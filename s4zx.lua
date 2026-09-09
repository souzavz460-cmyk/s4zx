--[[
    SOUZA UTILS
    LocalScript
    StarterPlayer > StarterPlayerScripts

    RECURSOS:
    1. Elevador / plataforma
    2. DESCNY - procura Tool de invisibilidade no inventário
    3. AntiLag

    FEITO PARA USO NO SEU PRÓPRIO JOGO NO ROBLOX STUDIO.
]]

------------------------------------------------------------
-- SERVICES
------------------------------------------------------------

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

------------------------------------------------------------
-- PLAYER
------------------------------------------------------------

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

------------------------------------------------------------
-- CONFIG
------------------------------------------------------------

local CONFIG = {

	-- SUA LOGO
	Logo = "rbxassetid://98880379063768",

	-- fallback caso o asset direto não carregue
	LogoFallback =
		"rbxthumb://type=Asset&id=98880379063768&w=420&h=420",

	--------------------------------------------------------
	-- ELEVADOR
	--------------------------------------------------------

	PlatformSize = Vector3.new(6.5, 0.7, 6.5),

	-- percentual da altura do personagem por nível
	-- deixei menor para o nível 2 não ficar absurdo
	StepRatio = 0.43,

	MinStep = 2.15,
	MaxStep = 3.0,

	MaxLevel = 20,

	-- suavidade da subida/descida
	PlatformSpeed = 7.5,

	--------------------------------------------------------
	-- UI
	--------------------------------------------------------

	Width = 410,
	Height = 320,
}

------------------------------------------------------------
-- COLORS
------------------------------------------------------------

local COLORS = {

	BG = Color3.fromRGB(9, 10, 15),

	BG2 = Color3.fromRGB(13, 14, 21),

	Top = Color3.fromRGB(16, 17, 25),

	Card = Color3.fromRGB(19, 20, 29),

	Card2 = Color3.fromRGB(24, 25, 36),

	Stroke = Color3.fromRGB(48, 50, 68),

	Text = Color3.fromRGB(245, 246, 255),

	SubText = Color3.fromRGB(139, 143, 163),

	Purple = Color3.fromRGB(126, 83, 255),

	PurpleHover = Color3.fromRGB(145, 108, 255),

	Green = Color3.fromRGB(79, 211, 144),

	Red = Color3.fromRGB(230, 82, 103),
}

------------------------------------------------------------
-- CHARACTER
------------------------------------------------------------

local Character
local Humanoid
local Root

------------------------------------------------------------
-- PLATFORM
------------------------------------------------------------

local Platform = nil

local Level = 0

local StepHeight = 2.5

local BaseY = 0
local CurrentY = 0
local TargetY = 0

------------------------------------------------------------
-- ANTI LAG
------------------------------------------------------------

local AntiLagEnabled = false
local AntiLagBusy = false

local AntiLagCache = {}

------------------------------------------------------------
-- GUI CLEANUP
------------------------------------------------------------

local oldGUI =
	PlayerGui:FindFirstChild("SouzaUtilities")

if oldGUI then
	oldGUI:Destroy()
end

local oldPlatform =
	workspace:FindFirstChild(
		"SouzaPlatform_" .. Player.UserId
	)

if oldPlatform then
	oldPlatform:Destroy()
end

------------------------------------------------------------
-- HELPERS
------------------------------------------------------------

local function corner(object, radius)

	local c = Instance.new("UICorner")

	c.CornerRadius =
		UDim.new(0, radius)

	c.Parent = object

	return c
end

local function stroke(
	object,
	color,
	thickness,
	transparency
)

	local s = Instance.new("UIStroke")

	s.Color =
		color or COLORS.Stroke

	s.Thickness =
		thickness or 1

	s.Transparency =
		transparency or 0

	s.Parent = object

	return s
end

------------------------------------------------------------
-- LOGO LOADER
------------------------------------------------------------

local function ApplyLogo(imageObject)

	imageObject.Image =
		CONFIG.Logo

	task.delay(
		2,
		function()

			if not imageObject then
				return
			end

			if not imageObject.Parent then
				return
			end

			local success, loaded =
				pcall(function()

					return imageObject.IsLoaded

				end)

			if success and not loaded then

				imageObject.Image =
					CONFIG.LogoFallback

			end

		end
	)

end

------------------------------------------------------------
-- CHARACTER HEIGHT
------------------------------------------------------------

local function GetCharacterHeight()

	if not Character then
		return 5.5
	end

	local success, result =
		pcall(function()

			local _, size =
				Character:GetBoundingBox()

			return size.Y

		end)

	if success then
		return result
	end

	return 5.5
end

------------------------------------------------------------
-- STEP HEIGHT
------------------------------------------------------------

