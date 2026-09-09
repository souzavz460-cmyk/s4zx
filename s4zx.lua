--[[
    SOUZA MOBILE PANEL V6
    LocalScript
    StarterPlayer > StarterPlayerScripts

    MOBILE FIRST:
    - Touch drag
    - Touch tap
    - Responsive UI
    - Floating button movable
    - Floating button clickable
    - Position persists after minimizing

    ABAS:
    - Principal
    - Visuais
    - Diversos
    - Ajustes

    PRINCIPAL:
    - Elevador
    - DESCNY
    - AntiLag
]]

------------------------------------------------------------
-- SERVICES
------------------------------------------------------------

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

------------------------------------------------------------
-- PLAYER
------------------------------------------------------------

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Camera = workspace.CurrentCamera

while not Camera do
	task.wait()
	Camera = workspace.CurrentCamera
end

------------------------------------------------------------
-- CONFIG
------------------------------------------------------------

local CONFIG = {

	Logo =
		"rbxthumb://type=Asset&id=98880379063768&w=420&h=420",

	PanelWidth = 690,
	PanelHeight = 420,

	SidebarWidth = 155,

	PlatformSize =
		Vector3.new(
			6.5,
			0.65,
			6.5
		),

	StepHeight = 2.15,

	MaxLevel = 25,

	PlatformSpeed = 8,
}

------------------------------------------------------------
-- COLORS
------------------------------------------------------------

local COLORS = {

	Background =
		Color3.fromRGB(
			5,
			9,
			15
		),

	Background2 =
		Color3.fromRGB(
			8,
			14,
			23
		),

	Background3 =
		Color3.fromRGB(
			11,
			18,
			29
		),

	Sidebar =
		Color3.fromRGB(
			3,
			7,
			12
		),

	SidebarHover =
		Color3.fromRGB(
			14,
			20,
			29
		),

	Card =
		Color3.fromRGB(
			18,
			28,
			40
		),

	CardHover =
		Color3.fromRGB(
			23,
			35,
			49
		),

	ButtonDark =
		Color3.fromRGB(
			8,
			16,
			26
		),

	Accent =
		Color3.fromRGB(
			255,
			75,
			22
		),

	Accent2 =
		Color3.fromRGB(
			255,
			113,
			43
		),

	Text =
		Color3.fromRGB(
			245,
			247,
			250
		),

	TextSecondary =
		Color3.fromRGB(
			161,
			171,
			185
		),

	TextMuted =
		Color3.fromRGB(
			95,
			108,
			126
		),

	Stroke =
		Color3.fromRGB(
			35,
			47,
			62
		),

	StrokeSoft =
		Color3.fromRGB(
			25,
			36,
			49
		),

	Green =
		Color3.fromRGB(
			72,
			220,
			143
		),

	Red =
		Color3.fromRGB(
			240,
			75,
			94
		),

	White =
		Color3.fromRGB(
			250,
			250,
			252
		),
}

------------------------------------------------------------
-- FONTS
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
-- CLEANUP
------------------------------------------------------------

local old =
	PlayerGui:FindFirstChild(
		"SouzaMobilePanel"
	)

if old then
	old:Destroy()
end

local oldPlatform =
	workspace:FindFirstChild(
		"SouzaMobilePlatform_"
		.. Player.UserId
	)

if oldPlatform then
	oldPlatform:Destroy()
end

------------------------------------------------------------
-- HELPERS
------------------------------------------------------------

local function Corner(
	object,
	radius
)

	local value =
		Instance.new("UICorner")

	value.CornerRadius =
		UDim.new(
			0,
			radius
		)

	value.Parent =
		object

	return value
end

------------------------------------------------------------

local function Stroke(
	object,
	color,
	thickness,
	transparency
)

	local value =
		Instance.new("UIStroke")

	value.Color =
		color or COLORS.Stroke

	value.Thickness =
		thickness or 1

	value.Transparency =
		transparency or 0

	value.Parent =
		object

	return value
end

------------------------------------------------------------

