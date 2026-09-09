--[[
    S4ZX FOLLOW PLATFORM
    LocalScript

    LOCAL:
    StarterPlayer
      > StarterPlayerScripts
        > LocalScript

    FUNÇÃO:
    + sobe uma altura do personagem
    - desce uma altura do personagem

    A plataforma acompanha o jogador horizontalmente
    e carrega o personagem durante subida/descida.
]]

------------------------------------------------------------
-- SERVICES
------------------------------------------------------------

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

------------------------------------------------------------
-- PLAYER
------------------------------------------------------------

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

------------------------------------------------------------
-- CONFIG
------------------------------------------------------------

local CONFIG = {

	Logo = "rbxassetid://98880379063768",

	PlatformSize = Vector3.new(7, 0.8, 7),

	-- espaço extra por nível
	ExtraStepHeight = 0.4,

	-- velocidade da subida
	MoveSpeed = 10,

	-- transparência do bloco
	PlatformTransparency = 0.08,

	-- Interface
	Width = 340,
	Height = 190,
}

------------------------------------------------------------
-- COLORS
------------------------------------------------------------

local COLORS = {

	Background = Color3.fromRGB(11, 11, 17),

	Topbar = Color3.fromRGB(15, 15, 23),

	Card = Color3.fromRGB(20, 20, 30),

	CardHover = Color3.fromRGB(27, 27, 40),

	Accent = Color3.fromRGB(132, 85, 255),

	Accent2 = Color3.fromRGB(85, 57, 210),

	Text = Color3.fromRGB(245, 245, 255),

	SubText = Color3.fromRGB(145, 145, 165),

	Stroke = Color3.fromRGB(49, 49, 67),

	Danger = Color3.fromRGB(220, 70, 90),
}

------------------------------------------------------------
-- CHARACTER VARIABLES
------------------------------------------------------------

local Character = nil
local Humanoid = nil
local Root = nil

------------------------------------------------------------
-- PLATFORM VARIABLES
------------------------------------------------------------

local Platform = nil

local CurrentLevel = 0
local TargetLevel = 0

local BasePlatformY = 0
local CurrentPlatformY = 0
local TargetPlatformY = 0

local StepHeight = 6

local CharacterReady = false

------------------------------------------------------------
-- OLD GUI CLEANUP
------------------------------------------------------------

local oldGui = PlayerGui:FindFirstChild("S4ZXFollowPlatform")

if oldGui then
	oldGui:Destroy()
end

local oldPlatform = workspace:FindFirstChild(
	"S4ZX_Platform_" .. Player.UserId
)

if oldPlatform then
	oldPlatform:Destroy()
end

------------------------------------------------------------
-- CREATE INSTANCE HELPER
------------------------------------------------------------

local function Create(className, properties)

	local object = Instance.new(className)

	for property, value in pairs(properties) do

		if property ~= "Parent" then
			object[property] = value
		end

	end

	if properties.Parent then
		object.Parent = properties.Parent
	end

	return object
end

------------------------------------------------------------
-- CORNER HELPER
------------------------------------------------------------

local function AddCorner(object, radius)

	local corner = Instance.new("UICorner")

	corner.CornerRadius = UDim.new(
		0,
		radius
	)

	corner.Parent = object

	return corner
end

------------------------------------------------------------
-- STROKE HELPER
------------------------------------------------------------

local function AddStroke(
	object,
	color,
	thickness,
	transparency
)

	local stroke = Instance.new("UIStroke")

	stroke.Color = color or COLORS.Stroke
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0

	stroke.Parent = object

	return stroke
end

------------------------------------------------------------
-- CHARACTER HEIGHT
------------------------------------------------------------

local function GetCharacterHeight()

	if not Character then
		return 6
	end

	local success, _, size = pcall(function()

		local cf, boundingSize =
			Character:GetBoundingBox()

		return cf, boundingSize

	end)

	if success and size then

		return math.max(
			size.Y,
			5
		)

	end

	return 6
end

------------------------------------------------------------
-- FOOT POSITION
------------------------------------------------------------

local function GetFeetY()

	if not Root or not Humanoid then
		return 0
	end

	return Root.Position.Y
		- Humanoid.HipHeight
		- (Root.Size.Y / 2)