local function UpdateStepHeight()

	local height =
		GetCharacterHeight()

	StepHeight =
		math.clamp(
			height * CONFIG.StepRatio,
			CONFIG.MinStep,
			CONFIG.MaxStep
		)

end

------------------------------------------------------------
-- FEET Y
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
-- DESTROY PLATFORM
------------------------------------------------------------

local function DestroyPlatform()

	if Platform then

		Platform:Destroy()

		Platform = nil

	end

	Level = 0

end

------------------------------------------------------------
-- CREATE PLATFORM
------------------------------------------------------------

local function CreatePlatform()

	if Platform and Platform.Parent then
		return
	end

	if not Root then
		return
	end

	UpdateStepHeight()

	--------------------------------------------------------
	-- BASE POSITION
	--------------------------------------------------------

	BaseY =
		GetFeetY()
		- (CONFIG.PlatformSize.Y / 2)
		- 0.05

	CurrentY =
		BaseY

	TargetY =
		BaseY

	--------------------------------------------------------
	-- PART
	--------------------------------------------------------

	Platform =
		Instance.new("Part")

	Platform.Name =
		"SouzaPlatform_"
		.. Player.UserId

	Platform.Size =
		CONFIG.PlatformSize

	Platform.Anchored = true

	Platform.CanCollide = true
	Platform.CanTouch = true
	Platform.CanQuery = true

	Platform.CastShadow = false

	Platform.Material =
		Enum.Material.SmoothPlastic

	Platform.Color =
		Color3.fromRGB(
			31,
			24,
			55
		)

	Platform.Transparency = 0.04

	Platform.TopSurface =
		Enum.SurfaceType.Smooth

	Platform.BottomSurface =
		Enum.SurfaceType.Smooth

	Platform.CFrame =
		CFrame.new(
			Root.Position.X,
			CurrentY,
			Root.Position.Z
		)

	Platform.Parent =
		workspace

	--------------------------------------------------------
	-- TOP GUI
	--------------------------------------------------------

	local surface =
		Instance.new("SurfaceGui")

	surface.Name =
		"Logo"

	surface.Face =
		Enum.NormalId.Top

	surface.AlwaysOnTop = false

	surface.LightInfluence = 0

	surface.SizingMode =
		Enum.SurfaceGuiSizingMode.PixelsPerStud

	surface.PixelsPerStud = 50

	surface.Parent =
		Platform

	--------------------------------------------------------

	local holder =
		Instance.new("Frame")

	holder.Size =
		UDim2.fromScale(
			1,
			1
		)

	holder.BackgroundColor3 =
		Color3.fromRGB(
			23,
			18,
			40
		)

	holder.BorderSizePixel = 0

	holder.Parent =
		surface

	--------------------------------------------------------

	local gradient =
		Instance.new("UIGradient")

	gradient.Rotation = 45

	gradient.Color =
		ColorSequence.new({

			ColorSequenceKeypoint.new(
				0,
				Color3.fromRGB(
					90,
					55,
					175
				)
			),

			ColorSequenceKeypoint.new(
				1,
				Color3.fromRGB(
					18,
					15,
					30
				)
			),

		})

	gradient.Parent =
		holder

	--------------------------------------------------------
	-- TEXT BACKUP
	--------------------------------------------------------

	local backup =
		Instance.new("TextLabel")

	backup.Size =
		UDim2.fromScale(
			1,
			1
		)

	backup.BackgroundTransparency = 1

	backup.Text =
		"S"

	backup.TextColor3 =
		Color3.fromRGB(
			150,
			110,
			255
		)

	backup.TextTransparency = 0.75

	backup.TextSize = 100

	backup.Font =
		Enum.Font.GothamBlack

	backup.Parent =
		holder

	--------------------------------------------------------
	-- IMAGE
	--------------------------------------------------------

	local image =
		Instance.new("ImageLabel")

	image.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	image.Position =
		UDim2.fromScale(
			0.5,
			0.5
		)

	image.Size =
		UDim2.fromScale(
			0.62,
			0.62
		)

	image.BackgroundTransparency = 1

	image.ScaleType =
		Enum.ScaleType.Fit

	image.Parent =
		holder

	ApplyLogo(image)

end

------------------------------------------------------------
-- CHARACTER SETUP
------------------------------------------------------------

local function SetupCharacter(character)

	Character = character

	Humanoid =
		character:WaitForChild(
			"Humanoid"
		)

	Root =
		character:WaitForChild(
			"HumanoidRootPart"
		)

	DestroyPlatform()

	UpdateStepHeight()

end

if Player.Character then

	task.spawn(
		SetupCharacter,
		Player.Character
	)

end

Player.CharacterAdded:Connect(
	function(character)

		task.wait(0.25)

		SetupCharacter(character)

	end
)

------------------------------------------------------------
-- SCREEN GUI
------------------------------------------------------------

