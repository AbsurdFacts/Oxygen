--[[ 
vape how the fuck u dont have a MotionBlur :troll:


OXYGEN 2.1!!!!
]]--

writefile("Oxygen 2.1/game/" .. game.GameId ..".lua","local GameID = " .. game.GameId)

local UI = Instance.new("ScreenGui")
local OpenFrame = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIFrame = Instance.new("Frame")
local Combat = Instance.new("ScrollingFrame")
local CombatText = Instance.new("TextLabel")
local Speed = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Aura = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local Fly = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local Visuals = Instance.new("ScrollingFrame")
local VisualsText = Instance.new("TextLabel")
local Skybox = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local CustomCape = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local Disguise = Instance.new("TextButton")
local UICorner_7 = Instance.new("UICorner")
local World = Instance.new("ScrollingFrame")
local WorldText = Instance.new("TextLabel")
local ChatSpammer = Instance.new("TextButton")
local UICorner_8 = Instance.new("UICorner")
local ChatDisabler = Instance.new("TextButton")
local UICorner_9 = Instance.new("UICorner")
local MotionBlur = Instance.new("TextButton")
local UICorner_10 = Instance.new("UICorner")
local FreeKit = Instance.new("TextBox")
local ClaimKit = Instance.new("TextButton")
local UICorner_11 = Instance.new("UICorner")
local Intro = Instance.new("Frame")
local IntroText = Instance.new("TextLabel")

--Properties:

UI.Name = "UI"
UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UI.ResetOnSpawn = false

OpenFrame.Name = "OpenFrame"
OpenFrame.Parent = UI
OpenFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
OpenFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
OpenFrame.BorderSizePixel = 0
OpenFrame.Position = UDim2.new(0.0237134211, 0, 0.466225177, 0)
OpenFrame.Size = UDim2.new(0.0499495454, 0, 0.0662251636, 0)
OpenFrame.Font = Enum.Font.Unknown
OpenFrame.Text = "Oxygen"
OpenFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
OpenFrame.TextSize = 29.000
OpenFrame.TextWrapped = true

UICorner.Parent = OpenFrame

UIFrame.Name = "UIFrame"
UIFrame.Parent = UI
UIFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UIFrame.BackgroundTransparency = 1.000
UIFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
UIFrame.BorderSizePixel = 0
UIFrame.Size = UDim2.new(1, 0, 1, 0)

Combat.Name = "Combat"
Combat.Parent = UIFrame
Combat.Active = true
Combat.BackgroundColor3 = Color3.fromRGB(150, 149, 151)
Combat.BorderColor3 = Color3.fromRGB(0, 0, 0)
Combat.BorderSizePixel = 0
Combat.Position = UDim2.new(0.226395935, 0, 0.0536809824, 0)
Combat.Size = UDim2.new(0.113705583, 0, 0.536809802, 0)

CombatText.Name = "CombatText"
CombatText.Parent = Combat
CombatText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CombatText.BackgroundTransparency = 1.000
CombatText.BorderColor3 = Color3.fromRGB(0, 0, 0)
CombatText.BorderSizePixel = 0
CombatText.Position = UDim2.new(0.0535714291, 0, 0, 0)
CombatText.Size = UDim2.new(0, 200, 0, 50)
CombatText.Font = Enum.Font.SourceSansBold
CombatText.Text = "Combat"
CombatText.TextColor3 = Color3.fromRGB(255, 255, 255)
CombatText.TextScaled = true
CombatText.TextSize = 14.000
CombatText.TextWrapped = true

Speed.Name = "Speed"
Speed.Parent = Combat
Speed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Speed.BorderColor3 = Color3.fromRGB(0, 0, 0)
Speed.BorderSizePixel = 0
Speed.Position = UDim2.new(0.0535714291, 0, 0.0457142852, 0)
Speed.Size = UDim2.new(0, 200, 0, 50)
Speed.Font = Enum.Font.SourceSansBold
Speed.Text = "Speed"
Speed.TextColor3 = Color3.fromRGB(0, 0, 0)
Speed.TextScaled = true
Speed.TextSize = 14.000
Speed.TextWrapped = true

