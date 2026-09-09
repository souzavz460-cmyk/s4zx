--[[
    SOUZA PANEL - REBUILD

    LocalScript:
    StarterPlayer
        > StarterPlayerScripts
            > LocalScript

    PRINCIPAL:
    • Elevador
    • DESCNY
    • AntiLag

    IMPORTANTE:
    A bolinha flutuante foi refeita do zero para PC:
    • Clique = abre
    • Segura + move = arrasta
    • Não abre ao terminar um arrasto
    • Fica limitada dentro da tela

    RightShift também abre/fecha o painel.
]]

------------------------------------------------------------
-- SERVICES
------------------------------------------------------------

local Players =
	game:GetService("Players")

local TweenService =
	game:GetService("TweenService")

local RunService =
	game:GetService("RunService")

local UIS =
	game:GetService("UserInputService")

local Lighting =
	game:GetService("Lighting")

------------------------------------------------------------
-- PLAYER
------------------------------------------------------------

local Player =
	Players.LocalPlayer

local PlayerGui =
	Player:WaitForChild("PlayerGui")

------------------------------------------------------------
-- CAMERA
------------------------------------------------------------

while not workspace.CurrentCamera do
	task.wait()
end

local Camera =
	workspace.CurrentCamera

------------------------------------------------------------
-- CONFIG
------------------------------------------------------------

local CONFIG = {

	Logo =
		"rbxthumb://type=Asset&id=98880379063768&w=420&h=420",

	--------------------------------------------------------
	-- PANEL
	--------------------------------------------------------

	Width = 600,

	Height = 390,

	SidebarWidth = 148,

	--------------------------------------------------------
	-- PLATFORM
	--------------------------------------------------------

	PlatformSize =
		Vector3.new(
			6.5,
			0.65,
			6.5
		),

	-- nível 2 continua baixo
	StepHeight = 2.15,

	MaxLevel = 25,

	MoveSpeed = 7.5,
}

------------------------------------------------------------
-- ADVANCED FONT
------------------------------------------------------------

local FONT_REGULAR =
	Font.new(

		"rbxasset://fonts/families/GothamSSm.json",

		Enum.FontWeight.Regular,

		Enum.FontStyle.Normal
	)

local FONT_MEDIUM =
	Font.new(

		"rbxasset://fonts/families/GothamSSm.json",

		Enum.FontWeight.Medium,

		Enum.FontStyle.Normal
	)

local FONT_BOLD =
	Font.new(

		"rbxasset://fonts/families/GothamSSm.json",

		Enum.FontWeight.Bold,

		Enum.FontStyle.Normal
	)

------------------------------------------------------------
-- COLORS
------------------------------------------------------------

local COLOR = {

	Background =
		Color3.fromRGB(
			7,
			10,
			16
		),

	Background2 =
		Color3.fromRGB(
			11,
			15,
			24
		),

	Sidebar =
		Color3.fromRGB(
			5,
			8,
			14
		),

	Sidebar2 =
		Color3.fromRGB(
			8,
			12,
			20
		),

	Card =
		Color3.fromRGB(
			16,
			22,
			32
		),

	CardHover =
		Color3.fromRGB(
			21,
			29,
			42
		),

	Control =
		Color3.fromRGB(
			8,
			14,
			22
		),

	Stroke =
		Color3.fromRGB(
			35,
			45,
			59
		),

	StrokeSoft =
		Color3.fromRGB(
			27,
			35,
			47
		),

	Text =
		Color3.fromRGB(
			245,
			247,
			250
		),

	Text2 =
		Color3.fromRGB(
			159,
			169,
			184
		),

	Text3 =
		Color3.fromRGB(
			103,
			114,
			132
		),

	Accent =
		Color3.fromRGB(
			255,
			77,
			24
		),

	Accent2 =
		Color3.fromRGB(
			255,
			110,
			42
		),

	Green =
		Color3.fromRGB(
			77,
			219,
			144
		),

	Red =
		Color3.fromRGB(
			238,
			78,
			96
		),

	White =
		Color3.fromRGB(
			247,
			249,
			252
		),
}

------------------------------------------------------------
-- CLEAN OLD VERSION
------------------------------------------------------------

local OldGui =
	PlayerGui:FindFirstChild(
		"SouzaPremiumPanel"
	)

if OldGui then
	OldGui:Destroy()
end

local OldPlatform =
	workspace:FindFirstChild(
		"SouzaPlatform_"
		.. Player.UserId
	)

if OldPlatform then
	OldPlatform:Destroy()
end

------------------------------------------------------------
-- HELPERS
------------------------------------------------------------

local function AddCorner(
	object,
	radius
)

	local corner =
		Instance.new("UICorner")

	corner.CornerRadius =
		UDim.new(
			0,
			radius
		)

	corner.Parent =
		object

	return corner

end

------------------------------------------------------------

local function AddStroke(
	object,
	color,
	thickness,
	transparency
)

	local stroke =
		Instance.new("UIStroke")

	stroke.Color =
		color or COLOR.Stroke

	stroke.Thickness =
		thickness or 1

	stroke.Transparency =
		transparency or 0

	stroke.Parent =
		object

	return stroke

end

------------------------------------------------------------

local function Tween(
	object,
	duration,
	properties
)

	local tween =
		TweenService:Create(

			object,

			TweenInfo.new(
				duration,

				Enum.EasingStyle.Quart,

				Enum.EasingDirection.Out
			),

			properties
		)

	tween:Play()

	return tween

end

------------------------------------------------------------
-- CHARACTER
------------------------------------------------------------

local Character

local Humanoid

local Root

------------------------------------------------------------

local function SetupCharacter(
	character
)

	Character =
		character

	Humanoid =
		character:WaitForChild(
			"Humanoid"
		)

	Root =
		character:WaitForChild(
			"HumanoidRootPart"
		)

end

------------------------------------------------------------

if Player.Character then

	task.spawn(
		SetupCharacter,
		Player.Character
	)

end

------------------------------------------------------------

Player.CharacterAdded:Connect(
	function(character)

		task.wait(0.2)

		SetupCharacter(
			character
		)

	end
)

------------------------------------------------------------
-- PLATFORM SYSTEM
------------------------------------------------------------

local Platform = nil

local Level = 0

local BaseY = 0

local CurrentY = 0

local TargetY = 0

------------------------------------------------------------
-- FEET Y
------------------------------------------------------------

local function GetFeetY()

	if not Root
		or not Humanoid
	then

		return 0

	end

	return Root.Position.Y
		- Humanoid.HipHeight
		- Root.Size.Y / 2

end

------------------------------------------------------------
-- CREATE PLATFORM
------------------------------------------------------------