local function Tween(
	object,
	time,
	properties
)

	local tween =
		TweenService:Create(
			object,

			TweenInfo.new(
				time,
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

local function SetupCharacter(character)

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

		task.wait(0.15)

		SetupCharacter(
			character
		)

	end
)

------------------------------------------------------------
-- ELEVATOR
------------------------------------------------------------

local Platform = nil

local Level = 0

local BaseY = 0
local CurrentY = 0
local TargetY = 0

------------------------------------------------------------

local function GetFeetY()

	if not Root or not Humanoid then
		return 0
	end

	return Root.Position.Y
		- Humanoid.HipHeight
		- Root.Size.Y / 2

end

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

	BaseY =
		GetFeetY()
		- CONFIG.PlatformSize.Y / 2
		- 0.04

	CurrentY =
		BaseY

	TargetY =
		BaseY

	--------------------------------------------------------
	-- PLATFORM
	--------------------------------------------------------

	Platform =
		Instance.new("Part")

	Platform.Name =
		"SouzaMobilePlatform_"
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
			11,
			16,
			24
		)

	Platform.Transparency =
		0.03

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
	-- SURFACE
	--------------------------------------------------------

	local surface =
		Instance.new("SurfaceGui")

	surface.Face =
		Enum.NormalId.Top

	surface.SizingMode =
		Enum.SurfaceGuiSizingMode.PixelsPerStud

	surface.PixelsPerStud =
		45

	surface.LightInfluence =
		0

	surface.Parent =
		Platform

	--------------------------------------------------------

	local background =
		Instance.new("Frame")

	background.Size =
		UDim2.fromScale(
			1,
			1
		)

	background.BackgroundColor3 =
		Color3.fromRGB(
			7,
			12,
			20
		)

	background.BorderSizePixel =
		0

	background.Parent =
		surface

	--------------------------------------------------------

	local gradient =
		Instance.new("UIGradient")

	gradient.Rotation =
		35

	gradient.Color =
		ColorSequence.new({

			ColorSequenceKeypoint.new(
				0,
				Color3.fromRGB(
					46,
					23,
					17
				)
			),

			ColorSequenceKeypoint.new(
				0.45,
				Color3.fromRGB(
					9,
					15,
					24
				)
			),

			ColorSequenceKeypoint.new(
				1,
				Color3.fromRGB(
					22,
					13,
					13
				)
			),

		})

	gradient.Parent =
		background

	--------------------------------------------------------

	local border =
		Instance.new("UIStroke")

	border.Color =
		COLORS.Accent

	border.Thickness =
		3

	border.Transparency =
		0.05

	border.Parent =
		background

	--------------------------------------------------------
	-- FALLBACK S
	--------------------------------------------------------

	local fallback =
		Instance.new("TextLabel")

	fallback.Size =
		UDim2.fromScale(
			1,
			1
		)

	fallback.BackgroundTransparency =
		1

	fallback.Text =
		"S"

	fallback.TextColor3 =
		COLORS.Accent

	fallback.TextTransparency =
		0.75

	fallback.TextScaled =
		true

	fallback.FontFace =
		FONT_BOLD

	fallback.Parent =
		background

	--------------------------------------------------------
	-- LOGO
	--------------------------------------------------------

	local logo =
		Instance.new("ImageLabel")

	logo.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	logo.Position =
		UDim2.fromScale(
			0.5,
			0.5
		)

	logo.Size =
		UDim2.fromScale(
			0.58,
			0.58
		)

	logo.BackgroundTransparency =
		1

	logo.Image =
		CONFIG.Logo

	logo.ScaleType =
		Enum.ScaleType.Fit

	logo.Parent =
		background

end

------------------------------------------------------------

local function RemovePlatform()

	Level = 0

	if Platform then

		Platform:Destroy()

		Platform = nil

	end

end

------------------------------------------------------------
-- FOLLOW LOOP
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
				-CONFIG.PlatformSpeed
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
-- DESCNY
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

	if not object:IsA("Tool") then
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

	local name =
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
			name,
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

local function FindInvisibleTool()

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

	local tool =
		FindInvisibleTool()

	if not tool then

		return false,
			"Item não encontrado"

	end

	if tool.Parent ~= Character then

		pcall(
			function()

				Humanoid:EquipTool(
					tool
				)

			end
		)

		task.wait(
			0.1
		)

	end

	local success =
		pcall(
			function()

				tool:Activate()

			end
		)

	if success then

		return true,
			tool.Name

	end

	return false,
		"Falha ao ativar"
end

------------------------------------------------------------
-- ANTILAG
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

	local success,
		value =
		pcall(
			function()

				return object[
					property
				]

			end
		)

	if success then

		AntiLagCache[
			object
		][property] =
			value

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
		or object:IsA(
			"Trail"
		)
		or object:IsA(
			"Beam"
		)
		or object:IsA(
			"Smoke"
		)
		or object:IsA(
			"Fire"
		)
		or object:IsA(
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
		or object:IsA(
			"BlurEffect"
		)
		or object:IsA(
			"SunRaysEffect"
		)
		or object:IsA(
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

			local objects =
				workspace:GetDescendants()

			for index,
				object
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

				if index % 250 == 0 then

					RunService.Heartbeat:Wait()

				end
			end

			for _, object
				in ipairs(
					Lighting:GetDescendants()
				)
			do

				OptimizeObject(
					object
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

						object[property] =
							value

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
	Instance.new("ScreenGui")

GUI.Name =
	"SouzaMobilePanel"

GUI.ResetOnSpawn =
	false

GUI.IgnoreGuiInset =
	false

GUI.ZIndexBehavior =
	Enum.ZIndexBehavior.Sibling

GUI.DisplayOrder =
	999

GUI.Parent =
	PlayerGui

------------------------------------------------------------
-- MAIN
------------------------------------------------------------

local Main =
	Instance.new("Frame")

Main.Name =
	"Main"

Main.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

Main.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

Main.Size =
	UDim2.fromOffset(
		CONFIG.PanelWidth,
		CONFIG.PanelHeight
	)

Main.BackgroundColor3 =
	COLORS.Background

Main.BorderSizePixel =
	0

Main.ClipsDescendants =
	true

Main.Active =
	true

Main.ZIndex =
	10

Main.Parent =
	GUI

Corner(
	Main,
	11
)

Stroke(
	Main,
	COLORS.Stroke,
	1,
	0
)

------------------------------------------------------------
-- RESPONSIVE SCALE
------------------------------------------------------------

local MainScale =
	Instance.new("UIScale")

MainScale.Scale =
	1

MainScale.Parent =
	Main

------------------------------------------------------------

local function UpdateScale()

	local viewport =
		Camera.ViewportSize

	local scaleX =
		viewport.X
		/ 760

	local scaleY =
		viewport.Y
		/ 470

	local scale =
		math.min(
			scaleX,
			scaleY
		)

	MainScale.Scale =
		math.clamp(
			scale,
			0.66,
			1
		)

end

UpdateScale()

Camera:GetPropertyChangedSignal(
	"ViewportSize"
):Connect(
	UpdateScale
)

------------------------------------------------------------
-- MAIN GRADIENT
------------------------------------------------------------

local MainGradient =
	Instance.new("UIGradient")

MainGradient.Rotation =
	115

MainGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,
			Color3.fromRGB(
				15,
				23,
				35
			)
		),

		ColorSequenceKeypoint.new(
			0.42,
			Color3.fromRGB(
				7,
				12,
				20
			)
		),

		ColorSequenceKeypoint.new(
			1,
			Color3.fromRGB(
				14,
				9,
				10
			)
		),

	})