UICorner_2.Parent = Speed

Aura.Name = "Aura"
Aura.Parent = Combat
Aura.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Aura.BorderColor3 = Color3.fromRGB(0, 0, 0)
Aura.BorderSizePixel = 0
Aura.Position = UDim2.new(0.0535714291, 0, 0.092582047, 0)
Aura.Size = UDim2.new(0, 200, 0, 50)
Aura.Font = Enum.Font.SourceSansBold
Aura.Text = "Aura"
Aura.TextColor3 = Color3.fromRGB(0, 0, 0)
Aura.TextScaled = true
Aura.TextSize = 14.000
Aura.TextWrapped = true

UICorner_3.Parent = Aura

Fly.Name = "Fly"
Fly.Parent = Combat
Fly.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fly.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fly.BorderSizePixel = 0
Fly.Position = UDim2.new(0.0535714291, 0, 0.142077118, 0)
Fly.Size = UDim2.new(0, 200, 0, 50)
Fly.Font = Enum.Font.SourceSansBold
Fly.Text = "Fly"
Fly.TextColor3 = Color3.fromRGB(0, 0, 0)
Fly.TextScaled = true
Fly.TextSize = 14.000
Fly.TextWrapped = true

UICorner_4.Parent = Fly

Visuals.Name = "Visuals"
Visuals.Parent = UIFrame
Visuals.Active = true
Visuals.BackgroundColor3 = Color3.fromRGB(150, 149, 151)
Visuals.BorderColor3 = Color3.fromRGB(0, 0, 0)
Visuals.BorderSizePixel = 0
Visuals.Position = UDim2.new(0.423857868, 0, 0.035276074, 0)
Visuals.Size = UDim2.new(0.113705583, 0, 0.536809802, 0)

VisualsText.Name = "VisualsText"
VisualsText.Parent = Visuals
VisualsText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
VisualsText.BackgroundTransparency = 1.000
VisualsText.BorderColor3 = Color3.fromRGB(0, 0, 0)
VisualsText.BorderSizePixel = 0
VisualsText.Position = UDim2.new(0.0535714291, 0, 0, 0)
VisualsText.Size = UDim2.new(0, 200, 0, 50)
VisualsText.Font = Enum.Font.SourceSansBold
VisualsText.Text = "Visuals"
VisualsText.TextColor3 = Color3.fromRGB(255, 255, 255)
VisualsText.TextScaled = true
VisualsText.TextSize = 14.000
VisualsText.TextWrapped = true

Skybox.Name = "Skybox"
Skybox.Parent = Visuals
Skybox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Skybox.BorderColor3 = Color3.fromRGB(0, 0, 0)
Skybox.BorderSizePixel = 0
Skybox.Position = UDim2.new(0.0535714291, 0, 0.0457142852, 0)
Skybox.Size = UDim2.new(0, 200, 0, 50)
Skybox.Font = Enum.Font.SourceSansBold
Skybox.Text = "Skybox"
Skybox.TextColor3 = Color3.fromRGB(0, 0, 0)
Skybox.TextScaled = true
Skybox.TextSize = 14.000
Skybox.TextWrapped = true

UICorner_5.Parent = Skybox

CustomCape.Name = "CustomCape"
CustomCape.Parent = Visuals
CustomCape.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CustomCape.BorderColor3 = Color3.fromRGB(0, 0, 0)
CustomCape.BorderSizePixel = 0
CustomCape.Position = UDim2.new(0.0535714291, 0, 0.0931755081, 0)
CustomCape.Size = UDim2.new(0, 200, 0, 50)
CustomCape.Font = Enum.Font.SourceSansBold
CustomCape.Text = "CustomCape"
CustomCape.TextColor3 = Color3.fromRGB(0, 0, 0)
CustomCape.TextScaled = true
CustomCape.TextSize = 14.000
CustomCape.TextWrapped = true

UICorner_6.Parent = CustomCape

