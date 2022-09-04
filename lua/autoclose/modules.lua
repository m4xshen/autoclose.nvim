local M = {}

M.delete = function (text)
    return text == "{" or 
	text == "[" or
	text == "(" or
	text == "<" or
	text == "\"" or
	text == "'" or
	text == "`"
end

M.escape = function (text)
    return text == "}" or 
	text == "]" or
	text == ")" or
	text == ">" or
	text == "\"" or
	text == "'"
end

M.pair = function (text)
    if text == "{" then return "}"
    elseif text == "[" then return "]"
    elseif text == "(" then return ")"
    elseif text == "<" then return ">"
    elseif text == "\"" then return "\""
    elseif text == "'" then return "'"
    elseif text == "`" then return "`"
    else return nil
    end
end

return M