local function CreatePlatform()

	if Platform
		and Platform.Parent
	then

		return

	end

	if not Root then
		return
	end

	--------------------------------------------------------
	-- BASE
	--------------------------------------------------------

	BaseY =
		GetFeetY()
		- CONFIG.PlatformSize.Y / 2
		- 0.04

	CurrentY =
		BaseY

	TargetY =
		BaseY

	--------------------------------------------------------
	-- PART
	--------------------------------------------------------

	Platform =
		Instance.new(
			"Part"
		)

	Platform.Name =
		"SouzaPlatform_"
		.. Player.UserId

	Platform.Size =
		CONFIG.PlatformSize

	Platform.Anchored =
		true

	Platform.CanCollide =
		true

	Platform.CanTouch =
		true

	Platform.CanQuery =
		true

	Platform.CastShadow =
		false

	Platform.Material =
		Enum.Material.SmoothPlastic

	Platform.Color =
		Color3.fromRGB(
			14,
			18,
			26
		)

	Platform.Transparency =
		0.02

	Platform.TopSurface =
		Enum.SurfaceType.Smooth

	Platform.BottomSurface =
		Enum.SurfaceType.Smooth

	Platform.CFrame =
		CFrame.new(

			Root.Position.X,

			BaseY,

			Root.Position.Z
		)

	Platform.Parent =
		workspace

	--------------------------------------------------------
	-- PLATFORM GUI
	--------------------------------------------------------

	local Surface =
		Instance.new(
			"SurfaceGui"
		)

	Surface.Face =
		Enum.NormalId.Top

	Surface.SizingMode =
		Enum.SurfaceGuiSizingMode.PixelsPerStud

	Surface.PixelsPerStud =
		50

	Surface.LightInfluence =
		0

	Surface.Parent =
		Platform

	--------------------------------------------------------

	local BG =
		Instance.new(
			"Frame"
		)

	BG.Size =
		UDim2.fromScale(
			1,
			1
		)

	BG.BackgroundColor3 =
		Color3.fromRGB(
			10,
			13,
			20
		)

	BG.BorderSizePixel =
		0

	BG.Parent =
		Surface

	--------------------------------------------------------

	local Gradient =
		Instance.new(
			"UIGradient"
		)

	Gradient.Rotation =
		45

	Gradient.Color =
		ColorSequence.new({

			ColorSequenceKeypoint.new(
				0,
				Color3.fromRGB(
					30,
					22,
					20
				)
			),

			ColorSequenceKeypoint.new(
				0.5,
				Color3.fromRGB(
					12,
					16,
					24
				)
			),

			ColorSequenceKeypoint.new(
				1,
				Color3.fromRGB(
					22,
					14,
					13
				)
			),

		})

	Gradient.Parent =
		BG

	--------------------------------------------------------

	local PlatformStroke =
		Instance.new(
			"UIStroke"
		)

	PlatformStroke.Color =
		COLOR.Accent

	PlatformStroke.Thickness =
		3

	PlatformStroke.Transparency =
		0.1

	PlatformStroke.Parent =
		BG

	--------------------------------------------------------
	-- FALLBACK
	--------------------------------------------------------

	local Letter =
		Instance.new(
			"TextLabel"
		)

	Letter.Size =
		UDim2.fromScale(
			1,
			1
		)

	Letter.BackgroundTransparency =
		1

	Letter.Text =
		"S"

	Letter.TextColor3 =
		COLOR.Accent

	Letter.TextTransparency =
		0.7

	Letter.TextScaled =
		true

	Letter.FontFace =
		FONT_BOLD

	Letter.Parent =
		BG

	--------------------------------------------------------
	-- LOGO
	--------------------------------------------------------

	local Logo =
		Instance.new(
			"ImageLabel"
		)

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
		UDim2.fromScale(
			0.58,
			0.58
		)

	Logo.BackgroundTransparency =
		1

	Logo.Image =
		CONFIG.Logo

	Logo.ScaleType =
		Enum.ScaleType.Fit

	Logo.Parent =
		BG

end

------------------------------------------------------------
-- REMOVE PLATFORM
------------------------------------------------------------

local function RemovePlatform()

	Level = 0

	if Platform then

		Platform:Destroy()

		Platform = nil

	end

end

------------------------------------------------------------
-- PLATFORM FOLLOW
------------------------------------------------------------

RunService.Heartbeat:Connect(
	function(dt)

		if not Platform
			or not Platform.Parent
		then

			return

		end

		if not Root
			or not Root.Parent
		then

			return

		end

		if not Humanoid
			or Humanoid.Health <= 0
		then

			return

		end

		local alpha =
			1
			- math.exp(
				-CONFIG.MoveSpeed
				* dt
			)

		CurrentY =
			CurrentY
			+ (
				TargetY
				- CurrentY
			)
			* alpha

		Platform.CFrame =
			CFrame.new(

				Root.Position.X,

				CurrentY,

				Root.Position.Z
			)

	end
)

------------------------------------------------------------
-- DESCNY SYSTEM
------------------------------------------------------------

local InvisKeywords = {

	"invis",

	"invisible",

	"invisibility",

	"cloak",

	"capa",

	"descny",

	"ghost",

	"vanish",
}

------------------------------------------------------------