end

------------------------------------------------------------
-- CREATE PLATFORM
------------------------------------------------------------

local function CreatePlatform()

	if Platform then

		Platform:Destroy()
		Platform = nil

	end

	Platform = Instance.new("Part")

	Platform.Name =
		"S4ZX_Platform_" .. Player.UserId

	Platform.Size = CONFIG.PlatformSize

	Platform.Anchored = true

	Platform.CanCollide = true

	Platform.CanTouch = true

	Platform.CanQuery = true

	Platform.CastShadow = true

	Platform.Material =
		Enum.Material.SmoothPlastic

	Platform.Color =
		Color3.fromRGB(
			33,
			25,
			55
		)

	Platform.Transparency =
		CONFIG.PlatformTransparency

	Platform.TopSurface =
		Enum.SurfaceType.Smooth

	Platform.BottomSurface =
		Enum.SurfaceType.Smooth

	Platform.Parent = workspace

	--------------------------------------------------------
	-- PLATFORM TOP GUI
	--------------------------------------------------------

	local surface =
		Instance.new("SurfaceGui")

	surface.Name = "LogoSurface"

	surface.Face = Enum.NormalId.Top

	surface.AlwaysOnTop = false

	surface.LightInfluence = 0

	surface.SizingMode =
		Enum.SurfaceGuiSizingMode.PixelsPerStud

	surface.PixelsPerStud = 40

	surface.Parent = Platform

	--------------------------------------------------------

	local background =
		Instance.new("Frame")

	background.Size =
		UDim2.fromScale(1, 1)

	background.BackgroundColor3 =
		Color3.fromRGB(
			22,
			17,
			38
		)

	background.BorderSizePixel = 0

	background.Parent = surface

	--------------------------------------------------------

	local gradient =
		Instance.new("UIGradient")

	gradient.Rotation = 45

	gradient.Color =
		ColorSequence.new({

			ColorSequenceKeypoint.new(
				0,
				Color3.fromRGB(
					56,
					35,
					100
				)
			),

			ColorSequenceKeypoint.new(
				1,
				Color3.fromRGB(
					20,
					15,
					35
				)
			)

		})

	gradient.Parent = background

	--------------------------------------------------------

	local platformLogo =
		Instance.new("ImageLabel")

	platformLogo.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	platformLogo.Position =
		UDim2.fromScale(
			0.5,
			0.5
		)

	platformLogo.Size =
		UDim2.fromScale(
			0.55,
			0.55
		)

	platformLogo.BackgroundTransparency = 1

	platformLogo.Image =
		CONFIG.Logo

	platformLogo.ScaleType =
		Enum.ScaleType.Fit

	platformLogo.ImageTransparency = 0.05

	platformLogo.Parent = background

	--------------------------------------------------------
	-- PLATFORM SIDE LIGHT
	--------------------------------------------------------

	local light =
		Instance.new("PointLight")

	light.Color =
		COLORS.Accent

	light.Range = 9

	light.Brightness = 0.7

	light.Shadows = false

	light.Parent = Platform

end

------------------------------------------------------------
-- RESET PLATFORM
------------------------------------------------------------

local function ResetPlatform()

	if not Root or not Humanoid then
		return
	end

	CharacterReady = false

	CurrentLevel = 0
	TargetLevel = 0

	StepHeight =
		GetCharacterHeight()
		+ CONFIG.ExtraStepHeight

	local feetY =
		GetFeetY()

	BasePlatformY =
		feetY
		- (CONFIG.PlatformSize.Y / 2)
		- 0.05

	CurrentPlatformY =
		BasePlatformY

	TargetPlatformY =
		BasePlatformY

	CreatePlatform()

	Platform.CFrame =
		CFrame.new(
			Root.Position.X,
			CurrentPlatformY,
			Root.Position.Z
		)

	CharacterReady = true

end

------------------------------------------------------------
-- SETUP CHARACTER
------------------------------------------------------------

local function SetupCharacter(character)

	CharacterReady = false

	Character = character

	Humanoid =
		character:WaitForChild(
			"Humanoid"
		)

	Root =
		character:WaitForChild(
			"HumanoidRootPart"
		)

	task.wait(0.3)

	ResetPlatform()

end