MainGradient.Parent =
	Main

------------------------------------------------------------
-- TOP ACCENT
------------------------------------------------------------

local TopAccent =
	Instance.new("Frame")

TopAccent.Size =
	UDim2.new(
		1,
		0,
		0,
		2
	)

TopAccent.BackgroundColor3 =
	COLORS.Accent

TopAccent.BorderSizePixel =
	0

TopAccent.ZIndex =
	15

TopAccent.Parent =
	Main

------------------------------------------------------------
-- SIDEBAR
------------------------------------------------------------

local Sidebar =
	Instance.new("Frame")

Sidebar.Size =
	UDim2.new(
		0,
		CONFIG.SidebarWidth,
		1,
		0
	)

Sidebar.BackgroundColor3 =
	COLORS.Sidebar

Sidebar.BackgroundTransparency =
	0.04

Sidebar.BorderSizePixel =
	0

Sidebar.ZIndex =
	11

Sidebar.Parent =
	Main

------------------------------------------------------------
-- SIDEBAR GRADIENT
------------------------------------------------------------

local SideGradient =
	Instance.new("UIGradient")

SideGradient.Rotation =
	90

SideGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,
			Color3.fromRGB(
				7,
				12,
				20
			)
		),

		ColorSequenceKeypoint.new(
			1,
			Color3.fromRGB(
				2,
				5,
				9
			)
		)

	})

SideGradient.Parent =
	Sidebar

------------------------------------------------------------
-- LOGO HOLDER
------------------------------------------------------------

local LogoHolder =
	Instance.new("Frame")

LogoHolder.AnchorPoint =
	Vector2.new(
		0.5,
		0
	)

LogoHolder.Position =
	UDim2.new(
		0.5,
		0,
		0,
		20
	)

LogoHolder.Size =
	UDim2.fromOffset(
		58,
		58
	)

LogoHolder.BackgroundColor3 =
	Color3.fromRGB(
		16,
		22,
		31
	)

LogoHolder.BorderSizePixel =
	0

LogoHolder.ZIndex =
	15

LogoHolder.Parent =
	Sidebar

Corner(
	LogoHolder,
	29
)

Stroke(
	LogoHolder,
	COLORS.Accent,
	2,
	0.1
)

------------------------------------------------------------
-- LOGO FALLBACK
------------------------------------------------------------

local LogoFallback =
	Instance.new("TextLabel")

LogoFallback.Size =
	UDim2.fromScale(
		1,
		1
	)

LogoFallback.BackgroundTransparency =
	1

LogoFallback.Text =
	"S"

LogoFallback.TextColor3 =
	COLORS.Accent

LogoFallback.TextSize =
	27

LogoFallback.FontFace =
	FONT_BOLD

LogoFallback.ZIndex =
	16

LogoFallback.Parent =
	LogoHolder

------------------------------------------------------------
-- LOGO IMAGE
------------------------------------------------------------

local LogoImage =
	Instance.new("ImageLabel")

LogoImage.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

LogoImage.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

LogoImage.Size =
	UDim2.fromOffset(
		50,
		50
	)

LogoImage.BackgroundTransparency =
	1

LogoImage.Image =
	CONFIG.Logo

LogoImage.ScaleType =
	Enum.ScaleType.Fit

LogoImage.ZIndex =
	17

LogoImage.Parent =
	LogoHolder

------------------------------------------------------------
-- BRAND
------------------------------------------------------------

local Brand =
	Instance.new("TextLabel")

Brand.Position =
	UDim2.fromOffset(
		0,
		88
	)

Brand.Size =
	UDim2.new(
		1,
		0,
		0,
		22
	)

Brand.BackgroundTransparency =
	1

Brand.Text =
	"SOUZA"

Brand.TextColor3 =
	COLORS.Text

Brand.TextSize =
	14

Brand.FontFace =
	FONT_BOLD

Brand.ZIndex =
	15

Brand.Parent =
	Sidebar

------------------------------------------------------------

local BrandSub =
	Instance.new("TextLabel")

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
		16
	)

BrandSub.BackgroundTransparency =
	1

BrandSub.Text =
	"MOBILE PANEL"

BrandSub.TextColor3 =
	COLORS.TextMuted

BrandSub.TextSize =
	8

BrandSub.FontFace =
	FONT_MEDIUM

BrandSub.ZIndex =
	15

BrandSub.Parent =
	Sidebar

------------------------------------------------------------
-- NAVIGATION
------------------------------------------------------------

local Navigation =
	Instance.new("Frame")

Navigation.Position =
	UDim2.fromOffset(
		10,
		145
	)

Navigation.Size =
	UDim2.new(
		1,
		-20,
		1,
		-160
	)

Navigation.BackgroundTransparency =
	1

Navigation.ZIndex =
	15

Navigation.Parent =
	Sidebar

------------------------------------------------------------

local NavLayout =
	Instance.new("UIListLayout")

NavLayout.Padding =
	UDim.new(
		0,
		8
	)

NavLayout.Parent =
	Navigation

------------------------------------------------------------
-- CONTENT
------------------------------------------------------------

local Content =
	Instance.new("Frame")

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
	11

Content.Parent =
	Main

------------------------------------------------------------
-- HEADER
------------------------------------------------------------

local Header =
	Instance.new("Frame")

Header.Size =
	UDim2.new(
		1,
		0,
		0,
		74
	)

Header.BackgroundTransparency =
	1

Header.Active =
	true

Header.ZIndex =
	20

Header.Parent =
	Content

------------------------------------------------------------

local HeaderSmall =
	Instance.new("TextLabel")

HeaderSmall.Position =
	UDim2.fromOffset(
		25,
		14
	)