local GUI =
	Instance.new("ScreenGui")

GUI.Name =
	"SouzaUtilities"

GUI.ResetOnSpawn = false

GUI.IgnoreGuiInset = true

GUI.ZIndexBehavior =
	Enum.ZIndexBehavior.Sibling

GUI.Parent =
	PlayerGui

------------------------------------------------------------
-- MAIN
------------------------------------------------------------

local Main =
	Instance.new("Frame")

Main.Name = "Main"

Main.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

Main.Position =
	UDim2.new(
		0.5,
		0,
		0.52,
		0
	)

Main.Size =
	UDim2.fromOffset(
		CONFIG.Width,
		CONFIG.Height
	)

Main.BackgroundColor3 =
	COLORS.BG

Main.BorderSizePixel = 0

Main.ClipsDescendants = true

Main.Parent =
	GUI

corner(Main, 18)

stroke(
	Main,
	COLORS.Stroke,
	1,
	0
)

------------------------------------------------------------
-- MAIN SCALE
------------------------------------------------------------

local MainScale =
	Instance.new("UIScale")

MainScale.Scale = 1

MainScale.Parent =
	Main

------------------------------------------------------------
-- BACKGROUND GRADIENT
------------------------------------------------------------

local bgGradient =
	Instance.new("UIGradient")

bgGradient.Rotation = 90

bgGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,
			Color3.fromRGB(
				16,
				17,
				25
			)
		),

		ColorSequenceKeypoint.new(
			1,
			Color3.fromRGB(
				8,
				9,
				14
			)
		)

	})

bgGradient.Parent =
	Main

------------------------------------------------------------
-- TOPBAR
------------------------------------------------------------

local Topbar =
	Instance.new("Frame")

Topbar.Name =
	"Topbar"

Topbar.Size =
	UDim2.new(
		1,
		0,
		0,
		64
	)

Topbar.BackgroundColor3 =
	COLORS.Top

Topbar.BackgroundTransparency =
	0.05

Topbar.BorderSizePixel = 0

Topbar.Parent =
	Main

------------------------------------------------------------
-- LOGO HOLDER
------------------------------------------------------------

local LogoHolder =
	Instance.new("Frame")

LogoHolder.Position =
	UDim2.fromOffset(
		14,
		11
	)

LogoHolder.Size =
	UDim2.fromOffset(
		42,
		42
	)

LogoHolder.BackgroundColor3 =
	Color3.fromRGB(
		28,
		24,
		45
	)

LogoHolder.BorderSizePixel = 0

LogoHolder.Parent =
	Topbar

corner(
	LogoHolder,
	13
)

stroke(
	LogoHolder,
	COLORS.Purple,
	1.2,
	0.3
)

------------------------------------------------------------
-- LOGO BACKUP
------------------------------------------------------------

local LogoBackup =
	Instance.new("TextLabel")

LogoBackup.Size =
	UDim2.fromScale(
		1,
		1
	)

LogoBackup.BackgroundTransparency = 1

LogoBackup.Text = "S"

LogoBackup.TextColor3 =
	COLORS.Purple

LogoBackup.TextSize = 22

LogoBackup.Font =
	Enum.Font.GothamBlack

LogoBackup.Parent =
	LogoHolder

------------------------------------------------------------
-- LOGO IMAGE
------------------------------------------------------------

local Logo =
	Instance.new("ImageLabel")

Logo.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

Logo.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

Logo.Size =
	UDim2.fromOffset(
		32,
		32
	)

Logo.BackgroundTransparency = 1

Logo.ScaleType =
	Enum.ScaleType.Fit

Logo.Parent =
	LogoHolder

ApplyLogo(Logo)

------------------------------------------------------------
-- TITLE
------------------------------------------------------------

local Title =
	Instance.new("TextLabel")

Title.Position =
	UDim2.fromOffset(
		68,
		11
	)

Title.Size =
	UDim2.new(
		1,
		-130,
		0,
		22
	)

Title.BackgroundTransparency = 1

Title.Text =
	"SOUZA"

Title.TextColor3 =
	COLORS.Text

Title.TextSize = 17

Title.Font =
	Enum.Font.GothamBold

Title.TextXAlignment =
	Enum.TextXAlignment.Left

Title.Parent =
	Topbar

------------------------------------------------------------
-- SUBTITLE
------------------------------------------------------------

local Subtitle =
	Instance.new("TextLabel")

Subtitle.Position =
	UDim2.fromOffset(
		68,
		33
	)

Subtitle.Size =
	UDim2.new(
		1,
		-130,
		0,
		16
	)

Subtitle.BackgroundTransparency = 1

Subtitle.Text =
	"UTILITY PANEL"

Subtitle.TextColor3 =
	COLORS.SubText

