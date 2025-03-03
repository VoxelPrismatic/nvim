local function fmt_sql()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	local sql = table.concat(lines, "\n")

	-- Clean up the SQL by removing extra whitespace and newlines
	sql = sql:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")

	local columns = {}
	-- Check if it's an INSERT statement
	if not sql:match("%s*[iI][nN][sS][eE][rR][tT]%s+[iI][nN][tT][oO]") then
		return nil, "Not a valid INSERT statement"
	end

	-- Extract table name
	local table_name = sql:match("%s*[iI][nN][sS][eE][rR][tT]%s+[iI][nN][tT][oO]%s*([^%s%()]+)")
	if not table_name then
		return nil, "Could not parse table name"
	end

	-- Extract column names between parentheses after table name
	local columns_part = sql:match("%(%s*([^%)]+)%s*%)%s*[vV][aA][lL][uU][eE][sS]")
	if not columns_part then
		return nil, "Could not parse column names"
	end

	-- Split column names and trim whitespace
	local column_names = {}
	for column in columns_part:gmatch("[^,]+") do
		local v = column:gsub("%s+", "")
		column_names[#column_names + 1] = v
		columns[v] = { values = {}, length = math.ceil((#v + (#column_names == 1 and 2 or 1) + 4) / 4) * 4 }
	end

	-- Extract values part (everything after VALUES)
	local values_part = sql:match("[vV][aA][lL][uU][eE][sS]%s*(.*)$")
	if not values_part then
		return nil, "Could not parse values"
	end

	local values = {}
	local in_quotes = false
	local in_tuple = false
	local current_value = ""

	-- Split values while respecting quoted strings
	for char in values_part:gmatch(".") do
		if char == "(" and not in_quotes and not in_tuple then
			in_tuple = true
		elseif char == ")" and not in_quotes and in_tuple then
			in_tuple = false
			values[#values + 1] = current_value:gsub("^%s+", ""):gsub("%s+$", "")
			for i, value in ipairs(values) do
				local col_name = column_names[i]
				local column = columns[col_name]
				column.values[#column.values + 1] = value
				column.length = math.ceil(math.max(column.length, #value + (i == 1 and 2 or 1) + 4) / 4) * 4
			end
			values = {}
			current_value = ""
		elseif char == "'" and not in_quotes and in_tuple then
			in_quotes = true
			current_value = current_value .. char
		elseif char == "'" and in_quotes and in_tuple then
			in_quotes = false
			current_value = current_value .. char
		elseif char == "," and not in_quotes and in_tuple then
			values[#values + 1] = current_value:gsub("^%s+", ""):gsub("%s+$", "")
			current_value = ""
		elseif in_tuple then
			current_value = current_value .. char
		end
	end

	local out_lines = {}
	for c, name in ipairs(column_names) do
		local column = columns[name]
		local entries = column.values
		local length = column.length

		table.insert(entries, 1, name)
		for i, value in ipairs(entries) do
			if out_lines[i] == nil then
				out_lines[i] = "\t"
				value = "(" .. value
			end
			out_lines[i] = out_lines[i] .. value
			if c < #column_names then
				out_lines[i] = out_lines[i]
					.. ","
					.. string.rep("\t", math.ceil((length - vim.fn.strwidth(value) - 1) / 4))
			else
				out_lines[i] = out_lines[i] .. ")"
				if i == 1 then
					out_lines[1] = out_lines[1] .. " VALUES"
				elseif i == #entries then
					out_lines[i] = out_lines[i] .. ";"
				else
					out_lines[i] = out_lines[i] .. ","
				end
			end
		end
	end

	table.insert(out_lines, 1, "INSERT INTO " .. table_name)
	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, out_lines)
end

vim.api.nvim_create_user_command("SqlFormat", fmt_sql, { range = true })
return {}
