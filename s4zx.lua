--[[
==============================================================
                    SOUZA ADMIN V11
              MOBILE-FIRST • ÚNICO LOCALSCRIPT
==============================================================

StarterPlayer
    > StarterPlayerScripts
        > LocalScript

PRINCIPAL
    • Elevador V11
    • TP FROM
    • DESCNY
    • AntiLag

VISUAIS
    • XRay Seguro
    • ESP Line
    • ESP Box
    • Chams
    • Categoria

DIVERSOS
    • Remover elevador
    • Desligar visuais

AJUSTES
    • Tema
    • Distância ESP
    • Intensidade XRay
    • Escala

IMPORTANTE:

XRAY V11:
    NÃO muda propriedades do mapa.
    NÃO muda Transparency.
    NÃO muda LocalTransparencyModifier.
    NÃO muda CanCollide.
    NÃO muda Material.

    Apenas cria Highlights locais em CurrentCamera.

ELEVADOR V11:
    NÃO usa Root.CFrame.
    NÃO usa Character:PivotTo.
    NÃO altera velocity.
    NÃO teleporta o personagem.

    Somente o BLOCO se move.

==============================================================
]]

------------------------------------------------------------
-- SERVICES
------------------------------------------------------------

local Players =
	game:GetService("Players")

local RunService =
	game:GetService("RunService")

local TweenService =
	game:GetService("TweenService")

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

	Logo =
		"rbxthumb://type=Asset&id=98880379063768&w=420&h=420",

	--------------------------------------------------------
	-- UI
	--------------------------------------------------------

	Width = 700,

	Height = 430,

	SidebarWidth = 154,

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

	-- IMPORTANTE:
	-- movimento limitado independente
	-- de quantas vezes apertar +/-

	UpSpeed = 4.4,

	DownSpeed = 3.0,

	-- teleport/rubberband REALMENTE grande
	RecoveryHorizontal = 35,

	RecoveryVertical = 25,

	--------------------------------------------------------
	-- TP FROM
	--------------------------------------------------------

	TPDistance = 32,

	--------------------------------------------------------
	-- ESP
	--------------------------------------------------------

	ESPDistance = 450,

	ESPUpdateRate = 1 / 20,

	--------------------------------------------------------
	-- SAFE XRAY
	--------------------------------------------------------

	XRayMaxParts = 180,

	XRayMinimumSize = 8,

	XRayFillTransparency = 0.95,

	XRayOutlineTransparency = 0.28,
}

------------------------------------------------------------
-- FONT
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

	Ember = {

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
				52
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

		Text =
			Color3.fromRGB(
				246,
				248,
				251
			),

		Sub =
			Color3.fromRGB(
				157,
				170,
				186
			),

		Muted =
			Color3.fromRGB(
				89,
				105,
				125
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
				116,
				46
			),
	},

	Violet = {

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
				23,
				19,
				39
			),

		CardHover =
			Color3.fromRGB(
				33,
				27,
				55
			),

		Control =
			Color3.fromRGB(
				12,
				9,
				25
			),

		Stroke =
			Color3.fromRGB(
				54,
				44,
				78
			),

		Text =
			Color3.fromRGB(
				249,
				247,
				255
			),

		Sub =
			Color3.fromRGB(
				176,
				163,
				201
			),

		Muted =
			Color3.fromRGB(
				109,
				95,
				142
			),

		Accent =
			Color3.fromRGB(
				139,
				87,
				255
			),

		Accent2 =
			Color3.fromRGB(
				177,
				131,
				255
			),
	},

	Ocean = {

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
				40,
				55
			),

		Control =
			Color3.fromRGB(
				5,
				17,
				26
			),

		Stroke =
			Color3.fromRGB(
				29,
				59,
				76
			),

		Text =
			Color3.fromRGB(
				244,
				250,
				255
			),

		Sub =
			Color3.fromRGB(
				147,
				183,
				201
			),

		Muted =
			Color3.fromRGB(
				79,
				124,
				146
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
				196,
				255
			),
	},

	Crimson = {

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
				52,
				18,
				28
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
				41
			),

		Text =
			Color3.fromRGB(
				255,
				245,
				248
			),

		Sub =
			Color3.fromRGB(
				205,
				154,
				167
			),

		Muted =
			Color3.fromRGB(
				143,
				84,
				100
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
				88,
				116
			),
	},

	Mono = {

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
				32,
				32,
				39
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
	}
}

------------------------------------------------------------
-- THEME
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

local CurrentTheme =
	ThemeOrder[
		ThemeIndex
	]

local function T()

	return THEMES[
		CurrentTheme
	]

end

------------------------------------------------------------
-- THEME BINDINGS
------------------------------------------------------------

local ThemeBindings =
	{}

local ThemeRefreshCallbacks =
	{}

------------------------------------------------------------

