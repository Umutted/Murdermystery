print("script ready")
local replicated = game:GetService("ReplicatedStorage")

local remotesfolder = replicated:FindFirstChild("Remotes")

if not remotesfolder then print("no remotes folder found") return end

local gameplayfolder = remotesfolder:FindFirstChild("Gameplay")

if not gameplayfolder then print("no gameplay folder found") return end

local faderemote = gameplayfolder:FindFirstChild("Fade")

local roundendfaderemote = gameplayfolder:FindFirstChild("RoundEndFade")

-- Gui to Lua
-- Version: 3.2

-- Instances:

local hxk = Instance.new("ScreenGui")
local Murderer = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local Sherrif = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")

--Properties:

-- Gui to Lua
-- Version: 3.2

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

--Properties:

hxk.Name = "hxk"
hxk.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
hxk.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Murderer.Name = "Murderer"
Murderer.Parent = hxk
Murderer.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Murderer.BackgroundTransparency = 0.500
Murderer.BorderColor3 = Color3.fromRGB(0, 0, 0)
Murderer.BorderSizePixel = 0
Murderer.Position = UDim2.new(0.0124917813, 0, 0.0136674261, 0)
Murderer.Size = UDim2.new(0.131492436, 0, 0.0569476075, 0)
Murderer.Font = Enum.Font.SourceSans
Murderer.Text = ""
Murderer.TextColor3 = Color3.fromRGB(255, 255, 255)
Murderer.TextScaled = true
Murderer.TextSize = 14.000
Murderer.TextWrapped = true

UICorner.Parent = Murderer

Sherrif.Name = "Sherrif"
Sherrif.Parent = hxk
Sherrif.BackgroundColor3 = Color3.fromRGB(0, 26, 255)
Sherrif.BackgroundTransparency = 0.500
Sherrif.BorderColor3 = Color3.fromRGB(0, 0, 0)
Sherrif.BorderSizePixel = 0
Sherrif.Position = UDim2.new(0.0124917813, 0, 0.0876993164, 0)
Sherrif.Size = UDim2.new(0.131492436, 0, 0.0569476075, 0)
Sherrif.Font = Enum.Font.SourceSans
Sherrif.Text = ""
Sherrif.TextColor3 = Color3.fromRGB(255, 255, 255)
Sherrif.TextScaled = true
Sherrif.TextSize = 14.000
Sherrif.TextWrapped = true

UICorner_2.Parent = Sherrif

Tpgun.Name = "Tpgun"
Tpgun.Parent = hxk
Tpgun.BackgroundColor3 = Color3.fromRGB(0, 255, 21)
Tpgun.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tpgun.BorderSizePixel = 0
Tpgun.Position = UDim2.new(0.176857337, 0, 0.0136674261, 0)
Tpgun.Size = UDim2.new(0.131492436, 0, 0.0569476075, 0)
Tpgun.Font = Enum.Font.Cartoon
Tpgun.Text = "Teleport To Gun"
Tpgun.TextColor3 = Color3.fromRGB(255, 255, 255)
Tpgun.TextScaled = true
Tpgun.TextSize = 14.000
Tpgun.TextWrapped = true
Tpgun.Visible = false


UICorner1.Name = "UICorner1"
UICorner1.Parent = Tpgun

Distance.Name = "Distance"
Distance.Parent = hxk
Distance.BackgroundColor3 = Color3.fromRGB(0, 26, 255)
Distance.BackgroundTransparency = 1.000
Distance.BorderColor3 = Color3.fromRGB(0, 0, 0)
Distance.BorderSizePixel = 0
Distance.Position = UDim2.new(0.0124917813, 0, 0.165148094, 0)
Distance.Size = UDim2.new(0.131492436, 0, 0.0569476075, 0)
Distance.Font = Enum.Font.Cartoon
Distance.Text = "349M"
Distance.TextColor3 = Color3.fromRGB(255, 255, 255)
Distance.TextScaled = true
Distance.TextSize = 14.000
Distance.TextWrapped = true

UICorner_3.Parent = Distance

print("gui hxk ready")


-- ----------------------------------------------------------------------------
local RoleGui = Instance.new("BillboardGui")
local Role = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")

--Properties:

RoleGui.Name = "RoleGui"
RoleGui.Parent = replicated
RoleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
RoleGui.Active = true
RoleGui.AlwaysOnTop = true
RoleGui.LightInfluence = 1.000
RoleGui.Size = UDim2.new(5, 0, 2, 0)
RoleGui.ResetOnSpawn = true
Role.Name = "Role"
Role.Parent = RoleGui
Role.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Role.BackgroundTransparency = 1.000
Role.BorderColor3 = Color3.fromRGB(0, 0, 0)
Role.BorderSizePixel = 0
Role.Position = UDim2.new(0, 0, -0.670000017, 0)
Role.Size = UDim2.new(1.0869565, 0, 0.684931517, 0)
Role.Font = Enum.Font.Cartoon
Role.Text = "Murderer"
Role.TextColor3 = Color3.fromRGB(255, 0, 4)
Role.TextScaled = true
Role.TextSize = 14.000
Role.TextWrapped = true

UICorner.Parent = Role

print("bb gui ready")

faderemote.OnClientEvent:Connect(function(data)
	
	print("remote geldi")
	local currentMurderer = ""
	local currentSherrif = ""
	for name, playerdata in data do
		if playerdata.Role == "Murderer" then
			currentMurderer = name
			Murderer.Text = name
			local newgui = replicated:FindFirstChild("RoleGui"):Clone()
			newgui.Parent = game.Workspace:FindFirstChild(name):FindFirstChild("Head")
			newgui.Enabled = true
			
			local roletext = newgui:FindFirstChild("Role")
			roletext.TextColor3 = Color3.fromRGB(255, 0, 4)
			roletext.Text = "Murderer"
		end
		
		if playerdata.Role == "Sheriff" then
			local humanoid = game.Workspace:FindFirstChild(name):FindFirstChild("Humanoid")
			currentSherrif = name
			Sherrif.Text = name
			local newgui = replicated:FindFirstChild("RoleGui"):Clone()
			newgui.Parent = game.Workspace:FindFirstChild(name):FindFirstChild("Head")
			newgui.Enabled = true

			local roletext = newgui:FindFirstChild("Role")
			roletext.TextColor3 = Color3.fromRGB(0, 255, 213)
			roletext.Text = "Sherrif"
		end
		
		
		if currentMurderer ~= "" and currentSherrif ~= "" then
			break
		end
		
		if currentMurderer ~= game.Players.LocalPlayer.Name then
			Distance.Visible = true
			
			
			
		end
		
	end
	
	while currentMurderer ~= "" do
		local distance = (game.Workspace:FindFirstChild(currentMurderer).HumanoidRootPart.Position - game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.HumanoidRootPart.Position).Magnitude())
		Distance.Text = math.floor(distance)
		wait(0.5)
	end
	
	workspace.DescendantAdded:Connect(function(obj)
		
		if obj.Name == "GunDrop" then
			
			Tpgun.Visible = true
			Tpgun.MouseButton1Click:Connect(function()
				local plr = game.Players.LocalPlayer
				
				plr.Character.HumanoidRootPart.CFrame = obj.CFrame
				
			end)
			
		end
		
	end)
	
	
	roundendfaderemote.OnClientEvent:Connect(function()
		currentMurderer = ""
		currentSherrif = ""
		Tpgun.Visible = false
		Distance.Visible = false
		
	end)
	
	
end)
