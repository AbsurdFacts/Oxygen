local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Oxygen",
	LoadingTitle = "Loading..",
	LoadingSubtitle = "by Aphoon",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "OxygenSavedFolder", -- Create a custom folder for your hub/game
		FileName = "Oxygen"
	},
	Discord = {
		Enabled = true,
		Invite = "https://discord.gg/EcaeSaY5Am", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
		RememberJoins = false -- Set this to false to make them join the discord every time they load it up
	},
	KeySystem = true, -- Set this to true to use our key system
	KeySettings = {
		Title = "AphoonSystem",
		Subtitle = "Aphoon Key System",
		Note = "Key: Aphoon_King",
		FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = {"Aphoon_King"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
})
local Tab = Window:CreateTab("Combat", 4483362458) -- Title, Image

local Speed = Tab:CreateButton({
	Name = "ESP",
	Callback = function()
		-- Function to create a name ESP for a player
		local function createNameESP(player)
			-- Create a BillboardGui as the name ESP
			local billboardGui = Instance.new("BillboardGui")
			billboardGui.Name = "NameESP"
			billboardGui.Enabled = true
			billboardGui.AlwaysOnTop = true
			billboardGui.Size = UDim2.new(0, 100, 0, 50)
			billboardGui.StudsOffset = Vector3.new(0, 3, 0)

			-- Create a TextLabel inside the BillboardGui to display player's name
			local nameLabel = Instance.new("TextLabel", billboardGui)
			nameLabel.Name = "NameLabel"
			nameLabel.BackgroundTransparency = 1
			nameLabel.Size = UDim2.new(1, 0, 1, 0)
			nameLabel.Position = UDim2.new(0, 0, 0, 0)
			nameLabel.Text = player.Name
			nameLabel.Font = Enum.Font.SourceSansBold
			nameLabel.TextSize = 20
			nameLabel.TextColor3 = Color3.new(1, 1, 1)

			-- Parent the BillboardGui to the player's character
			billboardGui.Parent = player.Character
		end

		-- Function to remove name ESP for a player
		local function removeNameESP(player)
			local character = player.Character
			if character then
				local nameESP = character:FindFirstChild("NameESP")
				if nameESP then
					nameESP:Destroy()
				end
			end
		end

		-- Function to update name ESPs for all players in the game
		local function updateNameESP()
			for _, player in ipairs(game.Players:GetPlayers()) do
				local character = player.Character
				if character then
					local nameESP = character:FindFirstChild("NameESP")
					if not nameESP then
						createNameESP(player)
					end
				end
			end
		end

		-- Connect the updateNameESP function to the PlayerAdded event
		game.Players.PlayerAdded:Connect(updateNameESP)

		-- Connect the updateNameESP function to the PlayerRemoving event
		game.Players.PlayerRemoving:Connect(updateNameESP)

		-- Run the updateNameESP function initially to update ESPs for existing players
		updateNameESP()
	end,
})
local Speed = Tab:CreateButton({
	Name = "Speed",
	Callback = function()
		local plr = game.Players.LocalPlayer
		local hum = plr.Character.Humanoid
		hum.WalkSpeed = 23
	end,
})
local ImageESP = Tab:CreateButton({
	Name = "ImageESP",
	Callback = function()
		-- LocalScript to create an ESP effect using an image in Roblox Studio

		local players = game:GetService("Players")
		local imageId = "rbxassetid://17090448684" -- Image ID for the ESP
		local imageSize = 10 -- Size of the image

		-- Function to create an ESP image above a player's head
		local function createESP(player)
			local character = player.Character
			if not character then return end

			local head = character:FindFirstChild("Head")
			if not head then return end

			local billboardGui = Instance.new("BillboardGui")
			billboardGui.Adornee = head
			billboardGui.Size = UDim2.new(imageSize, 0, imageSize, 0)
			billboardGui.AlwaysOnTop = true
			billboardGui.Parent = head

			local imageLabel = Instance.new("ImageLabel")
			imageLabel.Image = imageId
			imageLabel.Size = UDim2.new(1, 0, 1, 0)
			imageLabel.BackgroundTransparency = 1
			imageLabel.Parent = billboardGui
		end

		-- Connect the function to player added event
		players.PlayerAdded:Connect(createESP)

		-- Create ESP for existing players
		for _, player in pairs(players:GetPlayers()) do
			createESP(player)
		end
	end,
})
local AntiKnockback = Tab:CreateButton({
	Name = "AntiKnockback",
	Callback = function()
		-- Anti Knockback Script
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")

		-- Function to override default knockback
		local function onTakingDamage()
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
			wait(0.1) -- Adjust this delay as needed
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
		end

		-- Connect the function to the Humanoid's "TakingDamage" event
		humanoid.TakingDamage:Connect(onTakingDamage)
	end,
})
local SkyBox = Tab:CreateButton({
	Name = "Skybox",
	Callback = function()
		s = Instance.new("Sky")
		s.Name = "SKY"
		s.SkyboxBk = "http://www.roblox.com/asset/?id=358313209"
		s.SkyboxDn = "http://www.roblox.com/asset/?id=358313209"
		s.SkyboxFt = "http://www.roblox.com/asset/?id=358313209"
		s.SkyboxLf = "http://www.roblox.com/asset/?id=358313209"
		s.SkyboxRt = "http://www.roblox.com/asset/?id=358313209"
		s.SkyboxUp = "http://www.roblox.com/asset/?id=358313209"
		s.Parent = game.Lighting
	end,
})
local Bodyguard = Tab:CreateButton({
	Name = "Bodyguard",
	Callback = function()
		for i, v in pairs(game:GetService("Players"):GetChildren()) do


			if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Team ~= game.Players.LocalPlayer.Team then
				print(v.Name)
				repeat wait(0.2)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
				until v.Character.Humanoid.Health == 0 or not v.Character:FindFirstChild("Humanoid")
			end
		end
	end,
})