local function IsInvisibilityTool(
	object
)

	if not object:IsA(
		"Tool"
	) then

		return false

	end

	if object:GetAttribute(
		"Invisibility"
	) == true then

		return true

	end

	if object:GetAttribute(
		"Invisible"
	) == true then

		return true

	end

	if object:GetAttribute(
		"Descny"
	) == true then

		return true

	end

	local Search =
		string.lower(

			object.Name
			.. " "
			.. object.ToolTip
		)

	for _, keyword
		in ipairs(
			InvisKeywords
		)
	do

		if string.find(
			Search,

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

	--------------------------------------------------------

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

local function ActivateDescny()

	if not Humanoid then

		return false,
			"Personagem indisponível"

	end

	local Tool =
		FindInvisibilityTool()

	if not Tool then

		return false,
			"Item não encontrado"

	end

	--------------------------------------------------------
	-- EQUIP
	--------------------------------------------------------

	if Tool.Parent
		~= Character
	then

		pcall(
			function()

				Humanoid:EquipTool(
					Tool
				)

			end
		)

		task.wait(
			0.12
		)

	end

	--------------------------------------------------------
	-- ACTIVATE
	--------------------------------------------------------

	local Success =
		pcall(
			function()

				Tool:Activate()

			end
		)

	if Success then

		return true,
			Tool.Name

	end

	return false,
		"Falha ao ativar"

end

------------------------------------------------------------
-- ANTI LAG
------------------------------------------------------------

local AntiLagEnabled =
	false

local AntiLagCache =
	{}

------------------------------------------------------------

local function SaveProperty(
	object,
	property
)

	if not AntiLagCache[
		object
	] then

		AntiLagCache[
			object
		] = {}

	end

	if AntiLagCache[
		object
	][property] ~= nil
	then

		return

	end

	local Success,
		Value =
		pcall(
			function()

				return object[
					property
				]

			end
		)

	if Success then

		AntiLagCache[
			object
		][property] =
			Value

	end

end

------------------------------------------------------------

local function SetCached(
	object,
	property,
	value
)

	SaveProperty(
		object,
		property
	)

	pcall(
		function()

			object[property] =
				value

		end
	)

end

------------------------------------------------------------

local function OptimizeObject(
	object
)

	if
		object:IsA(
			"ParticleEmitter"
		)
		or
		object:IsA(
			"Trail"
		)
		or
		object:IsA(
			"Beam"
		)
		or
		object:IsA(
			"Smoke"
		)
		or
		object:IsA(
			"Fire"
		)
		or
		object:IsA(
			"Sparkles"
		)
	then

		SetCached(
			object,
			"Enabled",
			false
		)

	elseif
		object:IsA(
			"BloomEffect"
		)
		or
		object:IsA(
			"BlurEffect"
		)
		or
		object:IsA(
			"SunRaysEffect"
		)
		or
		object:IsA(
			"DepthOfFieldEffect"
		)
	then

		SetCached(
			object,
			"Enabled",
			false
		)

	elseif object:IsA(
		"BasePart"
	) then

		SetCached(
			object,
			"CastShadow",
			false
		)

	end

end

------------------------------------------------------------

local function EnableAntiLag()

	if AntiLagEnabled then
		return
	end

	AntiLagEnabled =
		true

	SetCached(
		Lighting,
		"GlobalShadows",
		false
	)

	task.spawn(
		function()

			local Objects =
				workspace:GetDescendants()

			for index,
				object
				in ipairs(
					Objects
				)
			do

				if not AntiLagEnabled then
					break
				end

				OptimizeObject(
					object
				)

				if index % 250
					== 0
				then

					RunService.Heartbeat:Wait()

				end

			end

			for _, effect
				in ipairs(
					Lighting:GetDescendants()
				)
			do

				OptimizeObject(
					effect
				)

			end

		end
	)

end

------------------------------------------------------------

local function DisableAntiLag()

	AntiLagEnabled =
		false

	for object,
		properties
		in pairs(
			AntiLagCache
		)
	do

		if object
			and object.Parent
		then

			for property,
				value
				in pairs(
					properties
				)
			do

				pcall(
					function()

						object[
							property
						] = value

					end
				)

			end

		end

	end

	AntiLagCache = {}

end

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

------------------------------------------------------------
-- GUI
------------------------------------------------------------

local GUI =
	Instance.new(
		"ScreenGui"
	)

GUI.Name =
	"SouzaPremiumPanel"

GUI.ResetOnSpawn =
	false

GUI.IgnoreGuiInset =
	true

GUI.ZIndexBehavior =
	Enum.ZIndexBehavior.Sibling

GUI.Parent =
	PlayerGui

------------------------------------------------------------
-- SCREEN POSITION
------------------------------------------------------------

local Viewport =
	Camera.ViewportSize

local StartX =
	math.floor(
		(
			Viewport.X
			- CONFIG.Width
		)
		/ 2
	)

local StartY =
	math.floor(
		(
			Viewport.Y
			- CONFIG.Height
		)
		/ 2
	)

------------------------------------------------------------
-- SHADOW
------------------------------------------------------------

local Shadow =
	Instance.new(
		"Frame"
	)

Shadow.Position =
	UDim2.fromOffset(

		StartX + 9,

		StartY + 11
	)

Shadow.Size =
	UDim2.fromOffset(

		CONFIG.Width,

		CONFIG.Height
	)

Shadow.BackgroundColor3 =
	Color3.fromRGB(
		0,
		0,
		0
	)

Shadow.BackgroundTransparency =
	0.45

Shadow.BorderSizePixel =
	0

Shadow.ZIndex =
	0

Shadow.Parent =
	GUI

AddCorner(
	Shadow,
	12
)

------------------------------------------------------------
-- MAIN
------------------------------------------------------------

local Main =
	Instance.new(
		"Frame"
	)

Main.Name =
	"Main"

Main.Position =
	UDim2.fromOffset(

		StartX,

		StartY
	)

Main.Size =
	UDim2.fromOffset(

		CONFIG.Width,

		CONFIG.Height
	)

Main.BackgroundColor3 =
	COLOR.Background

Main.BorderSizePixel =
	0

Main.ClipsDescendants =
	true

Main.Active =
	true

Main.ZIndex =
	2

Main.Parent =
	GUI

AddCorner(
	Main,
	12
)

AddStroke(

	Main,

	COLOR.Stroke,

	1,

	0.05
)

------------------------------------------------------------
-- MAIN BACKGROUND GRADIENT
------------------------------------------------------------

local MainGradient =
	Instance.new(
		"UIGradient"
	)

MainGradient.Rotation =
	125

MainGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,

			Color3.fromRGB(
				14,
				20,
				31
			)
		),

		ColorSequenceKeypoint.new(
			0.45,

			Color3.fromRGB(
				8,
				12,
				20
			)
		),

		ColorSequenceKeypoint.new(
			1,

			Color3.fromRGB(
				15,
				10,
				13
			)
		),

	})

MainGradient.Parent =
	Main

------------------------------------------------------------
-- SIDEBAR
------------------------------------------------------------

local Sidebar =
	Instance.new(
		"Frame"
	)

Sidebar.Size =
	UDim2.new(

		0,

		CONFIG.SidebarWidth,

		1,

		0
	)

Sidebar.BackgroundColor3 =
	COLOR.Sidebar

Sidebar.BackgroundTransparency =
	0.06

Sidebar.BorderSizePixel =
	0

Sidebar.ZIndex =
	3

Sidebar.Parent =
	Main

------------------------------------------------------------
-- SIDEBAR GRADIENT
------------------------------------------------------------

local SidebarGradient =
	Instance.new(
		"UIGradient"
	)

SidebarGradient.Rotation =
	90

SidebarGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,

			Color3.fromRGB(
				8,
				13,
				22
			)
		),

		ColorSequenceKeypoint.new(
			1,

			Color3.fromRGB(
				4,
				7,
				12
			)
		),

	})

SidebarGradient.Parent =
	Sidebar

------------------------------------------------------------
-- SIDEBAR DIVIDER
------------------------------------------------------------

local SideDivider =
	Instance.new(
		"Frame"
	)

SideDivider.AnchorPoint =
	Vector2.new(
		1,
		0
	)

SideDivider.Position =
	UDim2.new(
		1,
		0,
		0,
		0
	)

SideDivider.Size =
	UDim2.new(
		0,
		1,
		1,
		0
	)

SideDivider.BackgroundColor3 =
	COLOR.StrokeSoft

SideDivider.BorderSizePixel =
	0

SideDivider.Parent =
	Sidebar

------------------------------------------------------------
-- BRAND LOGO HOLDER
------------------------------------------------------------

local BrandHolder =
	Instance.new(
		"Frame"
	)

BrandHolder.AnchorPoint =
	Vector2.new(
		0.5,
		0
	)

BrandHolder.Position =
	UDim2.new(
		0.5,
		0,
		0,
		23
	)

BrandHolder.Size =
	UDim2.fromOffset(
		56,
		56
	)

BrandHolder.BackgroundColor3 =
	Color3.fromRGB(
		16,
		21,
		30
	)

BrandHolder.BorderSizePixel =
	0

BrandHolder.ZIndex =
	5

BrandHolder.Parent =
	Sidebar

AddCorner(
	BrandHolder,
	28
)

AddStroke(

	BrandHolder,

	COLOR.Accent,

	1.5,

	0.15
)