Disguise.Name = "Disguise"
Disguise.Parent = Visuals
Disguise.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Disguise.BorderColor3 = Color3.fromRGB(0, 0, 0)
Disguise.BorderSizePixel = 0
Disguise.Position = UDim2.new(0.0535714291, 0, 0.141746938, 0)
Disguise.Size = UDim2.new(0, 200, 0, 50)
Disguise.Font = Enum.Font.SourceSansBold
Disguise.Text = "Disguise"
Disguise.TextColor3 = Color3.fromRGB(0, 0, 0)
Disguise.TextScaled = true
Disguise.TextSize = 14.000
Disguise.TextWrapped = true

UICorner_7.Parent = Disguise

World.Name = "World"
World.Parent = UIFrame
World.Active = true
World.BackgroundColor3 = Color3.fromRGB(150, 149, 151)
World.BorderColor3 = Color3.fromRGB(0, 0, 0)
World.BorderSizePixel = 0
World.Position = UDim2.new(0.61624366, 0, 0.0536809824, 0)
World.Size = UDim2.new(0.113705583, 0, 0.536809802, 0)

WorldText.Name = "WorldText"
WorldText.Parent = World
WorldText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WorldText.BackgroundTransparency = 1.000
WorldText.BorderColor3 = Color3.fromRGB(0, 0, 0)
WorldText.BorderSizePixel = 0
WorldText.Position = UDim2.new(0.0535714291, 0, 0, 0)
WorldText.Size = UDim2.new(0, 200, 0, 50)
WorldText.Font = Enum.Font.SourceSansBold
WorldText.Text = "World"
WorldText.TextColor3 = Color3.fromRGB(255, 255, 255)
WorldText.TextScaled = true
WorldText.TextSize = 14.000
WorldText.TextWrapped = true

ChatSpammer.Name = "ChatSpammer"
ChatSpammer.Parent = World
ChatSpammer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ChatSpammer.BorderColor3 = Color3.fromRGB(0, 0, 0)
ChatSpammer.BorderSizePixel = 0
ChatSpammer.Position = UDim2.new(0.0535714291, 0, 0.0457142852, 0)
ChatSpammer.Size = UDim2.new(0, 200, 0, 50)
ChatSpammer.Font = Enum.Font.SourceSansBold
ChatSpammer.Text = "ChatSpammer"
ChatSpammer.TextColor3 = Color3.fromRGB(0, 0, 0)
ChatSpammer.TextScaled = true
ChatSpammer.TextSize = 14.000
ChatSpammer.TextWrapped = true

UICorner_8.Parent = ChatSpammer

ChatDisabler.Name = "ChatDisabler"
ChatDisabler.Parent = World
ChatDisabler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ChatDisabler.BorderColor3 = Color3.fromRGB(0, 0, 0)
ChatDisabler.BorderSizePixel = 0
ChatDisabler.Position = UDim2.new(0.0535714291, 0, 0.0903183669, 0)
ChatDisabler.Size = UDim2.new(0, 200, 0, 50)
ChatDisabler.Font = Enum.Font.SourceSansBold
ChatDisabler.Text = "ChatDisabler"
ChatDisabler.TextColor3 = Color3.fromRGB(0, 0, 0)
ChatDisabler.TextScaled = true
ChatDisabler.TextSize = 14.000
ChatDisabler.TextWrapped = true

UICorner_9.Parent = ChatDisabler

MotionBlur.Name = "MotionBlur"
MotionBlur.Parent = World
MotionBlur.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MotionBlur.BorderColor3 = Color3.fromRGB(0, 0, 0)
MotionBlur.BorderSizePixel = 0
MotionBlur.Position = UDim2.new(0.0535714291, 0, 0.135565624, 0)
MotionBlur.Size = UDim2.new(0, 200, 0, 50)
MotionBlur.Font = Enum.Font.SourceSansBold
MotionBlur.Text = "MotionBlur [OFF]"
MotionBlur.TextColor3 = Color3.fromRGB(0, 0, 0)
MotionBlur.TextScaled = true
MotionBlur.TextSize = 14.000
MotionBlur.TextWrapped = true

UICorner_10.Parent = MotionBlur