------------------------------------------------------------
-- INITIAL CHARACTER
------------------------------------------------------------

if Player.Character then

	task.spawn(
		SetupCharacter,
		Player.Character
	)

end

Player.CharacterAdded:Connect(
	function(character)

		task.wait(0.15)

		SetupCharacter(character)

	end
)

------------------------------------------------------------
-- GUI
------------------------------------------------------------

local ScreenGui =
	Create(
		"ScreenGui",
		{

			Name = "S4ZXFollowPlatform",

			ResetOnSpawn = false,

			IgnoreGuiInset = true,

			ZIndexBehavior =
				Enum.ZIndexBehavior.Sibling,

			Parent = PlayerGui
		}
	)

------------------------------------------------------------
-- SHADOW
------------------------------------------------------------

local Shadow =
	Create(
		"ImageLabel",
		{

			Name = "Shadow",

			AnchorPoint =
				Vector2.new(
					0.5,
					0.5
				),

			Position =
				UDim2.new(
					0.5,
					0,
					0.55,
					0
				),

			Size =
				UDim2.fromOffset(
					CONFIG.Width + 40,
					CONFIG.Height + 40
				),

			BackgroundTransparency = 1,

			Image =
				"rbxassetid://6015897843",

			ImageColor3 =
				Color3.fromRGB(
					0,
					0,
					0
				),

			ImageTransparency = 0.35,

			ScaleType =
				Enum.ScaleType.Slice,

			SliceCenter =
				Rect.new(
					49,
					49,
					450,
					450
				),

			ZIndex = 0,

			Parent = ScreenGui
		}
	)

------------------------------------------------------------
-- MAIN
------------------------------------------------------------

local Main =
	Create(
		"Frame",
		{

			Name = "Main",

			AnchorPoint =
				Vector2.new(
					0.5,
					0.5
				),

			Position =
				UDim2.new(
					0.5,
					0,
					0.55,
					0
				),

			Size =
				UDim2.fromOffset(
					CONFIG.Width,
					CONFIG.Height
				),

			BackgroundColor3 =
				COLORS.Background,

			BorderSizePixel = 0,

			ClipsDescendants = true,

			ZIndex = 2,

			Parent = ScreenGui
		}
	)

AddCorner(Main, 16)

AddStroke(
	Main,
	COLORS.Stroke,
	1,
	0
)

------------------------------------------------------------
-- MAIN GRADIENT
------------------------------------------------------------

local mainGradient =
	Instance.new("UIGradient")

mainGradient.Rotation = 90

mainGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,
			Color3.fromRGB(
				18,
				17,
				28
			)
		),

		ColorSequenceKeypoint.new(
			1,
			Color3.fromRGB(
				9,
				9,
				14
			)
		)

	})

mainGradient.Parent = Main

------------------------------------------------------------
-- SCALE
------------------------------------------------------------

local MainScale =
	Instance.new("UIScale")

MainScale.Scale = 1

MainScale.Parent = Main

------------------------------------------------------------
-- TOPBAR
------------------------------------------------------------

local Topbar =
	Create(
		"Frame",
		{

			Name = "Topbar",

			Size =
				UDim2.new(
					1,
					0,
					0,
					58
				),

			BackgroundColor3 =
				COLORS.Topbar,

			BackgroundTransparency = 0.1,

			BorderSizePixel = 0,

			ZIndex = 3,

			Parent = Main
		}
	)

------------------------------------------------------------
-- LOGO HOLDER
------------------------------------------------------------

local LogoHolder =
	Create(
		"Frame",
		{

			Position =
				UDim2.fromOffset(
					12,
					10
				),

			Size =
				UDim2.fromOffset(
					38,
					38
				),

			BackgroundColor3 =
				Color3.fromRGB(
					30,
					24,
					50
				),

			BorderSizePixel = 0,

			ZIndex = 5,

			Parent = Topbar
		}
	)

AddCorner(
	LogoHolder,
	11
)

AddStroke(
	LogoHolder,
	COLORS.Accent,
	1,
	0.45
)

------------------------------------------------------------
-- LOGO
------------------------------------------------------------