------------------------------------------------------------
-- FALLBACK S
------------------------------------------------------------

local BrandFallback =
	Instance.new(
		"TextLabel"
	)

BrandFallback.Size =
	UDim2.fromScale(
		1,
		1
	)

BrandFallback.BackgroundTransparency =
	1

BrandFallback.Text =
	"S"

BrandFallback.TextColor3 =
	COLOR.Accent

BrandFallback.TextSize =
	27

BrandFallback.FontFace =
	FONT_BOLD

BrandFallback.ZIndex =
	6

BrandFallback.Parent =
	BrandHolder

------------------------------------------------------------
-- BRAND LOGO
------------------------------------------------------------

local BrandLogo =
	Instance.new(
		"ImageLabel"
	)

BrandLogo.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

BrandLogo.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

BrandLogo.Size =
	UDim2.fromOffset(
		48,
		48
	)

BrandLogo.BackgroundTransparency =
	1

BrandLogo.Image =
	CONFIG.Logo

BrandLogo.ScaleType =
	Enum.ScaleType.Fit

BrandLogo.ZIndex =
	7

BrandLogo.Parent =
	BrandHolder

------------------------------------------------------------
-- BRAND NAME
------------------------------------------------------------

local BrandName =
	Instance.new(
		"TextLabel"
	)

BrandName.Position =
	UDim2.fromOffset(
		0,
		89
	)

BrandName.Size =
	UDim2.new(
		1,
		0,
		0,
		20
	)

BrandName.BackgroundTransparency =
	1

BrandName.Text =
	"SOUZA"

BrandName.TextColor3 =
	COLOR.Text

BrandName.TextSize =
	13

BrandName.FontFace =
	FONT_BOLD

BrandName.ZIndex =
	5

BrandName.Parent =
	Sidebar

------------------------------------------------------------
-- BRAND SUB
------------------------------------------------------------

local BrandSub =
	Instance.new(
		"TextLabel"
	)

BrandSub.Position =
	UDim2.fromOffset(
		0,
		108
	)

BrandSub.Size =
	UDim2.new(
		1,
		0,
		0,
		15
	)

BrandSub.BackgroundTransparency =
	1

BrandSub.Text =
	"UTILITY"

BrandSub.TextColor3 =
	COLOR.Text3

BrandSub.TextSize =
	9

BrandSub.FontFace =
	FONT_MEDIUM

BrandSub.ZIndex =
	5

BrandSub.Parent =
	Sidebar

------------------------------------------------------------
-- PRINCIPAL NAV
------------------------------------------------------------

local PrincipalButton =
	Instance.new(
		"TextButton"
	)

PrincipalButton.Position =
	UDim2.fromOffset(
		13,
		153
	)

PrincipalButton.Size =
	UDim2.new(
		1,
		-26,
		0,
		50
	)

PrincipalButton.BackgroundColor3 =
	Color3.fromRGB(
		22,
		25,
		32
	)

PrincipalButton.BackgroundTransparency =
	0.05

PrincipalButton.BorderSizePixel =
	0

PrincipalButton.Text =
	""

PrincipalButton.AutoButtonColor =
	false

PrincipalButton.ZIndex =
	5

PrincipalButton.Parent =
	Sidebar

AddCorner(
	PrincipalButton,
	10
)

------------------------------------------------------------
-- ACCENT BAR
------------------------------------------------------------

local PrincipalAccent =
	Instance.new(
		"Frame"
	)

PrincipalAccent.Position =
	UDim2.fromOffset(
		0,
		8
	)

PrincipalAccent.Size =
	UDim2.fromOffset(
		3,
		34
	)

PrincipalAccent.BackgroundColor3 =
	COLOR.Accent

PrincipalAccent.BorderSizePixel =
	0

PrincipalAccent.Parent =
	PrincipalButton

AddCorner(
	PrincipalAccent,
	2
)

------------------------------------------------------------
-- NAV ICON
------------------------------------------------------------

local PrincipalIcon =
	Instance.new(
		"TextLabel"
	)

PrincipalIcon.Position =
	UDim2.fromOffset(
		17,
		0
	)

PrincipalIcon.Size =
	UDim2.fromOffset(
		28,
		50
	)

PrincipalIcon.BackgroundTransparency =
	1

PrincipalIcon.Text =
	"◈"

PrincipalIcon.TextColor3 =
	COLOR.Accent

PrincipalIcon.TextSize =
	20

PrincipalIcon.FontFace =
	FONT_BOLD

PrincipalIcon.Parent =
	PrincipalButton

------------------------------------------------------------
-- NAV TEXT
------------------------------------------------------------

local PrincipalText =
	Instance.new(
		"TextLabel"
	)

PrincipalText.Position =
	UDim2.fromOffset(
		48,
		0
	)

PrincipalText.Size =
	UDim2.new(
		1,
		-52,
		1,
		0
	)

PrincipalText.BackgroundTransparency =
	1

PrincipalText.Text =
	"Principal"

PrincipalText.TextColor3 =
	COLOR.Text

PrincipalText.TextSize =
	13

PrincipalText.FontFace =
	FONT_MEDIUM

PrincipalText.TextXAlignment =
	Enum.TextXAlignment.Left

PrincipalText.Parent =
	PrincipalButton

------------------------------------------------------------
-- SIDEBAR BOTTOM INFO
------------------------------------------------------------

local KeyInfo =
	Instance.new(
		"TextLabel"
	)

KeyInfo.AnchorPoint =
	Vector2.new(
		0.5,
		1
	)

KeyInfo.Position =
	UDim2.new(
		0.5,
		0,
		1,
		-17
	)

KeyInfo.Size =
	UDim2.new(
		1,
		-20,
		0,
		40
	)

KeyInfo.BackgroundTransparency =
	1

KeyInfo.Text =
	"RIGHT SHIFT\nABRIR / FECHAR"

KeyInfo.TextColor3 =
	COLOR.Text3

KeyInfo.TextSize =
	8

KeyInfo.FontFace =
	FONT_MEDIUM

KeyInfo.TextWrapped =
	true

KeyInfo.Parent =
	Sidebar

------------------------------------------------------------
-- CONTENT
------------------------------------------------------------

local Content =
	Instance.new(
		"Frame"
	)

Content.Position =
	UDim2.new(

		0,

		CONFIG.SidebarWidth,

		0,

		0
	)

Content.Size =
	UDim2.new(

		1,

		-CONFIG.SidebarWidth,

		1,

		0
	)

Content.BackgroundTransparency =
	1

Content.ZIndex =
	3

Content.Parent =
	Main

------------------------------------------------------------
-- HEADER / DRAG AREA
------------------------------------------------------------

local Header =
	Instance.new(
		"Frame"
	)

Header.Name =
	"DragArea"

Header.Size =
	UDim2.new(
		1,
		0,
		0,
		76
	)

Header.BackgroundTransparency =
	1

Header.Active =
	true

Header.ZIndex =
	4

Header.Parent =
	Content

------------------------------------------------------------
-- HEADER SMALL TEXT
------------------------------------------------------------

local HeaderSmall =
	Instance.new(
		"TextLabel"
	)