HeaderSmall.Size =
	UDim2.fromOffset(
		250,
		16
	)

HeaderSmall.BackgroundTransparency =
	1

HeaderSmall.Text =
	"CONFIGURAÇÕES RÁPIDAS"

HeaderSmall.TextColor3 =
	COLORS.TextMuted

HeaderSmall.TextSize =
	8

HeaderSmall.FontFace =
	FONT_MEDIUM

HeaderSmall.TextXAlignment =
	Enum.TextXAlignment.Left

HeaderSmall.Parent =
	Header

------------------------------------------------------------

local HeaderIcon =
	Instance.new("TextLabel")

HeaderIcon.Position =
	UDim2.fromOffset(
		24,
		33
	)

HeaderIcon.Size =
	UDim2.fromOffset(
		26,
		27
	)

HeaderIcon.BackgroundTransparency =
	1

HeaderIcon.Text =
	"◈"

HeaderIcon.TextColor3 =
	COLORS.Accent

HeaderIcon.TextSize =
	21

HeaderIcon.FontFace =
	FONT_BOLD

HeaderIcon.Parent =
	Header

------------------------------------------------------------

local HeaderTitle =
	Instance.new("TextLabel")

HeaderTitle.Position =
	UDim2.fromOffset(
		57,
		33
	)

HeaderTitle.Size =
	UDim2.fromOffset(
		250,
		27
	)

HeaderTitle.BackgroundTransparency =
	1

HeaderTitle.Text =
	"PRINCIPAL"

HeaderTitle.TextColor3 =
	COLORS.Accent

HeaderTitle.TextSize =
	18

HeaderTitle.FontFace =
	FONT_BOLD

HeaderTitle.TextXAlignment =
	Enum.TextXAlignment.Left

HeaderTitle.Parent =
	Header

------------------------------------------------------------
-- MINIMIZE
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
		-18,
		0.5,
		3
	)

Minimize.Size =
	UDim2.fromOffset(
		40,
		40
	)

Minimize.BackgroundColor3 =
	COLORS.ButtonDark

Minimize.BorderSizePixel =
	0

Minimize.Text =
	"×"

Minimize.TextColor3 =
	COLORS.Accent

Minimize.TextSize =
	28

Minimize.FontFace =
	FONT_MEDIUM

Minimize.AutoButtonColor =
	false

Minimize.ZIndex =
	100

Minimize.Parent =
	Header

Corner(
	Minimize,
	10
)

Stroke(
	Minimize,
	COLORS.Stroke,
	1,
	0
)

------------------------------------------------------------
-- PAGE HOLDER
------------------------------------------------------------

local PageHolder =
	Instance.new("Frame")

PageHolder.Position =
	UDim2.fromOffset(
		20,
		74
	)

PageHolder.Size =
	UDim2.new(
		1,
		-30,
		1,
		-88
	)

PageHolder.BackgroundTransparency =
	1

PageHolder.ZIndex =
	15

PageHolder.Parent =
	Content

------------------------------------------------------------
-- PAGES
------------------------------------------------------------

local Pages =
	{}

local function CreatePage(
	name
)

	local page =
		Instance.new("ScrollingFrame")

	page.Name =
		name

	page.Size =
		UDim2.fromScale(
			1,
			1
		)

	page.BackgroundTransparency =
		1

	page.BorderSizePixel =
		0

	page.ScrollBarThickness =
		3

	page.ScrollBarImageColor3 =
		COLORS.Accent

	page.ScrollBarImageTransparency =
		0.2

	page.CanvasSize =
		UDim2.fromOffset(
			0,
			0
		)

	page.AutomaticCanvasSize =
		Enum.AutomaticSize.Y

	page.ScrollingDirection =
		Enum.ScrollingDirection.Y

	page.Visible =
		false

	page.ZIndex =
		15

	page.Parent =
		PageHolder

	--------------------------------------------------------

	local padding =
		Instance.new("UIPadding")

	padding.PaddingRight =
		UDim.new(
			0,
			10
		)

	padding.Parent =
		page

	--------------------------------------------------------

	local layout =
		Instance.new("UIListLayout")

	layout.Padding =
		UDim.new(
			0,
			11
		)

	layout.SortOrder =
		Enum.SortOrder.LayoutOrder

	layout.Parent =
		page

	Pages[
		name
	] = page

	return page
end

------------------------------------------------------------

local PrincipalPage =
	CreatePage(
		"Principal"
	)

local VisualPage =
	CreatePage(
		"Visuais"
	)

local DiversosPage =
	CreatePage(
		"Diversos"
	)

local AjustesPage =
	CreatePage(
		"Ajustes"
	)

------------------------------------------------------------
-- NAV BUTTONS
------------------------------------------------------------

local NavButtons =
	{}

local PageData = {

	Principal = {
		Icon = "⌂",
		Label = "Principal"
	},

	Visuais = {
		Icon = "◉",
		Label = "Visuais"
	},

	Diversos = {
		Icon = "◇",
		Label = "Diversos"
	},

	Ajustes = {
		Icon = "⚙",
		Label = "Ajustes"
	},
}

------------------------------------------------------------

local Order = {

	"Principal",
	"Visuais",
	"Diversos",
	"Ajustes",
}

------------------------------------------------------------

local function SwitchPage(
	name
)

	for pageName,
		page
		in pairs(
			Pages
		)
	do

		page.Visible =
			pageName == name
	end

	--------------------------------------------------------

	for buttonName,
		data
		in pairs(
			NavButtons
		)
	do

		local active =
			buttonName == name

		Tween(
			data.Button,
			0.15,
			{
				BackgroundTransparency =
					active and 0 or 1
			}
		)

		data.Icon.TextColor3 =
			active
			and COLORS.Accent
			or COLORS.TextSecondary

		data.Text.TextColor3 =
			active
			and COLORS.Text
			or COLORS.TextSecondary

		data.Bar.Visible =
			active
	end

	--------------------------------------------------------

	local data =
		PageData[
			name
		]

	HeaderIcon.Text =
		data.Icon

	HeaderTitle.Text =
		string.upper(
			data.Label
		)