local Logo =
	Create(
		"ImageLabel",
		{

			AnchorPoint =
				Vector2.new(
					0.5,
					0.5
				),

			Position =
				UDim2.fromScale(
					0.5,
					0.5
				),

			Size =
				UDim2.fromOffset(
					29,
					29
				),

			BackgroundTransparency = 1,

			Image = CONFIG.Logo,

			ScaleType =
				Enum.ScaleType.Fit,

			ZIndex = 6,

			Parent = LogoHolder
		}
	)

------------------------------------------------------------
-- TITLE
------------------------------------------------------------

local Title =
	Create(
		"TextLabel",
		{

			Position =
				UDim2.fromOffset(
					61,
					10
				),

			Size =
				UDim2.new(
					1,
					-120,
					0,
					20
				),

			BackgroundTransparency = 1,

			Text =
				"PLATFORM",

			TextColor3 =
				COLORS.Text,

			TextSize = 16,

			TextXAlignment =
				Enum.TextXAlignment.Left,

			Font =
				Enum.Font.GothamBold,

			ZIndex = 5,

			Parent = Topbar
		}
	)

------------------------------------------------------------
-- SUBTITLE
------------------------------------------------------------

local Subtitle =
	Create(
		"TextLabel",
		{

			Position =
				UDim2.fromOffset(
					61,
					30
				),

			Size =
				UDim2.new(
					1,
					-120,
					0,
					16
				),

			BackgroundTransparency = 1,

			Text =
				"FOLLOW ELEVATOR",

			TextColor3 =
				COLORS.SubText,

			TextSize = 10,

			TextXAlignment =
				Enum.TextXAlignment.Left,

			Font =
				Enum.Font.GothamMedium,

			ZIndex = 5,

			Parent = Topbar
		}
	)

------------------------------------------------------------
-- MINIMIZE
------------------------------------------------------------

local Minimize =
	Create(
		"TextButton",
		{

			AnchorPoint =
				Vector2.new(
					1,
					0.5
				),

			Position =
				UDim2.new(
					1,
					-12,
					0.5,
					0
				),

			Size =
				UDim2.fromOffset(
					34,
					34
				),

			BackgroundColor3 =
				Color3.fromRGB(
					27,
					27,
					39
				),

			BorderSizePixel = 0,

			Text = "—",

			TextColor3 =
				COLORS.Text,

			TextSize = 18,

			Font =
				Enum.Font.GothamBold,

			AutoButtonColor = false,

			ZIndex = 6,

			Parent = Topbar
		}
	)

AddCorner(
	Minimize,
	10
)

AddStroke(
	Minimize,
	COLORS.Stroke,
	1,
	0.2
)

------------------------------------------------------------
-- CONTENT
------------------------------------------------------------

local Content =
	Create(
		"Frame",
		{

			Position =
				UDim2.fromOffset(
					12,
					70
				),

			Size =
				UDim2.new(
					1,
					-24,
					1,
					-82
				),

			BackgroundTransparency = 1,

			ZIndex = 3,

			Parent = Main
		}
	)

------------------------------------------------------------
-- CARD
------------------------------------------------------------

local Card =
	Create(
		"Frame",
		{

			Size =
				UDim2.fromScale(
					1,
					1
				),

			BackgroundColor3 =
				COLORS.Card,

			BorderSizePixel = 0,

			ZIndex = 3,

			Parent = Content
		}
	)

AddCorner(
	Card,
	14
)

AddStroke(
	Card,
	COLORS.Stroke,
	1,
	0.15
)

------------------------------------------------------------
-- CARD TITLE
------------------------------------------------------------

local CardTitle =
	Create(
		"TextLabel",
		{

			Position =
				UDim2.fromOffset(
					15,
					12
				),

			Size =
				UDim2.fromOffset(
					130,
					18
				),

			BackgroundTransparency = 1,

			Text =
				"ALTURA",

			TextColor3 =
				COLORS.Text,

			TextSize = 13,

			TextXAlignment =
				Enum.TextXAlignment.Left,

			Font =
				Enum.Font.GothamBold,

			ZIndex = 4,

			Parent = Card
		}
	)

------------------------------------------------------------
-- LEVEL LABEL
------------------------------------------------------------