HeaderSmall.Position =
	UDim2.fromOffset(
		25,
		16
	)

HeaderSmall.Size =
	UDim2.fromOffset(
		300,
		15
	)

HeaderSmall.BackgroundTransparency =
	1

HeaderSmall.Text =
	"CONTROLE LOCAL"

HeaderSmall.TextColor3 =
	COLOR.Text3

HeaderSmall.TextSize =
	9

HeaderSmall.FontFace =
	FONT_MEDIUM

HeaderSmall.TextXAlignment =
	Enum.TextXAlignment.Left

HeaderSmall.Parent =
	Header

------------------------------------------------------------
-- HEADER TITLE
------------------------------------------------------------

local HeaderTitle =
	Instance.new(
		"TextLabel"
	)

HeaderTitle.Position =
	UDim2.fromOffset(
		24,
		31
	)

HeaderTitle.Size =
	UDim2.fromOffset(
		260,
		30
	)

HeaderTitle.BackgroundTransparency =
	1

HeaderTitle.Text =
	"PRINCIPAL"

HeaderTitle.TextColor3 =
	COLOR.Accent

HeaderTitle.TextSize =
	20

HeaderTitle.FontFace =
	FONT_BOLD

HeaderTitle.TextXAlignment =
	Enum.TextXAlignment.Left

HeaderTitle.Parent =
	Header

------------------------------------------------------------
-- MINIMIZE BUTTON
------------------------------------------------------------

local Minimize =
	Instance.new(
		"TextButton"
	)

Minimize.AnchorPoint =
	Vector2.new(
		1,
		0
	)

Minimize.Position =
	UDim2.new(
		1,
		-21,
		0,
		21
	)

Minimize.Size =
	UDim2.fromOffset(
		39,
		34
	)

Minimize.BackgroundColor3 =
	COLOR.Control

Minimize.BorderSizePixel =
	0

Minimize.Text =
	"—"

Minimize.TextColor3 =
	COLOR.Accent

Minimize.TextSize =
	19

Minimize.FontFace =
	FONT_BOLD

Minimize.AutoButtonColor =
	false

Minimize.ZIndex =
	10

Minimize.Parent =
	Header

AddCorner(
	Minimize,
	9
)

local MinimizeStroke =
	AddStroke(

	Minimize,

	COLOR.Stroke,

	1,

	0.1
)

------------------------------------------------------------
-- CONTENT SCROLL
------------------------------------------------------------

local Scroll =
	Instance.new(
		"ScrollingFrame"
	)

Scroll.Position =
	UDim2.fromOffset(
		22,
		76
	)

Scroll.Size =
	UDim2.new(
		1,
		-32,
		1,
		-91
	)

Scroll.BackgroundTransparency =
	1

Scroll.BorderSizePixel =
	0

Scroll.ScrollBarThickness =
	3

Scroll.ScrollBarImageColor3 =
	COLOR.Accent

Scroll.ScrollBarImageTransparency =
	0.18

Scroll.AutomaticCanvasSize =
	Enum.AutomaticSize.Y

Scroll.CanvasSize =
	UDim2.fromOffset(
		0,
		0
	)

Scroll.ScrollingDirection =
	Enum.ScrollingDirection.Y

Scroll.ZIndex =
	4

Scroll.Parent =
	Content

------------------------------------------------------------
-- RIGHT PADDING
------------------------------------------------------------

local ScrollPadding =
	Instance.new(
		"UIPadding"
	)

ScrollPadding.PaddingRight =
	UDim.new(
		0,
		10
	)

ScrollPadding.Parent =
	Scroll

------------------------------------------------------------
-- LIST
------------------------------------------------------------

local ScrollList =
	Instance.new(
		"UIListLayout"
	)

ScrollList.Padding =
	UDim.new(
		0,
		12
	)

ScrollList.SortOrder =
	Enum.SortOrder.LayoutOrder

ScrollList.Parent =
	Scroll

------------------------------------------------------------
-- SECTION LABEL
------------------------------------------------------------

local Section =
	Instance.new(
		"TextLabel"
	)

Section.Size =
	UDim2.new(
		1,
		0,
		0,
		22
	)

Section.BackgroundTransparency =
	1

Section.Text =
	"UTILIDADES"

Section.TextColor3 =
	COLOR.Text3

Section.TextSize =
	9

Section.FontFace =
	FONT_BOLD

Section.TextXAlignment =
	Enum.TextXAlignment.Left

Section.Parent =
	Scroll

------------------------------------------------------------
-- CARD CREATOR
------------------------------------------------------------

local function CreateCard(
	title,
	description
)

	local Card =
		Instance.new(
			"Frame"
		)

	Card.Size =
		UDim2.new(
			1,
			0,
			0,
			76
		)

	Card.BackgroundColor3 =
		COLOR.Card

	Card.BorderSizePixel =
		0

	Card.ZIndex =
		5

	Card.Parent =
		Scroll

	AddCorner(
		Card,
		11
	)

	local CardStroke =
		AddStroke(

		Card,

		COLOR.StrokeSoft,

		1,

		0.08
	)

	--------------------------------------------------------
	-- LEFT ACCENT DOT
	--------------------------------------------------------

	local Dot =
		Instance.new(
			"Frame"
		)

	Dot.Position =
		UDim2.fromOffset(
			17,
			21
		)

	Dot.Size =
		UDim2.fromOffset(
			6,
			34
		)

	Dot.BackgroundColor3 =
		COLOR.Accent

	Dot.BorderSizePixel =
		0

	Dot.Parent =
		Card

	AddCorner(
		Dot,
		3
	)

	--------------------------------------------------------
	-- TITLE
	--------------------------------------------------------

	local Title =
		Instance.new(
			"TextLabel"
		)

	Title.Position =
		UDim2.fromOffset(
			35,
			15
		)

	Title.Size =
		UDim2.new(
			1,
			-205,
			0,
			25
		)

	Title.BackgroundTransparency =
		1

	Title.Text =
		title

	Title.TextColor3 =
		COLOR.Text

	Title.TextSize =
		15

	Title.FontFace =
		FONT_MEDIUM

	Title.TextXAlignment =
		Enum.TextXAlignment.Left

	Title.Parent =
		Card

	--------------------------------------------------------
	-- DESCRIPTION
	--------------------------------------------------------

	local Description =
		Instance.new(
			"TextLabel"
		)

	Description.Position =
		UDim2.fromOffset(
			35,
			42
		)

	Description.Size =
		UDim2.new(
			1,
			-205,
			0,
			18
		)

	Description.BackgroundTransparency =
		1

	Description.Text =
		description

	Description.TextColor3 =
		COLOR.Text2

	Description.TextSize =
		10

	Description.FontFace =
		FONT_REGULAR

	Description.TextXAlignment =
		Enum.TextXAlignment.Left

	Description.Parent =
		Card

	--------------------------------------------------------
	-- HOVER
	--------------------------------------------------------

	Card.MouseEnter:Connect(
		function()

			Tween(
				Card,
				0.13,
				{
					BackgroundColor3 =
						COLOR.CardHover
				}
			)

			CardStroke.Color =
				COLOR.Stroke

		end
	)

	Card.MouseLeave:Connect(
		function()

			Tween(
				Card,
				0.13,
				{
					BackgroundColor3 =
						COLOR.Card
				}
			)

			CardStroke.Color =
				COLOR.StrokeSoft

		end
	)

	return Card,
		Title,
		Description

