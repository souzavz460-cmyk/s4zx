--[[
===============================================================
                    SOUZA ADMIN V13
                 ÚNICO LOCALSCRIPT
===============================================================

StarterPlayer
    > StarterPlayerScripts
        > LocalScript

PRINCIPAL
    • Elevador
    • Infinity Jump
    • TP FROM
    • Instant Steal
    • DESCNY
    • AntiLag

VISUAIS
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

DIVERSOS
    • Remover Elevador
    • Desligar Visuais

AJUSTES
    • Tema
    • Distância ESP
    • Distância XRay
    • Tamanho Interface

TEMAS
    • Ember
    • Violet
    • Ocean
    • Crimson
    • Mono
===============================================================
]]

------------------------------------------------------------
-- SERVICES
------------------------------------------------------------

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

------------------------------------------------------------
-- PLAYER / CAMERA
------------------------------------------------------------

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Camera = workspace.CurrentCamera

while not Camera do
	task.wait()
	Camera = workspace.CurrentCamera
end

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	if workspace.CurrentCamera then
		Camera = workspace.CurrentCamera
	end
end)

------------------------------------------------------------
-- CONFIG
------------------------------------------------------------

local CONFIG = {

	Logo = "rbxthumb://type=Asset&id=98880379063768&w=420&h=420",

	Width = 700,
	Height = 430,
	SidebarWidth = 154,

	--------------------------------------------------------
	-- ELEVATOR
	--------------------------------------------------------

	PlatformSize = Vector3.new(6.5, 0.65, 6.5),

	StepHeight = 2.10,
	MaxLevel = 25,

	UpSpeed = 4.0,
	DownSpeed = 2.0,

	-- não aceita outro +/- enquanto ainda está
	-- terminando um nível
	ElevatorArrivalTolerance = 0.04,

	-- evita continuar descendo se o player
	-- perdeu contato com a plataforma
	MaximumDownGap = 2.7,

	RecoveryDistance = 45,

	--------------------------------------------------------
	-- TP
	--------------------------------------------------------

	TPDistance = 30,
	TPSearchAfterWall = 12,

	--------------------------------------------------------
	-- INSTANT STEAL
	--------------------------------------------------------

	StealMaxDistance = 18,

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
	XRayRefreshRate = 1,
	XRayMinimumMagnitude = 7,
}

------------------------------------------------------------
-- FONT
------------------------------------------------------------

local FONT_REGULAR = Font.new(
	"rbxasset://fonts/families/GothamSSm.json",
	Enum.FontWeight.Regular,
	Enum.FontStyle.Normal
)

local FONT_MEDIUM = Font.new(
	"rbxasset://fonts/families/GothamSSm.json",
	Enum.FontWeight.Medium,
	Enum.FontStyle.Normal
)

local FONT_BOLD = Font.new(
	"rbxasset://fonts/families/GothamSSm.json",
	Enum.FontWeight.Bold,
	Enum.FontStyle.Normal
)

------------------------------------------------------------
-- THEMES
------------------------------------------------------------

