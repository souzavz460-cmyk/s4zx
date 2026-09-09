--[[
================================================================
                    SOUZA ADMIN V12
              MOBILE FIRST • ÚNICO LOCALSCRIPT
================================================================

COLOQUE EM:

StarterPlayer
    > StarterPlayerScripts
        > LocalScript

---------------------------------------------------------------
PRINCIPAL
---------------------------------------------------------------
• Elevador estável
• TP FROM
• DESCNY
• AntiLag

---------------------------------------------------------------
VISUAIS
---------------------------------------------------------------
• XRay Outline
• ESP Line
• ESP Box
• Chams
• Nome
• Distância
• Vida
• Tool
• Visibility Check
• Team Check

---------------------------------------------------------------
DIVERSOS
---------------------------------------------------------------
• Remover Elevador
• Desligar Visuais

---------------------------------------------------------------
AJUSTES
---------------------------------------------------------------
• Tema
• Max Distance ESP
• Distância XRay
• Tamanho da interface

---------------------------------------------------------------
TEMAS
---------------------------------------------------------------
• Ember
• Violet
• Ocean
• Crimson
• Mono

---------------------------------------------------------------
IMPORTANTE
---------------------------------------------------------------

ELEVADOR:
- NÃO muda Root.CFrame
- NÃO usa Character:PivotTo
- NÃO zera velocidade
- NÃO teleporta o personagem
- Só a plataforma se move
- Descida tem limite de velocidade
- Se o player ficar muito longe acima da plataforma,
  a descida pausa para evitar queda brusca

XRAY:
- NÃO muda Transparency
- NÃO muda LocalTransparencyModifier
- NÃO muda CanCollide
- NÃO muda Material
- NÃO muda Parent das Parts
- Apenas cria Highlight local na CurrentCamera

ESP:
- API oficial do Roblox
- ScreenGui + Frame + TextLabel
- RenderStepped
- objetos reutilizados
- PlayerRemoving limpa tudo
- Visibility Check com Raycast

================================================================
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

workspace:GetPropertyChangedSignal(
	"CurrentCamera"
):Connect(
	function()

		if workspace.CurrentCamera then

			Camera =
				workspace.CurrentCamera

		end

	end
)

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

	StepHeight = 2.10,

	MaxLevel = 25,

	UpSpeed = 4.2,

	DownSpeed = 2.25,

	-- se durante a descida o bloco ficar mais que isso
	-- abaixo dos pés, ele espera o player.
	MaximumDownGap = 3.15,

	-- só considera isso uma mudança externa grande.
	RecoveryDistance = 45,

	--------------------------------------------------------
	-- TP FROM
	--------------------------------------------------------

	TPDistance = 30,

	TPSearchAfterWall = 12,

	--------------------------------------------------------
	-- ESP
	--------------------------------------------------------

	ESPDistance = 450,

	VisibilityRefreshRate = 0.12,

	--------------------------------------------------------
	-- XRAY
	--------------------------------------------------------

	XRayDistance = 180,

	XRayMaxObjects = 160,

	XRayRefreshRate = 1.0,

	XRayMinimumMagnitude = 7,
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
				24,
				37,
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
				118,
				49
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

local CurrentTheme =
	ThemeOrder[
		ThemeIndex
	]

------------------------------------------------------------

local function Theme()

	return THEMES[
		CurrentTheme
	]

end

------------------------------------------------------------
-- THEME BINDINGS
------------------------------------------------------------

local ThemeBindings = {}

local ThemeRefreshCallbacks = {}

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

	if Object
		and Theme()[Key] ~= nil
	then

		Object[
			Property
		] =
			Theme()[Key]

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

local function Tween(
	Object,
	Duration,
	Properties
)

	local Value =
		TweenService:Create(

			Object,

			TweenInfo.new(
				Duration,
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

	local Data =
		Theme()

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
				Data[
					Binding.Key
				]

			if typeof(Value) ==
				"Color3"
			then

				Tween(
					Object,
					0.18,
					{
						[
							Binding.Property
						] =
							Value
					}
				)

			elseif Value ~= nil then

				Object[
					Binding.Property
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

		pcall(
			Callback
		)
	end
end

------------------------------------------------------------
-- CLEAN OLD
------------------------------------------------------------

for _,
	Name
	in ipairs({

		"SouzaAdminV12",

		"SouzaVisualV12",

	})
do

	local Object =
		PlayerGui:FindFirstChild(
			Name
		)

	if Object then

		Object:Destroy()

	end
end

------------------------------------------------------------

local OldPlatform =
	workspace:FindFirstChild(
		"SouzaElevatorV12"
	)

if OldPlatform then

	OldPlatform:Destroy()

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
			0.12
		)

		SetupCharacter(
			Char
		)

	end
)

------------------------------------------------------------
-- ========================================================
-- ELEVATOR V12
-- ========================================================
------------------------------------------------------------

local Platform = nil

local ElevatorLevel = 0

local ElevatorBaseY = nil

local ElevatorCurrentY = nil

local ElevatorTargetY = nil

local LastElevatorRootPosition = nil

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
-- PLATFORM DESIGN
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

	BindTheme(
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

	local function Refresh()

		local T =
			Theme()

		Gradient.Color =
			ColorSequence.new({

				ColorSequenceKeypoint.new(
					0,
					T.Accent
				),

				ColorSequenceKeypoint.new(
					0.35,
					T.BG2
				),

				ColorSequenceKeypoint.new(
					1,
					T.BG
				),

			})
	end

	Refresh()

	RegisterThemeRefresh(
		Refresh
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
		0.72

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
			0.57,
			0.57
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
-- CREATE ELEVATOR
------------------------------------------------------------

local function CreateElevator()

	if Platform
		and Platform.Parent
	then

		return
	end

	if not Root then

		return
	end

	local Feet =
		GetFeetY()

	if not Feet then

		return
	end

	ElevatorLevel =
		1

	ElevatorBaseY =
		Feet
		- CONFIG.PlatformSize.Y / 2
		- 0.05

	ElevatorCurrentY =
		ElevatorBaseY

	ElevatorTargetY =
		ElevatorBaseY

	LastElevatorRootPosition =
		Root.Position

	--------------------------------------------------------

	Platform =
		Instance.new(
			"Part"
		)

	Platform.Name =
		"SouzaElevatorV12"

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

			ElevatorCurrentY,

			Root.Position.Z

		)

	Platform.Parent =
		workspace

	CreatePlatformDesign(
		Platform
	)
end

------------------------------------------------------------
-- REMOVE ELEVATOR
------------------------------------------------------------

local function RemoveElevator()

	ElevatorLevel =
		0

	ElevatorBaseY =
		nil

	ElevatorCurrentY =
		nil

	ElevatorTargetY =
		nil

	LastElevatorRootPosition =
		nil

	if Platform then

		Platform:Destroy()

		Platform =
			nil
	end
end

------------------------------------------------------------
-- ELEVATOR REBASE
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
	-- mantém nível lógico
	-- mas aceita a posição nova do personagem
	--------------------------------------------------------

	ElevatorCurrentY =
		Feet
		- Platform.Size.Y / 2
		- 0.05

	ElevatorBaseY =
		ElevatorCurrentY
		- Offset

	ElevatorTargetY =
		ElevatorCurrentY

	LastElevatorRootPosition =
		Root.Position
end

------------------------------------------------------------
-- CHANGE LEVEL
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

	if NewLevel ==
		ElevatorLevel
	then

		return false,
			"Limite"
	end

	--------------------------------------------------------
	-- IMPORTANTE:
	-- apertar várias vezes só troca o alvo.
	-- não multiplica velocidade.
	--------------------------------------------------------

	ElevatorLevel =
		NewLevel

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
		-- PLAYER FOI REALMENTE MOVIDO PRA LONGE
		----------------------------------------------------

		if LastElevatorRootPosition then

			local ExternalDifference =
				(
					Position
					- LastElevatorRootPosition
				).Magnitude

			if ExternalDifference >
				CONFIG.RecoveryDistance
			then

				RebaseElevator()

				return
			end
		end

		LastElevatorRootPosition =
			Position

		----------------------------------------------------
		-- Y TARGET
		----------------------------------------------------

		if ElevatorCurrentY
			and ElevatorTargetY
		then

			local Difference =
				ElevatorTargetY
				- ElevatorCurrentY

			if math.abs(
				Difference
			) > 0.001
			then

				local Speed

				------------------------------------------------
				-- SUBINDO
				------------------------------------------------

				if Difference > 0 then

					Speed =
						CONFIG.UpSpeed

				------------------------------------------------
				-- DESCENDO
				------------------------------------------------

				else

					Speed =
						CONFIG.DownSpeed

					------------------------------------------------
					-- ANTI QUEDA:
					-- se o player estiver muito acima do bloco,
					-- espera ele encostar/cair de volta.
					------------------------------------------------

					local PlatformTop =
						ElevatorCurrentY
						+ Platform.Size.Y / 2

					local Feet =
						GetFeetY()

					if Feet then

						local Gap =
							Feet
							- PlatformTop

						if Gap >
							CONFIG.MaximumDownGap
						then

							Speed =
								0
						end
					end
				end

				------------------------------------------------

				if Speed > 0 then

					local Step =
						Speed
						* DT

					if math.abs(
						Difference
					) <= Step
					then

						ElevatorCurrentY =
							ElevatorTargetY

					else

						ElevatorCurrentY +=

							math.sign(
								Difference
							)

							* Step
					end
				end
			end
		end

		----------------------------------------------------
		-- SOMENTE PLATFORM.CFRAME
		----------------------------------------------------

		Platform.CFrame =
			CFrame.new(

				Position.X,

				ElevatorCurrentY,

				Position.Z

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

	"ghost",

	"vanish",
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
			0.10
		)
	end

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
-- TP FROM V12
-- ========================================================
------------------------------------------------------------

local TPBusy =
	false

------------------------------------------------------------
-- CHECK DESTINATION
------------------------------------------------------------

local function TPPositionClear(
	Position,
	Wall
)

	if not Character then

		return false
	end

	local _,
		Size =
		Character:GetBoundingBox()

	local CheckSize =
		Vector3.new(

			math.max(
				Size.X * 0.58,
				2
			),

			math.max(
				Size.Y * 0.68,
				3
			),

			math.max(
				Size.Z * 0.58,
				2
			)

		)

	local Params =
		OverlapParams.new()

	Params.FilterType =
		Enum.RaycastFilterType.Exclude

	local Ignore = {

		Character,

		Wall,
	}

	if Platform then

		table.insert(
			Ignore,
			Platform
		)
	end

	Params.FilterDescendantsInstances =
		Ignore

	--------------------------------------------------------

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
-- FAR FACE OF PART
------------------------------------------------------------

local function CalculateWallExit(
	Part,
	HitPosition,
	WorldDirection
)

	WorldDirection =
		WorldDirection.Unit

	local LocalOrigin =
		Part.CFrame:PointToObjectSpace(

			HitPosition

			+ WorldDirection
			* 0.04

		)

	local LocalDirection =
		Part.CFrame:VectorToObjectSpace(
			WorldDirection
		)

	local Half =
		Part.Size / 2

	--------------------------------------------------------
	-- ray-box slab intersection
	--------------------------------------------------------

	local Tmin =
		-math.huge

	local Tmax =
		math.huge

	local function Axis(
		O,
		D,
		H
	)

		if math.abs(D) <
			0.00001
		then

			if O < -H
				or O > H
			then

				return false
			end

			return true
		end

		local A =
			(
				-H - O
			)
			/ D

		local B =
			(
				H - O
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

		LocalOrigin.X,

		LocalDirection.X,

		Half.X

	) then

		return nil
	end

	if not Axis(

		LocalOrigin.Y,

		LocalDirection.Y,

		Half.Y

	) then

		return nil
	end

	if not Axis(

		LocalOrigin.Z,

		LocalDirection.Z,

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

	local LocalExit =
		LocalOrigin

		+ LocalDirection

		* (
			Tmax
			+ 0.04
		)

	return Part.CFrame:PointToWorldSpace(
		LocalExit
	)
end

------------------------------------------------------------
-- TP FROM
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
	-- HORIZONTAL CAMERA DIRECTION
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

	if Direction.Magnitude <
		0.01
	then

		TPBusy =
			false

		return false,
			"Direção inválida"
	end

	Direction =
		Direction.Unit

	--------------------------------------------------------
	-- RAYCAST
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

	local Origin =
		Root.Position
		+ Vector3.new(
			0,
			0.4,
			0
		)

	local Result =
		workspace:Raycast(

			Origin,

			Direction
			* CONFIG.TPDistance,

			Params
		)

	if not Result then

		TPBusy =
			false

		return false,
			"Sem parede na frente"
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
	-- NÃO ACEITA CHÃO / TETO
	--------------------------------------------------------

	if math.abs(
		Result.Normal.Y
	) > 0.72
	then

		TPBusy =
			false

		return false,
			"Aponte para uma parede"
	end

	--------------------------------------------------------
	-- OUTRO LADO
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
			"Não achei o outro lado"
	end

	--------------------------------------------------------
	-- SEARCH FREE POSITION
	--------------------------------------------------------

	local Destination =
		nil

	for Distance =
		2.5,
		CONFIG.TPSearchAfterWall,
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

	if not Destination then

		TPBusy =
			false

		return false,
			"Sem espaço livre do outro lado"
	end

	--------------------------------------------------------
	-- ONE TELEPORT
	--
	-- não fica brigando repetidamente com servidor.
	--------------------------------------------------------

	Character:PivotTo(

		CFrame.lookAt(

			Destination,

			Destination
			+ Direction

		)

	)

	--------------------------------------------------------
	-- platform follows destination
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

local AntiLagCache =
	{}

local AntiLagGeneration =
	0

------------------------------------------------------------
-- CACHE PROPERTY
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
		] =
			{}
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

local function AntiSet(
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
-- RESTORE
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
-- OPTIMIZE OBJECT
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

			AntiSet(
				Object,
				"Enabled",
				false
			)
		end
	end

	--------------------------------------------------------
	-- MEDIO
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

			AntiSet(
				Object,
				"Enabled",
				false
			)
		end
	end

	--------------------------------------------------------
	-- MAX
	--------------------------------------------------------

	if Level >= 3
		and Object:IsA(
			"BasePart"
		)
	then

		AntiSet(
			Object,
			"CastShadow",
			false
		)
	end
end

------------------------------------------------------------
-- SET ANTILAG
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

	AntiLagGeneration +=
		1

	local Generation =
		AntiLagGeneration

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
-- ========================================================
-- VISUAL ENGINE
-- ========================================================
------------------------------------------------------------

local VISUAL = {

	Box = false,

	Line = false,

	Chams = false,

	Name = false,

	Distance = false,

	Health = false,

	Tool = false,

	VisibilityCheck = true,

	TeamCheck = false,

	XRay = false,
}

------------------------------------------------------------
-- VISUAL GUI
------------------------------------------------------------

local VisualGui =
	Instance.new(
		"ScreenGui"
	)

VisualGui.Name =
	"SouzaVisualV12"

VisualGui.ResetOnSpawn =
	false

VisualGui.IgnoreGuiInset =
	true

VisualGui.DisplayOrder =
	998

VisualGui.ZIndexBehavior =
	Enum.ZIndexBehavior.Sibling

VisualGui.Parent =
	PlayerGui

------------------------------------------------------------
-- ESP CACHE
------------------------------------------------------------

local ESPCache = {}

local VisibilityCache = {}

------------------------------------------------------------
-- NEW FRAME
------------------------------------------------------------

local function NewVisualFrame()

	local Object =
		Instance.new(
			"Frame"
		)

	Object.BorderSizePixel =
		0

	Object.BackgroundColor3 =
		Color3.new(
			1,
			1,
			1
		)

	Object.Visible =
		false

	Object.ZIndex =
		70

	Object.Parent =
		VisualGui

	return Object
end

------------------------------------------------------------
-- NEW TEXT
------------------------------------------------------------

local function NewVisualText()

	local Object =
		Instance.new(
			"TextLabel"
		)

	Object.BackgroundTransparency =
		1

	Object.BorderSizePixel =
		0

	Object.TextColor3 =
		Color3.new(
			1,
			1,
			1
		)

	Object.TextStrokeColor3 =
		Color3.new(
			0,
			0,
			0
		)

	Object.TextStrokeTransparency =
		0.25

	Object.TextSize =
		11

	Object.FontFace =
		FONT_MEDIUM

	Object.Visible =
		false

	Object.ZIndex =
		73

	Object.Parent =
		VisualGui

	return Object
end

------------------------------------------------------------
-- CREATE ESP
------------------------------------------------------------

local function CreateESPData(
	Target
)

	if ESPCache[
		Target
	] then

		return ESPCache[
			Target
		]
	end

	local Data = {}

	--------------------------------------------------------
	-- BOX
	--------------------------------------------------------

	Data.Top =
		NewVisualFrame()

	Data.Bottom =
		NewVisualFrame()

	Data.Left =
		NewVisualFrame()

	Data.Right =
		NewVisualFrame()

	--------------------------------------------------------
	-- LINE
	--------------------------------------------------------

	Data.Line =
		NewVisualFrame()

	Data.Line.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	--------------------------------------------------------
	-- HEALTH
	--------------------------------------------------------

	Data.HealthBG =
		NewVisualFrame()

	Data.HealthBG.BackgroundColor3 =
		Color3.fromRGB(
			20,
			20,
			20
		)

	Data.Health =
		NewVisualFrame()

	--------------------------------------------------------
	-- TEXT
	--------------------------------------------------------

	Data.Name =
		NewVisualText()

	Data.Name.TextXAlignment =
		Enum.TextXAlignment.Center

	Data.Distance =
		NewVisualText()

	Data.Distance.TextXAlignment =
		Enum.TextXAlignment.Center

	Data.Tool =
		NewVisualText()

	Data.Tool.TextXAlignment =
		Enum.TextXAlignment.Center

	--------------------------------------------------------
	-- CHAMS
	--------------------------------------------------------

	Data.Chams =
		Instance.new(
			"Highlight"
		)

	Data.Chams.Name =
		"SouzaPlayerChams"

	Data.Chams.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	Data.Chams.FillTransparency =
		0.73

	Data.Chams.OutlineTransparency =
		0.06

	Data.Chams.Enabled =
		false

	Data.Chams.Parent =
		Camera

	--------------------------------------------------------

	ESPCache[
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

	Data.Top.Visible =
		false

	Data.Bottom.Visible =
		false

	Data.Left.Visible =
		false

	Data.Right.Visible =
		false

	Data.Line.Visible =
		false

	Data.HealthBG.Visible =
		false

	Data.Health.Visible =
		false

	Data.Name.Visible =
		false

	Data.Distance.Visible =
		false

	Data.Tool.Visible =
		false

	Data.Chams.Enabled =
		false
end

------------------------------------------------------------
-- REMOVE ESP
------------------------------------------------------------

local function RemoveESP(
	Target
)

	local Data =
		ESPCache[
			Target
		]

	if not Data then

		return
	end

	for _,
		Object
		in pairs(
			Data
		)
	do

		if typeof(Object) ==
			"Instance"
		then

			Object:Destroy()
		end
	end

	ESPCache[
		Target
	] =
		nil

	VisibilityCache[
		Target
	] =
		nil
end

------------------------------------------------------------
-- TEAM CHECK
------------------------------------------------------------

local function PassesTeamCheck(
	Target
)

	if not VISUAL.TeamCheck then

		return true
	end

	--------------------------------------------------------
	-- sem times configurados
	--------------------------------------------------------

	if Player.Team == nil
		or Target.Team == nil
	then

		return true
	end

	return Target.Team ~=
		Player.Team
end

------------------------------------------------------------
-- TOOL
------------------------------------------------------------

local function GetEquippedToolName(
	Char
)

	if not Char then

		return ""
	end

	local Tool =
		Char:FindFirstChildOfClass(
			"Tool"
		)

	if Tool then

		return Tool.Name
	end

	return ""
end

------------------------------------------------------------
-- CALCULATE BOX
------------------------------------------------------------

local function CalculateBox(
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

		return nil
	end

	local Half =
		Size / 2

	local Corners = {

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

	local Found =
		false

	--------------------------------------------------------

	for _,
		Point
		in ipairs(
			Corners
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

			Found =
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

	if not Found then

		return nil
	end

	local Width =
		MaxX - MinX

	local Height =
		MaxY - MinY

	if Width < 2
		or Height < 3
	then

		return nil
	end

	return {

		X = MinX,

		Y = MinY,

		Width = Width,

		Height = Height,

		CenterX =
			MinX
			+ Width / 2,

		CenterY =
			MinY
			+ Height / 2,

		BottomY =
			MaxY,
	}
end

------------------------------------------------------------
-- VISIBILITY
------------------------------------------------------------

local function CalculateVisibility(
	Target,
	TargetChar,
	TargetRoot
)

	if not VISUAL.VisibilityCheck then

		return true
	end

	local Now =
		os.clock()

	local Cached =
		VisibilityCache[
			Target
		]

	if Cached
		and Now
			- Cached.Time
			< CONFIG.VisibilityRefreshRate
	then

		return Cached.Visible
	end

	local Params =
		RaycastParams.new()

	Params.FilterType =
		Enum.RaycastFilterType.Exclude

	Params.FilterDescendantsInstances = {

		Character
	}

	Params.IgnoreWater =
		true

	local Origin =
		Camera.CFrame.Position

	local Direction =
		TargetRoot.Position
		- Origin

	local Result =
		workspace:Raycast(

			Origin,

			Direction,

			Params

		)

	local Visible =
		false

	if not Result then

		Visible =
			true

	elseif Result.Instance
		and Result.Instance:IsDescendantOf(
			TargetChar
		)
	then

		Visible =
			true
	end

	VisibilityCache[
		Target
	] = {

		Time = Now,

		Visible = Visible
	}

	return Visible
end

------------------------------------------------------------
-- BOX DRAW
------------------------------------------------------------

local function DrawBox(
	Data,
	Box,
	Color
)

	local Thickness =
		1.5

	--------------------------------------------------------
	-- TOP
	--------------------------------------------------------

	Data.Top.Position =
		UDim2.fromOffset(

			Box.X,

			Box.Y

		)

	Data.Top.Size =
		UDim2.fromOffset(

			Box.Width,

			Thickness

		)

	Data.Top.BackgroundColor3 =
		Color

	--------------------------------------------------------
	-- BOTTOM
	--------------------------------------------------------

	Data.Bottom.Position =
		UDim2.fromOffset(

			Box.X,

			Box.Y
			+ Box.Height

		)

	Data.Bottom.Size =
		UDim2.fromOffset(

			Box.Width,

			Thickness

		)

	Data.Bottom.BackgroundColor3 =
		Color

	--------------------------------------------------------
	-- LEFT
	--------------------------------------------------------

	Data.Left.Position =
		UDim2.fromOffset(

			Box.X,

			Box.Y

		)

	Data.Left.Size =
		UDim2.fromOffset(

			Thickness,

			Box.Height

		)

	Data.Left.BackgroundColor3 =
		Color

	--------------------------------------------------------
	-- RIGHT
	--------------------------------------------------------

	Data.Right.Position =
		UDim2.fromOffset(

			Box.X
			+ Box.Width,

			Box.Y

		)

	Data.Right.Size =
		UDim2.fromOffset(

			Thickness,

			Box.Height

		)

	Data.Right.BackgroundColor3 =
		Color

	--------------------------------------------------------

	Data.Top.Visible =
		true

	Data.Bottom.Visible =
		true

	Data.Left.Visible =
		true

	Data.Right.Visible =
		true
end

------------------------------------------------------------
-- LINE DRAW
------------------------------------------------------------

local function DrawLine(
	Data,
	Box,
	Color
)

	local View =
		Camera.ViewportSize

	local From =
		Vector2.new(

			View.X / 2,

			View.Y - 8

		)

	local To =
		Vector2.new(

			Box.CenterX,

			Box.BottomY

		)

	local Delta =
		To - From

	local Center =
		From
		+ Delta / 2

	--------------------------------------------------------

	Data.Line.Position =
		UDim2.fromOffset(

			Center.X,

			Center.Y

		)

	Data.Line.Size =
		UDim2.fromOffset(

			Delta.Magnitude,

			1.35

		)

	Data.Line.Rotation =
		math.deg(

			math.atan2(

				Delta.Y,

				Delta.X

			)
		)

	Data.Line.BackgroundColor3 =
		Color

	Data.Line.Visible =
		true
end

------------------------------------------------------------
-- HEALTH DRAW
------------------------------------------------------------

local function DrawHealth(
	Data,
	Box,
	TargetHumanoid
)

	if not VISUAL.Health then

		Data.HealthBG.Visible =
			false

		Data.Health.Visible =
			false

		return
	end

	local Ratio =
		0

	if TargetHumanoid.MaxHealth >
		0
	then

		Ratio =
			math.clamp(

				TargetHumanoid.Health
				/ TargetHumanoid.MaxHealth,

				0,

				1

			)
	end

	--------------------------------------------------------
	-- BG
	--------------------------------------------------------

	Data.HealthBG.Position =
		UDim2.fromOffset(

			Box.X - 7,

			Box.Y

		)

	Data.HealthBG.Size =
		UDim2.fromOffset(

			4,

			Box.Height

		)

	Data.HealthBG.Visible =
		true

	--------------------------------------------------------

	local Height =
		Box.Height
		* Ratio

	Data.Health.Position =
		UDim2.fromOffset(

			Box.X - 7,

			Box.Y
			+ Box.Height
			- Height

		)

	Data.Health.Size =
		UDim2.fromOffset(

			4,

			Height

		)

	--------------------------------------------------------
	-- RED -> GREEN
	--------------------------------------------------------

	Data.Health.BackgroundColor3 =
		Color3.new(

			1 - Ratio,

			Ratio,

			0.15

		)

	Data.Health.Visible =
		true
end

------------------------------------------------------------
-- TEXT DATA
------------------------------------------------------------

local function DrawTexts(
	Data,
	Target,
	Box,
	Distance
)

	--------------------------------------------------------
	-- NAME
	--------------------------------------------------------

	if VISUAL.Name then

		Data.Name.Text =
			Target.DisplayName

		Data.Name.Position =
			UDim2.fromOffset(

				Box.CenterX - 90,

				Box.Y - 18

			)

		Data.Name.Size =
			UDim2.fromOffset(
				180,
				16
			)

		Data.Name.Visible =
			true

	else

		Data.Name.Visible =
			false
	end

	--------------------------------------------------------
	-- DISTANCE
	--------------------------------------------------------

	if VISUAL.Distance then

		Data.Distance.Text =
			math.floor(
				Distance
			)
			.. " studs"

		Data.Distance.Position =
			UDim2.fromOffset(

				Box.CenterX - 90,

				Box.BottomY + 2

			)

		Data.Distance.Size =
			UDim2.fromOffset(
				180,
				15
			)

		Data.Distance.Visible =
			true

	else

		Data.Distance.Visible =
			false
	end

	--------------------------------------------------------
	-- TOOL
	--------------------------------------------------------

	if VISUAL.Tool then

		local Tool =
			GetEquippedToolName(
				Target.Character
			)

		if Tool ~= "" then

			Data.Tool.Text =
				Tool

			Data.Tool.Position =
				UDim2.fromOffset(

					Box.CenterX - 90,

					Box.BottomY + 16

				)

			Data.Tool.Size =
				UDim2.fromOffset(
					180,
					15
				)

			Data.Tool.Visible =
				true

		else

			Data.Tool.Visible =
				false
		end

	else

		Data.Tool.Visible =
			false
	end
end

------------------------------------------------------------
-- ESP RENDER LOOP
------------------------------------------------------------

RunService.RenderStepped:Connect(
	function()

		local AnyESP =
			VISUAL.Box
			or VISUAL.Line
			or VISUAL.Chams
			or VISUAL.Name
			or VISUAL.Distance
			or VISUAL.Health
			or VISUAL.Tool

		if not AnyESP then

			for _,
				Data
				in pairs(
					ESPCache
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
				CreateESPData(
					Target
				)

			------------------------------------------------
			-- TEAM
			------------------------------------------------

			if not PassesTeamCheck(
				Target
			) then

				HideESP(
					Data
				)

				continue
			end

			------------------------------------------------
			-- CHARACTER
			------------------------------------------------

			local TargetChar =
				Target.Character

			if not TargetChar then

				HideESP(
					Data
				)

				continue
			end

			local TargetRoot =
				TargetChar:FindFirstChild(
					"HumanoidRootPart"
				)

			local TargetHumanoid =
				TargetChar:FindFirstChildOfClass(
					"Humanoid"
				)

			if not TargetRoot
				or not TargetHumanoid
				or TargetHumanoid.Health <= 0
				or not Root
			then

				HideESP(
					Data
				)

				continue
			end

			------------------------------------------------
			-- DISTANCE
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
			-- 2D BOX
			------------------------------------------------

			local Box =
				CalculateBox(
					TargetChar
				)

			if not Box then

				HideESP(
					Data
				)

				continue
			end

			------------------------------------------------
			-- VISIBILITY
			------------------------------------------------

			local Visible =
				CalculateVisibility(

					Target,

					TargetChar,

					TargetRoot

				)

			local Color

			if VISUAL.VisibilityCheck then

				if Visible then

					Color =
						Color3.fromRGB(
							67,
							226,
							137
						)

				else

					Color =
						Color3.fromRGB(
							241,
							70,
							91
						)
				end

			else

				Color =
					Theme().Accent
			end

			------------------------------------------------
			-- BOX
			------------------------------------------------

			if VISUAL.Box then

				DrawBox(
					Data,
					Box,
					Color
				)

			else

				Data.Top.Visible =
					false

				Data.Bottom.Visible =
					false

				Data.Left.Visible =
					false

				Data.Right.Visible =
					false
			end

			------------------------------------------------
			-- LINE
			------------------------------------------------

			if VISUAL.Line then

				DrawLine(
					Data,
					Box,
					Color
				)

			else

				Data.Line.Visible =
					false
			end

			------------------------------------------------
			-- HEALTH
			------------------------------------------------

			DrawHealth(

				Data,

				Box,

				TargetHumanoid

			)

			------------------------------------------------
			-- TEXT
			------------------------------------------------

			DrawTexts(

				Data,

				Target,

				Box,

				Distance

			)

			------------------------------------------------
			-- CHAMS
			------------------------------------------------

			if VISUAL.Chams then

				Data.Chams.Adornee =
					TargetChar

				Data.Chams.FillColor =
					Color

				Data.Chams.OutlineColor =
					Theme().Text

				Data.Chams.Enabled =
					true

			else

				Data.Chams.Enabled =
					false
			end
		end
	end
)

------------------------------------------------------------
-- MEMORY CLEANUP
------------------------------------------------------------

Players.PlayerRemoving:Connect(
	function(Target)

		RemoveESP(
			Target
		)

	end
)

------------------------------------------------------------
-- ========================================================
-- XRAY OUTLINE
-- ========================================================
------------------------------------------------------------

local XRayObjects = {}

local XRayAccumulator =
	0

------------------------------------------------------------
-- CLEAR XRAY
------------------------------------------------------------

local function ClearXRay()

	for _,
		Highlight
		in pairs(
			XRayObjects
		)
	do

		if Highlight then

			Highlight:Destroy()

		end
	end

	XRayObjects = {}
end

------------------------------------------------------------
-- XRAY CANDIDATE
------------------------------------------------------------

local function XRayCandidate(
	Object
)

	if not Object:IsA(
		"BasePart"
	) then

		return false
	end

	if not Object.Anchored then

		return false
	end

	if Object.Transparency >= 1 then

		return false
	end

	if Platform
		and Object ==
			Platform
	then

		return false
	end

	if Character
		and Object:IsDescendantOf(
			Character
		)
	then

		return false
	end

	for _,
		P
		in ipairs(
			Players:GetPlayers()
		)
	do

		local Char =
			P.Character

		if Char
			and Object:IsDescendantOf(
				Char
			)
		then

			return false
		end
	end

	if Object.Size.Magnitude <
		CONFIG.XRayMinimumMagnitude
	then

		return false
	end

	return true
end

------------------------------------------------------------
-- CREATE XRAY
------------------------------------------------------------

local function AddXRayObject(
	Part
)

	if XRayObjects[
		Part
	] then

		return
	end

	local Highlight =
		Instance.new(
			"Highlight"
		)

	Highlight.Name =
		"SouzaXRayOutline"

	Highlight.Adornee =
		Part

	Highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	Highlight.FillTransparency =
		1

	Highlight.OutlineTransparency =
		0.18

	Highlight.OutlineColor =
		Theme().Accent

	Highlight.Parent =
		Camera

	XRayObjects[
		Part
	] =
		Highlight
end

------------------------------------------------------------
-- REBUILD XRAY
------------------------------------------------------------

local function RefreshXRay()

	if not VISUAL.XRay
		or not Root
	then

		ClearXRay()

		return
	end

	--------------------------------------------------------
	-- limpa apenas os highlights nossos
	--------------------------------------------------------

	ClearXRay()

	local Candidates = {}

	--------------------------------------------------------

	local Objects =
		workspace:GetDescendants()

	for Index,
		Object
		in ipairs(
			Objects
		)
	do

		if XRayCandidate(
			Object
		) then

			local Distance =
				(
					Object.Position
					- Root.Position
				).Magnitude

			if Distance <=
				CONFIG.XRayDistance
			then

				table.insert(
					Candidates,
					{
						Part = Object,

						Distance = Distance
					}
				)
			end
		end

		if Index % 300 ==
			0
		then

			RunService.Heartbeat:Wait()
		end
	end

	--------------------------------------------------------
	-- MAIS PRÓXIMOS PRIMEIRO
	--------------------------------------------------------

	table.sort(
		Candidates,

		function(A, B)

			return A.Distance <
				B.Distance
		end
	)

	local Limit =
		math.min(

			#Candidates,

			CONFIG.XRayMaxObjects

		)

	for Index = 1,
		Limit
	do

		AddXRayObject(
			Candidates[Index].Part
		)
	end
end

------------------------------------------------------------
-- XRAY LOOP
------------------------------------------------------------

RunService.Heartbeat:Connect(
	function(DT)

		XRayAccumulator +=
			DT

		if XRayAccumulator <
			CONFIG.XRayRefreshRate
		then

			return
		end

		XRayAccumulator =
			0

		if VISUAL.XRay then

			task.spawn(
				RefreshXRay
			)
		end
	end
)

------------------------------------------------------------
-- THEME XRAY
------------------------------------------------------------

RegisterThemeRefresh(
	function()

		for _,
			Highlight
			in pairs(
				XRayObjects
			)
		do

			if Highlight
				and Highlight.Parent
			then

				Highlight.OutlineColor =
					Theme().Accent
			end
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
	"SouzaAdminV12"

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

BindTheme(
	Main,
	"BackgroundColor3",
	"BG"
)

Corner(
	Main,
	15
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

------------------------------------------------------------

local function RefreshMainGradient()

	local T =
		Theme()

	MainGradient.Color =
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
			),

		})
end

RefreshMainGradient()

RegisterThemeRefresh(
	RefreshMainGradient
)

------------------------------------------------------------
-- UI SCALE
------------------------------------------------------------

local UIScaler =
	Instance.new(
		"UIScale"
	)

UIScaler.Parent =
	Main

local ManualScale =
	1

------------------------------------------------------------

local function UpdateUIScale()

	local View =
		Camera.ViewportSize

	local Automatic =
		math.clamp(

			math.min(

				View.X / 760,

				View.Y / 470

			),

			0.60,

			1

		)

	UIScaler.Scale =
		Automatic
		* ManualScale
end

UpdateUIScale()

Camera:GetPropertyChangedSignal(
	"ViewportSize"
):Connect(
	UpdateUIScale
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
	40

TopAccent.Parent =
	Main

BindTheme(
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

BindTheme(
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
	0
)

------------------------------------------------------------
-- LOGO FALLBACK
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

BindTheme(
	LogoFallback,
	"TextColor3",
	"Accent"
)

------------------------------------------------------------
-- LOGO IMAGE
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

BindTheme(
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
		-154
	)

Navigation.BackgroundTransparency =
	1

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
-- HEADER DRAG
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

HeaderDrag.Parent =
	Header

------------------------------------------------------------

local SmallHeader =
	Instance.new(
		"TextLabel"
	)

SmallHeader.Position =
	UDim2.fromOffset(
		23,
		12
	)

SmallHeader.Size =
	UDim2.fromOffset(
		280,
		15
	)

SmallHeader.BackgroundTransparency =
	1

SmallHeader.Text =
	"PAINEL ADMIN LOCAL"

SmallHeader.TextSize =
	8

SmallHeader.FontFace =
	FONT_MEDIUM

SmallHeader.TextXAlignment =
	Enum.TextXAlignment.Left

SmallHeader.Parent =
	HeaderDrag

BindTheme(
	SmallHeader,
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
		300,
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

local Pages = {}

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
		0.08

	Page.Visible =
		false

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
		"Stroke",
		1,
		0.25
	)

	--------------------------------------------------------
	-- ACCENT
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

	BindTheme(
		Accent,
		"BackgroundColor3",
		"Accent"
	)

	Corner(
		Accent,
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
			-210,
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
			-210,
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

	Desc.TextTruncate =
		Enum.TextTruncate.AtEnd

	Desc.Parent =
		Card

	BindTheme(
		Desc,
		"TextColor3",
		"Sub"
	)

	return Card,
		TitleLabel,
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

	--------------------------------------------------------

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
		Fire
	)

		Enabled =
			State

		Refresh()

		if Fire ~= false
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

	Refresh()

	RegisterThemeRefresh(
		Refresh
	)

	return {

		Set = Set,

		Get = function()

			return Enabled
		end,
	}
end

------------------------------------------------------------
-- SLIDER
------------------------------------------------------------

local function CreateSlider(
	Card,
	Minimum,
	Maximum,
	Initial,
	Suffix,
	Callback
)

	local Value =
		Initial

	--------------------------------------------------------

	local Holder =
		Instance.new(
			"Frame"
		)

	Holder.AnchorPoint =
		Vector2.new(
			1,
			0.5
		)

	Holder.Position =
		UDim2.new(
			1,
			-14,
			0.5,
			0
		)

	Holder.Size =
		UDim2.fromOffset(
			145,
			44
		)

	Holder.BackgroundTransparency =
		1

	Holder.Parent =
		Card

	--------------------------------------------------------
	-- VALUE TEXT
	--------------------------------------------------------

	local ValueLabel =
		Instance.new(
			"TextLabel"
		)

	ValueLabel.Size =
		UDim2.new(
			1,
			0,
			0,
			18
		)

	ValueLabel.BackgroundTransparency =
		1

	ValueLabel.TextSize =
		9

	ValueLabel.FontFace =
		FONT_BOLD

	ValueLabel.TextXAlignment =
		Enum.TextXAlignment.Right

	ValueLabel.Parent =
		Holder

	BindTheme(
		ValueLabel,
		"TextColor3",
		"Text"
	)

	--------------------------------------------------------
	-- TRACK
	--------------------------------------------------------

	local Track =
		Instance.new(
			"TextButton"
		)

	Track.Position =
		UDim2.fromOffset(
			0,
			27
		)

	Track.Size =
		UDim2.new(
			1,
			0,
			0,
			7
		)

	Track.BorderSizePixel =
		0

	Track.Text =
		""

	Track.AutoButtonColor =
		false

	Track.Parent =
		Holder

	BindTheme(
		Track,
		"BackgroundColor3",
		"Control"
	)

	Corner(
		Track,
		4
	)

	--------------------------------------------------------
	-- FILL
	--------------------------------------------------------

	local Fill =
		Instance.new(
			"Frame"
		)

	Fill.Size =
		UDim2.fromScale(
			0,
			1
		)

	Fill.BorderSizePixel =
		0

	Fill.Parent =
		Track

	BindTheme(
		Fill,
		"BackgroundColor3",
		"Accent"
	)

	Corner(
		Fill,
		4
	)

	--------------------------------------------------------
	-- KNOB
	--------------------------------------------------------

	local Knob =
		Instance.new(
			"Frame"
		)

	Knob.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	Knob.Position =
		UDim2.fromScale(
			0,
			0.5
		)

	Knob.Size =
		UDim2.fromOffset(
			17,
			17
		)

	Knob.BorderSizePixel =
		0

	Knob.Parent =
		Track

	BindTheme(
		Knob,
		"BackgroundColor3",
		"Text"
	)

	Corner(
		Knob,
		9
	)

	--------------------------------------------------------

	local Dragging =
		false

	local ActiveTouch =
		nil

	--------------------------------------------------------

	local function SetValue(
		NewValue,
		Fire
	)

		Value =
			math.clamp(

				NewValue,

				Minimum,

				Maximum

			)

		local Alpha =
			(
				Value
				- Minimum
			)
			/
			(
				Maximum
				- Minimum
			)

		Fill.Size =
			UDim2.fromScale(
				Alpha,
				1
			)

		Knob.Position =
			UDim2.fromScale(
				Alpha,
				0.5
			)

		ValueLabel.Text =
			tostring(
				math.floor(
					Value
				)
			)
			.. (
				Suffix or ""
			)

		if Fire ~= false
			and Callback
		then

			Callback(
				Value
			)
		end
	end

	--------------------------------------------------------

	local function UpdateFromX(
		X
	)

		local Start =
			Track.AbsolutePosition.X

		local Width =
			Track.AbsoluteSize.X

		if Width <= 0 then

			return
		end

		local Alpha =
			math.clamp(

				(
					X - Start
				)
				/ Width,

				0,

				1

			)

		SetValue(

			Minimum
			+ (
				Maximum - Minimum
			)
			* Alpha,

			true

		)
	end

	--------------------------------------------------------

	Track.InputBegan:Connect(
		function(Input)

			if Input.UserInputType ==
				Enum.UserInputType.Touch
			then

				Dragging =
					true

				ActiveTouch =
					Input

				UpdateFromX(
					Input.Position.X
				)

				local Connection

				Connection =
					Input.Changed:Connect(
						function()

							if not Dragging then

								if Connection then
									Connection:Disconnect()
								end

								return
							end

							if Input.UserInputState ==
								Enum.UserInputState.End

								or

								Input.UserInputState ==
								Enum.UserInputState.Cancel
							then

								Dragging =
									false

								ActiveTouch =
									nil

								if Connection then
									Connection:Disconnect()
								end

								return
							end

							UpdateFromX(
								Input.Position.X
							)

						end
					)

			elseif Input.UserInputType ==
				Enum.UserInputType.MouseButton1
			then

				Dragging =
					true

				UpdateFromX(
					UIS:GetMouseLocation().X
				)
			end
		end
	)

	--------------------------------------------------------

	UIS.InputChanged:Connect(
		function(Input)

			if not Dragging
				or ActiveTouch
			then

				return
			end

			if Input.UserInputType ==
				Enum.UserInputType.MouseMovement
			then

				UpdateFromX(
					UIS:GetMouseLocation().X
				)
			end
		end
	)

	UIS.InputEnded:Connect(
		function(Input)

			if Input.UserInputType ==
				Enum.UserInputType.MouseButton1
			then

				Dragging =
					false
			end
		end
	)

	SetValue(
		Initial,
		false
	)

	return {

		Get = function()

			return Value
		end,

		Set = SetValue,
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
-- ELEVATOR CARD
------------------------------------------------------------

local ElevatorCard,
	_,
	ElevatorDescription =
	CreateCard(

		PrincipalPage,

		"Elevador Estável",

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
-- LEVEL BOX
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

BindTheme(
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

BindTheme(
	LevelText,
	"TextColor3",
	"BG"
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
-- UPDATE ELEVATOR UI
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

			- (ElevatorCurrentY or 0)

		)

	if Difference <= 0.05 then

		ElevatorDescription.Text =
			"Nível "
			.. ElevatorLevel
			.. " • estável"

	elseif ElevatorTargetY >
		ElevatorCurrentY
	then

		ElevatorDescription.Text =
			"Nível "
			.. ElevatorLevel
			.. " • subindo"

	else

		local Feet =
			GetFeetY()

		local Gap =
			0

		if Feet
			and Platform
		then

			Gap =
				Feet
				- (
					ElevatorCurrentY
					+ Platform.Size.Y / 2
				)
		end

		if Gap >
			CONFIG.MaximumDownGap
		then

			ElevatorDescription.Text =
				"Nível "
				.. ElevatorLevel
				.. " • aguardando você"

		else

			ElevatorDescription.Text =
				"Nível "
				.. ElevatorLevel
				.. " • descendo seguro"
		end
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
-- PERIODIC UI
------------------------------------------------------------

task.spawn(
	function()

		while GUI
			and GUI.Parent
		do

			task.wait(
				0.15
			)

			UpdateElevatorUI()
		end
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
					70,
					220,
					140
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
	_,
	DescnyDescription =
	CreateCard(

		PrincipalPage,

		"DESCNY",

		"Procura e ativa sua capa de invisibilidade"

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

		if Success then

			DescnyDescription.Text =
				"Usando "
				.. tostring(
					Message
				)

			DescnyButton.Text =
				"ATIVADO"

		else

			DescnyDescription.Text =
				tostring(
					Message
				)

			DescnyButton.Text =
				"NÃO ACHOU"
		end

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
	_,
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

local AntiLagNames = {

	[0] = "OFF",

	[1] = "LEVE",

	[2] = "MÉDIO",

	[3] = "MÁXIMO",
}

------------------------------------------------------------

AntiLagButton.MouseButton1Click:Connect(
	function()

		local Next =
			AntiLagLevel
			+ 1

		if Next > 3 then

			Next =
				0
		end

		SetAntiLag(
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
-- VISUALS UI
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

		"XRay Outline",

		"Contornos locais através das paredes"

	)

local XRayToggle =
	CreateToggle(
		XRayCard,

		function(State)

			VISUAL.XRay =
				State

			if State then

				XRayDescription.Text =
					"Ativado • sem modificar as Parts"

				task.spawn(
					RefreshXRay
				)

			else

				XRayDescription.Text =
					"Contornos locais através das paredes"

				ClearXRay()
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

		"Tracer da parte inferior da tela"

	)

local LineToggle =
	CreateToggle(
		LineCard,

		function(State)

			VISUAL.Line =
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

		"Bounding Box 2D do personagem"

	)

local BoxToggle =
	CreateToggle(
		BoxCard,

		function(State)

			VISUAL.Box =
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

		"Highlight local através de paredes"

	)

local ChamsToggle =
	CreateToggle(
		ChamsCard,

		function(State)

			VISUAL.Chams =
				State

		end
	)

------------------------------------------------------------
-- NAME
------------------------------------------------------------

local NameCard =
	CreateCard(

		VisualPage,

		"ESP Name",

		"Exibe o DisplayName"

	)

local NameToggle =
	CreateToggle(
		NameCard,

		function(State)

			VISUAL.Name =
				State

		end
	)

------------------------------------------------------------
-- DISTANCE
------------------------------------------------------------

local ESPDistanceCard =
	CreateCard(

		VisualPage,

		"ESP Distance",

		"Exibe distância em studs"

	)

local ESPDistanceToggle =
	CreateToggle(
		ESPDistanceCard,

		function(State)

			VISUAL.Distance =
				State

		end
	)

------------------------------------------------------------
-- HEALTH
------------------------------------------------------------

local HealthCard =
	CreateCard(

		VisualPage,

		"ESP Health",

		"Barra lateral dinâmica"

	)

local HealthToggle =
	CreateToggle(
		HealthCard,

		function(State)

			VISUAL.Health =
				State

		end
	)

------------------------------------------------------------
-- TOOL
------------------------------------------------------------

local ToolCard =
	CreateCard(

		VisualPage,

		"ESP Tool",

		"Mostra a Tool equipada"

	)

local ToolToggle =
	CreateToggle(
		ToolCard,

		function(State)

			VISUAL.Tool =
				State

		end
	)

------------------------------------------------------------
-- FILTER SECTION
------------------------------------------------------------

CreateSection(
	VisualPage,
	"Filtros"
)

------------------------------------------------------------
-- VISIBILITY
------------------------------------------------------------

local VisibilityCard =
	CreateCard(

		VisualPage,

		"Visibility Check",

		"Verde visível • vermelho atrás da parede"

	)

local VisibilityToggle =
	CreateToggle(
		VisibilityCard,

		function(State)

			VISUAL.VisibilityCheck =
				State

		end
	)

VisibilityToggle.Set(
	true,
	false
)

------------------------------------------------------------
-- TEAM CHECK
------------------------------------------------------------

local TeamCard =
	CreateCard(

		VisualPage,

		"Team Check",

		"Oculta jogadores do mesmo time"

	)

local TeamToggle =
	CreateToggle(
		TeamCard,

		function(State)

			VISUAL.TeamCheck =
				State

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
-- REMOVE ELEVATOR
------------------------------------------------------------

local RemoveCard =
	CreateCard(

		MiscPage,

		"Remover Elevador",

		"Apaga a plataforma"

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
-- DISABLE VISUALS
------------------------------------------------------------

local DisableVisualCard =
	CreateCard(

		MiscPage,

		"Desligar Visuais",

		"Desativa todos os recursos visuais"

	)

local DisableVisualButton =
	CreateButton(
		DisableVisualCard,
		"DESLIGAR",
		115
	)

DisableVisualButton.MouseButton1Click:Connect(
	function()

		VISUAL.Box =
			false

		VISUAL.Line =
			false

		VISUAL.Chams =
			false

		VISUAL.Name =
			false

		VISUAL.Distance =
			false

		VISUAL.Health =
			false

		VISUAL.Tool =
			false

		VISUAL.XRay =
			false

		BoxToggle.Set(
			false,
			false
		)

		LineToggle.Set(
			false,
			false
		)

		ChamsToggle.Set(
			false,
			false
		)

		NameToggle.Set(
			false,
			false
		)

		ESPDistanceToggle.Set(
			false,
			false
		)

		HealthToggle.Set(
			false,
			false
		)

		ToolToggle.Set(
			false,
			false
		)

		XRayToggle.Set(
			false,
			false
		)

		ClearXRay()

		for _,
			Data
			in pairs(
				ESPCache
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
-- MAX DISTANCE ESP
------------------------------------------------------------

local ESPMaxCard =
	CreateCard(

		SettingsPage,

		"Max Distance ESP",

		"Distância máxima de renderização"

	)

CreateSlider(

	ESPMaxCard,

	100,

	1000,

	CONFIG.ESPDistance,

	"",

	function(Value)

		CONFIG.ESPDistance =
			math.floor(
				Value
			)

	end

)

------------------------------------------------------------
-- XRAY DISTANCE
------------------------------------------------------------

local XRayDistanceCard =
	CreateCard(

		SettingsPage,

		"Distância XRay",

		"Quanto do mapa recebe outline"

	)

CreateSlider(

	XRayDistanceCard,

	50,

	350,

	CONFIG.XRayDistance,

	"",

	function(Value)

		CONFIG.XRayDistance =
			math.floor(
				Value
			)

	end

)

------------------------------------------------------------
-- INTERFACE SIZE
------------------------------------------------------------

local ScaleCard,
	_,
	ScaleDescription =
	CreateCard(

		SettingsPage,

		"Tamanho Interface",

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

	1.08,
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

		local Percentage =
			math.floor(

				ManualScale
				* 100

			)

		ScaleButton.Text =
			Percentage
			.. "%"

		ScaleDescription.Text =
			Percentage
			.. "%"

		UpdateUIScale()

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

		Text = "Principal",
	},

	Visuais = {

		Icon = "◉",

		Text = "Visuais",
	},

	Diversos = {

		Icon = "◇",

		Text = "Diversos",
	},

	Ajustes = {

		Icon = "⚙",

		Text = "Ajustes",
	},
}

local NavigationOrder = {

	"Principal",

	"Visuais",

	"Diversos",

	"Ajustes",
}

local NavButtons = {}

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
			Theme().Card

		Data.Icon.TextColor3 =
			Active
			and Theme().Accent
			or Theme().Sub

		Data.Label.TextColor3 =
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
-- CREATE NAV BUTTONS
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

	BindTheme(
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

	local Label =
		Instance.new(
			"TextLabel"
		)

	Label.Position =
		UDim2.fromOffset(
			48,
			0
		)

	Label.Size =
		UDim2.new(
			1,
			-50,
			1,
			0
		)

	Label.BackgroundTransparency =
		1

	Label.Text =
		Info.Text

	Label.TextSize =
		12

	Label.FontFace =
		FONT_MEDIUM

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.Parent =
		Button

	BindTheme(
		Label,
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

		Label = Label,
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
-- MOBILE DRAG SYSTEM
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
-- ROBUST TOUCH DRAG
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

	local CurrentInput =
		nil

	local StartPointer =
		nil

	local StartTarget =
		nil

	local MouseConnection =
		nil

	--------------------------------------------------------
	-- UPDATE
	--------------------------------------------------------

	local function Update(
		Pointer
	)

		if not Dragging
			or not StartPointer
			or not StartTarget
		then

			return
		end

		local Delta =
			Pointer
			- StartPointer

		if Delta.Magnitude >
			8
		then

			Moved =
				true
		end

		if not Moved then

			return
		end

		local X =
			StartTarget.X
			+ Delta.X

		local Y =
			StartTarget.Y
			+ Delta.Y

		X,
			Y =
				ClampPosition(

					Target,

					X,

					Y

				)

		Target.AnchorPoint =
			Vector2.new(
				0,
				0
			)

		Target.Position =
			UDim2.fromOffset(
				X,
				Y
			)
	end

	--------------------------------------------------------
	-- FINISH
	--------------------------------------------------------

	local function Finish()

		if not Dragging then

			return
		end

		Dragging =
			false

		CurrentInput =
			nil

		if MouseConnection then

			MouseConnection:Disconnect()

			MouseConnection =
				nil
		end

		if not Moved
			and TapCallback
		then

			TapCallback()
		end
	end

	--------------------------------------------------------
	-- BEGIN
	--------------------------------------------------------

	Handle.InputBegan:Connect(
		function(Input)

			if Dragging then

				return
			end

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

			CurrentInput =
				Input

			StartPointer =
				Input.Position

			local Absolute =
				Target.AbsolutePosition

			StartTarget =
				Vector2.new(

					Absolute.X,

					Absolute.Y

				)

			------------------------------------------------
			-- TOUCH:
			-- escuta o próprio InputObject.
			------------------------------------------------

			if Input.UserInputType ==
				Enum.UserInputType.Touch
			then

				local TouchConnection

				TouchConnection =
					Input.Changed:Connect(
						function()

							if not Dragging
								or CurrentInput ~= Input
							then

								if TouchConnection then

									TouchConnection:Disconnect()

								end

								return
							end

							if Input.UserInputState ==
								Enum.UserInputState.End

								or

								Input.UserInputState ==
								Enum.UserInputState.Cancel
							then

								if TouchConnection then

									TouchConnection:Disconnect()

								end

								Finish()

								return
							end

							Update(
								Input.Position
							)
						end
					)

			------------------------------------------------
			-- MOUSE
			------------------------------------------------

			else

				MouseConnection =
					UIS.InputChanged:Connect(
						function(Movement)

							if not Dragging then

								return
							end

							if Movement.UserInputType ==
								Enum.UserInputType.MouseMovement
							then

								Update(
									UIS:GetMouseLocation()
								)
							end
						end
					)
			end
		end
	)

	--------------------------------------------------------
	-- MOUSE END
	--------------------------------------------------------

	UIS.InputEnded:Connect(
		function(Input)

			if not Dragging
				or not CurrentInput
			then

				return
			end

			if CurrentInput.UserInputType ==
				Enum.UserInputType.MouseButton1

				and

				Input.UserInputType ==
				Enum.UserInputType.MouseButton1
			then

				Finish()
			end
		end
	)
end

------------------------------------------------------------
-- MAIN DRAG
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
		"TextButton"
	)

Floating.Name =
	"FloatingButton"

Floating.AnchorPoint =
	Vector2.new(
		0,
		0
	)

Floating.Position =
	UDim2.new(
		1,
		-82,
		0.40,
		0
	)

Floating.Size =
	UDim2.fromOffset(
		62,
		62
	)

Floating.BorderSizePixel =
	0

Floating.Text =
	""

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
-- FALLBACK
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
	501

FloatingFallback.Parent =
	Floating

BindTheme(
	FloatingFallback,
	"TextColor3",
	"Accent"
)

------------------------------------------------------------
-- FLOATING LOGO
------------------------------------------------------------

local FloatingLogo =
	Instance.new(
		"ImageLabel"
	)

FloatingLogo.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

FloatingLogo.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

FloatingLogo.Size =
	UDim2.fromOffset(
		52,
		52
	)

FloatingLogo.BackgroundTransparency =
	1

FloatingLogo.Image =
	CONFIG.Logo

FloatingLogo.ScaleType =
	Enum.ScaleType.Fit

FloatingLogo.Active =
	false

FloatingLogo.ZIndex =
	502

FloatingLogo.Parent =
	Floating

------------------------------------------------------------
-- MINIMIZE
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

Close.MouseButton1Click:Connect(
	MinimizeUI
)

------------------------------------------------------------
-- TAP = OPEN / DRAG = MOVE
------------------------------------------------------------

MakeDraggable(

	Floating,

	Floating,

	RestoreUI

)

------------------------------------------------------------
-- ========================================================
-- RESPAWN
-- ========================================================
------------------------------------------------------------

Player.CharacterRemoving:Connect(
	function()

		RemoveElevator()

	end
)

------------------------------------------------------------
-- CAMERA CHANGED
-- reparent local highlights
------------------------------------------------------------

workspace:GetPropertyChangedSignal(
	"CurrentCamera"
):Connect(
	function()

		if not workspace.CurrentCamera then

			return
		end

		Camera =
			workspace.CurrentCamera

		for _,
			Data
			in pairs(
				ESPCache
			)
		do

			if Data.Chams then

				Data.Chams.Parent =
					Camera
			end
		end

		for _,
			Highlight
			in pairs(
				XRayObjects
			)
		do

			if Highlight then

				Highlight.Parent =
					Camera
			end
		end
	end
)

------------------------------------------------------------
-- INITIAL THEME
------------------------------------------------------------

ApplyTheme(
	CurrentTheme
)

------------------------------------------------------------
-- INITIAL PAGE
------------------------------------------------------------

SwitchPage(
	"Principal"
)

UpdateElevatorUI()