Subtitle.TextSize = 10

Subtitle.Font =
	Enum.Font.GothamMedium

Subtitle.TextXAlignment =
	Enum.TextXAlignment.Left

Subtitle.Parent =
	Topbar

------------------------------------------------------------
-- MINIMIZE BUTTON
------------------------------------------------------------

local Minimize =
	Instance.new("TextButton")

Minimize.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

Minimize.Position =
	UDim2.new(
		1,
		-15,
		0.5,
		0
	)

Minimize.Size =
	UDim2.fromOffset(
		36,
		36
	)

Minimize.BackgroundColor3 =
	Color3.fromRGB(
		27,
		28,
		40
	)

Minimize.BorderSizePixel = 0

Minimize.Text = "−"

Minimize.TextColor3 =
	COLORS.Text

Minimize.TextSize = 22

Minimize.Font =
	Enum.Font.GothamBold

Minimize.AutoButtonColor =
	false

Minimize.Parent =
	Topbar

corner(Minimize, 11)

stroke(
	Minimize,
	COLORS.Stroke,
	1,
	0.15
)

------------------------------------------------------------
-- CONTENT
------------------------------------------------------------

local Content =
	Instance.new("Frame")

Content.Position =
	UDim2.fromOffset(
		14,
		76
	)

Content.Size =
	UDim2.new(
		1,
		-28,
		1,
		-90
	)

Content.BackgroundTransparency = 1

Content.Parent =
	Main

------------------------------------------------------------
-- LAYOUT
------------------------------------------------------------

local Layout =
	Instance.new("UIListLayout")

Layout.Padding =
	UDim.new(
		0,
		9
	)

Layout.FillDirection =
	Enum.FillDirection.Vertical

Layout.SortOrder =
	Enum.SortOrder.LayoutOrder

Layout.Parent =
	Content

------------------------------------------------------------
-- CARD CREATOR
------------------------------------------------------------

local function CreateCard(
	titleText,
	descriptionText
)

	local Card =
		Instance.new("Frame")

	Card.Size =
		UDim2.new(
			1,
			0,
			0,
			68
		)

	Card.BackgroundColor3 =
		COLORS.Card

	Card.BorderSizePixel = 0

	Card.Parent =
		Content

	corner(Card, 14)

	stroke(
		Card,
		COLORS.Stroke,
		1,
		0.15
	)

	--------------------------------------------------------

	local CardTitle =
		Instance.new("TextLabel")

	CardTitle.Position =
		UDim2.fromOffset(
			15,
			12
		)

	CardTitle.Size =
		UDim2.new(
			1,
			-160,
			0,
			19
		)

	CardTitle.BackgroundTransparency = 1

	CardTitle.Text =
		titleText

	CardTitle.TextColor3 =
		COLORS.Text

	CardTitle.TextSize = 13

	CardTitle.Font =
		Enum.Font.GothamBold

	CardTitle.TextXAlignment =
		Enum.TextXAlignment.Left

	CardTitle.Parent =
		Card

	--------------------------------------------------------

	local Description =
		Instance.new("TextLabel")

	Description.Position =
		UDim2.fromOffset(
			15,
			34
		)

	Description.Size =
		UDim2.new(
			1,
			-160,
			0,
			18
		)

	Description.BackgroundTransparency = 1

	Description.Text =
		descriptionText

	Description.TextColor3 =
		COLORS.SubText

	Description.TextSize = 10

	Description.Font =
		Enum.Font.GothamMedium

	Description.TextXAlignment =
		Enum.TextXAlignment.Left

	Description.TextTruncate =
		Enum.TextTruncate.AtEnd

	Description.Parent =
		Card

	return Card,
		CardTitle,
		Description

end

------------------------------------------------------------
-- ELEVATOR CARD
------------------------------------------------------------

local ElevatorCard,
	ElevatorTitle,
	ElevatorDescription =
	CreateCard(
		"ELEVADOR",
		"Nível 0 • bloco desativado"
	)

------------------------------------------------------------
-- BUTTONS HOLDER
------------------------------------------------------------

local ElevatorButtons =
	Instance.new("Frame")

ElevatorButtons.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

ElevatorButtons.Position =
	UDim2.new(
		1,
		-12,
		0.5,
		0
	)

ElevatorButtons.Size =
	UDim2.fromOffset(
		132,
		46
	)

ElevatorButtons.BackgroundTransparency = 1

ElevatorButtons.Parent =
	ElevatorCard

------------------------------------------------------------
-- MINUS
------------------------------------------------------------

local Minus =
	Instance.new("TextButton")

Minus.Size =
	UDim2.fromOffset(
		58,
		46
	)

Minus.Position =
	UDim2.fromOffset(
		0,
		0
	)

Minus.BackgroundColor3 =
	COLORS.Card2

