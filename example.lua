local Handler = require(script.Handler)

local TextLabel = Handler:AddUIInstance("TextLabel", {
	{"Size", UDim2.new(1,0,1,0)};
	{"Text", "Welcome"};
	{"Parent", script.Parent.Frame};
})

local UIStroke = Handler:AddUIChild(TextLabel, "UIStroke", {
	{"Color", Color3.fromRGB(255,255,255)};
	{"ApplyStrokeMode", "Border"};
	{"Thickness", 3};
	{"Enabled", false};
})

local UICorner = Handler:UpdateProperty(Handler:AddUIChild(TextLabel, "UICorner"), {
	{"CornerRadius", UDim.new(50,50)};
})

Handler:AddConnections(TextLabel, {
	{
		function()
			Handler:UpdateProperty(UIStroke, {
				{"Enabled", true}
			})
		end, "MouseEnter"
	};
	{
		function()
			Handler:UpdateProperty(UIStroke, {
				{"Enabled", false}
			})
		end, "MouseLeave"
	};
})