end

------------------------------------------------------------
-- ELEVATOR
------------------------------------------------------------

local ElevatorCard,
	ElevatorTitle,
	ElevatorDescription =
	CreateCard(

		"ELEVADOR",

		"Desativado"
	)

------------------------------------------------------------
-- ELEVATOR CONTROLS
------------------------------------------------------------

local ElevatorControls =
	Instance.new(
		"Frame"
	)

ElevatorControls.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

ElevatorControls.Position =
	UDim2.new(
		1,
		-15,
		0.5,
		0
	)

ElevatorControls.Size =
	UDim2.fromOffset(
		161,
		42
	)

ElevatorControls.BackgroundTransparency =
	1

ElevatorControls.ZIndex =
	7

ElevatorControls.Parent =
	ElevatorCard

------------------------------------------------------------
-- MINUS
------------------------------------------------------------

local Minus =
	Instance.new(
		"TextButton"
	)

Minus.Position =
	UDim2.fromOffset(
		0,
		0
	)

Minus.Size =
	UDim2.fromOffset(
		42,
		42
	)

Minus.BackgroundColor3 =
	COLOR.Control

Minus.BorderSizePixel =
	0

Minus.Text =
	"−"

Minus.TextColor3 =
	COLOR.Text

Minus.TextSize =
	23

Minus.FontFace =
	FONT_BOLD

Minus.AutoButtonColor =
	false

Minus.Parent =
	ElevatorControls

AddCorner(
	Minus,
	9
)

AddStroke(

	Minus,

	COLOR.Stroke,

	1,

	0.1
)

------------------------------------------------------------
-- LEVEL BOX
------------------------------------------------------------

local LevelBox =
	Instance.new(
		"Frame"
	)

LevelBox.Position =
	UDim2.fromOffset(
		49,
		0
	)

LevelBox.Size =
	UDim2.fromOffset(
		63,
		42
	)

LevelBox.BackgroundColor3 =
	Color3.fromRGB(
		238,
		242,
		247
	)

LevelBox.BorderSizePixel =
	0

LevelBox.Parent =
	ElevatorControls

AddCorner(
	LevelBox,
	9
)

------------------------------------------------------------
-- LEVEL TEXT
------------------------------------------------------------

local LevelText =
	Instance.new(
		"TextLabel"
	)

LevelText.Size =
	UDim2.fromScale(
		1,
		1
	)

LevelText.BackgroundTransparency =
	1

LevelText.Text =
	"0"

LevelText.TextColor3 =
	Color3.fromRGB(
		16,
		21,
		28
	)

LevelText.TextSize =
	14

LevelText.FontFace =
	FONT_BOLD

LevelText.Parent =
	LevelBox

------------------------------------------------------------
-- PLUS
------------------------------------------------------------

local Plus =
	Instance.new(
		"TextButton"
	)

Plus.Position =
	UDim2.fromOffset(
		119,
		0
	)

Plus.Size =
	UDim2.fromOffset(
		42,
		42
	)

Plus.BackgroundColor3 =
	COLOR.Accent

Plus.BorderSizePixel =
	0

Plus.Text =
	"+"

Plus.TextColor3 =
	COLOR.White

Plus.TextSize =
	23

Plus.FontFace =
	FONT_BOLD

Plus.AutoButtonColor =
	false

Plus.Parent =
	ElevatorControls

AddCorner(
	Plus,
	9
)

------------------------------------------------------------
-- UPDATE ELEVATOR TEXT
------------------------------------------------------------

local function UpdateElevatorUI()

	LevelText.Text =
		tostring(
			Level
		)

	if not Platform then

		ElevatorDescription.Text =
			"Desativado"

	else

		local Height =
			math.max(
				Level - 1,
				0
			)
			* CONFIG.StepHeight

		ElevatorDescription.Text =
			"Nível "
			.. Level
			.. "  •  "
			.. string.format(
				"%.1f studs",
				Height
			)

	end

end

------------------------------------------------------------
-- PLUS FUNCTION
------------------------------------------------------------

Plus.MouseButton1Click:Connect(
	function()

		if not Root then
			return
		end

		----------------------------------------------------
		-- PRIMEIRO +
		-- só cria debaixo do player
		----------------------------------------------------

		if not Platform then

			CreatePlatform()

			Level = 1

			TargetY =
				BaseY

			UpdateElevatorUI()

			return

		end

		----------------------------------------------------

		if Level >=
			CONFIG.MaxLevel
		then

			return

		end

		Level += 1

		TargetY =
			BaseY
			+ (
				Level - 1
			)
			* CONFIG.StepHeight

		UpdateElevatorUI()

	end
)

------------------------------------------------------------
-- MINUS FUNCTION
------------------------------------------------------------

Minus.MouseButton1Click:Connect(
	function()

		if not Platform then
			return
		end

		if Level > 1 then

			Level -= 1

			TargetY =
				BaseY
				+ (
					Level - 1
				)
				* CONFIG.StepHeight

			UpdateElevatorUI()

			return

		end

		RemovePlatform()

		UpdateElevatorUI()

	end
)

------------------------------------------------------------
-- DESCNY CARD
------------------------------------------------------------

local DescnyCard,
	DescnyTitle,
	DescnyDescription =
	CreateCard(

		"DESCNY",

		"Procura a capa ou item de invisibilidade"
	)

------------------------------------------------------------
-- DESCNY BUTTON
------------------------------------------------------------

local DescnyButton =
	Instance.new(
		"TextButton"
	)

DescnyButton.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

DescnyButton.Position =
	UDim2.new(
		1,
		-15,
		0.5,
		0
	)

DescnyButton.Size =
	UDim2.fromOffset(
		125,
		42
	)

DescnyButton.BackgroundColor3 =
	COLOR.Control

DescnyButton.BorderSizePixel =
	0

DescnyButton.Text =
	"ATIVAR"

DescnyButton.TextColor3 =
	COLOR.Text

DescnyButton.TextSize =
	11

DescnyButton.FontFace =
	FONT_BOLD

DescnyButton.AutoButtonColor =
	false

DescnyButton.Parent =
	DescnyCard

AddCorner(
	DescnyButton,
	9
)

local DescnyStroke =
	AddStroke(

	DescnyButton,

	COLOR.Stroke,

	1,

	0.1
)

------------------------------------------------------------
-- DESCNY CLICK
------------------------------------------------------------