end

------------------------------------------------------------
-- CREATE NAV
------------------------------------------------------------

for index,
	name
	in ipairs(
		Order
	)
do

	local info =
		PageData[
			name
		]

	local button =
		Instance.new("TextButton")

	button.LayoutOrder =
		index

	button.Size =
		UDim2.new(
			1,
			0,
			0,
			49
		)

	button.BackgroundColor3 =
		COLORS.SidebarHover

	button.BackgroundTransparency =
		1

	button.BorderSizePixel =
		0

	button.Text =
		""

	button.AutoButtonColor =
		false

	button.ZIndex =
		20

	button.Parent =
		Navigation

	Corner(
		button,
		9
	)

	--------------------------------------------------------
	-- ACTIVE BAR
	--------------------------------------------------------

	local bar =
		Instance.new("Frame")

	bar.Position =
		UDim2.fromOffset(
			0,
			8
		)

	bar.Size =
		UDim2.fromOffset(
			3,
			33
		)

	bar.BackgroundColor3 =
		COLORS.Accent

	bar.BorderSizePixel =
		0

	bar.Visible =
		false

	bar.Parent =
		button

	Corner(
		bar,
		2
	)

	--------------------------------------------------------
	-- ICON
	--------------------------------------------------------

	local icon =
		Instance.new("TextLabel")

	icon.Position =
		UDim2.fromOffset(
			14,
			0
		)

	icon.Size =
		UDim2.fromOffset(
			30,
			49
		)

	icon.BackgroundTransparency =
		1

	icon.Text =
		info.Icon

	icon.TextColor3 =
		COLORS.TextSecondary

	icon.TextSize =
		20

	icon.FontFace =
		FONT_BOLD

	icon.Parent =
		button

	--------------------------------------------------------
	-- TEXT
	--------------------------------------------------------

	local text =
		Instance.new("TextLabel")

	text.Position =
		UDim2.fromOffset(
			48,
			0
		)

	text.Size =
		UDim2.new(
			1,
			-50,
			1,
			0
		)

	text.BackgroundTransparency =
		1

	text.Text =
		info.Label

	text.TextColor3 =
		COLORS.TextSecondary

	text.TextSize =
		12

	text.FontFace =
		FONT_MEDIUM

	text.TextXAlignment =
		Enum.TextXAlignment.Left

	text.Parent =
		button

	--------------------------------------------------------

	NavButtons[
		name
	] = {

		Button = button,
		Bar = bar,
		Icon = icon,
		Text = text,
	}

	button.MouseButton1Click:Connect(
		function()

			SwitchPage(
				name
			)

		end
	)

end

------------------------------------------------------------
-- SECTION
------------------------------------------------------------

local function CreateSection(
	parent,
	text
)

	local label =
		Instance.new("TextLabel")

	label.Size =
		UDim2.new(
			1,
			0,
			0,
			21
		)

	label.BackgroundTransparency =
		1

	label.Text =
		string.upper(
			text
		)

	label.TextColor3 =
		COLORS.TextMuted

	label.TextSize =
		8

	label.FontFace =
		FONT_BOLD

	label.TextXAlignment =
		Enum.TextXAlignment.Left

	label.Parent =
		parent

	return label
end

------------------------------------------------------------
-- CARD
------------------------------------------------------------

local function CreateCard(
	parent,
	title,
	description
)

	local card =
		Instance.new("Frame")

	card.Size =
		UDim2.new(
			1,
			0,
			0,
			70
		)

	card.BackgroundColor3 =
		COLORS.Card

	card.BorderSizePixel =
		0

	card.ZIndex =
		20

	card.Parent =
		parent

	Corner(
		card,
		10
	)

	local cardStroke =
		Stroke(
			card,
			COLORS.StrokeSoft,
			1,
			0.05
		)

	--------------------------------------------------------
	-- ACCENT
	--------------------------------------------------------

	local accent =
		Instance.new("Frame")

	accent.Position =
		UDim2.fromOffset(
			14,
			18
		)

	accent.Size =
		UDim2.fromOffset(
			4,
			34
		)

	accent.BackgroundColor3 =
		COLORS.Accent

	accent.BorderSizePixel =
		0

	accent.Parent =
		card

	Corner(
		accent,
		2
	)

	--------------------------------------------------------
	-- TITLE
	--------------------------------------------------------

	local titleLabel =
		Instance.new("TextLabel")

	titleLabel.Position =
		UDim2.fromOffset(
			30,
			11
		)

	titleLabel.Size =
		UDim2.new(
			1,
			-200,
			0,
			25
		)

	titleLabel.BackgroundTransparency =
		1

	titleLabel.Text =
		title

	titleLabel.TextColor3 =
		COLORS.Text

	titleLabel.TextSize =
		14

	titleLabel.FontFace =
		FONT_MEDIUM

	titleLabel.TextXAlignment =
		Enum.TextXAlignment.Left

	titleLabel.Parent =
		card

	--------------------------------------------------------
	-- DESCRIPTION
	--------------------------------------------------------

	local desc =
		Instance.new("TextLabel")

	desc.Position =
		UDim2.fromOffset(
			30,
			37
		)

	desc.Size =
		UDim2.new(
			1,
			-200,
			0,
			18
		)

	desc.BackgroundTransparency =
		1

	desc.Text =
		description

	desc.TextColor3 =
		COLORS.TextSecondary

	desc.TextSize =
		9

	desc.FontFace =
		FONT_REGULAR

	desc.TextXAlignment =
		Enum.TextXAlignment.Left

	desc.Parent =
		card

	return card,
		titleLabel,
		desc,
		cardStroke