local function Bind(
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

	if Object then

		Object[
			Property
		] =
			T()[
				Key
			]

	end

end

------------------------------------------------------------

local function RegisterThemeRefresh(
	Callback
)

	table.insert(
		ThemeRefreshCallbacks,
		Callback
	)

end

------------------------------------------------------------
-- TWEEN
------------------------------------------------------------

local function Tween(
	Object,
	Time,
	Properties
)

	local Value =
		TweenService:Create(

			Object,

			TweenInfo.new(
				Time,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.Out
			),

			Properties
		)

	Value:Play()

	return Value

end

------------------------------------------------------------
-- APPLY THEME
------------------------------------------------------------

local function ApplyTheme(
	Name
)

	if not THEMES[
		Name
	] then

		return

	end

	CurrentTheme =
		Name

	for _,
		Item
		in ipairs(
			ThemeBindings
		)
	do

		local Object =
			Item.Object

		if Object
			and Object.Parent
		then

			local Value =
				T()[
					Item.Key
				]

			if typeof(
				Value
			) == "Color3"
			then

				Tween(
					Object,
					0.18,
					{
						[
							Item.Property
						] = Value
					}
				)

			else

				Object[
					Item.Property
				] =
					Value

			end

		end

	end

	for _,
		Callback
		in ipairs(
			ThemeRefreshCallbacks
		)
	do

		Callback()

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

	Bind(
		Value,
		"Color",
		Key or "Stroke"
	)

	return Value

end

------------------------------------------------------------
-- CLEAN OLD
------------------------------------------------------------

for _,
	Name
	in ipairs({

		"SouzaAdminV11",

		"SouzaESP_V11"

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

for _,
	Name
	in ipairs({

		"SouzaElevatorV11",

		"SouzaAdminPlatform_"
		.. Player.UserId

	})
do

	local Existing =
		workspace:FindFirstChild(
			Name
		)

	if Existing then

		Existing:Destroy()

	end

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
-- ELEVATOR V11
-- ========================================================
------------------------------------------------------------

local Platform =
	nil

local ElevatorLevel =
	0

local ElevatorBaseY =
	nil

local ElevatorY =
	nil

local ElevatorTargetY =
	nil

local LastRootPosition =
	nil

------------------------------------------------------------
-- FEET Y
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
-- PLATFORM GUI
------------------------------------------------------------

local function CreatePlatformDesign(
	Part
)

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
		Part

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

	BG.BorderSizePixel =
		0

	BG.Parent =
		Surface

	Bind(
		BG,
		"BackgroundColor3",
		"BG2"
	)

	--------------------------------------------------------

	local Gradient =
		Instance.new(
			"UIGradient"
		)

	Gradient.Rotation =
		35

	Gradient.Parent =
		BG

	local function RefreshGradient()

		Gradient.Color =
			ColorSequence.new({

				ColorSequenceKeypoint.new(
					0,
					T().Accent
				),

				ColorSequenceKeypoint.new(
					0.35,
					T().BG2
				),

				ColorSequenceKeypoint.new(
					1,
					T().BG
				)
			})

	end

	RefreshGradient()

	RegisterThemeRefresh(
		RefreshGradient
	)

	--------------------------------------------------------

	Stroke(
		BG,
		"Accent",
		3,
		0.05
	)

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

	Fallback.TextScaled =
		true

	Fallback.TextTransparency =
		0.7

	Fallback.FontFace =
		FONT_BOLD

	Fallback.Parent =
		BG

	Bind(
		Fallback,
		"TextColor3",
		"Accent"
	)

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
-- CREATE
------------------------------------------------------------

local function CreateElevator()

	if Platform
		and Platform.Parent
	then

		return

	end

	local Feet =
		GetFeetY()

	if not Feet
		or not Root
	then

		return

	end

	ElevatorLevel =
		1

	ElevatorBaseY =
		Feet

		- CONFIG.PlatformSize.Y / 2

		- 0.04

	ElevatorY =
		ElevatorBaseY

	ElevatorTargetY =
		ElevatorBaseY

	LastRootPosition =
		Root.Position

	--------------------------------------------------------

	Platform =
		Instance.new(
			"Part"
		)

	Platform.Name =
		"SouzaElevatorV11"

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
			12,
			17,
			26
		)

	Platform.TopSurface =
		Enum.SurfaceType.Smooth

	Platform.BottomSurface =
		Enum.SurfaceType.Smooth

	Platform.CFrame =
		CFrame.new(

			Root.Position.X,

			ElevatorY,

			Root.Position.Z

		)

	Platform.Parent =
		workspace

	CreatePlatformDesign(
		Platform
	)

end

------------------------------------------------------------
-- REMOVE
------------------------------------------------------------

local function RemoveElevator()

	ElevatorLevel =
		0

	ElevatorBaseY =
		nil

	ElevatorY =
		nil

	ElevatorTargetY =
		nil

	LastRootPosition =
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

local function RebaseElevator()

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

	local Offset =
		math.max(
			ElevatorLevel - 1,
			0
		)

		* CONFIG.StepHeight

	--------------------------------------------------------
	-- mantém o número do nível
	-- mas aceita a nova posição do jogo
	--------------------------------------------------------

	ElevatorY =
		Feet

		- CONFIG.PlatformSize.Y / 2

		- 0.04

	ElevatorBaseY =
		ElevatorY
		- Offset

	ElevatorTargetY =
		ElevatorY

	LastRootPosition =
		Root.Position

end

------------------------------------------------------------
-- LEVEL CHANGE
------------------------------------------------------------

local function ChangeElevatorLevel(
	Direction
)

	if not Root
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

		CreateElevator()

		return true,
			"Nível 1"

	end

	--------------------------------------------------------

	local NewLevel =
		ElevatorLevel
		+ Direction

	if NewLevel <= 0 then

		RemoveElevator()

		return true,
			"Desativado"

	end

	NewLevel =
		math.clamp(

			NewLevel,

			1,

			CONFIG.MaxLevel

		)

	ElevatorLevel =
		NewLevel

	--------------------------------------------------------
	-- Só troca destino.
	-- NÃO move player.
	--------------------------------------------------------

	ElevatorTargetY =
		ElevatorBaseY

		+ (
			ElevatorLevel - 1
		)

		* CONFIG.StepHeight

	return true,
		"Nível "
		.. ElevatorLevel

end

------------------------------------------------------------
-- ELEVATOR LOOP
------------------------------------------------------------

RunService.Heartbeat:Connect(
	function(DT)

		if not Platform
			or not Platform.Parent
			or not Root
			or not Root.Parent
			or not Humanoid
			or Humanoid.Health <= 0
		then

			return

		end

		local Position =
			Root.Position

		----------------------------------------------------
		-- LARGE SERVER/GAME MOVEMENT
		----------------------------------------------------

		if LastRootPosition then

			local Delta =
				Position
				- LastRootPosition

			local Horizontal =
				Vector2.new(

					Delta.X,

					Delta.Z

				).Magnitude

			local Vertical =
				math.abs(
					Delta.Y
				)

			if Horizontal >
				CONFIG.RecoveryHorizontal

				or

				Vertical >
				CONFIG.RecoveryVertical
			then

				------------------------------------------------
				-- NÃO TELEPORTA PLAYER.
				-- bloco aceita a nova posição.
				------------------------------------------------

				RebaseElevator()

				return

			end

		end

		LastRootPosition =
			Position

		----------------------------------------------------
		-- MOVE Y WITH HARD SPEED LIMIT
		----------------------------------------------------

		if ElevatorTargetY
			and ElevatorY
		then

			local Difference =
				ElevatorTargetY
				- ElevatorY

			if math.abs(
				Difference
			) > 0.001
			then

				local Speed

				if Difference > 0 then

					Speed =
						CONFIG.UpSpeed

				else

					-- descida mais devagar
					-- justamente para não matar
					Speed =
						CONFIG.DownSpeed

				end

				local MaxStep =
					Speed
					* DT

				if math.abs(
					Difference
				) <= MaxStep
				then

					ElevatorY =
						ElevatorTargetY

				else

					ElevatorY +=

						math.sign(
							Difference
						)

						* MaxStep

				end

			end

		end

		----------------------------------------------------
		-- APPLY ONLY TO PLATFORM
		----------------------------------------------------

		Platform.CFrame =
			CFrame.new(

				Position.X,

				ElevatorY,

				Position.Z

			)

	end
)

------------------------------------------------------------
-- ========================================================
-- DESCNY
-- ========================================================
------------------------------------------------------------

local InvisibleKeywords = {

	"invis",

	"invisible",

	"invisibility",

	"cloak",

	"capa",

	"descny",

	"ghost",

	"vanish"
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
		Keyword
		in ipairs(
			InvisibleKeywords
		)
	do

		if string.find(

			Search,

			Keyword,

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

	local Success =
		pcall(
			function()

				Tool:Activate()

			end
		)

	return Success,
		Success
			and Tool.Name
			or "Falha ao ativar"

end

------------------------------------------------------------
-- ========================================================
-- TP FROM
-- ========================================================
------------------------------------------------------------

local TPBusy =
	false

------------------------------------------------------------
-- SAFE DESTINATION
------------------------------------------------------------

local function TPPositionClear(
	Position,
	Wall
)

	if not Character then

		return false

	end

	local _,
		CharSize =
		Character:GetBoundingBox()

	local CheckSize =
		Vector3.new(

			math.max(
				CharSize.X * 0.6,
				2
			),

			math.max(
				CharSize.Y * 0.7,
				3
			),

			math.max(
				CharSize.Z * 0.6,
				2
			)

		)

	local Params =
		OverlapParams.new()

	Params.FilterType =
		Enum.RaycastFilterType.Exclude

	local Ignore = {

		Character,

		Wall
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

			CFrame.new(
				Position
			),

			CheckSize,

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
-- FIND FAR FACE
------------------------------------------------------------

local function WallExitPoint(
	Part,
	Hit,
	Direction
)

	local LocalHit =
		Part.CFrame:PointToObjectSpace(

			Hit

			+ Direction
			* 0.05

		)

	local LocalDirection =
		Part.CFrame:VectorToObjectSpace(
			Direction
		)

	local Half =
		Part.Size / 2

	local TMax =
		math.huge

	--------------------------------------------------------

	local function Check(
		Origin,
		Dir,
		HalfSize
	)

		if math.abs(
			Dir
		) < 0.00001
		then

			return

		end

		local Boundary

		if Dir > 0 then

			Boundary =
				HalfSize

		else

			Boundary =
				-HalfSize

		end

		local T =
			(
				Boundary
				- Origin
			)

			/ Dir

		if T > 0
			and T < TMax
		then

			TMax =
				T

		end

	end

	--------------------------------------------------------

	Check(
		LocalHit.X,
		LocalDirection.X,
		Half.X
	)

	Check(
		LocalHit.Y,
		LocalDirection.Y,
		Half.Y
	)

	Check(
		LocalHit.Z,
		LocalDirection.Z,
		Half.Z
	)

	--------------------------------------------------------

	if TMax ==
		math.huge
	then

		return nil

	end

	local LocalExit =
		LocalHit

		+ LocalDirection
		* TMax

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

	if not Character
		or not Root
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
			* CONFIG.TPDistance,

			Params

		)

	if not Result then

		TPBusy =
			false

		return false,
			"Sem parede"

	end

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

	--------------------------------------------------------
	-- FLOOR/TOP
	--------------------------------------------------------

	if math.abs(
		Result.Normal.Y
	) > 0.72
	then

		TPBusy =
			false

		return false,
			"Aponte para parede"

	end

	--------------------------------------------------------
	-- OTHER SIDE
	--------------------------------------------------------

	local Exit =
		WallExitPoint(

			Wall,

			Result.Position,

			Direction

		)

	if not Exit then

		TPBusy =
			false

		return false,
			"Saída não encontrada"

	end

	--------------------------------------------------------
	-- FIND CLEAR SPACE
	--------------------------------------------------------

	local Destination =
		nil

	for Distance =
		2.5,
		10,
		0.5
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

	--------------------------------------------------------

	if not Destination then

		TPBusy =
			false

		return false,
			"Sem espaço do outro lado"

	end

	--------------------------------------------------------
	-- SINGLE PIVOT ONLY
	--------------------------------------------------------

	Character:PivotTo(

		CFrame.lookAt(

			Destination,

			Destination
			+ Direction

		)

	)

	--------------------------------------------------------
	-- elevator accepts new position
	--------------------------------------------------------

	if Platform then

		task.defer(
			RebaseElevator
		)

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

local AntiCache =
	{}

local AntiGeneration =
	0

------------------------------------------------------------

local function CacheProperty(
	Object,
	Property
)

	if not AntiCache[
		Object
	] then

		AntiCache[
			Object
		] =
			{}

	end

	if AntiCache[
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

		AntiCache[
			Object
		][Property] =
			Value

	end

end

------------------------------------------------------------

local function ChangeProperty(
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

local function RestoreAntiLag()

	AntiGeneration +=
		1

	for Object,
		Properties
		in pairs(
			AntiCache
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

	AntiCache =
		{}

end

------------------------------------------------------------

local function OptimizeObject(
	Object,
	Level
)

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

			ChangeProperty(
				Object,
				"Enabled",
				false
			)

		end

	end

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
		then

			ChangeProperty(
				Object,
				"Enabled",
				false
			)

		end

	end

	--------------------------------------------------------

	if Level >= 3 then

		if Object:IsA(
			"BasePart"
		)
		then

			ChangeProperty(
				Object,
				"CastShadow",
				false
			)

		end

	end

end

------------------------------------------------------------

local function SetAntiLag(
	Level
)

	RestoreAntiLag()

	AntiLagLevel =
		Level

	if Level <= 0 then

		return

	end

	AntiGeneration +=
		1

	local Generation =
		AntiGeneration

	task.spawn(
		function()

			local Objects =
				workspace:GetDescendants()

			for Index,
				Object
				in ipairs(
					Objects
				)
			do

				if Generation ~=
					AntiGeneration
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
-- ========================================================
-- SAFE XRAY V11
--
-- ZERO MAP PROPERTY MODIFICATION
-- ========================================================
------------------------------------------------------------

local XRayEnabled =
	false

local XRayHighlights =
	{}

local XRayCount =
	0

------------------------------------------------------------
-- CHARACTER OBJECT?
------------------------------------------------------------

local function IsCharacterObject(
	Object
)

	local Model =
		Object:FindFirstAncestorOfClass(
			"Model"
		)

	if Model
		and Model:FindFirstChildOfClass(
			"Humanoid"
		)
	then

		return true

	end

	return false

end

------------------------------------------------------------
-- XRAY CANDIDATE
------------------------------------------------------------

local function IsSafeXRayCandidate(
	Part
)

	if not Part:IsA(
		"BasePart"
	) then

		return false

	end

	if not Part.Anchored then

		return false

	end

	if Platform
		and Part ==
			Platform
	then

		return false

	end

	if IsCharacterObject(
		Part
	) then

		return false

	end

	if Part:GetAttribute(
		"NoXRay"
	) == true
	then

		return false

	end

	--------------------------------------------------------
	-- evita criar highlight pra detalhezinho pequeno
	-- isso deixa mobile muito mais leve
	--------------------------------------------------------

	if Part.Size.Magnitude <
		CONFIG.XRayMinimumSize
	then

		return false

	end

	return true

end

------------------------------------------------------------
-- ADD HIGHLIGHT
------------------------------------------------------------

local function AddXRayHighlight(
	Part
)

	if not XRayEnabled then

		return

	end

	if XRayHighlights[
		Part
	] then

		return

	end

	if XRayCount >=
		CONFIG.XRayMaxParts
	then

		return

	end

	if not IsSafeXRayCandidate(
		Part
	) then

		return

	end

	--------------------------------------------------------
	-- IMPORTANT:
	-- Highlight fica dentro da CAMERA.
	-- NÃO vira filho do mapa.
	--------------------------------------------------------

	local Highlight =
		Instance.new(
			"Highlight"
		)

	Highlight.Name =
		"SouzaSafeXRay"

	Highlight.Adornee =
		Part

	Highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	Highlight.FillTransparency =
		CONFIG.XRayFillTransparency

	Highlight.OutlineTransparency =
		CONFIG.XRayOutlineTransparency

	Highlight.FillColor =
		T().Accent

	Highlight.OutlineColor =
		T().Accent2

	Highlight.Parent =
		Camera

	XRayHighlights[
		Part
	] =
		Highlight

	XRayCount +=
		1

end

------------------------------------------------------------
-- ENABLE
------------------------------------------------------------

local function EnableSafeXRay()

	if XRayEnabled then

		return

	end

	XRayEnabled =
		true

	XRayCount =
		0

	task.spawn(
		function()

			local Objects =
				workspace:GetDescendants()

			for Index,
				Object
				in ipairs(
					Objects
				)
			do

				if not XRayEnabled then

					return

				end

				if Object:IsA(
					"BasePart"
				) then

					AddXRayHighlight(
						Object
					)

				end

				if XRayCount >=
					CONFIG.XRayMaxParts
				then

					break

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
-- DISABLE
------------------------------------------------------------

local function DisableSafeXRay()

	XRayEnabled =
		false

	for _,
		Highlight
		in pairs(
			XRayHighlights
		)
	do

		if Highlight then

			Highlight:Destroy()

		end

	end

	XRayHighlights =
		{}

	XRayCount =
		0

end

------------------------------------------------------------
-- REFRESH COLORS
------------------------------------------------------------

local function RefreshSafeXRay()

	if not XRayEnabled then

		return

	end

	for _,
		Highlight
		in pairs(
			XRayHighlights
		)
	do

		if Highlight
			and Highlight.Parent
		then

			Highlight.FillColor =
				T().Accent

			Highlight.OutlineColor =
				T().Accent2

			Highlight.FillTransparency =
				CONFIG.XRayFillTransparency

			Highlight.OutlineTransparency =
				CONFIG.XRayOutlineTransparency

		end

	end

end

RegisterThemeRefresh(
	RefreshSafeXRay
)

------------------------------------------------------------
-- ========================================================
-- ESP
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
	"SouzaESP_V11"

ESPGui.ResetOnSpawn =
	false

ESPGui.IgnoreGuiInset =
	true

ESPGui.DisplayOrder =
	998

ESPGui.Parent =
	PlayerGui

------------------------------------------------------------

local ESPObjects =
	{}

------------------------------------------------------------
-- FILTER
------------------------------------------------------------

local function ShouldShowPlayer(
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
-- COLOR
------------------------------------------------------------

local function PlayerESPColor(
	Target
)

	if Player.Team
		and Target.Team
	then

		if Target.Team ==
			Player.Team
		then

			return Color3.fromRGB(
				75,
				220,
				145
			)

		else

			return Color3.fromRGB(
				240,
				75,
				95
			)

		end

	end

	return T().Accent

end

------------------------------------------------------------
-- CREATE ESP DATA
------------------------------------------------------------

local function GetESPData(
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
	-- CHAMS
	--------------------------------------------------------

	local Chams =
		Instance.new(
			"Highlight"
		)

	Chams.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	Chams.FillTransparency =
		0.66

	Chams.OutlineTransparency =
		0.05

	Chams.Enabled =
		false

	-- CurrentCamera = visual local
	Chams.Parent =
		Camera

	Data.Chams =
		Chams

	--------------------------------------------------------

	ESPObjects[
		Target
	] =
		Data

	return Data

end

------------------------------------------------------------
-- HIDE
------------------------------------------------------------

local function HideESP(
	Data
)

	Data.Box.Visible =
		false

	Data.Line.Visible =
		false

	Data.Chams.Enabled =
		false

end

------------------------------------------------------------
-- BOX UPDATE
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

				local A,
					B =
					Char:GetBoundingBox()

				return
					A,
					B

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

		Vector3.new(-Half.X, -Half.Y, -Half.Z),
		Vector3.new( Half.X, -Half.Y, -Half.Z),
		Vector3.new(-Half.X,  Half.Y, -Half.Z),
		Vector3.new( Half.X,  Half.Y, -Half.Z),

		Vector3.new(-Half.X, -Half.Y, Half.Z),
		Vector3.new( Half.X, -Half.Y, Half.Z),
		Vector3.new(-Half.X,  Half.Y, Half.Z),
		Vector3.new( Half.X,  Half.Y, Half.Z)
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
-- LINE UPDATE
------------------------------------------------------------

local function UpdateLine(
	Data,
	WorldPosition
)

	local Screen,
		Visible =
		Camera:WorldToViewportPoint(
			WorldPosition
		)

	if not Visible
		or Screen.Z <= 0
	then

		Data.Line.Visible =
			false

		return

	end

	local View =
		Camera.ViewportSize

	local From =
		Vector2.new(

			View.X / 2,

			View.Y - 18

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

		local AnyEnabled =
			ESPLine
			or ESPBox
			or ESPChams

		----------------------------------------------------

		if not AnyEnabled then

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

			if Target ==
				Player
			then

				continue

			end

			local Data =
				GetESPData(
					Target
				)

			if not ShouldShowPlayer(
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
				PlayerESPColor(
					Target
				)

			Data.BoxStroke.Color =
				Color

			Data.Line.BackgroundColor3 =
				Color

			Data.Chams.FillColor =
				Color

			Data.Chams.OutlineColor =
				T().Text

			Data.Chams.Adornee =
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

			Data.Chams.Enabled =
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
	"SouzaAdminV11"

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

Main.Active =
	true

Main.ClipsDescendants =
	true

Main.Parent =
	GUI

Bind(
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
-- BACKGROUND
------------------------------------------------------------

local MainGradient =
	Instance.new(
		"UIGradient"
	)

MainGradient.Rotation =
	120

MainGradient.Parent =
	Main

local function RefreshMainGradient()

	MainGradient.Color =
		ColorSequence.new({

			ColorSequenceKeypoint.new(
				0,
				T().BG2
			),

			ColorSequenceKeypoint.new(
				0.55,
				T().BG
			),

			ColorSequenceKeypoint.new(
				1,
				T().Control
			)

		})

end

RefreshMainGradient()

RegisterThemeRefresh(
	RefreshMainGradient
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

local ManualScale =
	1

------------------------------------------------------------

local function RefreshScale()

	local View =
		Camera.ViewportSize

	local Automatic =
		math.clamp(

			math.min(

				View.X / 760,

				View.Y / 470

			),

			0.62,

			1

		)

	MainScale.Scale =
		Automatic
		* ManualScale

end

RefreshScale()

Camera:GetPropertyChangedSignal(
	"ViewportSize"
):Connect(
	RefreshScale
)

------------------------------------------------------------
-- TOP BAR
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

TopAccent.Parent =
	Main

Bind(
	TopAccent,
	"BackgroundColor3",
	"Accent"
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

Sidebar.Parent =
	Main

Bind(
	Sidebar,
	"BackgroundColor3",
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

LogoHolder.Parent =
	Sidebar

Bind(
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
	0
)

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

LogoFallback.Parent =
	LogoHolder

Bind(
	LogoFallback,
	"TextColor3",
	"Accent"
)

------------------------------------------------------------

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
	UDim2.fromOffset(
		50,
		50
	)

Logo.BackgroundTransparency =
	1

Logo.Image =
	CONFIG.Logo

Logo.ScaleType =
	Enum.ScaleType.Fit

Logo.Parent =
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

Brand.Parent =
	Sidebar

Bind(
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
		16
	)

BrandSub.BackgroundTransparency =
	1

BrandSub.Text =
	"ADMIN • MOBILE"

BrandSub.TextSize =
	8

BrandSub.FontFace =
	FONT_MEDIUM

BrandSub.Parent =
	Sidebar

Bind(
	BrandSub,
	"TextColor3",
	"Muted"
)

------------------------------------------------------------
-- NAV
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
		-152
	)

Navigation.BackgroundTransparency =
	1

Navigation.Parent =
	Sidebar

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

Header.Parent =
	Content

------------------------------------------------------------
-- DRAG AREA
------------------------------------------------------------

local DragArea =
	Instance.new(
		"Frame"
	)

DragArea.Size =
	UDim2.new(
		1,
		-70,
		1,
		0
	)

DragArea.BackgroundTransparency =
	1

DragArea.Active =
	true

DragArea.Parent =
	Header

------------------------------------------------------------

local HeaderSmall =
	Instance.new(
		"TextLabel"
	)

HeaderSmall.Position =
	UDim2.fromOffset(
		23,
		12
	)

HeaderSmall.Size =
	UDim2.fromOffset(
		280,
		15
	)

HeaderSmall.BackgroundTransparency =
	1

HeaderSmall.Text =
	"PAINEL ADMIN LOCAL"

HeaderSmall.TextSize =
	8

HeaderSmall.FontFace =
	FONT_MEDIUM

HeaderSmall.TextXAlignment =
	Enum.TextXAlignment.Left

HeaderSmall.Parent =
	DragArea

Bind(
	HeaderSmall,
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

HeaderIcon.Parent =
	DragArea

Bind(
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

HeaderTitle.Parent =
	DragArea

Bind(
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

Close.Parent =
	Header

Bind(
	Close,
	"BackgroundColor3",
	"Control"
)

Bind(
	Close,
	"TextColor3",
	"Accent"
)

Corner(
	Close,
	10
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

PageHolder.Parent =
	Content

------------------------------------------------------------
-- PAGES
------------------------------------------------------------

local Pages =
	{}

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

	Page.ScrollBarThickness =
		3

	Page.ScrollBarImageTransparency =
		0.1

	Page.ScrollingDirection =
		Enum.ScrollingDirection.Y

	Page.Visible =
		false

	Page.Parent =
		PageHolder

	Bind(
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

	Bind(
		Label,
		"TextColor3",
		"Muted"
	)

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

	Card.Parent =
		Parent

	Bind(
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
		"Stroke",
		1,
		0.25
	)

	--------------------------------------------------------

	local Accent =
		Instance.new(
			"Frame"
		)

	Accent.Position =
		UDim2.fromOffset(
			14,
			18
		)

	Accent.Size =
		UDim2.fromOffset(
			4,
			34
		)

	Accent.BorderSizePixel =
		0

	Accent.Parent =
		Card

	Bind(
		Accent,
		"BackgroundColor3",
		"Accent"
	)

	Corner(
		Accent,
		2
	)

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

	Bind(
		TitleLabel,
		"TextColor3",
		"Text"
	)

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

	Bind(
		Desc,
		"TextColor3",
		"Sub"
	)

	return Card,
		Desc

end

------------------------------------------------------------
-- BUTTON
------------------------------------------------------------

local function CreateButton(
	Card,
	Text,
	Width
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
			Width or 115,
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

	Bind(
		Button,
		"BackgroundColor3",
		"Control"
	)

	Bind(
		Button,
		"TextColor3",
		"Text"
	)

	Corner(
		Button,
		9
	)

	Stroke(
		Button,
		"Stroke",
		1,
		0
	)

	return Button

end

------------------------------------------------------------
-- TOGGLE
------------------------------------------------------------

local function CreateToggle(
	Card,
	Callback
)

	local Enabled =
		false

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

	Dot.Size =
		UDim2.fromOffset(
			21,
			21
		)

	Dot.BorderSizePixel =
		0

	Dot.Parent =
		Track

	Corner(
		Dot,
		11
	)

	--------------------------------------------------------

	local function Refresh()

		if Enabled then

			Track.BackgroundColor3 =
				T().Accent

			TrackStroke.Color =
				T().Accent2

			Dot.BackgroundColor3 =
				T().Text

			Dot.Position =
				UDim2.fromOffset(
					45,
					16
				)

		else

			Track.BackgroundColor3 =
				T().Control

			TrackStroke.Color =
				T().Stroke

			Dot.BackgroundColor3 =
				T().Sub

			Dot.Position =
				UDim2.fromOffset(
					17,
					16
				)

		end

	end

	--------------------------------------------------------

	local function Set(
		Value,
		Fire
	)

		Enabled =
			Value

		Refresh()

		if Fire ~= false
			and Callback
		then

			Callback(
				Enabled
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

	Refresh()

	RegisterThemeRefresh(
		Refresh
	)

	return {

		Set = Set,

		Get = function()

			return Enabled

		end
	}

end

------------------------------------------------------------
-- ========================================================
-- PRINCIPAL UI
-- ========================================================
------------------------------------------------------------

CreateSection(
	PrincipalPage,
	"Movimento"
)

------------------------------------------------------------
-- ELEVATOR
------------------------------------------------------------

local ElevatorCard,
	ElevatorDescription =
	CreateCard(

		PrincipalPage,

		"Elevador V11",

		"Desativado"

	)

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

Bind(
	Minus,
	"BackgroundColor3",
	"Control"
)

Bind(
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

local LevelBox =
	Instance.new(
		"Frame"
	)

LevelBox.Position =
	UDim2.fromOffset(
		48,
		0
	)

LevelBox.Size =
	UDim2.fromOffset(
		62,
		40
	)

LevelBox.BorderSizePixel =
	0

LevelBox.Parent =
	ElevatorControls

Bind(
	LevelBox,
	"BackgroundColor3",
	"Text"
)

Corner(
	LevelBox,
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
	LevelBox

Bind(
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

Bind(
	Plus,
	"BackgroundColor3",
	"Accent"
)

Bind(
	Plus,
	"TextColor3",
	"Text"
)

Corner(
	Plus,
	9
)

------------------------------------------------------------
-- UPDATE ELEVATOR
------------------------------------------------------------

local function UpdateElevatorUI()

	LevelText.Text =
		tostring(
			ElevatorLevel
		)

	if not Platform then

		ElevatorDescription.Text =
			"Desativado"

		return

	end

	local Difference =
		math.abs(

			(ElevatorTargetY or 0)

			- (ElevatorY or 0)

		)

	if Difference > 0.05 then

		if ElevatorTargetY >
			ElevatorY
		then

			ElevatorDescription.Text =
				"Nível "
				.. ElevatorLevel
				.. " • subindo com limite de velocidade"

		else

			ElevatorDescription.Text =
				"Nível "
				.. ElevatorLevel
				.. " • descendo com limite de segurança"

		end

	else

		ElevatorDescription.Text =
			"Nível "
			.. ElevatorLevel
			.. " • estável"

	end

end

------------------------------------------------------------

Plus.MouseButton1Click:Connect(
	function()

		ChangeElevatorLevel(
			1
		)

		UpdateElevatorUI()

	end
)

------------------------------------------------------------

Minus.MouseButton1Click:Connect(
	function()

		ChangeElevatorLevel(
			-1
		)

		UpdateElevatorUI()

	end
)

------------------------------------------------------------
-- PERIODIC ELEVATOR UI
------------------------------------------------------------

task.spawn(
	function()

		while GUI.Parent do

			task.wait(
				0.18
			)

			UpdateElevatorUI()

		end

	end
)

------------------------------------------------------------
-- TP FROM
------------------------------------------------------------

local TPCard,
	TPDescription =
	CreateCard(

		PrincipalPage,

		"TP FROM",

		"Atravessa a parede na sua frente"

	)

local TPButton =
	CreateButton(
		TPCard,
		"ATRAVESSAR",
		115
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
					75,
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
						T().Text

				end

			end
		)

	end
)

------------------------------------------------------------
-- UTILITIES
------------------------------------------------------------

CreateSection(
	PrincipalPage,
	"Utilidades"
)

------------------------------------------------------------
-- DESCNY
------------------------------------------------------------

local DescnyCard,
	DescnyDescription =
	CreateCard(

		PrincipalPage,

		"DESCNY",

		"Procura e ativa a capa de invisibilidade"

	)

local DescnyButton =
	CreateButton(
		DescnyCard,
		"ATIVAR",
		115
	)

------------------------------------------------------------

DescnyButton.MouseButton1Click:Connect(
	function()

		DescnyButton.Text =
			"BUSCANDO"

		local Success,
			Message =
			ActivateDescny()

		DescnyDescription.Text =
			Success
			and "Usando " .. tostring(Message)
			or tostring(Message)

		DescnyButton.Text =
			Success
			and "ATIVADO"
			or "NÃO ACHOU"

		task.delay(
			1.2,
			function()

				if DescnyButton.Parent then

					DescnyButton.Text =
						"ATIVAR"

				end

			end
		)

	end
)

------------------------------------------------------------
-- ANTILAG
------------------------------------------------------------

local AntiLagCard,
	AntiLagDescription =
	CreateCard(

		PrincipalPage,

		"AntiLag",

		"OFF"

	)

local AntiLagButton =
	CreateButton(
		AntiLagCard,
		"OFF",
		115
	)

local AntiNames = {

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

		SetAntiLag(
			Next
		)

		AntiLagButton.Text =
			AntiNames[
				Next
			]

		AntiLagDescription.Text =
			"Modo "
			.. AntiNames[
				Next
			]

	end
)

------------------------------------------------------------
-- ========================================================
-- VISUAIS UI
-- ========================================================
------------------------------------------------------------

CreateSection(
	VisualPage,
	"Mapa"
)

------------------------------------------------------------
-- SAFE XRAY
------------------------------------------------------------

local XRayCard,
	XRayDescription =
	CreateCard(

		VisualPage,

		"XRay Seguro",

		"Highlights locais • não altera peças do mapa"

	)

local XRayToggle =
	CreateToggle(
		XRayCard,

		function(State)

			if State then

				EnableSafeXRay()

				XRayDescription.Text =
					"Ativado • zero propriedades do mapa modificadas"

			else

				DisableSafeXRay()

				XRayDescription.Text =
					"Highlights locais • não altera peças do mapa"

			end

		end
	)

------------------------------------------------------------
-- ESP
------------------------------------------------------------

CreateSection(
	VisualPage,
	"ESP Players"
)

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

		function(State)

			ESPLine =
				State

		end
	)

------------------------------------------------------------

local BoxCard =
	CreateCard(

		VisualPage,

		"ESP Box",

		"Caixa em volta do jogador"

	)

local BoxToggle =
	CreateToggle(
		BoxCard,

		function(State)

			ESPBox =
				State

		end
	)

------------------------------------------------------------

local ChamsCard =
	CreateCard(

		VisualPage,

		"Chams",

		"Highlight local através das paredes"

	)

local ChamsToggle =
	CreateToggle(
		ChamsCard,

		function(State)

			ESPChams =
				State

		end
	)

------------------------------------------------------------
-- CATEGORY
------------------------------------------------------------

local CategoryCard,
	CategoryDescription =
	CreateCard(

		VisualPage,

		"Categoria",

		"Todos"

	)

local CategoryButton =
	CreateButton(
		CategoryCard,
		"TODOS",
		125
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
	"Controles rápidos"
)

------------------------------------------------------------

local RemoveCard =
	CreateCard(

		MiscPage,

		"Remover Elevador",

		"Apaga a plataforma imediatamente"

	)

local RemoveButton =
	CreateButton(
		RemoveCard,
		"REMOVER",
		115
	)

RemoveButton.MouseButton1Click:Connect(
	function()

		RemoveElevator()

		UpdateElevatorUI()

	end
)

------------------------------------------------------------

local DisableCard =
	CreateCard(

		MiscPage,

		"Desligar Visuais",

		"Desativa XRay e todos ESP"

	)

local DisableButton =
	CreateButton(
		DisableCard,
		"DESLIGAR",
		115
	)

------------------------------------------------------------

DisableButton.MouseButton1Click:Connect(
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

		DisableSafeXRay()

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
	ThemeDescription =
	CreateCard(

		SettingsPage,

		"Tema",

		CurrentTheme

	)

local ThemeButton =
	CreateButton(
		ThemeCard,
		string.upper(
			CurrentTheme
		),
		125
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
			Name
		)

		ThemeButton.Text =
			string.upper(
				Name
			)

		ThemeDescription.Text =
			Name

	end
)

------------------------------------------------------------
-- ESP DISTANCE
------------------------------------------------------------

local DistanceCard,
	DistanceDescription =
	CreateCard(

		SettingsPage,

		"Distância ESP",

		"450 studs"

	)

local DistanceButton =
	CreateButton(
		DistanceCard,
		"450",
		125
	)

local Distances = {

	150,

	300,

	450,

	700
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
-- XRAY INTENSITY
------------------------------------------------------------

local XRayPowerCard,
	XRayPowerDescription =
	CreateCard(

		SettingsPage,

		"Intensidade XRay",

		"Outline médio"

	)

local XRayPowerButton =
	CreateButton(
		XRayPowerCard,
		"MÉDIO",
		125
	)

local XRayModes = {

	{
		Name = "SUAVE",
		Fill = 0.98,
		Outline = 0.55
	},

	{
		Name = "MÉDIO",
		Fill = 0.95,
		Outline = 0.28
	},

	{
		Name = "FORTE",
		Fill = 0.88,
		Outline = 0.08
	}
}

local XRayModeIndex =
	2

------------------------------------------------------------

XRayPowerButton.MouseButton1Click:Connect(
	function()

		XRayModeIndex +=
			1

		if XRayModeIndex >
			#XRayModes
		then

			XRayModeIndex =
				1

		end

		local Mode =
			XRayModes[
				XRayModeIndex
			]

		CONFIG.XRayFillTransparency =
			Mode.Fill

		CONFIG.XRayOutlineTransparency =
			Mode.Outline

		XRayPowerButton.Text =
			Mode.Name

		XRayPowerDescription.Text =
			"Outline "
			.. string.lower(
				Mode.Name
			)

		RefreshSafeXRay()

	end
)

------------------------------------------------------------
-- UI SCALE
------------------------------------------------------------

local ScaleCard,
	ScaleDescription =
	CreateCard(

		SettingsPage,

		"Tamanho da Interface",

		"100%"

	)

local ScaleButton =
	CreateButton(
		ScaleCard,
		"100%",
		125
	)

local ScaleValues = {

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
			#ScaleValues
		then

			ScaleIndex =
				1

		end

		ManualScale =
			ScaleValues[
				ScaleIndex
			]

		local Percent =
			math.floor(
				ManualScale
				* 100
			)

		ScaleButton.Text =
			Percent
			.. "%"

		ScaleDescription.Text =
			Percent
			.. "%"

		RefreshScale()

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
	}
}

local NavigationOrder = {

	"Principal",

	"Visuais",

	"Diversos",

	"Ajustes"
}

local NavButtons =
	{}

------------------------------------------------------------
-- SWITCH
------------------------------------------------------------

local function SwitchPage(
	Name
)

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

	--------------------------------------------------------

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

		Data.Button.BackgroundTransparency =
			Active
			and 0
			or 1

		Data.Button.BackgroundColor3 =
			T().Card

		Data.Icon.TextColor3 =
			Active
			and T().Accent
			or T().Sub

		Data.Text.TextColor3 =
			Active
			and T().Text
			or T().Sub

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

	Button.BackgroundTransparency =
		1

	Button.Text =
		""

	Button.AutoButtonColor =
		false

	Button.Parent =
		Navigation

	Bind(
		Button,
		"BackgroundColor3",
		"Card"
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

	Bind(
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

	Bind(
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

	Bind(
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

local function ClampPosition(
	Target,
	X,
	Y
)

	local View =
		Camera.ViewportSize

	local Width =
		Target.AbsoluteSize.X

	local Height =
		Target.AbsoluteSize.Y

	X =
		math.clamp(

			X,

			5,

			math.max(
				5,
				View.X
				- Width
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
				- Height
				- 5
			)

		)

	return X,
		Y

end

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

	local ActiveInput =
		nil

	local StartPointer =
		nil

	local StartPosition =
		nil

	--------------------------------------------------------
	-- BEGIN
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

			ActiveInput =
				Input

			StartPointer =
				Input.Position

			local Absolute =
				Target.AbsolutePosition

			Target.AnchorPoint =
				Vector2.new(
					0,
					0
				)

			Target.Position =
				UDim2.fromOffset(

					Absolute.X,

					Absolute.Y

				)

			StartPosition =
				Vector2.new(

					Absolute.X,

					Absolute.Y

				)

		end
	)

	--------------------------------------------------------
	-- MOVE
	--------------------------------------------------------

	UIS.InputChanged:Connect(
		function(Input)

			if not Dragging
				or not ActiveInput
			then

				return

			end

			local Pointer

			if ActiveInput.UserInputType ==
				Enum.UserInputType.Touch
			then

				if Input ~=
					ActiveInput
				then

					return

				end

				Pointer =
					Input.Position

			else

				if Input.UserInputType ~=
					Enum.UserInputType.MouseMovement
				then

					return

				end

				Pointer =
					UIS:GetMouseLocation()

			end

			local Delta =
				Pointer
				- StartPointer

			if Delta.Magnitude >
				7
			then

				Moved =
					true

			end

			if not Moved then

				return

			end

			local X =
				StartPosition.X
				+ Delta.X

			local Y =
				StartPosition.Y
				+ Delta.Y

			X,
				Y =
				ClampPosition(

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
				or not ActiveInput
			then

				return

			end

			local Correct

			if ActiveInput.UserInputType ==
				Enum.UserInputType.Touch
			then

				Correct =
					Input ==
					ActiveInput

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

			ActiveInput =
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
-- MAIN DRAG
------------------------------------------------------------

MakeDraggable(
	DragArea,
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

Bind(
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
-- FLOATING FALLBACK
------------------------------------------------------------

local FloatingFallback =
	Instance.new(
		"TextLabel"
	)

FloatingFallback.Size =
	UDim2.fromScale(
		1,
		1
	)

FloatingFallback.BackgroundTransparency =
	1

FloatingFallback.Text =
	"S"

FloatingFallback.TextSize =
	27

FloatingFallback.FontFace =
	FONT_BOLD

FloatingFallback.Active =
	false

FloatingFallback.ZIndex =
	499

FloatingFallback.Parent =
	Floating

Bind(
	FloatingFallback,
	"TextColor3",
	"Accent"
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

	-- NÃO altera posição da bolinha
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

Close.MouseButton1Click:Connect(
	MinimizeUI
)

------------------------------------------------------------
-- TAP = OPEN
-- DRAG = MOVE
------------------------------------------------------------

MakeDraggable(

	Floating,

	Floating,

	RestoreUI

)

------------------------------------------------------------
-- RESPAWN
------------------------------------------------------------

Player.CharacterRemoving:Connect(
	function()

		RemoveElevator()

	end
)

------------------------------------------------------------
-- START
------------------------------------------------------------

ApplyTheme(
	CurrentTheme
)

SwitchPage(
	"Principal"
)

UpdateElevatorUI()