DescnyButton.MouseButton1Click:Connect(
	function()

		DescnyButton.Text =
			"PROCURANDO"

		DescnyButton.TextColor3 =
			COLOR.Text2

		local Success,
			Result =
			ActivateDescny()

		if Success then

			DescnyButton.Text =
				"ATIVADO"

			DescnyButton.TextColor3 =
				COLOR.Green

			DescnyStroke.Color =
				COLOR.Green

			DescnyDescription.Text =
				"Usando "
				.. tostring(
					Result
				)

			task.delay(
				1.3,
				function()

					if DescnyButton.Parent then

						DescnyButton.Text =
							"ATIVAR"

						DescnyButton.TextColor3 =
							COLOR.Text

						DescnyStroke.Color =
							COLOR.Stroke

					end

				end
			)

		else

			DescnyButton.Text =
				"NÃO ACHOU"

			DescnyButton.TextColor3 =
				COLOR.Red

			DescnyStroke.Color =
				COLOR.Red

			DescnyDescription.Text =
				Result

			task.delay(
				1.3,
				function()

					if DescnyButton.Parent then

						DescnyButton.Text =
							"ATIVAR"

						DescnyButton.TextColor3 =
							COLOR.Text

						DescnyStroke.Color =
							COLOR.Stroke

					end

				end
			)

		end

	end
)

------------------------------------------------------------
-- ANTILAG CARD
------------------------------------------------------------

local AntiLagCard,
	AntiLagTitle,
	AntiLagDescription =
	CreateCard(

		"ANTILAG",

		"Reduz partículas, efeitos e sombras"
	)

------------------------------------------------------------
-- TOGGLE HOLDER
------------------------------------------------------------

local AntiTrack =
	Instance.new(
		"TextButton"
	)

AntiTrack.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

AntiTrack.Position =
	UDim2.new(
		1,
		-15,
		0.5,
		0
	)

AntiTrack.Size =
	UDim2.fromOffset(
		64,
		32
	)

AntiTrack.BackgroundColor3 =
	COLOR.Control

AntiTrack.BorderSizePixel =
	0

AntiTrack.Text =
	""

AntiTrack.AutoButtonColor =
	false

AntiTrack.Parent =
	AntiLagCard

AddCorner(
	AntiTrack,
	16
)

local AntiStroke =
	AddStroke(

	AntiTrack,

	COLOR.Stroke,

	1,

	0.05
)

------------------------------------------------------------
-- TOGGLE DOT
------------------------------------------------------------

local AntiDot =
	Instance.new(
		"Frame"
	)

AntiDot.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

AntiDot.Position =
	UDim2.fromOffset(
		17,
		16
	)

AntiDot.Size =
	UDim2.fromOffset(
		22,
		22
	)

AntiDot.BackgroundColor3 =
	COLOR.Text2

AntiDot.BorderSizePixel =
	0

AntiDot.Parent =
	AntiTrack

AddCorner(
	AntiDot,
	11
)

------------------------------------------------------------
-- ANTILAG TOGGLE
------------------------------------------------------------

local function UpdateAntiLagUI()

	if AntiLagEnabled then

		Tween(
			AntiTrack,
			0.17,
			{
				BackgroundColor3 =
					COLOR.Accent
			}
		)

		Tween(
			AntiDot,
			0.17,
			{
				Position =
					UDim2.fromOffset(
						47,
						16
					),

				BackgroundColor3 =
					COLOR.White
			}
		)

		AntiStroke.Color =
			COLOR.Accent2

		AntiLagDescription.Text =
			"Otimização ativada"

	else

		Tween(
			AntiTrack,
			0.17,
			{
				BackgroundColor3 =
					COLOR.Control
			}
		)

		Tween(
			AntiDot,
			0.17,
			{
				Position =
					UDim2.fromOffset(
						17,
						16
					),

				BackgroundColor3 =
					COLOR.Text2
			}
		)

		AntiStroke.Color =
			COLOR.Stroke

		AntiLagDescription.Text =
			"Reduz partículas, efeitos e sombras"

	end

end

------------------------------------------------------------

AntiTrack.MouseButton1Click:Connect(
	function()

		if AntiLagEnabled then

			DisableAntiLag()

		else

			EnableAntiLag()

		end

		UpdateAntiLagUI()

	end
)

------------------------------------------------------------
-- FOOTER
------------------------------------------------------------

local Footer =
	Instance.new(
		"TextLabel"
	)

Footer.Size =
	UDim2.new(
		1,
		0,
		0,
		30
	)

Footer.BackgroundTransparency =
	1

Footer.Text =
	"Local utilities  •  PC"

Footer.TextColor3 =
	COLOR.Text3

Footer.TextSize =
	9

Footer.FontFace =
	FONT_REGULAR

Footer.TextXAlignment =
	Enum.TextXAlignment.Left

Footer.Parent =
	Scroll

------------------------------------------------------------
-- FLOATING BUTTON
------------------------------------------------------------

local Mini =
	Instance.new(
		"TextButton"
	)

Mini.Name =
	"FloatingLogo"

-- posição inicial:
-- esquerda da tela, não no meio
Mini.Position =
	UDim2.fromOffset(
		28,
		175
	)

Mini.Size =
	UDim2.fromOffset(
		62,
		62
	)

Mini.BackgroundColor3 =
	Color3.fromRGB(
		8,
		12,
		19
	)

Mini.BorderSizePixel =
	0

Mini.Text =
	""

Mini.Active =
	true

Mini.AutoButtonColor =
	false

Mini.Selectable =
	false

Mini.Visible =
	false

Mini.ZIndex =
	200

Mini.Parent =
	GUI

AddCorner(
	Mini,
	31
)

local MiniStroke =
	AddStroke(

	Mini,

	COLOR.Accent,

	2,

	0.05
)

------------------------------------------------------------
-- MINI FALLBACK
------------------------------------------------------------

local MiniFallback =
	Instance.new(
		"TextLabel"
	)

MiniFallback.Size =
	UDim2.fromScale(
		1,
		1
	)

MiniFallback.BackgroundTransparency =
	1

MiniFallback.Text =
	"S"

MiniFallback.TextColor3 =
	COLOR.Accent

MiniFallback.TextSize =
	28

MiniFallback.FontFace =
	FONT_BOLD

MiniFallback.ZIndex =
	201

MiniFallback.Parent =
	Mini

------------------------------------------------------------
-- MINI LOGO
------------------------------------------------------------

local MiniLogo =
	Instance.new(
		"ImageLabel"
	)

MiniLogo.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

MiniLogo.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

MiniLogo.Size =
	UDim2.fromOffset(
		52,
		52
	)

MiniLogo.BackgroundTransparency =
	1

MiniLogo.Image =
	CONFIG.Logo

MiniLogo.ScaleType =
	Enum.ScaleType.Fit

MiniLogo.ZIndex =
	202

MiniLogo.Parent =
	Mini

------------------------------------------------------------
-- STATE
------------------------------------------------------------

local Minimized =
	false

------------------------------------------------------------
-- MINIMIZE
------------------------------------------------------------

local function MinimizeUI()

	if Minimized then
		return
	end

	Minimized =
		true

	local CurrentMainPosition =
		Main.AbsolutePosition

	--------------------------------------------------------
	-- mantém a bolinha perto da janela na primeira vez
	--------------------------------------------------------

	if not Mini.Visible then

		local X =
			math.max(
				10,
				CurrentMainPosition.X
				- 76
			)

		local Y =
			CurrentMainPosition.Y
			+ 20

		Mini.Position =
			UDim2.fromOffset(
				X,
				Y
			)

	end

	Main.Visible =
		false

	Shadow.Visible =
		false

	Mini.Visible =
		true

	Mini.BackgroundTransparency =
		1

	Tween(
		Mini,
		0.16,
		{
			BackgroundTransparency =
				0
		}
	)