end

------------------------------------------------------------
-- PRINCIPAL
------------------------------------------------------------

CreateSection(
	PrincipalPage,
	"Utilidades"
)

------------------------------------------------------------
-- ELEVATOR CARD
------------------------------------------------------------

local ElevatorCard,
	ElevatorTitle,
	ElevatorDescription =
	CreateCard(
		PrincipalPage,
		"Elevador",
		"Desativado"
	)

------------------------------------------------------------
-- CONTROLS
------------------------------------------------------------

local ElevatorControls =
	Instance.new("Frame")

ElevatorControls.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

ElevatorControls.Position =
	UDim2.new(
		1,
		-14,
		0.5,
		0
	)

ElevatorControls.Size =
	UDim2.fromOffset(
		158,
		40
	)

ElevatorControls.BackgroundTransparency =
	1

ElevatorControls.ZIndex =
	30

ElevatorControls.Parent =
	ElevatorCard

------------------------------------------------------------

local Minus =
	Instance.new("TextButton")

Minus.Size =
	UDim2.fromOffset(
		40,
		40
	)

Minus.BackgroundColor3 =
	COLORS.ButtonDark

Minus.BorderSizePixel =
	0

Minus.Text =
	"−"

Minus.TextColor3 =
	COLORS.Text

Minus.TextSize =
	23

Minus.FontFace =
	FONT_BOLD

Minus.AutoButtonColor =
	false

Minus.Parent =
	ElevatorControls

Corner(
	Minus,
	9
)

Stroke(
	Minus,
	COLORS.Stroke,
	1,
	0
)

------------------------------------------------------------

local LevelHolder =
	Instance.new("Frame")

LevelHolder.Position =
	UDim2.fromOffset(
		48,
		0
	)

LevelHolder.Size =
	UDim2.fromOffset(
		62,
		40
	)

LevelHolder.BackgroundColor3 =
	COLORS.White

LevelHolder.BorderSizePixel =
	0

LevelHolder.Parent =
	ElevatorControls

Corner(
	LevelHolder,
	9
)

------------------------------------------------------------

local LevelText =
	Instance.new("TextLabel")

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
	LevelHolder

------------------------------------------------------------

local Plus =
	Instance.new("TextButton")

Plus.Position =
	UDim2.fromOffset(
		118,
		0
	)

Plus.Size =
	UDim2.fromOffset(
		40,
		40
	)

Plus.BackgroundColor3 =
	COLORS.Accent

Plus.BorderSizePixel =
	0

Plus.Text =
	"+"

Plus.TextColor3 =
	COLORS.White

Plus.TextSize =
	22

Plus.FontFace =
	FONT_BOLD

Plus.AutoButtonColor =
	false

Plus.Parent =
	ElevatorControls

Corner(
	Plus,
	9
)

------------------------------------------------------------
-- UPDATE ELEVATOR
------------------------------------------------------------

local function UpdateElevator()

	LevelText.Text =
		tostring(
			Level
		)

	if not Platform then

		ElevatorDescription.Text =
			"Desativado"

	else

		local height =
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
				height
			)

	end

end

------------------------------------------------------------
-- PLUS
------------------------------------------------------------

Plus.MouseButton1Click:Connect(
	function()

		if not Root then
			return
		end

		if not Platform then

			CreatePlatform()

			Level =
				1

			TargetY =
				BaseY

			UpdateElevator()

			return
		end

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

		UpdateElevator()

	end
)

------------------------------------------------------------
-- MINUS
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

			UpdateElevator()

		else

			RemovePlatform()

			UpdateElevator()

		end

	end
)

------------------------------------------------------------
-- DESCNY CARD
------------------------------------------------------------

local DescnyCard,
	DescnyTitle,
	DescnyDescription,
	DescnyStroke =
	CreateCard(
		PrincipalPage,
		"DESCNY",
		"Procura item de invisibilidade"
	)

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
		-14,
		0.5,
		0
	)

DescnyButton.Size =
	UDim2.fromOffset(
		110,
		39
	)

DescnyButton.BackgroundColor3 =
	COLORS.ButtonDark

DescnyButton.BorderSizePixel =
	0

DescnyButton.Text =
	"ATIVAR"

DescnyButton.TextColor3 =
	COLORS.Text

DescnyButton.TextSize =
	10

DescnyButton.FontFace =
	FONT_BOLD

DescnyButton.AutoButtonColor =
	false

DescnyButton.ZIndex =
	30

DescnyButton.Parent =
	DescnyCard

Corner(
	DescnyButton,
	9
)

local DescnyButtonStroke =
	Stroke(
		DescnyButton,
		COLORS.Stroke,
		1,
		0
	)

------------------------------------------------------------

DescnyButton.MouseButton1Click:Connect(
	function()

		DescnyButton.Text =
			"BUSCANDO..."

		local success,
			result =
			ActivateDescny()

		if success then

			DescnyButton.Text =
				"ATIVADO"

			DescnyButton.TextColor3 =
				COLORS.Green

			DescnyButtonStroke.Color =
				COLORS.Green

			DescnyDescription.Text =
				"Usando "
				.. tostring(
					result
				)

		else

			DescnyButton.Text =
				"NÃO ACHOU"

			DescnyButton.TextColor3 =
				COLORS.Red

			DescnyButtonStroke.Color =
				COLORS.Red

			DescnyDescription.Text =
				tostring(
					result
				)

		end

		task.delay(
			1.4,
			function()

				if not DescnyButton.Parent then
					return
				end

				DescnyButton.Text =
					"ATIVAR"

				DescnyButton.TextColor3 =
					COLORS.Text

				DescnyButtonStroke.Color =
					COLORS.Stroke

			end
		)

	end
)

