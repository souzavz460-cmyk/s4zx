--[[
    SOUZA PANEL V4
    LocalScript

    StarterPlayer
        > StarterPlayerScripts
            > LocalScript

    INTERFACE:
    Inspirada no layout enviado:
    - Sidebar
    - Tema dark/navy
    - Accent laranja
    - Cards
    - Scroll
    - Minimizar
    - Círculo flutuante 100% arrastável

    RECURSOS:
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

------------------------------------------------------------
-- CONFIG
------------------------------------------------------------

local CONFIG = {

	-- Usando thumbnail porque costuma carregar melhor
	-- quando rbxassetid não aparece.
	Logo =
		"rbxthumb://type=Asset&id=98880379063768&w=420&h=420",

	--------------------------------------------------------
	-- ELEVADOR
	--------------------------------------------------------

	PlatformSize =
		Vector3.new(
			6.5,
			0.65,
			6.5
		),

	-- Nível 2 fica baixo.
	StepHeight = 2.2,

	MaxLevel = 25,

	MoveSpeed = 7.5,

	--------------------------------------------------------
	-- UI
	--------------------------------------------------------

	Width = 620,
	Height = 410,

	SidebarWidth = 155,
}

------------------------------------------------------------
-- COLORS
------------------------------------------------------------

local C = {

	Background =
		Color3.fromRGB(
			3,
			8,
			14
		),

	Sidebar =
		Color3.fromRGB(
			2,
			7,
			13
		),

	Top =
		Color3.fromRGB(
			4,
			10,
			17
		),

	Row =
		Color3.fromRGB(
			17,
			28,
			40
		),

	RowHover =
		Color3.fromRGB(
			22,
			35,
			49
		),

	Accent =
		Color3.fromRGB(
			255,
			74,
			22
		),

	AccentHover =
		Color3.fromRGB(
			255,
			98,
			47
		),

	Text =
		Color3.fromRGB(
			238,
			241,
			246
		),

	SubText =
		Color3.fromRGB(
			155,
			164,
			177
		),

	Disabled =
		Color3.fromRGB(
			8,
			17,
			27
		),

	Track =
		Color3.fromRGB(
			235,
			239,
			243
		),

	Stroke =
		Color3.fromRGB(
			25,
			38,
			52
		),

	Green =
		Color3.fromRGB(
			80,
			220,
			150
		),

	Red =
		Color3.fromRGB(
			235,
			73,
			88
		),
}

------------------------------------------------------------
-- CLEANUP
------------------------------------------------------------

local oldGui =
	PlayerGui:FindFirstChild(
		"SouzaAdvancedPanel"
	)

if oldGui then
	oldGui:Destroy()
end

local oldPlatform =
	workspace:FindFirstChild(
		"SouzaFollowPlatform_"
		.. Player.UserId
	)

if oldPlatform then
	oldPlatform:Destroy()
end

------------------------------------------------------------
-- CHARACTER
------------------------------------------------------------

local Character
local Humanoid
local Root

local function SetupCharacter(char)

	Character = char

	Humanoid =
		char:WaitForChild(
			"Humanoid"
		)

	Root =
		char:WaitForChild(
			"HumanoidRootPart"
		)

end

if Player.Character then

	SetupCharacter(
		Player.Character
	)

end

Player.CharacterAdded:Connect(
	function(char)

		task.wait(0.2)

		SetupCharacter(char)

	end
)

------------------------------------------------------------
-- HELPERS
------------------------------------------------------------

local function Corner(
	object,
	radius
)

	local c =
		Instance.new(
			"UICorner"
		)

	c.CornerRadius =
		UDim.new(
			0,
			radius
		)

	c.Parent = object

	return c
end

local function Stroke(
	object,
	color,
	thickness,
	transparency
)

	local s =
		Instance.new(
			"UIStroke"
		)

	s.Color =
		color or C.Stroke

	s.Thickness =
		thickness or 1

	s.Transparency =
		transparency or 0

	s.Parent = object

	return s
end

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
-- PLATFORM
------------------------------------------------------------

local Platform = nil

local Level = 0

local BaseY = 0

local CurrentY = 0

local TargetY = 0

------------------------------------------------------------
-- FEET POSITION
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
	-- Level 1 = exatamente debaixo do player.
	--------------------------------------------------------

	BaseY =
		GetFeetY()
		- CONFIG.PlatformSize.Y / 2
		- 0.05

	CurrentY = BaseY
	TargetY = BaseY

	--------------------------------------------------------
	-- PART
	--------------------------------------------------------

	Platform =
		Instance.new(
			"Part"
		)

	Platform.Name =
		"SouzaFollowPlatform_"
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
			17,
			21,
			29
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
	-- SURFACE GUI
	--------------------------------------------------------

	local surface =
		Instance.new(
			"SurfaceGui"
		)

	surface.Face =
		Enum.NormalId.Top

	surface.SizingMode =
		Enum.SurfaceGuiSizingMode.PixelsPerStud

	surface.PixelsPerStud = 45

	surface.LightInfluence = 0

	surface.Parent =
		Platform

	--------------------------------------------------------

	local background =
		Instance.new(
			"Frame"
		)

	background.Size =
		UDim2.fromScale(
			1,
			1
		)

	background.BackgroundColor3 =
		Color3.fromRGB(
			10,
			13,
			20
		)

	background.BorderSizePixel = 0

	background.Parent =
		surface

	--------------------------------------------------------
	-- ORANGE BORDER
	--------------------------------------------------------

	local border =
		Instance.new(
			"UIStroke"
		)

	border.Color =
		C.Accent

	border.Thickness = 3

	border.Parent =
		background

	--------------------------------------------------------
	-- BACKUP S
	--------------------------------------------------------

	local backup =
		Instance.new(
			"TextLabel"
		)

	backup.Size =
		UDim2.fromScale(
			1,
			1
		)

	backup.BackgroundTransparency = 1

	backup.Text = "S"

	backup.TextColor3 =
		C.Accent

	backup.TextTransparency =
		0.65

	backup.Font =
		Enum.Font.GothamBlack

	backup.TextScaled = true

	backup.Parent =
		background

	--------------------------------------------------------
	-- LOGO
	--------------------------------------------------------

	local logo =
		Instance.new(
			"ImageLabel"
		)

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

	logo.BackgroundTransparency = 1

	logo.Image =
		CONFIG.Logo

	logo.ScaleType =
		Enum.ScaleType.Fit

	logo.Parent =
		background

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
-- PLATFORM LOOP
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

		----------------------------------------------------
		-- VERTICAL SMOOTH
		----------------------------------------------------

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

		----------------------------------------------------
		-- FOLLOW PLAYER
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
-- ANTI LAG
------------------------------------------------------------

local AntiLagEnabled = false

local AntiLagCache = {}

local function SaveProperty(
	object,
	property
)

	if not AntiLagCache[object] then

		AntiLagCache[object] = {}

	end

	if AntiLagCache[object][property]
		~= nil
	then

		return

	end

	local success, value =
		pcall(
			function()

				return object[property]

			end
		)

	if success then

		AntiLagCache[object][property] =
			value

	end

end

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

local function EnableAntiLag()

	if AntiLagEnabled then
		return
	end

	AntiLagEnabled = true

	SetCached(
		Lighting,
		"GlobalShadows",
		false
	)

	task.spawn(
		function()

			local descendants =
				workspace:GetDescendants()

			for index, object
				in ipairs(
					descendants
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

local function DisableAntiLag()

	AntiLagEnabled = false

	for object, properties
		in pairs(
			AntiLagCache
		)
	do

		if object
			and object.Parent
		then

			for property, value
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
-- DESCNY
------------------------------------------------------------

local InvisNames = {

	"invis",
	"invisible",
	"invisibility",
	"cloak",
	"capa",
	"descny",
	"vanish",
	"ghost",

}

local function IsInvisibilityTool(
	object
)

	if not object:IsA("Tool") then
		return false
	end

	if object:GetAttribute(
		"Invisible"
	) == true then

		return true

	end

	if object:GetAttribute(
		"Invisibility"
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

	for _, word
		in ipairs(
			InvisNames
		)
	do

		if string.find(
			name,
			word,
			1,
			true
		) then

			return true

		end

	end

	return false
end

local function FindInvisibilityTool()

	--------------------------------------------------------
	-- CHARACTER
	--------------------------------------------------------

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
	-- BACKPACK
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

local function ActivateDescny()

	if not Humanoid then

		return false,
			"Personagem não encontrado"

	end

	local tool =
		FindInvisibilityTool()

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

		task.wait(0.1)

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
		"Não foi possível ativar"

end

------------------------------------------------------------
-- GUI
------------------------------------------------------------

local GUI =
	Instance.new(
		"ScreenGui"
	)

GUI.Name =
	"SouzaAdvancedPanel"

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
	Instance.new(
		"Frame"
	)

Main.Name = "Main"

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
		CONFIG.Width,
		CONFIG.Height
	)

Main.BackgroundColor3 =
	C.Background

Main.BorderSizePixel = 0

Main.ClipsDescendants = true

Main.Active = true

Main.Parent = GUI

Corner(Main, 6)

Stroke(
	Main,
	Color3.fromRGB(
		8,
		13,
		20
	),
	1,
	0
)

------------------------------------------------------------
-- SCALE
------------------------------------------------------------

local MainScale =
	Instance.new(
		"UIScale"
	)

MainScale.Scale = 1

MainScale.Parent =
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
	C.Sidebar

Sidebar.BorderSizePixel = 0

Sidebar.Parent =
	Main

------------------------------------------------------------
-- SIDE LOGO HOLDER
------------------------------------------------------------

local SideLogoHolder =
	Instance.new(
		"Frame"
	)

SideLogoHolder.AnchorPoint =
	Vector2.new(
		0.5,
		0
	)

SideLogoHolder.Position =
	UDim2.new(
		0.5,
		0,
		0,
		18
	)

SideLogoHolder.Size =
	UDim2.fromOffset(
		58,
		58
	)

SideLogoHolder.BackgroundColor3 =
	Color3.fromRGB(
		22,
		27,
		35
	)

SideLogoHolder.BorderSizePixel = 0

SideLogoHolder.Parent =
	Sidebar

Corner(
	SideLogoHolder,
	29
)

Stroke(
	SideLogoHolder,
	C.Accent,
	2,
	0.3
)

------------------------------------------------------------
-- S BACKUP
------------------------------------------------------------

local SideBackup =
	Instance.new(
		"TextLabel"
	)

SideBackup.Size =
	UDim2.fromScale(
		1,
		1
	)

SideBackup.BackgroundTransparency = 1

SideBackup.Text = "S"

SideBackup.TextColor3 =
	C.Accent

SideBackup.TextSize = 27

SideBackup.Font =
	Enum.Font.GothamBlack

SideBackup.Parent =
	SideLogoHolder

------------------------------------------------------------
-- SIDE LOGO
------------------------------------------------------------

local SideLogo =
	Instance.new(
		"ImageLabel"
	)

SideLogo.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

SideLogo.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

SideLogo.Size =
	UDim2.fromOffset(
		50,
		50
	)

SideLogo.BackgroundTransparency = 1

SideLogo.Image =
	CONFIG.Logo

SideLogo.ScaleType =
	Enum.ScaleType.Fit

SideLogo.Parent =
	SideLogoHolder

------------------------------------------------------------
-- NAV HOLDER
------------------------------------------------------------

local Nav =
	Instance.new(
		"Frame"
	)

Nav.Position =
	UDim2.fromOffset(
		10,
		100
	)

Nav.Size =
	UDim2.new(
		1,
		-20,
		1,
		-110
	)

Nav.BackgroundTransparency = 1

Nav.Parent =
	Sidebar

------------------------------------------------------------
-- NAV LAYOUT
------------------------------------------------------------

local NavLayout =
	Instance.new(
		"UIListLayout"
	)

NavLayout.Padding =
	UDim.new(
		0,
		7
	)

NavLayout.SortOrder =
	Enum.SortOrder.LayoutOrder

NavLayout.Parent =
	Nav

------------------------------------------------------------
-- CONTENT AREA
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

Content.BackgroundColor3 =
	C.Background

Content.BorderSizePixel = 0

Content.Parent =
	Main

------------------------------------------------------------
-- HEADER
------------------------------------------------------------

local Header =
	Instance.new(
		"Frame"
	)

Header.Size =
	UDim2.new(
		1,
		0,
		0,
		72
	)

Header.BackgroundTransparency = 1

Header.Parent =
	Content

------------------------------------------------------------
-- HEADER ICON
------------------------------------------------------------

local HeaderIcon =
	Instance.new(
		"TextLabel"
	)

HeaderIcon.Position =
	UDim2.fromOffset(
		25,
		20
	)

HeaderIcon.Size =
	UDim2.fromOffset(
		28,
		30
	)

HeaderIcon.BackgroundTransparency = 1

HeaderIcon.Text = "◈"

HeaderIcon.TextColor3 =
	C.Accent

HeaderIcon.TextSize = 25

HeaderIcon.Font =
	Enum.Font.GothamBold

HeaderIcon.Parent =
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
		60,
		21
	)

HeaderTitle.Size =
	UDim2.fromOffset(
		240,
		28
	)

HeaderTitle.BackgroundTransparency = 1

HeaderTitle.Text =
	"DIVERSOS"

HeaderTitle.TextColor3 =
	C.Accent

HeaderTitle.TextSize = 17

HeaderTitle.Font =
	Enum.Font.GothamBold

HeaderTitle.TextXAlignment =
	Enum.TextXAlignment.Left

HeaderTitle.Parent =
	Header

------------------------------------------------------------
-- MOON
------------------------------------------------------------

local Moon =
	Instance.new(
		"TextButton"
	)

Moon.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

Moon.Position =
	UDim2.new(
		1,
		-60,
		0.5,
		0
	)

Moon.Size =
	UDim2.fromOffset(
		36,
		36
	)

Moon.BackgroundTransparency = 1

Moon.Text = "☾"

Moon.TextColor3 =
	C.Accent

Moon.TextSize = 28

Moon.Font =
	Enum.Font.GothamBold

Moon.Parent =
	Header

------------------------------------------------------------
-- MINIMIZE
------------------------------------------------------------

local Minimize =
	Instance.new(
		"TextButton"
	)

Minimize.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

Minimize.Position =
	UDim2.new(
		1,
		-17,
		0.5,
		0
	)

Minimize.Size =
	UDim2.fromOffset(
		36,
		36
	)

Minimize.BackgroundTransparency = 1

Minimize.Text = "×"

Minimize.TextColor3 =
	C.Accent

Minimize.TextSize = 31

Minimize.Font =
	Enum.Font.Gotham

Minimize.Parent =
	Header

------------------------------------------------------------
-- PAGES HOLDER
------------------------------------------------------------

local Pages =
	Instance.new(
		"Frame"
	)

Pages.Position =
	UDim2.fromOffset(
		20,
		72
	)

Pages.Size =
	UDim2.new(
		1,
		-30,
		1,
		-83
	)

Pages.BackgroundTransparency = 1

Pages.Parent =
	Content

------------------------------------------------------------
-- PAGE CREATOR
------------------------------------------------------------

local PageFrames = {}

local function CreatePage(
	name
)

	local page =
		Instance.new(
			"ScrollingFrame"
		)

	page.Name = name

	page.Size =
		UDim2.fromScale(
			1,
			1
		)

	page.BackgroundTransparency = 1

	page.BorderSizePixel = 0

	page.ScrollBarThickness = 4

	page.ScrollBarImageColor3 =
		Color3.fromRGB(
			31,
			46,
			62
		)

	page.CanvasSize =
		UDim2.fromOffset(
			0,
			0
		)

	page.AutomaticCanvasSize =
		Enum.AutomaticSize.Y

	page.ScrollingDirection =
		Enum.ScrollingDirection.Y

	page.Visible = false

	page.Parent =
		Pages

	--------------------------------------------------------

	local padding =
		Instance.new(
			"UIPadding"
		)

	padding.PaddingRight =
		UDim.new(
			0,
			12
		)

	padding.Parent =
		page

	--------------------------------------------------------

	local layout =
		Instance.new(
			"UIListLayout"
		)

	layout.Padding =
		UDim.new(
			0,
			12
		)

	layout.SortOrder =
		Enum.SortOrder.LayoutOrder

	layout.Parent =
		page

	PageFrames[name] =
		page

	return page

end

------------------------------------------------------------
-- PAGES
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

local ContaPage =
	CreatePage(
		"Conta"
	)

------------------------------------------------------------
-- NAVIGATION
------------------------------------------------------------

local NavButtons = {}

local PageInfo = {

	Principal = {
		Icon = "⊕",
		Name = "Principal",
	},

	Visuais = {
		Icon = "◉",
		Name = "Visuais",
	},

	Diversos = {
		Icon = "◇",
		Name = "Diversos",
	},

	Ajustes = {
		Icon = "⚙",
		Name = "Ajustes",
	},

	Conta = {
		Icon = "♙",
		Name = "Conta",
	},
}

------------------------------------------------------------
-- SET PAGE
------------------------------------------------------------

local function SetPage(
	pageName
)

	for name, page
		in pairs(
			PageFrames
		)
	do

		page.Visible =
			name == pageName

	end

	for name, data
		in pairs(
			NavButtons
		)
	do

		local active =
			name == pageName

		Tween(
			data.Text,
			0.15,
			{
				TextColor3 =
					active
					and C.Accent
					or C.Text
			}
		)

		Tween(
			data.Icon,
			0.15,
			{
				TextColor3 =
					active
					and C.Accent
					or C.SubText
			}
		)

	end

	local info =
		PageInfo[
			pageName
		]

	HeaderIcon.Text =
		info.Icon

	HeaderTitle.Text =
		string.upper(
			info.Name
		)

end

------------------------------------------------------------
-- NAV BUTTON CREATOR
------------------------------------------------------------

local NavOrder = {

	"Principal",
	"Visuais",
	"Diversos",
	"Ajustes",
	"Conta",

}

for order, pageName
	in ipairs(
		NavOrder
	)
do

	local info =
		PageInfo[
			pageName
		]

	local button =
		Instance.new(
			"TextButton"
		)

	button.LayoutOrder =
		order

	button.Size =
		UDim2.new(
			1,
			0,
			0,
			55
		)

	button.BackgroundTransparency = 1

	button.Text = ""

	button.AutoButtonColor = false

	button.Parent =
		Nav

	--------------------------------------------------------

	local icon =
		Instance.new(
			"TextLabel"
		)

	icon.Position =
		UDim2.fromOffset(
			5,
			2
		)

	icon.Size =
		UDim2.fromOffset(
			40,
			32
		)

	icon.BackgroundTransparency = 1

	icon.Text =
		info.Icon

	icon.TextColor3 =
		C.SubText

	icon.TextSize = 24

	icon.Font =
		Enum.Font.GothamBold

	icon.Parent =
		button

	--------------------------------------------------------

	local text =
		Instance.new(
			"TextLabel"
		)

	text.Position =
		UDim2.fromOffset(
			0,
			33
		)

	text.Size =
		UDim2.new(
			1,
			0,
			0,
			19
		)

	text.BackgroundTransparency = 1

	text.Text =
		info.Name

	text.TextColor3 =
		C.Text

	text.TextSize = 14

	text.Font =
		Enum.Font.GothamMedium

	text.Parent =
		button

	--------------------------------------------------------

	NavButtons[
		pageName
	] = {

		Button = button,

		Icon = icon,

		Text = text,
	}

	button.MouseButton1Click:Connect(
		function()

			SetPage(
				pageName
			)

		end
	)

end

------------------------------------------------------------
-- ROW CREATOR
------------------------------------------------------------

local function CreateRow(
	parent,
	title,
	description
)

	local row =
		Instance.new(
			"Frame"
		)

	row.Size =
		UDim2.new(
			1,
			0,
			0,
			62
		)

	row.BackgroundColor3 =
		C.Row

	row.BorderSizePixel = 0

	row.Parent =
		parent

	Corner(
		row,
		9
	)

	--------------------------------------------------------

	local titleLabel =
		Instance.new(
			"TextLabel"
		)

	titleLabel.Position =
		UDim2.fromOffset(
			19,
			description and 10 or 0
		)

	titleLabel.Size =
		UDim2.new(
			1,
			-180,
			0,
			description and 22 or 62
		)

	titleLabel.BackgroundTransparency = 1

	titleLabel.Text =
		title

	titleLabel.TextColor3 =
		C.Text

	titleLabel.TextSize = 16

	titleLabel.Font =
		Enum.Font.GothamMedium

	titleLabel.TextXAlignment =
		Enum.TextXAlignment.Left

	titleLabel.TextYAlignment =
		description
		and Enum.TextYAlignment.Bottom
		or Enum.TextYAlignment.Center

	titleLabel.Parent =
		row

	--------------------------------------------------------

	local descriptionLabel

	if description then

		descriptionLabel =
			Instance.new(
				"TextLabel"
			)

		descriptionLabel.Position =
			UDim2.fromOffset(
				19,
				34
			)

		descriptionLabel.Size =
			UDim2.new(
				1,
				-190,
				0,
				17
			)

		descriptionLabel.BackgroundTransparency = 1

		descriptionLabel.Text =
			description

		descriptionLabel.TextColor3 =
			C.SubText

		descriptionLabel.TextSize = 10

		descriptionLabel.Font =
			Enum.Font.Gotham

		descriptionLabel.TextXAlignment =
			Enum.TextXAlignment.Left

		descriptionLabel.Parent =
			row

	end

	return row,
		titleLabel,
		descriptionLabel

end

------------------------------------------------------------
-- TOGGLE CREATOR
------------------------------------------------------------

local function CreateToggle(
	row,
	callback
)

	local enabled = false

	--------------------------------------------------------
	-- WHITE SWITCH
	--------------------------------------------------------

	local track =
		Instance.new(
			"Frame"
		)

	track.AnchorPoint =
		Vector2.new(
			1,
			0.5
		)

	track.Position =
		UDim2.new(
			1,
			-68,
			0.5,
			0
		)

	track.Size =
		UDim2.fromOffset(
			38,
			23
		)

	track.BackgroundColor3 =
		C.Track

	track.BorderSizePixel = 0

	track.Parent =
		row

	Corner(
		track,
		12
	)

	--------------------------------------------------------
	-- SWITCH DOT
	--------------------------------------------------------

	local dot =
		Instance.new(
			"Frame"
		)

	dot.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	dot.Position =
		UDim2.fromOffset(
			11,
			11.5
		)

	dot.Size =
		UDim2.fromOffset(
			17,
			17
		)

	dot.BackgroundColor3 =
		Color3.fromRGB(
			24,
			30,
			36
		)

	dot.BorderSizePixel = 0

	dot.Parent =
		track

	Corner(
		dot,
		9
	)

	--------------------------------------------------------
	-- CHECKBOX
	--------------------------------------------------------

	local check =
		Instance.new(
			"TextButton"
		)

	check.AnchorPoint =
		Vector2.new(
			1,
			0.5
		)

	check.Position =
		UDim2.new(
			1,
			-15,
			0.5,
			0
		)

	check.Size =
		UDim2.fromOffset(
			31,
			31
		)

	check.BackgroundColor3 =
		C.Disabled

	check.BorderSizePixel = 0

	check.Text = ""

	check.TextColor3 =
		Color3.new(
			1,
			1,
			1
		)

	check.TextSize = 19

	check.Font =
		Enum.Font.GothamBold

	check.AutoButtonColor = false

	check.Parent =
		row

	Corner(
		check,
		8
	)

	--------------------------------------------------------

	local function Set(
		state
	)

		enabled = state

		Tween(
			dot,
			0.18,
			{
				Position =
					state
					and UDim2.fromOffset(
						27,
						11.5
					)
					or UDim2.fromOffset(
						11,
						11.5
					)
			}
		)

		Tween(
			check,
			0.16,
			{
				BackgroundColor3 =
					state
					and C.Accent
					or C.Disabled
			}
		)

		check.Text =
			state
			and "✓"
			or ""

		if callback then

			callback(
				state
			)

		end

	end

	check.MouseButton1Click:Connect(
		function()

			Set(
				not enabled
			)

		end
	)

	track.InputBegan:Connect(
		function(input)

			if input.UserInputType ==
				Enum.UserInputType.MouseButton1
			then

				Set(
					not enabled
				)

			end

		end
	)

	return {

		Set = Set,

		Get = function()

			return enabled

		end,

		Check = check,

		Track = track,
	}

end

------------------------------------------------------------
-- PRINCIPAL PAGE
------------------------------------------------------------

local WelcomeRow =
	CreateRow(
		PrincipalPage,
		"SOUZA PANEL",
		"Painel local de utilidades"
	)

local StatusRow,
	StatusTitle,
	StatusDescription =
	CreateRow(
		PrincipalPage,
		"Status",
		"Interface carregada"
	)

------------------------------------------------------------
-- VISUAL PAGE
------------------------------------------------------------

local PlatformLogoRow =
	CreateRow(
		VisualPage,
		"Logo na plataforma",
		"Sua logo aparece na parte superior do bloco"
	)

local UIInfoRow =
	CreateRow(
		VisualPage,
		"Interface",
		"Layout inspirado na referência enviada"
	)

------------------------------------------------------------
-- DIVERSOS - ELEVATOR
------------------------------------------------------------

local ElevatorRow,
	ElevatorTitle,
	ElevatorDescription =
	CreateRow(
		DiversosPage,
		"Elevador",
		"Nível 0 • desativado"
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
		155,
		40
	)

ElevatorControls.BackgroundTransparency = 1

ElevatorControls.Parent =
	ElevatorRow

------------------------------------------------------------
-- MINUS
------------------------------------------------------------

local Minus =
	Instance.new(
		"TextButton"
	)

Minus.Size =
	UDim2.fromOffset(
		40,
		40
	)

Minus.BackgroundColor3 =
	C.Disabled

Minus.BorderSizePixel = 0

Minus.Text = "−"

Minus.TextColor3 =
	C.Text

Minus.TextSize = 25

Minus.Font =
	Enum.Font.GothamBold

Minus.AutoButtonColor = false

Minus.Parent =
	ElevatorControls

Corner(
	Minus,
	8
)

------------------------------------------------------------
-- LEVEL
------------------------------------------------------------

local LevelText =
	Instance.new(
		"TextLabel"
	)

LevelText.Position =
	UDim2.fromOffset(
		47,
		0
	)

LevelText.Size =
	UDim2.fromOffset(
		60,
		40
	)

LevelText.BackgroundColor3 =
	C.Track

LevelText.BorderSizePixel = 0

LevelText.Text = "0"

LevelText.TextColor3 =
	Color3.fromRGB(
		18,
		24,
		30
	)

LevelText.TextSize = 15

LevelText.Font =
	Enum.Font.GothamBold

LevelText.Parent =
	ElevatorControls

Corner(
	LevelText,
	8
)

------------------------------------------------------------
-- PLUS
------------------------------------------------------------

local Plus =
	Instance.new(
		"TextButton"
	)

Plus.Position =
	UDim2.fromOffset(
		114,
		0
	)

Plus.Size =
	UDim2.fromOffset(
		40,
		40
	)

Plus.BackgroundColor3 =
	C.Accent

Plus.BorderSizePixel = 0

Plus.Text = "+"

Plus.TextColor3 =
	Color3.new(
		1,
		1,
		1
	)

Plus.TextSize = 24

Plus.Font =
	Enum.Font.GothamBold

Plus.AutoButtonColor = false

Plus.Parent =
	ElevatorControls

Corner(
	Plus,
	8
)

------------------------------------------------------------
-- UPDATE ELEVATOR
------------------------------------------------------------

local function UpdateElevator()

	LevelText.Text =
		tostring(
			Level
		)

	if Platform then

		ElevatorDescription.Text =
			"Nível "
			.. Level
			.. " • "
			.. string.format(
				"%.1f studs",
				math.max(
					Level - 1,
					0
				)
				* CONFIG.StepHeight
			)

	else

		ElevatorDescription.Text =
			"Nível 0 • desativado"

	end

end

------------------------------------------------------------
-- +
------------------------------------------------------------

Plus.MouseButton1Click:Connect(
	function()

		if not Root then
			return
		end

		if not Platform then

			CreatePlatform()

			Level = 1

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

		----------------------------------------------------
		-- Nível 1 = base
		-- Nível 2 = +2.2
		-- Nível 3 = +4.4
		----------------------------------------------------

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
-- -
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

			return

		end

		RemovePlatform()

		UpdateElevator()

	end
)

------------------------------------------------------------
-- DESCNY ROW
------------------------------------------------------------

local DescnyRow,
	DescnyTitle,
	DescnyDescription =
	CreateRow(
		DiversosPage,
		"DESCNY",
		"Procura item de invisibilidade"
	)

local DescnyToggle

DescnyToggle =
	CreateToggle(
		DescnyRow,

		function(state)

			if not state then

				DescnyDescription.Text =
					"Procura item de invisibilidade"

				return

			end

			local success, result =
				ActivateDescny()

			if success then

				DescnyDescription.Text =
					"Ativado • "
					.. tostring(
						result
					)

			else

				DescnyDescription.Text =
					tostring(
						result
					)

				task.delay(
					0.6,
					function()

						if DescnyToggle then

							DescnyToggle.Set(
								false
							)

						end

					end
				)

			end

		end
	)

------------------------------------------------------------
-- ANTILAG ROW
------------------------------------------------------------

local AntiLagRow,
	AntiLagTitle,
	AntiLagDescription =
	CreateRow(
		DiversosPage,
		"AntiLag",
		"Reduz partículas, efeitos e sombras"
	)

local AntiLagToggle =
	CreateToggle(
		AntiLagRow,

		function(state)

			if state then

				AntiLagDescription.Text =
					"Otimizando..."

				EnableAntiLag()

				task.delay(
					0.5,
					function()

						if AntiLagEnabled then

							AntiLagDescription.Text =
								"Otimização ativada"

						end

					end
				)

			else

				DisableAntiLag()

				AntiLagDescription.Text =
					"Reduz partículas, efeitos e sombras"

			end

		end
	)

------------------------------------------------------------
-- REMOVE PLATFORM ROW
------------------------------------------------------------

local RemoveRow =
	CreateRow(
		DiversosPage,
		"Remover plataforma",
		"Desativa o elevador imediatamente"
	)

local RemoveButton =
	Instance.new(
		"TextButton"
	)

RemoveButton.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

RemoveButton.Position =
	UDim2.new(
		1,
		-15,
		0.5,
		0
	)

RemoveButton.Size =
	UDim2.fromOffset(
		105,
		34
	)

RemoveButton.BackgroundColor3 =
	C.Disabled

RemoveButton.BorderSizePixel = 0

RemoveButton.Text =
	"REMOVER"

RemoveButton.TextColor3 =
	C.Text

RemoveButton.TextSize = 11

RemoveButton.Font =
	Enum.Font.GothamBold

RemoveButton.Parent =
	RemoveRow

Corner(
	RemoveButton,
	8
)

RemoveButton.MouseButton1Click:Connect(
	function()

		RemovePlatform()

		UpdateElevator()

	end
)

------------------------------------------------------------
-- AJUSTES PAGE
------------------------------------------------------------

local ThemeRow =
	CreateRow(
		AjustesPage,
		"Tema escuro",
		"Mantém o visual preto/azul da referência"
	)

CreateToggle(
	ThemeRow,
	function(state)

		if state then

			Tween(
				Main,
				0.25,
				{
					BackgroundColor3 =
						Color3.fromRGB(
							0,
							3,
							7
						)
				}
			)

		else

			Tween(
				Main,
				0.25,
				{
					BackgroundColor3 =
						C.Background
				}
			)

		end

	end
)

------------------------------------------------------------
-- CONTA
------------------------------------------------------------

CreateRow(
	ContaPage,
	"Jogador",
	Player.DisplayName
	.. "  @"
	.. Player.Name
)

CreateRow(
	ContaPage,
	"User ID",
	tostring(
		Player.UserId
	)
)

------------------------------------------------------------
-- DRAG MAIN WINDOW
------------------------------------------------------------

local WindowDragging = false

local WindowDragStart

local WindowStartPosition

Header.Active = true

Header.InputBegan:Connect(
	function(input)

		if input.UserInputType ~=
			Enum.UserInputType.MouseButton1
		then

			return

		end

		WindowDragging = true

		WindowDragStart =
			input.Position

		WindowStartPosition =
			Main.Position

	end
)

UIS.InputChanged:Connect(
	function(input)

		if not WindowDragging then
			return
		end

		if input.UserInputType ~=
			Enum.UserInputType.MouseMovement
		then

			return

		end

		local delta =
			input.Position
			- WindowDragStart

		Main.Position =
			UDim2.new(

				WindowStartPosition.X.Scale,

				WindowStartPosition.X.Offset
				+ delta.X,

				WindowStartPosition.Y.Scale,

				WindowStartPosition.Y.Offset
				+ delta.Y

			)

	end
)

UIS.InputEnded:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
		then

			WindowDragging = false

		end

	end
)

------------------------------------------------------------
-- FLOATING BUTTON
------------------------------------------------------------

local MiniHolder =
	Instance.new(
		"Frame"
	)

MiniHolder.Name =
	"FloatingButton"

-- IMPORTANTE:
-- NÃO começa mais no centro.
MiniHolder.Position =
	UDim2.fromOffset(
		25,
		170
	)

MiniHolder.Size =
	UDim2.fromOffset(
		64,
		64
	)

MiniHolder.BackgroundColor3 =
	Color3.fromRGB(
		10,
		14,
		20
	)

MiniHolder.BorderSizePixel = 0

MiniHolder.Visible = false

MiniHolder.Active = true

MiniHolder.ZIndex = 100

MiniHolder.Parent =
	GUI

Corner(
	MiniHolder,
	32
)

Stroke(
	MiniHolder,
	C.Accent,
	2,
	0.05
)

------------------------------------------------------------
-- FALLBACK LETTER
------------------------------------------------------------

local MiniBackup =
	Instance.new(
		"TextLabel"
	)

MiniBackup.Size =
	UDim2.fromScale(
		1,
		1
	)

MiniBackup.BackgroundTransparency = 1

MiniBackup.Text = "S"

MiniBackup.TextColor3 =
	C.Accent

MiniBackup.TextSize = 30

MiniBackup.Font =
	Enum.Font.GothamBlack

MiniBackup.ZIndex = 101

MiniBackup.Parent =
	MiniHolder

------------------------------------------------------------
-- LOGO
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
		54,
		54
	)

MiniLogo.BackgroundTransparency = 1

MiniLogo.Image =
	CONFIG.Logo

MiniLogo.ScaleType =
	Enum.ScaleType.Fit

MiniLogo.ZIndex = 102

MiniLogo.Parent =
	MiniHolder

------------------------------------------------------------
-- MINI HITBOX
------------------------------------------------------------

local MiniHitbox =
	Instance.new(
		"TextButton"
	)

MiniHitbox.Size =
	UDim2.fromScale(
		1,
		1
	)

MiniHitbox.BackgroundTransparency = 1

MiniHitbox.Text = ""

MiniHitbox.AutoButtonColor = false

MiniHitbox.Active = true

MiniHitbox.ZIndex = 103

MiniHitbox.Parent =
	MiniHolder

------------------------------------------------------------
-- MINIMIZE / RESTORE
------------------------------------------------------------

local Minimized = false

local function MinimizeUI()

	if Minimized then
		return
	end

	Minimized = true

	Tween(
		MainScale,
		0.12,
		{
			Scale = 0.88
		}
	)

	task.delay(
		0.1,
		function()

			Main.Visible = false

			MiniHolder.Visible = true

		end
	)

end

local function RestoreUI()

	if not Minimized then
		return
	end

	Minimized = false

	MiniHolder.Visible = false

	Main.Visible = true

	MainScale.Scale = 0.88

	Tween(
		MainScale,
		0.18,
		{
			Scale = 1
		}
	)

end

Minimize.MouseButton1Click:Connect(
	MinimizeUI
)

------------------------------------------------------------
-- FIX PRINCIPAL:
-- CÍRCULO 100% ARRASTÁVEL
------------------------------------------------------------

local MiniDragging = false

local MiniMoved = false

local MiniDragStart

local MiniStartPosition

local DRAG_THRESHOLD = 6

------------------------------------------------------------
-- KEEP INSIDE SCREEN
------------------------------------------------------------

local function ClampMini(
	x,
	y
)

	local camera =
		workspace.CurrentCamera

	if not camera then

		return x, y

	end

	local viewport =
		camera.ViewportSize

	local width =
		MiniHolder.AbsoluteSize.X

	local height =
		MiniHolder.AbsoluteSize.Y

	x =
		math.clamp(
			x,
			5,
			viewport.X
				- width
				- 5
		)

	y =
		math.clamp(
			y,
			5,
			viewport.Y
				- height
				- 5
		)

	return x, y
end

------------------------------------------------------------
-- BEGIN DRAG
------------------------------------------------------------

MiniHitbox.InputBegan:Connect(
	function(input)

		if input.UserInputType ~=
			Enum.UserInputType.MouseButton1
		then

			return

		end

		MiniDragging = true

		MiniMoved = false

		MiniDragStart =
			input.Position

		MiniStartPosition =
			MiniHolder.Position

	end
)

------------------------------------------------------------
-- DRAG
------------------------------------------------------------

UIS.InputChanged:Connect(
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

		if delta.Magnitude >
			DRAG_THRESHOLD
		then

			MiniMoved = true

		end

		if not MiniMoved then
			return
		end

		local newX =
			MiniStartPosition.X.Offset
			+ delta.X

		local newY =
			MiniStartPosition.Y.Offset
			+ delta.Y

		newX, newY =
			ClampMini(
				newX,
				newY
			)

		MiniHolder.Position =
			UDim2.fromOffset(
				newX,
				newY
			)

	end
)

------------------------------------------------------------
-- RELEASE
------------------------------------------------------------

UIS.InputEnded:Connect(
	function(input)

		if input.UserInputType ~=
			Enum.UserInputType.MouseButton1
		then

			return

		end

		if not MiniDragging then
			return
		end

		MiniDragging = false

		----------------------------------------------------
		-- Se quase não moveu = clique.
		-- Se moveu = NÃO abre a janela.
		----------------------------------------------------

		if not MiniMoved then

			RestoreUI()

		end

	end
)

------------------------------------------------------------
-- MOON ANIMATION
------------------------------------------------------------

local Darker = false

Moon.MouseButton1Click:Connect(
	function()

		Darker =
			not Darker

		if Darker then

			Content.BackgroundColor3 =
				Color3.fromRGB(
					1,
					4,
					8
				)

			Sidebar.BackgroundColor3 =
				Color3.fromRGB(
					0,
					3,
					7
				)

		else

			Content.BackgroundColor3 =
				C.Background

			Sidebar.BackgroundColor3 =
				C.Sidebar

		end

	end
)

------------------------------------------------------------
-- RESPAWN SAFETY
------------------------------------------------------------

Player.CharacterRemoving:Connect(
	function()

		RemovePlatform()

		UpdateElevator()

	end
)

------------------------------------------------------------
-- DEFAULT PAGE
------------------------------------------------------------

SetPage(
	"Diversos"
)

UpdateElevator()