FreeKit.Name = "FreeKit"
FreeKit.Parent = World
FreeKit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FreeKit.BorderColor3 = Color3.fromRGB(0, 0, 0)
FreeKit.BorderSizePixel = 0
FreeKit.Position = UDim2.new(0.0535714291, 0, 0.193208188, 0)
FreeKit.Size = UDim2.new(0, 200, 0, 50)
FreeKit.Font = Enum.Font.SourceSansBold
FreeKit.PlaceholderText = "pyro"
FreeKit.Text = ""
FreeKit.TextColor3 = Color3.fromRGB(0, 0, 0)
FreeKit.TextScaled = true
FreeKit.TextSize = 14.000
FreeKit.TextWrapped = true

ClaimKit.Name = "ClaimKit"
ClaimKit.Parent = FreeKit
ClaimKit.BackgroundColor3 = Color3.fromRGB(40, 255, 0)
ClaimKit.BorderColor3 = Color3.fromRGB(0, 0, 0)
ClaimKit.BorderSizePixel = 0
ClaimKit.Position = UDim2.new(-0.001428833, 0, 1.15031826, 0)
ClaimKit.Size = UDim2.new(1, 0, 1, 0)
ClaimKit.Font = Enum.Font.SourceSansBold
ClaimKit.Text = "Claim"
ClaimKit.TextColor3 = Color3.fromRGB(0, 0, 0)
ClaimKit.TextScaled = true
ClaimKit.TextSize = 14.000
ClaimKit.TextWrapped = true

UICorner_11.Parent = ClaimKit

Intro.Name = "Intro"
Intro.Parent = UI
Intro.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Intro.BorderColor3 = Color3.fromRGB(0, 0, 0)
Intro.BorderSizePixel = 0
Intro.Size = UDim2.new(1, 0, 1, 0)

IntroText.Name = "IntroText"
IntroText.Parent = Intro
IntroText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IntroText.BackgroundTransparency = 1.000
IntroText.BorderColor3 = Color3.fromRGB(0, 0, 0)
IntroText.BorderSizePixel = 0
IntroText.Position = UDim2.new(0.391370565, 0, 0.464723915, 0)
IntroText.Size = UDim2.new(0.201015234, 0, 0.0966257676, 0)
IntroText.Font = Enum.Font.Merriweather
IntroText.Text = "Oxygen Client | 2.1"
IntroText.TextColor3 = Color3.fromRGB(254, 252, 255)
IntroText.TextScaled = true
IntroText.TextSize = 14.000
IntroText.TextTransparency = 1.000
IntroText.TextWrapped = true

-- Scripts:

local function JZIU_fake_script() -- OpenFrame.ToggleHackFrameVisibility 
	local script = Instance.new('LocalScript', OpenFrame)

	local openFrameButton = script.Parent -- Reference to the OpenFrame TextButton
	local hackFrame = openFrameButton.Parent:FindFirstChild("UIFrame") -- Find the HackFrame within the same parent
	
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
coroutine.wrap(JZIU_fake_script)()
local function JJCUMSD_fake_script() -- UI.InfJump 
	local script = Instance.new('LocalScript', UI)

	game:GetService("UserInputService").JumpRequest:connect(function()
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end)
end
coroutine.wrap(JJCUMSD_fake_script)()
local function VLQAIYZ_fake_script() -- Speed.Speed 
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
coroutine.wrap(VLQAIYZ_fake_script)()
local function MXNBZJH_fake_script() -- Aura.Aura 
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
coroutine.wrap(MXNBZJH_fake_script)()
local function QPEPHK_fake_script() -- Fly.Fly 
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
coroutine.wrap(QPEPHK_fake_script)()
local function MFLP_fake_script() -- Combat.Drag1 
	local script = Instance.new('LocalScript', Combat)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(MFLP_fake_script)()
local function TXNJNO_fake_script() -- Skybox.skybox 
	local script = Instance.new('LocalScript', Skybox)

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
coroutine.wrap(TXNJNO_fake_script)()
local function NPIUKR_fake_script() -- CustomCape.CustomCape 
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
coroutine.wrap(NPIUKR_fake_script)()
local function UHIF_fake_script() -- Visuals.Drag2 
	local script = Instance.new('LocalScript', Visuals)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(UHIF_fake_script)()
