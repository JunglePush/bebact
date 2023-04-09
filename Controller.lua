local Controller = {}

local UIElements = {}
local Instances = {}

local TweenService = game:GetService("TweenService")
local UpdateInstances = script.Parent.UpdateInstances

function Controller:UpdateInstances()
	UpdateInstances:Fire(Instances)
end

function Controller:RemoveConnections(UI, ...)
	local Inst = UIElements[UI][1]
	local Connections = UIElements[UI]["Connections"]
	
	for index, func in pairs(Connections) do
		local Connection = func[1]
		local Type = func[2]
		
		if ... == nil then
			if typeof(Connection) == "RBXScriptConnection" then
				Connection:Disconnect()
			end
		elseif type(...) == "string" then
			if Type == ... then
				if typeof(Connection) == "RBXScriptConnection" then
					Connection:Disconnect()
				end
				return UI
			end
		else	
			for index, trig in pairs(...) do
				if trig == Type then
					if typeof(Connection) == "RBXScriptConnection" then
						Connection:Disconnect()
					end
				end
			end
		end
	end
	
	
	return UI
end

function Controller:AddConnections(UI, ...)
	for index, button in pairs(...) do
		local func = button[1]
		local trig = button[2]

		if trig == "MouseButton1Click" or trig == "MouseEnter" or trig == "MouseLeave" and typeof(func) == "function" then
			local Con = UI[trig]:Connect(func)
			table.insert(UIElements[UI]["Connections"], {Con, trig})
		end
	end
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
	
	UIElements[Child] = {UI}
	UIElements[Child]["Connections"] = {}
	
	if ... ~= nil then
		Child = self:UpdateProperty(Child, ...)
	end
	
	Instances[Child.Name] = Child
	self:UpdateInstances()
	return Child
end

function Controller:AddUIInstance(Inst, Propertys, Childs, ...)
	local UI = Instance.new(Inst)
--	UI.Size = UDim2.new(.2,0,.2,0)
	UIElements[UI] = {UI}
	UIElements[UI]["Connections"] = {}
	
	if Childs ~= nil then
		for i,v in pairs(Childs) do
			local inst = v[1]
			local property = v[2]
			print(inst, property)
			
			local child = self:AddUIChild(UI, inst, property)
			Instances[tostring(child.Name)] = child
		end
	end
	
	if Propertys ~= nil then
		UI = self:UpdateProperty(UI, Propertys)
	end
	
	if ... ~= nil then
		UI = self:GiveConnections(UI, ...)
	end
	
	Instances[tostring(UI.Name)] = UI
	
	self:UpdateInstances()
	
	return Instances
end

function Controller:TweenUI(UI, Inst, ...)
	for index, property in pairs(...) do
		local Property = property[1]
		local easingDirection = property[2]
		local easingStyle = property[3]
		local Time = property[4]
		local override = property[5]
		local callback = property[6]
		local Property2 = property[7]
		
		if typeof(callback) ~= "function" then
			callback = nil
		end
		
		if Inst == "Size" then
			UI:TweenSize(Property, easingDirection, easingStyle, Time, override ,callback)
		elseif Inst == "Position" then
			UI:TweenPosition(Property, easingDirection, easingStyle, Time,override, callback)
		elseif Inst == "SizeAndPosition" then
			print(Property, Property2)
			UI:TweenSizeAndPosition(Property, Property2, easingDirection, easingStyle, Time,override, callback)
		end
	end
	
	return UI
end

function Controller:RemoveUIChild(UI, Inst)
	UI:FindFirstChild(Inst):Destroy()
	
	return UI
end

function Controller:RemoveUIDescendant(UI, Inst)
	UI:FindFirstChild(Inst, true):Destroy()
	
	return UI
end

function Controller:RemoveUIDescendants(UI)
	for i,v in pairs(UI:GetDescendants()) do
		v:Destroy()
	end

	return UI
end

return Controller
