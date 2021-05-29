local module = {}

function module:GetTheme(Name)
	return script:FindFirstChild(Name)
end

return module
