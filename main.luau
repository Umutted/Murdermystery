local replicated = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local workspace = game:GetService("Workspace")

local remotesfolder = replicated:FindFirstChild("Remotes")
if not remotesfolder then print("no remotes folder found") return end

local gameplayfolder = remotesfolder:FindFirstChild("Gameplay")
if not gameplayfolder then print("no gameplay folder found") return end

local faderemote = gameplayfolder:FindFirstChild("Fade")
local roundendfaderemote = gameplayfolder:FindFirstChild("RoundEndFade")

local localPlayer = players.LocalPlayer

-- GUI Oluşturma
local hxk = Instance.new("ScreenGui")
hxk.Name = "hxk"
hxk.Parent = localPlayer:WaitForChild("PlayerGui")
hxk.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Murderer = Instance.new("TextLabel")
Murderer.Name = "Murderer"
Murderer.Parent = hxk
Murderer.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Murderer.BackgroundTransparency = 0.500
Murderer.Position = UDim2.new(0.012, 0, 0.013, 0)
Murderer.Size = UDim2.new(0.131, 0, 0.056, 0)
Murderer.Font = Enum.Font.SourceSans
Murderer.Text = ""
Murderer.TextColor3 = Color3.fromRGB(255, 255, 255)
Murderer.TextScaled = true
Instance.new("UICorner", Murderer)

local Sherrif = Instance.new("TextLabel")
Sherrif.Name = "Sherrif"
Sherrif.Parent = hxk
Sherrif.BackgroundColor3 = Color3.fromRGB(0, 26, 255)
Sherrif.BackgroundTransparency = 0.500
Sherrif.Position = UDim2.new(0.012, 0, 0.087, 0)
Sherrif.Size = UDim2.new(0.131, 0, 0.056, 0)
Sherrif.Font = Enum.Font.SourceSans
Sherrif.Text = ""
Sherrif.TextColor3 = Color3.fromRGB(255, 255, 255)
Sherrif.TextScaled = true
Instance.new("UICorner", Sherrif)

local Tpgun = Instance.new("TextButton")
Tpgun.Name = "Tpgun"
Tpgun.Parent = hxk
Tpgun.BackgroundColor3 = Color3.fromRGB(0, 255, 21)
Tpgun.Position = UDim2.new(0.176, 0, 0.013, 0)
Tpgun.Size = UDim2.new(0.131, 0, 0.056, 0)
Tpgun.Font = Enum.Font.Cartoon
Tpgun.Text = "Teleport To Gun"
Tpgun.TextColor3 = Color3.fromRGB(255, 255, 255)
Tpgun.TextScaled = true
Tpgun.Visible = false
Instance.new("UICorner", Tpgun)

local Distance = Instance.new("TextLabel")
Distance.Name = "Distance"
Distance.Parent = hxk
Distance.BackgroundTransparency = 1
Distance.Position = UDim2.new(0.012, 0, 0.165, 0)
Distance.Size = UDim2.new(0.131, 0, 0.056, 0)
Distance.Font = Enum.Font.Cartoon
Distance.Text = ""
Distance.TextColor3 = Color3.fromRGB(255, 255, 255)
Distance.TextScaled = true
Distance.Visible = false

-- ESP Template
local RoleGui = Instance.new("BillboardGui")
RoleGui.Name = "RoleGui"
RoleGui.Parent = replicated
RoleGui.AlwaysOnTop = true
RoleGui.Size = UDim2.new(5, 0, 2, 0)

local Role = Instance.new("TextLabel")
Role.Name = "Role"
Role.Parent = RoleGui
Role.BackgroundTransparency = 1
Role.Size = UDim2.new(1, 0, 1, 0)
Role.Font = Enum.Font.Cartoon
Role.TextScaled = true

-- Sistem Değişkenleri (Global)
local currentMurderer = ""
local currentSherrif = ""
local currentGunDrop = nil

-- FADE REMOTE (El Başladığında)
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

		-- ESP Takma İşlemini Paralel ve Güvenli Hale Getiriyoruz
		if playerData.Role == "Murderer" or playerData.Role == "Sheriff" then
			task.spawn(function()
				local targetPlayer = players:FindFirstChild(name)
				if targetPlayer then
					local char = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
					local head = char:WaitForChild("Head", 5) 

					if head then
						local oldGui = head:FindFirstChild("RoleGui")
						if oldGui then oldGui:Destroy() end

						local newgui = RoleGui:Clone()
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
end)

-- MESAFE GÜNCELLEME THREAD'İ (Arka planda çalışır, script'i kitlemez)
task.spawn(function()
	while true do
		task.wait(0.2)
		if currentMurderer ~= "" and currentMurderer ~= localPlayer.Name then
			local murdChar = workspace:FindFirstChild(currentMurderer)
			local myChar = localPlayer.Character

			if murdChar and myChar and murdChar:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart") then
				local dist = (murdChar.HumanoidRootPart.Position - myChar.HumanoidRootPart.Position).Magnitude
				Distance.Text = math.floor(dist) .. "M"
				Distance.Visible = true
			else
				Distance.Visible = false
			end
		else
			Distance.Visible = false
		end
	end
end)

-- SİLAH DÜŞMESİ DİNLEYİCİSİ
workspace.DescendantAdded:Connect(function(obj)
	if obj.Name == "GunDrop" then
		currentGunDrop = obj
		Tpgun.Visible = true
	end
end)

-- TELEPORT BUTONU TIKLAMASI
Tpgun.MouseButton1Click:Connect(function()
	if currentGunDrop then
		local myChar = localPlayer.Character
		if myChar and myChar:FindFirstChild("HumanoidRootPart") then
			if currentGunDrop:IsA("Model") then
				myChar.HumanoidRootPart.CFrame = currentGunDrop:GetPivot()
			elseif currentGunDrop:IsA("BasePart") then
				myChar.HumanoidRootPart.CFrame = currentGunDrop.CFrame
			end
		end
	end
end)

-- EL BİTİŞ DİNLEYİCİSİ
roundendfaderemote.OnClientEvent:Connect(function()
	currentMurderer = ""
	currentSherrif = ""
	currentGunDrop = nil
	Tpgun.Visible = false
	Distance.Visible = false
	Murderer.Text = ""
	Sherrif.Text = ""
end)