Minus.BorderSizePixel = 0

Minus.Text = "−"

Minus.TextColor3 =
	COLORS.Text

Minus.TextSize = 27

Minus.Font =
	Enum.Font.GothamBold

Minus.AutoButtonColor = false

Minus.Parent =
	ElevatorButtons

corner(Minus, 12)

stroke(
	Minus,
	COLORS.Stroke,
	1,
	0
)

------------------------------------------------------------
-- PLUS
------------------------------------------------------------

local Plus =
	Instance.new("TextButton")

Plus.Size =
	UDim2.fromOffset(
		58,
		46
	)

Plus.Position =
	UDim2.fromOffset(
		74,
		0
	)

Plus.BackgroundColor3 =
	COLORS.Purple

Plus.BorderSizePixel = 0

Plus.Text = "+"

Plus.TextColor3 =
	Color3.fromRGB(
		255,
		255,
		255
	)

Plus.TextSize = 25

Plus.Font =
	Enum.Font.GothamBold

Plus.AutoButtonColor =
	false

Plus.Parent =
	ElevatorButtons

corner(Plus, 12)

stroke(
	Plus,
	Color3.fromRGB(
		170,
		140,
		255
	),
	1,
	0.25
)

------------------------------------------------------------
-- DESCNY CARD
------------------------------------------------------------

local DescnyCard,
	DescnyTitle,
	DescnyDescription =
	CreateCard(
		"DESCNY",
		"Procura item de invisibilidade"
	)

------------------------------------------------------------
-- DESCNY BUTTON
------------------------------------------------------------

local DescnyButton =
	Instance.new("TextButton")

DescnyButton.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

DescnyButton.Position =
	UDim2.new(
		1,
		-12,
		0.5,
		0
	)

DescnyButton.Size =
	UDim2.fromOffset(
		104,
		42
	)

DescnyButton.BackgroundColor3 =
	COLORS.Card2

DescnyButton.BorderSizePixel = 0

DescnyButton.Text =
	"USAR"

DescnyButton.TextColor3 =
	COLORS.Text

DescnyButton.TextSize = 11

DescnyButton.Font =
	Enum.Font.GothamBold

DescnyButton.AutoButtonColor = false

DescnyButton.Parent =
	DescnyCard

corner(
	DescnyButton,
	12
)

stroke(
	DescnyButton,
	COLORS.Stroke,
	1,
	0
)

------------------------------------------------------------
-- ANTILAG CARD
------------------------------------------------------------

local AntiLagCard,
	AntiLagTitle,
	AntiLagDescription =
	CreateCard(
		"ANTILAG",
		"Reduz efeitos visuais pesados"
	)

------------------------------------------------------------
-- ANTILAG BUTTON
------------------------------------------------------------

local AntiLagButton =
	Instance.new("TextButton")

AntiLagButton.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

AntiLagButton.Position =
	UDim2.new(
		1,
		-12,
		0.5,
		0
	)

AntiLagButton.Size =
	UDim2.fromOffset(
		104,
		42
	)

AntiLagButton.BackgroundColor3 =
	COLORS.Card2

AntiLagButton.BorderSizePixel = 0

AntiLagButton.Text =
	"OFF"

AntiLagButton.TextColor3 =
	COLORS.SubText

AntiLagButton.TextSize = 11

AntiLagButton.Font =
	Enum.Font.GothamBold

AntiLagButton.AutoButtonColor = false

AntiLagButton.Parent =
	AntiLagCard

corner(
	AntiLagButton,
	12
)

local AntiLagStroke =
	stroke(
		AntiLagButton,
		COLORS.Stroke,
		1,
		0
	)

------------------------------------------------------------
-- MINI BUTTON
------------------------------------------------------------

local Mini =
	Instance.new("ImageButton")

Mini.Name =
	"Mini"

Mini.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

Mini.Position =
	Main.Position

Mini.Size =
	UDim2.fromOffset(
		58,
		58
	)

Mini.BackgroundColor3 =
	COLORS.BG2

Mini.BorderSizePixel = 0

Mini.ScaleType =
	Enum.ScaleType.Fit

Mini.Visible = false

Mini.AutoButtonColor = false

Mini.Parent =
	GUI

corner(Mini, 18)

stroke(
	Mini,
	COLORS.Purple,
	2,
	0.1
)

ApplyLogo(Mini)

------------------------------------------------------------
-- BUTTON SCALE ANIMATION
------------------------------------------------------------

