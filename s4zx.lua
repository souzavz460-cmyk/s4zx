--[[
    BLOCO ELEVADOR
    LocalScript
    StarterPlayer > StarterPlayerScripts

    + = sobe 1 altura do personagem
    - = desce 1 altura do personagem
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- CONFIG
--------------------------------------------------

local LOGO = "rbxassetid://98880379063768"

local BLOCK_SIZE = Vector3.new(7, 1, 7)

-- multiplicador da altura do personagem por clique
local HEIGHT_MULTIPLIER = 1

--------------------------------------------------
-- VARIÁVEIS
--------------------------------------------------

local character
local root
local humanoid

local block
local currentLevel = 0

--------------------------------------------------
-- CHARACTER
--------------------------------------------------

local function getCharacter()
	character = player.Character or player.CharacterAdded:Wait()

	root = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")
end

getCharacter()

player.CharacterAdded:Connect(function()
	task.wait(0.5)

	getCharacter()

	currentLevel = 0

	if block then
		block:Destroy()
		block = nil
	end
end)

--------------------------------------------------
-- ALTURA DO PERSONAGEM
--------------------------------------------------

local function getCharacterHeight()
	if not character then
		return 5
	end

	local _, size = character:GetBoundingBox()

	return math.max(size.Y, 4)
end

--------------------------------------------------
-- BLOCO
--------------------------------------------------

local function createBlock()
	if block and block.Parent then
		return block
	end

	block = Instance.new("Part")
	block.Name = "PlayerElevatorBlock"

	block.Size = BLOCK_SIZE

	block.Anchored = true
	block.CanCollide = true
	block.CanTouch = true
	block.CanQuery = true

	block.Material = Enum.Material.SmoothPlastic
	block.Color = Color3.fromRGB(30, 30, 38)

	block.TopSurface = Enum.SurfaceType.Smooth
	block.BottomSurface = Enum.SurfaceType.Smooth

	block.Parent = workspace

	return block
end

--------------------------------------------------
-- POSIÇÃO BASE
--------------------------------------------------

local function getBasePosition()
	if not root then
		return Vector3.zero
	end

	local blockHeight = BLOCK_SIZE.Y / 2

	-- deixa o bloco logo abaixo dos pés
	return Vector3.new(
		root.Position.X,
		root.Position.Y - humanoid.HipHeight - 3 + blockHeight,
		root.Position.Z
	)
end

--------------------------------------------------
-- MOVER BLOCO
--------------------------------------------------

local function updateBlock()
	if not root then
		return
	end

	local platform = createBlock()

	local characterHeight = getCharacterHeight()

	local basePosition = getBasePosition()

	local targetPosition =
		basePosition
		+ Vector3.new(
			0,
			currentLevel * characterHeight * HEIGHT_MULTIPLIER,
			0
		)

	local tween = TweenService:Create(
		platform,
		TweenInfo.new(
			0.28,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out
		),
		{
			Position = targetPosition
		}
	)

	tween:Play()
end

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "BlockElevatorUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

--------------------------------------------------
-- MAIN
--------------------------------------------------

local main = Instance.new("Frame")

main.Size = UDim2.fromOffset(190, 72)

main.Position = UDim2.new(
	0.5,
	-95,
	0.78,
	0
)

main.BackgroundColor3 = Color3.fromRGB(13, 13, 18)

main.BorderSizePixel = 0

main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")

stroke.Color = Color3.fromRGB(75, 75, 100)
stroke.Thickness = 1

stroke.Parent = main

--------------------------------------------------
-- LOGO
--------------------------------------------------

local logo = Instance.new("ImageLabel")

logo.Size = UDim2.fromOffset(48, 48)

logo.Position = UDim2.fromOffset(12, 12)

logo.BackgroundTransparency = 1

logo.Image = LOGO

logo.ScaleType = Enum.ScaleType.Fit

logo.Parent = main

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(1, 0)
logoCorner.Parent = logo

--------------------------------------------------
-- BOTÃO MENOS
--------------------------------------------------

local minus = Instance.new("TextButton")

minus.Size = UDim2.fromOffset(48, 48)

minus.Position = UDim2.fromOffset(73, 12)

minus.BackgroundColor3 = Color3.fromRGB(28, 28, 38)

minus.BorderSizePixel = 0

minus.Text = "−"

minus.TextColor3 = Color3.fromRGB(245, 245, 250)

minus.TextSize = 32

minus.Font = Enum.Font.GothamBold

minus.AutoButtonColor = false

minus.Parent = main

local minusCorner = Instance.new("UICorner")
minusCorner.CornerRadius = UDim.new(0, 12)
minusCorner.Parent = minus

--------------------------------------------------
-- BOTÃO MAIS
--------------------------------------------------

local plus = Instance.new("TextButton")

plus.Size = UDim2.fromOffset(48, 48)

plus.Position = UDim2.fromOffset(130, 12)

plus.BackgroundColor3 = Color3.fromRGB(115, 80, 255)

plus.BorderSizePixel = 0

plus.Text = "+"

plus.TextColor3 = Color3.fromRGB(255, 255, 255)

plus.TextSize = 30

plus.Font = Enum.Font.GothamBold

plus.AutoButtonColor = false

plus.Parent = main

local plusCorner = Instance.new("UICorner")
plusCorner.CornerRadius = UDim.new(0, 12)
plusCorner.Parent = plus

--------------------------------------------------
-- ANIMAÇÃO BOTÃO
--------------------------------------------------

local function buttonPress(button)
	local originalSize = button.Size

	TweenService:Create(
		button,
		TweenInfo.new(0.07),
		{
			Size = UDim2.fromOffset(
				originalSize.X.Offset - 4,
				originalSize.Y.Offset - 4
			)
		}
	):Play()

	task.delay(0.07, function()

		TweenService:Create(
			button,
			TweenInfo.new(0.12),
			{
				Size = originalSize
			}
		):Play()

	end)
end

--------------------------------------------------
-- +
--------------------------------------------------

plus.MouseButton1Click:Connect(function()

	buttonPress(plus)

	currentLevel += 1

	updateBlock()

end)

--------------------------------------------------
-- -
--------------------------------------------------

minus.MouseButton1Click:Connect(function()

	buttonPress(minus)

	currentLevel -= 1

	updateBlock()

end)

--------------------------------------------------
-- CRIA PRIMEIRO BLOCO
--------------------------------------------------

updateBlock()