------------------------------------------------------------
-- ANTILAG
------------------------------------------------------------

local AntiCard,
	AntiTitle,
	AntiDescription =
	CreateCard(
		PrincipalPage,
		"AntiLag",
		"Reduz efeitos visuais pesados"
	)

------------------------------------------------------------

local AntiSwitch =
	Instance.new("TextButton")

AntiSwitch.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

AntiSwitch.Position =
	UDim2.new(
		1,
		-15,
		0.5,
		0
	)

AntiSwitch.Size =
	UDim2.fromOffset(
		62,
		32
	)

AntiSwitch.BackgroundColor3 =
	COLORS.ButtonDark

AntiSwitch.BorderSizePixel =
	0

AntiSwitch.Text =
	""

AntiSwitch.AutoButtonColor =
	false

AntiSwitch.ZIndex =
	30

AntiSwitch.Parent =
	AntiCard

Corner(
	AntiSwitch,
	16
)

local AntiSwitchStroke =
	Stroke(
		AntiSwitch,
		COLORS.Stroke,
		1,
		0
	)

------------------------------------------------------------

local AntiDot =
	Instance.new("Frame")

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
		21,
		21
	)

AntiDot.BackgroundColor3 =
	COLORS.TextSecondary

AntiDot.BorderSizePixel =
	0

AntiDot.ZIndex =
	31

AntiDot.Parent =
	AntiSwitch

Corner(
	AntiDot,
	11
)

------------------------------------------------------------

local function UpdateAntiLag()

	if AntiLagEnabled then

		Tween(
			AntiSwitch,
			0.18,
			{
				BackgroundColor3 =
					COLORS.Accent
			}
		)

		Tween(
			AntiDot,
			0.18,
			{
				Position =
					UDim2.fromOffset(
						45,
						16
					),

				BackgroundColor3 =
					COLORS.White
			}
		)

		AntiSwitchStroke.Color =
			COLORS.Accent2

		AntiDescription.Text =
			"Ativado"

	else

		Tween(
			AntiSwitch,
			0.18,
			{
				BackgroundColor3 =
					COLORS.ButtonDark
			}
		)

		Tween(
			AntiDot,
			0.18,
			{
				Position =
					UDim2.fromOffset(
						17,
						16
					),

				BackgroundColor3 =
					COLORS.TextSecondary
			}
		)

		AntiSwitchStroke.Color =
			COLORS.Stroke

		AntiDescription.Text =
			"Reduz efeitos visuais pesados"

	end

end

------------------------------------------------------------

AntiSwitch.MouseButton1Click:Connect(
	function()

		if AntiLagEnabled then

			DisableAntiLag()

		else

			EnableAntiLag()

		end

		UpdateAntiLag()

	end
)

------------------------------------------------------------
-- VISUAL PAGE
------------------------------------------------------------

CreateSection(
	VisualPage,
	"Interface"
)

------------------------------------------------------------

local VisualCard =
	CreateCard(
		VisualPage,
		"Tema",
		"Dark Navy + Orange"
	)

------------------------------------------------------------

CreateCard(
	VisualPage,
	"Layout Mobile",
	"Escala automática para telas menores"
)

------------------------------------------------------------
-- DIVERSOS PAGE
------------------------------------------------------------

CreateSection(
	DiversosPage,
	"Informações"
)

------------------------------------------------------------

CreateCard(
	DiversosPage,
	"Status",
	"Interface carregada"
)

------------------------------------------------------------

CreateCard(
	DiversosPage,
	"Plataforma",
	"Segue sua posição horizontal"
)

------------------------------------------------------------
-- AJUSTES
------------------------------------------------------------

CreateSection(
	AjustesPage,
	"Interface"
)

------------------------------------------------------------

CreateCard(
	AjustesPage,
	"Arrastar Menu",
	"Segure o topo da janela e mova"
)

------------------------------------------------------------

CreateCard(
	AjustesPage,
	"Botão Flutuante",
	"Toque para abrir • segure para mover"
)

------------------------------------------------------------
-- GENERIC MOBILE DRAG
------------------------------------------------------------

local function MakeDraggable(
	handle,
	target,
	onTap
)

	local dragging =
		false

	local moved =
		false

	local activeInput =
		nil

	local dragStart =
		nil

	local startPosition =
		nil

	local threshold =
		8

	--------------------------------------------------------
	-- START
	--------------------------------------------------------

	handle.InputBegan:Connect(
		function(input)

			local type =
				input.UserInputType

			if
				type
					~= Enum.UserInputType.Touch
				and
				type
					~= Enum.UserInputType.MouseButton1
			then
				return
			end

			dragging =
				true

			moved =
				false

			activeInput =
				input

			dragStart =
				input.Position

			startPosition =
				target.AbsolutePosition

		end
	)

	--------------------------------------------------------
	-- MOVE
	--------------------------------------------------------

	UIS.InputChanged:Connect(
		function(input)

			if not dragging then
				return
			end

			------------------------------------------------
			-- TOUCH:
			-- precisa ser o mesmo dedo
			------------------------------------------------

			if activeInput
				and
				activeInput.UserInputType
					== Enum.UserInputType.Touch
			then

				if input
					~= activeInput
				then
					return
				end

			else

				if input.UserInputType
					~= Enum.UserInputType.MouseMovement
				then
					return
				end

			end

			------------------------------------------------

			local delta =
				input.Position
				- dragStart

			if delta.Magnitude >
				threshold
			then

				moved =
					true
			end

			if not moved then
				return
			end

			------------------------------------------------

			local viewport =
				Camera.ViewportSize

			local width =
				target.AbsoluteSize.X

			local height =
				target.AbsoluteSize.Y

			local newX =
				startPosition.X
				+ delta.X

			local newY =
				startPosition.Y
				+ delta.Y

			------------------------------------------------
			-- KEEP INSIDE SCREEN
			------------------------------------------------

			newX =
				math.clamp(
					newX,
					5,
					math.max(
						5,
						viewport.X
							- width
							- 5
					)
				)

			newY =
				math.clamp(
					newY,
					5,
					math.max(
						5,
						viewport.Y
							- height
							- 5
					)
				)

			target.AnchorPoint =
				Vector2.new(
					0,
					0
				)

			target.Position =
				UDim2.fromOffset(
					newX,
					newY
				)

		end
	)

	--------------------------------------------------------
	-- END
	--------------------------------------------------------

	UIS.InputEnded:Connect(
		function(input)

			if not dragging then
				return
			end

			local correct =
				false

			if activeInput
				and
				activeInput.UserInputType
					== Enum.UserInputType.Touch
			then

				correct =
					input
					== activeInput

			else

				correct =
					input.UserInputType
					== Enum.UserInputType.MouseButton1

			end

			if not correct then
				return
			end

			dragging =
				false

			activeInput =
				nil

			------------------------------------------------
			-- TAP
			------------------------------------------------

			if not moved
				and onTap
			then

				onTap()

			end

		end
	)