local LevelLabel =
	Create(
		"TextLabel",
		{

			Position =
				UDim2.fromOffset(
					15,
					32
				),

			Size =
				UDim2.fromOffset(
					130,
					18
				),

			BackgroundTransparency = 1,

			Text =
				"Nível 0",

			TextColor3 =
				COLORS.SubText,

			TextSize = 11,

			TextXAlignment =
				Enum.TextXAlignment.Left,

			Font =
				Enum.Font.GothamMedium,

			ZIndex = 4,

			Parent = Card
		}
	)

------------------------------------------------------------
-- BUTTON HOLDER
------------------------------------------------------------

local ButtonHolder =
	Create(
		"Frame",
		{

			AnchorPoint =
				Vector2.new(
					1,
					0.5
				),

			Position =
				UDim2.new(
					1,
					-14,
					0.5,
					0
				),

			Size =
				UDim2.fromOffset(
					146,
					58
				),

			BackgroundTransparency = 1,

			ZIndex = 4,

			Parent = Card
		}
	)

------------------------------------------------------------
-- MINUS
------------------------------------------------------------

local Minus =
	Create(
		"TextButton",
		{

			Position =
				UDim2.fromOffset(
					0,
					0
				),

			Size =
				UDim2.fromOffset(
					66,
					58
				),

			BackgroundColor3 =
				Color3.fromRGB(
					31,
					31,
					44
				),

			BorderSizePixel = 0,

			Text = "−",

			TextColor3 =
				COLORS.Text,

			TextSize = 29,

			Font =
				Enum.Font.GothamBold,

			AutoButtonColor = false,

			ZIndex = 5,

			Parent = ButtonHolder
		}
	)

AddCorner(
	Minus,
	13
)

AddStroke(
	Minus,
	COLORS.Stroke,
	1,
	0
)

------------------------------------------------------------
-- PLUS
------------------------------------------------------------

local Plus =
	Create(
		"TextButton",
		{

			Position =
				UDim2.fromOffset(
					80,
					0
				),

			Size =
				UDim2.fromOffset(
					66,
					58
				),

			BackgroundColor3 =
				COLORS.Accent,

			BorderSizePixel = 0,

			Text = "+",

			TextColor3 =
				Color3.fromRGB(
					255,
					255,
					255
				),

			TextSize = 28,

			Font =
				Enum.Font.GothamBold,

			AutoButtonColor = false,

			ZIndex = 5,

			Parent = ButtonHolder
		}
	)

AddCorner(
	Plus,
	13
)

local plusStroke =
	AddStroke(
		Plus,
		Color3.fromRGB(
			168,
			130,
			255
		),
		1,
		0.15
	)

------------------------------------------------------------
-- PLUS GRADIENT
------------------------------------------------------------

local plusGradient =
	Instance.new("UIGradient")

plusGradient.Rotation = 45

plusGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,
			Color3.fromRGB(
				155,
				105,
				255
			)
		),

		ColorSequenceKeypoint.new(
			1,
			Color3.fromRGB(
				105,
				66,
				230
			)
		)

	})

plusGradient.Parent = Plus

------------------------------------------------------------
-- MINIMIZED BUTTON
------------------------------------------------------------

local Mini =
	Create(
		"ImageButton",
		{

			Name = "MiniButton",

			AnchorPoint =
				Vector2.new(
					0.5,
					0.5
				),

			Position =
				Main.Position,

			Size =
				UDim2.fromOffset(
					58,
					58
				),

			BackgroundColor3 =
				Color3.fromRGB(
					17,
					17,
					25
				),

			BorderSizePixel = 0,

			Image = CONFIG.Logo,

			ScaleType =
				Enum.ScaleType.Fit,

			AutoButtonColor = false,

			Visible = false,

			ZIndex = 20,

			Parent = ScreenGui
		}
	)

AddCorner(
	Mini,
	18
)

AddStroke(
	Mini,
	COLORS.Accent,
	2,
	0.15
)

local MiniScale =
	Instance.new("UIScale")

MiniScale.Scale = 1

MiniScale.Parent = Mini

------------------------------------------------------------
-- BUTTON ANIMATION
------------------------------------------------------------