local function Press(button)

	local scale =
		button:FindFirstChild(
			"ButtonScale"
		)

	if not scale then

		scale =
			Instance.new("UIScale")

		scale.Name =
			"ButtonScale"

		scale.Scale = 1

		scale.Parent =
			button

	end

	TweenService:Create(
		scale,
		TweenInfo.new(
			0.06,
			Enum.EasingStyle.Quad
		),
		{
			Scale = 0.92
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
-- UPDATE ELEVATOR TEXT
------------------------------------------------------------

local function UpdateElevatorText()

	if not Platform then

		ElevatorDescription.Text =
			"Nível 0 • bloco desativado"

		return
	end

	ElevatorDescription.Text =
		"Nível "
		.. tostring(Level)
		.. " / "
		.. tostring(CONFIG.MaxLevel)

end

------------------------------------------------------------
-- PLUS
------------------------------------------------------------

Plus.MouseButton1Click:Connect(
	function()

		Press(Plus)

		if not Root then
			return
		end

		if not Platform then

			CreatePlatform()

		end

		if Level >= CONFIG.MaxLevel then

			ElevatorDescription.Text =
				"Altura máxima atingida"

			return

		end

		Level += 1

		TargetY =
			BaseY
			+ (
				StepHeight
				* Level
			)

		UpdateElevatorText()

	end
)

------------------------------------------------------------
-- MINUS
------------------------------------------------------------

Minus.MouseButton1Click:Connect(
	function()

		Press(Minus)

		if not Platform then
			return
		end

		if Level > 0 then

			Level -= 1

			TargetY =
				BaseY
				+ (
					StepHeight
					* Level
				)

			UpdateElevatorText()

			return

		end

		----------------------------------------------------
		-- nível já está 0:
		-- segundo clique no - remove o bloco
		----------------------------------------------------

		DestroyPlatform()

		UpdateElevatorText()

	end
)

------------------------------------------------------------
-- PLATFORM FOLLOW LOOP
------------------------------------------------------------

RunService.Heartbeat:Connect(
	function(deltaTime)

		if not Platform then
			return
		end

		if not Platform.Parent then

			Platform = nil

			return
		end

		if not Root then
			return
		end

		if not Root.Parent then
			return
		end

		if not Humanoid then
			return
		end

		if Humanoid.Health <= 0 then
			return
		end

		----------------------------------------------------
		-- SMOOTH Y
		----------------------------------------------------

		local alpha =
			1 -
			math.exp(
				-CONFIG.PlatformSpeed
				* deltaTime
			)

		CurrentY =
			CurrentY
			+ (
				TargetY
				- CurrentY
			)
			* alpha

		if math.abs(
			TargetY
				- CurrentY
		) < 0.01 then

			CurrentY =
				TargetY

		end

		----------------------------------------------------
		-- SEGUE X/Z DO JOGADOR
		----------------------------------------------------

		Platform.CFrame =
			CFrame.new(

				Root.Position.X,

				CurrentY,

				Root.Position.Z

			)

	end
)

------------------------------------------------------------
-- DESCNY
------------------------------------------------------------

local InvisKeywords = {

	"invis",
	"invisible",
	"invisibility",
	"cloak",
	"capa",
	"descny",

}

------------------------------------------------------------
-- CHECK TOOL
------------------------------------------------------------

local function IsInvisibilityTool(tool)

	if not tool:IsA("Tool") then
		return false
	end

	if tool:GetAttribute(
		"Invisibility"
	) == true then

		return true
	end

	if tool:GetAttribute(
		"Invisible"
	) == true then

		return true
	end

	if tool:GetAttribute(
		"Descny"
	) == true then

		return true
	end

	local searchText =
		string.lower(
			tool.Name
			.. " "
			.. tool.ToolTip
		)

	for _, keyword
		in ipairs(
			InvisKeywords
		)
	do

		if string.find(
			searchText,
			keyword,
			1,
			true
		) then

			return true

		end

	end

	return false
end

------------------------------------------------------------
-- FIND TOOL
------------------------------------------------------------

local function FindInvisibilityTool()

	if Character then

		for _, object
			in ipairs(
				Character:GetChildren()
			)
		do

			if IsInvisibilityTool(
				object
			) then

				return object

			end

		end

	end

	local Backpack =
		Player:FindFirstChildOfClass(
			"Backpack"
		)

	if Backpack then

		for _, object
			in ipairs(
				Backpack:GetChildren()
			)
		do

			if IsInvisibilityTool(
				object
			) then

				return object

			end

		end

	end

	return nil
end

------------------------------------------------------------
-- ACTIVATE DESCNY
------------------------------------------------------------

DescnyButton.MouseButton1Click:Connect(
	function()

		Press(DescnyButton)

		if not Humanoid then
			return
		end

		local tool =
			FindInvisibilityTool()

		if not tool then

			DescnyDescription.Text =
				"Item de invisibilidade não encontrado"

			DescnyButton.Text =
				"NÃO ACHOU"

			DescnyButton.TextColor3 =
				COLORS.Red

			task.delay(
				1.5,
				function()

					DescnyButton.Text =
						"USAR"

					DescnyButton.TextColor3 =
						COLORS.Text

				end
			)

			return
		end

		----------------------------------------------------
		-- EQUIP
		----------------------------------------------------

		if tool.Parent ~= Character then

			pcall(function()

				Humanoid:EquipTool(
					tool
				)

			end)

			task.wait(0.12)

		end

		----------------------------------------------------
		-- ACTIVATE TOOL
		----------------------------------------------------

		local success =
			pcall(function()

				tool:Activate()

			end)

		if success then

			DescnyDescription.Text =
				"Usando: "
				.. tool.Name

			DescnyButton.Text =
				"ATIVADO"

			DescnyButton.TextColor3 =
				COLORS.Green

			task.delay(
				1.25,
				function()

					if DescnyButton.Parent then

						DescnyButton.Text =
							"USAR"

						DescnyButton.TextColor3 =
							COLORS.Text

					end

				end
			)

		else

			DescnyDescription.Text =
				"Não foi possível ativar "
				.. tool.Name

		end

	end
)

------------------------------------------------------------
-- ANTILAG CACHE
------------------------------------------------------------

local function SaveProperty(
	object,
	property
)

	if not AntiLagCache[object] then

		AntiLagCache[object] = {}

	end

	if AntiLagCache[object][property]
		== nil
	then

		local success, value =
			pcall(function()

				return object[property]

			end)

		if success then

			AntiLagCache[object][property] =
				value

		end

	end

end

------------------------------------------------------------
-- CHANGE PROPERTY
------------------------------------------------------------

local function ChangeProperty(
	object,
	property,
	value
)

	SaveProperty(
		object,
		property
	)

	pcall(function()

		object[property] =
			value

	end)

end

------------------------------------------------------------
-- OPTIMIZE OBJECT
------------------------------------------------------------

local function OptimizeObject(object)

	if object:IsA(
		"ParticleEmitter"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"Trail"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"Beam"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"Smoke"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"Fire"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"Sparkles"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"BloomEffect"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"BlurEffect"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"DepthOfFieldEffect"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"SunRaysEffect"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"ColorCorrectionEffect"
	) then

		ChangeProperty(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"BasePart"
	) then

		ChangeProperty(
			object,
			"CastShadow",
			false
		)

	elseif object:IsA(
		"MeshPart"
	) then

		pcall(function()

			ChangeProperty(
				object,
				"RenderFidelity",
				Enum.RenderFidelity.Performance
			)

		end)

	end

end

------------------------------------------------------------
-- ENABLE ANTILAG
------------------------------------------------------------

local function EnableAntiLag()

	if AntiLagBusy then
		return
	end

	AntiLagBusy = true
	AntiLagEnabled = true

	AntiLagDescription.Text =
		"Otimizando mapa..."

	AntiLagButton.Text =
		"..."

	--------------------------------------------------------
	-- LIGHTING
	--------------------------------------------------------

	ChangeProperty(
		Lighting,
		"GlobalShadows",
		false
	)

	--------------------------------------------------------
	-- PROCESS OBJECTS
	--------------------------------------------------------

	task.spawn(
		function()

			local objects =
				workspace:GetDescendants()

			local lightingObjects =
				Lighting:GetDescendants()

			for _, object
				in ipairs(
					lightingObjects
				)
			do

				table.insert(
					objects,
					object
				)

			end

			local processed = 0

			for _, object
				in ipairs(
					objects
				)
			do

				if not AntiLagEnabled then
					break
				end

				OptimizeObject(
					object
				)

				processed += 1

				-- evita travadão ao ativar
				if processed % 200 == 0 then

					RunService.Heartbeat:Wait()

				end

			end

			if AntiLagEnabled then

				AntiLagDescription.Text =
					"Efeitos pesados reduzidos"

				AntiLagButton.Text =
					"ON"

				AntiLagButton.TextColor3 =
					COLORS.Green

				AntiLagButton.BackgroundColor3 =
					Color3.fromRGB(
						24,
						53,
						43
					)

				AntiLagStroke.Color =
					COLORS.Green

			end

			AntiLagBusy = false

		end
	)

end

------------------------------------------------------------
-- DISABLE ANTILAG
------------------------------------------------------------

local function DisableAntiLag()

	if AntiLagBusy then

		AntiLagEnabled = false

		task.wait()

	end

	AntiLagEnabled = false
	AntiLagBusy = true

	AntiLagDescription.Text =
		"Restaurando efeitos..."

	AntiLagButton.Text =
		"..."

	task.spawn(
		function()

			local count = 0

			for object, properties
				in pairs(
					AntiLagCache
				)
			do

				if object
					and
					object.Parent
				then

					for property, value
						in pairs(
							properties
						)
					do

						pcall(function()

							object[property] =
								value

						end)

					end

				end

				count += 1

				if count % 200 == 0 then

					RunService.Heartbeat:Wait()

				end

			end

			AntiLagCache = {}

			AntiLagDescription.Text =
				"Reduz efeitos visuais pesados"

			AntiLagButton.Text =
				"OFF"

			AntiLagButton.TextColor3 =
				COLORS.SubText

			AntiLagButton.BackgroundColor3 =
				COLORS.Card2

			AntiLagStroke.Color =
				COLORS.Stroke

			AntiLagBusy = false

		end
	)

end

------------------------------------------------------------
-- ANTILAG CLICK
------------------------------------------------------------

AntiLagButton.MouseButton1Click:Connect(
	function()

		Press(AntiLagButton)

		if AntiLagBusy then
			return
		end

		if AntiLagEnabled then

			DisableAntiLag()

		else

			EnableAntiLag()

		end

	end
)

------------------------------------------------------------
-- NEW OBJECT ANTILAG
------------------------------------------------------------

workspace.DescendantAdded:Connect(
	function(object)

		if AntiLagEnabled then

			task.defer(
				OptimizeObject,
				object
			)

		end

	end
)

Lighting.DescendantAdded:Connect(
	function(object)

		if AntiLagEnabled then

			task.defer(
				OptimizeObject,
				object
			)

		end

	end
)

------------------------------------------------------------
-- MINIMIZE
------------------------------------------------------------

local Minimized = false

local function MinimizeUI()

	if Minimized then
		return
	end

	Minimized = true

	Mini.Position =
		Main.Position

	TweenService:Create(
		MainScale,
		TweenInfo.new(
			0.13,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		),
		{
			Scale = 0.88
		}
	):Play()

	task.delay(
		0.12,
		function()

			Main.Visible = false

			Mini.Visible = true

		end
	)

end

------------------------------------------------------------
-- RESTORE
------------------------------------------------------------

local function RestoreUI()

	if not Minimized then
		return
	end

	Minimized = false

	Mini.Visible = false

	Main.Position =
		Mini.Position

	Main.Visible = true

	MainScale.Scale = 0.88

	TweenService:Create(
		MainScale,
		TweenInfo.new(
			0.18,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),
		{
			Scale = 1
		}
	):Play()

end

Minimize.MouseButton1Click:Connect(
	function()

		Press(Minimize)

		MinimizeUI()

	end
)

Mini.MouseButton1Click:Connect(
	function()

		RestoreUI()

	end
)

------------------------------------------------------------
-- DRAG MAIN
------------------------------------------------------------

local Dragging = false

local DragStart
local StartPosition

Topbar.InputBegan:Connect(
	function(input)

		if input.UserInputType ~=
			Enum.UserInputType.MouseButton1
		then
			return
		end

		Dragging = true

		DragStart =
			input.Position

		StartPosition =
			Main.Position

	end
)

UserInputService.InputEnded:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
		then

			Dragging = false

		end

	end
)

UserInputService.InputChanged:Connect(
	function(input)

		if not Dragging then
			return
		end

		if input.UserInputType ~=
			Enum.UserInputType.MouseMovement
		then
			return
		end

		local Delta =
			input.Position
			- DragStart

		Main.Position =
			UDim2.new(

				StartPosition.X.Scale,

				StartPosition.X.Offset
					+ Delta.X,

				StartPosition.Y.Scale,

				StartPosition.Y.Offset
					+ Delta.Y

			)

	end
)

------------------------------------------------------------
-- MINI DRAG
------------------------------------------------------------

local MiniDragging = false

local MiniDragStart
local MiniStartPosition

Mini.InputBegan:Connect(
	function(input)

		if input.UserInputType ~=
			Enum.UserInputType.MouseButton1
		then
			return
		end

		MiniDragging = true

		MiniDragStart =
			input.Position

		MiniStartPosition =
			Mini.Position

	end
)

UserInputService.InputEnded:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
		then

			MiniDragging = false

		end

	end
)

UserInputService.InputChanged:Connect(
	function(input)

		if not MiniDragging then
			return
		end

		if input.UserInputType ~=
			Enum.UserInputType.MouseMovement
		then
			return
		end

		local delta =
			input.Position
			- MiniDragStart

		Mini.Position =
			UDim2.new(

				MiniStartPosition.X.Scale,

				MiniStartPosition.X.Offset
					+ delta.X,

				MiniStartPosition.Y.Scale,

				MiniStartPosition.Y.Offset
					+ delta.Y

			)

	end
)

------------------------------------------------------------
-- RESPAWN SAFETY
------------------------------------------------------------

Player.CharacterRemoving:Connect(
	function()

		DestroyPlatform()

	end
)

------------------------------------------------------------
-- INITIAL UI
------------------------------------------------------------

UpdateElevatorText()