end

------------------------------------------------------------
-- FLOATING BUTTON
------------------------------------------------------------

local Floating =
	Instance.new("ImageButton")

Floating.Name =
	"FloatingButton"

Floating.AnchorPoint =
	Vector2.new(
		0,
		0
	)

-- posição inicial.
-- depois NÃO muda sozinha.
Floating.Position =
	UDim2.fromOffset(
		20,
		170
	)

Floating.Size =
	UDim2.fromOffset(
		62,
		62
	)

Floating.BackgroundColor3 =
	Color3.fromRGB(
		7,
		13,
		21
	)

Floating.BorderSizePixel =
	0

Floating.Image =
	CONFIG.Logo

Floating.ScaleType =
	Enum.ScaleType.Fit

Floating.AutoButtonColor =
	false

Floating.Active =
	true

Floating.Selectable =
	false

Floating.Visible =
	false

Floating.ZIndex =
	500

Floating.Parent =
	GUI

Corner(
	Floating,
	31
)

local FloatingStroke =
	Stroke(
		Floating,
		COLORS.Accent,
		2,
		0.02
	)

------------------------------------------------------------
-- FALLBACK LETTER
------------------------------------------------------------

local FloatingFallback =
	Instance.new("TextLabel")

FloatingFallback.Size =
	UDim2.fromScale(
		1,
		1
	)

FloatingFallback.BackgroundTransparency =
	1

FloatingFallback.Text =
	"S"

FloatingFallback.TextColor3 =
	COLORS.Accent

FloatingFallback.TextSize =
	27

FloatingFallback.FontFace =
	FONT_BOLD

FloatingFallback.ZIndex =
	499

FloatingFallback.Active =
	false

FloatingFallback.Parent =
	Floating

------------------------------------------------------------
-- MINI GLOW
------------------------------------------------------------

local FloatingGlow =
	Instance.new("Frame")

FloatingGlow.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

FloatingGlow.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

FloatingGlow.Size =
	UDim2.new(
		1,
		10,
		1,
		10
	)

FloatingGlow.BackgroundColor3 =
	COLORS.Accent

FloatingGlow.BackgroundTransparency =
	0.87

FloatingGlow.BorderSizePixel =
	0

FloatingGlow.ZIndex =
	498

FloatingGlow.Active =
	false

FloatingGlow.Parent =
	Floating

Corner(
	FloatingGlow,
	40
)

------------------------------------------------------------
-- MINIMIZE / RESTORE
------------------------------------------------------------

local Minimized =
	false

------------------------------------------------------------

local function MinimizeUI()

	if Minimized then
		return
	end

	Minimized =
		true

	--------------------------------------------------------
	-- IMPORTANT:
	-- NÃO ALTERA Floating.Position
	--------------------------------------------------------

	Main.Visible =
		false

	Floating.Visible =
		true

	Floating.Size =
		UDim2.fromOffset(
			52,
			52
		)

	Tween(
		Floating,
		0.18,
		{
			Size =
				UDim2.fromOffset(
					62,
					62
				)
		}
	)

end

------------------------------------------------------------

local function RestoreUI()

	if not Minimized then
		return
	end

	Minimized =
		false

	Floating.Visible =
		false

	Main.Visible =
		true

end

------------------------------------------------------------
-- MINIMIZE BUTTON
------------------------------------------------------------

Minimize.MouseButton1Click:Connect(
	function()

		MinimizeUI()

	end
)

------------------------------------------------------------
-- FLOATING:
-- TAP OPENS
-- HOLD + DRAG MOVES
------------------------------------------------------------

MakeDraggable(
	Floating,
	Floating,

	function()

		RestoreUI()

	end
)

------------------------------------------------------------
-- MENU DRAG MOBILE
------------------------------------------------------------

MakeDraggable(
	Header,
	Main,
	nil
)

------------------------------------------------------------
-- PREVENT MINIMIZE BUTTON FROM DRAGGING HEADER
------------------------------------------------------------

Minimize.InputBegan:Connect(
	function(input)

		-- button handles itself
	end
)

------------------------------------------------------------
-- RESPAWN
------------------------------------------------------------

Player.CharacterRemoving:Connect(
	function()

		RemovePlatform()

		UpdateElevator()

	end
)

------------------------------------------------------------
-- START PAGE
------------------------------------------------------------

SwitchPage(
	"Principal"
)

UpdateElevator()

UpdateAntiLag()