local function PressAnimation(button)

	local scale =
		button:FindFirstChild(
			"PressScale"
		)

	if not scale then

		scale =
			Instance.new(
				"UIScale"
			)

		scale.Name =
			"PressScale"

		scale.Scale = 1

		scale.Parent = button

	end

	TweenService:Create(
		scale,
		TweenInfo.new(
			0.07,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		),
		{
			Scale = 0.91
		}
	):Play()

	task.delay(
		0.07,
		function()

			if scale.Parent then

				TweenService:Create(
					scale,
					TweenInfo.new(
						0.13,
						Enum.EasingStyle.Back,
						Enum.EasingDirection.Out
					),
					{
						Scale = 1
					}
				):Play()

			end

		end
	)

end

------------------------------------------------------------
-- UPDATE LABEL
------------------------------------------------------------

local function UpdateLevelLabel()

	LevelLabel.Text =
		"Nível "
		.. tostring(
			TargetLevel
		)

end

------------------------------------------------------------
-- PLUS CLICK
------------------------------------------------------------

Plus.MouseButton1Click:Connect(
	function()

		PressAnimation(Plus)

		if not CharacterReady then
			return
		end

		TargetLevel += 1

		TargetPlatformY =
			BasePlatformY
			+ (
				TargetLevel
				* StepHeight
			)

		UpdateLevelLabel()

	end
)

------------------------------------------------------------
-- MINUS CLICK
------------------------------------------------------------

Minus.MouseButton1Click:Connect(
	function()

		PressAnimation(Minus)

		if not CharacterReady then
			return
		end

		TargetLevel -= 1

		TargetPlatformY =
			BasePlatformY
			+ (
				TargetLevel
				* StepHeight
			)

		UpdateLevelLabel()

	end
)

------------------------------------------------------------
-- MINIMIZE
------------------------------------------------------------

local minimized = false

local function MinimizeUI()

	if minimized then
		return
	end

	minimized = true

	Mini.Position =
		Main.Position

	TweenService:Create(
		MainScale,
		TweenInfo.new(
			0.16,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.In
		),
		{
			Scale = 0.8
		}
	):Play()

	TweenService:Create(
		Main,
		TweenInfo.new(
			0.16,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		),
		{
			BackgroundTransparency = 0.3
		}
	):Play()

	task.delay(
		0.15,
		function()

			Main.Visible = false
			Shadow.Visible = false

			MiniScale.Scale = 0.7

			Mini.Visible = true

			TweenService:Create(
				MiniScale,
				TweenInfo.new(
					0.2,
					Enum.EasingStyle.Back,
					Enum.EasingDirection.Out
				),
				{
					Scale = 1
				}
			):Play()

		end
	)

end

------------------------------------------------------------
-- RESTORE
------------------------------------------------------------

local function RestoreUI()

	if not minimized then
		return
	end

	minimized = false

	TweenService:Create(
		MiniScale,
		TweenInfo.new(
			0.12,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		),
		{
			Scale = 0.7
		}
	):Play()

	task.delay(
		0.1,
		function()

			Mini.Visible = false

			Main.Visible = true
			Shadow.Visible = true

			Main.BackgroundTransparency = 0

			MainScale.Scale = 0.8

			TweenService:Create(
				MainScale,
				TweenInfo.new(
					0.22,
					Enum.EasingStyle.Back,
					Enum.EasingDirection.Out
				),
				{
					Scale = 1
				}
			):Play()

		end
	)

end

Minimize.MouseButton1Click:Connect(
	function()

		PressAnimation(Minimize)

		MinimizeUI()

	end
)

Mini.MouseButton1Click:Connect(
	function()

		PressAnimation(Mini)

		RestoreUI()

	end
)

------------------------------------------------------------
-- DRAG SYSTEM
------------------------------------------------------------

local dragging = false

local dragInput = nil
local dragStart = nil
local startPosition = nil

Topbar.InputBegan:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
		then

			dragging = true

			dragStart =
				input.Position

			startPosition =
				Main.Position

			input.Changed:Connect(
				function()

					if input.UserInputState ==
						Enum.UserInputState.End
					then

						dragging = false

					end

				end
			)

		end

	end
)

Topbar.InputChanged:Connect(
	function(input)

		if input.UserInputType ==
				Enum.UserInputType.MouseMovement
			or
			input.UserInputType ==
				Enum.UserInputType.Touch
		then

			dragInput = input

		end

	end
)