local THEMES = {

	Ember = {

		BG = Color3.fromRGB(5, 9, 15),
		BG2 = Color3.fromRGB(9, 15, 24),
		Sidebar = Color3.fromRGB(3, 7, 12),

		Card = Color3.fromRGB(17, 27, 40),
		Control = Color3.fromRGB(7, 15, 25),
		Stroke = Color3.fromRGB(35, 48, 63),

		Text = Color3.fromRGB(246, 248, 251),
		Sub = Color3.fromRGB(157, 170, 186),
		Muted = Color3.fromRGB(89, 105, 125),

		Accent = Color3.fromRGB(255, 76, 22),
		Accent2 = Color3.fromRGB(255, 118, 49),
	},

	Violet = {

		BG = Color3.fromRGB(7, 6, 15),
		BG2 = Color3.fromRGB(14, 11, 28),
		Sidebar = Color3.fromRGB(5, 4, 12),

		Card = Color3.fromRGB(23, 19, 39),
		Control = Color3.fromRGB(12, 9, 25),
		Stroke = Color3.fromRGB(54, 44, 78),

		Text = Color3.fromRGB(249, 247, 255),
		Sub = Color3.fromRGB(176, 163, 201),
		Muted = Color3.fromRGB(109, 95, 142),

		Accent = Color3.fromRGB(139, 87, 255),
		Accent2 = Color3.fromRGB(177, 131, 255),
	},

	Ocean = {

		BG = Color3.fromRGB(3, 10, 16),
		BG2 = Color3.fromRGB(7, 20, 30),
		Sidebar = Color3.fromRGB(2, 8, 13),

		Card = Color3.fromRGB(12, 29, 41),
		Control = Color3.fromRGB(5, 17, 26),
		Stroke = Color3.fromRGB(29, 59, 76),

		Text = Color3.fromRGB(244, 250, 255),
		Sub = Color3.fromRGB(147, 183, 201),
		Muted = Color3.fromRGB(79, 124, 146),

		Accent = Color3.fromRGB(35, 166, 255),
		Accent2 = Color3.fromRGB(82, 196, 255),
	},

	Crimson = {

		BG = Color3.fromRGB(13, 4, 7),
		BG2 = Color3.fromRGB(25, 7, 11),
		Sidebar = Color3.fromRGB(9, 3, 5),

		Card = Color3.fromRGB(37, 14, 20),
		Control = Color3.fromRGB(22, 7, 11),
		Stroke = Color3.fromRGB(73, 29, 41),

		Text = Color3.fromRGB(255, 245, 248),
		Sub = Color3.fromRGB(205, 154, 167),
		Muted = Color3.fromRGB(143, 84, 100),

		Accent = Color3.fromRGB(239, 48, 82),
		Accent2 = Color3.fromRGB(255, 88, 116),
	},

	Mono = {

		BG = Color3.fromRGB(7, 7, 9),
		BG2 = Color3.fromRGB(14, 14, 18),
		Sidebar = Color3.fromRGB(4, 4, 6),

		Card = Color3.fromRGB(22, 22, 27),
		Control = Color3.fromRGB(12, 12, 16),
		Stroke = Color3.fromRGB(54, 54, 65),

		Text = Color3.fromRGB(250, 250, 252),
		Sub = Color3.fromRGB(174, 174, 184),
		Muted = Color3.fromRGB(108, 108, 122),

		Accent = Color3.fromRGB(225, 225, 233),
		Accent2 = Color3.fromRGB(255, 255, 255),
	},
}

local ThemeOrder = {
	"Ember",
	"Violet",
	"Ocean",
	"Crimson",
	"Mono"
}

local ThemeIndex = 1
local CurrentTheme = ThemeOrder[ThemeIndex]

local function Theme()
	return THEMES[CurrentTheme]
end

------------------------------------------------------------
-- THEME SYSTEM
------------------------------------------------------------

local ThemeBindings = {}
local ThemeCallbacks = {}

local function BindTheme(object, property, key)

	table.insert(ThemeBindings, {
		Object = object,
		Property = property,
		Key = key
	})

	if object and Theme()[key] ~= nil then
		object[property] = Theme()[key]
	end
end

local function RegisterThemeRefresh(callback)
	table.insert(ThemeCallbacks, callback)
end

------------------------------------------------------------
-- HELPERS
------------------------------------------------------------

local function Corner(object, radius)

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = object

	return corner
end

local function Stroke(object, key, thickness, transparency)

	local stroke = Instance.new("UIStroke")

	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0

	stroke.Parent = object

	BindTheme(
		stroke,
		"Color",
		key or "Stroke"
	)

	return stroke
end

