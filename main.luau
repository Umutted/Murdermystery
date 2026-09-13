local replicated = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local remotesfolder = replicated:FindFirstChild("Remotes")
if not remotesfolder then print("no remotes folder found") return end

local gameplayfolder = remotesfolder:FindFirstChild("Gameplay")
if not gameplayfolder then print("no gameplay folder found") return end

local faderemote = gameplayfolder:FindFirstChild("Fade")
local roundendfaderemote = gameplayfolder:FindFirstChild("RoundEndFade")

-- Instances:

local hxk = Instance.new("ScreenGui")
local Murderer = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local Sherrif = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local Tpgun = Instance.new("TextButton")
local UICorner1 = Instance.new("UICorner")
local Distance = Instance.new("TextLabel")
local UICorner_3 = Instance.new("UICorner")

-- Properties:

hxk.Name = "hxk"
hxk.Parent = LocalPlayer:WaitForChild("PlayerGui")
hxk.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Murderer.Name = "Murderer"
Murderer.Parent = hxk
Murderer.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Murderer.BackgroundTransparency = 0.5
Murderer.BorderSizePixel = 0
Murderer.Position = UDim2.new(0.0124917813, 0, 0.0136674261, 0)
Murderer.Size = UDim2.new(0.131492436, 0, 0.0569476075, 0)
Murderer.Font = Enum.Font.SourceSans
Murderer.Text = ""
Murderer.TextColor3 = Color3.fromRGB(255, 255, 255)
Murderer.TextScaled = true
Murderer.TextWrapped = true
UICorner.Parent = Murderer

Sherrif.Name = "Sherrif"
Sherrif.Parent = hxk
Sherrif.BackgroundColor3 = Color3.fromRGB(0, 26, 255)
Sherrif.BackgroundTransparency = 0.5
Sherrif.BorderSizePixel = 0
Sherrif.Position = UDim2.new(0.0124917813, 0, 0.0876993164, 0)
Sherrif.Size = UDim2.new(0.131492436, 0, 0.0569476075, 0)
Sherrif.Font = Enum.Font.SourceSans
Sherrif.Text = ""
Sherrif.TextColor3 = Color3.fromRGB(255, 255, 255)
Sherrif.TextScaled = true
Sherrif.TextWrapped = true
UICorner_2.Parent = Sherrif

Tpgun.Name = "Tpgun"
Tpgun.Parent = hxk
Tpgun.BackgroundColor3 = Color3.fromRGB(0, 255, 21)
Tpgun.BorderSizePixel = 0
Tpgun.Position = UDim2.new(0.176857337, 0, 0.0136674261, 0)
Tpgun.Size = UDim2.new(0.131492436, 0, 0.0569476075, 0)
Tpgun.Font = Enum.Font.Cartoon
Tpgun.Text = "Teleport To Gun"
Tpgun.TextColor3 = Color3.fromRGB(255, 255, 255)
Tpgun.TextScaled = true
Tpgun.TextWrapped = true
Tpgun.Visible = false
UICorner1.Name = "UICorner1"
UICorner1.Parent = Tpgun

Distance.Name = "Distance"
Distance.Parent = hxk
Distance.BackgroundColor3 = Color3.fromRGB(0, 26, 255)
Distance.BackgroundTransparency = 1
Distance.BorderSizePixel = 0
Distance.Position = UDim2.new(0.0124917813, 0, 0.165148094, 0)
Distance.Size = UDim2.new(0.131492436, 0, 0.0569476075, 0)
Distance.Font = Enum.Font.Cartoon
Distance.Text = "0M"
Distance.TextColor3 = Color3.fromRGB(255, 255, 255)
Distance.TextScaled = true
Distance.TextWrapped = true
UICorner_3.Parent = Distance

-- ----------------------------------------------------------------------------
local RoleGuiTemplate = Instance.new("BillboardGui")
local Role = Instance.new("TextLabel")
local UICornerRole = Instance.new("UICorner")

RoleGuiTemplate.Name = "RoleGui"
RoleGuiTemplate.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
RoleGuiTemplate.Active = true
RoleGuiTemplate.AlwaysOnTop = true
RoleGuiTemplate.LightInfluence = 1
RoleGuiTemplate.Size = UDim2.new(5, 0, 2, 0)
RoleGuiTemplate.ResetOnSpawn = true

Role.Name = "Role"
Role.Parent = RoleGuiTemplate
Role.BackgroundTransparency = 1
Role.BorderSizePixel = 0
Role.Position = UDim2.new(0, 0, -0.67, 0)
Role.Size = UDim2.new(1.0869565, 0, 0.684931517, 0)
Role.Font = Enum.Font.Cartoon
Role.Text = "Murderer"
Role.TextColor3 = Color3.fromRGB(255, 0, 4)
Role.TextScaled = true
Role.TextWrapped = true
UICornerRole.Parent = Role

-- State (module-level, shared across all callbacks below)
local currentMurderer = ""
local currentSherrif = ""
local distanceTrackerRunning = false

local function startDistanceTracker()
	if distanceTrackerRunning then return end
	distanceTrackerRunning = true

	task.spawn(function()
		while currentMurderer ~= "" do
			local murdererChar = Workspace:FindFirstChild(currentMurderer)
			local myChar = LocalPlayer.Character

			if murdererChar and myChar
				and murdererChar:FindFirstChild("HumanoidRootPart")
				and myChar:FindFirstChild("HumanoidRootPart") then

				local distance = (murdererChar.HumanoidRootPart.Position - myChar.HumanoidRootPart.Position).Magnitude
				Distance.Text = math.floor(distance) .. "M"
			end

			task.wait(0.5)
		end
		distanceTrackerRunning = false
	end)
end

faderemote.OnClientEvent:Connect(function(data)
	currentMurderer = ""
	currentSherrif = ""

	for name, playerData in data do
		if playerData.Role == "Murderer" then
			currentMurderer = name
			Murderer.Text = name
		elseif playerData.Role == "Sheriff" then
			currentSherrif = name
			Sherrif.Text = name
		end

		if playerData.Role == "Murderer" or playerData.Role == "Sheriff" then
			task.spawn(function()
				local targetPlayer = Players:FindFirstChild(name)
				if targetPlayer then
					local char = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
					local head = char:WaitForChild("Head", 5)

					if head then
						local oldGui = head:FindFirstChild("RoleGui")
						if oldGui then oldGui:Destroy() end

						local newgui = RoleGuiTemplate:Clone()
						if playerData.Role == "Murderer" then
							newgui.Role.TextColor3 = Color3.fromRGB(255, 0, 4)
							newgui.Role.Text = "Murderer"
						else
							newgui.Role.TextColor3 = Color3.fromRGB(0, 255, 213)
							newgui.Role.Text = "Sheriff"
						end
						newgui.Parent = head
					end
				end
			end)
		end
	end

	startDistanceTracker()
end)

workspace.DescendantAdded:Connect(function(obj)
	if obj.Name == "GunDrop" then
		Tpgun.Visible = true

		Tpgun.MouseButton1Click:Connect(function()
			local plr = LocalPlayer
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				plr.Character.HumanoidRootPart.CFrame = obj.CFrame
			end
		end)
	end
end)

roundendfaderemote.OnClientEvent:Connect(function()
	currentMurderer = ""
	currentSherrif = ""
	Tpgun.Visible = false
	Distance.Visible = false
end)