local function SMBIK_fake_script() -- Disguise.Disguise 
	local script = Instance.new('LocalScript', Disguise)

	local Lplr = game.Players.LocalPlayer
	
	local function ChangeAvatar()
		Lplr.CharacterAppearanceId = 4720262362
	end
	
	script.Parent.MouseButton1Click:Connect(ChangeAvatar)
end
coroutine.wrap(SMBIK_fake_script)()
local function SMREQ_fake_script() -- ChatSpammer.ChatSpammer 
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
coroutine.wrap(SMREQ_fake_script)()
local function BXBGQS_fake_script() -- ChatDisabler.ChatDisabler 
	local script = Instance.new('LocalScript', ChatDisabler)

	local function Spam()
		while true do
			wait(0.1)
			local args = {
				[1] = "f.u.c.k.i.s.g.o.o.d",
				[2] = "All"
			}
	
			game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
		end
	end
	
	script.Parent.MouseButton1Click:Connect(Spam)
end
coroutine.wrap(BXBGQS_fake_script)()
local function UHREJ_fake_script() -- MotionBlur.MotionBlur 
	local script = Instance.new('LocalScript', MotionBlur)

	local button = script.Parent
	local blurEffect = Instance.new("BlurEffect", game.Lighting)
	local player = game.Players.LocalPlayer
	local camera = game.Workspace.CurrentCamera
	
	blurEffect.Enabled = false
	local isBlurActive = false
	local blurIntensity = 5 -- Adjust the blur intensity as needed
	local lastCameraPosition = camera.CFrame.Position
	
	button.MouseButton1Click:Connect(function()
		isBlurActive = not isBlurActive
		if isBlurActive then
			button.Text = "MotionBlur [ON]"
		else
			button.Text = "MotionBlur [OFF]"
			blurEffect.Enabled = true
			blurEffect.Size = 0
		end
	end)
	
	local function updateBlur()
		if isBlurActive then
			local currentCameraPosition = camera.CFrame.Position
			local deltaPosition = (currentCameraPosition - lastCameraPosition).magnitude
			blurEffect.Size = math.clamp(deltaPosition * blurIntensity, 0, 24) -- Adjust max blur size as needed
			lastCameraPosition = currentCameraPosition
		end
	end
	
	game:GetService("RunService").RenderStepped:Connect(updateBlur)
end
coroutine.wrap(UHREJ_fake_script)()
local function AHNZA_fake_script() -- FreeKit.FreeKit 
	local script = Instance.new('LocalScript', FreeKit)

	local ExecuteButton = script.Parent.ClaimKit -- path to execute button
	local ExecuteTextbox = script.Parent -- path to executetextbox
	
	ExecuteButton.MouseButton1Click:Connect(function()
		game.Players.LocalPlayer:SetAttribute("PlayingAsKit", ExecuteTextbox)
	end)
end
coroutine.wrap(AHNZA_fake_script)()
local function UBTCIC_fake_script() -- World.Drag3 
	local script = Instance.new('LocalScript', World)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(UBTCIC_fake_script)()
local function DPJGXZR_fake_script() -- Intro.Handler 
	local script = Instance.new('LocalScript', Intro)

	local Text = script.Parent.IntroText
	local Screen = script.Parent
	
	Text.TextTransparency = 0.9
	wait(0.5)
	Text.TextTransparency = 0.8
	wait(0.5)
	Text.TextTransparency = 0.7
	wait(0.5)
	Text.TextTransparency = 0.6
	wait(0.5)
	Text.TextTransparency = 0.5
	wait(0.5)
	Text.TextTransparency = 0.4
	wait(0.5)
	Text.TextTransparency = 0.3
	wait(0.5)
	Text.TextTransparency = 0.2
	wait(0.5)
	Text.TextTransparency = 0.1
	wait(0.5)
	Text.TextTransparency = 0
	wait(5)
	Screen.Visible = false
end
coroutine.wrap(DPJGXZR_fake_script)()
