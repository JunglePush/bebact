local Controller = {}

local UIElements = {}

function Controller:RemoveConnections(UI)
	for index, func in pairs(UIElements[UI]) do
		if typeof(func) == "RBXScriptConnection" then
			func:Disconnect()
		end
	end
	return UI
end

function Controller:GiveConnections(UI, ...)
	for index, button in pairs(...) do
		local func = button[1]
		local trig = button[2]

		if trig == "MouseButton1Click" or trig == "MouseEnter" or trig == "MouseLeave" and typeof(func) == "function" then
			local Con = UI[trig]:Connect(func)
			table.insert(UIElements[UI], Con)
		end
	end
	return UI
end

function Controller:AddUIInstance(Inst, ...)
	local UI = Instance.new(Inst, script.Parent.Parent.Frame)
	UI.Size = UDim2.new(.2,0,.2,0)
	UIElements[UI] = {UI}
	
	UI = self:GiveConnections(UI, ...)
	
	return UI
end

function Controller:UpdateProperty(UI, ...)
	for index, propertys in pairs(...) do
		local Property = propertys[1]
		local Edit = propertys[2]

		UI[Property] = Edit
	end
	
	return UI
end

function Controller:AddUIChild(UI, Inst, ...)
	local Child = Instance.new(Inst, UI)
	
	Child = self:UpdateProperty(Child, ...)
	
	return Child
end



return Controller