UserInputService.InputChanged:Connect(
	function(input)

		if input ==
				dragInput
			and
			dragging
		then

			local delta =
				input.Position
				- dragStart

			local newPosition =
				UDim2.new(

					startPosition.X.Scale,

					startPosition.X.Offset
						+ delta.X,

					startPosition.Y.Scale,

					startPosition.Y.Offset
						+ delta.Y

				)

			Main.Position =
				newPosition

			Shadow.Position =
				newPosition

		end

	end
)

------------------------------------------------------------
-- MINI DRAG
------------------------------------------------------------

local miniDragging = false
local miniDragStart = nil
local miniStartPosition = nil

Mini.InputBegan:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
		then

			miniDragging = true

			miniDragStart =
				input.Position

			miniStartPosition =
				Mini.Position

			input.Changed:Connect(
				function()

					if input.UserInputState ==
						Enum.UserInputState.End
					then

						miniDragging = false

					end

				end
			)

		end

	end
)

UserInputService.InputChanged:Connect(
	function(input)

		if not miniDragging then
			return
		end

		if input.UserInputType ~=
			Enum.UserInputType.MouseMovement
		then
			return
		end

		local delta =
			input.Position
			- miniDragStart

		Mini.Position =
			UDim2.new(

				miniStartPosition.X.Scale,

				miniStartPosition.X.Offset
					+ delta.X,

				miniStartPosition.Y.Scale,

				miniStartPosition.Y.Offset
					+ delta.Y

			)

	end
)

------------------------------------------------------------
-- BUTTON HOVER
------------------------------------------------------------

local function SetupHover(
	button,
	normalColor,
	hoverColor
)

	button.MouseEnter:Connect(
		function()

			TweenService:Create(
				button,
				TweenInfo.new(
					0.12
				),
				{
					BackgroundColor3 =
						hoverColor
				}
			):Play()

		end
	)

	button.MouseLeave:Connect(
		function()

			TweenService:Create(
				button,
				TweenInfo.new(
					0.12
				),
				{
					BackgroundColor3 =
						normalColor
				}
			):Play()

		end
	)

end

SetupHover(
	Minus,
	Color3.fromRGB(
		31,
		31,
		44
	),
	Color3.fromRGB(
		42,
		42,
		60
	)
)

SetupHover(
	Minimize,
	Color3.fromRGB(
		27,
		27,
		39
	),
	Color3.fromRGB(
		40,
		40,
		55
	)
)

------------------------------------------------------------
-- MAIN PLATFORM LOOP
------------------------------------------------------------

RunService.RenderStepped:Connect(
	function(deltaTime)

		if not CharacterReady then
			return
		end

		if not Character then
			return
		end

		if not Character.Parent then
			return
		end

		if not Humanoid then
			return
		end

		if Humanoid.Health <= 0 then
			return
		end

		if not Root then
			return
		end

		if not Root.Parent then
			return
		end

		if not Platform then
			return
		end

		if not Platform.Parent then
			return
		end

		----------------------------------------------------
		-- SMOOTH VERTICAL MOVEMENT
		----------------------------------------------------

		local difference =
			TargetPlatformY
			- CurrentPlatformY

		local verticalDelta = 0

		if math.abs(difference) > 0.001 then

			local alpha =
				1
				- math.exp(
					-CONFIG.MoveSpeed
					* deltaTime
				)

			local newY =
				CurrentPlatformY
				+ difference
				* alpha

			verticalDelta =
				newY
				- CurrentPlatformY

			CurrentPlatformY =
				newY

		else

			CurrentPlatformY =
				TargetPlatformY

		end

		----------------------------------------------------
		-- MOVE PLAYER WITH PLATFORM
		----------------------------------------------------

		if math.abs(verticalDelta) > 0.0001 then

			Root.CFrame =
				Root.CFrame
				+ Vector3.new(
					0,
					verticalDelta,
					0
				)

		end

		----------------------------------------------------
		-- FOLLOW PLAYER X / Z
		----------------------------------------------------

		Platform.CFrame =
			CFrame.new(

				Root.Position.X,

				CurrentPlatformY,

				Root.Position.Z

			)

	end
)

------------------------------------------------------------
-- FINISH
------------------------------------------------------------

UpdateLevelLabel()
