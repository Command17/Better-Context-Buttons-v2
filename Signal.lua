local module = {}
module.__index = module

function module:Connect(handler)
	if not (type(handler) == "function") then
		error("expected function got %s"):format(handler)
	end
	return handler
end

return module
