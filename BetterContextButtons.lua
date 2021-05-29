local module = {}
local Theme = require(script.Theme)
local CurrentTheme = Theme:GetTheme("Default")
local Signal = require(script.Signal)
module.__index = module
-- PRIVATE FUNCTIONS --
function module:_UDim2(handler)
	if not (type(handler) == UDim2) then
		error("UDim2 expected got %s"):format(handler)
	end
	return handler
end

function module:_CreateGui()
	self.Gui = Instance.new("ScreenGui")
	self.Gui.Name = "BetterContextButtons"
	self.Gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") or game.Players.LocalPlayer:FindFirstChild("PlayerGui")
	self.Gui.ResetOnSpawn = false
end

module:_CreateGui()
-- PUBLIC FUNCTIONS --
function module.new()
	local self = setmetatable({}, module)
	
	local ImageButton = Instance.new("ImageButton", self.Gui)
	ImageButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
	ImageButton.ImageRectOffset = Vector2.new(1, 1)
	ImageButton.ImageRectSize = Vector2.new(144, 144)
	ImageButton.SliceScale = 1
	ImageButton.ScaleType = Enum.ScaleType.Stretch
	ImageButton.Size = UDim2.new(0,74,0,74)
	ImageButton.BackgroundTransparency = 1
	ImageButton.ImageColor3 = require(CurrentTheme).NormalColor
	ImageButton.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageButton.Visible = false
	
	ImageButton.Name = "Unnamed"
	
	self.Button = ImageButton
	
	return self
end

function module:BindAction(handler)
	local CurrentSignal = Signal:Connect(handler)
	self.Button.Visible = true
	self.Button.MouseButton1Down:Connect(function()
		self.Button.ImageColor3 = require(CurrentTheme).ClickedColor
		CurrentSignal()
	end)
	self.Button.MouseButton1Up:Connect(function()
		self.Button.ImageColor3 = require(CurrentTheme).NormalColor
	end)
	self.Button.TouchLongPress:Connect(function(pos, state)
		if state == Enum.UserInputState.Begin then
			self.Button.ImageColor3 = require(CurrentTheme).ClickedColor
			CurrentSignal()
		elseif Enum.UserInputState.End then
			self.Button.ImageColor3 = require(CurrentTheme).NormalColor
		end
	end)
end

function module:UnBindAction()
	self.Button.Visible = false
end

function module:SetName(Name)
	self.Button.Name = Name
end

function module:SetPosition(Pos)
	local PosCheck = module:_UDim2(Pos)
	self.Button.Position = PosCheck
end

function module:SetTheme(theme)
	CurrentTheme = Theme:GetTheme(Theme)
end

function module:SetSize(Size)
	local SizeCheck = module:_UDim2(Size)
	self.Button.Size = SizeCheck
end

function module:DestroyAction()
	game.Debris:AddItem(self.Button)
end

function module:SetLabel(Text)
	local Label = Instance.new("TextLabel", self.Button)
	Label.Text = Text
	Label.Font = Enum.Font.GothamBlack
	Label.Size = self.Button.Size
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.BackgroundTransparency = 1
end

function module:SetImage(url)
	local Image = Instance.new("ImageLabel", self.Button)
	Image.Size = self.Button.Size
	Image.BackgroundTransperency = 1
end

return module
