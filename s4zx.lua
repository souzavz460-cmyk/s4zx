--[[
============================================================
                 SOUZA ADMIN PANEL V10
                   MOBILE • 1 LOCALSCRIPT
============================================================

StarterPlayer
    > StarterPlayerScripts
        > LocalScript

ABAS:
    PRINCIPAL
        • Elevador
        • TP FROM
        • DESCNY
        • AntiLag

    VISUAIS
        • XRay
        • ESP Line
        • ESP Box
        • Chams
        • Categoria ESP

    DIVERSOS
        • Remover plataforma
        • Desligar visuais

    AJUSTES
        • Temas
        • Força XRay
        • Distância ESP
        • Escala da interface

TEMAS:
    • Ember
    • Violet
    • Ocean
    • Crimson
    • Mono

MOBILE:
    • Arrastar menu pelo header
    • Fechar => bolinha
    • Tocar bolinha => abre
    • Segurar + arrastar => move
============================================================
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
	Player:WaitForChild(
		"PlayerGui"
	)

------------------------------------------------------------
-- CAMERA
------------------------------------------------------------

local Camera =
	workspace.CurrentCamera

while not Camera do

	task.wait()

	Camera =
		workspace.CurrentCamera

end

------------------------------------------------------------
-- CONFIG
------------------------------------------------------------

local CONFIG = {

	--------------------------------------------------------
	-- LOGO
	--------------------------------------------------------

	Logo =
		"rbxthumb://type=Asset&id=98880379063768&w=420&h=420",

	--------------------------------------------------------
	-- UI
	--------------------------------------------------------

	Width = 700,

	Height = 430,

	SidebarWidth = 155,

	UIScale = 1,

	--------------------------------------------------------
	-- ELEVATOR
	--------------------------------------------------------

	PlatformSize =
		Vector3.new(
			6.5,
			0.65,
			6.5
		),

	StepHeight = 2.1,

	MaxLevel = 25,

	ElevatorDuration = 0.23,

	RecoveryHorizontal = 14,

	RecoveryVertical = 9,

	--------------------------------------------------------
	-- TP FROM
	--------------------------------------------------------

	TPMaxDistance = 35,

	--------------------------------------------------------
	-- XRAY
	--------------------------------------------------------

	XRayTransparency = 0.68,

	--------------------------------------------------------
	-- ESP
	--------------------------------------------------------

	ESPDistance = 450,

	ESPUpdateRate = 1 / 20,
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
-- THEMES
------------------------------------------------------------

local THEMES = {

	--------------------------------------------------------
	-- EMBER
	--------------------------------------------------------

	Ember = {

		Display = "EMBER",

		BG =
			Color3.fromRGB(
				5,
				9,
				15
			),

		BG2 =
			Color3.fromRGB(
				9,
				15,
				24
			),

		Sidebar =
			Color3.fromRGB(
				3,
				7,
				12
			),

		Card =
			Color3.fromRGB(
				17,
				27,
				40
			),

		CardHover =
			Color3.fromRGB(
				23,
				36,
				51
			),

		Control =
			Color3.fromRGB(
				7,
				15,
				25
			),

		Stroke =
			Color3.fromRGB(
				35,
				48,
				63
			),

		StrokeSoft =
			Color3.fromRGB(
				25,
				37,
				50
			),

		Text =
			Color3.fromRGB(
				246,
				248,
				251
			),

		Sub =
			Color3.fromRGB(
				156,
				169,
				185
			),

		Muted =
			Color3.fromRGB(
				88,
				104,
				124
			),

		Accent =
			Color3.fromRGB(
				255,
				76,
				22
			),

		Accent2 =
			Color3.fromRGB(
				255,
				119,
				52
			),
	},

	--------------------------------------------------------
	-- VIOLET
	--------------------------------------------------------

	Violet = {

		Display = "VIOLET",

		BG =
			Color3.fromRGB(
				7,
				6,
				15
			),

		BG2 =
			Color3.fromRGB(
				14,
				11,
				28
			),

		Sidebar =
			Color3.fromRGB(
				5,
				4,
				12
			),

		Card =
			Color3.fromRGB(
				22,
				19,
				38
			),

		CardHover =
			Color3.fromRGB(
				31,
				27,
				52
			),

		Control =
			Color3.fromRGB(
				12,
				9,
				25
			),

		Stroke =
			Color3.fromRGB(
				50,
				43,
				75
			),

		StrokeSoft =
			Color3.fromRGB(
				36,
				31,
				57
			),

		Text =
			Color3.fromRGB(
				248,
				246,
				255
			),

		Sub =
			Color3.fromRGB(
				173,
				163,
				199
			),

		Muted =
			Color3.fromRGB(
				109,
				96,
				140
			),

		Accent =
			Color3.fromRGB(
				138,
				86,
				255
			),

		Accent2 =
			Color3.fromRGB(
				172,
				126,
				255
			),
	},

	--------------------------------------------------------
	-- OCEAN
	--------------------------------------------------------

	Ocean = {

		Display = "OCEAN",

		BG =
			Color3.fromRGB(
				3,
				10,
				16
			),

		BG2 =
			Color3.fromRGB(
				7,
				20,
				30
			),

		Sidebar =
			Color3.fromRGB(
				2,
				8,
				13
			),

		Card =
			Color3.fromRGB(
				12,
				29,
				41
			),

		CardHover =
			Color3.fromRGB(
				17,
				39,
				54
			),

		Control =
			Color3.fromRGB(
				5,
				17,
				26
			),

		Stroke =
			Color3.fromRGB(
				28,
				58,
				75
			),

		StrokeSoft =
			Color3.fromRGB(
				20,
				43,
				58
			),

		Text =
			Color3.fromRGB(
				243,
				250,
				255
			),

		Sub =
			Color3.fromRGB(
				146,
				181,
				199
			),

		Muted =
			Color3.fromRGB(
				79,
				123,
				145
			),

		Accent =
			Color3.fromRGB(
				35,
				166,
				255
			),

		Accent2 =
			Color3.fromRGB(
				82,
				194,
				255
			),
	},

	--------------------------------------------------------
	-- CRIMSON
	--------------------------------------------------------

	Crimson = {

		Display = "CRIMSON",

		BG =
			Color3.fromRGB(
				13,
				4,
				7
			),

		BG2 =
			Color3.fromRGB(
				25,
				7,
				11
			),

		Sidebar =
			Color3.fromRGB(
				9,
				3,
				5
			),

		Card =
			Color3.fromRGB(
				37,
				14,
				20
			),

		CardHover =
			Color3.fromRGB(
				51,
				18,
				27
			),

		Control =
			Color3.fromRGB(
				22,
				7,
				11
			),

		Stroke =
			Color3.fromRGB(
				73,
				29,
				40
			),

		StrokeSoft =
			Color3.fromRGB(
				55,
				21,
				31
			),

		Text =
			Color3.fromRGB(
				255,
				245,
				248
			),

		Sub =
			Color3.fromRGB(
				204,
				154,
				166
			),

		Muted =
			Color3.fromRGB(
				143,
				84,
				99
			),

		Accent =
			Color3.fromRGB(
				239,
				48,
				82
			),

		Accent2 =
			Color3.fromRGB(
				255,
				89,
				116
			),
	},

	--------------------------------------------------------
	-- MONO
	--------------------------------------------------------

	Mono = {

		Display = "MONO",

		BG =
			Color3.fromRGB(
				7,
				7,
				9
			),

		BG2 =
			Color3.fromRGB(
				14,
				14,
				18
			),

		Sidebar =
			Color3.fromRGB(
				4,
				4,
				6
			),

		Card =
			Color3.fromRGB(
				22,
				22,
				27
			),

		CardHover =
			Color3.fromRGB(
				31,
				31,
				38
			),

		Control =
			Color3.fromRGB(
				12,
				12,
				16
			),

		Stroke =
			Color3.fromRGB(
				54,
				54,
				65
			),

		StrokeSoft =
			Color3.fromRGB(
				39,
				39,
				48
			),

		Text =
			Color3.fromRGB(
				250,
				250,
				252
			),

		Sub =
			Color3.fromRGB(
				174,
				174,
				184
			),

		Muted =
			Color3.fromRGB(
				108,
				108,
				122
			),

		Accent =
			Color3.fromRGB(
				225,
				225,
				233
			),

		Accent2 =
			Color3.fromRGB(
				255,
				255,
				255
			),
	},
}

------------------------------------------------------------
-- THEME STATE
------------------------------------------------------------

local ThemeOrder = {

	"Ember",

	"Violet",

	"Ocean",

	"Crimson",

	"Mono"
}

local ThemeIndex =
	1

local CurrentThemeName =
	ThemeOrder[
		ThemeIndex
	]

------------------------------------------------------------

local function Theme()

	return THEMES[
		CurrentThemeName
	]

end

------------------------------------------------------------
-- THEME BINDINGS
------------------------------------------------------------

local ThemeBindings =
	{}

local ThemeGradients =
	{}

------------------------------------------------------------

local function BindTheme(
	Object,
	Property,
	Key
)

	table.insert(
		ThemeBindings,
		{
			Object = Object,
			Property = Property,
			Key = Key
		}
	)

	local Value =
		Theme()[
			Key
		]

	if Value ~= nil then

		Object[
			Property
		] =
			Value

	end

end

------------------------------------------------------------

local function BindGradient(
	Gradient,
	Type
)

	table.insert(
		ThemeGradients,
		{
			Object = Gradient,
			Type = Type
		}
	)

end

------------------------------------------------------------
-- TWEEN HELPER
------------------------------------------------------------

local function Tween(
	Object,
	Time,
	Properties
)

	local T =
		TweenService:Create(

			Object,

			TweenInfo.new(
				Time,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.Out
			),

			Properties
		)

	T:Play()

	return T

end

------------------------------------------------------------
-- APPLY THEME
------------------------------------------------------------

local function ApplyTheme(
	Name,
	Animate
)

	if not THEMES[
		Name
	] then

		return

	end

	CurrentThemeName =
		Name

	local T =
		Theme()

	--------------------------------------------------------
	-- NORMAL PROPERTIES
	--------------------------------------------------------

	for _,
		Binding
		in ipairs(
			ThemeBindings
		)
	do

		local Object =
			Binding.Object

		if Object
			and Object.Parent
		then

			local Value =
				T[
					Binding.Key
				]

			if Value ~= nil then

				if Animate
					and typeof(
						Value
					) == "Color3"
				then

					Tween(
						Object,
						0.22,
						{
							[
								Binding.Property
							] = Value
						}
					)

				else

					Object[
						Binding.Property
					] =
						Value

				end
			end
		end
	end

	--------------------------------------------------------
	-- GRADIENTS
	--------------------------------------------------------

	for _,
		Data
		in ipairs(
			ThemeGradients
		)
	do

		local Gradient =
			Data.Object

		if Gradient
			and Gradient.Parent
		then

			if Data.Type ==
				"Main"
			then

				Gradient.Color =
					ColorSequence.new({

						ColorSequenceKeypoint.new(
							0,
							T.BG2
						),

						ColorSequenceKeypoint.new(
							0.55,
							T.BG
						),

						ColorSequenceKeypoint.new(
							1,
							T.Control
						)

					})

			elseif Data.Type ==
				"Sidebar"
			then

				Gradient.Color =
					ColorSequence.new({

						ColorSequenceKeypoint.new(
							0,
							T.BG2
						),

						ColorSequenceKeypoint.new(
							1,
							T.Sidebar
						)

					})

			end
		end
	end
end

------------------------------------------------------------
-- UI HELPERS
------------------------------------------------------------

local function Corner(
	Object,
	Radius
)

	local Value =
		Instance.new(
			"UICorner"
		)

	Value.CornerRadius =
		UDim.new(
			0,
			Radius
		)

	Value.Parent =
		Object

	return Value
end

------------------------------------------------------------

local function Stroke(
	Object,
	Key,
	Thickness,
	Transparency
)

	local Value =
		Instance.new(
			"UIStroke"
		)

	Value.Thickness =
		Thickness or 1

	Value.Transparency =
		Transparency or 0

	Value.Parent =
		Object

	BindTheme(
		Value,
		"Color",
		Key or "Stroke"
	)

	return Value
end

------------------------------------------------------------
-- CLEAN OLD GUI
------------------------------------------------------------

for _,
	Name
	in ipairs({

		"SouzaAdminV10",

		"SouzaESP_V10"

	})
do

	local Existing =
		PlayerGui:FindFirstChild(
			Name
		)

	if Existing then

		Existing:Destroy()

	end
end

------------------------------------------------------------
-- OLD PLATFORM
------------------------------------------------------------

local ExistingPlatform =
	workspace:FindFirstChild(

		"SouzaAdminPlatform_"
		.. Player.UserId
	)

if ExistingPlatform then

	ExistingPlatform:Destroy()

end

------------------------------------------------------------
-- CHARACTER
------------------------------------------------------------

local Character

local Humanoid

local Root

------------------------------------------------------------

local function SetupCharacter(
	Char
)

	Character =
		Char

	Humanoid =
		Char:WaitForChild(
			"Humanoid"
		)

	Root =
		Char:WaitForChild(
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
	function(Char)

		task.wait(
			0.15
		)

		SetupCharacter(
			Char
		)

	end
)

------------------------------------------------------------
-- ========================================================
-- SAFE ELEVATOR
-- ========================================================
------------------------------------------------------------

local Platform =
	nil

local PlatformLevel =
	0

local ElevatorBusy =
	false

local PlatformHoldY =
	nil

local LastPlayerPosition =
	nil

------------------------------------------------------------
-- FEET
------------------------------------------------------------

local function GetFeetY()

	if not Root
		or not Humanoid
	then

		return nil

	end

	return Root.Position.Y

		- Humanoid.HipHeight

		- Root.Size.Y / 2
end

------------------------------------------------------------
-- DESTINATION SAFETY
------------------------------------------------------------

local function ElevatorDestinationClear(
	DeltaY
)

	if not Character then

		return false

	end

	local Success,
		CF,
		Size =
		pcall(
			function()

				local BoxCF,
					BoxSize =
					Character:GetBoundingBox()

				return
					BoxCF,
					BoxSize

			end
		)

	if not Success
		or not CF
	then

		return true

	end

	local SafeSize =
		Vector3.new(

			Size.X * 0.70,

			Size.Y * 0.78,

			Size.Z * 0.70
		)

	local Target =
		CF

		+ Vector3.new(
			0,
			DeltaY,
			0
		)

	local Params =
		OverlapParams.new()

	Params.FilterType =
		Enum.RaycastFilterType.Exclude

	local Ignore = {

		Character
	}

	if Platform then

		table.insert(
			Ignore,
			Platform
		)

	end

	Params.FilterDescendantsInstances =
		Ignore

	local Parts =
		workspace:GetPartBoundsInBox(

			Target,

			SafeSize,

			Params

		)

	for _,
		Part
		in ipairs(
			Parts
		)
	do

		if Part:IsA(
			"BasePart"
		)
			and Part.CanCollide
		then

			return false

		end
	end

	return true

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

	if not Root
		or not Humanoid
	then

		return

	end

	local Feet =
		GetFeetY()

	if not Feet then

		return

	end

	PlatformHoldY =
		Feet

		- CONFIG.PlatformSize.Y / 2

		- 0.04

	LastPlayerPosition =
		Root.Position

	--------------------------------------------------------
	-- PART
	--------------------------------------------------------

	Platform =
		Instance.new(
			"Part"
		)

	Platform.Name =
		"SouzaAdminPlatform_"
		.. Player.UserId

	Platform.Size =
		CONFIG.PlatformSize

	Platform.Anchored =
		true

	Platform.CanCollide =
		true

	Platform.CanTouch =
		false

	Platform.CanQuery =
		false

	Platform.CastShadow =
		false

	Platform.Material =
		Enum.Material.SmoothPlastic

	Platform.Color =
		Color3.fromRGB(
			11,
			17,
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

			PlatformHoldY,

			Root.Position.Z

		)

	Platform.Parent =
		workspace

	--------------------------------------------------------
	-- TOP GUI
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
		45

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
		Theme().BG2

	BG.BorderSizePixel =
		0

	BG.Parent =
		Surface

	BindTheme(
		BG,
		"BackgroundColor3",
		"BG2"
	)

	--------------------------------------------------------

	local G =
		Instance.new(
			"UIGradient"
		)

	G.Rotation =
		35

	G.Parent =
		BG

	BindGradient(
		G,
		"Main"
	)

	--------------------------------------------------------

	Stroke(
		BG,
		"Accent",
		3,
		0.05
	)

	--------------------------------------------------------
	-- FALLBACK
	--------------------------------------------------------

	local Fallback =
		Instance.new(
			"TextLabel"
		)

	Fallback.Size =
		UDim2.fromScale(
			1,
			1
		)

	Fallback.BackgroundTransparency =
		1

	Fallback.Text =
		"S"

	Fallback.TextTransparency =
		0.72

	Fallback.TextScaled =
		true

	Fallback.FontFace =
		FONT_BOLD

	Fallback.Parent =
		BG

	BindTheme(
		Fallback,
		"TextColor3",
		"Accent"
	)

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

	ElevatorBusy =
		false

	PlatformLevel =
		0

	PlatformHoldY =
		nil

	LastPlayerPosition =
		nil

	if Platform then

		Platform:Destroy()

		Platform =
			nil

	end

end

------------------------------------------------------------
-- REBASE
------------------------------------------------------------

local function RebasePlatform()

	if not Platform
		or not Root
	then

		return

	end

	local Feet =
		GetFeetY()

	if not Feet then

		return

	end

	PlatformHoldY =
		Feet

		- Platform.Size.Y / 2

		- 0.04

	Platform.CFrame =
		CFrame.new(

			Root.Position.X,

			PlatformHoldY,

			Root.Position.Z

		)

	LastPlayerPosition =
		Root.Position

end

------------------------------------------------------------
-- MOVE ELEVATOR
------------------------------------------------------------

local function MoveElevator(
	Direction
)

	if ElevatorBusy then

		return false,
			"Elevador ocupado"

	end

	if not Character
		or not Root
		or not Humanoid
	then

		return false,
			"Personagem indisponível"

	end

	--------------------------------------------------------
	-- FIRST +
	--------------------------------------------------------

	if not Platform then

		if Direction < 0 then

			return false,
				"Desativado"

		end

		CreatePlatform()

		PlatformLevel =
			1

		return true,
			"Nível 1"

	end

	--------------------------------------------------------

	local NewLevel =
		PlatformLevel
		+ Direction

	if NewLevel <= 0 then

		RemovePlatform()

		return true,
			"Desativado"

	end

	NewLevel =
		math.clamp(

			NewLevel,

			1,

			CONFIG.MaxLevel

		)

	if NewLevel ==
		PlatformLevel
	then

		return false,
			"Limite"

	end

	local DeltaY =
		(
			NewLevel
			- PlatformLevel
		)

		* CONFIG.StepHeight

	--------------------------------------------------------
	-- SAFETY
	--------------------------------------------------------

	if not ElevatorDestinationClear(
		DeltaY
	) then

		return false,
			"Espaço bloqueado"

	end

	ElevatorBusy =
		true

	Platform.CanCollide =
		false

	--------------------------------------------------------
	-- START
	--------------------------------------------------------

	local StartPivot =
		Character:GetPivot()

	local StartPlatform =
		Platform.CFrame

	local Elapsed =
		0

	--------------------------------------------------------

	while Elapsed <
		CONFIG.ElevatorDuration
	do

		local DT =
			RunService.Heartbeat:Wait()

		Elapsed +=
			DT

		if not Character
			or not Character.Parent
			or not Platform
			or not Platform.Parent
		then

			ElevatorBusy =
				false

			return false,
				"Interrompido"

		end

		local Alpha =
			math.clamp(

				Elapsed
				/ CONFIG.ElevatorDuration,

				0,

				1

			)

		----------------------------------------------------
		-- SMOOTHSTEP
		----------------------------------------------------

		local Smooth =
			Alpha
			* Alpha
			* (
				3
				- 2
				* Alpha
			)

		local Offset =
			Vector3.new(

				0,

				DeltaY
				* Smooth,

				0

			)

		----------------------------------------------------

		Character:PivotTo(

			StartPivot
			+ Offset

		)

		Platform.CFrame =
			StartPlatform
			+ Offset

	end

	--------------------------------------------------------

	PlatformLevel =
		NewLevel

	PlatformHoldY =
		Platform.Position.Y

	if Root then

		Root.AssemblyLinearVelocity =
			Vector3.zero

		Root.AssemblyAngularVelocity =
			Vector3.zero

	end

	Platform.CanCollide =
		true

	LastPlayerPosition =
		Root.Position

	ElevatorBusy =
		false

	return true,
		"Nível "
		.. PlatformLevel

end

------------------------------------------------------------
-- ELEVATOR FOLLOW
------------------------------------------------------------

RunService.Heartbeat:Connect(
	function()

		if ElevatorBusy then

			return

		end

		if not Platform
			or not Platform.Parent
			or not Root
			or not Root.Parent
			or not Humanoid
			or Humanoid.Health <= 0
		then

			return

		end

		----------------------------------------------------
		-- GAME MOVED PLAYER
		----------------------------------------------------

		if LastPlayerPosition then

			local Difference =
				Root.Position
				- LastPlayerPosition

			local Horizontal =
				Vector2.new(

					Difference.X,

					Difference.Z

				).Magnitude

			local Vertical =
				math.abs(
					Difference.Y
				)

			if Horizontal >
				CONFIG.RecoveryHorizontal

				or

				Vertical >
				CONFIG.RecoveryVertical
			then

				RebasePlatform()

				return

			end

		end

		LastPlayerPosition =
			Root.Position

		----------------------------------------------------
		-- FOLLOW X/Z ONLY
		----------------------------------------------------

		Platform.CFrame =
			CFrame.new(

				Root.Position.X,

				PlatformHoldY,

				Root.Position.Z

			)

	end
)

------------------------------------------------------------
-- ========================================================
-- DESCNY
-- ========================================================
------------------------------------------------------------

local InvisKeywords = {

	"invis",

	"invisible",

	"invisibility",

	"cloak",

	"capa",

	"descny",

	"vanish",

	"ghost"
}

------------------------------------------------------------

local function IsInvisibleTool(
	Object
)

	if not Object:IsA(
		"Tool"
	) then

		return false

	end

	if Object:GetAttribute(
		"Invisibility"
	) == true

		or

		Object:GetAttribute(
			"Invisible"
		) == true

		or

		Object:GetAttribute(
			"Descny"
		) == true
	then

		return true

	end

	local Search =
		string.lower(

			Object.Name

			.. " "

			.. Object.ToolTip

		)

	for _,
		Word
		in ipairs(
			InvisKeywords
		)
	do

		if string.find(

			Search,

			Word,

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

		for _,
			Object
			in ipairs(
				Character:GetChildren()
			)
		do

			if IsInvisibleTool(
				Object
			) then

				return Object

			end

		end

	end

	--------------------------------------------------------

	local Backpack =
		Player:FindFirstChildOfClass(
			"Backpack"
		)

	if Backpack then

		for _,
			Object
			in ipairs(
				Backpack:GetChildren()
			)
		do

			if IsInvisibleTool(
				Object
			) then

				return Object

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
		FindInvisibleTool()

	if not Tool then

		return false,
			"Item não encontrado"

	end

	--------------------------------------------------------

	if Tool.Parent ~=
		Character
	then

		pcall(
			function()

				Humanoid:EquipTool(
					Tool
				)

			end
		)

		task.wait(
			0.1
		)

	end

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
-- ========================================================
-- TP FROM V10
-- ========================================================
------------------------------------------------------------

local TPBusy =
	false

------------------------------------------------------------
-- CLEAR DESTINATION
------------------------------------------------------------

local function TPPositionClear(
	Position,
	IgnoreWall
)

	if not Character then

		return false

	end

	local _,
		CharacterSize =
		Character:GetBoundingBox()

	local Size =
		Vector3.new(

			math.max(
				CharacterSize.X
					* 0.65,
				2
			),

			math.max(
				CharacterSize.Y
					* 0.75,
				3
			),

			math.max(
				CharacterSize.Z
					* 0.65,
				2
			)

		)

	local Params =
		OverlapParams.new()

	Params.FilterType =
		Enum.RaycastFilterType.Exclude

	local Ignore = {

		Character
	}

	if Platform then

		table.insert(
			Ignore,
			Platform
		)

	end

	if IgnoreWall then

		table.insert(
			Ignore,
			IgnoreWall
		)

	end

	Params.FilterDescendantsInstances =
		Ignore

	local Parts =
		workspace:GetPartBoundsInBox(

			CFrame.new(
				Position
			),

			Size,

			Params

		)

	for _,
		Part
		in ipairs(
			Parts
		)
	do

		if Part:IsA(
			"BasePart"
		)
			and Part.CanCollide
		then

			return false

		end

	end

	return true

end

------------------------------------------------------------
-- WALL EXIT
------------------------------------------------------------

local function CalculateWallExit(
	Part,
	HitPosition,
	WorldDirection
)

	WorldDirection =
		WorldDirection.Unit

	local Inside =
		HitPosition

		+ WorldDirection
		* 0.05

	local Origin =
		Part.CFrame:PointToObjectSpace(
			Inside
		)

	local Direction =
		Part.CFrame:VectorToObjectSpace(
			WorldDirection
		)

	local Half =
		Part.Size / 2

	local Tmin =
		-math.huge

	local Tmax =
		math.huge

	--------------------------------------------------------

	local function Axis(
		O,
		D,
		H
	)

		if math.abs(
			D
		) < 0.00001
		then

			return O >= -H
				and O <= H

		end

		local A =
			(
				-H
				- O
			)
			/ D

		local B =
			(
				H
				- O
			)
			/ D

		if A > B then

			A,
				B =
				B,
				A

		end

		Tmin =
			math.max(
				Tmin,
				A
			)

		Tmax =
			math.min(
				Tmax,
				B
			)

		return Tmin <=
			Tmax

	end

	--------------------------------------------------------

	if not Axis(
		Origin.X,
		Direction.X,
		Half.X
	) then

		return nil

	end

	if not Axis(
		Origin.Y,
		Direction.Y,
		Half.Y
	) then

		return nil

	end

	if not Axis(
		Origin.Z,
		Direction.Z,
		Half.Z
	) then

		return nil

	end

	if Tmax < 0
		or Tmax ==
			math.huge
	then

		return nil

	end

	--------------------------------------------------------

	local LocalExit =
		Origin

		+ Direction

		* (
			Tmax
			+ 0.05
		)

	return Part.CFrame:PointToWorldSpace(
		LocalExit
	)

end

------------------------------------------------------------
-- TP
------------------------------------------------------------

local function TPFrom()

	if TPBusy then

		return false,
			"Aguarde"

	end

	if not Root
		or not Character
		or not Humanoid
	then

		return false,
			"Personagem indisponível"

	end

	TPBusy =
		true

	--------------------------------------------------------
	-- DIRECTION
	--------------------------------------------------------

	local Look =
		Camera.CFrame.LookVector

	local Direction =
		Vector3.new(

			Look.X,

			0,

			Look.Z

		)

	if Direction.Magnitude <
		0.05
	then

		Direction =
			Vector3.new(

				Root.CFrame.LookVector.X,

				0,

				Root.CFrame.LookVector.Z

			)

	end

	Direction =
		Direction.Unit

	--------------------------------------------------------
	-- RAY
	--------------------------------------------------------

	local Params =
		RaycastParams.new()

	Params.FilterType =
		Enum.RaycastFilterType.Exclude

	local Ignore = {

		Character
	}

	if Platform then

		table.insert(
			Ignore,
			Platform
		)

	end

	Params.FilterDescendantsInstances =
		Ignore

	Params.IgnoreWater =
		true

	--------------------------------------------------------

	local Result =
		workspace:Raycast(

			Root.Position

			+ Vector3.new(
				0,
				0.5,
				0
			),

			Direction
				* CONFIG.TPMaxDistance,

			Params

		)

	if not Result then

		TPBusy =
			false

		return false,
			"Sem parede na frente"

	end

	--------------------------------------------------------

	local Wall =
		Result.Instance

	if not Wall:IsA(
		"BasePart"
	) then

		TPBusy =
			false

		return false,
			"Objeto incompatível"

	end

	if math.abs(
		Result.Normal.Y
	) > 0.7
	then

		TPBusy =
			false

		return false,
			"Aponte para uma parede"

	end

	--------------------------------------------------------

	local Exit =
		CalculateWallExit(

			Wall,

			Result.Position,

			Direction

		)

	if not Exit then

		TPBusy =
			false

		return false,
			"Não achei a saída"

	end

	--------------------------------------------------------
	-- FIND SAFE POSITION
	--------------------------------------------------------

	local Destination =
		nil

	for Distance =
		2.5,
		12,
		0.75
	do

		local Candidate =
			Exit

			+ Direction
			* Distance

		Candidate =
			Vector3.new(

				Candidate.X,

				Root.Position.Y,

				Candidate.Z

			)

		if TPPositionClear(

			Candidate,

			Wall

		) then

			Destination =
				Candidate

			break

		end

	end

	if not Destination then

		TPBusy =
			false

		return false,
			"Sem espaço do outro lado"

	end

	--------------------------------------------------------
	-- STOP MOMENTUM
	--------------------------------------------------------

	Root.AssemblyLinearVelocity =
		Vector3.zero

	Root.AssemblyAngularVelocity =
		Vector3.zero

	--------------------------------------------------------
	-- TP ONCE
	--------------------------------------------------------

	Character:PivotTo(

		CFrame.lookAt(

			Destination,

			Destination
				+ Direction

		)

	)

	--------------------------------------------------------

	RunService.Heartbeat:Wait()

	RunService.Heartbeat:Wait()

	--------------------------------------------------------

	if Root then

		Root.AssemblyLinearVelocity =
			Vector3.zero

		Root.AssemblyAngularVelocity =
			Vector3.zero

	end

	--------------------------------------------------------

	if Platform then

		RebasePlatform()

	end

	TPBusy =
		false

	return true,
		"Atravessou "
		.. Wall.Name

end

------------------------------------------------------------
-- ========================================================
-- ANTILAG
-- ========================================================
------------------------------------------------------------

local AntiLagLevel =
	0

local AntiLagCache =
	{}

local AntiLagGeneration =
	0

------------------------------------------------------------

local function CacheProperty(
	Object,
	Property
)

	if not AntiLagCache[
		Object
	] then

		AntiLagCache[
			Object
		] = {}

	end

	if AntiLagCache[
		Object
	][Property] ~= nil
	then

		return

	end

	local Success,
		Value =
		pcall(
			function()

				return Object[
					Property
				]

			end
		)

	if Success then

		AntiLagCache[
			Object
		][Property] =
			Value

	end

end

------------------------------------------------------------

local function SetCached(
	Object,
	Property,
	Value
)

	CacheProperty(
		Object,
		Property
	)

	pcall(
		function()

			Object[
				Property
			] =
				Value

		end
	)

end

------------------------------------------------------------

local function OptimizeObject(
	Object,
	Level
)

	--------------------------------------------------------
	-- LEVE
	--------------------------------------------------------

	if Level >= 1 then

		if Object:IsA(
			"BloomEffect"
		)

			or Object:IsA(
				"BlurEffect"
			)

			or Object:IsA(
				"SunRaysEffect"
			)

			or Object:IsA(
				"DepthOfFieldEffect"
			)
		then

			SetCached(
				Object,
				"Enabled",
				false
			)

		end

	end

	--------------------------------------------------------
	-- MEDIUM
	--------------------------------------------------------

	if Level >= 2 then

		if Object:IsA(
			"ParticleEmitter"
		)

			or Object:IsA(
				"Trail"
			)

			or Object:IsA(
				"Beam"
			)

			or Object:IsA(
				"Smoke"
			)

			or Object:IsA(
				"Fire"
			)

			or Object:IsA(
				"Sparkles"
			)

			or Object:IsA(
				"PointLight"
			)

			or Object:IsA(
				"SpotLight"
			)

			or Object:IsA(
				"SurfaceLight"
			)
		then

			SetCached(
				Object,
				"Enabled",
				false
			)

		end

	end

	--------------------------------------------------------
	-- MAX
	--------------------------------------------------------

	if Level >= 3 then

		if Object:IsA(
			"BasePart"
		) then

			SetCached(
				Object,
				"CastShadow",
				false
			)

		end

		if Object:IsA(
			"MeshPart"
		) then

			pcall(
				function()

					SetCached(

						Object,

						"RenderFidelity",

						Enum.RenderFidelity.Performance

					)

				end
			)

		end

	end

end

------------------------------------------------------------
-- RESTORE ANTILAG
------------------------------------------------------------

local function RestoreAntiLag()

	AntiLagGeneration +=
		1

	for Object,
		Properties
		in pairs(
			AntiLagCache
		)
	do

		if Object then

			for Property,
				Value
				in pairs(
					Properties
				)
			do

				pcall(
					function()

						Object[
							Property
						] =
							Value

					end
				)

			end

		end

	end

	AntiLagCache =
		{}

end

------------------------------------------------------------
-- APPLY ANTILAG
------------------------------------------------------------

local function ApplyAntiLag(
	Level
)

	RestoreAntiLag()

	AntiLagLevel =
		Level

	if Level <= 0 then

		return

	end

	AntiLagGeneration +=
		1

	local Generation =
		AntiLagGeneration

	SetCached(
		Lighting,
		"GlobalShadows",
		false
	)

	if Level >= 2 then

		pcall(
			function()

				SetCached(

					workspace.Terrain,

					"Decoration",

					false

				)

			end
		)

	end

	--------------------------------------------------------
	-- WORK IN BATCH
	--------------------------------------------------------

	task.spawn(
		function()

			local List =
				workspace:GetDescendants()

			for Index,
				Object
				in ipairs(
					List
				)
			do

				if Generation ~=
					AntiLagGeneration
				then

					return

				end

				OptimizeObject(
					Object,
					Level
				)

				if Index % 150 ==
					0
				then

					RunService.Heartbeat:Wait()

				end

			end

			for _,
				Object
				in ipairs(
					Lighting:GetDescendants()
				)
			do

				OptimizeObject(
					Object,
					Level
				)

			end

		end
	)

end

------------------------------------------------------------
-- NEW OBJECT ANTILAG
------------------------------------------------------------

workspace.DescendantAdded:Connect(
	function(Object)

		if AntiLagLevel > 0 then

			task.defer(
				function()

					OptimizeObject(

						Object,

						AntiLagLevel

					)

				end
			)

		end

	end
)

------------------------------------------------------------
-- ========================================================
-- XRAY SAFE LOCAL
-- ========================================================
------------------------------------------------------------

local XRayEnabled =
	false

local XRayCache =
	{}

------------------------------------------------------------
-- PLAYER PART CHECK
------------------------------------------------------------

local function IsPlayerCharacterPart(
	Part
)

	for _,
		P
		in ipairs(
			Players:GetPlayers()
		)
	do

		local Char =
			P.Character

		if Char
			and Part:IsDescendantOf(
				Char
			)
		then

			return true

		end

	end

	return false

end

------------------------------------------------------------
-- XRAY ALLOWED
------------------------------------------------------------

local function CanXRayPart(
	Part
)

	if not Part:IsA(
		"BasePart"
	) then

		return false

	end

	if IsPlayerCharacterPart(
		Part
	) then

		return false

	end

	if Platform
		and Part ==
			Platform
	then

		return false

	end

	--------------------------------------------------------
	-- STATIC MAP ONLY
	--------------------------------------------------------

	if not Part.Anchored then

		return false

	end

	if Part.Transparency >=
		1
	then

		return false

	end

	if Part:GetAttribute(
		"NoXRay"
	) == true
	then

		return false

	end

	return true

end

------------------------------------------------------------
-- APPLY XRAY
------------------------------------------------------------

local function ApplyXRayPart(
	Part
)

	if not XRayEnabled then

		return

	end

	if not CanXRayPart(
		Part
	) then

		return

	end

	if XRayCache[
		Part
	] == nil
	then

		XRayCache[
			Part
		] =
			Part.LocalTransparencyModifier

	end

	Part.LocalTransparencyModifier =
		math.max(

			XRayCache[
				Part
			],

			CONFIG.XRayTransparency

		)

end

------------------------------------------------------------
-- ENABLE XRAY
------------------------------------------------------------

local function EnableXRay()

	if XRayEnabled then

		return

	end

	XRayEnabled =
		true

	task.spawn(
		function()

			local List =
				workspace:GetDescendants()

			for Index,
				Object
				in ipairs(
					List
				)
			do

				if not XRayEnabled then

					return

				end

				if Object:IsA(
					"BasePart"
				) then

					ApplyXRayPart(
						Object
					)

				end

				if Index % 120 ==
					0
				then

					RunService.Heartbeat:Wait()

				end

			end

		end
	)

end

------------------------------------------------------------
-- DISABLE XRAY
------------------------------------------------------------

local function DisableXRay()

	XRayEnabled =
		false

	for Part,
		Original
		in pairs(
			XRayCache
		)
	do

		if Part
			and Part.Parent
		then

			pcall(
				function()

					Part.LocalTransparencyModifier =
						Original

				end
			)

		end

	end

	XRayCache =
		{}

end

------------------------------------------------------------
-- REFRESH XRAY
------------------------------------------------------------

local function RefreshXRay()

	if not XRayEnabled then

		return

	end

	for Part,
		Original
		in pairs(
			XRayCache
		)
	do

		if Part
			and Part.Parent
		then

			Part.LocalTransparencyModifier =
				math.max(

					Original,

					CONFIG.XRayTransparency

				)

		end

	end

end

------------------------------------------------------------
-- NEW XRAY PART
------------------------------------------------------------

workspace.DescendantAdded:Connect(
	function(Object)

		if XRayEnabled
			and Object:IsA(
				"BasePart"
			)
		then

			task.defer(
				function()

					ApplyXRayPart(
						Object
					)

				end
			)

		end

	end
)

------------------------------------------------------------
-- ========================================================
-- ESP PLAYERS
-- ========================================================
------------------------------------------------------------

local ESPLine =
	false

local ESPBox =
	false

local ESPChams =
	false

local ESPFilter =
	"Todos"

------------------------------------------------------------
-- ESP GUI
------------------------------------------------------------

local ESPGui =
	Instance.new(
		"ScreenGui"
	)

ESPGui.Name =
	"SouzaESP_V10"

ESPGui.IgnoreGuiInset =
	true

ESPGui.ResetOnSpawn =
	false

ESPGui.DisplayOrder =
	998

ESPGui.Parent =
	PlayerGui

------------------------------------------------------------

local ESPFolder =
	Instance.new(
		"Folder"
	)

ESPFolder.Name =
	"SouzaESPHighlights"

ESPFolder.Parent =
	workspace

------------------------------------------------------------

local ESPObjects =
	{}

------------------------------------------------------------
-- SHOULD ESP
------------------------------------------------------------

local function ShouldESP(
	Target
)

	if Target ==
		Player
	then

		return false

	end

	local Char =
		Target.Character

	if not Char then

		return false

	end

	local H =
		Char:FindFirstChildOfClass(
			"Humanoid"
		)

	if not H
		or H.Health <= 0
	then

		return false

	end

	--------------------------------------------------------

	if ESPFilter ==
		"Aliados"
	then

		return Player.Team ~= nil

			and Target.Team ==
			Player.Team

	end

	if ESPFilter ==
		"Inimigos"
	then

		if Player.Team ==
			nil
		then

			return true

		end

		return Target.Team ~=
			Player.Team

	end

	return true

end

------------------------------------------------------------
-- ESP COLOR
------------------------------------------------------------

local function GetESPColor(
	Target
)

	if Player.Team
		and Target.Team
	then

		if Player.Team ==
			Target.Team
		then

			return Color3.fromRGB(
				69,
				221,
				145
			)

		else

			return Color3.fromRGB(
				245,
				73,
				92
			)

		end

	end

	return Theme().Accent

end

------------------------------------------------------------
-- CREATE ESP
------------------------------------------------------------

local function CreateESP(
	Target
)

	if ESPObjects[
		Target
	] then

		return ESPObjects[
			Target
		]

	end

	local Data =
		{}

	--------------------------------------------------------
	-- BOX
	--------------------------------------------------------

	local Box =
		Instance.new(
			"Frame"
		)

	Box.BackgroundTransparency =
		1

	Box.BorderSizePixel =
		0

	Box.Visible =
		false

	Box.Parent =
		ESPGui

	local BoxStroke =
		Instance.new(
			"UIStroke"
		)

	BoxStroke.Thickness =
		1.6

	BoxStroke.Parent =
		Box

	Data.Box =
		Box

	Data.BoxStroke =
		BoxStroke

	--------------------------------------------------------
	-- LINE
	--------------------------------------------------------

	local Line =
		Instance.new(
			"Frame"
		)

	Line.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	Line.BorderSizePixel =
		0

	Line.Visible =
		false

	Line.Parent =
		ESPGui

	Data.Line =
		Line

	--------------------------------------------------------
	-- HIGHLIGHT
	--------------------------------------------------------

	local Highlight =
		Instance.new(
			"Highlight"
		)

	Highlight.FillTransparency =
		0.66

	Highlight.OutlineTransparency =
		0.05

	Highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	Highlight.Enabled =
		false

	Highlight.Parent =
		ESPFolder

	Data.Highlight =
		Highlight

	--------------------------------------------------------

	ESPObjects[
		Target
	] =
		Data

	return Data

end

------------------------------------------------------------
-- HIDE ESP
------------------------------------------------------------

local function HideESP(
	Data
)

	Data.Box.Visible =
		false

	Data.Line.Visible =
		false

	Data.Highlight.Enabled =
		false

end

------------------------------------------------------------
-- BOX
------------------------------------------------------------

local function UpdateBox(
	Data,
	Char
)

	local Success,
		CF,
		Size =
		pcall(
			function()

				local BoxCF,
					BoxSize =
					Char:GetBoundingBox()

				return
					BoxCF,
					BoxSize

			end
		)

	if not Success
		or not CF
	then

		Data.Box.Visible =
			false

		return

	end

	local Half =
		Size / 2

	local Points = {

		Vector3.new(
			-Half.X,
			-Half.Y,
			-Half.Z
		),

		Vector3.new(
			Half.X,
			-Half.Y,
			-Half.Z
		),

		Vector3.new(
			-Half.X,
			Half.Y,
			-Half.Z
		),

		Vector3.new(
			Half.X,
			Half.Y,
			-Half.Z
		),

		Vector3.new(
			-Half.X,
			-Half.Y,
			Half.Z
		),

		Vector3.new(
			Half.X,
			-Half.Y,
			Half.Z
		),

		Vector3.new(
			-Half.X,
			Half.Y,
			Half.Z
		),

		Vector3.new(
			Half.X,
			Half.Y,
			Half.Z
		),
	}

	local MinX =
		math.huge

	local MinY =
		math.huge

	local MaxX =
		-math.huge

	local MaxY =
		-math.huge

	local Valid =
		false

	--------------------------------------------------------

	for _,
		Point
		in ipairs(
			Points
		)
	do

		local World =
			CF:PointToWorldSpace(
				Point
			)

		local Screen =
			Camera:WorldToViewportPoint(
				World
			)

		if Screen.Z > 0 then

			Valid =
				true

			MinX =
				math.min(
					MinX,
					Screen.X
				)

			MinY =
				math.min(
					MinY,
					Screen.Y
				)

			MaxX =
				math.max(
					MaxX,
					Screen.X
				)

			MaxY =
				math.max(
					MaxY,
					Screen.Y
				)

		end

	end

	if not Valid then

		Data.Box.Visible =
			false

		return

	end

	Data.Box.Position =
		UDim2.fromOffset(

			MinX,

			MinY

		)

	Data.Box.Size =
		UDim2.fromOffset(

			math.max(
				MaxX - MinX,
				2
			),

			math.max(
				MaxY - MinY,
				2
			)

		)

	Data.Box.Visible =
		true

end

------------------------------------------------------------
-- LINE
------------------------------------------------------------

local function UpdateLine(
	Data,
	Position
)

	local Screen,
		Visible =
		Camera:WorldToViewportPoint(
			Position
		)

	if not Visible
		or Screen.Z <= 0
	then

		Data.Line.Visible =
			false

		return

	end

	local Viewport =
		Camera.ViewportSize

	local From =
		Vector2.new(

			Viewport.X / 2,

			Viewport.Y - 15

		)

	local To =
		Vector2.new(

			Screen.X,

			Screen.Y

		)

	local Delta =
		To - From

	local Center =
		From

		+ Delta / 2

	Data.Line.Position =
		UDim2.fromOffset(

			Center.X,

			Center.Y

		)

	Data.Line.Size =
		UDim2.fromOffset(

			Delta.Magnitude,

			1.5

		)

	Data.Line.Rotation =
		math.deg(

			math.atan2(

				Delta.Y,

				Delta.X

			)

		)

	Data.Line.Visible =
		true

end

------------------------------------------------------------
-- ESP LOOP
------------------------------------------------------------

local ESPClock =
	0

RunService.RenderStepped:Connect(
	function(DT)

		ESPClock +=
			DT

		if ESPClock <
			CONFIG.ESPUpdateRate
		then

			return

		end

		ESPClock =
			0

		local Any =
			ESPLine
			or ESPBox
			or ESPChams

		----------------------------------------------------

		if not Any then

			for _,
				Data
				in pairs(
					ESPObjects
				)
			do

				HideESP(
					Data
				)

			end

			return

		end

		----------------------------------------------------

		for _,
			Target
			in ipairs(
				Players:GetPlayers()
			)
		do

			local Data =
				CreateESP(
					Target
				)

			if not ShouldESP(
				Target
			) then

				HideESP(
					Data
				)

				continue

			end

			local Char =
				Target.Character

			local TargetRoot =
				Char

				and Char:FindFirstChild(
					"HumanoidRootPart"
				)

			if not TargetRoot
				or not Root
			then

				HideESP(
					Data
				)

				continue

			end

			------------------------------------------------

			local Distance =
				(
					TargetRoot.Position

					- Root.Position

				).Magnitude

			if Distance >
				CONFIG.ESPDistance
			then

				HideESP(
					Data
				)

				continue

			end

			------------------------------------------------

			local Color =
				GetESPColor(
					Target
				)

			Data.BoxStroke.Color =
				Color

			Data.Line.BackgroundColor3 =
				Color

			Data.Highlight.FillColor =
				Color

			Data.Highlight.OutlineColor =
				Theme().Text

			Data.Highlight.Adornee =
				Char

			------------------------------------------------

			if ESPBox then

				UpdateBox(
					Data,
					Char
				)

			else

				Data.Box.Visible =
					false

			end

			------------------------------------------------

			if ESPLine then

				UpdateLine(

					Data,

					TargetRoot.Position

				)

			else

				Data.Line.Visible =
					false

			end

			------------------------------------------------

			Data.Highlight.Enabled =
				ESPChams

		end

	end
)

------------------------------------------------------------
-- ========================================================
-- GUI
-- ========================================================
------------------------------------------------------------

local GUI =
	Instance.new(
		"ScreenGui"
	)

GUI.Name =
	"SouzaAdminV10"

GUI.ResetOnSpawn =
	false

GUI.IgnoreGuiInset =
	false

GUI.DisplayOrder =
	999

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

		CONFIG.Width,

		CONFIG.Height

	)

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

BindTheme(
	Main,
	"BackgroundColor3",
	"BG"
)

Corner(
	Main,
	14
)

Stroke(
	Main,
	"Stroke",
	1,
	0
)

------------------------------------------------------------
-- MAIN GRADIENT
------------------------------------------------------------

local MainGradient =
	Instance.new(
		"UIGradient"
	)

MainGradient.Rotation =
	120

MainGradient.Parent =
	Main

BindGradient(
	MainGradient,
	"Main"
)

------------------------------------------------------------
-- SCALE
------------------------------------------------------------

local MainScale =
	Instance.new(
		"UIScale"
	)

MainScale.Parent =
	Main

------------------------------------------------------------

local UserScale =
	1

local function UpdateScale()

	local View =
		Camera.ViewportSize

	local Auto =
		math.clamp(

			math.min(

				View.X / 760,

				View.Y / 470

			),

			0.62,

			1

		)

	MainScale.Scale =
		Auto
		* UserScale

end

UpdateScale()

Camera:GetPropertyChangedSignal(
	"ViewportSize"
):Connect(
	UpdateScale
)

------------------------------------------------------------
-- TOP ACCENT
------------------------------------------------------------

local TopAccent =
	Instance.new(
		"Frame"
	)

TopAccent.Size =
	UDim2.new(
		1,
		0,
		0,
		2
	)

TopAccent.BorderSizePixel =
	0

TopAccent.ZIndex =
	60

TopAccent.Parent =
	Main

BindTheme(
	TopAccent,
	"BackgroundColor3",
	"Accent"
)

------------------------------------------------------------
-- AMBIENT GLOW
------------------------------------------------------------

local Glow =
	Instance.new(
		"Frame"
	)

Glow.AnchorPoint =
	Vector2.new(
		1,
		1
	)

Glow.Position =
	UDim2.fromScale(
		1,
		1
	)

Glow.Size =
	UDim2.fromOffset(
		220,
		150
	)

Glow.BackgroundTransparency =
	0.92

Glow.BorderSizePixel =
	0

Glow.ZIndex =
	10

Glow.Parent =
	Main

BindTheme(
	Glow,
	"BackgroundColor3",
	"Accent"
)

Corner(
	Glow,
	100
)

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

Sidebar.BorderSizePixel =
	0

Sidebar.ZIndex =
	15

Sidebar.Parent =
	Main

BindTheme(
	Sidebar,
	"BackgroundColor3",
	"Sidebar"
)

------------------------------------------------------------

local SidebarGradient =
	Instance.new(
		"UIGradient"
	)

SidebarGradient.Rotation =
	90

SidebarGradient.Parent =
	Sidebar

BindGradient(
	SidebarGradient,
	"Sidebar"
)

------------------------------------------------------------
-- LOGO HOLDER
------------------------------------------------------------

local LogoHolder =
	Instance.new(
		"Frame"
	)

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
		18
	)

LogoHolder.Size =
	UDim2.fromOffset(
		58,
		58
	)

LogoHolder.BorderSizePixel =
	0

LogoHolder.ZIndex =
	20

LogoHolder.Parent =
	Sidebar

BindTheme(
	LogoHolder,
	"BackgroundColor3",
	"Card"
)

Corner(
	LogoHolder,
	29
)

Stroke(
	LogoHolder,
	"Accent",
	2,
	0.05
)

------------------------------------------------------------
-- FALLBACK
------------------------------------------------------------

local LogoFallback =
	Instance.new(
		"TextLabel"
	)

LogoFallback.Size =
	UDim2.fromScale(
		1,
		1
	)

LogoFallback.BackgroundTransparency =
	1

LogoFallback.Text =
	"S"

LogoFallback.TextSize =
	27

LogoFallback.FontFace =
	FONT_BOLD

LogoFallback.ZIndex =
	21

LogoFallback.Parent =
	LogoHolder

BindTheme(
	LogoFallback,
	"TextColor3",
	"Accent"
)

------------------------------------------------------------
-- LOGO IMAGE
------------------------------------------------------------

local LogoImage =
	Instance.new(
		"ImageLabel"
	)

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
	22

LogoImage.Parent =
	LogoHolder

------------------------------------------------------------
-- BRAND
------------------------------------------------------------

local Brand =
	Instance.new(
		"TextLabel"
	)

Brand.Position =
	UDim2.fromOffset(
		0,
		84
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

Brand.TextSize =
	14

Brand.FontFace =
	FONT_BOLD

Brand.ZIndex =
	20

Brand.Parent =
	Sidebar

BindTheme(
	Brand,
	"TextColor3",
	"Text"
)

------------------------------------------------------------

local BrandSub =
	Instance.new(
		"TextLabel"
	)

BrandSub.Position =
	UDim2.fromOffset(
		0,
		105
	)

BrandSub.Size =
	UDim2.new(
		1,
		0,
		0,
		17
	)

BrandSub.BackgroundTransparency =
	1

BrandSub.Text =
	"ADMIN • MOBILE"

BrandSub.TextSize =
	8

BrandSub.FontFace =
	FONT_MEDIUM

BrandSub.ZIndex =
	20

BrandSub.Parent =
	Sidebar

BindTheme(
	BrandSub,
	"TextColor3",
	"Muted"
)

------------------------------------------------------------
-- NAVIGATION
------------------------------------------------------------

local Navigation =
	Instance.new(
		"Frame"
	)

Navigation.Position =
	UDim2.fromOffset(
		10,
		142
	)

Navigation.Size =
	UDim2.new(
		1,
		-20,
		1,
		-155
	)

Navigation.BackgroundTransparency =
	1

Navigation.ZIndex =
	25

Navigation.Parent =
	Sidebar

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

NavLayout.Parent =
	Navigation

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
	15

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
		70
	)

Header.BackgroundTransparency =
	1

Header.ZIndex =
	30

Header.Parent =
	Content

------------------------------------------------------------
-- DRAG AREA
------------------------------------------------------------

local HeaderDrag =
	Instance.new(
		"Frame"
	)

HeaderDrag.Size =
	UDim2.new(
		1,
		-70,
		1,
		0
	)

HeaderDrag.BackgroundTransparency =
	1

HeaderDrag.Active =
	true

HeaderDrag.ZIndex =
	31

HeaderDrag.Parent =
	Header

------------------------------------------------------------

local SmallTitle =
	Instance.new(
		"TextLabel"
	)

SmallTitle.Position =
	UDim2.fromOffset(
		23,
		12
	)

SmallTitle.Size =
	UDim2.fromOffset(
		280,
		15
	)

SmallTitle.BackgroundTransparency =
	1

SmallTitle.Text =
	"PAINEL ADMIN LOCAL"

SmallTitle.TextSize =
	8

SmallTitle.FontFace =
	FONT_MEDIUM

SmallTitle.TextXAlignment =
	Enum.TextXAlignment.Left

SmallTitle.ZIndex =
	32

SmallTitle.Parent =
	HeaderDrag

BindTheme(
	SmallTitle,
	"TextColor3",
	"Muted"
)

------------------------------------------------------------

local HeaderIcon =
	Instance.new(
		"TextLabel"
	)

HeaderIcon.Position =
	UDim2.fromOffset(
		23,
		30
	)

HeaderIcon.Size =
	UDim2.fromOffset(
		26,
		27
	)

HeaderIcon.BackgroundTransparency =
	1

HeaderIcon.Text =
	"⌂"

HeaderIcon.TextSize =
	20

HeaderIcon.FontFace =
	FONT_BOLD

HeaderIcon.ZIndex =
	32

HeaderIcon.Parent =
	HeaderDrag

BindTheme(
	HeaderIcon,
	"TextColor3",
	"Accent"
)

------------------------------------------------------------

local HeaderTitle =
	Instance.new(
		"TextLabel"
	)

HeaderTitle.Position =
	UDim2.fromOffset(
		56,
		30
	)

HeaderTitle.Size =
	UDim2.fromOffset(
		260,
		27
	)

HeaderTitle.BackgroundTransparency =
	1

HeaderTitle.Text =
	"PRINCIPAL"

HeaderTitle.TextSize =
	18

HeaderTitle.FontFace =
	FONT_BOLD

HeaderTitle.TextXAlignment =
	Enum.TextXAlignment.Left

HeaderTitle.ZIndex =
	32

HeaderTitle.Parent =
	HeaderDrag

BindTheme(
	HeaderTitle,
	"TextColor3",
	"Accent"
)

------------------------------------------------------------
-- CLOSE
------------------------------------------------------------

local Close =
	Instance.new(
		"TextButton"
	)

Close.AnchorPoint =
	Vector2.new(
		1,
		0.5
	)

Close.Position =
	UDim2.new(
		1,
		-17,
		0.5,
		1
	)

Close.Size =
	UDim2.fromOffset(
		42,
		42
	)

Close.BorderSizePixel =
	0

Close.Text =
	"×"

Close.TextSize =
	28

Close.FontFace =
	FONT_MEDIUM

Close.AutoButtonColor =
	false

Close.ZIndex =
	40

Close.Parent =
	Header

BindTheme(
	Close,
	"BackgroundColor3",
	"Control"
)

BindTheme(
	Close,
	"TextColor3",
	"Accent"
)

Corner(
	Close,
	11
)

Stroke(
	Close,
	"Stroke",
	1,
	0
)

------------------------------------------------------------
-- PAGE HOLDER
------------------------------------------------------------

local PageHolder =
	Instance.new(
		"Frame"
	)

PageHolder.Position =
	UDim2.fromOffset(
		19,
		70
	)

PageHolder.Size =
	UDim2.new(
		1,
		-29,
		1,
		-84
	)

PageHolder.BackgroundTransparency =
	1

PageHolder.ZIndex =
	20

PageHolder.Parent =
	Content

------------------------------------------------------------
-- PAGES
------------------------------------------------------------

local Pages =
	{}

------------------------------------------------------------

local function CreatePage(
	Name
)

	local Page =
		Instance.new(
			"ScrollingFrame"
		)

	Page.Name =
		Name

	Page.Size =
		UDim2.fromScale(
			1,
			1
		)

	Page.BackgroundTransparency =
		1

	Page.BorderSizePixel =
		0

	Page.CanvasSize =
		UDim2.fromOffset(
			0,
			0
		)

	Page.AutomaticCanvasSize =
		Enum.AutomaticSize.Y

	Page.ScrollingDirection =
		Enum.ScrollingDirection.Y

	Page.ScrollBarThickness =
		3

	Page.ScrollBarImageTransparency =
		0.12

	Page.Visible =
		false

	Page.ZIndex =
		21

	Page.Parent =
		PageHolder

	BindTheme(
		Page,
		"ScrollBarImageColor3",
		"Accent"
	)

	--------------------------------------------------------

	local Padding =
		Instance.new(
			"UIPadding"
		)

	Padding.PaddingRight =
		UDim.new(
			0,
			10
		)

	Padding.Parent =
		Page

	--------------------------------------------------------

	local Layout =
		Instance.new(
			"UIListLayout"
		)

	Layout.Padding =
		UDim.new(
			0,
			11
		)

	Layout.SortOrder =
		Enum.SortOrder.LayoutOrder

	Layout.Parent =
		Page

	Pages[
		Name
	] =
		Page

	return Page
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

local MiscPage =
	CreatePage(
		"Diversos"
	)

local SettingsPage =
	CreatePage(
		"Ajustes"
	)

------------------------------------------------------------
-- SECTION
------------------------------------------------------------

local function CreateSection(
	Parent,
	Text
)

	local Label =
		Instance.new(
			"TextLabel"
		)

	Label.Size =
		UDim2.new(
			1,
			0,
			0,
			20
		)

	Label.BackgroundTransparency =
		1

	Label.Text =
		string.upper(
			Text
		)

	Label.TextSize =
		8

	Label.FontFace =
		FONT_BOLD

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.Parent =
		Parent

	BindTheme(
		Label,
		"TextColor3",
		"Muted"
	)

	return Label
end

------------------------------------------------------------
-- CARD
------------------------------------------------------------

local function CreateCard(
	Parent,
	Title,
	Description
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
			70
		)

	Card.BorderSizePixel =
		0

	Card.Active =
		true

	Card.Parent =
		Parent

	BindTheme(
		Card,
		"BackgroundColor3",
		"Card"
	)

	Corner(
		Card,
		11
	)

	Stroke(
		Card,
		"StrokeSoft",
		1,
		0.05
	)

	--------------------------------------------------------
	-- ACCENT BAR
	--------------------------------------------------------

	local Bar =
		Instance.new(
			"Frame"
		)

	Bar.Position =
		UDim2.fromOffset(
			14,
			18
		)

	Bar.Size =
		UDim2.fromOffset(
			4,
			34
		)

	Bar.BorderSizePixel =
		0

	Bar.Parent =
		Card

	BindTheme(
		Bar,
		"BackgroundColor3",
		"Accent"
	)

	Corner(
		Bar,
		2
	)

	--------------------------------------------------------
	-- TITLE
	--------------------------------------------------------

	local TitleLabel =
		Instance.new(
			"TextLabel"
		)

	TitleLabel.Position =
		UDim2.fromOffset(
			30,
			10
		)

	TitleLabel.Size =
		UDim2.new(
			1,
			-205,
			0,
			26
		)

	TitleLabel.BackgroundTransparency =
		1

	TitleLabel.Text =
		Title

	TitleLabel.TextSize =
		14

	TitleLabel.FontFace =
		FONT_MEDIUM

	TitleLabel.TextXAlignment =
		Enum.TextXAlignment.Left

	TitleLabel.Parent =
		Card

	BindTheme(
		TitleLabel,
		"TextColor3",
		"Text"
	)

	--------------------------------------------------------
	-- DESCRIPTION
	--------------------------------------------------------

	local Desc =
		Instance.new(
			"TextLabel"
		)

	Desc.Position =
		UDim2.fromOffset(
			30,
			37
		)

	Desc.Size =
		UDim2.new(
			1,
			-205,
			0,
			18
		)

	Desc.BackgroundTransparency =
		1

	Desc.Text =
		Description

	Desc.TextSize =
		9

	Desc.FontFace =
		FONT_REGULAR

	Desc.TextXAlignment =
		Enum.TextXAlignment.Left

	Desc.Parent =
		Card

	BindTheme(
		Desc,
		"TextColor3",
		"Sub"
	)

	--------------------------------------------------------
	-- HOVER PC
	--------------------------------------------------------

	Card.MouseEnter:Connect(
		function()

			Tween(
				Card,
				0.12,
				{
					BackgroundColor3 =
						Theme().CardHover
				}
			)

		end
	)

	Card.MouseLeave:Connect(
		function()

			Tween(
				Card,
				0.12,
				{
					BackgroundColor3 =
						Theme().Card
				}
			)

		end
	)

	return Card,
		TitleLabel,
		Desc

end

------------------------------------------------------------
-- ACTION BUTTON
------------------------------------------------------------

local function CreateActionButton(
	Card,
	Text
)

	local Button =
		Instance.new(
			"TextButton"
		)

	Button.AnchorPoint =
		Vector2.new(
			1,
			0.5
		)

	Button.Position =
		UDim2.new(
			1,
			-14,
			0.5,
			0
		)

	Button.Size =
		UDim2.fromOffset(
			115,
			39
		)

	Button.BorderSizePixel =
		0

	Button.Text =
		Text

	Button.TextSize =
		9

	Button.FontFace =
		FONT_BOLD

	Button.AutoButtonColor =
		false

	Button.Parent =
		Card

	BindTheme(
		Button,
		"BackgroundColor3",
		"Control"
	)

	BindTheme(
		Button,
		"TextColor3",
		"Text"
	)

	Corner(
		Button,
		9
	)

	local S =
		Stroke(
			Button,
			"Stroke",
			1,
			0
		)

	return Button,
		S
end

------------------------------------------------------------
-- TOGGLE
------------------------------------------------------------

local function CreateToggle(
	Card,
	Initial,
	Callback
)

	local Enabled =
		Initial or false

	local Track =
		Instance.new(
			"TextButton"
		)

	Track.AnchorPoint =
		Vector2.new(
			1,
			0.5
		)

	Track.Position =
		UDim2.new(
			1,
			-15,
			0.5,
			0
		)

	Track.Size =
		UDim2.fromOffset(
			62,
			32
		)

	Track.BorderSizePixel =
		0

	Track.Text =
		""

	Track.AutoButtonColor =
		false

	Track.Parent =
		Card

	BindTheme(
		Track,
		"BackgroundColor3",
		"Control"
	)

	Corner(
		Track,
		16
	)

	local TrackStroke =
		Stroke(
			Track,
			"Stroke",
			1,
			0
		)

	--------------------------------------------------------

	local Dot =
		Instance.new(
			"Frame"
		)

	Dot.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	Dot.Position =
		UDim2.fromOffset(
			17,
			16
		)

	Dot.Size =
		UDim2.fromOffset(
			21,
			21
		)

	Dot.BorderSizePixel =
		0

	Dot.Parent =
		Track

	BindTheme(
		Dot,
		"BackgroundColor3",
		"Sub"
	)

	Corner(
		Dot,
		11
	)

	--------------------------------------------------------

	local function UpdateVisual()

		if Enabled then

			Track.BackgroundColor3 =
				Theme().Accent

			TrackStroke.Color =
				Theme().Accent2

			Dot.BackgroundColor3 =
				Theme().Text

			Dot.Position =
				UDim2.fromOffset(
					45,
					16
				)

		else

			Track.BackgroundColor3 =
				Theme().Control

			TrackStroke.Color =
				Theme().Stroke

			Dot.BackgroundColor3 =
				Theme().Sub

			Dot.Position =
				UDim2.fromOffset(
					17,
					16
				)

		end

	end

	--------------------------------------------------------

	local function Set(
		State,
		FireCallback
	)

		Enabled =
			State

		UpdateVisual()

		if FireCallback ~= false
			and Callback
		then

			Callback(
				State
			)

		end

	end

	--------------------------------------------------------

	Track.MouseButton1Click:Connect(
		function()

			Set(
				not Enabled,
				true
			)

		end
	)

	UpdateVisual()

	return {

		Set = Set,

		Get = function()

			return Enabled

		end,

		UpdateVisual =
			UpdateVisual
	}
end

------------------------------------------------------------
-- CYCLE BUTTON
------------------------------------------------------------

local function CreateCycleButton(
	Card,
	Text
)

	local Button,
		S =
		CreateActionButton(
			Card,
			Text
		)

	Button.Size =
		UDim2.fromOffset(
			130,
			39
		)

	return Button,
		S
end

------------------------------------------------------------
-- ========================================================
-- PRINCIPAL
-- ========================================================
------------------------------------------------------------

CreateSection(
	PrincipalPage,
	"Movimento"
)

------------------------------------------------------------
-- ELEVATOR CARD
------------------------------------------------------------

local ElevatorCard,
	_,
	ElevatorDescription =
	CreateCard(

		PrincipalPage,

		"Elevador",

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

ElevatorControls.Parent =
	ElevatorCard

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

Minus.BorderSizePixel =
	0

Minus.Text =
	"−"

Minus.TextSize =
	23

Minus.FontFace =
	FONT_BOLD

Minus.AutoButtonColor =
	false

Minus.Parent =
	ElevatorControls

BindTheme(
	Minus,
	"BackgroundColor3",
	"Control"
)

BindTheme(
	Minus,
	"TextColor3",
	"Text"
)

Corner(
	Minus,
	9
)

Stroke(
	Minus,
	"Stroke",
	1,
	0
)

------------------------------------------------------------

local LevelHolder =
	Instance.new(
		"Frame"
	)

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

LevelHolder.BorderSizePixel =
	0

LevelHolder.Parent =
	ElevatorControls

BindTheme(
	LevelHolder,
	"BackgroundColor3",
	"Text"
)

Corner(
	LevelHolder,
	9
)

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

LevelText.TextSize =
	14

LevelText.FontFace =
	FONT_BOLD

LevelText.Parent =
	LevelHolder

BindTheme(
	LevelText,
	"TextColor3",
	"BG"
)

------------------------------------------------------------

local Plus =
	Instance.new(
		"TextButton"
	)

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

Plus.BorderSizePixel =
	0

Plus.Text =
	"+"

Plus.TextSize =
	23

Plus.FontFace =
	FONT_BOLD

Plus.AutoButtonColor =
	false

Plus.Parent =
	ElevatorControls

BindTheme(
	Plus,
	"BackgroundColor3",
	"Accent"
)

BindTheme(
	Plus,
	"TextColor3",
	"Text"
)

Corner(
	Plus,
	9
)

------------------------------------------------------------
-- ELEVATOR UI
------------------------------------------------------------

local function UpdateElevatorUI()

	LevelText.Text =
		tostring(
			PlatformLevel
		)

	if not Platform then

		ElevatorDescription.Text =
			"Desativado"

	else

		ElevatorDescription.Text =
			"Nível "
			.. PlatformLevel
			.. " • bloco estável"

	end

end

------------------------------------------------------------

Plus.MouseButton1Click:Connect(
	function()

		local _,
			Message =
			MoveElevator(
				1
			)

		UpdateElevatorUI()

	end
)

------------------------------------------------------------

Minus.MouseButton1Click:Connect(
	function()

		MoveElevator(
			-1
		)

		UpdateElevatorUI()

	end
)

------------------------------------------------------------
-- TP FROM
------------------------------------------------------------

local TPCard,
	_,
	TPDescription =
	CreateCard(

		PrincipalPage,

		"TP FROM",

		"Atravessa a parede na sua frente"

	)

local TPButton,
	TPButtonStroke =
	CreateActionButton(
		TPCard,
		"ATRAVESSAR"
	)

------------------------------------------------------------

TPButton.MouseButton1Click:Connect(
	function()

		TPButton.Text =
			"..."

		local Success,
			Message =
			TPFrom()

		TPDescription.Text =
			Message

		if Success then

			TPButton.Text =
				"FEITO"

			TPButton.TextColor3 =
				Color3.fromRGB(
					72,
					220,
					145
				)

		else

			TPButton.Text =
				"FALHOU"

			TPButton.TextColor3 =
				Color3.fromRGB(
					240,
					75,
					95
				)

		end

		task.delay(
			1,
			function()

				if TPButton.Parent then

					TPButton.Text =
						"ATRAVESSAR"

					TPButton.TextColor3 =
						Theme().Text

					TPButtonStroke.Color =
						Theme().Stroke

				end

			end
		)

	end
)

------------------------------------------------------------
-- UTILITIES SECTION
------------------------------------------------------------

CreateSection(
	PrincipalPage,
	"Utilidades"
)

------------------------------------------------------------
-- DESCNY
------------------------------------------------------------

local DescnyCard,
	_,
	DescnyDescription =
	CreateCard(

		PrincipalPage,

		"DESCNY",

		"Procura e ativa sua capa de invisibilidade"

	)

local DescnyButton,
	DescnyStroke =
	CreateActionButton(
		DescnyCard,
		"ATIVAR"
	)

------------------------------------------------------------

DescnyButton.MouseButton1Click:Connect(
	function()

		DescnyButton.Text =
			"BUSCANDO"

		local Success,
			Message =
			ActivateDescny()

		if Success then

			DescnyButton.Text =
				"ATIVADO"

			DescnyButton.TextColor3 =
				Color3.fromRGB(
					72,
					220,
					145
				)

			DescnyDescription.Text =
				"Usando "
				.. tostring(
					Message
				)

		else

			DescnyButton.Text =
				"NÃO ACHOU"

			DescnyButton.TextColor3 =
				Color3.fromRGB(
					240,
					75,
					95
				)

			DescnyDescription.Text =
				Message

		end

		task.delay(
			1.2,
			function()

				if DescnyButton.Parent then

					DescnyButton.Text =
						"ATIVAR"

					DescnyButton.TextColor3 =
						Theme().Text

					DescnyStroke.Color =
						Theme().Stroke

				end

			end
		)

	end
)

------------------------------------------------------------
-- ANTILAG
------------------------------------------------------------

local AntiLagCard,
	_,
	AntiLagDescription =
	CreateCard(

		PrincipalPage,

		"AntiLag",

		"OFF"

	)

local AntiLagButton =
	CreateCycleButton(
		AntiLagCard,
		"OFF"
	)

------------------------------------------------------------

local AntiLagNames = {

	[0] = "OFF",

	[1] = "LEVE",

	[2] = "MÉDIO",

	[3] = "MÁXIMO"
}

------------------------------------------------------------

AntiLagButton.MouseButton1Click:Connect(
	function()

		local Next =
			AntiLagLevel + 1

		if Next > 3 then

			Next =
				0

		end

		ApplyAntiLag(
			Next
		)

		AntiLagButton.Text =
			AntiLagNames[
				Next
			]

		AntiLagDescription.Text =
			"Modo "
			.. AntiLagNames[
				Next
			]

	end
)

------------------------------------------------------------
-- ========================================================
-- VISUAIS
-- ========================================================
------------------------------------------------------------

CreateSection(
	VisualPage,
	"Mapa"
)

------------------------------------------------------------
-- XRAY
------------------------------------------------------------

local XRayCard,
	_,
	XRayDescription =
	CreateCard(

		VisualPage,

		"XRay",

		"Transparência visual local do mapa"

	)

local XRayToggle

XRayToggle =
	CreateToggle(

		XRayCard,

		false,

		function(State)

			if State then

				EnableXRay()

				XRayDescription.Text =
					"Ativado • "
					.. math.floor(
						CONFIG.XRayTransparency
						* 100
					)
					.. "%"

			else

				DisableXRay()

				XRayDescription.Text =
					"Transparência visual local do mapa"

			end

		end
	)

------------------------------------------------------------
-- ESP SECTION
------------------------------------------------------------

CreateSection(
	VisualPage,
	"ESP Players"
)

------------------------------------------------------------
-- LINE
------------------------------------------------------------

local LineCard =
	CreateCard(

		VisualPage,

		"ESP Line",

		"Linha até jogadores"

	)

local LineToggle =
	CreateToggle(

		LineCard,

		false,

		function(State)

			ESPLine =
				State

		end
	)

------------------------------------------------------------
-- BOX
------------------------------------------------------------

local BoxCard =
	CreateCard(

		VisualPage,

		"ESP Box",

		"Caixa ao redor dos jogadores"

	)

local BoxToggle =
	CreateToggle(

		BoxCard,

		false,

		function(State)

			ESPBox =
				State

		end
	)

------------------------------------------------------------
-- CHAMS
------------------------------------------------------------

local ChamsCard =
	CreateCard(

		VisualPage,

		"Chams",

		"Highlight através das paredes"

	)

local ChamsToggle =
	CreateToggle(

		ChamsCard,

		false,

		function(State)

			ESPChams =
				State

		end
	)

------------------------------------------------------------
-- CATEGORY
------------------------------------------------------------

local CategoryCard,
	_,
	CategoryDescription =
	CreateCard(

		VisualPage,

		"Categoria ESP",

		"Todos"

	)

local CategoryButton =
	CreateCycleButton(
		CategoryCard,
		"TODOS"
	)

local Categories = {

	"Todos",

	"Aliados",

	"Inimigos"
}

local CategoryIndex =
	1

------------------------------------------------------------

CategoryButton.MouseButton1Click:Connect(
	function()

		CategoryIndex +=
			1

		if CategoryIndex >
			#Categories
		then

			CategoryIndex =
				1

		end

		ESPFilter =
			Categories[
				CategoryIndex
			]

		CategoryButton.Text =
			string.upper(
				ESPFilter
			)

		CategoryDescription.Text =
			ESPFilter

	end
)

------------------------------------------------------------
-- ========================================================
-- DIVERSOS
-- ========================================================
------------------------------------------------------------

CreateSection(
	MiscPage,
	"Controles"
)

------------------------------------------------------------
-- REMOVE PLATFORM
------------------------------------------------------------

local RemoveCard =
	CreateCard(

		MiscPage,

		"Remover Elevador",

		"Apaga a plataforma imediatamente"

	)

local RemoveButton =
	CreateActionButton(
		RemoveCard,
		"REMOVER"
	)

RemoveButton.MouseButton1Click:Connect(
	function()

		RemovePlatform()

		UpdateElevatorUI()

	end
)

------------------------------------------------------------
-- DISABLE VISUALS
------------------------------------------------------------

local DisableVisualCard =
	CreateCard(

		MiscPage,

		"Desligar Visuais",

		"Desativa XRay e todos os ESP"

	)

local DisableVisualButton =
	CreateActionButton(
		DisableVisualCard,
		"DESLIGAR"
	)

DisableVisualButton.MouseButton1Click:Connect(
	function()

		ESPLine =
			false

		ESPBox =
			false

		ESPChams =
			false

		LineToggle.Set(
			false,
			false
		)

		BoxToggle.Set(
			false,
			false
		)

		ChamsToggle.Set(
			false,
			false
		)

		XRayToggle.Set(
			false,
			false
		)

		DisableXRay()

		for _,
			Data
			in pairs(
				ESPObjects
			)
		do

			HideESP(
				Data
			)

		end

	end
)

------------------------------------------------------------
-- INFO
------------------------------------------------------------

CreateCard(

	MiscPage,

	"Conta",

	Player.DisplayName
	.. " • @"
	.. Player.Name

)

------------------------------------------------------------
-- ========================================================
-- SETTINGS
-- ========================================================
------------------------------------------------------------

CreateSection(
	SettingsPage,
	"Personalização"
)

------------------------------------------------------------
-- THEME
------------------------------------------------------------

local ThemeCard,
	_,
	ThemeDescription =
	CreateCard(

		SettingsPage,

		"Tema",

		Theme().Display

	)

local ThemeButton =
	CreateCycleButton(

	ThemeCard,

	Theme().Display

)

------------------------------------------------------------

ThemeButton.MouseButton1Click:Connect(
	function()

		ThemeIndex +=
			1

		if ThemeIndex >
			#ThemeOrder
		then

			ThemeIndex =
				1

		end

		local Name =
			ThemeOrder[
				ThemeIndex
			]

		ApplyTheme(
			Name,
			true
		)

		ThemeButton.Text =
			Theme().Display

		ThemeDescription.Text =
			Theme().Display

		----------------------------------------------------
		-- REFRESH TOGGLE STATE COLORS
		----------------------------------------------------

		LineToggle.UpdateVisual()

		BoxToggle.UpdateVisual()

		ChamsToggle.UpdateVisual()

		XRayToggle.UpdateVisual()

	end
)

------------------------------------------------------------
-- XRAY POWER
------------------------------------------------------------

local XRayPowerCard,
	_,
	XRayPowerDescription =
	CreateCard(

		SettingsPage,

		"Força XRay",

		"68%"

	)

local XRayPowerButton =
	CreateCycleButton(
		XRayPowerCard,
		"68%"
	)

local XRayLevels = {

	0.50,

	0.68,

	0.78,

	0.86
}

local XRayIndex =
	2

------------------------------------------------------------

XRayPowerButton.MouseButton1Click:Connect(
	function()

		XRayIndex +=
			1

		if XRayIndex >
			#XRayLevels
		then

			XRayIndex =
				1

		end

		CONFIG.XRayTransparency =
			XRayLevels[
				XRayIndex
			]

		local Percent =
			math.floor(

				CONFIG.XRayTransparency

				* 100

			)

		XRayPowerButton.Text =
			Percent
			.. "%"

		XRayPowerDescription.Text =
			Percent
			.. "%"

		RefreshXRay()

	end
)

------------------------------------------------------------
-- ESP DISTANCE
------------------------------------------------------------

local DistanceCard,
	_,
	DistanceDescription =
	CreateCard(

		SettingsPage,

		"Distância ESP",

		"450 studs"

	)

local DistanceButton =
	CreateCycleButton(
		DistanceCard,
		"450"
	)

local Distances = {

	150,

	300,

	450,

	700,

	1000
}

local DistanceIndex =
	3

------------------------------------------------------------

DistanceButton.MouseButton1Click:Connect(
	function()

		DistanceIndex +=
			1

		if DistanceIndex >
			#Distances
		then

			DistanceIndex =
				1

		end

		CONFIG.ESPDistance =
			Distances[
				DistanceIndex
			]

		DistanceButton.Text =
			tostring(
				CONFIG.ESPDistance
			)

		DistanceDescription.Text =
			CONFIG.ESPDistance
			.. " studs"

	end
)

------------------------------------------------------------
-- UI SCALE
------------------------------------------------------------

local ScaleCard,
	_,
	ScaleDescription =
	CreateCard(

		SettingsPage,

		"Tamanho da Interface",

		"100%"

	)

local ScaleButton =
	CreateCycleButton(
		ScaleCard,
		"100%"
	)

local ScaleLevels = {

	0.82,

	0.90,

	1,

	1.08
}

local ScaleIndex =
	3

------------------------------------------------------------

ScaleButton.MouseButton1Click:Connect(
	function()

		ScaleIndex +=
			1

		if ScaleIndex >
			#ScaleLevels
		then

			ScaleIndex =
				1

		end

		UserScale =
			ScaleLevels[
				ScaleIndex
			]

		local Percentage =
			math.floor(
				UserScale
				* 100
			)

		ScaleButton.Text =
			Percentage
			.. "%"

		ScaleDescription.Text =
			Percentage
			.. "%"

		UpdateScale()

	end
)

------------------------------------------------------------
-- ========================================================
-- NAVIGATION
-- ========================================================
------------------------------------------------------------

local PageInfo = {

	Principal = {

		Icon = "⌂",

		Text = "Principal"
	},

	Visuais = {

		Icon = "◉",

		Text = "Visuais"
	},

	Diversos = {

		Icon = "◇",

		Text = "Diversos"
	},

	Ajustes = {

		Icon = "⚙",

		Text = "Ajustes"
	},
}

------------------------------------------------------------

local NavigationOrder = {

	"Principal",

	"Visuais",

	"Diversos",

	"Ajustes"
}

------------------------------------------------------------

local NavButtons =
	{}

local CurrentPage =
	"Principal"

------------------------------------------------------------
-- SWITCH PAGE
------------------------------------------------------------

local function SwitchPage(
	Name
)

	CurrentPage =
		Name

	for PageName,
		Page
		in pairs(
			Pages
		)
	do

		Page.Visible =
			PageName ==
			Name

	end

	for ButtonName,
		Data
		in pairs(
			NavButtons
		)
	do

		local Active =
			ButtonName ==
			Name

		Data.Bar.Visible =
			Active

		Data.Button.BackgroundColor3 =
			Active
			and Theme().Card
			or Theme().Sidebar

		Data.Button.BackgroundTransparency =
			Active
			and 0
			or 1

		Data.Icon.TextColor3 =
			Active
			and Theme().Accent
			or Theme().Sub

		Data.Text.TextColor3 =
			Active
			and Theme().Text
			or Theme().Sub

	end

	local Info =
		PageInfo[
			Name
		]

	HeaderIcon.Text =
		Info.Icon

	HeaderTitle.Text =
		string.upper(
			Info.Text
		)

end

------------------------------------------------------------
-- NAV BUTTONS
------------------------------------------------------------

for Index,
	Name
	in ipairs(
		NavigationOrder
	)
do

	local Info =
		PageInfo[
			Name
		]

	local Button =
		Instance.new(
			"TextButton"
		)

	Button.LayoutOrder =
		Index

	Button.Size =
		UDim2.new(
			1,
			0,
			0,
			49
		)

	Button.BorderSizePixel =
		0

	Button.Text =
		""

	Button.AutoButtonColor =
		false

	Button.Parent =
		Navigation

	BindTheme(
		Button,
		"BackgroundColor3",
		"Sidebar"
	)

	Corner(
		Button,
		9
	)

	--------------------------------------------------------

	local Bar =
		Instance.new(
			"Frame"
		)

	Bar.Position =
		UDim2.fromOffset(
			0,
			8
		)

	Bar.Size =
		UDim2.fromOffset(
			3,
			33
		)

	Bar.BorderSizePixel =
		0

	Bar.Visible =
		false

	Bar.Parent =
		Button

	BindTheme(
		Bar,
		"BackgroundColor3",
		"Accent"
	)

	Corner(
		Bar,
		2
	)

	--------------------------------------------------------

	local Icon =
		Instance.new(
			"TextLabel"
		)

	Icon.Position =
		UDim2.fromOffset(
			14,
			0
		)

	Icon.Size =
		UDim2.fromOffset(
			30,
			49
		)

	Icon.BackgroundTransparency =
		1

	Icon.Text =
		Info.Icon

	Icon.TextSize =
		20

	Icon.FontFace =
		FONT_BOLD

	Icon.Parent =
		Button

	BindTheme(
		Icon,
		"TextColor3",
		"Sub"
	)

	--------------------------------------------------------

	local Text =
		Instance.new(
			"TextLabel"
		)

	Text.Position =
		UDim2.fromOffset(
			48,
			0
		)

	Text.Size =
		UDim2.new(
			1,
			-50,
			1,
			0
		)

	Text.BackgroundTransparency =
		1

	Text.Text =
		Info.Text

	Text.TextSize =
		12

	Text.FontFace =
		FONT_MEDIUM

	Text.TextXAlignment =
		Enum.TextXAlignment.Left

	Text.Parent =
		Button

	BindTheme(
		Text,
		"TextColor3",
		"Sub"
	)

	--------------------------------------------------------

	NavButtons[
		Name
	] = {

		Button = Button,

		Bar = Bar,

		Icon = Icon,

		Text = Text
	}

	Button.MouseButton1Click:Connect(
		function()

			SwitchPage(
				Name
			)

		end
	)

end

------------------------------------------------------------
-- ========================================================
-- MOBILE DRAG
-- ========================================================
------------------------------------------------------------

local function ClampToScreen(
	Target,
	X,
	Y
)

	local View =
		Camera.ViewportSize

	local W =
		Target.AbsoluteSize.X

	local H =
		Target.AbsoluteSize.Y

	X =
		math.clamp(

			X,

			5,

			math.max(
				5,
				View.X
				- W
				- 5
			)

		)

	Y =
		math.clamp(

			Y,

			5,

			math.max(
				5,
				View.Y
				- H
				- 5
			)

		)

	return X,
		Y
end

------------------------------------------------------------
-- MOBILE + PC DRAG
------------------------------------------------------------

local function MakeDraggable(
	Handle,
	Target,
	TapCallback
)

	local Dragging =
		false

	local Moved =
		false

	local ActiveTouch =
		nil

	local StartInput =
		nil

	local StartPos =
		nil

	local Threshold =
		8

	--------------------------------------------------------
	-- START
	--------------------------------------------------------

	Handle.InputBegan:Connect(
		function(Input)

			if Input.UserInputType ~=
				Enum.UserInputType.Touch

				and

				Input.UserInputType ~=
				Enum.UserInputType.MouseButton1
			then

				return

			end

			Dragging =
				true

			Moved =
				false

			ActiveTouch =
				Input

			StartInput =
				Input.Position

			local Abs =
				Target.AbsolutePosition

			Target.AnchorPoint =
				Vector2.new(
					0,
					0
				)

			Target.Position =
				UDim2.fromOffset(

					Abs.X,

					Abs.Y

				)

			StartPos =
				Vector2.new(

					Abs.X,

					Abs.Y

				)

		end
	)

	--------------------------------------------------------
	-- TOUCH MOVED
	--------------------------------------------------------

	UIS.TouchMoved:Connect(
		function(Input)

			if not Dragging
				or not ActiveTouch
			then

				return

			end

			if ActiveTouch.UserInputType ~=
				Enum.UserInputType.Touch
			then

				return

			end

			if Input ~=
				ActiveTouch
			then

				return

			end

			local Delta =
				Input.Position
				- StartInput

			if Delta.Magnitude >
				Threshold
			then

				Moved =
					true

			end

			if not Moved then

				return

			end

			local X =
				StartPos.X
				+ Delta.X

			local Y =
				StartPos.Y
				+ Delta.Y

			X,
				Y =
				ClampToScreen(

					Target,

					X,

					Y

				)

			Target.Position =
				UDim2.fromOffset(
					X,
					Y
				)

		end
	)

	--------------------------------------------------------
	-- MOUSE MOVE
	--------------------------------------------------------

	UIS.InputChanged:Connect(
		function(Input)

			if not Dragging
				or not ActiveTouch
			then

				return

			end

			if ActiveTouch.UserInputType ~=
				Enum.UserInputType.MouseButton1
			then

				return

			end

			if Input.UserInputType ~=
				Enum.UserInputType.MouseMovement
			then

				return

			end

			local Current =
				UIS:GetMouseLocation()

			local Delta =
				Current
				- StartInput

			if Delta.Magnitude >
				Threshold
			then

				Moved =
					true

			end

			if not Moved then

				return

			end

			local X =
				StartPos.X
				+ Delta.X

			local Y =
				StartPos.Y
				+ Delta.Y

			X,
				Y =
				ClampToScreen(

					Target,

					X,

					Y

				)

			Target.Position =
				UDim2.fromOffset(
					X,
					Y
				)

		end
	)

	--------------------------------------------------------
	-- END
	--------------------------------------------------------

	UIS.InputEnded:Connect(
		function(Input)

			if not Dragging
				or not ActiveTouch
			then

				return

			end

			local Correct =
				false

			if ActiveTouch.UserInputType ==
				Enum.UserInputType.Touch
			then

				Correct =
					Input ==
					ActiveTouch

			else

				Correct =
					Input.UserInputType ==
					Enum.UserInputType.MouseButton1

			end

			if not Correct then

				return

			end

			Dragging =
				false

			ActiveTouch =
				nil

			if not Moved
				and TapCallback
			then

				TapCallback()

			end

		end
	)

end

------------------------------------------------------------
-- DRAG MAIN
------------------------------------------------------------

MakeDraggable(

	HeaderDrag,

	Main,

	nil

)

------------------------------------------------------------
-- ========================================================
-- FLOATING BUTTON
-- ========================================================
------------------------------------------------------------

local Floating =
	Instance.new(
		"ImageButton"
	)

Floating.Name =
	"FloatingLogo"

Floating.AnchorPoint =
	Vector2.new(
		0,
		0
	)

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

Floating.Visible =
	false

Floating.ZIndex =
	500

Floating.Parent =
	GUI

BindTheme(
	Floating,
	"BackgroundColor3",
	"BG2"
)

Corner(
	Floating,
	31
)

Stroke(
	Floating,
	"Accent",
	2,
	0
)

------------------------------------------------------------
-- FLOATING GLOW
------------------------------------------------------------

local FloatingGlow =
	Instance.new(
		"Frame"
	)

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

FloatingGlow.BackgroundTransparency =
	0.88

FloatingGlow.BorderSizePixel =
	0

FloatingGlow.Active =
	false

FloatingGlow.ZIndex =
	499

FloatingGlow.Parent =
	Floating

BindTheme(
	FloatingGlow,
	"BackgroundColor3",
	"Accent"
)

Corner(
	FloatingGlow,
	40
)

------------------------------------------------------------
-- MINIMIZE
------------------------------------------------------------

local Minimized =
	false

local function MinimizeUI()

	if Minimized then

		return

	end

	Minimized =
		true

	Main.Visible =
		false

	Floating.Visible =
		true

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

	Floating.Visible =
		false

	Main.Visible =
		true

end

------------------------------------------------------------
-- CLOSE
------------------------------------------------------------

Close.MouseButton1Click:Connect(
	MinimizeUI
)

------------------------------------------------------------
-- FLOATING MOBILE DRAG
------------------------------------------------------------

MakeDraggable(

	Floating,

	Floating,

	function()

		RestoreUI()

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
-- INITIAL THEME
------------------------------------------------------------

ApplyTheme(
	CurrentThemeName,
	false
)

SwitchPage(
	"Principal"
)

UpdateElevatorUI()
