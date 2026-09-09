--[[
    ============================================================
                    SOUZA ADMIN PANEL V9
                     MOBILE FIRST
                    ÚNICO LOCALSCRIPT
    ============================================================

    StarterPlayer
        > StarterPlayerScripts
            > LocalScript

    PRINCIPAL
        - Elevador estável
        - DESCNY
        - TP FROM
        - AntiLag

    VISUAIS
        - XRay
        - ESP Line
        - ESP Box
        - Chams
        - Filtro: Todos / Mesmo Time / Outros Times

    DIVERSOS
        - Remover plataforma
        - Desligar visuais

    AJUSTES
        - Distância ESP
        - Força XRay

    MOBILE:
        - Menu arrastável pelo topo
        - Bolinha minimizada arrastável
        - Toque na bolinha = abrir
        - Arrastar bolinha = mover sem abrir

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
	-- PANEL
	--------------------------------------------------------

	Width = 700,

	Height = 430,

	SidebarWidth = 155,

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

	HorizontalSmooth = 18,

	VerticalSmooth = 10,

	--------------------------------------------------------
	-- STABILIZER
	--------------------------------------------------------

	RecoveryHorizontal = 14,

	RecoveryVertical = 9,

	--------------------------------------------------------
	-- TP FROM
	--------------------------------------------------------

	TPDistance = 55,

	TPExtraDistance = 1.4,

	--------------------------------------------------------
	-- XRAY
	--------------------------------------------------------

	XRayTransparency = 0.72,

	--------------------------------------------------------
	-- ESP
	--------------------------------------------------------

	ESPDistance = 450,

	ESPUpdateRate = 1 / 20,
}

------------------------------------------------------------
-- COLORS
------------------------------------------------------------

local C = {

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
			113,
			42
		),

	Green =
		Color3.fromRGB(
			74,
			220,
			145
		),

	Red =
		Color3.fromRGB(
			240,
			75,
			95
		),

	Blue =
		Color3.fromRGB(
			75,
			180,
			255
		),

	Purple =
		Color3.fromRGB(
			174,
			93,
			255
		),

	White =
		Color3.fromRGB(
			250,
			251,
			253
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

local Old =
	PlayerGui:FindFirstChild(
		"SouzaAdminV9"
	)

if Old then

	Old:Destroy()

end

------------------------------------------------------------

local OldESP =
	PlayerGui:FindFirstChild(
		"SouzaAdminESP"
	)

if OldESP then

	OldESP:Destroy()

end

------------------------------------------------------------

local OldPlatform =
	workspace:FindFirstChild(
		"SouzaAdminPlatform_"
		.. Player.UserId
	)

if OldPlatform then

	OldPlatform:Destroy()

end

------------------------------------------------------------
-- HELPERS
------------------------------------------------------------

local function Corner(
	Object,
	Radius
)

	local UICorner =
		Instance.new(
			"UICorner"
		)

	UICorner.CornerRadius =
		UDim.new(
			0,
			Radius
		)

	UICorner.Parent =
		Object

	return UICorner

end

------------------------------------------------------------

local function Stroke(
	Object,
	Color,
	Thickness,
	Transparency
)

	local UIStroke =
		Instance.new(
			"UIStroke"
		)

	UIStroke.Color =
		Color or C.Stroke

	UIStroke.Thickness =
		Thickness or 1

	UIStroke.Transparency =
		Transparency or 0

	UIStroke.Parent =
		Object

	return UIStroke

end

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
-- ELEVATOR
-- ========================================================
------------------------------------------------------------

local Platform =
	nil

local PlatformLevel =
	0

local PlatformBaseY =
	0

local PlatformCurrentY =
	0

local PlatformTargetY =
	0

local PlatformCurrentX =
	0

local PlatformCurrentZ =
	0

local LastRootPosition =
	nil

------------------------------------------------------------
-- GET FEET
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
	-- BASE POSITION
	--------------------------------------------------------

	PlatformBaseY =
		GetFeetY()
		- CONFIG.PlatformSize.Y / 2
		- 0.05

	PlatformCurrentY =
		PlatformBaseY

	PlatformTargetY =
		PlatformBaseY

	PlatformCurrentX =
		Root.Position.X

	PlatformCurrentZ =
		Root.Position.Z

	LastRootPosition =
		Root.Position

	--------------------------------------------------------
	-- PLATFORM
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

			PlatformCurrentX,

			PlatformCurrentY,

			PlatformCurrentZ
		)

	Platform.Parent =
		workspace

	--------------------------------------------------------
	-- PLATFORM DESIGN
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

	local Background =
		Instance.new(
			"Frame"
		)

	Background.Size =
		UDim2.fromScale(
			1,
			1
		)

	Background.BackgroundColor3 =
		Color3.fromRGB(
			7,
			12,
			19
		)

	Background.BorderSizePixel =
		0

	Background.Parent =
		Surface

	--------------------------------------------------------

	local Gradient =
		Instance.new(
			"UIGradient"
		)

	Gradient.Rotation =
		35

	Gradient.Color =
		ColorSequence.new({

			ColorSequenceKeypoint.new(

				0,

				Color3.fromRGB(
					55,
					25,
					16
				)
			),

			ColorSequenceKeypoint.new(

				0.5,

				Color3.fromRGB(
					8,
					14,
					23
				)
			),

			ColorSequenceKeypoint.new(

				1,

				Color3.fromRGB(
					24,
					12,
					13
				)
			),

		})

	Gradient.Parent =
		Background

	--------------------------------------------------------

	local Border =
		Instance.new(
			"UIStroke"
		)

	Border.Color =
		C.Accent

	Border.Thickness =
		3

	Border.Transparency =
		0.05

	Border.Parent =
		Background

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

	Fallback.TextColor3 =
		C.Accent

	Fallback.TextTransparency =
		0.72

	Fallback.TextScaled =
		true

	Fallback.FontFace =
		FONT_BOLD

	Fallback.Parent =
		Background

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
		Background

end

------------------------------------------------------------
-- REMOVE PLATFORM
------------------------------------------------------------

local function RemovePlatform()

	PlatformLevel =
		0

	LastRootPosition =
		nil

	if Platform then

		Platform:Destroy()

		Platform =
			nil

	end

end

------------------------------------------------------------
-- PLATFORM LOOP
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

		local RootPosition =
			Root.Position

		----------------------------------------------------
		-- STABILIZER
		----------------------------------------------------

		if LastRootPosition then

			local Difference =
				RootPosition
				- LastRootPosition

			local HorizontalDifference =
				Vector2.new(

					Difference.X,

					Difference.Z

				).Magnitude

			local VerticalDifference =
				math.abs(
					Difference.Y
				)

			------------------------------------------------
			-- TELEPORT / RUBBERBAND / CORRECTION
			------------------------------------------------

			if
				HorizontalDifference
					>= CONFIG.RecoveryHorizontal

				or

				VerticalDifference
					>= CONFIG.RecoveryVertical
			then

				--------------------------------------------
				-- SNAP X/Z
				--------------------------------------------

				PlatformCurrentX =
					RootPosition.X

				PlatformCurrentZ =
					RootPosition.Z

				--------------------------------------------
				-- Mantém o LEVEL mas cria nova referência
				-- baseada na posição para onde o jogo
				-- devolveu o personagem.
				--------------------------------------------

				local LevelOffset =
					math.max(

						PlatformLevel - 1,

						0

					)

					* CONFIG.StepHeight

				PlatformBaseY =
					GetFeetY()

					- CONFIG.PlatformSize.Y / 2

					- 0.05

					- LevelOffset

				PlatformTargetY =
					PlatformBaseY
					+ LevelOffset

				PlatformCurrentY =
					PlatformTargetY

			end

		end

		LastRootPosition =
			RootPosition

		----------------------------------------------------
		-- X/Z SMOOTH FOLLOW
		----------------------------------------------------

		local HAlpha =
			1
			- math.exp(

				-CONFIG.HorizontalSmooth

				* DT
			)

		PlatformCurrentX =
			PlatformCurrentX

			+ (

				RootPosition.X

				- PlatformCurrentX
			)

			* HAlpha

		PlatformCurrentZ =
			PlatformCurrentZ

			+ (

				RootPosition.Z

				- PlatformCurrentZ
			)

			* HAlpha

		----------------------------------------------------
		-- FAILSAFE X/Z
		----------------------------------------------------

		local Distance =
			Vector2.new(

				PlatformCurrentX
					- RootPosition.X,

				PlatformCurrentZ
					- RootPosition.Z

			).Magnitude

		if Distance > 6 then

			PlatformCurrentX =
				RootPosition.X

			PlatformCurrentZ =
				RootPosition.Z

		end

		----------------------------------------------------
		-- Y
		----------------------------------------------------

		local VAlpha =
			1
			- math.exp(

				-CONFIG.VerticalSmooth

				* DT
			)

		local PreviousY =
			PlatformCurrentY

		PlatformCurrentY =
			PlatformCurrentY

			+ (

				PlatformTargetY

				- PlatformCurrentY

			)

			* VAlpha

		----------------------------------------------------
		-- LIFT ASSIST
		----------------------------------------------------

		local DeltaY =
			PlatformCurrentY
			- PreviousY

		if math.abs(
			DeltaY
		) > 0.002
		then

			local DifferenceFromPlatform =
				Root.Position.Y
				- PlatformCurrentY

			if
				DifferenceFromPlatform > 0

				and

				DifferenceFromPlatform < 7
			then

				Root.CFrame =
					Root.CFrame

					+ Vector3.new(

						0,

						DeltaY,

						0

					)

			end

		end

		----------------------------------------------------
		-- APPLY
		----------------------------------------------------

		Platform.CFrame =
			CFrame.new(

				PlatformCurrentX,

				PlatformCurrentY,

				PlatformCurrentZ
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

	"ghost",
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

	--------------------------------------------------------

	if
		Object:GetAttribute(
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

	--------------------------------------------------------

	local Search =
		string.lower(

			Object.Name

			.. " "

			.. Object.ToolTip
		)

	for _,
		Keyword
		in ipairs(
			InvisKeywords
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
-- TP FROM
-- ATRAVESSAR PAREDE DA FRENTE
-- ========================================================
------------------------------------------------------------

local function CalculateExitPoint(
	Part,
	HitPosition,
	Direction
)

	Direction =
		Direction.Unit

	--------------------------------------------------------
	-- TRANSFORMA PRO ESPAÇO LOCAL DA PAREDE
	--------------------------------------------------------

	local LocalPosition =
		Part.CFrame:PointToObjectSpace(
			HitPosition
		)

	local LocalDirection =
		Part.CFrame:VectorToObjectSpace(
			Direction
		)

	local Half =
		Part.Size / 2

	local Candidates =
		{}

	--------------------------------------------------------
	-- X
	--------------------------------------------------------

	if math.abs(
		LocalDirection.X
	) > 0.0001
	then

		local Boundary =
			LocalDirection.X > 0

			and Half.X

			or -Half.X

		local T =
			(
				Boundary
				- LocalPosition.X
			)

			/ LocalDirection.X

		if T > 0.03 then

			table.insert(
				Candidates,
				T
			)

		end

	end

	--------------------------------------------------------
	-- Y
	--------------------------------------------------------

	if math.abs(
		LocalDirection.Y
	) > 0.0001
	then

		local Boundary =
			LocalDirection.Y > 0

			and Half.Y

			or -Half.Y

		local T =
			(
				Boundary
				- LocalPosition.Y
			)

			/ LocalDirection.Y

		if T > 0.03 then

			table.insert(
				Candidates,
				T
			)

		end

	end

	--------------------------------------------------------
	-- Z
	--------------------------------------------------------

	if math.abs(
		LocalDirection.Z
	) > 0.0001
	then

		local Boundary =
			LocalDirection.Z > 0

			and Half.Z

			or -Half.Z

		local T =
			(
				Boundary
				- LocalPosition.Z
			)

			/ LocalDirection.Z

		if T > 0.03 then

			table.insert(
				Candidates,
				T
			)

		end

	end

	--------------------------------------------------------

	if #Candidates == 0 then

		return nil

	end

	local ExitDistance =
		math.min(
			table.unpack(
				Candidates
			)
		)

	--------------------------------------------------------

	local RootRadius =
		2

	if Root then

		RootRadius =
			math.max(

				Root.Size.X,

				Root.Size.Z

			)

			/ 2

	end

	return HitPosition

		+ Direction

		* (

			ExitDistance

			+ RootRadius

			+ CONFIG.TPExtraDistance

		)

end

------------------------------------------------------------

local function TPFrom()

	if not Root
		or not Character
	then

		return false,
			"Personagem não encontrado"

	end

	--------------------------------------------------------
	-- DIREÇÃO HORIZONTAL DA CAMERA
	--------------------------------------------------------

	local CameraLook =
		Camera.CFrame.LookVector

	local FlatDirection =
		Vector3.new(

			CameraLook.X,

			0,

			CameraLook.Z
		)

	if FlatDirection.Magnitude
		< 0.05
	then

		FlatDirection =
			Vector3.new(

				Root.CFrame.LookVector.X,

				0,

				Root.CFrame.LookVector.Z

			)

	end

	FlatDirection =
		FlatDirection.Unit

	--------------------------------------------------------
	-- RAYCAST
	--------------------------------------------------------

	local Params =
		RaycastParams.new()

	Params.FilterType =
		Enum.RaycastFilterType.Exclude

	local Exclude = {

		Character
	}

	if Platform then

		table.insert(
			Exclude,
			Platform
		)

	end

	Params.FilterDescendantsInstances =
		Exclude

	Params.IgnoreWater =
		true

	--------------------------------------------------------

	local Origin =
		Root.Position

		+ Vector3.new(
			0,
			1,
			0
		)

	local Result =
		workspace:Raycast(

			Origin,

			FlatDirection
				* CONFIG.TPDistance,

			Params
		)

	if not Result then

		return false,
			"Nenhuma parede na frente"

	end

	--------------------------------------------------------

	local Part =
		Result.Instance

	if not Part:IsA(
		"BasePart"
	) then

		return false,
			"Objeto incompatível"

	end

	--------------------------------------------------------
	-- EVITA TELEPORTAR ATRAVÉS DE UM CHÃO / TETO
	--------------------------------------------------------

	if math.abs(
		Result.Normal.Y
	) > 0.75
	then

		return false,
			"Aponte para uma parede"

	end

	--------------------------------------------------------

	local Exit =
		CalculateExitPoint(

			Part,

			Result.Position,

			FlatDirection
		)

	if not Exit then

		return false,
			"Não consegui calcular o outro lado"

	end

	--------------------------------------------------------
	-- PRESERVA ALTURA DO PLAYER
	--------------------------------------------------------

	Exit =
		Vector3.new(

			Exit.X,

			Root.Position.Y,

			Exit.Z
		)

	--------------------------------------------------------

	Root.CFrame =
		CFrame.lookAt(

			Exit,

			Exit
				+ FlatDirection
		)

	--------------------------------------------------------
	-- STABILIZER SABE DA NOVA POSIÇÃO
	--------------------------------------------------------

	LastRootPosition =
		Root.Position

	return true,
		"Atravessou "
		.. Part.Name

end

------------------------------------------------------------
-- ========================================================
-- ANTILAG ADVANCED
-- 0 OFF
-- 1 LEVE
-- 2 MEDIO
-- 3 MAX
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

local function SetOptimized(
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
			] = Value

		end
	)

end

------------------------------------------------------------

local function RestoreAntiLag()

	AntiLagGeneration += 1

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

local function OptimizeObject(
	Object,
	Level
)

	--------------------------------------------------------
	-- LEVE
	--------------------------------------------------------

	if Level >= 1 then

		if
			Object:IsA(
				"BloomEffect"
			)

			or

			Object:IsA(
				"BlurEffect"
			)

			or

			Object:IsA(
				"SunRaysEffect"
			)

			or

			Object:IsA(
				"DepthOfFieldEffect"
			)
		then

			SetOptimized(
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

		if
			Object:IsA(
				"ParticleEmitter"
			)

			or

			Object:IsA(
				"Trail"
			)

			or

			Object:IsA(
				"Beam"
			)

			or

			Object:IsA(
				"Smoke"
			)

			or

			Object:IsA(
				"Fire"
			)

			or

			Object:IsA(
				"Sparkles"
			)

			or

			Object:IsA(
				"PointLight"
			)

			or

			Object:IsA(
				"SpotLight"
			)

			or

			Object:IsA(
				"SurfaceLight"
			)
		then

			SetOptimized(
				Object,
				"Enabled",
				false
			)

		end

	end

	--------------------------------------------------------
	-- MAXIMO
	--------------------------------------------------------

	if Level >= 3 then

		if Object:IsA(
			"BasePart"
		) then

			SetOptimized(
				Object,
				"CastShadow",
				false
			)

		end

		----------------------------------------------------

		if Object:IsA(
			"MeshPart"
		) then

			pcall(
				function()

					SetOptimized(

						Object,

						"RenderFidelity",

						Enum.RenderFidelity.Performance

					)

				end
			)

		end

		----------------------------------------------------

		if
			Object:IsA(
				"Decal"
			)

			or

			Object:IsA(
				"Texture"
			)
		then

			SetOptimized(
				Object,
				"Transparency",
				1
			)

		end

	end

end

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

	AntiLagGeneration += 1

	local Generation =
		AntiLagGeneration

	--------------------------------------------------------
	-- LIGHTING
	--------------------------------------------------------

	SetOptimized(
		Lighting,
		"GlobalShadows",
		false
	)

	--------------------------------------------------------
	-- TERRAIN
	--------------------------------------------------------

	if Level >= 2 then

		pcall(
			function()

				SetOptimized(

					workspace.Terrain,

					"Decoration",

					false

				)

			end
		)

	end

	--------------------------------------------------------
	-- SCAN EM LOTES
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

				if Generation
					~= AntiLagGeneration
				then

					return

				end

				OptimizeObject(
					Object,
					Level
				)

				if Index % 150
					== 0
				then

					RunService.Heartbeat:Wait()

				end

			end

			------------------------------------------------

			for _,
				Object
				in ipairs(
					Lighting:GetDescendants()
				)
			do

				if Generation
					~= AntiLagGeneration
				then

					return

				end

				OptimizeObject(
					Object,
					Level
				)

			end

		end
	)

end

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

Lighting.DescendantAdded:Connect(
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
-- XRAY
-- ========================================================
------------------------------------------------------------

local XRayEnabled =
	false

local XRayCache =
	{}

------------------------------------------------------------
-- CHECK CHARACTER PART
------------------------------------------------------------

local function IsCharacterPart(
	Part
)

	local Model =
		Part:FindFirstAncestorOfClass(
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

local function ApplyXRayObject(
	Object
)

	if not Object:IsA(
		"BasePart"
	) then

		return

	end

	if Platform
		and (
			Object == Platform

			or

			Object:IsDescendantOf(
				Platform
			)
		)
	then

		return

	end

	if IsCharacterPart(
		Object
	) then

		return

	end

	--------------------------------------------------------

	if XRayCache[
		Object
	] == nil
	then

		XRayCache[
			Object
		] =
			Object.LocalTransparencyModifier

	end

	--------------------------------------------------------

	Object.LocalTransparencyModifier =
		math.max(

			XRayCache[
				Object
			] or 0,

			CONFIG.XRayTransparency

		)

end

------------------------------------------------------------

local function EnableXRay()

	if XRayEnabled then
		return
	end

	XRayEnabled =
		true

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

				ApplyXRayObject(
					Object
				)

				if Index % 200
					== 0
				then

					RunService.Heartbeat:Wait()

				end

			end

		end
	)

end

------------------------------------------------------------

local function DisableXRay()

	XRayEnabled =
		false

	for Object,
		Original
		in pairs(
			XRayCache
		)
	do

		if Object
			and Object.Parent
		then

			Object.LocalTransparencyModifier =
				Original

		end

	end

	XRayCache =
		{}

end

------------------------------------------------------------

local function RefreshXRay()

	if not XRayEnabled then
		return
	end

	for Object,
		Original
		in pairs(
			XRayCache
		)
	do

		if Object
			and Object.Parent
		then

			Object.LocalTransparencyModifier =
				math.max(

					Original,

					CONFIG.XRayTransparency
				)

		end

	end

end

------------------------------------------------------------

workspace.DescendantAdded:Connect(
	function(Object)

		if XRayEnabled then

			task.defer(
				function()

					ApplyXRayObject(
						Object
					)

				end
			)

		end

	end
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
	"SouzaAdminESP"

ESPGui.IgnoreGuiInset =
	true

ESPGui.ResetOnSpawn =
	false

ESPGui.DisplayOrder =
	998

ESPGui.Parent =
	PlayerGui

------------------------------------------------------------
-- HIGHLIGHT FOLDER
------------------------------------------------------------

local HighlightFolder =
	Instance.new(
		"Folder"
	)

HighlightFolder.Name =
	"SouzaHighlights"

HighlightFolder.Parent =
	workspace

------------------------------------------------------------

local ESPObjects =
	{}

------------------------------------------------------------
-- FILTER
------------------------------------------------------------

local function ShouldESP(
	Target
)

	if Target == Player then

		return false

	end

	if not Target.Character then

		return false

	end

	local H =
		Target.Character:FindFirstChildOfClass(
			"Humanoid"
		)

	if not H
		or H.Health <= 0
	then

		return false

	end

	--------------------------------------------------------

	if ESPFilter ==
		"Mesmo Time"
	then

		if not Player.Team then

			return false

		end

		return Target.Team
			== Player.Team

	end

	--------------------------------------------------------

	if ESPFilter ==
		"Outros Times"
	then

		if not Player.Team then

			return true

		end

		return Target.Team
			~= Player.Team

	end

	--------------------------------------------------------

	return true

end

------------------------------------------------------------
-- PLAYER COLOR
------------------------------------------------------------

local function GetESPColor(
	Target
)

	if Player.Team
		and Target.Team
	then

		if Target.Team ==
			Player.Team
		then

			return C.Green

		else

			return C.Red

		end

	end

	return C.Accent

end

------------------------------------------------------------
-- CREATE DATA
------------------------------------------------------------

local function CreateESPData(
	Target
)

	local Existing =
		ESPObjects[
			Target
		]

	if Existing then

		return Existing

	end

	local Data = {

		Character = nil
	}

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

	Box.ZIndex =
		100

	Box.Parent =
		ESPGui

	local BoxStroke =
		Instance.new(
			"UIStroke"
		)

	BoxStroke.Thickness =
		1.7

	BoxStroke.Color =
		C.Accent

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

	Line.BackgroundColor3 =
		C.Accent

	Line.BorderSizePixel =
		0

	Line.Visible =
		false

	Line.ZIndex =
		99

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

	Highlight.Name =
		"SouzaCham"

	Highlight.FillTransparency =
		0.63

	Highlight.OutlineTransparency =
		0.05

	Highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	Highlight.Enabled =
		false

	Highlight.Parent =
		HighlightFolder

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
-- CLEAN TARGET
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
-- UPDATE BOX
------------------------------------------------------------

local function UpdateESPBox(
	Data,
	CharacterModel
)

	local CF,
		Size

	local Success =
		pcall(
			function()

				CF,
					Size =
					CharacterModel:GetBoundingBox()

			end
		)

	if not Success then

		Data.Box.Visible =
			false

		return

	end

	--------------------------------------------------------

	local Half =
		Size / 2

	local Points = {

		Vector3.new(-Half.X, -Half.Y, -Half.Z),

		Vector3.new( Half.X, -Half.Y, -Half.Z),

		Vector3.new(-Half.X,  Half.Y, -Half.Z),

		Vector3.new( Half.X,  Half.Y, -Half.Z),

		Vector3.new(-Half.X, -Half.Y,  Half.Z),

		Vector3.new( Half.X, -Half.Y,  Half.Z),

		Vector3.new(-Half.X,  Half.Y,  Half.Z),

		Vector3.new( Half.X,  Half.Y,  Half.Z),
	}

	--------------------------------------------------------

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
		LocalPoint
		in ipairs(
			Points
		)
	do

		local WorldPoint =
			CF:PointToWorldSpace(
				LocalPoint
			)

		local Screen =
			Camera:WorldToViewportPoint(
				WorldPoint
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

	--------------------------------------------------------

	if not Valid then

		Data.Box.Visible =
			false

		return

	end

	--------------------------------------------------------

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
-- UPDATE LINE
------------------------------------------------------------

local function UpdateESPLine(
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

	--------------------------------------------------------

	local Viewport =
		Camera.ViewportSize

	local From =
		Vector2.new(

			Viewport.X / 2,

			Viewport.Y - 20
		)

	local To =
		Vector2.new(

			Screen.X,

			Screen.Y
		)

	local Delta =
		To - From

	local Length =
		Delta.Magnitude

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

			Length,

			1.6
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

local ESPAccumulator =
	0

RunService.RenderStepped:Connect(
	function(DT)

		ESPAccumulator +=
			DT

		if ESPAccumulator <
			CONFIG.ESPUpdateRate
		then

			return

		end

		ESPAccumulator =
			0

		----------------------------------------------------

		local AnyESP =
			ESPLine
			or ESPBox
			or ESPChams

		if not AnyESP then

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

			if ShouldESP(
				Target
			) then

				local Char =
					Target.Character

				local TargetRoot =
					Char
					and
					Char:FindFirstChild(
						"HumanoidRootPart"
					)

				if TargetRoot
					and Root
				then

					local Distance =
						(
							TargetRoot.Position

							- Root.Position
						).Magnitude

					local Data =
						CreateESPData(
							Target
						)

					if Distance <=
						CONFIG.ESPDistance
					then

						local Color =
							GetESPColor(
								Target
							)

						------------------------------------
						-- CHARACTER CHANGED
						------------------------------------

						if Data.Character
							~= Char
						then

							Data.Character =
								Char

							Data.Highlight.Adornee =
								Char

						end

						------------------------------------
						-- COLORS
						------------------------------------

						Data.BoxStroke.Color =
							Color

						Data.Line.BackgroundColor3 =
							Color

						Data.Highlight.FillColor =
							Color

						Data.Highlight.OutlineColor =
							C.White

						------------------------------------
						-- BOX
						------------------------------------

						if ESPBox then

							UpdateESPBox(

								Data,

								Char

							)

						else

							Data.Box.Visible =
								false

						end

						------------------------------------
						-- LINE
						------------------------------------

						if ESPLine then

							UpdateESPLine(

								Data,

								TargetRoot.Position

							)

						else

							Data.Line.Visible =
								false

						end

						------------------------------------
						-- CHAMS
						------------------------------------

						Data.Highlight.Enabled =
							ESPChams

					else

						HideESP(
							Data
						)

					end

				end

			else

				local Data =
					ESPObjects[
						Target
					]

				if Data then

					HideESP(
						Data
					)

				end

			end

		end

	end
)

------------------------------------------------------------
-- PLAYER REMOVING
------------------------------------------------------------

Players.PlayerRemoving:Connect(
	function(Target)

		local Data =
			ESPObjects[
				Target
			]

		if Data then

			pcall(
				function()

					Data.Box:Destroy()

					Data.Line:Destroy()

					Data.Highlight:Destroy()

				end
			)

			ESPObjects[
				Target
			] =
				nil

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
	"SouzaAdminV9"

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

Main.BackgroundColor3 =
	C.BG

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
	13
)

Stroke(
	Main,
	C.Stroke,
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

MainScale.Scale =
	1

MainScale.Parent =
	Main

------------------------------------------------------------

local function UpdateScale()

	local Viewport =
		Camera.ViewportSize

	local ScaleX =
		Viewport.X / 760

	local ScaleY =
		Viewport.Y / 470

	MainScale.Scale =
		math.clamp(

			math.min(
				ScaleX,
				ScaleY
			),

			0.62,

			1

		)

end

UpdateScale()

------------------------------------------------------------

Camera:GetPropertyChangedSignal(
	"ViewportSize"
):Connect(
	UpdateScale
)

------------------------------------------------------------
-- BACKGROUND GRADIENT
------------------------------------------------------------

local BGGradient =
	Instance.new(
		"UIGradient"
	)

BGGradient.Rotation =
	120

BGGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(

			0,

			Color3.fromRGB(
				14,
				22,
				34
			)
		),

		ColorSequenceKeypoint.new(

			0.55,

			Color3.fromRGB(
				6,
				11,
				18
			)
		),

		ColorSequenceKeypoint.new(

			1,

			Color3.fromRGB(
				18,
				9,
				10
			)
		),

	})

BGGradient.Parent =
	Main

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

TopAccent.BackgroundColor3 =
	C.Accent

TopAccent.BorderSizePixel =
	0

TopAccent.ZIndex =
	50

TopAccent.Parent =
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

Sidebar.BorderSizePixel =
	0

Sidebar.ZIndex =
	11

Sidebar.Parent =
	Main

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
		56,
		56
	)

LogoHolder.BackgroundColor3 =
	C.Card

LogoHolder.BorderSizePixel =
	0

LogoHolder.ZIndex =
	20

LogoHolder.Parent =
	Sidebar

Corner(
	LogoHolder,
	28
)

Stroke(
	LogoHolder,
	C.Accent,
	2,
	0.05
)

------------------------------------------------------------
-- FALLBACK LOGO
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

LogoFallback.TextColor3 =
	C.Accent

LogoFallback.TextSize =
	27

LogoFallback.FontFace =
	FONT_BOLD

LogoFallback.ZIndex =
	21

LogoFallback.Parent =
	LogoHolder

------------------------------------------------------------
-- IMAGE
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
		49,
		49
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

Brand.TextColor3 =
	C.Text

Brand.TextSize =
	14

Brand.FontFace =
	FONT_BOLD

Brand.ZIndex =
	20

Brand.Parent =
	Sidebar

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

BrandSub.TextColor3 =
	C.Muted

BrandSub.TextSize =
	8

BrandSub.FontFace =
	FONT_MEDIUM

BrandSub.ZIndex =
	20

BrandSub.Parent =
	Sidebar

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
		-155
	)

Navigation.BackgroundTransparency =
	1

Navigation.ZIndex =
	20

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
	11

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
-- DRAG HANDLE
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

local HeaderSmall =
	Instance.new(
		"TextLabel"
	)

HeaderSmall.Position =
	UDim2.fromOffset(
		24,
		12
	)

HeaderSmall.Size =
	UDim2.fromOffset(
		280,
		16
	)

HeaderSmall.BackgroundTransparency =
	1

HeaderSmall.Text =
	"PAINEL ADMIN LOCAL"

HeaderSmall.TextColor3 =
	C.Muted

HeaderSmall.TextSize =
	8

HeaderSmall.FontFace =
	FONT_MEDIUM

HeaderSmall.TextXAlignment =
	Enum.TextXAlignment.Left

HeaderSmall.ZIndex =
	32

HeaderSmall.Parent =
	HeaderDrag

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
		25,
		27
	)

HeaderIcon.BackgroundTransparency =
	1

HeaderIcon.Text =
	"⌂"

HeaderIcon.TextColor3 =
	C.Accent

HeaderIcon.TextSize =
	20

HeaderIcon.FontFace =
	FONT_BOLD

HeaderIcon.ZIndex =
	32

HeaderIcon.Parent =
	HeaderDrag

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

HeaderTitle.TextColor3 =
	C.Accent

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

------------------------------------------------------------
-- CLOSE/MINIMIZE
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

Close.BackgroundColor3 =
	C.Control

Close.BorderSizePixel =
	0

Close.Text =
	"×"

Close.TextColor3 =
	C.Accent

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

Corner(
	Close,
	10
)

Stroke(
	Close,
	C.Stroke,
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

	Page.ScrollBarImageColor3 =
		C.Accent

	Page.ScrollBarImageTransparency =
		0.12

	Page.Visible =
		false

	Page.ZIndex =
		21

	Page.Parent =
		PageHolder

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

	--------------------------------------------------------

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
-- SECTION CREATOR
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

	Label.TextColor3 =
		C.Muted

	Label.TextSize =
		8

	Label.FontFace =
		FONT_BOLD

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.ZIndex =
		22

	Label.Parent =
		Parent

	return Label

end

------------------------------------------------------------
-- CARD CREATOR
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

	Card.BackgroundColor3 =
		C.Card

	Card.BorderSizePixel =
		0

	Card.ZIndex =
		22

	Card.Parent =
		Parent

	Corner(
		Card,
		10
	)

	Stroke(
		Card,
		C.StrokeSoft,
		1,
		0.08
	)

	--------------------------------------------------------
	-- LEFT ACCENT
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

	Accent.BackgroundColor3 =
		C.Accent

	Accent.BorderSizePixel =
		0

	Accent.ZIndex =
		23

	Accent.Parent =
		Card

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
			-200,
			0,
			26
		)

	TitleLabel.BackgroundTransparency =
		1

	TitleLabel.Text =
		Title

	TitleLabel.TextColor3 =
		C.Text

	TitleLabel.TextSize =
		14

	TitleLabel.FontFace =
		FONT_MEDIUM

	TitleLabel.TextXAlignment =
		Enum.TextXAlignment.Left

	TitleLabel.ZIndex =
		23

	TitleLabel.Parent =
		Card

	--------------------------------------------------------
	-- DESC
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
			-200,
			0,
			18
		)

	Desc.BackgroundTransparency =
		1

	Desc.Text =
		Description

	Desc.TextColor3 =
		C.Sub

	Desc.TextSize =
		9

	Desc.FontFace =
		FONT_REGULAR

	Desc.TextXAlignment =
		Enum.TextXAlignment.Left

	Desc.ZIndex =
		23

	Desc.Parent =
		Card

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
			112,
			39
		)

	Button.BackgroundColor3 =
		C.Control

	Button.BorderSizePixel =
		0

	Button.Text =
		Text

	Button.TextColor3 =
		C.Text

	Button.TextSize =
		10

	Button.FontFace =
		FONT_BOLD

	Button.AutoButtonColor =
		false

	Button.ZIndex =
		30

	Button.Parent =
		Card

	Corner(
		Button,
		9
	)

	local ButtonStroke =
		Stroke(
			Button,
			C.Stroke,
			1,
			0
		)

	return Button,
		ButtonStroke

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

	Track.BackgroundColor3 =
		C.Control

	Track.BorderSizePixel =
		0

	Track.Text =
		""

	Track.AutoButtonColor =
		false

	Track.ZIndex =
		30

	Track.Parent =
		Card

	Corner(
		Track,
		16
	)

	local TrackStroke =
		Stroke(
			Track,
			C.Stroke,
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

	Dot.BackgroundColor3 =
		C.Sub

	Dot.BorderSizePixel =
		0

	Dot.ZIndex =
		31

	Dot.Parent =
		Track

	Corner(
		Dot,
		11
	)

	--------------------------------------------------------

	local function Set(
		State,
		FireCallback
	)

		Enabled =
			State

		if Enabled then

			Tween(
				Track,
				0.17,
				{
					BackgroundColor3 =
						C.Accent
				}
			)

			Tween(
				Dot,
				0.17,
				{
					Position =
						UDim2.fromOffset(
							45,
							16
						),

					BackgroundColor3 =
						C.White
				}
			)

			TrackStroke.Color =
				C.Accent2

		else

			Tween(
				Track,
				0.17,
				{
					BackgroundColor3 =
						C.Control
				}
			)

			Tween(
				Dot,
				0.17,
				{
					Position =
						UDim2.fromOffset(
							17,
							16
						),

					BackgroundColor3 =
						C.Sub
				}
			)

			TrackStroke.Color =
				C.Stroke

		end

		if FireCallback ~= false
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

	Set(
		Enabled,
		false
	)

	return {

		Set = Set,

		Get = function()

			return Enabled

		end
	}

end

------------------------------------------------------------
-- CYCLE BUTTON
------------------------------------------------------------

local function CreateCycleButton(
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
			132,
			39
		)

	Button.BackgroundColor3 =
		C.Control

	Button.BorderSizePixel =
		0

	Button.Text =
		Text

	Button.TextColor3 =
		C.Text

	Button.TextSize =
		9

	Button.FontFace =
		FONT_BOLD

	Button.AutoButtonColor =
		false

	Button.ZIndex =
		30

	Button.Parent =
		Card

	Corner(
		Button,
		9
	)

	Stroke(
		Button,
		C.Stroke,
		1,
		0
	)

	return Button

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
	ElevatorTitle,
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

ElevatorControls.ZIndex =
	30

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

Minus.BackgroundColor3 =
	C.Control

Minus.BorderSizePixel =
	0

Minus.Text =
	"−"

Minus.TextColor3 =
	C.Text

Minus.TextSize =
	23

Minus.FontFace =
	FONT_BOLD

Minus.AutoButtonColor =
	false

Minus.ZIndex =
	31

Minus.Parent =
	ElevatorControls

Corner(
	Minus,
	9
)

Stroke(
	Minus,
	C.Stroke,
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

LevelHolder.BackgroundColor3 =
	C.White

LevelHolder.BorderSizePixel =
	0

LevelHolder.ZIndex =
	31

LevelHolder.Parent =
	ElevatorControls

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

LevelText.ZIndex =
	32

LevelText.Parent =
	LevelHolder

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

Plus.BackgroundColor3 =
	C.Accent

Plus.BorderSizePixel =
	0

Plus.Text =
	"+"

Plus.TextColor3 =
	C.White

Plus.TextSize =
	23

Plus.FontFace =
	FONT_BOLD

Plus.AutoButtonColor =
	false

Plus.ZIndex =
	31

Plus.Parent =
	ElevatorControls

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
			PlatformLevel
		)

	if not Platform then

		ElevatorDescription.Text =
			"Desativado"

	else

		local Height =
			math.max(

				PlatformLevel - 1,

				0

			)

			* CONFIG.StepHeight

		ElevatorDescription.Text =
			"Nível "
			.. PlatformLevel
			.. " • "
			.. string.format(
				"%.1f studs",
				Height
			)
			.. " • estabilizador ON"

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

		----------------------------------------------------
		-- PRIMEIRO +
		----------------------------------------------------

		if not Platform then

			CreatePlatform()

			PlatformLevel =
				1

			PlatformTargetY =
				PlatformBaseY

			UpdateElevatorUI()

			return

		end

		----------------------------------------------------

		if PlatformLevel >=
			CONFIG.MaxLevel
		then

			return

		end

		PlatformLevel +=
			1

		PlatformTargetY =
			PlatformBaseY

			+ (

				PlatformLevel - 1

			)

			* CONFIG.StepHeight

		UpdateElevatorUI()

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

		if PlatformLevel > 1 then

			PlatformLevel -=
				1

			PlatformTargetY =
				PlatformBaseY

				+ (

					PlatformLevel - 1

				)

				* CONFIG.StepHeight

		else

			RemovePlatform()

		end

		UpdateElevatorUI()

	end
)

------------------------------------------------------------
-- TP FROM
------------------------------------------------------------

local TPCard,
	TPTitle,
	TPDescription =
	CreateCard(

		PrincipalPage,

		"TP FROM",

		"Atravessa a parede que estiver na sua frente"
	)

local TPButton,
	TPStroke =
	CreateActionButton(
		TPCard,
		"ATRAVESSAR"
	)

------------------------------------------------------------

TPButton.MouseButton1Click:Connect(
	function()

		TPButton.Text =
			"PROCURANDO"

		local Success,
			Message =
			TPFrom()

		if Success then

			TPButton.Text =
				"FEITO"

			TPButton.TextColor3 =
				C.Green

			TPStroke.Color =
				C.Green

		else

			TPButton.Text =
				"SEM PAREDE"

			TPButton.TextColor3 =
				C.Red

			TPStroke.Color =
				C.Red

		end

		TPDescription.Text =
			Message

		task.delay(
			1.1,
			function()

				if not TPButton.Parent then
					return
				end

				TPButton.Text =
					"ATRAVESSAR"

				TPButton.TextColor3 =
					C.Text

				TPStroke.Color =
					C.Stroke

			end
		)

	end
)

------------------------------------------------------------
-- DESCNY
------------------------------------------------------------

CreateSection(
	PrincipalPage,
	"Utilidades"
)

------------------------------------------------------------

local DescnyCard,
	DescnyTitle,
	DescnyDescription =
	CreateCard(

		PrincipalPage,

		"DESCNY",

		"Procura sua capa/item de invisibilidade"
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
				C.Green

			DescnyStroke.Color =
				C.Green

			DescnyDescription.Text =
				"Usando "
				.. tostring(
					Message
				)

		else

			DescnyButton.Text =
				"NÃO ACHOU"

			DescnyButton.TextColor3 =
				C.Red

			DescnyStroke.Color =
				C.Red

			DescnyDescription.Text =
				Message

		end

		task.delay(
			1.2,
			function()

				if not DescnyButton.Parent then
					return
				end

				DescnyButton.Text =
					"ATIVAR"

				DescnyButton.TextColor3 =
					C.Text

				DescnyStroke.Color =
					C.Stroke

			end
		)

	end
)

------------------------------------------------------------
-- ANTILAG
------------------------------------------------------------

local AntiLagCard,
	AntiLagTitle,
	AntiLagDescription =
	CreateCard(

		PrincipalPage,

		"AntiLag",

		"OFF • toque para mudar o nível"
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

		if Next == 0 then

			AntiLagButton.TextColor3 =
				C.Text

			AntiLagDescription.Text =
				"OFF • efeitos restaurados"

		elseif Next == 1 then

			AntiLagButton.TextColor3 =
				C.Green

			AntiLagDescription.Text =
				"LEVE • sombras e pós-processamento reduzidos"

		elseif Next == 2 then

			AntiLagButton.TextColor3 =
				C.Blue

			AntiLagDescription.Text =
				"MÉDIO • partículas e luzes reduzidas"

		else

			AntiLagButton.TextColor3 =
				C.Accent

			AntiLagDescription.Text =
				"MÁXIMO • otimização agressiva para mobile"

		end

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
	XRayTitle,
	XRayDescription =
	CreateCard(

		VisualPage,

		"XRay",

		"Deixa o mapa transparente e mantém players visíveis"
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
					"Ativado • transparência "
					.. math.floor(
						CONFIG.XRayTransparency * 100
					)
					.. "%"

			else

				DisableXRay()

				XRayDescription.Text =
					"Deixa o mapa transparente e mantém players visíveis"

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

local LineCard,
	LineTitle,
	LineDescription =
	CreateCard(

		VisualPage,

		"ESP Line",

		"Linha da parte inferior da tela até o jogador"
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

local BoxCard,
	BoxTitle,
	BoxDescription =
	CreateCard(

		VisualPage,

		"ESP Box",

		"Caixa acompanhando o personagem"
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

local ChamsCard,
	ChamsTitle,
	ChamsDescription =
	CreateCard(

		VisualPage,

		"Chams",

		"Highlight visível através das paredes"
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
-- ESP FILTER
------------------------------------------------------------

local FilterCard,
	FilterTitle,
	FilterDescription =
	CreateCard(

		VisualPage,

		"Categoria ESP",

		"Escolha quais jogadores aparecem"
	)

local FilterButton =
	CreateCycleButton(
		FilterCard,
		"TODOS"
	)

------------------------------------------------------------

local FilterModes = {

	"Todos",

	"Mesmo Time",

	"Outros Times"
}

local FilterIndex =
	1

------------------------------------------------------------

FilterButton.MouseButton1Click:Connect(
	function()

		FilterIndex +=
			1

		if FilterIndex >
			#FilterModes
		then

			FilterIndex =
				1

		end

		ESPFilter =
			FilterModes[
				FilterIndex
			]

		FilterButton.Text =
			string.upper(
				ESPFilter
			)

		FilterDescription.Text =
			"Filtro atual: "
			.. ESPFilter

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
-- REMOVE PLATFORM
------------------------------------------------------------

local RemovePlatformCard,
	RemovePlatformTitle,
	RemovePlatformDesc =
	CreateCard(

		MiscPage,

		"Remover Plataforma",

		"Desliga o elevador imediatamente"
	)

local RemovePlatformButton =
	CreateActionButton(
		RemovePlatformCard,
		"REMOVER"
	)

RemovePlatformButton.MouseButton1Click:Connect(
	function()

		RemovePlatform()

		UpdateElevatorUI()

	end
)

------------------------------------------------------------
-- DISABLE VISUALS
------------------------------------------------------------

local DisableVisualCard,
	DisableVisualTitle,
	DisableVisualDesc =
	CreateCard(

		MiscPage,

		"Desligar Visuais",

		"Desativa XRay, Line, Box e Chams"
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
-- PLAYER INFO
------------------------------------------------------------

local InfoCard,
	InfoTitle,
	InfoDescription =
	CreateCard(

		MiscPage,

		"Jogador",

		Player.DisplayName
		.. " • @"
		.. Player.Name
	)

------------------------------------------------------------
-- ========================================================
-- AJUSTES
-- ========================================================
------------------------------------------------------------

CreateSection(
	SettingsPage,
	"ESP"
)

------------------------------------------------------------
-- ESP DISTANCE
------------------------------------------------------------

local DistanceCard,
	DistanceTitle,
	DistanceDescription =
	CreateCard(

		SettingsPage,

		"Distância ESP",

		tostring(
			CONFIG.ESPDistance
		)
		.. " studs"
	)

local DistanceButton =
	CreateCycleButton(
		DistanceCard,
		"450"
	)

------------------------------------------------------------

local ESPDistances = {

	150,

	300,

	450,

	700
}

local ESPDistanceIndex =
	3

------------------------------------------------------------

DistanceButton.MouseButton1Click:Connect(
	function()

		ESPDistanceIndex +=
			1

		if ESPDistanceIndex >
			#ESPDistances
		then

			ESPDistanceIndex =
				1

		end

		CONFIG.ESPDistance =
			ESPDistances[
				ESPDistanceIndex
			]

		DistanceButton.Text =
			tostring(
				CONFIG.ESPDistance
			)

		DistanceDescription.Text =
			tostring(
				CONFIG.ESPDistance
			)
			.. " studs"

	end
)

------------------------------------------------------------
-- XRAY POWER
------------------------------------------------------------

local XRayPowerCard,
	XRayPowerTitle,
	XRayPowerDescription =
	CreateCard(

		SettingsPage,

		"Força XRay",

		"72%"
	)

local XRayPowerButton =
	CreateCycleButton(
		XRayPowerCard,
		"72%"
	)

------------------------------------------------------------

local XRayValues = {

	0.55,

	0.72,

	0.84
}

local XRayValueIndex =
	2

------------------------------------------------------------

XRayPowerButton.MouseButton1Click:Connect(
	function()

		XRayValueIndex +=
			1

		if XRayValueIndex >
			#XRayValues
		then

			XRayValueIndex =
				1

		end

		CONFIG.XRayTransparency =
			XRayValues[
				XRayValueIndex
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

------------------------------------------------------------
-- SWITCH PAGE
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
			PageName == Name

	end

	--------------------------------------------------------

	for ButtonName,
		Data
		in pairs(
			NavButtons
		)
	do

		local Active =
			ButtonName == Name

		Tween(
			Data.Button,
			0.15,
			{
				BackgroundTransparency =
					Active
					and 0
					or 1
			}
		)

		Data.Bar.Visible =
			Active

		Data.Icon.TextColor3 =
			Active
			and C.Accent
			or C.Sub

		Data.Text.TextColor3 =
			Active
			and C.Text
			or C.Sub

	end

	--------------------------------------------------------

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
-- CREATE NAV
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

	Button.BackgroundColor3 =
		Color3.fromRGB(
			14,
			21,
			31
		)

	Button.BackgroundTransparency =
		1

	Button.BorderSizePixel =
		0

	Button.Text =
		""

	Button.AutoButtonColor =
		false

	Button.ZIndex =
		25

	Button.Parent =
		Navigation

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

	Bar.BackgroundColor3 =
		C.Accent

	Bar.BorderSizePixel =
		0

	Bar.Visible =
		false

	Bar.ZIndex =
		26

	Bar.Parent =
		Button

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

	Icon.TextColor3 =
		C.Sub

	Icon.TextSize =
		20

	Icon.FontFace =
		FONT_BOLD

	Icon.ZIndex =
		26

	Icon.Parent =
		Button

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

	Text.TextColor3 =
		C.Sub

	Text.TextSize =
		12

	Text.FontFace =
		FONT_MEDIUM

	Text.TextXAlignment =
		Enum.TextXAlignment.Left

	Text.ZIndex =
		26

	Text.Parent =
		Button

	--------------------------------------------------------

	NavButtons[
		Name
	] = {

		Button = Button,

		Bar = Bar,

		Icon = Icon,

		Text = Text
	}

	--------------------------------------------------------

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

	local Viewport =
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

				Viewport.X
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

				Viewport.Y
					- Height
					- 5

			)
		)

	return X,
		Y

end

------------------------------------------------------------
-- MAKE DRAGGABLE
------------------------------------------------------------

local function MakeTouchDraggable(
	Handle,
	Target,
	TapCallback
)

	local Dragging =
		false

	local Moved =
		false

	local InputObject =
		nil

	local StartPointer =
		nil

	local StartPosition =
		nil

	local Threshold =
		7

	--------------------------------------------------------
	-- BEGIN
	--------------------------------------------------------

	Handle.InputBegan:Connect(
		function(Input)

			if
				Input.UserInputType
					~= Enum.UserInputType.Touch

				and

				Input.UserInputType
					~= Enum.UserInputType.MouseButton1
			then

				return

			end

			Dragging =
				true

			Moved =
				false

			InputObject =
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
				or not InputObject
			then

				return

			end

			local Pointer

			------------------------------------------------
			-- TOUCH
			------------------------------------------------

			if InputObject.UserInputType ==
				Enum.UserInputType.Touch
			then

				if Input
					~= InputObject
				then

					return

				end

				Pointer =
					Input.Position

			------------------------------------------------
			-- MOUSE
			------------------------------------------------

			else

				if Input.UserInputType
					~= Enum.UserInputType.MouseMovement
				then

					return

				end

				Pointer =
					UIS:GetMouseLocation()

			end

			------------------------------------------------

			local Delta =
				Pointer
				- StartPointer

			if Delta.Magnitude >
				Threshold
			then

				Moved =
					true

			end

			if not Moved then
				return
			end

			------------------------------------------------

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
	-- FINISH
	--------------------------------------------------------

	UIS.InputEnded:Connect(
		function(Input)

			if not Dragging
				or not InputObject
			then

				return

			end

			local Correct =
				false

			if InputObject.UserInputType ==
				Enum.UserInputType.Touch
			then

				Correct =
					Input
					== InputObject

			else

				Correct =
					Input.UserInputType
					== Enum.UserInputType.MouseButton1

			end

			if not Correct then
				return
			end

			Dragging =
				false

			InputObject =
				nil

			------------------------------------------------

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

MakeTouchDraggable(

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
		18,
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
		C.Accent,
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

FloatingFallback.TextColor3 =
	C.Accent

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

------------------------------------------------------------
-- MINIMIZE STATE
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
	function()

		MinimizeUI()

	end
)

------------------------------------------------------------
-- FLOATING DRAG + TAP
------------------------------------------------------------

MakeTouchDraggable(

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
-- INITIAL
------------------------------------------------------------

SwitchPage(
	"Principal"
)

UpdateElevatorUI()
