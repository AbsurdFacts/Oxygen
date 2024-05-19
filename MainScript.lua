--[[
fuck vape private
]]--

local gameID = game.GameId

writefile("Oxygen1.9/game/saved/" .. gameID ..".lua","local MainGui = Instance.new("ScreenGui")
local OpenFrame = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local LogoText = Instance.new("TextLabel")
local HackFrame = Instance.new("Frame")
local Combat = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local CombatText = Instance.new("TextLabel")
local Fly = Instance.new("TextButton")
local Speed = Instance.new("TextButton")
local Aura = Instance.new("TextButton")
local World = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local WText = Instance.new("TextLabel")
local ChatSpammer = Instance.new("TextButton")
local Visual = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local VText = Instance.new("TextLabel")
local skybox = Instance.new("TextButton")
local CustomCape = Instance.new("TextButton")
local Cape = Instance.new("TextButton")

--Properties:

MainGui.Name = "MainGui"
MainGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

OpenFrame.Name = "OpenFrame"
OpenFrame.Parent = MainGui
OpenFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
OpenFrame.BackgroundTransparency = 0.450
OpenFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
OpenFrame.BorderSizePixel = 0
OpenFrame.Position = UDim2.new(0.0237134211, 0, 0.466225177, 0)
OpenFrame.Size = UDim2.new(0.0499495454, 0, 0.0662251636, 0)
OpenFrame.Font = Enum.Font.Unknown
OpenFrame.Text = "OY"
OpenFrame.TextColor3 = Color3.fromRGB(255, 14, 0)
OpenFrame.TextSize = 29.000
OpenFrame.TextWrapped = true

UICorner.Parent = OpenFrame

LogoText.Name = "LogoText"
LogoText.Parent = MainGui
LogoText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LogoText.BackgroundTransparency = 1.010
LogoText.BorderColor3 = Color3.fromRGB(0, 0, 0)
LogoText.BorderSizePixel = 0
LogoText.Size = UDim2.new(0.0691220984, 0, 0.152317882, 0)
LogoText.Font = Enum.Font.Highway
LogoText.Text = "Oxygen 1.9"
LogoText.TextColor3 = Color3.fromRGB(255, 0, 0)
LogoText.TextScaled = true
LogoText.TextSize = 14.000
LogoText.TextWrapped = true

HackFrame.Name = "HackFrame"
HackFrame.Parent = MainGui
HackFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HackFrame.BackgroundTransparency = 1.030
HackFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
HackFrame.BorderSizePixel = 0
HackFrame.Size = UDim2.new(1, 0, 1, 0)

Combat.Name = "Combat"
Combat.Parent = HackFrame
Combat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Combat.BackgroundTransparency = 0.400
Combat.BorderColor3 = Color3.fromRGB(0, 0, 0)
Combat.BorderSizePixel = 0
Combat.Position = UDim2.new(0.0948536843, 0, 0.027814569, 0)
Combat.Size = UDim2.new(0.197275475, 0, 0.943046331, 0)

UICorner_2.Parent = Combat

CombatText.Name = "CombatText"
CombatText.Parent = Combat
CombatText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CombatText.BackgroundTransparency = 1.010
CombatText.BorderColor3 = Color3.fromRGB(0, 0, 0)
CombatText.BorderSizePixel = 0
CombatText.Position = UDim2.new(0.0843989775, 0, 0.0126404492, 0)
CombatText.Size = UDim2.new(0.828644514, 0, 0.144662917, 0)
CombatText.Font = Enum.Font.Highway
CombatText.Text = "Combat"
CombatText.TextColor3 = Color3.fromRGB(255, 0, 0)
CombatText.TextScaled = true
CombatText.TextSize = 14.000
CombatText.TextWrapped = true

Fly.Name = "Fly"
Fly.Parent = Combat
Fly.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fly.BackgroundTransparency = 1.000
Fly.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fly.BorderSizePixel = 0
Fly.Position = UDim2.new(0.263427109, 0, 0.175561801, 0)
Fly.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
Fly.Font = Enum.Font.DenkOne
Fly.Text = "Fly"
Fly.TextColor3 = Color3.fromRGB(0, 0, 0)
Fly.TextScaled = true
Fly.TextSize = 14.000
Fly.TextWrapped = true

Speed.Name = "Speed"
Speed.Parent = Combat
Speed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Speed.BackgroundTransparency = 1.000
Speed.BorderColor3 = Color3.fromRGB(0, 0, 0)
Speed.BorderSizePixel = 0
Speed.Position = UDim2.new(0.263427109, 0, 0.245786518, 0)
Speed.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
Speed.Font = Enum.Font.DenkOne
Speed.Text = "Speed"
Speed.TextColor3 = Color3.fromRGB(0, 0, 0)
Speed.TextScaled = true
Speed.TextSize = 14.000
Speed.TextWrapped = true

Aura.Name = "Aura"
Aura.Parent = Combat
Aura.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Aura.BackgroundTransparency = 1.000
Aura.BorderColor3 = Color3.fromRGB(0, 0, 0)
Aura.BorderSizePixel = 0
Aura.Position = UDim2.new(0.263427109, 0, 0.31601125, 0)
Aura.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
Aura.Font = Enum.Font.DenkOne
Aura.Text = "Aura"
Aura.TextColor3 = Color3.fromRGB(0, 0, 0)
Aura.TextScaled = true
Aura.TextSize = 14.000
Aura.TextWrapped = true

World.Name = "World"
World.Parent = HackFrame
World.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
World.BackgroundTransparency = 0.400
World.BorderColor3 = Color3.fromRGB(0, 0, 0)
World.BorderSizePixel = 0
World.Position = UDim2.new(0.49635753, 0, 0.027814569, 0)
World.Size = UDim2.new(0.197275475, 0, 0.943046331, 0)

UICorner_3.Parent = World

WText.Name = "WText"
WText.Parent = World
WText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WText.BackgroundTransparency = 1.010
WText.BorderColor3 = Color3.fromRGB(0, 0, 0)
WText.BorderSizePixel = 0
WText.Position = UDim2.new(0.0843989775, 0, 0.0126404492, 0)
WText.Size = UDim2.new(0.828644514, 0, 0.144662917, 0)
WText.Font = Enum.Font.Highway
WText.Text = "World (BETA)"
WText.TextColor3 = Color3.fromRGB(255, 0, 0)
WText.TextScaled = true
WText.TextSize = 14.000
WText.TextWrapped = true

ChatSpammer.Name = "ChatSpammer"
ChatSpammer.Parent = World
ChatSpammer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ChatSpammer.BackgroundTransparency = 1.000
ChatSpammer.BorderColor3 = Color3.fromRGB(0, 0, 0)
ChatSpammer.BorderSizePixel = 0
ChatSpammer.Position = UDim2.new(0.242789894, 0, 0.175561801, 0)
ChatSpammer.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
ChatSpammer.Font = Enum.Font.DenkOne
ChatSpammer.Text = "ChatSpammer"
ChatSpammer.TextColor3 = Color3.fromRGB(0, 0, 0)
ChatSpammer.TextScaled = true
ChatSpammer.TextSize = 14.000
ChatSpammer.TextWrapped = true

Visual.Name = "Visual"
Visual.Parent = HackFrame
Visual.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Visual.BackgroundTransparency = 0.400
Visual.BorderColor3 = Color3.fromRGB(0, 0, 0)
Visual.BorderSizePixel = 0
Visual.Position = UDim2.new(0.295649737, 0, 0.027814569, 0)
Visual.Size = UDim2.new(0.197275475, 0, 0.943046331, 0)

UICorner_4.Parent = Visual

VText.Name = "VText"
VText.Parent = Visual
VText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
VText.BackgroundTransparency = 1.010
VText.BorderColor3 = Color3.fromRGB(0, 0, 0)
VText.BorderSizePixel = 0
VText.Position = UDim2.new(0.0843989775, 0, 0.0126404492, 0)
VText.Size = UDim2.new(0.828644514, 0, 0.144662917, 0)
VText.Font = Enum.Font.Highway
VText.Text = "Visual"
VText.TextColor3 = Color3.fromRGB(255, 0, 0)
VText.TextScaled = true
VText.TextSize = 14.000
VText.TextWrapped = true

skybox.Name = "skybox"
skybox.Parent = Visual
skybox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
skybox.BackgroundTransparency = 1.000
skybox.BorderColor3 = Color3.fromRGB(0, 0, 0)
skybox.BorderSizePixel = 0
skybox.Position = UDim2.new(0.24278982, 0, 0.175561801, 0)
skybox.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
skybox.Font = Enum.Font.DenkOne
skybox.Text = "skybox"
skybox.TextColor3 = Color3.fromRGB(0, 0, 0)
skybox.TextScaled = true
skybox.TextSize = 14.000
skybox.TextWrapped = true

CustomCape.Name = "Custom Cape"
CustomCape.Parent = Visual
CustomCape.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CustomCape.BackgroundTransparency = 1.000
CustomCape.BorderColor3 = Color3.fromRGB(0, 0, 0)
CustomCape.BorderSizePixel = 0
CustomCape.Position = UDim2.new(0.242883757, 0, 0.245786518, 0)
CustomCape.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
CustomCape.Font = Enum.Font.DenkOne
CustomCape.Text = "Custom Cape"
CustomCape.TextColor3 = Color3.fromRGB(0, 0, 0)
CustomCape.TextScaled = true
CustomCape.TextSize = 14.000
CustomCape.TextWrapped = true

Cape.Name = "Cape"
Cape.Parent = Visual
Cape.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Cape.BackgroundTransparency = 1.000
Cape.BorderColor3 = Color3.fromRGB(0, 0, 0)
Cape.BorderSizePixel = 0
Cape.Position = UDim2.new(0.242883757, 0, 0.31601125, 0)
Cape.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
Cape.Font = Enum.Font.DenkOne
Cape.Text = "Cape"
Cape.TextColor3 = Color3.fromRGB(0, 0, 0)
Cape.TextScaled = true
Cape.TextSize = 14.000
Cape.TextWrapped = true

-- Scripts:

local function SKECMJ_fake_script() -- OpenFrame.ToggleHackFrameVisibility 
	local script = Instance.new('LocalScript', OpenFrame)

	local openFrameButton = script.Parent -- Reference to the OpenFrame TextButton
	local hackFrame = openFrameButton.Parent:FindFirstChild("HackFrame") -- Find the HackFrame within the same parent
	
	-- Check if HackFrame exists
	if not hackFrame then
	    warn("HackFrame not found")
	    return
	end
	
	-- Function to toggle the visibility of HackFrame
	local function toggleHackFrameVisibility()
	    hackFrame.Visible = not hackFrame.Visible -- Toggle the visibility
	end
	
	-- Connect the function to the button's click event
	openFrameButton.MouseButton1Click:Connect(toggleHackFrameVisibility)
end
coroutine.wrap(SKECMJ_fake_script)()
local function DBRYL_fake_script() -- Fly.LocalScript 
	local script = Instance.new('LocalScript', Fly)

	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")
	
	local flightEnabled = false
	local flyingSpeed = 23
	local ascendSpeed = 23
	local descendSpeed = -23
	
	local function toggleFlightMode()
		flightEnabled = not flightEnabled
		humanoid.PlatformStand = flightEnabled -- Disable platform standing while flying
	
		if flightEnabled then
			-- Enable flight mode
			rootPart.Anchored = true -- Disable gravity while flying
			humanoid.Sit = true -- Make sure the character isn't standing
		else
			-- Disable flight mode
			rootPart.Anchored = false
			humanoid.Sit = false
		end
	end
	
	-- Connect the flight toggle function to a keybind or button input
	script.Parent.MouseButton1Click:Connect(toggleFlightMode)
	
	-- Main flying loop
	game:GetService("RunService").Stepped:Connect(function(_, dt)
		if flightEnabled then
			local moveVector = Vector3.new(0, 0, 0)
	
			-- Handle movement controls
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
				moveVector = moveVector + Vector3.new(0, 0, -1)
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
				moveVector = moveVector + Vector3.new(0, 0, 1)
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
				moveVector = moveVector + Vector3.new(-1, 0, 0)
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
				moveVector = moveVector + Vector3.new(1, 0, 0)
			end
	
			-- Apply movement
			rootPart.CFrame = rootPart.CFrame * CFrame.new(moveVector * flyingSpeed * dt)
	
			-- Handle ascending and descending
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
				rootPart.CFrame = rootPart.CFrame * CFrame.new(0, ascendSpeed * dt, 0)
			elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
				rootPart.CFrame = rootPart.CFrame * CFrame.new(0, descendSpeed * dt, 0)
			end
		end
	end)
end
coroutine.wrap(DBRYL_fake_script)()
local function WNREO_fake_script() -- Speed.LocalScript 
	local script = Instance.new('LocalScript', Speed)

	local SpeedToggled = false
	
	local function Speed()
		if SpeedToggled == false then
			SpeedToggled = true
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 23
		elseif SpeedToggled == true then
			SpeedToggled = false
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end
	end
	script.Parent.MouseButton1Click:Connect(Speed)
end
coroutine.wrap(WNREO_fake_script)()
local function MWNJYQD_fake_script() -- Aura.LocalScript 
	local script = Instance.new('LocalScript', Aura)

	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local KnitClient = debug.getupvalue(require(LocalPlayer.PlayerScripts.TS.knit).setup, 6)
	local TweenService = game:GetService("TweenService")
	local Camera = game:GetService("Workspace").CurrentCamera
	local RunService = game:GetService("RunService")
	bedwars = {
		["ClientHandlerStore"] = require(LocalPlayer.PlayerScripts.TS.ui.store).ClientStore, ["SwordController"] = KnitClient.Controllers.SwordController,
		["CombatConstant"] = require(game:GetService("ReplicatedStorage").TS.combat["combat-constant"]).CombatConstant,
		["CombatController"] = KnitClient.Controllers.CombatController,
		["KnockbackTable"] = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1),
		["SprintController"] = KnitClient.Controllers.SprintController,
		["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator
	}
	function SetCamera(Camera)
		workspace.CurrentCamera.CameraSubject = Camera
	end
	function IsAlive(plr)
		plr = plr or LocalPlayer
		if not plr.Character then return false end        
		if not plr.Character:FindFirstChild("Head") then return false end
		if not plr.Character:FindFirstChild("Humanoid") then return false end
		if plr.Character:FindFirstChild("Humanoid").Health < 0.11 then return false end
		return true
	end
	function GetClosestPlayer()
		local target = nil
		local distance = math.huge
		for i,v in next, Players:GetPlayers() do
			if v.Team ~= LocalPlayer.Team and IsAlive(v) and not v.Character:FindFirstChildOfClass("ForceField") then
				local plrdist = LocalPlayer:DistanceFromCharacter(v.Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame.p)
				if plrdist < distance then
					target = v
					distance = plrdist
				end
			end
		end
		return target
	end
	function GetBeds()
		local beds = {}
		for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
			if string.lower(v.Name) == "bed" and v:FindFirstChild("Covers") ~= nil and v:FindFirstChild("Covers").Color ~= LocalPlayer.Team.TeamColor then
				table.insert(beds,v)
			end
		end
		return beds
	end
	function getserverpos(Position)
		local x = math.round(Position.X/3)
		local y = math.round(Position.Y/3)
		local z = math.round(Position.Z/3)
		return Vector3.new(x,y,z)
	end
	function GetMatchState()
		return bedwars["ClientHandlerStore"]:getState().Game.matchState
	end
	function GetQueueType()
		local state = bedwars["ClientHandlerStore"]:getState()
		return state.Game.queueType or "bedwars_test"
	end
	local function GetInventory(plr)
		if not plr then 
			return {items = {}, armor = {}}
		end
	
		local suc, ret = pcall(function() 
			return require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil.getInventory(plr)
		end)
	
		if not suc then 
			return {items = {}, armor = {}}
		end
		if plr.Character and plr.Character:FindFirstChild("InventoryFolder") then 
			local invFolder = plr.Character:FindFirstChild("InventoryFolder").Value
			if not invFolder then return ret end
			for i,v in next, ret do 
				for i2, v2 in next, v do 
					if typeof(v2) == 'table' and v2.itemType then
						v2.instance = invFolder:FindFirstChild(v2.itemType)
					end
				end
				if typeof(v) == 'table' and v.itemType then
					v.instance = invFolder:FindFirstChild(v.itemType)
				end
			end
		end
	
		return ret
	end
	local BedwarsSwords = require(game:GetService("ReplicatedStorage").TS.games.bedwars["bedwars-swords"]).BedwarsMelees
	function hashFunc(vec)
		return {value = vec}
	end
	local function getSword()
		local highest, returning = -9e9, nil
		for i,v in next, GetInventory(LocalPlayer).items do 
			local swords = table.find(BedwarsSwords, v.itemType)
			if not swords then continue end
			if swords > highest then 
				returning = v
				highest = swords
			end
		end
		return returning
	end
	local function getItemNear(itemName)
		for slot, item in next, GetInventory(LocalPlayer).items do
			if item.itemType == itemName or item.itemType:find(itemName) then
				return item, slot
			end
		end
		return nil
	end
	local function switchItem(tool)
		if LocalPlayer.Character.HandInvItem.Value ~= tool then
			game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.SetInvItem:InvokeServer({
				hand = tool
			})
		end
	end
	
	local SwordAnimations = {
		["Slow"] = {
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(220), math.rad(100), math.rad(100)),Time = 0.25},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
		}
	}
	
	local origC0 = game:GetService("ReplicatedStorage").Assets.Viewmodel.RightHand.RightWrist.C0
	
	local function EnableKillaura()
		KillauraRange = 20
		repeat task.wait() until GetMatchState() ~= 0
		while task.wait() do
			for i, v in pairs(game:GetService("Players"):GetChildren()) do
				if v.Team ~= LocalPlayer.Team and IsAlive(v) and IsAlive(LocalPlayer) and not v.Character:FindFirstChildOfClass("ForceField") then
					local Magnitude = (v.Character:FindFirstChild("HumanoidRootPart").Position - LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
					if Magnitude < KillauraRange then
						local Sword = getSword()
						if not ToolcheckKillaura then
							switchItem(Sword.tool)
						end
						if Sword ~= nil then
							KillauraSpeed = true
							spawn(function()
								local anim = Instance.new("Animation")
								anim.AnimationId = "rbxassetid://4947108314"
								local loader = LocalPlayer.Character:FindFirstChild("Humanoid"):FindFirstChild("Animator")
								loader:LoadAnimation(anim):Play()
								if CostumAnimations then
									CostumAnimations = false
									for i,v in pairs(SwordAnimations["Slow"]) do
										game:GetService("TweenService"):Create(Camera.Viewmodel.RightHand.RightWrist,TweenInfo.new(v.Time),{C0 = origC0 * v.CFrame}):Play()
										task.wait(v.Time-0.01)
									end
									CostumAnimations = true
								end
							end)
							game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.SwordHit:FireServer({
								["chargedAttack"] = {["chargeRatio"] = 0},
								["entityInstance"] = v.Character,
								["validate"] = {
									["targetPosition"] = hashFunc(v.Character:FindFirstChild("HumanoidRootPart").Position),
									["selfPosition"] = hashFunc(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position + ((LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude > 14 and (CFrame.lookAt(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position, v.Character:FindFirstChild("HumanoidRootPart").Position).LookVector * 4) or Vector3.new(0, 0, 0))),
								}, 
								["weapon"] = Sword.tool,
							})
						else
							KillauraSpeed = false
						end
					end
				end
			end
		end
	end
	
	--  Killaura
	script.Parent.MouseButton1Click:Connect(EnableKillaura)
end
coroutine.wrap(MWNJYQD_fake_script)()
local function WHTI_fake_script() -- ChatSpammer.LocalScript 
	local script = Instance.new('LocalScript', ChatSpammer)

	local function Spam()
		while true do
			wait(0.1)
			local args = {
				[1] = "Use Oxygen | Oxygen On Top!",
				[2] = "All"
			}
	
			game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
		end
	end
	
	script.Parent.MouseButton1Click:Connect(Spam)
end
coroutine.wrap(WHTI_fake_script)()
local function QHHFH_fake_script() -- skybox.LocalScript 
	local script = Instance.new('LocalScript', skybox)

	local Images = {--\\What 99% Of you like to see xd
		"rbxassetid://14993957229", 
		"rbxassetid://14993958854",
		"rbxassetid://14993961695"
	} 
	local sky = Instance.new("Sky", game.Lighting)
	
	local function Sky()
		sky.SkyboxBk = Images[1]
		sky.SkyboxDn = Images[2]
		sky.SkyboxFt = Images[2]
		sky.SkyboxLf = Images[3]
		sky.SkyboxRt = Images[1]
		sky.SkyboxUp = Images[1]
		sky.Parent = game.Lighting
	end
	script.Parent.MouseButton1Click:Connect(Sky)
end
coroutine.wrap(QHHFH_fake_script)()
local function NKSA_fake_script() -- CustomCape.LocalScript 
	local script = Instance.new('LocalScript', CustomCape)

	local Lplr = game.Players.LocalPlayer
	
	local function CreateCape(DecalId)
		local Cape = Instance.new("Part")
	
		Cape.Parent = Lplr.Character
		Cape.Name = "Cape"
		Cape.Size = Vector3.new(0.2, 0.2, 0.08)
		Cape.Material = Enum.Material.SmoothPlastic
		Cape.Color = Color3.new(0.105882, 0.105882, 0.105882)
		Cape.CanCollide = false
	
		local BlockMesh = Instance.new("BlockMesh")
	
		BlockMesh.Parent = Cape
		BlockMesh.Name = "Mesh"
		BlockMesh.Scale = Vector3.new(9, 17.5, 0.5)
		BlockMesh.VertexColor = Vector3.new(1, 1, 1)
	
		local Motor = Instance.new("Motor")
	
		Motor.Parent = Cape
		Motor.Name = "Motor"
		Motor.C0 = CFrame.new(0, 2, 0, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
		Motor.C1 = CFrame.new(0, 1, 0.449999988, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
		Motor.Part1 = Lplr.Character.UpperTorso
		Motor.Part0 = Cape
		Motor.CurrentAngle = -0.16208772361278534
		Motor.DesiredAngle = -0.1002269834280014
	
		local Decal = Instance.new("Decal")
	
		Decal.Parent = Cape
		Decal.Name = "Decal"
		Decal.Face = Enum.NormalId.Back
		Decal.Texture = "rbxassetid://14993961695"
		Decal.Transparency = 0
	end
	
	script.Parent.MouseButton1Click:Connect(CreateCape)
end
coroutine.wrap(NKSA_fake_script)()
local function SLBDMH_fake_script() -- Cape.LocalScript 
	local script = Instance.new('LocalScript', Cape)

	local Lplr = game.Players.LocalPlayer
	
	local function CreateCape(DecalId)
		local Cape = Instance.new("Part")
	
		Cape.Parent = Lplr.Character
		Cape.Name = "Cape"
		Cape.Size = Vector3.new(0.2, 0.2, 0.08)
		Cape.Material = Enum.Material.SmoothPlastic
		Cape.Color = Color3.new(0.105882, 0.105882, 0.105882)
		Cape.CanCollide = false
	
		local BlockMesh = Instance.new("BlockMesh")
	
		BlockMesh.Parent = Cape
		BlockMesh.Name = "Mesh"
		BlockMesh.Scale = Vector3.new(9, 17.5, 0.5)
		BlockMesh.VertexColor = Vector3.new(1, 1, 1)
	
		local Motor = Instance.new("Motor")
	
		Motor.Parent = Cape
		Motor.Name = "Motor"
		Motor.C0 = CFrame.new(0, 2, 0, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
		Motor.C1 = CFrame.new(0, 1, 0.449999988, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
		Motor.Part1 = Lplr.Character.UpperTorso
		Motor.Part0 = Cape
		Motor.CurrentAngle = -0.16208772361278534
		Motor.DesiredAngle = -0.1002269834280014
	
		local Decal = Instance.new("Decal")
	
		Decal.Parent = Cape
		Decal.Name = "Decal"
		Decal.Face = Enum.NormalId.Back
		Decal.Texture = DecalId
		Decal.Transparency = 0
	end
	
	script.Parent.MouseButton1Click:Connect(CreateCape)
end
coroutine.wrap(SLBDMH_fake_script)()
local function ZHNAP_fake_script() -- MainGui.LocalScript 
	local script = Instance.new('LocalScript', MainGui)

	game:GetService("UserInputService").JumpRequest:connect(function()
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end)
end
coroutine.wrap(ZHNAP_fake_script)()
local function EVLX_fake_script() -- MainGui.Notify 
	local script = Instance.new('LocalScript', MainGui)

	-- Create a notification GUI
	local notifyGUI = Instance.new("ScreenGui")
	notifyGUI.Parent = game:GetService("Players").LocalPlayer.PlayerGui
	
	-- Create a label to display the notification
	local notifyLabel = Instance.new("TextLabel")
	notifyLabel.Size = UDim2.new(0, 200, 0, 50)
	notifyLabel.Position = UDim2.new(0.5, -100, 0.8)
	notifyLabel.BackgroundColor3 = Color3.new(0, 0, 0) -- Set the background color to black
	notifyLabel.TextColor3 = Color3.new(1, 1, 1) -- Set the text color to white
	notifyLabel.TextStrokeTransparency = 0
	notifyLabel.Text = "Oxygen 1.9 Loaded! (Credits to Ince0465 for making notification script uwu)"
	notifyLabel.Font = Enum.Font.Jura -- Set the font to Jura
	notifyLabel.TextSize = 20 -- Set the text size to 20
	notifyLabel.Parent = notifyGUI
	notifyLabel.TextScaled = true
	
	-- Create a function to dissolve the notification
	local function dissolveNotify()
		notifyLabel.BackgroundTransparency = 0
		for i = 0, 1, 0.1 do
			wait(0.05)
			notifyLabel.BackgroundTransparency = i
		end
		notifyGUI:Destroy()
	end
	
	-- Dissolve the notification after 6.5 seconds
	wait(6.5)
	dissolveNotify()
end
coroutine.wrap(EVLX_fake_script)()")

local MainGui = Instance.new("ScreenGui")
local OpenFrame = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local LogoText = Instance.new("TextLabel")
local HackFrame = Instance.new("Frame")
local Combat = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local CombatText = Instance.new("TextLabel")
local Fly = Instance.new("TextButton")
local Speed = Instance.new("TextButton")
local Aura = Instance.new("TextButton")
local World = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local WText = Instance.new("TextLabel")
local ChatSpammer = Instance.new("TextButton")
local Visual = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local VText = Instance.new("TextLabel")
local skybox = Instance.new("TextButton")
local CustomCape = Instance.new("TextButton")
local Cape = Instance.new("TextButton")

--Properties:

MainGui.Name = "MainGui"
MainGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

OpenFrame.Name = "OpenFrame"
OpenFrame.Parent = MainGui
OpenFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
OpenFrame.BackgroundTransparency = 0.450
OpenFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
OpenFrame.BorderSizePixel = 0
OpenFrame.Position = UDim2.new(0.0237134211, 0, 0.466225177, 0)
OpenFrame.Size = UDim2.new(0.0499495454, 0, 0.0662251636, 0)
OpenFrame.Font = Enum.Font.Unknown
OpenFrame.Text = "OY"
OpenFrame.TextColor3 = Color3.fromRGB(255, 14, 0)
OpenFrame.TextSize = 29.000
OpenFrame.TextWrapped = true

UICorner.Parent = OpenFrame

LogoText.Name = "LogoText"
LogoText.Parent = MainGui
LogoText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LogoText.BackgroundTransparency = 1.010
LogoText.BorderColor3 = Color3.fromRGB(0, 0, 0)
LogoText.BorderSizePixel = 0
LogoText.Size = UDim2.new(0.0691220984, 0, 0.152317882, 0)
LogoText.Font = Enum.Font.Highway
LogoText.Text = "Oxygen 1.9"
LogoText.TextColor3 = Color3.fromRGB(255, 0, 0)
LogoText.TextScaled = true
LogoText.TextSize = 14.000
LogoText.TextWrapped = true

HackFrame.Name = "HackFrame"
HackFrame.Parent = MainGui
HackFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HackFrame.BackgroundTransparency = 1.030
HackFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
HackFrame.BorderSizePixel = 0
HackFrame.Size = UDim2.new(1, 0, 1, 0)

Combat.Name = "Combat"
Combat.Parent = HackFrame
Combat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Combat.BackgroundTransparency = 0.400
Combat.BorderColor3 = Color3.fromRGB(0, 0, 0)
Combat.BorderSizePixel = 0
Combat.Position = UDim2.new(0.0948536843, 0, 0.027814569, 0)
Combat.Size = UDim2.new(0.197275475, 0, 0.943046331, 0)

UICorner_2.Parent = Combat

CombatText.Name = "CombatText"
CombatText.Parent = Combat
CombatText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CombatText.BackgroundTransparency = 1.010
CombatText.BorderColor3 = Color3.fromRGB(0, 0, 0)
CombatText.BorderSizePixel = 0
CombatText.Position = UDim2.new(0.0843989775, 0, 0.0126404492, 0)
CombatText.Size = UDim2.new(0.828644514, 0, 0.144662917, 0)
CombatText.Font = Enum.Font.Highway
CombatText.Text = "Combat"
CombatText.TextColor3 = Color3.fromRGB(255, 0, 0)
CombatText.TextScaled = true
CombatText.TextSize = 14.000
CombatText.TextWrapped = true

Fly.Name = "Fly"
Fly.Parent = Combat
Fly.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fly.BackgroundTransparency = 1.000
Fly.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fly.BorderSizePixel = 0
Fly.Position = UDim2.new(0.263427109, 0, 0.175561801, 0)
Fly.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
Fly.Font = Enum.Font.DenkOne
Fly.Text = "Fly"
Fly.TextColor3 = Color3.fromRGB(0, 0, 0)
Fly.TextScaled = true
Fly.TextSize = 14.000
Fly.TextWrapped = true

Speed.Name = "Speed"
Speed.Parent = Combat
Speed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Speed.BackgroundTransparency = 1.000
Speed.BorderColor3 = Color3.fromRGB(0, 0, 0)
Speed.BorderSizePixel = 0
Speed.Position = UDim2.new(0.263427109, 0, 0.245786518, 0)
Speed.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
Speed.Font = Enum.Font.DenkOne
Speed.Text = "Speed"
Speed.TextColor3 = Color3.fromRGB(0, 0, 0)
Speed.TextScaled = true
Speed.TextSize = 14.000
Speed.TextWrapped = true

Aura.Name = "Aura"
Aura.Parent = Combat
Aura.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Aura.BackgroundTransparency = 1.000
Aura.BorderColor3 = Color3.fromRGB(0, 0, 0)
Aura.BorderSizePixel = 0
Aura.Position = UDim2.new(0.263427109, 0, 0.31601125, 0)
Aura.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
Aura.Font = Enum.Font.DenkOne
Aura.Text = "Aura"
Aura.TextColor3 = Color3.fromRGB(0, 0, 0)
Aura.TextScaled = true
Aura.TextSize = 14.000
Aura.TextWrapped = true

World.Name = "World"
World.Parent = HackFrame
World.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
World.BackgroundTransparency = 0.400
World.BorderColor3 = Color3.fromRGB(0, 0, 0)
World.BorderSizePixel = 0
World.Position = UDim2.new(0.49635753, 0, 0.027814569, 0)
World.Size = UDim2.new(0.197275475, 0, 0.943046331, 0)

UICorner_3.Parent = World

WText.Name = "WText"
WText.Parent = World
WText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WText.BackgroundTransparency = 1.010
WText.BorderColor3 = Color3.fromRGB(0, 0, 0)
WText.BorderSizePixel = 0
WText.Position = UDim2.new(0.0843989775, 0, 0.0126404492, 0)
WText.Size = UDim2.new(0.828644514, 0, 0.144662917, 0)
WText.Font = Enum.Font.Highway
WText.Text = "World (BETA)"
WText.TextColor3 = Color3.fromRGB(255, 0, 0)
WText.TextScaled = true
WText.TextSize = 14.000
WText.TextWrapped = true

ChatSpammer.Name = "ChatSpammer"
ChatSpammer.Parent = World
ChatSpammer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ChatSpammer.BackgroundTransparency = 1.000
ChatSpammer.BorderColor3 = Color3.fromRGB(0, 0, 0)
ChatSpammer.BorderSizePixel = 0
ChatSpammer.Position = UDim2.new(0.242789894, 0, 0.175561801, 0)
ChatSpammer.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
ChatSpammer.Font = Enum.Font.DenkOne
ChatSpammer.Text = "ChatSpammer"
ChatSpammer.TextColor3 = Color3.fromRGB(0, 0, 0)
ChatSpammer.TextScaled = true
ChatSpammer.TextSize = 14.000
ChatSpammer.TextWrapped = true

Visual.Name = "Visual"
Visual.Parent = HackFrame
Visual.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Visual.BackgroundTransparency = 0.400
Visual.BorderColor3 = Color3.fromRGB(0, 0, 0)
Visual.BorderSizePixel = 0
Visual.Position = UDim2.new(0.295649737, 0, 0.027814569, 0)
Visual.Size = UDim2.new(0.197275475, 0, 0.943046331, 0)

UICorner_4.Parent = Visual

VText.Name = "VText"
VText.Parent = Visual
VText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
VText.BackgroundTransparency = 1.010
VText.BorderColor3 = Color3.fromRGB(0, 0, 0)
VText.BorderSizePixel = 0
VText.Position = UDim2.new(0.0843989775, 0, 0.0126404492, 0)
VText.Size = UDim2.new(0.828644514, 0, 0.144662917, 0)
VText.Font = Enum.Font.Highway
VText.Text = "Visual"
VText.TextColor3 = Color3.fromRGB(255, 0, 0)
VText.TextScaled = true
VText.TextSize = 14.000
VText.TextWrapped = true

skybox.Name = "skybox"
skybox.Parent = Visual
skybox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
skybox.BackgroundTransparency = 1.000
skybox.BorderColor3 = Color3.fromRGB(0, 0, 0)
skybox.BorderSizePixel = 0
skybox.Position = UDim2.new(0.24278982, 0, 0.175561801, 0)
skybox.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
skybox.Font = Enum.Font.DenkOne
skybox.Text = "skybox"
skybox.TextColor3 = Color3.fromRGB(0, 0, 0)
skybox.TextScaled = true
skybox.TextSize = 14.000
skybox.TextWrapped = true

CustomCape.Name = "Custom Cape"
CustomCape.Parent = Visual
CustomCape.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CustomCape.BackgroundTransparency = 1.000
CustomCape.BorderColor3 = Color3.fromRGB(0, 0, 0)
CustomCape.BorderSizePixel = 0
CustomCape.Position = UDim2.new(0.242883757, 0, 0.245786518, 0)
CustomCape.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
CustomCape.Font = Enum.Font.DenkOne
CustomCape.Text = "Custom Cape"
CustomCape.TextColor3 = Color3.fromRGB(0, 0, 0)
CustomCape.TextScaled = true
CustomCape.TextSize = 14.000
CustomCape.TextWrapped = true

Cape.Name = "Cape"
Cape.Parent = Visual
Cape.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Cape.BackgroundTransparency = 1.000
Cape.BorderColor3 = Color3.fromRGB(0, 0, 0)
Cape.BorderSizePixel = 0
Cape.Position = UDim2.new(0.242883757, 0, 0.31601125, 0)
Cape.Size = UDim2.new(0.511508942, 0, 0.0702247173, 0)
Cape.Font = Enum.Font.DenkOne
Cape.Text = "Cape"
Cape.TextColor3 = Color3.fromRGB(0, 0, 0)
Cape.TextScaled = true
Cape.TextSize = 14.000
Cape.TextWrapped = true

-- Scripts:

local function SKECMJ_fake_script() -- OpenFrame.ToggleHackFrameVisibility 
	local script = Instance.new('LocalScript', OpenFrame)

	local openFrameButton = script.Parent -- Reference to the OpenFrame TextButton
	local hackFrame = openFrameButton.Parent:FindFirstChild("HackFrame") -- Find the HackFrame within the same parent
	
	-- Check if HackFrame exists
	if not hackFrame then
	    warn("HackFrame not found")
	    return
	end
	
	-- Function to toggle the visibility of HackFrame
	local function toggleHackFrameVisibility()
	    hackFrame.Visible = not hackFrame.Visible -- Toggle the visibility
	end
	
	-- Connect the function to the button's click event
	openFrameButton.MouseButton1Click:Connect(toggleHackFrameVisibility)
end
coroutine.wrap(SKECMJ_fake_script)()
local function DBRYL_fake_script() -- Fly.LocalScript 
	local script = Instance.new('LocalScript', Fly)

	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")
	
	local flightEnabled = false
	local flyingSpeed = 23
	local ascendSpeed = 23
	local descendSpeed = -23
	
	local function toggleFlightMode()
		flightEnabled = not flightEnabled
		humanoid.PlatformStand = flightEnabled -- Disable platform standing while flying
	
		if flightEnabled then
			-- Enable flight mode
			rootPart.Anchored = true -- Disable gravity while flying
			humanoid.Sit = true -- Make sure the character isn't standing
		else
			-- Disable flight mode
			rootPart.Anchored = false
			humanoid.Sit = false
		end
	end
	
	-- Connect the flight toggle function to a keybind or button input
	script.Parent.MouseButton1Click:Connect(toggleFlightMode)
	
	-- Main flying loop
	game:GetService("RunService").Stepped:Connect(function(_, dt)
		if flightEnabled then
			local moveVector = Vector3.new(0, 0, 0)
	
			-- Handle movement controls
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
				moveVector = moveVector + Vector3.new(0, 0, -1)
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
				moveVector = moveVector + Vector3.new(0, 0, 1)
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
				moveVector = moveVector + Vector3.new(-1, 0, 0)
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
				moveVector = moveVector + Vector3.new(1, 0, 0)
			end
	
			-- Apply movement
			rootPart.CFrame = rootPart.CFrame * CFrame.new(moveVector * flyingSpeed * dt)
	
			-- Handle ascending and descending
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
				rootPart.CFrame = rootPart.CFrame * CFrame.new(0, ascendSpeed * dt, 0)
			elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
				rootPart.CFrame = rootPart.CFrame * CFrame.new(0, descendSpeed * dt, 0)
			end
		end
	end)
end
coroutine.wrap(DBRYL_fake_script)()
local function WNREO_fake_script() -- Speed.LocalScript 
	local script = Instance.new('LocalScript', Speed)

	local SpeedToggled = false
	
	local function Speed()
		if SpeedToggled == false then
			SpeedToggled = true
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 23
		elseif SpeedToggled == true then
			SpeedToggled = false
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end
	end
	script.Parent.MouseButton1Click:Connect(Speed)
end
coroutine.wrap(WNREO_fake_script)()
local function MWNJYQD_fake_script() -- Aura.LocalScript 
	local script = Instance.new('LocalScript', Aura)

	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local KnitClient = debug.getupvalue(require(LocalPlayer.PlayerScripts.TS.knit).setup, 6)
	local TweenService = game:GetService("TweenService")
	local Camera = game:GetService("Workspace").CurrentCamera
	local RunService = game:GetService("RunService")
	bedwars = {
		["ClientHandlerStore"] = require(LocalPlayer.PlayerScripts.TS.ui.store).ClientStore, ["SwordController"] = KnitClient.Controllers.SwordController,
		["CombatConstant"] = require(game:GetService("ReplicatedStorage").TS.combat["combat-constant"]).CombatConstant,
		["CombatController"] = KnitClient.Controllers.CombatController,
		["KnockbackTable"] = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1),
		["SprintController"] = KnitClient.Controllers.SprintController,
		["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator
	}
	function SetCamera(Camera)
		workspace.CurrentCamera.CameraSubject = Camera
	end
	function IsAlive(plr)
		plr = plr or LocalPlayer
		if not plr.Character then return false end        
		if not plr.Character:FindFirstChild("Head") then return false end
		if not plr.Character:FindFirstChild("Humanoid") then return false end
		if plr.Character:FindFirstChild("Humanoid").Health < 0.11 then return false end
		return true
	end
	function GetClosestPlayer()
		local target = nil
		local distance = math.huge
		for i,v in next, Players:GetPlayers() do
			if v.Team ~= LocalPlayer.Team and IsAlive(v) and not v.Character:FindFirstChildOfClass("ForceField") then
				local plrdist = LocalPlayer:DistanceFromCharacter(v.Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame.p)
				if plrdist < distance then
					target = v
					distance = plrdist
				end
			end
		end
		return target
	end
	function GetBeds()
		local beds = {}
		for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
			if string.lower(v.Name) == "bed" and v:FindFirstChild("Covers") ~= nil and v:FindFirstChild("Covers").Color ~= LocalPlayer.Team.TeamColor then
				table.insert(beds,v)
			end
		end
		return beds
	end
	function getserverpos(Position)
		local x = math.round(Position.X/3)
		local y = math.round(Position.Y/3)
		local z = math.round(Position.Z/3)
		return Vector3.new(x,y,z)
	end
	function GetMatchState()
		return bedwars["ClientHandlerStore"]:getState().Game.matchState
	end
	function GetQueueType()
		local state = bedwars["ClientHandlerStore"]:getState()
		return state.Game.queueType or "bedwars_test"
	end
	local function GetInventory(plr)
		if not plr then 
			return {items = {}, armor = {}}
		end
	
		local suc, ret = pcall(function() 
			return require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil.getInventory(plr)
		end)
	
		if not suc then 
			return {items = {}, armor = {}}
		end
		if plr.Character and plr.Character:FindFirstChild("InventoryFolder") then 
			local invFolder = plr.Character:FindFirstChild("InventoryFolder").Value
			if not invFolder then return ret end
			for i,v in next, ret do 
				for i2, v2 in next, v do 
					if typeof(v2) == 'table' and v2.itemType then
						v2.instance = invFolder:FindFirstChild(v2.itemType)
					end
				end
				if typeof(v) == 'table' and v.itemType then
					v.instance = invFolder:FindFirstChild(v.itemType)
				end
			end
		end
	
		return ret
	end
	local BedwarsSwords = require(game:GetService("ReplicatedStorage").TS.games.bedwars["bedwars-swords"]).BedwarsMelees
	function hashFunc(vec)
		return {value = vec}
	end
	local function getSword()
		local highest, returning = -9e9, nil
		for i,v in next, GetInventory(LocalPlayer).items do 
			local swords = table.find(BedwarsSwords, v.itemType)
			if not swords then continue end
			if swords > highest then 
				returning = v
				highest = swords
			end
		end
		return returning
	end
	local function getItemNear(itemName)
		for slot, item in next, GetInventory(LocalPlayer).items do
			if item.itemType == itemName or item.itemType:find(itemName) then
				return item, slot
			end
		end
		return nil
	end
	local function switchItem(tool)
		if LocalPlayer.Character.HandInvItem.Value ~= tool then
			game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.SetInvItem:InvokeServer({
				hand = tool
			})
		end
	end
	
	local SwordAnimations = {
		["Slow"] = {
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(220), math.rad(100), math.rad(100)),Time = 0.25},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
		}
	}
	
	local origC0 = game:GetService("ReplicatedStorage").Assets.Viewmodel.RightHand.RightWrist.C0
	
	local function EnableKillaura()
		KillauraRange = 20
		repeat task.wait() until GetMatchState() ~= 0
		while task.wait() do
			for i, v in pairs(game:GetService("Players"):GetChildren()) do
				if v.Team ~= LocalPlayer.Team and IsAlive(v) and IsAlive(LocalPlayer) and not v.Character:FindFirstChildOfClass("ForceField") then
					local Magnitude = (v.Character:FindFirstChild("HumanoidRootPart").Position - LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
					if Magnitude < KillauraRange then
						local Sword = getSword()
						if not ToolcheckKillaura then
							switchItem(Sword.tool)
						end
						if Sword ~= nil then
							KillauraSpeed = true
							spawn(function()
								local anim = Instance.new("Animation")
								anim.AnimationId = "rbxassetid://4947108314"
								local loader = LocalPlayer.Character:FindFirstChild("Humanoid"):FindFirstChild("Animator")
								loader:LoadAnimation(anim):Play()
								if CostumAnimations then
									CostumAnimations = false
									for i,v in pairs(SwordAnimations["Slow"]) do
										game:GetService("TweenService"):Create(Camera.Viewmodel.RightHand.RightWrist,TweenInfo.new(v.Time),{C0 = origC0 * v.CFrame}):Play()
										task.wait(v.Time-0.01)
									end
									CostumAnimations = true
								end
							end)
							game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.SwordHit:FireServer({
								["chargedAttack"] = {["chargeRatio"] = 0},
								["entityInstance"] = v.Character,
								["validate"] = {
									["targetPosition"] = hashFunc(v.Character:FindFirstChild("HumanoidRootPart").Position),
									["selfPosition"] = hashFunc(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position + ((LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude > 14 and (CFrame.lookAt(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position, v.Character:FindFirstChild("HumanoidRootPart").Position).LookVector * 4) or Vector3.new(0, 0, 0))),
								}, 
								["weapon"] = Sword.tool,
							})
						else
							KillauraSpeed = false
						end
					end
				end
			end
		end
	end
	
	--  Killaura
	script.Parent.MouseButton1Click:Connect(EnableKillaura)
end
coroutine.wrap(MWNJYQD_fake_script)()
local function WHTI_fake_script() -- ChatSpammer.LocalScript 
	local script = Instance.new('LocalScript', ChatSpammer)

	local function Spam()
		while true do
			wait(0.1)
			local args = {
				[1] = "Use Oxygen | Oxygen On Top!",
				[2] = "All"
			}
	
			game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
		end
	end
	
	script.Parent.MouseButton1Click:Connect(Spam)
end
coroutine.wrap(WHTI_fake_script)()
local function QHHFH_fake_script() -- skybox.LocalScript 
	local script = Instance.new('LocalScript', skybox)

	local Images = {--\\What 99% Of you like to see xd
		"rbxassetid://14993957229", 
		"rbxassetid://14993958854",
		"rbxassetid://14993961695"
	} 
	local sky = Instance.new("Sky", game.Lighting)
	
	local function Sky()
		sky.SkyboxBk = Images[1]
		sky.SkyboxDn = Images[2]
		sky.SkyboxFt = Images[2]
		sky.SkyboxLf = Images[3]
		sky.SkyboxRt = Images[1]
		sky.SkyboxUp = Images[1]
		sky.Parent = game.Lighting
	end
	script.Parent.MouseButton1Click:Connect(Sky)
end
coroutine.wrap(QHHFH_fake_script)()
local function NKSA_fake_script() -- CustomCape.LocalScript 
	local script = Instance.new('LocalScript', CustomCape)

	local Lplr = game.Players.LocalPlayer
	
	local function CreateCape(DecalId)
		local Cape = Instance.new("Part")
	
		Cape.Parent = Lplr.Character
		Cape.Name = "Cape"
		Cape.Size = Vector3.new(0.2, 0.2, 0.08)
		Cape.Material = Enum.Material.SmoothPlastic
		Cape.Color = Color3.new(0.105882, 0.105882, 0.105882)
		Cape.CanCollide = false
	
		local BlockMesh = Instance.new("BlockMesh")
	
		BlockMesh.Parent = Cape
		BlockMesh.Name = "Mesh"
		BlockMesh.Scale = Vector3.new(9, 17.5, 0.5)
		BlockMesh.VertexColor = Vector3.new(1, 1, 1)
	
		local Motor = Instance.new("Motor")
	
		Motor.Parent = Cape
		Motor.Name = "Motor"
		Motor.C0 = CFrame.new(0, 2, 0, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
		Motor.C1 = CFrame.new(0, 1, 0.449999988, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
		Motor.Part1 = Lplr.Character.UpperTorso
		Motor.Part0 = Cape
		Motor.CurrentAngle = -0.16208772361278534
		Motor.DesiredAngle = -0.1002269834280014
	
		local Decal = Instance.new("Decal")
	
		Decal.Parent = Cape
		Decal.Name = "Decal"
		Decal.Face = Enum.NormalId.Back
		Decal.Texture = "rbxassetid://14993961695"
		Decal.Transparency = 0
	end
	
	script.Parent.MouseButton1Click:Connect(CreateCape)
end
coroutine.wrap(NKSA_fake_script)()
local function SLBDMH_fake_script() -- Cape.LocalScript 
	local script = Instance.new('LocalScript', Cape)

	local Lplr = game.Players.LocalPlayer
	
	local function CreateCape(DecalId)
		local Cape = Instance.new("Part")
	
		Cape.Parent = Lplr.Character
		Cape.Name = "Cape"
		Cape.Size = Vector3.new(0.2, 0.2, 0.08)
		Cape.Material = Enum.Material.SmoothPlastic
		Cape.Color = Color3.new(0.105882, 0.105882, 0.105882)
		Cape.CanCollide = false
	
		local BlockMesh = Instance.new("BlockMesh")
	
		BlockMesh.Parent = Cape
		BlockMesh.Name = "Mesh"
		BlockMesh.Scale = Vector3.new(9, 17.5, 0.5)
		BlockMesh.VertexColor = Vector3.new(1, 1, 1)
	
		local Motor = Instance.new("Motor")
	
		Motor.Parent = Cape
		Motor.Name = "Motor"
		Motor.C0 = CFrame.new(0, 2, 0, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
		Motor.C1 = CFrame.new(0, 1, 0.449999988, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
		Motor.Part1 = Lplr.Character.UpperTorso
		Motor.Part0 = Cape
		Motor.CurrentAngle = -0.16208772361278534
		Motor.DesiredAngle = -0.1002269834280014
	
		local Decal = Instance.new("Decal")
	
		Decal.Parent = Cape
		Decal.Name = "Decal"
		Decal.Face = Enum.NormalId.Back
		Decal.Texture = DecalId
		Decal.Transparency = 0
	end
	
	script.Parent.MouseButton1Click:Connect(CreateCape)
end
coroutine.wrap(SLBDMH_fake_script)()
local function ZHNAP_fake_script() -- MainGui.LocalScript 
	local script = Instance.new('LocalScript', MainGui)

	game:GetService("UserInputService").JumpRequest:connect(function()
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end)
end
coroutine.wrap(ZHNAP_fake_script)()
local function EVLX_fake_script() -- MainGui.Notify 
	local script = Instance.new('LocalScript', MainGui)

	-- Create a notification GUI
	local notifyGUI = Instance.new("ScreenGui")
	notifyGUI.Parent = game:GetService("Players").LocalPlayer.PlayerGui
	
	-- Create a label to display the notification
	local notifyLabel = Instance.new("TextLabel")
	notifyLabel.Size = UDim2.new(0, 200, 0, 50)
	notifyLabel.Position = UDim2.new(0.5, -100, 0.8)
	notifyLabel.BackgroundColor3 = Color3.new(0, 0, 0) -- Set the background color to black
	notifyLabel.TextColor3 = Color3.new(1, 1, 1) -- Set the text color to white
	notifyLabel.TextStrokeTransparency = 0
	notifyLabel.Text = "Oxygen 1.9 Loaded! (Credits to Ince0465 for making notification script uwu)"
	notifyLabel.Font = Enum.Font.Jura -- Set the font to Jura
	notifyLabel.TextSize = 20 -- Set the text size to 20
	notifyLabel.Parent = notifyGUI
	notifyLabel.TextScaled = true
	
	-- Create a function to dissolve the notification
	local function dissolveNotify()
		notifyLabel.BackgroundTransparency = 0
		for i = 0, 1, 0.1 do
			wait(0.05)
			notifyLabel.BackgroundTransparency = i
		end
		notifyGUI:Destroy()
	end
	
	-- Dissolve the notification after 6.5 seconds
	wait(6.5)
	dissolveNotify()
end
coroutine.wrap(EVLX_fake_script)()