end

------------------------------------------------------------
-- RESTORE
------------------------------------------------------------

local function RestoreUI()

	if not Minimized then
		return
	end

	Minimized =
		false

	Mini.Visible =
		false

	Main.Visible =
		true

	Shadow.Visible =
		true

end

------------------------------------------------------------
-- MINIMIZE CLICK
------------------------------------------------------------

Minimize.MouseButton1Click:Connect(
	function()

		MinimizeUI()

	end
)

------------------------------------------------------------
-- RIGHT SHIFT SAFETY
------------------------------------------------------------

UIS.InputBegan:Connect(
	function(input, processed)

		if processed then
			return
		end

		if input.KeyCode ==
			Enum.KeyCode.RightShift
		then

			if Minimized then

				RestoreUI()

			else

				MinimizeUI()

			end

		end

	end
)

------------------------------------------------------------
-- CLAMP POSITION HELPER
------------------------------------------------------------

local function ClampToScreen(
	target,
	x,
	y
)

	local viewport =
		Camera.ViewportSize

	local width =
		target.AbsoluteSize.X

	local height =
		target.AbsoluteSize.Y

	x =
		math.clamp(

			x,

			6,

			math.max(
				6,
				viewport.X
				- width
				- 6
			)
		)

	y =
		math.clamp(

			y,

			6,

			math.max(
				6,
				viewport.Y
				- height
				- 6
			)
		)

	return x,
		y

end

------------------------------------------------------------
-- MAIN WINDOW DRAG
-- absolute pixel based
------------------------------------------------------------

do

	local Dragging =
		false

	local StartMouse

	local StartFrame

	--------------------------------------------------------

	Header.InputBegan:Connect(
		function(input)

			if input.UserInputType
				~= Enum.UserInputType.MouseButton1
			then

				return

			end

			Dragging =
				true

			StartMouse =
				UIS:GetMouseLocation()

			StartFrame =
				Vector2.new(

					Main.AbsolutePosition.X,

					Main.AbsolutePosition.Y
				)

		end
	)

	--------------------------------------------------------

	UIS.InputChanged:Connect(
		function(input)

			if not Dragging then
				return
			end

			if input.UserInputType
				~= Enum.UserInputType.MouseMovement
			then

				return

			end

			local Mouse =
				UIS:GetMouseLocation()

			local Delta =
				Mouse
				- StartMouse

			local X =
				StartFrame.X
				+ Delta.X

			local Y =
				StartFrame.Y
				+ Delta.Y

			X, Y =
				ClampToScreen(
					Main,
					X,
					Y
				)

			Main.Position =
				UDim2.fromOffset(
					X,
					Y
				)

			Shadow.Position =
				UDim2.fromOffset(
					X + 9,
					Y + 11
				)

		end
	)

	--------------------------------------------------------

	UIS.InputEnded:Connect(
		function(input)

			if input.UserInputType
				== Enum.UserInputType.MouseButton1
			then

				Dragging =
					false

			end

		end
	)

end

------------------------------------------------------------
-- MINI DRAG
-- REBUILT COMPLETELY
------------------------------------------------------------

do

	local Dragging =
		false

	local Moved =
		false

	local StartMouse

	local StartButton

	local Threshold =
		5

	--------------------------------------------------------
	-- MOUSE DOWN DIRECTLY ON TEXTBUTTON
	--------------------------------------------------------

	Mini.InputBegan:Connect(
		function(input)

			if input.UserInputType
				~= Enum.UserInputType.MouseButton1
			then

				return

			end

			Dragging =
				true

			Moved =
				false

			StartMouse =
				UIS:GetMouseLocation()

			StartButton =
				Vector2.new(

					Mini.AbsolutePosition.X,

					Mini.AbsolutePosition.Y
				)

		end
	)

	--------------------------------------------------------
	-- MOVE
	--------------------------------------------------------

	UIS.InputChanged:Connect(
		function(input)

			if not Dragging then
				return
			end

			if input.UserInputType
				~= Enum.UserInputType.MouseMovement
			then

				return

			end

			local Mouse =
				UIS:GetMouseLocation()

			local Delta =
				Mouse
				- StartMouse

			------------------------------------------------
			-- SE MEXEU MAIS DE 5 PIXELS = DRAG
			------------------------------------------------

			if Delta.Magnitude
				>= Threshold
			then

				Moved =
					true

			end

			if not Moved then
				return
			end

			local X =
				StartButton.X
				+ Delta.X

			local Y =
				StartButton.Y
				+ Delta.Y

			X, Y =
				ClampToScreen(
					Mini,
					X,
					Y
				)

			Mini.Position =
				UDim2.fromOffset(
					X,
					Y
				)

		end
	)

	--------------------------------------------------------
	-- RELEASE
	--------------------------------------------------------

	UIS.InputEnded:Connect(
		function(input)

			if input.UserInputType
				~= Enum.UserInputType.MouseButton1
			then

				return

			end

			if not Dragging then
				return
			end

			Dragging =
				false

			------------------------------------------------
			-- NÃO MOVEU = FOI CLIQUE
			------------------------------------------------

			if not Moved then

				RestoreUI()

			end

		end
	)

end

------------------------------------------------------------
-- MINI HOVER
------------------------------------------------------------

Mini.MouseEnter:Connect(
	function()

		Tween(
			Mini,
			0.13,
			{
				BackgroundColor3 =
					Color3.fromRGB(
						18,
						22,
						31
					)
			}
		)

		MiniStroke.Thickness =
			2.5

	end
)

------------------------------------------------------------

Mini.MouseLeave:Connect(
	function()

		Tween(
			Mini,
			0.13,
			{
				BackgroundColor3 =
					Color3.fromRGB(
						8,
						12,
						19
					)
			}
		)

		MiniStroke.Thickness =
			2

	end
)

------------------------------------------------------------
-- MINIMIZE HOVER
------------------------------------------------------------

Minimize.MouseEnter:Connect(
	function()

		Tween(
			Minimize,
			0.12,
			{
				BackgroundColor3 =
					COLOR.CardHover
			}
		)

		MinimizeStroke.Color =
			COLOR.Accent

	end
)

------------------------------------------------------------

Minimize.MouseLeave:Connect(
	function()

		Tween(
			Minimize,
			0.12,
			{
				BackgroundColor3 =
					COLOR.Control
			}
		)

		MinimizeStroke.Color =
			COLOR.Stroke

	end
)

------------------------------------------------------------
-- RESPAWN
------------------------------------------------------------

Player.CharacterRemoving:Connect(
	function()

		RemovePlatform()

		UpdateElevatorUI()

	end
)

------------------------------------------------------------
-- FINISH
------------------------------------------------------------

UpdateElevatorUI()

UpdateAntiLagUI()