local function Tween(object, duration, properties)

	local tween = TweenService:Create(
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

local function ApplyTheme(name)

	if not THEMES[name] then
		return
	end

	CurrentTheme = name

	for _, binding in ipairs(ThemeBindings) do

		local object = binding.Object

		if object and object.Parent then

			local value =
				Theme()[binding.Key]

			if typeof(value) == "Color3" then

				Tween(
					object,
					0.18,
					{
						[binding.Property] = value
					}
				)

			elseif value ~= nil then

				object[binding.Property] =
					value
			end
		end
	end

	for _, callback in ipairs(ThemeCallbacks) do
		pcall(callback)
	end
end

------------------------------------------------------------
-- CLEAN OLD
------------------------------------------------------------

for _, name in ipairs({
	"SouzaAdminV13",
	"SouzaVisualV13"
}) do

	local old =
		PlayerGui:FindFirstChild(name)

	if old then
		old:Destroy()
	end
end

local oldPlatform =
	workspace:FindFirstChild(
		"SouzaElevatorV13"
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
		char:WaitForChild("Humanoid")

	Root =
		char:WaitForChild("HumanoidRootPart")
end

if Player.Character then
	task.spawn(
		SetupCharacter,
		Player.Character
	)
end

Player.CharacterAdded:Connect(function(char)

	task.wait(0.12)

	SetupCharacter(char)
end)

------------------------------------------------------------
-- ========================================================
-- INFINITY JUMP
-- ========================================================
------------------------------------------------------------

local InfinityJumpEnabled = false

UIS.JumpRequest:Connect(function()

	if not InfinityJumpEnabled then
		return
	end

	if not Humanoid
		or not Humanoid.Parent
		or Humanoid.Health <= 0
	then
		return
	end

	Humanoid:ChangeState(
		Enum.HumanoidStateType.Jumping
	)
end)

------------------------------------------------------------
-- ========================================================
-- ELEVATOR V13
-- ========================================================
------------------------------------------------------------

local Platform = nil

local ElevatorLevel = 0

local ElevatorBaseY = nil

local ElevatorCurrentY = nil

local ElevatorTargetY = nil

local ElevatorMoving = false

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

local function CreatePlatformDesign(part)

	local surface =
		Instance.new("SurfaceGui")

	surface.Face =
		Enum.NormalId.Top

	surface.SizingMode =
		Enum.SurfaceGuiSizingMode.PixelsPerStud

	surface.PixelsPerStud = 45
	surface.LightInfluence = 0
	surface.Parent = part

	--------------------------------------------------------

	local background =
		Instance.new("Frame")

	background.Size =
		UDim2.fromScale(1, 1)

	background.BorderSizePixel = 0

	background.Parent =
		surface

	BindTheme(
		background,
		"BackgroundColor3",
		"BG2"
	)

	--------------------------------------------------------

	local gradient =
		Instance.new("UIGradient")

	gradient.Rotation = 35
	gradient.Parent = background

	local function refreshGradient()

		local t = Theme()

		gradient.Color =
			ColorSequence.new({

				ColorSequenceKeypoint.new(
					0,
					t.Accent
				),

				ColorSequenceKeypoint.new(
					0.35,
					t.BG2
				),

				ColorSequenceKeypoint.new(
					1,
					t.BG
				)
			})
	end

	refreshGradient()

	RegisterThemeRefresh(
		refreshGradient
	)

	Stroke(
		background,
		"Accent",
		3,
		0.05
	)

	--------------------------------------------------------

	local fallback =
		Instance.new("TextLabel")

	fallback.Size =
		UDim2.fromScale(1, 1)

	fallback.BackgroundTransparency = 1

	fallback.Text = "S"

	fallback.TextScaled = true

	fallback.TextTransparency = 0.72

	fallback.FontFace =
		FONT_BOLD

	fallback.Parent =
		background

	BindTheme(
		fallback,
		"TextColor3",
		"Accent"
	)

	--------------------------------------------------------

	local logo =
		Instance.new("ImageLabel")

	logo.AnchorPoint =
		Vector2.new(0.5, 0.5)

	logo.Position =
		UDim2.fromScale(0.5, 0.5)

	logo.Size =
		UDim2.fromScale(0.57, 0.57)

	logo.BackgroundTransparency = 1

	logo.Image = CONFIG.Logo

	logo.ScaleType =
		Enum.ScaleType.Fit

	logo.Parent =
		background
end

------------------------------------------------------------
-- CREATE ELEVATOR
------------------------------------------------------------

local function CreateElevator()

	if Platform and Platform.Parent then
		return
	end

	if not Root then
		return
	end

	local feet =
		GetFeetY()

	if not feet then
		return
	end

	ElevatorLevel = 1

	ElevatorBaseY =
		feet
		- CONFIG.PlatformSize.Y / 2
		- 0.05

	ElevatorCurrentY =
		ElevatorBaseY

	ElevatorTargetY =
		ElevatorBaseY

	ElevatorMoving = false

	LastElevatorRootPosition =
		Root.Position

	--------------------------------------------------------

	Platform =
		Instance.new("Part")

	Platform.Name =
		"SouzaElevatorV13"

	Platform.Size =
		CONFIG.PlatformSize

	Platform.Anchored = true
	Platform.CanCollide = true
	Platform.CanTouch = false
	Platform.CanQuery = false
	Platform.CastShadow = false

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
-- REMOVE
------------------------------------------------------------

local function RemoveElevator()

	ElevatorLevel = 0

	ElevatorBaseY = nil
	ElevatorCurrentY = nil
	ElevatorTargetY = nil

	ElevatorMoving = false

	LastElevatorRootPosition = nil

	if Platform then

		Platform:Destroy()

		Platform = nil
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

	local feet =
		GetFeetY()

	if not feet then
		return
	end

	local offset =
		math.max(
			ElevatorLevel - 1,
			0
		)
		* CONFIG.StepHeight

	ElevatorCurrentY =
		feet
		- Platform.Size.Y / 2
		- 0.05

	ElevatorBaseY =
		ElevatorCurrentY
		- offset

	ElevatorTargetY =
		ElevatorCurrentY

	ElevatorMoving = false

	LastElevatorRootPosition =
		Root.Position
end

------------------------------------------------------------
-- CHANGE LEVEL
------------------------------------------------------------

local function ChangeElevatorLevel(direction)

	if not Root or not Humanoid then

		return false,
			"Personagem indisponível"
	end

	if not Platform then

		if direction < 0 then

			return false,
				"Desativado"
		end

		CreateElevator()

		return true,
			"Nível 1"
	end

	--------------------------------------------------------
	-- NÃO ACEITA SPAM DURANTE TRANSIÇÃO
	--------------------------------------------------------

	if ElevatorMoving then

		return false,
			"Aguarde o nível terminar"
	end

	--------------------------------------------------------

	local newLevel =
		ElevatorLevel + direction

	if newLevel <= 0 then

		RemoveElevator()

		return true,
			"Desativado"
	end

	newLevel =
		math.clamp(
			newLevel,
			1,
			CONFIG.MaxLevel
		)

	if newLevel == ElevatorLevel then

		return false,
			"Limite"
	end

	ElevatorLevel =
		newLevel

	ElevatorTargetY =
		ElevatorBaseY
		+ (
			ElevatorLevel - 1
		)
		* CONFIG.StepHeight

	ElevatorMoving = true

	return true,
		"Nível "
		.. ElevatorLevel
end

------------------------------------------------------------
-- ELEVATOR LOOP
------------------------------------------------------------

RunService.Heartbeat:Connect(function(dt)

	if not Platform
		or not Platform.Parent
		or not Root
		or not Root.Parent
		or not Humanoid
		or Humanoid.Health <= 0
	then
		return
	end

	local position =
		Root.Position

	--------------------------------------------------------
	-- MOVIMENTO EXTERNO GRANDE
	--------------------------------------------------------

	if LastElevatorRootPosition then

		local delta =
			(
				position
				- LastElevatorRootPosition
			).Magnitude

		if delta >
			CONFIG.RecoveryDistance
		then

			RebaseElevator()

			return
		end
	end

	LastElevatorRootPosition =
		position

	--------------------------------------------------------
	-- MOVE Y
	--------------------------------------------------------

	if ElevatorCurrentY
		and ElevatorTargetY
	then

		local difference =
			ElevatorTargetY
			- ElevatorCurrentY

		if math.abs(difference)
			<= CONFIG.ElevatorArrivalTolerance
		then

			ElevatorCurrentY =
				ElevatorTargetY

			ElevatorMoving =
				false

		else

			local speed

			------------------------------------------------
			-- UP
			------------------------------------------------

			if difference > 0 then

				speed =
					CONFIG.UpSpeed

			------------------------------------------------
			-- DOWN
			------------------------------------------------

			else

				speed =
					CONFIG.DownSpeed

				local feet =
					GetFeetY()

				local platformTop =
					ElevatorCurrentY
					+ Platform.Size.Y / 2

				if feet then

					local gap =
						feet
						- platformTop

					if gap >
						CONFIG.MaximumDownGap
					then

						speed = 0
					end
				end
			end

			------------------------------------------------

			if speed > 0 then

				local maxStep =
					speed * dt

				if math.abs(difference)
					<= maxStep
				then

					ElevatorCurrentY =
						ElevatorTargetY

					ElevatorMoving =
						false

				else

					ElevatorCurrentY +=
						math.sign(difference)
						* maxStep
				end
			end
		end
	end

	--------------------------------------------------------
	-- SOMENTE A PLATAFORMA É MOVIMENTADA
	--------------------------------------------------------

	Platform.CFrame =
		CFrame.new(
			position.X,
			ElevatorCurrentY,
			position.Z
		)
end)

------------------------------------------------------------
-- ========================================================
-- TP FROM
-- ========================================================
------------------------------------------------------------

local TPBusy = false

------------------------------------------------------------
-- POSITION CLEAR
------------------------------------------------------------

local function TPPositionClear(
	position,
	wall
)

	if not Character then
		return false
	end

	local _, charSize =
		Character:GetBoundingBox()

	local checkSize =
		Vector3.new(

			math.max(
				charSize.X * 0.58,
				2
			),

			math.max(
				charSize.Y * 0.68,
				3
			),

			math.max(
				charSize.Z * 0.58,
				2
			)
		)

	local params =
		OverlapParams.new()

	params.FilterType =
		Enum.RaycastFilterType.Exclude

	local ignore = {
		Character,
		wall
	}

	if Platform then
		table.insert(
			ignore,
			Platform
		)
	end

	params.FilterDescendantsInstances =
		ignore

	local parts =
		workspace:GetPartBoundsInBox(
			CFrame.new(position),
			checkSize,
			params
		)

	for _, part in ipairs(parts) do

		if part:IsA("BasePart")
			and part.CanCollide
		then

			return false
		end
	end

	return true
end

------------------------------------------------------------
-- CALCULATE WALL EXIT
------------------------------------------------------------

local function CalculateWallExit(
	part,
	hitPosition,
	worldDirection
)

	worldDirection =
		worldDirection.Unit

	local localOrigin =
		part.CFrame:PointToObjectSpace(

			hitPosition
			+ worldDirection * 0.04

		)

	local localDirection =
		part.CFrame:VectorToObjectSpace(
			worldDirection
		)

	local half =
		part.Size / 2

	local tMin = -math.huge
	local tMax = math.huge

	--------------------------------------------------------

	local function Axis(o, d, h)

		if math.abs(d) < 0.00001 then

			if o < -h or o > h then
				return false
			end

			return true
		end

		local a =
			(-h - o) / d

		local b =
			(h - o) / d

		if a > b then
			a, b = b, a
		end

		tMin =
			math.max(
				tMin,
				a
			)

		tMax =
			math.min(
				tMax,
				b
			)

		return tMin <= tMax
	end

	--------------------------------------------------------

	if not Axis(
		localOrigin.X,
		localDirection.X,
		half.X
	) then
		return nil
	end

	if not Axis(
		localOrigin.Y,
		localDirection.Y,
		half.Y
	) then
		return nil
	end

	if not Axis(
		localOrigin.Z,
		localDirection.Z,
		half.Z
	) then
		return nil
	end

	if tMax < 0
		or tMax == math.huge
	then
		return nil
	end

	local localExit =
		localOrigin
		+ localDirection
		* (
			tMax + 0.04
		)

	return part.CFrame:PointToWorldSpace(
		localExit
	)
end

------------------------------------------------------------
-- TP
------------------------------------------------------------

local function TPFrom()

	if TPBusy then
		return false, "Aguarde"
	end

	if not Root
		or not Character
		or not Humanoid
	then

		return false,
			"Personagem indisponível"
	end

	TPBusy = true

	local look =
		Camera.CFrame.LookVector

	local direction =
		Vector3.new(
			look.X,
			0,
			look.Z
		)

	if direction.Magnitude < 0.05 then

		direction =
			Vector3.new(
				Root.CFrame.LookVector.X,
				0,
				Root.CFrame.LookVector.Z
			)
	end

	if direction.Magnitude < 0.01 then

		TPBusy = false

		return false,
			"Direção inválida"
	end

	direction =
		direction.Unit

	--------------------------------------------------------
	-- RAY
	--------------------------------------------------------

	local params =
		RaycastParams.new()

	params.FilterType =
		Enum.RaycastFilterType.Exclude

	local ignore = {
		Character
	}

	if Platform then
		table.insert(
			ignore,
			Platform
		)
	end

	params.FilterDescendantsInstances =
		ignore

	params.IgnoreWater = true

	--------------------------------------------------------

	local origin =
		Root.Position
		+ Vector3.new(
			0,
			0.4,
			0
		)

	local result =
		workspace:Raycast(
			origin,
			direction * CONFIG.TPDistance,
			params
		)

	if not result then

		TPBusy = false

		return false,
			"Sem parede na frente"
	end

	local wall =
		result.Instance

	if not wall:IsA("BasePart") then

		TPBusy = false

		return false,
			"Objeto incompatível"
	end

	if math.abs(result.Normal.Y) >
		0.72
	then

		TPBusy = false

		return false,
			"Aponte para uma parede"
	end

	--------------------------------------------------------

	local exit =
		CalculateWallExit(
			wall,
			result.Position,
			direction
		)

	if not exit then

		TPBusy = false

		return false,
			"Não achei o outro lado"
	end

	--------------------------------------------------------
	-- FIND FREE DESTINATION
	--------------------------------------------------------

	local destination = nil

	for distance =
		2.5,
		CONFIG.TPSearchAfterWall,
		0.5
	do

		local candidate =
			exit
			+ direction * distance

		candidate =
			Vector3.new(
				candidate.X,
				Root.Position.Y,
				candidate.Z
			)

		if TPPositionClear(
			candidate,
			wall
		) then

			destination =
				candidate

			break
		end
	end

	if not destination then

		TPBusy = false

		return false,
			"Sem espaço livre"
	end

	--------------------------------------------------------
	-- SINGLE TELEPORT
	--------------------------------------------------------

	Character:PivotTo(

		CFrame.lookAt(
			destination,
			destination + direction
		)

	)

	if Platform then

		task.defer(
			RebaseElevator
		)
	end

	TPBusy = false

	return true,
		"Atravessou "
		.. wall.Name
end

------------------------------------------------------------
-- ========================================================
-- INSTANT STEAL
-- ========================================================
------------------------------------------------------------

local StealKeywords = {

	"steal",
	"roubar",
	"roubo",
	"pegar",
	"take",
	"grab",
	"collect",
}

------------------------------------------------------------
-- PROMPT POSITION
------------------------------------------------------------

local function PromptPosition(prompt)

	local parent =
		prompt.Parent

	if not parent then
		return nil
	end

	if parent:IsA("Attachment") then
		return parent.WorldPosition
	end

	if parent:IsA("BasePart") then
		return parent.Position
	end

	local model =
		parent:FindFirstAncestorOfClass(
			"Model"
		)

	if model then

		local success,
			pivot =
			pcall(function()
				return model:GetPivot()
			end)

		if success then
			return pivot.Position
		end
	end

	return nil
end

------------------------------------------------------------
-- IS STEAL PROMPT
------------------------------------------------------------

local function IsStealPrompt(prompt)

	if not prompt:IsA(
		"ProximityPrompt"
	) then
		return false
	end

	if not prompt.Enabled then
		return false
	end

	--------------------------------------------------------
	-- melhor opção para seu próprio jogo:
	--
	-- prompt:SetAttribute("Stealable", true)
	--------------------------------------------------------

	if prompt:GetAttribute(
		"Stealable"
	) == true
	then

		return true
	end

	local text =
		string.lower(
			prompt.Name
			.. " "
			.. prompt.ActionText
			.. " "
			.. prompt.ObjectText
		)

	for _, keyword in ipairs(
		StealKeywords
	) do

		if string.find(
			text,
			keyword,
			1,
			true
		) then

			return true
		end
