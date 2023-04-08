local Handler = require(script.Handler)


local Button = Handler:AddUIInstance("TextButton", {
	{
		function()
			print("working")
		end, "MouseButton1Click";
	};
	{
		function()
			print("Hey")
		end, "MouseEnter";
	};
	{
		function()
			print("Bye")
		end, "MouseLeave";
	};

})

task.wait(3)

Handler:RemoveConnections(Button)

Handler:GiveConnections(Button, {
	{
		function()
			print("NEWWWW")
		end, "MouseButton1Click";
	};
	{
		function()
			print("NEWWteastWW")
		end, "MouseButton1Click";
	};
})
task.wait(2)

local TextLabel = Handler:AddUIChild(Button, "TextLabel", {
	{"Size", UDim2.new(1,0,1,0)};
	{"Text", "Stupid..."};
})

local UICorner = Handler:AddUIChild(TextLabel, "UICorner", {
	{"CornerRadius", UDim.new(0,10)};
})

task.wait(1)

for _ = 1,10 do
	task.wait(.1)
	Handler:UpdateProperty(TextLabel, {
		{"Text", "Stupid..."..tostring(_)};
	})
	Handler:UpdateProperty(UICorner, {
		{"CornerRadius", UDim.new(0,_)}
	})
end
