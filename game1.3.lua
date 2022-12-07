local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local DataStoreService = game:GetService("DataStoreService")
local PhysicsService = game:GetService("PhysicsService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local DataStoreKey = "7YvcbeObX2Q9KUEtyHgNLpCHTYD3Dr"

local Letters = {"A", "B", "C", "D", "E", "F", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}

local DataStore = DataStoreService:GetDataStore(DataStoreKey)
_G.DataStore = DataStore

local PlayerbaseData2 = ReplicatedStorage:WaitForChild("PlayerbaseData2") 
local CharStats = ReplicatedStorage:WaitForChild("CharStats")
local Storage = ReplicatedStorage:WaitForChild("Storage") 
local Events = ReplicatedStorage:WaitForChild("Events")
local Events2 = ReplicatedStorage:WaitForChild("Events2")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Values = ReplicatedStorage:WaitForChild("Values")
local ItemStats = Storage:WaitForChild("ItemStats")

local Characters = workspace:WaitForChild("Characters")

local Tools = ServerStorage:FindFirstChild("Tools")
local Resources = ServerStorage:WaitForChild("Resources")

local Holsters = Resources.Holsters
local Sounds = Resources.Sounds
local Animations = Resources.Animations
local MeleeSounds = Sounds.Melees

local UpdateClientEvent = Events:WaitForChild("UpdateClient")
local MOVZREPEvent = Events:WaitForChild("MOVZREP")
local BYZERSPROTECEvent = Events:WaitForChild("BYZERSPROTEC")
local DiedDataa = Events:WaitForChild("DiedDataa")
local BloodHitEvent = Events:WaitForChild("BloodHitEvent")
local ATMEvent = Events:WaitForChild("ATM")
local ResetBars = Events:WaitForChild("ResetBars")
local OHNRGEE = Events:WaitForChild("OHNRGEE")
local Notification = Events:WaitForChild("Notification")
local KillEvent = Events:WaitForChild("KillEvent")
local ClientWarn = Events:WaitForChild("ClientWarn")
local GotXP = Events:WaitForChild("GotXP")
local LevelUp = Events:WaitForChild("LevelUp")

local Effects = require(Modules.Effects)
local GunDamage = require(Modules.Damage)
local GetSellPrice = require(Modules:WaitForChild("GetSellPrice"))
local GetUnlockPrice = require(Modules:WaitForChild("GetUnlockPrice"))
local GetRefillPrice = require(Modules:WaitForChild("GetRefillPrice"))

local InventorySlotValues = {
	
	-- | Gun(s) | -- 
	["Sawn-Off"] = 3.5,
	["Beretta"] =3,
	["G-17"] =3,
	["TEC-9"] =3,
	["M1911"] = 3,
	["Uzi"] = 4,
	["Deagle"] = 3.5,
	["Ithaca-37"] = 5,
	["MAC-10"] = 4,
	["Tommy"] = 5,
	["AKS-74U"] = 5.5,
	["Mare"] = 5,
	["AKM"] = 6.5,
	["RPG-7"] = 8,
	["Super-Shorty"] = 3.5,
	["FNP-45"] = 3.5,
	["Magnum"] = 3.5,
	["G-18"] = 3,
	["MP7"] = 4.5,
	["UMP-45"] = 4.5,
	["M4A1-1"] = 6,
	["FN-FAL"] = 6.5,
	["M320-1"] = 4.5,
	
	-- | Melee(s) | --
	["Shiv"] = 0.5,
	["Wrench"] = 1.5,
	["Bayonet"] = 1.5,
	["Crowbar"] = 3.5,
	["Golfclub"] = 4,
	["Shovel"] = 4,
	["Bat"] = 4,
	["Balisong"] = 1,
	["Taiga"] = 3,
	["Rambo"] = 3,
	["Fire-Axe"] = 4,
	["Metal-Bat"] = 4,
	["Katana"] = 5,
	["Chainsaw"] = 6,
	["ERADICATOR"] = 4,
	["Slayer's Sword II"] = 9,
	["Cursed Dagger"] = 3,
	["Baton"] = 2,
}

local Scraps = {
	WhiteScraps = {
		["Beretta"] = 7,
		["Sawn-Off"] = 7,
		["Shovel"] = 9,
		["Molotov"] = 9,
		["Lockpick"] = 10,
		["Crowbar"] = 10,
		["Bayonet"] = 11,
		["Wrench"] = 12,
		["Shiv"] = 12,
		["Golfclub"] = 13,
	},
	
	GreenScraps = {
		["Beretta"] = 5,
		["Golfclub"] = 6,
		["Tec-9"] = 7,
		["Uzi"] = 8,
		["Sawn-Off"] = 10,
		["Bat"] = 9,
		["Grenade"] = 9,
		["Taiga"] = 8,
		["Lockpick"] = 8,
		["Crowbar"] = 9,
		["Molotov"] = 9,
		["Shovel"] = 12,

	},
	
	RedScraps = {
		["Tommy"] = 5,
		["Chainsaw"] = 5,
		["Deagle"] = 6,
		["C4"] = 7,
		["Uzi"] = 8,
		["M1911"] = 8,
		["Metal-Bat"] = 9,
		["Rambo"] = 11,
		["Fire-Axe"] = 12,
		["Machete"] = 13,
		["Balisong"] = 15,
	},	
}

_G.LoadedPlayers = {}
_G.PlayerData = {}

local PlayerProtection = {}

local LimbBlood = {
	Amount = { 6, 15 }, 
	Speed = 5, 
	Spread = { -55, 95 }, 
	Size = 5, 
	WidthScale = 2, 
	UpVector = Vector3.new(0, -5, 0), 
	RepeatCount = 1, 
	RepeatTick = 0.1, 
	MaxYAngle = nil
} 

local LimbBlood2 = {
	Amount = { 25, 30 }, 
	Speed = 30, 
	Spread = { -55, 95 }, 
	Size = 5, 
	WidthScale = 2, 
	UpVector = Vector3.new(0, 10, 0), 
	RepeatCount = 1, 
	RepeatTick = 0.1, 
	MaxYAngle = nil
} 

local XPAmounts = {
	["Down"] = 15,
	["AssistDown"] = 5,
	["BreakLimb"] = 15,
	["DecapLimb"] = 25,
	["ExplodeHead"] = 40,
	["Kill"] = 50,
	["Assist"] = 25,
	["Stun"] = 5,
	["CursePlayer"] = 5,
	["ArmorBreak"] = 25,
	["BurnTick"] = 7,
	["Hallows_Explosion"] = {
		[1] = 15,
		[2] = 5
	}
}

_G.XPAmounts = XPAmounts

local Codes = {
	["freedoublexp"] = {
		["Bank"] = 10000,
		["DoubleXP"] = {
			["Duration"] = 3600
		}
	}
}

local function GVF(Name)
	return CharStats and CharStats:FindFirstChild(Name)
end

_G.GVF = GVF

local function TeamCheck(Player1, Player2)
	if not (not Player1) and not (not Player1.Parent) and not (not Player2) and not (not Player2.Parent) then
		if Player1 == Player2 then
			return false
		elseif Player1.Character and Player2.Character and Player1.Character:FindFirstChild("IsRCU") and Player2.Character:FindFirstChild("IsRCU") then
			return true
		elseif Player1.TeamColor ~= Player2.TeamColor or Player1.Neutral == true and Player2.Neutral == true then
			return false
		else
			return true
		end
	end
end

_G.TeamCheck = TeamCheck

local function AddRagdoll(C)
	task.spawn(function()
		local Torso = C:FindFirstChild("Torso")
		local HumanoidRootPart = C:FindFirstChild("HumanoidRootPart")
		local Head = C:FindFirstChild("Head")
		if HumanoidRootPart then
			C.PrimaryPart = HumanoidRootPart
		end

		if Head then
			Head.Size = Vector3.new(1, 1, 1)	
		end
		if HumanoidRootPart then
			local CTs = Resources:WaitForChild("Ragdoll"):WaitForChild("CTs"):Clone()
			CTs.Parent = HumanoidRootPart
		end
		if Torso then
			for _, RagdollAttachment in pairs(Resources:WaitForChild("Ragdoll"):WaitForChild("RagdollAttachments"):GetChildren()) do
				if RagdollAttachment:IsA("Attachment") then
					local Clone = RagdollAttachment:Clone()
					Clone.Parent = Torso
				end
			end
			for _, BloodAttachment in pairs(ReplicatedStorage:WaitForChild("Storage"):WaitForChild("BloodStuff"):WaitForChild("BloodAttachments"):GetChildren()) do
				if BloodAttachment:IsA("Attachment") then
					local Clone = BloodAttachment:Clone()
					Clone.Parent = Torso
				end
			end
		end
		for _, v in pairs(Resources:WaitForChild("Ragdoll"):WaitForChild("Limbs"):GetChildren()) do
			if C:FindFirstChild(v.Name) then
				local Clone = v:WaitForChild(v.Name):WaitForChild("RagdollAttachment"):Clone()
				Clone.Parent = C:FindFirstChild(v.Name)
			end
		end
		for _, bp in pairs(C:GetChildren()) do
			if bp then
				if bp:IsA("BasePart") then
					if bp.Name ~= "HumanoidRootPart" then
						task.wait()
						
						local Collider = Instance.new("Part", bp)
						Collider.CFrame = bp.CFrame
						Collider.Massless = true
						Collider.CanCollide = false
						Collider.Transparency = 1
						Collider.Anchored = false
						Collider.Name = "Collider"

						local Weld = Instance.new("WeldConstraint", bp)
						Weld.Part0 = bp
						Weld.Part1 = Collider

						workspace.DescendantRemoving:Connect(function(d)
							if d == bp then
								Collider:Destroy()
							end
						end)

						if bp.Name == "Head" then
							Collider.Size = Vector3.new(1, 0.5, 0.5)
						elseif bp.Name == "Torso" then
							Collider.Size = Vector3.new(1, 1, 0.5)
						else
							Collider.Size = Vector3.new(0.5, 1, 0.5)
						end

						game:GetService("PhysicsService"):SetPartCollisionGroup(Collider, "Ragdolls")
					end
				end
			end
		end

		local CTs = HumanoidRootPart:FindFirstChild("CTs")
		if CTs then 
			for _, v in pairs(CTs:GetChildren()) do
				if v:IsA("BallSocketConstraint") then
					if Torso then
						for _, motor in pairs(Torso:GetChildren()) do
							if motor:IsA("Motor6D") then
								if string.match(v.Name, motor.Name) then
									if motor.Part1 then
										local Part0 = Torso:WaitForChild("Torso_"..motor.Part1.Name)
										local Part1 = motor.Part1:WaitForChild("RagdollAttachment")
										v.Attachment0 = Part0
										v.Attachment1 = Part1

										local HealthValue = CharStats[C.Name]:FindFirstChild("HealthValues"):FindFirstChild(motor.Part1.Name)
										if HealthValue then
											HealthValue.MotorValue.Value = motor.Name
										end
									end
								end
							end
						end
					end
				end
			end
		end

		for _, BP in pairs(C:GetChildren()) do
			if BP:IsA("BasePart") and BP.Name ~= "Collider" then
				if CharStats[C.Name].HealthValues:FindFirstChild(BP.Name) then
					if not CharStats[C.Name].HealthValues:FindFirstChild(BP.Name).Broken.Value and not CharStats[C.Name].HealthValues:FindFirstChild(BP.Name).Destroyed.Value then
						PhysicsService:SetPartCollisionGroup(BP, "Characters")
					end
				else
					PhysicsService:SetPartCollisionGroup(BP, "Characters")
				end
			end
		end

		local function CQH(Hat)
			task.wait()
			local Handle = Hat:FindFirstChild("Handle")
			if Handle then
				Handle.Size = Vector3.new()
				Handle.CanQuery = false
			end
		end

		for _, Hat in pairs(C:GetChildren()) do
			if Hat:IsA("Accessory") then
				CQH(Hat)
			end
		end

		C.ChildAdded:Connect(function(Hat)
			if Hat:IsA("Accessory") then
				CQH(Hat)
			end
		end)
	end)
end

_G.AddRagdoll = AddRagdoll

local function RagdollFunction(Player, chr, rag, charstats)
	if not Player:IsA("Model") then
		if Player then
			if Player.Character ~= chr then
				return
			end
		end
	else
		if Player ~= chr then
			return
		end
	end
	
	local Torso = chr:FindFirstChild("Torso")
	local Humanoid = chr:FindFirstChild("Humanoid")
	local HumanoidRootPart = chr:FindFirstChild("HumanoidRootPart")
	if Humanoid then
		Humanoid.BreakJointsOnDeath = false
		Humanoid.PlatformStand = rag
		
		if rag then
			Humanoid:UnequipTools()
		end
	end
	for _, L in pairs(chr:GetChildren()) do
		if L:IsA("BasePart") then
			if L:FindFirstChild("Collider") then
				L:FindFirstChild("Collider").CanCollide = rag
			end
		end
	end
	if not rag then
		if Torso then
			Torso.CFrame = CFrame.new(Torso.Position) * CFrame.Angles(0, 90, 0)
		end
	end
	if Torso and not Player:IsA("Model") then
		for _, v in pairs(Torso:GetChildren()) do
			if v:IsA("Motor6D") then
				if charstats then
					if charstats:FindFirstChild("HealthValues") then
						if v.Part1 then
							local hv = charstats:FindFirstChild("HealthValues"):FindFirstChild(v.Part1.Name)
							if hv then
								if hv.Value <= 0 and not hv.Broken.Value then
									v.Enabled = false
								else
									v.Enabled = not rag
								end
							end
						end
					end
				end
			end
		end
	end
end

local function GetBloodAttachment(Character, Limb)
	local Name = Limb.Name
	local LookFor = "RGAB_Neck"
	if Name == "Left Leg" then
		LookFor = "RGAB_Left Hip"
	elseif Name == "Right Arm" then
		LookFor = "RGAB_Right Shoulder"
	elseif Name == "Right Leg" then
		LookFor = "RGAB_Right Hip"
	elseif Name == "Left Arm" then
		LookFor = "RGAB_Left Shoulder"
	end
	return Character.Torso:FindFirstChild(LookFor)
end

local function GetMotor6D(Character, Name)
	local LookFor = "Neck"
	if Name == "Left Arm" then
		LookFor = "Left Shoulder"
	elseif Name == "Left Leg" then
		LookFor = "Left Hip"
	elseif Name == "Right Arm" then
		LookFor = "Right Shoulder"
	elseif Name == "Right Leg" then
		LookFor = "Right Hip"
	end
	return Character.Torso:FindFirstChild(LookFor)
end

local function r(Pl, t)
	pcall(function()
		local C = Pl
		if not C:IsA("Model") then
			C = Pl.Character
		end

		if C then 
			local CharStat = CharStats:FindFirstChild(Pl.Name)
			CharStat.RagdollTime.RagdollSwitch.Value = true
			CharStat.RagdollTime.RagdollSwitch2.Value = true

			local seed = math.random()
			CharStat.RagdollTime.RagdollSwitch.Code.Value = seed

			task.spawn(function()
				RagdollFunction(Pl, C, true, CharStat)

				task.wait(CharStat.RagdollTime.Value + t)

				if CharStat then
					if CharStat:FindFirstChild("RagdollTime") then
						if CharStat.RagdollTime:FindFirstChild("RagdollSwitch") then
							if CharStat.RagdollTime.RagdollSwitch.Code.Value == seed then
								if C then
									if C:FindFirstChildWhichIsA("Humanoid") then
										if C.Humanoid.Health > 0 then
											local headbroken = (CharStat.HealthValues.Head.Value <= 0 and CharStat.HealthValues.Head.Broken.Value) or ((CharStat.HealthValues["Left Leg"].Value <= 0 and not CharStat.HealthValues["Left Leg"].Broken.Value) and (CharStat.HealthValues["Right Leg"].Value <= 0 and not CharStat.HealthValues["Right Leg"].Broken.Value)) and CharStat.Downed.Value
											if not headbroken then
												RagdollFunction(Pl, C, false, CharStat)

												CharStat.RagdollTime.RagdollSwitch.Value = false
												CharStat.RagdollTime.RagdollSwitch2.Value = false
												CharStat.RagdollTime.Value = 0
											end
										end
									end
								end
							end

							CharStat.RagdollTime.Value -= t
						end
					end
				end
			end)

			CharStat.RagdollTime.Value += t
		end
	end)
end

_G.RAG = r

local function HV(HealthValue, Character, Player)
	if HealthValue.Value <= 0 then
		if Character:FindFirstChild("Torso") and Character:FindFirstChild("Head") and Character:FindFirstChild(HealthValue.Name) then
			if Character:FindFirstChild("Head") then
				if HealthValue.Name ~= "Head" then
					if Character.Humanoid.Health > 0 then
						if Character.Head:FindFirstChild("scream") then
							Character.Head.scream:Destroy()
						end

						local Screams = Resources.Sounds:WaitForChild("Screams"):GetChildren()
						local Scream = Screams[math.random(1, #Screams)]:Clone()
						Scream.Parent = Character["Head"]
						Scream:Play()
						game:GetService("Debris"):AddItem(Scream, 3)
					end
				end
			end

			if HealthValue.Broken.Value then
				local BoneBreaks = Resources.Sounds.BoneBreaks:GetChildren()
				local BoneBreak = BoneBreaks[math.random(1, #BoneBreaks)]:Clone()
				BoneBreak.Parent = Character["Head"]
				BoneBreak:Play()
				game:GetService("Debris"):AddItem(BoneBreak, 3)
			else						
				local GoreSounds = Resources.Sounds.Gore:GetChildren()
				local GoreSound = GoreSounds[math.random(1, #GoreSounds)]:Clone()
				GoreSound.Parent = Character["Head"]
				GoreSound:Play()
				game:GetService("Debris"):AddItem(GoreSound, 3)
			end

			if Player then
				OHNRGEE:FireClient(Player)
			end

			if not HealthValue.Broken.Value then
				local Stub = nil

				if Resources.BloodStubs:FindFirstChild(HealthValue.Name) then
					Stub = Resources.BloodStubs:FindFirstChild(HealthValue.Name).Main:Clone()
					if Stub then
						if Character.Torso then
							Stub.Parent = Character
							Stub:SetPrimaryPartCFrame(Character.Torso.CFrame)

							local WeldConstraint = Instance.new("WeldConstraint", Character.Torso)
							WeldConstraint.Part0 = Character.Torso
							WeldConstraint.Part1 = Stub.PrimaryPart

							ReplicatedStorage.Events.GorePart:FireAllClients(Stub)
						end
					end
				end
			end

			if not HealthValue.Destroyed.Value and not HealthValue.Broken.Value then
				if Character:FindFirstChild("Torso") then
					for _, motor in pairs(Character:WaitForChild("Torso"):GetChildren()) do
						if motor:IsA("Motor6D") then
							if motor.Part1 then
								if motor.Part1.Name == HealthValue.Name then
									motor.Enabled = false
								end
							end
						end
					end
				end

				game.Debris:AddItem(Character[HealthValue.Name], 7)

				if HealthValue.Name == "Head" then
					Character.Humanoid.Health = 0
				end
				if Character:FindFirstChild("HumanoidRootPart") then
					if Character.HumanoidRootPart:FindFirstChild("CTs") then
						if HealthValue.Name == "Head" then
							Character:FindFirstChild("HumanoidRootPart"):WaitForChild("CTs"):WaitForChild("RGCT_Neck").Enabled = false
						elseif HealthValue.Name == "Left Arm" then
							Character:FindFirstChild("HumanoidRootPart"):WaitForChild("CTs"):WaitForChild("RGCT_Left Shoulder").Enabled = false
						elseif HealthValue.Name == "Right Arm" then
							Character:FindFirstChild("HumanoidRootPart"):WaitForChild("CTs"):WaitForChild("RGCT_Right Shoulder").Enabled = false
						elseif HealthValue.Name == "Left Leg" then
							Character:FindFirstChild("HumanoidRootPart"):WaitForChild("CTs"):WaitForChild("RGCT_Left Hip").Enabled = false
						elseif HealthValue.Name == "Right Leg" then
							Character:FindFirstChild("HumanoidRootPart"):WaitForChild("CTs"):WaitForChild("RGCT_Right Hip").Enabled = false
						end
					end
				end

				if Character:FindFirstChild("Torso") then
					local attachment = GetBloodAttachment(Character, HealthValue)
					Events.BloodTrailEvent:FireAllClients(attachment, LimbBlood, true)
				end

				Character:FindFirstChild(HealthValue.Name).Velocity = Vector3.new(math.random(-1, 1), 1, math.random(-1, 1)) * 5

				local col = Instance.new("Part", Character[HealthValue.Name])
				if col then
					if HealthValue.Name == "Head" then
						col.Size = Vector3.new(1, 0.5, 0.5)
					else
						col.Size = Vector3.new(0.5, 0.85, 0.5)
					end

					col.Transparency = 1
					col.Massless = true
					col.Anchored = false
					col.CanCollide = true
					col.CFrame = Character:FindFirstChild(HealthValue.Name).CFrame

					local colwel = Instance.new("WeldConstraint", Character:FindFirstChild(HealthValue.Name))
					colwel.Part0 = Character:FindFirstChild(HealthValue.Name)
					colwel.Part1 = col

					game:GetService("PhysicsService"):SetPartCollisionGroup(col, "Ragdolls")
					game:GetService("PhysicsService"):SetPartCollisionGroup(Character[HealthValue.Name], "Ragdolls")
				end
			elseif HealthValue.Broken.Value and not HealthValue.Destroyed.Value then
				if HealthValue.Name == "Head" then
					if Character then
						local Head = Character:FindFirstChild("Head")
						if Head then
							local RagdollAttachment = Head:FindFirstChild("RagdollAttachment")
							if RagdollAttachment then
								RagdollAttachment.Orientation = Vector3.new(-30, 180, 180)
							end
						end
						Character.Humanoid.Health = 13

						if Character:FindFirstChild("Torso") then
							if Character.Torso:FindFirstChild("Neck") then
								Character.Torso.Neck.Enabled = false
							end
						end

						Head.CFrame = Character.Torso.CFrame * CFrame.new(Vector3.new(0, 1, 0)) * CFrame.Angles(90, 0, 0)
					end
				else
					local brk = false
					local con
					local Player = Players:GetPlayerFromCharacter(Character)
					if Player then
						con = Player.CharacterAdded:Connect(function()
							brk = true
							con:Disconnect()
							con = nil
						end)
					end

					for i = 1, math.huge do
						task.wait(1)

						HealthValue.Value += 1

						if HealthValue.Value >= HealthValue.MaxValue then
							break
						end
					end

					if HealthValue then
						if HealthValue:FindFirstChild("Broken") then
							HealthValue.Broken.Value = false
							HealthValue.Value = HealthValue.MaxValue
						end
					end
				end
			elseif HealthValue.Destroyed.Value then
				if HealthValue.Name == "Head" then
					for _, v in pairs(Character:GetChildren()) do
						if v:IsA("Accessory") then
							if v.Handle:FindFirstChildWhichIsA("Weld") then
								if v.Handle.AccessoryWeld.Part1 then
									if v.Handle.AccessoryWeld.Part1.Name == "Head" then
										v:Destroy()
									end
								end
							else
								v:Destroy()
							end
						end
					end

					for _, v in pairs(Character:GetChildren()) do
						local Parts = v:FindFirstChild("Parts")
						if Parts then
							local Head = Parts:FindFirstChild("Head")
							if Head then
								if Head:IsA("Folder") then
									Head:Destroy()
								end
							end
						end
					end

					if Character:FindFirstChild("Head") and Character:FindFirstChildWhichIsA("Humanoid") then
						Character.Head.Transparency = 1
						Character.Humanoid.Health = 0

						for _, Decal in pairs(Character.Head:GetChildren()) do
							if Decal:IsA("Decal") then
								Decal.Transparency = 1
							end
						end
					end
				end
			end
		end
	end
end

_G.HV = HV

local AllowanceTime = 600

local function Tag(TargetHumanoid, Player)
	if not TargetHumanoid or not Player then
		return
	end
	if TargetHumanoid:IsDescendantOf(Player.Character) or not CharStats:FindFirstChild(TargetHumanoid.Parent.Name) or TargetHumanoid.Health <= 0 then
		return
	end

	if CharStats[TargetHumanoid.Parent.Name]:FindFirstChild("Creator") and CharStats[TargetHumanoid.Parent.Name]:FindFirstChild("Assist") then
		if CharStats[TargetHumanoid.Parent.Name].Creator.Value then
			if CharStats[TargetHumanoid.Parent.Name].Creator.Value ~= Player then
				CharStats[TargetHumanoid.Parent.Name].Assist.Value = CharStats[TargetHumanoid.Parent.Name].Creator.Value	
			end
		end
		CharStats[TargetHumanoid.Parent.Name].Creator.Value = Player
	end
end

local function Combat(Player, Is, Time)
	local CharStat = CharStats:FindFirstChild(Player.Name)
	if CharStat then
		if Is then
			local inCombat_ = Instance.new("BoolValue")
			inCombat_.Name = "inCombat_"
			inCombat_.Parent = CharStat.Tags
			if Time then
				game.Debris:AddItem(inCombat_, Time)
			end
		else
			for _, v in pairs(CharStat.Tags:GetChildren()) do
				if v.Name == "inCombat_" then
					v:Destroy()
				end
			end
		end
	end
end

_G.Combat = Combat
_G.Tag = Tag

Players.PlayerAdded:Connect(function(Player)
	_G.LoadedPlayers[Player.Name] = Player

	local UserThumbnail = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

	local UserId = Player.UserId
	local PlayerData = {}
	
	PlayerData = DataStore:GetAsync(UserId.."PlayerData") or {
		["Cash"] = 0,
		["Bank"] = 10000,
		["Bounty"] = 0,
		["Level"] = 1,
		["XP"] = 0,
		["MaxXP"] = 1000,
		["ClientSettings"] = require(Modules.DefaultClientSettings),
		["DisplayName"] = nil,
		["RedeemedCodes"] = {},
		["DoubleXP"] = {
			["Enabled"] = false,
			["Timer"] = 0
		},
		["Data"] = {
			["Unlocked"] = {}
		},
		["Armour"] = {}
 	}

	task.wait()
	
	if not CharStats:FindFirstChild(Player.Name) then
		local CharStat = Resources.Data.CharStat:Clone()
		CharStat.Name = Player.Name
		CharStat.Parent = CharStats
	end

	if not PlayerbaseData2:FindFirstChild(Player.Name) then
		local PlayerbaseData = Resources.Data.PlayerbaseData:Clone()
		PlayerbaseData.Name = Player.Name
		PlayerbaseData.Parent = PlayerbaseData2
		PlayerbaseData.Loaded.Value = true
	end

	local Debounce = false

	local function BountyAlert()
		local ActualBounty = PlayerData.Bounty
		if ActualBounty then
			if ActualBounty >= 1000 and Player.Character then
				if Debounce then
					return
				end

				Debounce = true
				
				local ShowName = Player.DisplayName
				pcall(function()
					ShowName = require(Modules.GetCharName)(Player.Character)
				end)
				
				Notification:FireAllClients({
					Title = "Bounty Alert",
					Text = ShowName..": ".._G.PlayerData[Player.Name].Bounty.."",
					ViewportIcon = Player.Character,
					Button1 = "Close",
					Duration = 5
				}, "Beep2")

				task.wait(30)

				Debounce = false
			elseif ActualBounty < 1000 then
				Debounce = false
			end
		end
	end

	if not Player:FindFirstChild("leaderstats") then
		local leaderstats = Resources.Data.leaderstats:Clone()
		leaderstats.Parent = Player
		leaderstats.Level.Value = PlayerData.Level
	end

	local leaderstats = Player:WaitForChild("leaderstats")
	local CharStat = CharStats:FindFirstChild(Player.Name)
	local PlayerbaseData = PlayerbaseData2:FindFirstChild(Player.Name)
	
	PlayerbaseData.Bounty.Amount:GetPropertyChangedSignal("Value"):Connect(function()
		BountyAlert()
	end)
	
	PlayerbaseData.DoubleXP.Value = PlayerData.DoubleXP.Enabled
	PlayerbaseData.DoubleXP.Timer.Value = PlayerData.DoubleXP.Timer

	PlayerProtection[Player.Name] = {
		["Amt"] = 60,
		["Is"] = false
	}

	if DataStore:GetAsync(UserId.."Unlocked") then
		for _, v in pairs(DataStore:GetAsync(UserId.."Unlocked")) do
			PlayerData.Data.Unlocked[v] = v

			local Item = Instance.new("BoolValue", PlayerbaseData.Unlocked)
			Item.Name = v
		end
	end

	_G.PlayerData[Player.Name] = PlayerData

	if not Player:FindFirstChild("DataLoaded") then
		local DataLoaded = Instance.new("BoolValue", Player)
		DataLoaded.Name = "DataLoaded"
	end

	if not Player:FindFirstChild("PlayerGui") then
		repeat
			task.wait(1)
		until Player:FindFirstChild("PlayerGui")
	end

	local Intro = Resources.Intro:Clone()
	Intro.Parent = Player.PlayerGui

	local Loaded = false
	local Looping = false

	local combatlogged = false
	local armorloaded = false

	local DiedTakeCash = 0

	local HasDied = false
	
	local Amt = 60
	
	CharStat.ArmorHP.Body:GetPropertyChangedSignal("Value"):Connect(function()
		if CharStat.ArmorHP.Body.Value <= 0 then
			if Player.Character then
				for _, v in pairs(Player.Character:GetChildren()) do
					if string.match(v.Name, "Vest") then
						require(v.BrokenM)(nil, "Broken")
					end
				end
			end
		elseif CharStat.ArmorHP.Body.Value >= CharStat.ArmorHP.Body.MaxValue then
			if Player.Character then
				for _, v in pairs(Player.Character:GetChildren()) do
					if string.match(v.Name, "Vest") then
						require(v.BrokenM)(nil, "Repaired")
					end
				end
			end
		end
	end)
	
	CharStat.ArmorHP.Head:GetPropertyChangedSignal("Value"):Connect(function()
		if CharStat.ArmorHP.Head.Value <= 0 then
			if Player.Character then
				for _, v in pairs(Player.Character:GetChildren()) do
					if string.match(v.Name, "Helmet") then
						require(v.BrokenM)(nil, "Broken")
					end
				end
			end
		elseif CharStat.ArmorHP.Head.Value >= CharStat.ArmorHP.Head.MaxValue then
			if Player.Character then
				for _, v in pairs(Player.Character:GetChildren()) do
					if string.match(v.Name, "Helmet") then
						require(v.BrokenM)(nil, "Repaired")
					end
				end
			end
		end
	end)
	
	Player.CharacterAdded:Connect(function(Character)
		task.wait()

		if not CollectionService:HasTag(Player, "Loaded") then
			Character:Destroy()
			return
		end
		
		local DiedData = {
			["KillerName"] = "N/A",
			["KillDistance"] = "N/A",
			["WeaponName"] = "N/A"
		}
		DiedDataa:FireClient(Player, DiedData)
		
		Amt = 60

		if HasDied then
			if DiedTakeCash then
				if DiedTakeCash > 0 then
					Events.Notification:FireClient(Player, {
						Title = "Cash Lost", 
						Text = "You lost $"..DiedTakeCash,
						Button1 = "Close",
						Duration = 5
					}, "lost")
				end
			end
		end
		
		DiedTakeCash = 0

		BountyAlert()

		pcall(function()
			Character.SpawnFF:Destroy()
		end)

		local SpawnFF = Instance.new("ForceField", Character)
		SpawnFF.Name = "SpawnFF"
		game.Debris:AddItem(SpawnFF, 15)
		
		Character.Archivable = true

		Character.Parent = Characters

		Character:WaitForChild("Humanoid")

		Character.Humanoid.MaxHealth = 115
		Character.Humanoid.Health = Character.Humanoid.MaxHealth
		Character.Humanoid.BreakJointsOnDeath = false
		Character.Humanoid.RequiresNeck = false

		Character.Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff

		CharStat.RagdollTime.RagdollSwitch.Value = false
		CharStat.RagdollTime.RagdollSwitch2.Value = false
		CharStat.RagdollTime.Value = 0
		CharStat.Downed.Value = false
		CharStat.Handcuffed.Value = false
		CharStat.Downed.Resisting.Value = false
		
		CharStat.InventorySlots.MaxValue = 10
		CharStat.InventorySlots.Value = CharStat.InventorySlots.MinValue
		CharStat.MovementSoundModifier.Value = 1
		CharStat.AccelerationModifier.Value = 1
		CharStat.ExplosiveProof.Value = 1
		CharStat.ExplosiveProof2.Value = 1

		for _, v in pairs(CharStat.MeleeProof:GetChildren()) do
			v.Value = 1
		end

		for _, v in pairs(CharStat.BulletProof:GetChildren()) do
			v.Value = 1
		end

		for _, v in pairs(CharStat.ArmoredParts:GetChildren()) do
			v.Value = false
		end

		for _, v in pairs(CharStat.ArmorHP:GetChildren()) do
			v.Value = v.MaxValue
		end
		
		local function LoadArmor()
			pcall(function()
				if armorloaded then
					return
				end
				
				armorloaded = true
				
				local VestTags
				local HelmetTags

				local Character = Player.Character

				if PlayerData.Armour then
					if PlayerData.Armour[1] then
						if PlayerData.Armour[1][1] then
							for _, v in pairs(Resources.Armour:GetChildren()) do
								local Armour = v:FindFirstChild(PlayerData.Armour[1][1])
								if Armour then
									Armour = Armour.Parent

									local IsVest = PlayerData.Armour[1][2]
									local IsHelmet = PlayerData.Armour[2][2]

									for _, ActualArmour in pairs(Armour:GetChildren()) do
										if ActualArmour:IsA("Folder") then

											VestTags = {
												[1] = ActualArmour.Name,
												[2] = true,
											}
											
											ActualArmour:Clone().Parent = Character
										end
									end

									if Character:FindFirstChild("VestA_3") then
										local Rigger_Vest = game:GetService("ServerStorage"):WaitForChild("Resources"):WaitForChild("Armour").Rigger_Vest:Clone()

										if not Character:FindFirstChild("VestA_3"):FindFirstChild("Rigger_Vest") then
											if IsVest == "true" then
												Rigger_Vest.Parent = Character:FindFirstChild("VestA_3")
												Rigger_Vest.Disabled = false
											end
										end
									elseif Character:FindFirstChild("VestA_2") then
										local Rigger_Vest = game:GetService("ServerStorage"):WaitForChild("Resources"):WaitForChild("Armour").Rigger_Vest:Clone()

										if not Character:FindFirstChild("VestA_2"):FindFirstChild("Rigger_Vest") then
											if IsVest == "true" then
												Rigger_Vest.Parent = Character:FindFirstChild("VestA_2")
												Rigger_Vest.Disabled = false
											end
										end
									elseif Character:FindFirstChild("VestA_1") then
										local Rigger_Vest = game:GetService("ServerStorage"):WaitForChild("Resources"):WaitForChild("Armour").Rigger_Vest:Clone()

										if not Character:FindFirstChild("VestA_1"):FindFirstChild("Rigger_Vest") then
											if IsVest == "true" then
												Rigger_Vest.Parent = Character:FindFirstChild("VestA_1")
												Rigger_Vest.Disabled = false
											end
										end
									end
								end	
							end
						end
					end
					if PlayerData.Armour[2] then
						if PlayerData.Armour[2][1] then
							for _, v in pairs(Resources.Armour:GetChildren()) do
								local Armour = v:FindFirstChild(PlayerData.Armour[2][1])
								if Armour then
									local IsHelmet = PlayerData.Armour[2][2]
									
									for _, ActualArmour in pairs(Armour:GetChildren()) do
										if ActualArmour:IsA("Folder") then

											HelmetTags = {
												[1] = Armour.Name,
												[2] = true,
											}

											ActualArmour:Clone().Parent = Character
										end
									end
									
									if Character:FindFirstChild("HelmetA_1") then
										local Rigger_Helmet = game:GetService("ServerStorage"):WaitForChild("Resources"):WaitForChild("Armour").Rigger_Helmet:Clone()

										if not Character:FindFirstChild("HelmetA_1"):FindFirstChild("Rigger_Helmet") then
											if IsHelmet == "true" then
												Rigger_Helmet.Parent = Character:FindFirstChild("HelmetA_1")
												Rigger_Helmet.Disabled = false
											end
										end
									elseif Character:FindFirstChild("HelmetA_2") then
										local Rigger_Helmet = game:GetService("ServerStorage"):WaitForChild("Resources"):WaitForChild("Armour").Rigger_Helmet:Clone()

										if not Character:FindFirstChild("HelmetA_2"):FindFirstChild("Rigger_Helmet") then
											if IsHelmet == "true" then
												Rigger_Helmet.Parent = Character:FindFirstChild("HelmetA_2")
												Rigger_Helmet.Disabled = false
											end
										end
									elseif Character:FindFirstChild("HelmetA_3") then
										local Rigger_Helmet = game:GetService("ServerStorage"):WaitForChild("Resources"):WaitForChild("Armour").Rigger_Helmet:Clone()

										if not Character:FindFirstChild("HelmetA_3"):FindFirstChild("Rigger_Helmet") then
											if IsHelmet == "true" then
												Rigger_Helmet.Parent = Character:FindFirstChild("HelmetA_3")
												Rigger_Helmet.Disabled = false
											end
										end
									end
								end
							end
						end
					end
				end
				
				if ReplicatedStorage.Values.DataSaving.Value then
					local Armour = {}

					if VestTags then
						Armour[1] = VestTags
					end

					if HelmetTags then
						Armour[2] = HelmetTags
					end

					PlayerData.Armour = Armour
				end
			end)
		end
		
		local IsCombat = DataStore:GetAsync(UserId.."Combat")
		DataStore:SetAsync(UserId.."Combat", {})
		if IsCombat then
			if IsCombat and IsCombat[1] then
				if not combatlogged then
					combatlogged = true

					local CombatLogGUI = Storage.GUIs.CombatLogGUI:Clone()
					CombatLogGUI.LostMoney.Value = IsCombat[1]
					CombatLogGUI.LostItems.Value = IsCombat[2]
					CombatLogGUI.Enabled = true
					CombatLogGUI.Parent = Player.PlayerGui
				end
			else
				LoadArmor()
			end
		else
			LoadArmor()
		end

		CharStat.Currents:ClearAllChildren()
		CharStat.FOVs:ClearAllChildren()
		CharStat.Tags:ClearAllChildren()

		for _, HealthValue in pairs(CharStat.HealthValues:GetChildren()) do
			HealthValue.MaxValue = 100
			HealthValue.Value = HealthValue.MaxValue
			HealthValue.Destroyed.Value = false
			HealthValue.Broken.Value = false
		end

		if PlayerData.DisplayName and not Loaded then
			Character.Humanoid.DisplayName = PlayerData.DisplayName
			PlayerData.DisplayName = nil
			Loaded = true
		else
			if PlayerData.ClientSettings.HideName then
				local Name = "#"
				for i = 1, 4 do
					local letter = math.random(1, #Letters)
					Name = Name..string.lower(Letters[letter])
				end

				Character.Humanoid.DisplayName = Name
				PlayerData.DisplayName = Name
			end
		end

		Character.ChildRemoved:Connect(function(C)
			if C.Name == "Head" or C.Name == "HumanoidRootPart" then
				if Character then
					if Character:FindFirstChild("Humanoid") then
						Character.Humanoid.Health = 0
					end
				end
			end
		end)

		Character.ChildAdded:Connect(function(C)
			if C:IsA("Tool") then
				if SpawnFF then
					SpawnFF:Destroy()
				end
			end
		end)

		for _, Tool in pairs(ServerStorage.StarterTools:GetChildren()) do
			if not Player.Backpack:FindFirstChild(Tool.Name) then
				Tool:Clone().Parent = Player.Backpack
			end
		end

		for _, Sound in pairs(Sounds.Head:GetChildren()) do
			if not Character.Head:FindFirstChild(Sound.Name) then
				Sound:Clone().Parent = Character.Head
			end
		end

		AddRagdoll(Character)

		for _, v in pairs(Storage.FistPoints:GetChildren()) do
			v:Clone().Parent = Character["Right Arm"]
			v:Clone().Parent = Character["Left Arm"]
			v:Clone().Parent = Character["Right Leg"]
		end

		Character.Humanoid.Died:Connect(function()
			if Character.Humanoid.Health <= 0 and not game:GetService("CollectionService"):HasTag(Character, "Dead") and CharStat and CharStat:FindFirstChild("Downed") then
				game:GetService("CollectionService"):AddTag(Character, "Dead")

				pcall(function()
					Character.Head.Face.Texture = "rbxassetid://15426038"
				end)
				pcall(function()
					Character.Head.face.Texture = "rbxassetid://15426038"
				end)

				if Character:FindFirstChild("Torso") then
					local DeadLight = Instance.new("PointLight", Character.Torso)
					DeadLight.Color = Color3.fromRGB(255, 0, 0)
					DeadLight.Brightness = 5
					DeadLight.Shadows = true
					DeadLight.Range = 7
					DeadLight.Name = "DeadLight"

					local DeadUI = Storage.GUIs:WaitForChild("DeadGUI"):Clone()
					DeadUI.Parent = Character.Torso
					DeadUI.PlayerToHideFrom = Player
				end

				HasDied = true

				local deaths = Sounds:WaitForChild("Deaths"):GetChildren()
				local death = deaths[math.random(1, #deaths)]:Clone()
				if Character:FindFirstChild("Head") then
					death.Parent = Character:WaitForChild("Head")
					death:Play()
					game.Debris:AddItem(death, death.TimeLength / death.PlaybackSpeed)
				end

				if Character:FindFirstChild("Head") then
					for _, v in pairs(Character.Head:GetChildren()) do
						if v:FindFirstChild("Vocal") then
							v:Destroy()
						end
					end

					Character.Head.ChildAdded:Connect(function(v)
						task.wait()
						if v:FindFirstChild("Vocal") then
							v:Destroy()
						end
					end)
				end

				CharStat.Downed.Value = false

				local Head = Character:FindFirstChild("Head")
				if Head then
					Character.PrimaryPart = Head
				end

				local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
				if Humanoid and PlayerbaseData then
					local Creator = CharStat:FindFirstChild("Creator")
					local Assist = CharStat:FindFirstChild("Assist")
					
					if PlayerbaseData.Bounty.Amount.Value >= 1000 then
						if Creator then
							if Creator.Value then
								local ShowName = Player.DisplayName
								pcall(function()
									ShowName = require(Modules.GetCharName)(Player.Character)
								end)

								Notification:FireAllClients({
									Title = "Bounty Alert",
									Text = ShowName.."'s ".._G.PlayerData[Player.Name].Bounty.." Bounty was claimed.",
									ViewportIcon = Player.Character,
									Button1 = "Close",
									Duration = 5
								}, "Beep2")
							end
						end
					end
					
					if Creator then
						if Creator.Value and _G.PlayerData[Creator.Value.Name] then
							local Cash = math.floor((40 + PlayerbaseData2[Player.Name].Bounty.Amount.Value) + 0.5)
							local Multi = 1
							if PlayerbaseData2:FindFirstChild(Creator.Value.Name) then
								if PlayerbaseData2[Creator.Value.Name].DoubleXP.Value then
									Multi = 2
								end
							end
							local XP = math.floor((XPAmounts.Kill + (PlayerbaseData2[Player.Name].Bounty.Amount.Value / 2)) + 0.5) * Multi

							local PlayerData = _G.PlayerData[Creator.Value.Name]
							if PlayerData then
								GotXP:FireClient(Creator.Value, XP)
								PlayerData.XP += XP
								UpdateClientEvent:FireClient(Creator.Value, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
							end

							_G.PlayerData[Creator.Value.Name].Bounty += 50
							PlayerbaseData2[Creator.Value.Name].Bounty.Amount.Value = _G.PlayerData[Creator.Value.Name].Bounty

							KillEvent:FireClient(Creator.Value, Character, Player.UserId, "KILLED", Cash, XP)

							_G.PlayerData[Creator.Value.Name].Cash += Cash

							UpdateClientEvent:FireClient(Creator.Value, false, _G.PlayerData[Creator.Value.Name].Data, _G.PlayerData[Creator.Value.Name].Bank, _G.PlayerData[Creator.Value.Name].Cash, _G.PlayerData[Creator.Value.Name], _G.PlayerData[Creator.Value.Name].Bounty)

							Creator.Value = nil
						end
					end
					
					if Assist then
						if Assist.Value and PlayerbaseData and _G.PlayerData[Assist.Value.Name] then
							local Cash = math.floor((25 + (PlayerbaseData.Bounty.Amount.Value / 1.5)) + 0.5)
							local Multi = 1
							if PlayerbaseData2:FindFirstChild(Assist.Value.Name) then
								if PlayerbaseData2[Assist.Value.Name].DoubleXP.Value then
									Multi = 2
								end
							end 
							local XP = math.floor((XPAmounts.Assist + (PlayerbaseData.Bounty.Amount.Value / 2.5)) + 0.5) * Multi

							local PlayerData = _G.PlayerData[Assist.Value.Name]
							if PlayerData then
								GotXP:FireClient(Assist.Value, XP)
								PlayerData.XP += XP
								UpdateClientEvent:FireClient(Assist.Value, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
							end

							_G.PlayerData[Assist.Value.Name].Bounty += 100
							PlayerbaseData2[Assist.Value.Name].Bounty.Amount.Value = _G.PlayerData[Assist.Value.Name].Bounty

							KillEvent:FireClient(Assist.Value, Character, Player.UserId, "ASSIST", Cash, XP)

							_G.PlayerData[Assist.Value.Name].Cash += Cash

							UpdateClientEvent:FireClient(Assist.Value, false, _G.PlayerData[Assist.Value.Name].Data, _G.PlayerData[Assist.Value.Name].Bank, _G.PlayerData[Assist.Value.Name].Cash, _G.PlayerData[Assist.Value.Name], _G.PlayerData[Assist.Value.Name].Bounty)

							Assist.Value = nil
						end		
					end
				end

				_G.PlayerData[Player.Name].Bounty = 0
				PlayerbaseData.Bounty.Amount.Value = 0
				
				coroutine.wrap(r)(Player, 1)

				local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
				if HumanoidRootPart then
					PhysicsService:SetPartCollisionGroup(HumanoidRootPart, "RagdollNoCollide")
				end

				pcall(function()
					Character.Torso["DownedLight"]:Destroy()
				end)

				pcall(function()
					Character.Torso["DownedBreathing"]:Destroy()
				end)

				pcall(function()
					Character.Torso["ReviveGUI"]:Destroy()
				end)

				pcall(function()
					Character.Torso["BleedOutGUI"]:Destroy()
				end)

				CharStat.Downed.Resisting.Value = false

				if PlayerData.Cash > 0 then
					local CheckCash = math.floor(PlayerData.Cash / 4 + 0.5)
					if CheckCash >= 50 then
						DiedTakeCash = math.clamp(CheckCash, 50, 1000)
					else
						DiedTakeCash = CheckCash
					end

					DiedTakeCash = math.floor(DiedTakeCash + 0.5)

					PlayerData.Cash -= DiedTakeCash

					UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

					task.spawn(function()
						task.wait(1)
						
						if DiedTakeCash > 0 then
							if Character then
								if Character:FindFirstChild("HumanoidRootPart") then
									local CF = Character.HumanoidRootPart.Position

									local Cash = Resources.CashDrop:Clone()
									Cash.Value.Value = DiedTakeCash
									Cash.A.GUI.TextLabel.Text = "$"..DiedTakeCash
									Cash.Position = CF
									Cash.Parent = workspace.Filter.SpawnedBread
								end
							end
						end
					end)
				end 
			end
		end)

		Character.Humanoid.HealthChanged:Connect(function()
			if CharStat then
				if CharStat:FindFirstChild("Downed") then
					if Character:FindFirstChild("Humanoid").Health < 15 then
						if Character:FindFirstChild("Torso") then
							if Character.Humanoid.Health > 0 then
								if not Character.Torso:FindFirstChild("DownedLight") and not Character.Torso:FindFirstChild("ReviveUI") and not CharStat.HealthValues.Head.Destroyed.Value and not CollectionService:HasTag(Character, "Downed") then
									CharStat.Downed.Value = true
									
									CollectionService:AddTag(Character, "Downed")

									if Character:FindFirstChild("Torso") then
										local DownedLight = Instance.new("PointLight", Character.Torso)
										DownedLight.Color = Color3.fromRGB(255, 170, 127)
										DownedLight.Brightness = 5
										DownedLight.Shadows = true
										DownedLight.Range = 5
										DownedLight.Name = "DownedLight"
									else
										return
									end

									local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
									if Humanoid then
										if Humanoid.Health > 0 then
											if PlayerbaseData and PlayerbaseData:FindFirstChild("DoubleXP") then
												local Creator = CharStat:FindFirstChild("Creator")
												local Assist = CharStat:FindFirstChild("Assist")
												
												if Creator then
													if Creator.Value then
														if not CollectionService:HasTag(Character, "GaveXP") then
															CollectionService:AddTag(Character, "GaveXP")

															local PlayerData = _G.PlayerData[Creator.Value.Name]
															if PlayerData then
																local Multi = 1
																if PlayerbaseData2[Creator.Value.Name].DoubleXP.Value then
																	Multi = 2
																end
																local XP = _G.XPAmounts.Down * Multi
																GotXP:FireClient(Creator.Value, XP)
																PlayerData.XP += XP
																UpdateClientEvent:FireClient(Creator.Value, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
															end
														end
													end
												end
												
												if Assist then
													if Assist.Value then
														if not CollectionService:HasTag(Character, "GaveXP2") then
															CollectionService:AddTag(Character, "GaveXP2")

															local PlayerData = _G.PlayerData[Assist.Value.Name]
															if PlayerData then
																local Multi = 1
																if PlayerbaseData2[Assist.Value.Name].DoubleXP.Value then
																	Multi = 2
																end
																local XP = _G.XPAmounts.Down * Multi
																GotXP:FireClient(Assist.Value, XP)
																PlayerData.XP += XP
																UpdateClientEvent:FireClient(Assist.Value, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
															end
														end
													end
												end
											end
										end
									end

									local is = false

									task.spawn(function()
										local con = nil
										con = Player.CharacterAdded:Connect(function()
											is = true
											con:Disconnect()
											con = nil
										end)
									end)

									if not is then
										if CharStat.Downed.Value then
											r(Player, 2)
										end

										if not is then
											local headbroken = (CharStat.HealthValues.Head.Value <= 0 and CharStat.HealthValues.Head.Broken.Value) or ((CharStat.HealthValues["Left Leg"].Value <= 0 and not CharStat.HealthValues["Left Leg"].Broken.Value) and (CharStat.HealthValues["Right Leg"].Value <= 0 and not CharStat.HealthValues["Right Leg"].Broken.Value)) and CharStat.Downed.Value
											if headbroken then
												local BleedOutGUI = Storage.GUIs:WaitForChild("BleedOutGUI"):Clone()
												BleedOutGUI.Parent = Character.Torso
												BleedOutGUI.PlayerToHideFrom = Player

												local function C()
													pcall(function()
														if Character.Humanoid.Health > 0 then
															BleedOutGUI.Frame.Bar.Size = UDim2.new(1, 0, 1 - (Character.Humanoid.Health / 15), 0)
														else
															BleedOutGUI:Destroy()
														end
													end)
												end

												Character.Humanoid.Health = 13

												RunService.Heartbeat:Connect(C)	

												repeat
													task.wait(2)
													if not Values.ZaWarudo.Value and Character.Humanoid.Health > 0 then
														Character.Humanoid:TakeDamage(1)
													end
												until Character.Humanoid.Health <= 0 or Character.Humanoid.Health > 15 or is

												CharStat.Downed.Value = false

												BleedOutGUI:Destroy()

												if Character.Humanoid.Health > 15 then
													local Head = Character:FindFirstChild("Head")
													if Head then
														local RagdollAttachment = Head:FindFirstChild("RagdollAttachment")
														if RagdollAttachment then
															RagdollAttachment.Orientation = Vector3.new(0, 0, 0)
														end
													end

													RagdollFunction(Player, Character, false, CharStat)

													local CharStat = CharStats:FindFirstChild(Player.Name)
													if CharStat then
														CharStat.RagdollTime.RagdollSwitch.Value = false
														CharStat.RagdollTime.RagdollSwitch2.Value = false
														CharStat.HealthValues.Head.Value = CharStat.HealthValues.Head.MaxValue
														CharStat.HealthValues.Head.Broken.Value = false
													end
												end
											elseif not headbroken and CharStat.Downed.Value then
												CharStat.RagdollTime.RagdollSwitch.Changed:Wait()

												if Character:FindFirstChild("Torso") and Character.Humanoid.Health > 0 and CharStat.Downed.Value and not game:GetService("CollectionService"):HasTag(Character, "BleedingOut") and not Character.Torso:FindFirstChild("ReviveUI") then
													local ReviveUI = Storage.GUIs:WaitForChild("ReviveGUI"):Clone()
													ReviveUI.Parent = Character.Torso

													local DownedBreathing = Sounds:WaitForChild("DownedBreathing"):Clone()
													DownedBreathing.Parent = Character.Torso
													DownedBreathing:Play()

													local function C()
														pcall(function()
															if Character.Humanoid.Health > 0 then
																if ReviveUI:FindFirstChild("Frame") then
																	local Color1 = Color3.fromRGB(255, 213, 0)
																	local Color2 = Color3.fromRGB(75, 0, 0)

																	local Color = Color1:Lerp(Color2, 1 - Character.Humanoid.Health / 15)

																	if CharStats:FindFirstChild(Character.Name) then
																		if CharStats[Character.Name].Currents:FindFirstChild("Reviving") then
																			ReviveUI.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(150, 255, 150)
																		else
																			ReviveUI.Frame.ImageLabel.ImageColor3 = Color
																		end
																	else
																		ReviveUI.Frame.ImageLabel.ImageColor3 = Color
																	end
																end
															end
														end)
													end

													RunService.Heartbeat:Connect(C)

													ReviveUI.PlayerToHideFrom = Player
												end
											end
										end
									end
								end
							end
						end
					else
						if Character:FindFirstChild("Torso") then
							if game:GetService("CollectionService"):HasTag(Character, "Downed") then
								CharStat.Downed.Value = false								
								
								game:GetService("CollectionService"):RemoveTag(Character, "Downed")

								pcall(function()
									Character.Torso["DownedLight"]:Destroy()
								end)

								pcall(function()
									Character.Torso["DownedBreathing"]:Destroy()
								end)

								pcall(function()
									Character.Torso["ReviveGUI"]:Destroy()
								end)

								CharStat.Downed.Resisting.Value = false

								CollectionService:RemoveTag(Character, "GaveXP")
								CollectionService:RemoveTag(Character, "GaveXP2")
							end
						end
					end
				end
			end
		end)
	end)
	
	Player.Backpack.ChildAdded:Connect(function(Child)
		task.wait()
		local Character = Player.Character
		if Character then
			if Child:IsA("Tool") then
				if not CollectionService:HasTag(Child, Player.Name) then
					local SlotUsage = 0
					if InventorySlotValues[Child.Name] then
						SlotUsage = InventorySlotValues[Child.Name]
					end

					CollectionService:AddTag(Child, Player.Name)

					if CharStat then
						if CharStat:FindFirstChild("InventorySlots") then
							CharStat.InventorySlots.Value += SlotUsage
						end
					end
				end
			end

			local Torso = Character:FindFirstChild("Torso")
			if Torso then
				local Holster = Holsters:FindFirstChild(Child.Name)
				if Holster then
					local Bool = Holster:FindFirstChildWhichIsA("BoolValue")
					if Bool then
						local Limb = Character:FindFirstChild(Bool.Name)
						if Limb then
							Torso = Limb
						end
					end

					Holster = Holster:Clone()

					local DisplayItems = Character:FindFirstChild("DisplayItems")
					if not DisplayItems then
						DisplayItems = Instance.new("Folder", Character)
						DisplayItems.Name = "DisplayItems"
					end

					if DisplayItems:FindFirstChild(Holster.Name) then
						Holster:Destroy()
						Holster = DisplayItems:FindFirstChild(Holster.Name)
					end

					for _, v in pairs(Holster:GetDescendants()) do
						if v:IsA("MeshPart") or v:IsA("BasePart") or v:IsA("Union") or v:IsA("Decal") then
							if v.Name ~= "Main" then
								v.Transparency = 0
							end
						end
					end

					Holster.Parent = DisplayItems
					Holster:SetPrimaryPartCFrame(Torso.CFrame)

					local Weld = Instance.new("WeldConstraint", Holster.PrimaryPart)
					Weld.Part0 = Torso
					Weld.Part1 = Holster.PrimaryPart

					for _, v in pairs(Holster:GetDescendants()) do
						if v:IsA("MeshPart") or v:IsA("BasePart") or v:IsA("Union") then
							game:GetService("PhysicsService"):SetPartCollisionGroup(v, "Holsters")
						end
					end

					for _, CurrentHolster in pairs(DisplayItems:GetChildren()) do
						if CurrentHolster ~= Holster then
							if Holster:FindFirstChild("Overwrite") then
								task.wait()
								if Holster.Overwrite:FindFirstChild(CurrentHolster.Name) then
									for _, v in pairs(CurrentHolster:GetDescendants()) do
										if v:IsA("MeshPart") or v:IsA("BasePart") or v:IsA("Union") or v:IsA("Decal") then
											if v.Name ~= "Main" then
												v.Transparency = 1
											end
										end
									end
									for _, v in pairs(Holster:GetDescendants()) do
										if v:IsA("MeshPart") or v:IsA("BasePart") or v:IsA("Union") or v:IsA("Decal") then
											if v.Name ~= "Main" then
												v.Transparency = 0
											end
										end
									end
								elseif CurrentHolster.Overwrite:FindFirstChild(Holster.Name) then
									for _, v in pairs(Holster:GetDescendants()) do
										if v:IsA("MeshPart") or v:IsA("BasePart") or v:IsA("Union") or v:IsA("Decal") then
											if v.Name ~= "Main" then
												v.Transparency = 1
											end
										end
									end
									for _, v in pairs(CurrentHolster:GetDescendants()) do
										if v:IsA("MeshPart") or v:IsA("BasePart") or v:IsA("Union") or v:IsA("Decal") then
											if v.Name ~= "Main" then
												v.Transparency = 0
											end
										end
									end
								end
							end
						end
					end	
				end
			end
		end
	end)

	Player.Backpack.ChildRemoved:Connect(function(Child)
		task.wait()
		local Character = Player.Character
		if Character then
			if Child:IsA("Tool") then
				if not Child:IsDescendantOf(Character) then
					if CollectionService:HasTag(Child, Player.Name) then
						local SlotUsage = 0
						if InventorySlotValues[Child.Name] then
							SlotUsage = InventorySlotValues[Child.Name]
						end

						CollectionService:RemoveTag(Child, Player.Name)

						if CharStat then
							if CharStat:FindFirstChild("InventorySlots") then
								CharStat.InventorySlots.Value -= SlotUsage
							end
						end
					end
				end
			end

			local Torso = Character:FindFirstChild("Torso")
			if Torso then
				local DisplayItems = Character:FindFirstChild("DisplayItems")
				if DisplayItems then
					local Holster = DisplayItems:FindFirstChild(Child.Name)
					if Holster then
						for _, CurrentHolster in pairs(DisplayItems:GetChildren()) do
							if CurrentHolster ~= Holster then
								if Holster:FindFirstChild("Overwrite") then
									task.wait()
									if Holster.Overwrite:FindFirstChild(CurrentHolster.Name) then
										for _, v in pairs(CurrentHolster:GetDescendants()) do
											if v:IsA("MeshPart") or v:IsA("BasePart") then
												if v.Name ~= "Main" then
													v.Transparency = 0
												end
											end
										end
									end
								end
							end
						end

						for _, v in pairs(Holster:GetDescendants()) do
							if v:IsA("MeshPart") or v:IsA("BasePart") then
								if v.Name ~= "Main" then
									v.Transparency = 1
								end
							end
						end
					end
				end
			end
		end
	end)

	for _, HealthValue in pairs(CharStat.HealthValues:GetChildren()) do
		HealthValue.Changed:Connect(function()
			local Character = Player.Character
			if Character then
				if Character:FindFirstChild(HealthValue.Name) then
					HV(HealthValue, Character, Player)
				end
			end
		end)
	end
	
	spawn(function()
		while true do
			task.wait()
			
			local PlayerData = _G.PlayerData[Player.Name]
			local leaderstats = Player:FindFirstChild("leaderstats")
			if PlayerData and leaderstats then
				if PlayerData.XP and PlayerData.MaxXP then
					if PlayerData.XP >= PlayerData.MaxXP then
						PlayerData.XP = (PlayerData.XP - PlayerData.MaxXP)
						PlayerData.Level += 1 
						leaderstats.Level.Value = PlayerData.Level
						PlayerData.MaxXP = 500 + (500 * PlayerData.Level)
						PlayerData.Bank += 1000 * PlayerData.Level
						
						LevelUp:FireClient(Player, PlayerData.Level, 1000 * PlayerData.Level)
					end
				end
			end
		end
	end)
	
	spawn(function()
		while true do
			task.wait()
			if not Player then
				break
			end
			if CharStat:FindFirstChild("Tags") then
				if Amt > 0 and not CharStat.Tags:FindFirstChild("inCombat_") then
					task.wait(1)

					if Player.Character then
						if PlayerProtection[Player.Name].Is then
							Amt -= 1
						else
							if Player.Character:FindFirstChild("ProtectionFF") then
								Amt -= 1
							end
						end

						local Text = ""

						if PlayerProtection[Player.Name].Is then
							Text = "Cooldown"
						end

						BYZERSPROTECEvent:FireClient(Player, Text, PlayerProtection[Player.Name].Amt)

						PlayerProtection[Player.Name].Amt = Amt
					end
				elseif Amt <= 0 or CharStat.Tags:FindFirstChild("inCombat_") then
					PlayerProtection[Player.Name].Is = not PlayerProtection[Player.Name].Is

					if PlayerProtection[Player.Name].Is then
						if Player.Character then
							if Player.Character:FindFirstChild("HumanoidRootPart") then
								Player.Character.HumanoidRootPart.Anchored = false

								if Player.Character:FindFirstChild("ProtectionFF") then
									Player.Character:FindFirstChild("ProtectionFF"):Destroy()
								end
							end
						end
					end

					Amt = 60

					task.wait()
				end
			end
		end
	end)
end)

local function SaveData(Player, Is)
	if PlayerbaseData2:FindFirstChild(Player.Name) then
		local PlayerData = _G.PlayerData[Player.Name]
		local UserId = Player.UserId

		local PlayerTools = {}

		for _, Tool in pairs(Player.Backpack:GetChildren()) do
			if not ServerStorage.StarterTools:FindFirstChild(Tool.Name) then
				PlayerTools[Tool.Name] = {
					["Name"] = Tool.Name, 
				} 
				
				if Tool:FindFirstChild("Values") then
					if Tool.Values:FindFirstChild("SERVER_Ammo") then
						PlayerTools[Tool.Name]["Ammo"] = Tool.Values.SERVER_Ammo.Value
					end
				end
				
				if Tool:FindFirstChild("Values") then
					if Tool.Values:FindFirstChild("SERVER_StoredAmmo") then
						PlayerTools[Tool.Name]["StoredAmmo"] = Tool.Values.SERVER_StoredAmmo.Value
					end
				end
			end
		end

		local Tool = _G.PlayerData[Player.Name].Tool

		if Tool then
			if not ServerStorage.StarterTools:FindFirstChild(Tool.Name) then
				PlayerTools[Tool.Name] = {
					["Name"] = Tool.Name, 
				} 
				
				if Tool:FindFirstChild("Values") then
					if Tool.Values:FindFirstChild("SERVER_Ammo") then
						PlayerTools[Tool.Name]["Ammo"] = Tool.Values.SERVER_Ammo.Value
					end
				end

				if Tool:FindFirstChild("Values") then
					if Tool.Values:FindFirstChild("SERVER_StoredAmmo") then
						PlayerTools[Tool.Name]["StoredAmmo"] = Tool.Values.SERVER_StoredAmmo.Value
					end
				end
			end
		end
		
		PlayerData.Tools = PlayerTools
		
		if CharStats[Player.Name].Tags:FindFirstChild("inCombat_") and not Values.ShuttingDown.Value then
			if not Is then
				PlayerData.Tools = {}				
				
				local TakeCash
				local CheckCash = math.floor(PlayerData.Cash / 4 + 0.5)
				if CheckCash >= 50 then
					TakeCash = math.clamp(CheckCash, 50, 1000)
				else
					TakeCash = CheckCash
				end

				TakeCash = math.floor(TakeCash + 0.5)

				PlayerData.Cash -= TakeCash

				local CurrentTools = 0
				if _G.PlayerData[Player.Name].Tool and not ServerStorage.StarterTools:FindFirstChild(_G.PlayerData[Player.Name].Tool.Name) then
					CurrentTools = 1
				end
				for _, Tool in pairs(Player.Backpack:GetChildren()) do
					if not ServerStorage.StarterTools:FindFirstChild(Tool.Name) then
						CurrentTools += 1
					end
				end

				DataStore:SetAsync(UserId.."Combat", {
					[1] = TakeCash,
					[2] = CurrentTools
				})			
			end
		end
		
		local Unlocks = {}

		for _, Unlock in pairs(PlayerbaseData2[Player.Name].Unlocked:GetChildren()) do
			Unlocks[Unlock.Name] = Unlock.Name
		end

		local RedeemedCodes = {}

		for _, RedeemedCode in pairs(PlayerData.RedeemedCodes) do
			RedeemedCodes[RedeemedCode] = RedeemedCode
		end
		
		PlayerData.RedeemedCodes = RedeemedCodes
		PlayerData.Unlocked = Unlocks
		PlayerData.DoubleXP = {
			["Enabled"] = PlayerbaseData2[Player.Name].DoubleXP.Value,
			["Timer"] = PlayerbaseData2[Player.Name].DoubleXP.Timer.Value
		}

		DataStore:SetAsync(UserId.."PlayerData", PlayerData)
	end
end

Players.PlayerRemoving:Connect(function(Player)
	if Values.DataSaving.Value then
		SaveData(Player)
	end	

	if CharStats:FindFirstChild(Player.Name) and PlayerbaseData2:FindFirstChild(Player.Name) then
		if CharStats[Player.Name].Tags:FindFirstChild("inCombat_") then
			local Creator = CharStats:FindFirstChild(Player.Name):FindFirstChild("Creator")
			local Assist = CharStats:FindFirstChild(Player.Name):FindFirstChild("Assist")
			
			if PlayerbaseData2[Player.Name].Bounty.Amount.Value >= 1000 then
				if Creator then
					if Creator.Value then
						local ShowName = Player.DisplayName
						pcall(function()
							ShowName = require(Modules.GetCharName)(Player.Character)
						end)

						Notification:FireAllClients({
							Title = "Bounty Alert",
							Text = ShowName.."'s ".._G.PlayerData[Player.Name].Bounty.." Bounty was claimed.",
							ViewportIcon = Player.Character,
							Button1 = "Close",
							Duration = 5
						}, "Beep2")
					end
				end
			end
			
			if Creator then
				if Creator.Value then
					local Cash = math.floor((40 + PlayerbaseData2[Player.Name].Bounty.Amount.Value) + 0.5)
					local Multi = 1
					if PlayerbaseData2:FindFirstChild(Creator.Value.Name) then
						if PlayerbaseData2[Creator.Value.Name].DoubleXP.Value then
							Multi = 2
						end
					end
					local XP = math.floor((XPAmounts.Kill + (PlayerbaseData2[Player.Name].Bounty.Amount.Value / 2)) + 0.5) * Multi

					local PlayerData = _G.PlayerData[Creator.Value.Name]
					if PlayerData then
						GotXP:FireClient(Creator.Value, XP)
						PlayerData.XP += XP
						UpdateClientEvent:FireClient(Creator.Value, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
					end

					_G.PlayerData[Creator.Value.Name].Bounty += 50
					PlayerbaseData2[Creator.Value.Name].Bounty.Amount.Value = _G.PlayerData[Creator.Value.Name].Bounty

					KillEvent:FireClient(Creator.Value, "[REDACTED]", Player.UserId, "KILLED", Cash, XP)

					_G.PlayerData[Creator.Value.Name].Cash += Cash

					UpdateClientEvent:FireClient(Creator.Value, false, _G.PlayerData[Creator.Value.Name].Data, _G.PlayerData[Creator.Value.Name].Bank, _G.PlayerData[Creator.Value.Name].Cash, _G.PlayerData[Creator.Value.Name], _G.PlayerData[Creator.Value.Name].Bounty)

					Creator.Value = nil
				end
			end
			
			if Assist then
				if Assist.Value and PlayerbaseData2:FindFirstChild(Player.Name) then
					local Cash = math.floor((25 + (PlayerbaseData2:FindFirstChild(Player.Name).Bounty.Amount.Value / 1.5)) + 0.5)
					local Multi = 1
					if PlayerbaseData2:FindFirstChild(Assist.Value.Name) then
						if PlayerbaseData2[Assist.Value.Name].DoubleXP.Value then
							Multi = 2
						end
					end 
					local XP = math.floor((XPAmounts.Assist + (PlayerbaseData2:FindFirstChild(Player.Name).Bounty.Amount.Value / 2.5)) + 0.5) * Multi

					local PlayerData = _G.PlayerData[Assist.Value.Name]
					if PlayerData then
						GotXP:FireClient(Assist.Value, XP)
						PlayerData.XP += XP
						UpdateClientEvent:FireClient(Assist.Value, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
					end

					_G.PlayerData[Assist.Value.Name].Bounty += 100
					PlayerbaseData2[Assist.Value.Name].Bounty.Amount.Value = _G.PlayerData[Assist.Value.Name].Bounty

					KillEvent:FireClient(Assist.Value, "[REDACTED]", Player.UserId, "ASSIST", Cash, XP)

					_G.PlayerData[Assist.Value.Name].Cash += Cash

					UpdateClientEvent:FireClient(Assist.Value, false, _G.PlayerData[Assist.Value.Name].Data, _G.PlayerData[Assist.Value.Name].Bank, _G.PlayerData[Assist.Value.Name].Cash, _G.PlayerData[Assist.Value.Name], _G.PlayerData[Assist.Value.Name].Bounty)

					Assist.Value = nil
				end	
			end
		end
		
		CharStats[Player.Name]:Destroy()
		PlayerbaseData2[Player.Name]:Destroy()
	end
	
	_G.LoadedPlayers[Player.Name] = nil
	_G.PlayerData[Player.Name] = nil
end)

Values.DataSaving:GetPropertyChangedSignal("Value"):Connect(function()
	if Values.DataSaving.Value == false then
		for _, Player in pairs(Players:GetPlayers()) do
			SaveData(Player, true)
		end
	end
end)

local TagCheck = function(Player, Tool)
	return (CollectionService:HasTag(Tool, Player.Name.." 1") and CollectionService:HasTag(Tool, Player.Name.." 2"))
end

local function check(Character, HitPart)
	if CharStats:FindFirstChild(Character.Name) then
		if CharStats[Character.Name].HealthValues:FindFirstChild(HitPart.Name) then
			if CharStats[Character.Name].HealthValues:FindFirstChild(HitPart.Name).Value <= 0 and not CharStats[Character.Name].HealthValues:FindFirstChild(HitPart.Name).Broken.Value then
				return true
			end
		end
	end
end

local ToolStuns = {
	["Metal-Bat"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if HitPart.Name == "Head" then
			local PlayerData = _G.PlayerData[Player.Name]
			if PlayerData then
				local Multi = 1
				if PlayerbaseData2[Player.Name].DoubleXP.Value then
					Multi = 2
				end
				local XP = XPAmounts.Stun * Multi
				GotXP:FireClient(Player, XP)
				PlayerData.XP += XP
				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
			end
		end
		if TargetPlayer then
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1800, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1800, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				elseif Combo == 3 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Vector3.new(0, -1, 0)) * 1650, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				end
			end
		else
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				elseif Combo == 3 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or Vector3.new(0, -1, 0) * 1650
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Shovel"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if HitPart.Name == "Head" then
			local PlayerData = _G.PlayerData[Player.Name]
			if PlayerData then
				local Multi = 1
				if PlayerbaseData2[Player.Name].DoubleXP.Value then
					Multi = 2
				end
				local XP = XPAmounts.Stun * Multi
				GotXP:FireClient(Player, XP)
				PlayerData.XP += XP
				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
			end
		end
		if TargetPlayer then
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1700, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1700, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				end
			end
		else			
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1700
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1700
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Crowbar"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if HitPart.Name == "Head" then
			local PlayerData = _G.PlayerData[Player.Name]
			if PlayerData then
				local Multi = 1
				if PlayerbaseData2[Player.Name].DoubleXP.Value then
					Multi = 2
				end
				local XP = XPAmounts.Stun * Multi
				GotXP:FireClient(Player, XP)
				PlayerData.XP += XP
				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
			end
		end
		if TargetPlayer then
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				end
			end
		else			
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Nunchucks"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		if Combo == 3 then 
			local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
			if HitPart.Name == "Head" then
				local PlayerData = _G.PlayerData[Player.Name]
				if PlayerData then
					local Multi = 1
					if PlayerbaseData2[Player.Name].DoubleXP.Value then
						Multi = 2
					end
					local XP = XPAmounts.Stun * Multi
					GotXP:FireClient(Player, XP)
					PlayerData.XP += XP
					UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
				end

				if TargetPlayer then
					if HitPart.Name == "Head" or IsDown then
						if not IsDown then
							coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
						end

						if breaklimb and HitPart.Name == "Head" then
							HitPart = TargetChar.HumanoidRootPart
						end

						Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500, 0.18)
						Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
					end
				else			
					if HitPart.Name == "Head" or IsDown then
						if not IsDown then
							coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
						end

						local Force = Instance.new("BodyForce")
						Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500
						Force.Parent = HitPart
						game:GetService("Debris"):AddItem(Force, 0.18)
					end
				end
			end
		end
	end,
	["Golfclub"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if HitPart.Name == "Head" then
			local PlayerData = _G.PlayerData[Player.Name]
			if PlayerData then
				local Multi = 1
				if PlayerbaseData2[Player.Name].DoubleXP.Value then
					Multi = 2
				end
				local XP = XPAmounts.Stun * Multi
				GotXP:FireClient(Player, XP)
				PlayerData.XP += XP
				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
			end
		end
		if TargetPlayer then
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				end
			end
		else
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Wrench"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if HitPart.Name == "Head" then
			local PlayerData = _G.PlayerData[Player.Name]
			if PlayerData then
				local Multi = 1
				if PlayerbaseData2[Player.Name].DoubleXP.Value then
					Multi = 2
				end
				local XP = XPAmounts.Stun * Multi
				GotXP:FireClient(Player, XP)
				PlayerData.XP += XP
				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
			end
		end
		if TargetPlayer then
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, -1, 0)) * 900, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 900, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				end
			end
		else
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, -1, 0)) * 900
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 900
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Bat"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if HitPart.Name == "Head" then
			local PlayerData = _G.PlayerData[Player.Name]
			if PlayerData then
				local Multi = 1
				if PlayerbaseData2[Player.Name].DoubleXP.Value then
					Multi = 2
				end
				local XP = XPAmounts.Stun * Multi
				GotXP:FireClient(Player, XP)
				PlayerData.XP += XP
				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
			end
		end
		if TargetPlayer then
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1300, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1300, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				elseif Combo == 3 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Vector3.new(0, -1, 0)) * 1200, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				end
			end
		else
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1300
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1300
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				elseif Combo == 3 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or Vector3.new(0, -1, 0) * 1200
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["BRUHBAR"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if HitPart.Name == "Head" then
			local PlayerData = _G.PlayerData[Player.Name]
			if PlayerData then
				local Multi = 1
				if PlayerbaseData2[Player.Name].DoubleXP.Value then
					Multi = 2
				end
				local XP = XPAmounts.Stun * Multi
				GotXP:FireClient(Player, XP)
				PlayerData.XP += XP
				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
			end
		end
		if TargetPlayer then
			if Combo == 1 then
				if not IsDown then
					coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
				end

				HitPart = TargetChar.HumanoidRootPart

				Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 25000, 0.18)
				Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
			elseif Combo == 2 then
				if not IsDown then
					coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
				end

				HitPart = TargetChar.HumanoidRootPart

				Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 25000, 0.18)
				Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
			elseif Combo == 3 then
				if not IsDown then
					coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
				end

				HitPart = TargetChar.HumanoidRootPart

				Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Vector3.new(0, -1, 0)) * 5000, 0.18)
				Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
			end
		else
			if Combo == 1 then
				if not IsDown then
					coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
				end

				local Force = Instance.new("BodyForce")
				Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 25000
				Force.Parent = HitPart
				game:GetService("Debris"):AddItem(Force, 0.18)
			elseif Combo == 2 then
				if not IsDown then
					coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
				end

				local Force = Instance.new("BodyForce")
				Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 25000
				Force.Parent = HitPart
				game:GetService("Debris"):AddItem(Force, 0.18)
			elseif Combo == 3 then
				if not IsDown then
					coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
				end

				local Force = Instance.new("BodyForce")
				Force.Force = Vel or Vector3.new(0, -1, 0) * 5000
				Force.Parent = HitPart
				game:GetService("Debris"):AddItem(Force, 0.18)
			end
		end
	end,
	["BBaton"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if HitPart.Name == "Head" then
			local PlayerData = _G.PlayerData[Player.Name]
			if PlayerData then
				local Multi = 1
				if PlayerbaseData2[Player.Name].DoubleXP.Value then
					Multi = 2
				end
				local XP = XPAmounts.Stun * Multi
				GotXP:FireClient(Player, XP)
				PlayerData.XP += XP
				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
			end
		end
		if TargetPlayer then
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, -1, 0)) * 1300, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
					end

					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1300, 0.18)
					Events.CONC_EF:FireClient(TargetPlayer, Config.Mains["S"..Combo].ConcussionEffect.Time, Config.Mains["S"..Combo].ConcussionEffect.Multi)
				end
			end
		else
			if HitPart.Name == "Head" or IsDown then
				if Combo == 1 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, -1, 0)) * 1300
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				elseif Combo == 2 then
					if not IsDown then
						coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
					end

					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1300
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Fists"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if Combo == 3 then
			local PlayerData = _G.PlayerData[Player.Name]
			if PlayerData then
				local Multi = 1
				if PlayerbaseData2[Player.Name].DoubleXP.Value then
					Multi = 2
				end
				local XP = XPAmounts.Stun * Multi
				GotXP:FireClient(Player, XP)
				PlayerData.XP += XP
				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
			end
		end
		if TargetPlayer then
			if Combo == 3 then
				if not IsDown then
					coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
				end

				if breaklimb and HitPart.Name == "Head" then
					HitPart = TargetChar.HumanoidRootPart
				end

				Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1250, 0.18)
			else
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 2, 0)) * 1250, 0.18)
				end
			end
		else
			if Combo == 3 then
				if not IsDown then
					coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
				end

				local Force = Instance.new("BodyForce")
				Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1250
				Force.Parent = HitPart
				game:GetService("Debris"):AddItem(Force, 0.18)
			else
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 2, 0)) * 1250
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Bayonet"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if TargetPlayer then
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1250, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1250, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1250, 0.18)
				end
			end
		else
			if Combo == 1 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1250
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1250
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1250
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Shiv"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if TargetPlayer then
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1250, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1250, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1250, 0.18)
				end
			end
		else
			if Combo == 1 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1250
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1250
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1250
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Rambo"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if TargetPlayer then
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1500, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1500, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1500, 0.18)
				end
			end
		else
			if Combo == 1 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1500
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1500
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1500
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["BlackBayonet"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if TargetPlayer then
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1800, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1800, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1800, 0.18)
				end
			end
		else
			if Combo == 1 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["CursedDagger"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if TargetPlayer then
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1800, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1800, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1800, 0.18)
				end
			end
		else
			if Combo == 1 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Katana"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if TargetPlayer then
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1800, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1800, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1800, 0.18)
				end
			end
		else
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						local Force = Instance.new("BodyForce")
						Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 180
						Force.Parent = HitPart
						game:GetService("Debris"):AddItem(Force, 0.18)
						
						HitPart = TargetChar.HumanoidRootPart
					end
					
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						local Force = Instance.new("BodyForce")
						Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 180
						Force.Parent = HitPart
						game:GetService("Debris"):AddItem(Force, 0.18)						
						
						HitPart = TargetChar.HumanoidRootPart
					end
					
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						local Force = Instance.new("BodyForce")
						Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 180
						Force.Parent = HitPart
						game:GetService("Debris"):AddItem(Force, 0.18)						
						
						HitPart = TargetChar.HumanoidRootPart
					end
					
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Military-Machete"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if TargetPlayer then
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 1800, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 1800, 0.18)
				end
			end
		else
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						local Force = Instance.new("BodyForce")
						Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 180
						Force.Parent = HitPart
						game:GetService("Debris"):AddItem(Force, 0.18)
						
						HitPart = TargetChar.HumanoidRootPart
					end
					
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						local Force = Instance.new("BodyForce")
						Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 180
						Force.Parent = HitPart
						game:GetService("Debris"):AddItem(Force, 0.18)						
						
						HitPart = TargetChar.HumanoidRootPart
					end
					
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 1800
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Taiga"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if TargetPlayer then
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 1300, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 1300, 0.18)
				end
			end
		else
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						local Force = Instance.new("BodyForce")
						Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 130
						Force.Parent = HitPart
						game:GetService("Debris"):AddItem(Force, 0.18)
						
						HitPart = TargetChar.HumanoidRootPart
					end
					
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 1300
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						local Force = Instance.new("BodyForce")
						Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 130
						Force.Parent = HitPart
						game:GetService("Debris"):AddItem(Force, 0.18)
						
						HitPart = TargetChar.HumanoidRootPart
					end					
					
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 0.5, 0)) * 1300
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["Balisong"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if TargetPlayer then
			if Combo == 1 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1000, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 1000, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1000, 0.18)
				end
			end
		else
			if Combo == 1 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1000
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 2 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1000
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			elseif Combo == 3 then
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 1, 0)) * 1000
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["GOD_FISTS"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if Combo == 3 then
			local PlayerData = _G.PlayerData[Player.Name]
			if PlayerData then
				local Multi = 1
				if PlayerbaseData2[Player.Name].DoubleXP.Value then
					Multi = 2
				end
				local XP = XPAmounts.Stun * Multi
				GotXP:FireClient(Player, XP)
				PlayerData.XP += XP
				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
			end
		end
		if TargetPlayer then
			if Combo == 3 then
				if not IsDown then
					coroutine.wrap(r)(TargetPlayer, Config.Mains["S"..Combo].KnockTime)
				end

				if breaklimb and HitPart.Name == "Head" then
					HitPart = TargetChar.HumanoidRootPart
				end

				Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1250, 0.18)
			else
				if IsDown then
					if breaklimb and HitPart.Name == "Head" then
						HitPart = TargetChar.HumanoidRootPart
					end

					Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 2, 0)) * 1250, 0.18)
				end
			end
		else
			if Combo == 3 then
				if not IsDown then
					coroutine.wrap(r)(TargetChar, Config.Mains["S"..Combo].KnockTime)
				end

				local Force = Instance.new("BodyForce")
				Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1250
				Force.Parent = HitPart
				game:GetService("Debris"):AddItem(Force, 0.18)
			else
				if IsDown then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 2, 0)) * 1250
					Force.Parent = HitPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
	["ERADICATOR"] = function(Player, TargetChar, HitPart, Config, Combo, IsDown, Vel, breaklimb)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
		if TargetPlayer then
			if IsDown then
				if TargetChar:FindFirstChild("HumanoidRootPart") then
					Events.FT_:FireClient(TargetPlayer, TargetChar.HumanoidRootPart, Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 2000, 0.18)
				end
			end
		else			
			if IsDown then
				if TargetChar:FindFirstChild("HumanoidRootPart") then
					local Force = Instance.new("BodyForce")
					Force.Force = Vel or (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 2000
					Force.Parent = TargetChar.HumanoidRootPart
					game:GetService("Debris"):AddItem(Force, 0.18)
				end
			end
		end
	end,
}

local EventsTable = {
	UpdateClient = function(Player)
		local PlayerData = _G.PlayerData[Player.Name]

		if PlayerData then
			UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
		end
	end,
	SSHPRMTE1 = function(Player, StoreType, ItemType, ItemName, MainPart, Transaction)
		local Argument1, Argument2 = false, "An error has occured"

		local PlayerData = _G.PlayerData[Player.Name]

		if Player.Character then
			if Player.Character:FindFirstChild("Torso") then
				if (MainPart.Position - Player.Character.Torso.Position).Magnitude < 10 then
					local ItemStat = ItemStats:FindFirstChild(ItemType):FindFirstChild(ItemName)

					if ItemStat then
						local Level = ItemStat.Level.Value
						local PlayerLevel = PlayerData.Level

						if Transaction == "Purchase" then
							if ItemType == "Armour" then
								local Multi = 1
								if PlayerData.Cash - ItemStat.Price.Value * Multi < 0 then
									return false, "INSUFFICIENT FUNDS"
								end
								local Character = Player.Character
								if Character then
									if Character:FindFirstChild("Torso") and Character:FindFirstChild("Head") then
										if MainPart.Parent.CurrentStocks[ItemName].Value > 0 then
											if PlayerbaseData2[Player.Name].Unlocked:FindFirstChild(ItemName) then
												local VestTags
												local HelmetTags

												if ItemName == "VestA_1" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
													if not IsArmored.Value then
														VestTags = {
															[1] = ItemName,
															[2] = true,
														}

														local Armour = Resources.Armour.T1.VestA_1:Clone()
														Armour.Parent = Character

														local Rigger_Vest = Resources.Armour.Rigger_Vest:Clone()
														Rigger_Vest.Parent = Armour
														Rigger_Vest.Disabled = false
													else
														return false, "ALREADY ARMORED"
													end
													
													MainPart.Parent.CurrentStocks[ItemName].Value -= 1
												elseif ItemName == "VestA_2" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
													if not IsArmored.Value then
														VestTags = {
															[1] = ItemName,
															[2] = true,
														}

														local Armour = Resources.Armour.T2.VestA_2:Clone()
														Armour.Parent = Character

														local Rigger_Vest = Resources.Armour.Rigger_Vest:Clone()
														Rigger_Vest.Parent = Armour
														Rigger_Vest.Disabled = false
													else
														return false, "ALREADY ARMORED"
													end
													
													MainPart.Parent.CurrentStocks[ItemName].Value -= 1
												elseif ItemName == "VestA_3" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
													if not IsArmored.Value then
														VestTags = {
															[1] = ItemName,
															[2] = true,
														}

														local Armour = Resources.Armour.T3.VestA_3:Clone()
														Armour.Parent = Character

														local Rigger_Vest = Resources.Armour.Rigger_Vest:Clone()
														Rigger_Vest.Parent = Armour
														Rigger_Vest.Disabled = false
													else
														return false, "ALREADY ARMORED"
													end

													MainPart.Parent.CurrentStocks[ItemName].Value -= 1
												elseif ItemName == "HelmetA_1" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
													if not IsArmored.Value then
														HelmetTags = {
															[1] = ItemName,
															[2] = true,
														}

														local Armour = Resources.Armour.T1.HelmetA_1:Clone()
														Armour.Parent = Character

														local Rigger_Helmet = Resources.Armour.Rigger_Helmet:Clone()
														Rigger_Helmet.Parent = Armour
														Rigger_Helmet.Disabled = false
													else
														return false, "ALREADY ARMORED"
													end
													
													MainPart.Parent.CurrentStocks[ItemName].Value -= 1
												elseif ItemName == "HelmetA_2" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
													if not IsArmored.Value then
														HelmetTags = {
															[1] = ItemName,
															[2] = true,
														}

														local Armour = Resources.Armour.T2.HelmetA_2:Clone()
														Armour.Parent = Character

														local Rigger_Helmet = Resources.Armour.Rigger_Helmet:Clone()
														Rigger_Helmet.Parent = Armour
														Rigger_Helmet.Disabled = false
													else
														return false, "ALREADY ARMORED"
													end
													
													MainPart.Parent.CurrentStocks[ItemName].Value -= 1
												elseif ItemName == "HelmetA_3" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
													if not IsArmored.Value then
														HelmetTags = {
															[1] = ItemName,
															[2] = true,
														}

														local Armour = Resources.Armour.T3.HelmetA_3:Clone()
														Armour.Parent = Character

														local Rigger_Helmet = Resources.Armour.Rigger_Helmet:Clone()
														Rigger_Helmet.Parent = Armour
														Rigger_Helmet.Disabled = false
													else
														return false, "ALREADY ARMORED"
													end

													MainPart.Parent.CurrentStocks[ItemName].Value -= 1
												end

												local Armour = {}

												if VestTags then
													Armour[1] = VestTags
												end

												if HelmetTags then
													Armour[2] = HelmetTags
												end

												PlayerData.Armour = Armour

												PlayerData.Cash -= ItemStat.Price.Value * Multi
												UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

												return true, "PURCHASE COMPLETE"
											else
												if PlayerLevel >= Level then
													local VestTags
													local HelmetTags

													if ItemName == "VestA_1" then
														local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
														if not IsArmored.Value then
															VestTags = {
																[1] = ItemName,
																[2] = true,
															}

															local Armour = Resources.Armour.T1.VestA_1:Clone()
															Armour.Parent = Character

															local Rigger_Vest = Resources.Armour.Rigger_Vest:Clone()
															Rigger_Vest.Parent = Armour
															Rigger_Vest.Disabled = false
														else
															return false, "ALREADY ARMORED"
														end
														
														MainPart.Parent.CurrentStocks[ItemName].Value -= 1
													elseif ItemName == "VestA_2" then
														local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
														if not IsArmored.Value then
															VestTags = {
																[1] = ItemName,
																[2] = true,
															}

															local Armour = Resources.Armour.T2.VestA_2:Clone()
															Armour.Parent = Character

															local Rigger_Vest = Resources.Armour.Rigger_Vest:Clone()
															Rigger_Vest.Parent = Armour
															Rigger_Vest.Disabled = false
														else
															return false, "ALREADY ARMORED"
														end
														
														MainPart.Parent.CurrentStocks[ItemName].Value -= 1
													elseif ItemName == "VestA_3" then
														local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
														local IsArmored2 = require(Modules.IsArmored).Check(Character.Head, Character)

														local Armour = Resources.Armour.T3.VestA_3:Clone()
														Armour.Parent = Character

														if not IsArmored.Value and not IsArmored2.Value then
															Armour:Destroy()
															return false, "ALREADY ARMORED"
														end

														if not IsArmored.Value then
															VestTags = {
																[1] = ItemName,
																[2] = true,
															}

															local Rigger_Vest = Resources.Armour.Rigger_Vest:Clone()
															Rigger_Vest.Parent = Armour
															Rigger_Vest.Disabled = false
														end
														if not IsArmored2.Value then
															HelmetTags = {
																[1] = ItemName,
																[2] = true,
															}

															local Rigger_Helmet = Resources.Armour.Rigger_Helmet:Clone()
															Rigger_Helmet.Parent = Armour
															Rigger_Helmet.Disabled = false
														end
														
														MainPart.Parent.CurrentStocks[ItemName].Value -= 1
													elseif ItemName == "HelmetA_1" then
														local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
														if not IsArmored.Value then
															HelmetTags = {
																[1] = ItemName,
																[2] = true,
															}

															local Armour = Resources.Armour.T1.HelmetA_1:Clone()
															Armour.Parent = Character

															local Rigger_Helmet = Resources.Armour.Rigger_Helmet:Clone()
															Rigger_Helmet.Parent = Armour
															Rigger_Helmet.Disabled = false
														else
															return false, "ALREADY ARMORED"
														end
														
														MainPart.Parent.CurrentStocks[ItemName].Value -= 1
													elseif ItemName == "HelmetA_2" then
														local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
														if not IsArmored.Value then
															HelmetTags = {
																[1] = ItemName,
																[2] = true,
															}

															local Armour = Resources.Armour.T2.HelmetA_2:Clone()
															Armour.Parent = Character

															local Rigger_Helmet = Resources.Armour.Rigger_Helmet:Clone()
															Rigger_Helmet.Parent = Armour
															Rigger_Helmet.Disabled = false
														else
															return false, "ALREADY ARMORED"
														end
														
														MainPart.Parent.CurrentStocks[ItemName].Value -= 1
													end
													
													if Values.DataSaving.Value then
														local Armour = {}

														if VestTags then
															Armour[1] = VestTags
														end

														if HelmetTags then
															Armour[2] = HelmetTags
														end

														PlayerData.Armour = Armour
													end

													PlayerData.Cash -= ItemStat.Price.Value * Multi
													UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

													return true, "PURCHASE COMPLETE"
												end
											end
										end
									end
								end
							else
								local ToolCheck = Tools:FindFirstChild(ItemName)
								if ToolCheck then
									if CharStats:FindFirstChild(Player.Name) then
										local SlotUsage = 0
										if InventorySlotValues[ItemName] then
											SlotUsage = InventorySlotValues[ItemName]
										end
										if CharStats:FindFirstChild(Player.Name).InventorySlots.Value + SlotUsage < CharStats:FindFirstChild(Player.Name).InventorySlots.MaxValue then
											local Price = ItemStat.Price.Value
											if PlayerData.Cash >= Price then 
												if MainPart.Parent.CurrentStocks[ItemName].Value > 0 then
													local function Purchase()
														local Tool = ToolCheck:Clone()
														Tool.Parent = Player.Backpack

														PlayerData.Cash = PlayerData.Cash - Price

														UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

														MainPart.Parent.CurrentStocks[ItemName].Value -= 1

														Argument1 = true
														Argument2 = "PURCHASE COMPLETE"
													end

													if ItemStat.SellStations:FindFirstChild(StoreType) then
														if PlayerbaseData2[Player.Name].Unlocked:FindFirstChild(ItemName) then
															Purchase()
														else
															if PlayerLevel >= Level then
																Purchase()
															end
														end
													else
														Argument1 = false
														Argument2 = "ITEM NOT SOLD HERE"	
													end
												else
													Argument1 = false
													Argument2 = "ITEM NOT IN STOCK"	
												end
											else
												Argument1 = false
												Argument2 = "NOT ENOUGH CASH"
											end
										end
									end
								end
							end
						elseif Transaction == "Sell" then
							if CharStats[Player.Name].Tags:FindFirstChild("inCombat_") then
								Argument1 = false
								Argument2 = "CANNOT SELL ITEMS WHILE IN COMBAT"
							else							
								if ItemType == "Armour" then
									local Character = Player.Character
									local CharStat = GVF(Player.Name)
	
									if Character and CharStat then
										if Character:FindFirstChild("Torso") and Character:FindFirstChild("Head") and Character:FindFirstChild(ItemName) then
											if (ItemStat:FindFirstChild("Sellable") and ItemStat.Sellable.Value and ItemStat.SellStations:FindFirstChild(StoreType)) then
												local Price = GetSellPrice(Player, Character[ItemName], ItemStat)
												
												if ItemName == "VestA_1" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
													if IsArmored.Value then
														pcall(function()
															Character.VestA_1:Destroy()
														end)
													else
														return false, "NOT ARMORED"
													end
												elseif ItemName == "VestA_2" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
													if IsArmored.Value then
														pcall(function()
															Character.VestA_2:Destroy()
														end)
													else
														return false, "NOT ARMORED"
													end
												elseif ItemName == "VestA_3" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)

													if IsArmored.Value then
														pcall(function()
															Character.VestA_3:Destroy()
														end)
													else
														return false, "NOT ARMORED"
													end
												elseif ItemName == "HelmetA_1" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
													if IsArmored.Value then
														pcall(function()
															Character.HelmetA_1:Destroy()
														end)
													else
														return false, "NOT ARMORED"
													end
												elseif ItemName == "HelmetA_2" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
													if IsArmored.Value then
														pcall(function()
															Character.HelmetA_2:Destroy()
														end)
														pcall(function()
															Character.Head.Breathing:Destroy()
														end)
													else
														return false, "NOT ARMORED"
													end
												elseif ItemName == "HelmetA_3" then
													local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
													if IsArmored.Value then
														pcall(function()
															Character.HelmetA_3:Destroy()
														end)
														pcall(function()
															Character.Head.Breathing:Destroy()
														end)
													else
														return false, "NOT ARMORED"
													end
												end

												if string.match(ItemName, "Vest") then
													for _, v in pairs(CharStat.ArmoredParts:GetChildren()) do
														if v.Name ~= "Head" then
															v.Value = false
														end
													end
													for _, v in pairs(CharStat.BulletProof:GetChildren()) do
														if v.Name ~= "Head" then
															v.Value = 1
														end
													end
													for _, v in pairs(CharStat.MeleeProof:GetChildren()) do
														if v.Name ~= "Head" then
															v.Value = 1
														end
													end
													
													CharStat.ArmorHP.Body.Value = 0
													CharStat.InventorySlots.MaxValue = 10
													CharStat.InventorySlots.Value = CharStat.InventorySlots.MinValue
													CharStat.MovementSoundModifier.Value = 1
													CharStat.AccelerationModifier.Value = 1
													CharStat.ExplosiveProof.Value = 1
													CharStat.ExplosiveProof2.Value = 1
												elseif string.match(ItemName, "Helmet") then
													CharStat.ArmorHP.Head.Value = 0
													CharStat.ArmoredParts.Head.Value = false
													CharStat.MeleeProof.Head.Value = 1
													CharStat.BulletProof.Head.Value = 1
												end

												for _, v in pairs(CharStat.ArmorHP:GetChildren()) do
													v.Value = v.MaxValue
												end
												
												if Values.DataSaving.Value then
													PlayerData.Armour = {}
												end

												Events.HelmetRemoved:FireClient(Player)
												PlayerData.Cash += Price
												UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

												return true, "ARMOR SOLD"
											end
										end
									end
								else
									local Tool = Player.Backpack:FindFirstChild(ItemName)
									if Tool then
										if (ItemStat:FindFirstChild("Sellable") and ItemStat.Sellable.Value and ItemStat.SellStations:FindFirstChild(StoreType)) then
											local SellPrice = GetSellPrice(Player, Tool, ItemStat)

											PlayerData.Cash = PlayerData.Cash + SellPrice

											UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

											Tool:Destroy()

											MainPart.Parent.CurrentStocks[ItemName].Value += 1

											Argument1 = true
											Argument2 = "ITEM SOLD"
										end
									end
								end
							end
						elseif Transaction == "Rent" then
							if ItemType == "Armour" then
								local Multi = ItemStat.CanRent.RentMulti.Value
								if PlayerData.Cash - ItemStat.Price.Value * Multi < 0 then
									return false, "INSUFFICIENT FUNDS"
								end
								local Character = Player.Character
								if Character then
									if Character:FindFirstChild("Torso") and Character:FindFirstChild("Head") then
										if (ItemStat:FindFirstChild("CanRent") and ItemStat.CanRent.Value) and PlayerLevel < Level then
											local VestTags
											local HelmetTags

											if ItemName == "VestA_1" then
												local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
												if not IsArmored.Value then
													VestTags = {
														[1] = ItemName,
														[2] = true,
													}

													local Armour = Resources.Armour.T1.VestA_1:Clone()
													Armour.Parent = Character

													local Rigger_Vest = Resources.Armour.Rigger_Vest:Clone()
													Rigger_Vest.Parent = Armour
													Rigger_Vest.Disabled = false
												else
													return false, "ALREADY ARMORED"
												end
												
												MainPart.Parent.CurrentStocks[ItemName].Value -= 1
											elseif ItemName == "VestA_2" then
												local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
												if not IsArmored.Value then
													VestTags = {
														[1] = ItemName,
														[2] = true,
													}

													local Armour = Resources.Armour.T2.VestA_2:Clone()
													Armour.Parent = Character

													local Rigger_Vest = Resources.Armour.Rigger_Vest:Clone()
													Rigger_Vest.Parent = Armour
													Rigger_Vest.Disabled = false
												else
													return false, "ALREADY ARMORED"
												end
												
												MainPart.Parent.CurrentStocks[ItemName].Value -= 1
											elseif ItemName == "VestA_3" then
												local IsArmored = require(Modules.IsArmored).Check(Character.Torso, Character)
												if not IsArmored.Value then
													VestTags = {
														[1] = ItemName,
														[2] = true,
													}

													local Armour = Resources.Armour.T3.VestA_3:Clone()
													Armour.Parent = Character

													local Rigger_Vest = Resources.Armour.Rigger_Vest:Clone()
													Rigger_Vest.Parent = Armour
													Rigger_Vest.Disabled = false
												else
													return false, "ALREADY ARMORED"
												end

												MainPart.Parent.CurrentStocks[ItemName].Value -= 1
											elseif ItemName == "HelmetA_1" then
												local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
												if not IsArmored.Value then
													HelmetTags = {
														[1] = ItemName,
														[2] = true,
													}

													local Armour = Resources.Armour.T1.HelmetA_1:Clone()
													Armour.Parent = Character

													local Rigger_Helmet = Resources.Armour.Rigger_Helmet:Clone()
													Rigger_Helmet.Parent = Armour
													Rigger_Helmet.Disabled = false
												else
													return false, "ALREADY ARMORED"
												end
												
												MainPart.Parent.CurrentStocks[ItemName].Value -= 1
											elseif ItemName == "HelmetA_2" then
												local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
												if not IsArmored.Value then
													HelmetTags = {
														[1] = ItemName,
														[2] = true,
													}

													local Armour = Resources.Armour.T2.HelmetA_2:Clone()
													Armour.Parent = Character

													local Rigger_Helmet = Resources.Armour.Rigger_Helmet:Clone()
													Rigger_Helmet.Parent = Armour
													Rigger_Helmet.Disabled = false
												else
													return false, "ALREADY ARMORED"
												end
												
												MainPart.Parent.CurrentStocks[ItemName].Value -= 1
											elseif ItemName == "HelmetA_3" then
												local IsArmored = require(Modules.IsArmored).Check(Character.Head, Character)
												if not IsArmored.Value then
													HelmetTags = {
														[1] = ItemName,
														[2] = true,
													}

													local Armour = Resources.Armour.T3.HelmetA_3:Clone()
													Armour.Parent = Character

													local Rigger_Helmet = Resources.Armour.Rigger_Helmet:Clone()
													Rigger_Helmet.Parent = Armour
													Rigger_Helmet.Disabled = false
												else
													return false, "ALREADY ARMORED"
												end

												MainPart.Parent.CurrentStocks[ItemName].Value -= 1
											end
											
											if Values.DataSaving.Value then
												local Armour = {}

												if VestTags then
													Armour[1] = VestTags
												end

												if HelmetTags then
													Armour[2] = HelmetTags
												end

												PlayerData.Armour = Armour
											end

											PlayerData.Cash -= ItemStat.Price.Value * Multi
											UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

											return true, "PURCHASE COMPLETE"
										end
									end
								end
							else
								local ToolCheck = Tools:FindFirstChild(ItemName)
								if ToolCheck then
									if (ItemStat:FindFirstChild("CanRent") and ItemStat.CanRent.Value) and PlayerLevel < Level then
										local Price = ItemStat.Price.Value * ItemStat.CanRent.RentMulti.Value

										if PlayerData.Cash >= Price then
											local Tool = ToolCheck:Clone()
											Tool.Parent = Player.Backpack

											PlayerData.Cash = PlayerData.Cash - Price

											UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

											Argument1 = true
											Argument2 = "PURCHASE COMPLETE"
										else
											Argument1 = false
											Argument2 = "NOT ENOUGH CASH"
										end
									end
								end
							end
						elseif Transaction == "Unlock" then
							if (ItemStat:FindFirstChild("CanUnlock") and ItemStat.CanUnlock.Value) then
								local UnlockPrice = GetUnlockPrice(Player, PlayerData.Level, ItemStat.Level.Value, ItemStat.CanUnlock)

								if PlayerData.Bank >= UnlockPrice then
									local Item = Instance.new("BoolValue", PlayerbaseData2[Player.Name].Unlocked)
									Item.Name = ItemName

									PlayerData.Bank = PlayerData.Bank - UnlockPrice

									UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

									Argument1 = true
									Argument2 = "ITEM UNLOCKED!"
								else
									Argument1 = false
									Argument2 = "NOT ENOUGH CASH"
								end
							end
						elseif Transaction == "Refill" then
							local Tool = Player.Backpack:FindFirstChild(ItemName)
							if Tool then
								if (ItemStat:FindFirstChild("ResupplyGun") and ItemStat.ResupplyGun.Value and ItemStat.SellStations:FindFirstChild(StoreType)) then
									local Config = require(Tool.Config)
									local Ammo = (Tool.Values.SERVER_Ammo.Value + Tool.Values.SERVER_StoredAmmo.Value) / (Config.MagSize + Config.StoredAmmo)
									
									local RefillPrice = GetRefillPrice(Player, ItemStat.ResupplyGun.Price.Value, Ammo)
									
									if PlayerData.Cash - RefillPrice >= 0 then
										PlayerData.Cash = PlayerData.Cash - RefillPrice

										Tool.Values.SERVER_Ammo.Value = Tool.Values.SERVER_Ammo.MaxValue 
										Tool.Values.SERVER_StoredAmmo.Value = Tool.Values.SERVER_StoredAmmo.MaxValue 

										UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

										Argument1 = true
										Argument2 = "ITEM REFILLED"
									end
								end
							end
						end
					end
				end
			end
		end

		return Argument1, Argument2
	end,
	DeathRespawn = function(Player)
		if CollectionService:HasTag(Player, "Respawning") then
			return false
		end
		if Player.Character then
			if Player.Character.Humanoid.Health > 0 then
				return
			end
		end

		game:GetService("CollectionService"):AddTag(Player, "Respawning")

		coroutine.wrap(function()
			for _, Character in pairs(workspace.Characters:GetChildren()) do
				if Character.Name == Player.Name then
					Character.Parent = ReplicatedStorage
					game:GetService("Debris"):AddItem(Character, 3)
				end
			end

			task.wait(2)

			Player:LoadCharacter()
			game:GetService("CollectionService"):RemoveTag(Player, "Respawning")
		end)()

		return true
	end,
	BRBRBRRBLOOOL = function(Player)
		local PlayerData = _G.PlayerData[Player.Name]

		return PlayerData
	end,
	ClientSettingsUpdated = function(Player, Settings)
		_G.PlayerData[Player.Name].ClientSettings = Settings
	end,
	GetClientSettings = function(Player)
		if _G.PlayerData[Player.Name] then
			local ClientSettings = _G.PlayerData[Player.Name].ClientSettings or require(Modules.DefaultClientSettings)

			return ClientSettings
		end
	end,
	["XMHH.1"] = function(Player, Key, Tick, Tool, Type, Type2, Time, Bool)
		if Tool.Values.SlashDB.Value then
			return
		end
		if not Player.Character then
			return
		end
		if not Tool:IsDescendantOf(Player.Character) then
			return
		end
		if ReplicatedStorage.Values.ZaWarudo.Value then
			if ReplicatedStorage.Values.ZaWarudo.Owner.Value ~= Player then
				return
			end
		end

		if Key == "🚨" then
			if Type == "43TRFWJ" then
				if Type2 == "Normal" then
					local Is, Combo, Reset = false, 1, false					
					
					Tool.Values.SlashDB.Value = true
					Tool.Values.Slashing1.Value = true

					local Config = require(Tool.Config)

					if TagCheck(Player, Tool) then
						Combo = 3
						Is = true
						Reset = true
					else
						if Time >= 10 then
							Is = true
						elseif Time < 10 then
							if Config.Mains.S2 then
								if Time < (Config.Mains["S"..2].DebounceTime + Config.Mains["S"..2].ComboEndTime) then
									Combo = 2
									Reset = true
								end
							end
							Is = true
						end
					end

					CollectionService:RemoveTag(Player, "GotBlocked")
					CollectionService:AddTag(Tool, Combo)

					for _, Tag in pairs(CollectionService:GetTags(Tool.Values.Slashing1)) do
						CollectionService:RemoveTag(Tool.Values.Slashing1, Tag)
					end

					CollectionService:RemoveTag(Tool, "Hit")

					local ActualMeleeSounds = MeleeSounds:FindFirstChild(Tool.Name)

					if ActualMeleeSounds then
						local Swings = ActualMeleeSounds:FindFirstChild("Swings")
						if Swings then
							local Swing = Swings["Swing"..Combo]:Clone()
							Swing.Parent = (Tool:FindFirstChild("Handle") or Tool:FindFirstChild("HHandle")) or Player.Character.Torso
							game:GetService("Debris"):AddItem(Swing, 3)
							Swing:Play()
						end
					end

					local ComboConfig = Config.Mains.S1

					pcall(function()
						ComboConfig = Config.Mains["S"..Combo]
					end)

					if Config.TrailsEnabled then
						task.spawn(function()
							local Trail = Tool.Handle:FindFirstChildWhichIsA("Trail")
							if Trail then
								task.wait(ComboConfig.SwingWait / ComboConfig.AnimSpeed)
								if Trail then
									Trail.Enabled = true
									task.wait(ComboConfig.SwingTime / ComboConfig.AnimSpeed)
									if Trail then
										Trail.Enabled = false
									end
								end
							end
						end)
					end

					for _, Tag in pairs(CollectionService:GetTags(Tool)) do
						if string.match(Tag, "sd2") then
							CollectionService:RemoveTag(Tool, Tag)
						end
					end

					local seed = math.random()

					CollectionService:AddTag(Tool, "seed "..seed)

					local seed2 = math.random()

					CollectionService:AddTag(Tool, "sd2 "..seed2)

					task.spawn(function()
						task.wait(ComboConfig.DebounceTime)

						if Tool:FindFirstChild("Values") then
							Tool.Values.SlashDB.Value = false
						end

						CollectionService:RemoveTag(Tool, Combo)

						for _, Tag in pairs(CollectionService:GetTags(Tool)) do
							if string.match(Tag, "sd2") then
								seed2 = Tag
							end
						end

						task.wait(ComboConfig.DebounceTime)

						local seedcheck = CollectionService:HasTag(Tool, seed2)
						if seedcheck then
							if Tool:FindFirstChild("Values") then
								Tool.Values.Slashing1.Value = false
							end
						end
					end)	
					
					return Is, Combo, Reset
				end
			elseif Type == "EXECQQ" then
				Tool.Values.SlashDB.Value = true
				Tool.Values.Executing.Value = true

				local Config = require(Tool.Config)

				CollectionService:AddTag(Tool, "ex")

				for _, Tag in pairs(CollectionService:GetTags(Tool.Values.Executing)) do
					CollectionService:RemoveTag(Tool.Values.Executing, Tag)
				end

				local ActualMeleeSounds = MeleeSounds:FindFirstChild(Tool.Name)

				if ActualMeleeSounds then
					local Swing = ActualMeleeSounds["Execute"]:Clone()
					Swing.Parent = (Tool:FindFirstChild("Handle") or Tool:FindFirstChild("HHandle")) or Player.Character.Torso
					game:GetService("Debris"):AddItem(Swing, Swing.TimeLength / Swing.PlaybackSpeed)
					Swing:Play()
				end

				local ComboConfig = Config.Mains.E

				for _, Tag in pairs(CollectionService:GetTags(Tool)) do
					if string.match(Tag, "es") then
						CollectionService:RemoveTag(Tool, Tag)
					end
				end

				local seed = math.random()

				CollectionService:AddTag(Tool, "es "..seed)

				task.spawn(function()
					task.wait(ComboConfig.DebounceTime)

					Tool.Values.SlashDB.Value = false

					CollectionService:RemoveTag(Tool, "ex")

					for _, Tag in pairs(CollectionService:GetTags(Tool)) do
						if string.match(Tag, "es") then
							seed = Tag
						end
					end

					task.wait(ComboConfig.DebounceTime)

					local seedcheck = CollectionService:HasTag(Tool, seed)
					if seedcheck then
						Tool.Values.Executing.Value = false
					end
				end)	

				return true
			elseif Type == "BLSTAZ1" then
				if Tool.Values:FindFirstChild("Reviving") then
					if Tool.Values.Reviving.Value then
						return
					end
				end
				if Tool.Values.Executing.Value then
					return
				end
				if not require(Tool.Config).BlockSettings.Enabled then
					return
				end
				if CharStats:FindFirstChild(Player.Name) then
					if CharStats:FindFirstChild(Player.Name).RagdollTime.RagdollSwitch.Value then
						return
					end
				end

				pcall(function()
					local BlockSound = Sounds.Melees[Tool.Name].BlockStart:Clone()
					BlockSound.Parent = Tool.Handle or Player.Character.Torso
					BlockSound:Play()
					game.Debris:AddItem(BlockSound, 3)
				end)

				Tool.Values.Blocking.Value = true

				return true
			elseif Type == "BZLZSTO2" then
				pcall(function()
					local BlockSound = Sounds.Melees[Tool.Name].BlockStop:Clone()
					BlockSound.Parent = Tool.Handle or Player.Character.Torso
					BlockSound:Play()
					game.Debris:AddItem(BlockSound, 3)
				end)

				Tool.Values.Blocking.Value = false

				return true
			elseif Type == "REV1" then
				local Character = Player.Character
				if Character then
					local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
					if HumanoidRootPart then
						if Tool.Values.Reviving.Value then
							return
						end

						local v75 = (function()
							for v76, v77 in pairs(workspace:FindPartsInRegion3(Region3.new(HumanoidRootPart.Position - Vector3.new(2, 3, 2), HumanoidRootPart.Position + Vector3.new(2, 2, 2)), nil, math.huge)) do
								local l__Parent__78 = v77.Parent
								if l__Parent__78 ~= Character and v77.Name == "Torso" and l__Parent__78:FindFirstChildWhichIsA("Humanoid") and (l__Parent__78:FindFirstChildWhichIsA("Humanoid"):GetState() ~= Enum.HumanoidStateType.Dead and ReplicatedStorage.CharStats:FindFirstChild(l__Parent__78.Name).Downed.Value and ReplicatedStorage.CharStats:FindFirstChild(l__Parent__78.Name) and ReplicatedStorage.CharStats:FindFirstChild(l__Parent__78.Name).Grabbed.Value == false) and (not ReplicatedStorage.CharStats:FindFirstChild(l__Parent__78.Name).Currents:FindFirstChild("Reviving")) then
									return l__Parent__78
								end
							end
							return false
						end)()
						if not v75 then
							return
						end
						if CharStats[v75.Name].Currents:FindFirstChild("Reviving") then
							return
						end
						if CharStats[Player.Name].Currents:FindFirstChild("Reviving") then
							return
						end
						if game:GetService("CollectionService"):HasTag(v75, "BleedingOut") then
							return
						end

						local Reviving = Instance.new("Folder")
						Reviving.Name = "Reviving"
						Reviving.Parent = CharStats[v75.Name].Currents

						Tool.Values.Reviving.Value = true

						local BeingRevived
						if Players:GetPlayerFromCharacter(v75) then
							BeingRevived = ReplicatedStorage.Storage.GUIs.HealGUI:Clone()
							BeingRevived.Parent = Players:GetPlayerFromCharacter(v75).PlayerGui
							BeingRevived.LocalScript.Disabled = false
						end

						local Config = require(Tool.Config)
						local Time = Config.Customs.Revive.Time

						local SD = Instance.new("NumberValue", ReplicatedStorage:WaitForChild("CharStats")[Player.Name].Currents)
						SD.Name = "SD_Reviving"
						SD.Value = 16

						local AJ = Instance.new("BoolValue", ReplicatedStorage:WaitForChild("CharStats")[Player.Name].Currents)
						AJ.Name = "AJ"

						local Anim = Player.Character.Humanoid:LoadAnimation(Tool.AnimsFolder.Revive)
						Anim:Play()

						local RSound
						if Player.Character:FindFirstChild("Torso") then
							RSound = Instance.new("Sound", Player.Character.Torso)
							RSound.Volume = 1
							RSound.SoundId = "rbxassetid://7370680829"
							RSound.PlaybackSpeed = 1
							RSound.Looped = true
							RSound:Play()
						end

						local Gyro
						if Player.Character:FindFirstChild("HumanoidRootPart") and v75:FindFirstChild("HumanoidRootPart") then
							Gyro = Instance.new("BodyGyro")
							CollectionService:AddTag(Gyro, "BM")
							Gyro.Parent = Player.Character.HumanoidRootPart
							Gyro.D = 200
							Gyro.MaxTorque = Vector3.new(0, 15000, 0)
							Gyro.P = 3000
						end

						local pl = Players:GetPlayerFromCharacter(v75) or v75

						task.spawn(function()
							local CurrentTime = 0
							local CurrentTick = tick()

							local ToolCheck = Character:FindFirstChildWhichIsA("Tool")
							local Config = require(ToolCheck.Config)

							if Config.Customs.Revive then

								while true do
									RunService.Heartbeat:Wait()
									CurrentTime = tick() - CurrentTick
									Gyro.CFrame = CFrame.lookAt(Player.Character.HumanoidRootPart.Position, v75.HumanoidRootPart.Position)
									if CurrentTime >= Time or not Tool.Values.Reviving.Value or not ToolCheck:IsDescendantOf(Character) or Player.Character ~= Character or v75.Humanoid.Health <= 0 or Character.Humanoid.Health <= 0 or (Character.Torso.Position - v75.Torso.Position).Magnitude > 5 or CharStats[v75.Name].Downed.Value == false then
										break
									end 
								end

								if CurrentTime >= Time then
									v75.Humanoid.Health = 35

									if v75:FindFirstChild("Torso") then
										local Sound = Instance.new("Sound", v75.Torso)
										Sound.Volume = 0.35
										Sound.SoundId = "rbxassetid://5014191737"
										Sound.PlaybackSpeed = 1
										Sound:Play()

										game:GetService("Debris"):AddItem(Sound, 5)
									end
								end

								Anim:Stop()

								pcall(function()
									BeingRevived:Destroy()
								end)
								Reviving:Destroy()
								RSound:Destroy()
								Gyro:Destroy()

								Tool.Values.Reviving.Value = false

								pcall(function()
									SD:Destroy()
								end)
								pcall(function()
									AJ:Destroy()
								end)
							end
						end)

						return true, Time
					end
				end
			elseif Type == "PPZXKU1" then
				
				return true
			end
		end
	end,
	["XMHH2.1"] = function(Player, Key, Tick, Tool, Type, Bool1, Bool2, Hitter, HitPart, TargetChar, Pos1, Pos2)
		if Key == "🚨" then
			if Type == "2389ZFX33" then
				if not HitPart:IsDescendantOf(TargetChar) or not Player.Character or check(TargetChar, HitPart) or HitPart:IsDescendantOf(Player.Character) or not TargetChar or not CharStats:FindFirstChild(TargetChar.Name) or not TargetChar:IsDescendantOf(workspace.Characters) or not Player.Character:FindFirstChild("HumanoidRootPart") then
					return
				end

				if TargetChar:FindFirstChildWhichIsA("ForceField") then
					if TargetChar:FindFirstChildWhichIsA("ForceField").Name ~= "GodFF" then
						ClientWarn:FireClient(Player, { "Player is protected!", 1.5, Color3.fromRGB(255, 121, 121), Color3.new(0, 0, 0), "lost" })
					end
					return
				end
				if Players:GetPlayerFromCharacter(TargetChar) then
					if TeamCheck(Player, Players:GetPlayerFromCharacter(TargetChar)) then
						Events.ClientWarn:FireClient(Player, {"Friendly fire!", 1.5, Color3.fromRGB(255, 121, 121), Color3.new(0, 0, 0), "lost"})
						return
					end
				end

				local Magnitude = (HitPart.Position - Hitter.Position).Magnitude

				local Config = require(Tool.Config)

				local MMag = Config.MMag or 10

				if Magnitude > MMag then
					return
				end

				local ArmorReduction = CharStats[TargetChar.Name].MeleeProof[HitPart.Name].Value

				if Tool.Values.Executing.Value then
					local CharStat = CharStats[TargetChar.Name]
					if CharStat then
						if CharStat.Downed.Value then
							local TargetHumanoid = TargetChar:FindFirstChildWhichIsA("Humanoid")
							if TargetHumanoid then
								Tool.Values.Executing.Value = false

								if Values.ZaWarudo.Value then
									repeat
										task.wait()
									until not Values.ZaWarudo.Value
								end								

								local ActualMeleeSounds = MeleeSounds:FindFirstChild(Tool.Name)

								if ActualMeleeSounds then
									Tag(TargetHumanoid, Player)

									Combat(Player, true, 30)
									Combat(TargetChar, true, math.huge)

									TargetHumanoid.Health = 0

									if ActualMeleeSounds:FindFirstChild("ExecuteHit") then
										local Hit = ActualMeleeSounds.ExecuteHit:Clone()
										Hit.PlaybackSpeed += math.random(-100, 100) / 1000
										Hit.Parent = HitPart
										Hit:Play()
										game:GetService("Debris"):AddItem(Hit, 2)
									else
										local Hits = ActualMeleeSounds.Hit:GetChildren()
										local Hit = Hits[math.random(1, #Hits)]:Clone()
										Hit.PlaybackSpeed += math.random(-100, 100) / 1000
										Hit.Parent = HitPart
										Hit:Play()
										game:GetService("Debris"):AddItem(Hit, 2)

										local HitSound2 = ActualMeleeSounds:FindFirstChild("HitSound2")
										if HitSound2 then
											HitSound2 = HitSound2:Clone()
											HitSound2.PlaybackSpeed += math.random(-100, 100) / 1000
											HitSound2.Parent = HitPart
											HitSound2:Play()
											game:GetService("Debris"):AddItem(HitSound2, 2)
										end
									end

									if Config.Customs.ExplodeFinish then
										local Explosion = Resources.Effects.Explosions:WaitForChild("ExplodeFinish"):Clone()
										Explosion.Name = Tool.Name.." Explosion"
										Explosion.Position = Pos1
										Explosion.Parent = workspace.Debris
										Explosion.Attachment.Emitter.Disabled = false
										game.Debris:AddItem(Explosion, 3)
									end

									task.spawn(function()
										if Config.Customs.CurseFinish then
											if TargetChar:FindFirstChild("HumanoidRootPart") then
												local Sound = Resources.Effects.CursedDaggerEffects["Strike"..math.random(1, 3)]:Clone()
												Sound.Parent = TargetChar.HumanoidRootPart
												Sound:Play()
												game.Debris:AddItem(Sound, 6)

												local Sound2 = Resources.Effects.CursedDaggerEffects["Laugh"]:Clone()
												Sound2.Parent = TargetChar.HumanoidRootPart
												Sound2:Play()
												game.Debris:AddItem(Sound2, 6)
											end
											local function Curse(Character)
												if Character:FindFirstChild("HumanoidRootPart") and Character:FindFirstChild("Head") and not Character:FindFirstChildWhichIsA("ForceField") and CharStats[Character.Name] then
													if (Character.HumanoidRootPart.Position - Pos1).Magnitude <= Config.Customs.CurseFinish.Radius / 2 then
														local Animation = Character.Humanoid:LoadAnimation(Resources.Animations.Burn)
														if not CharStats[Character.Name].Downed.Value then
															Animation:Play(0.1)
														end
														
														local Currents = CharStats[Character.Name].Currents
														local PoisonEffect = Instance.new("NumberValue")

														PoisonEffect.Name = "POIZSKRATA"
														PoisonEffect.Value = 0.5

														local NoIcon = Instance.new("BoolValue", PoisonEffect)
														NoIcon.Name = "NoIcon"
														NoIcon.Value = true

														PoisonEffect.Parent = Currents

														game:GetService("Debris"):AddItem(PoisonEffect, 2)

														if Character.Head:FindFirstChild("BurningSound") then
															Character.Head.BurningSound:Destroy()
														end

														local Sound = Resources.Sounds.BurningSound:Clone()
														Sound.Parent = Character.Head
														Sound:Play()
														game.Debris:AddItem(Sound, 8)

														local ZapS = ActualMeleeSounds.ZapS:Clone()
														ZapS.Parent = Character.HumanoidRootPart
														ZapS:Play()
														game.Debris:AddItem(ZapS, 3)

														local PlayerData = _G.PlayerData[Player.Name]
														if PlayerData then
															local Multi = 1
															if PlayerbaseData2[Player.Name].DoubleXP.Value then
																Multi = 2
															end
															local XP = XPAmounts.CursePlayer * Multi
															GotXP:FireClient(Player, XP)
															PlayerData.XP += XP
															UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
														end

														for _, Limb in pairs(Character:GetChildren()) do
															if Limb:IsA("BasePart") then
																local Fire = Resources.Effects.CursedDaggerEffects.Flames1:Clone()
																Fire.Parent = Limb

																task.spawn(function()
																	task.wait(Config.Customs.CurseFinish.Time)
																	Fire.Enabled = false
																end)

																game.Debris:AddItem(Fire, Config.Customs.CurseFinish.Time + 1)
															end
														end

														for _, Limb in pairs(CharStats[Character.Name].HealthValues:GetChildren()) do
															if Limb.Name ~= "Head" then
																if not Limb.Broken.Value then
																	local dmg = Config.Customs.CurseFinish.DPS * Config.Customs.CurseFinish.Time
																	if Limb.Value - dmg <= 0 then
																		Limb.Broken.Value = true
																	end
																	Limb.Value -= dmg
																end
															end
														end

														task.spawn(function()
															for i = 1, Config.Customs.CurseFinish.Time do
																if Character:FindFirstChild("Humanoid") and not Character:FindFirstChildWhichIsA("ForceField") then
																	if Character.Humanoid.Health - Config.Customs.CurseFinish.DPS <= 14 and not CharStats[Character.Name].Downed.Value then
																		if Character ~= TargetChar then
																			Character.Humanoid.Health = 13
																		end
																		Animation:Stop()
																	elseif Character.Humanoid.Health - Config.Customs.CurseFinish.DPS <= 14 and CharStats[Character.Name].Downed.Value then
																		Character.Humanoid:TakeDamage(Config.Customs.CurseFinish.DPS / 5) 
																	else
																		Character.Humanoid:TakeDamage(Config.Customs.CurseFinish.DPS)
																	end	

																	local PlayerData = _G.PlayerData[Player.Name]
																	if PlayerData then
																		local Multi = 1
																		if PlayerbaseData2[Player.Name].DoubleXP.Value then
																			Multi = 2
																		end
																		local XP = XPAmounts.BurnTick * Multi
																		GotXP:FireClient(Player, XP)
																		PlayerData.XP += XP
																		UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
																	end
																end
																task.wait(1)
															end
															Animation:Stop(1)
														end)

														task.wait(0.25)
													end
												end
											end

											Curse(TargetChar)

											for _, Character in pairs(workspace.Characters:GetChildren()) do
												if Character ~= Player.Character and Character ~= TargetChar then
													Curse(Character)
												end
											end
										end
									end)

									local XP_Sound = Resources.Effects.XP.XP_Sound:Clone()
									XP_Sound.Parent = Player.Character.HumanoidRootPart
									XP_Sound:Play()

									local XP_Particle = Resources.Effects.XP.XP_Particle:Clone()
									XP_Particle.Parent = Player.Character.HumanoidRootPart
									XP_Particle:Emit(50)

									game.Debris:AddItem(XP_Sound, 2)
									game.Debris:AddItem(XP_Particle, 2)

									Player.Character.Humanoid.Health = Player.Character.Humanoid.Health + 65

									local BloodEffectA = Instance.new("Attachment", HitPart)
									BloodEffectA.WorldPosition = Pos1
									BloodHitEvent:FireAllClients(BloodEffectA)
									game:GetService("Debris"):AddItem(BloodEffectA, 1)

									Tool.Event:FireClient(Player, "Hitmarker", (HitPart.Name == "Head"), 3)

									pcall(function()
										if CharStats[TargetChar.Name].HealthValues:FindFirstChild(HitPart.Name) then
											if Tool.Name == "Katana" or Tool.Name == "Military-Machete" or Tool.Name == "Taiga" or Tool.Name == "Metal-Bat" or Tool.Name == "Chainsaw" or Tool.Name == "Fire-Axe" then
												if CharStats[TargetChar.Name].HealthValues[HitPart.Name].Value - 100 * ArmorReduction <= 0 then
													if HitPart.Name == "Head" then
														CharStats[TargetChar.Name].HealthValues[HitPart.Name].Destroyed.Value = (Tool.Name == "Metal-Bat" or Tool.Name == "Chainsaw" or Tool.Name == "Fire-Axe")
														task.wait()
													end
												end 

												CharStats[TargetChar.Name].HealthValues[HitPart.Name].Value -= 100 * ArmorReduction
											end
										end
									end)
								end
							end
						end
					end
				elseif Tool.Values.Slashing1.Value then
					if ReplicatedStorage.Values.ZaWarudo.Value then
						if CollectionService:HasTag(HitPart, "ZWHIT") then
							return
						end
					end
					if not Config.MultipleHits then
						if CollectionService:HasTag(Tool.Values.Slashing1, TargetChar.Name) then
							return
						end
					end
					if CollectionService:HasTag(Player, "GotBlocked") then
						return
					end
					local t = TargetChar:FindFirstChildWhichIsA("Tool")
					if t then
						local v = t:FindFirstChild("Values")
						if v then
							local b = v:FindFirstChild("Blocking")
							if b then
								if b.Value then
									if CharStats:FindFirstChild(TargetChar.Name) then
										if not CharStats[TargetChar.Name].RagdollTime.RagdollSwitch.Value then
											if require(TargetChar:FindFirstChildWhichIsA("Tool").Config).BlockHitStrength and Config.BlockHitStrength then
												if (require(TargetChar:FindFirstChildWhichIsA("Tool").Config).BlockHitStrength >= Config.BlockHitStrength) then
													if Player.Character then
														if TargetChar:FindFirstChild("Torso") then
															local CharToChar = Player.Character.HumanoidRootPart.Position - TargetChar.Torso.Position

															local CharLookVect = TargetChar.Torso.CFrame.LookVector
															if CharToChar:Dot(CharLookVect) > 0 then
																t:FindFirstChild("Event"):FireClient(game:GetService("Players"):GetPlayerFromCharacter(TargetChar), "BH", true)
																Tool:FindFirstChild("Event"):FireClient(Player, "BH2", true)

																pcall(function()
																	local BlockHitSound = Sounds.Melees[t.Name].BlockHit:Clone()
																	BlockHitSound.Parent = TargetChar.Torso
																	BlockHitSound:Play()
																	BlockHitSound.PlaybackSpeed += math.random(-100, 100) / 1000
																	game:GetService("Debris"):AddItem(BlockHitSound, BlockHitSound.TimeLength / BlockHitSound.PlaybackSpeed)
																end)

																pcall(function()
																	local BlockSound = Sounds.Melees[t.Name].BlockStop:Clone()
																	BlockSound.Parent = t.Handle or Player.Character.Torso
																	BlockSound:Play()
																	game.Debris:AddItem(BlockSound, 3)
																end)

																CollectionService:AddTag(Player, "GotBlocked")

																t.Values.Blocking.Value = false

																pcall(function()
																	t.Handle.Spark.Sparks:Emit(20)
																end)

																local SP = Instance.new("NumberValue")
																SP.Name = "SP_Flinch"
																SP.Value = 0.25
																SP.Parent = CharStats[Player.Name].Currents
																game:GetService("Debris"):AddItem(SP, Config.BlockSettings.HitFlinchTime or 0.7)

																local Flinching = Instance.new("BoolValue")
																Flinching.Name = "Flinching"
																Flinching.Parent = CharStats[Player.Name].Currents
																game:GetService("Debris"):AddItem(Flinching, Config.BlockSettings.HitFlinchTime or 0.7)

																b.Value = false

																return
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
					if CharStats[Player.Name].Currents:FindFirstChild("Flinching") then
						return
					end
					local TargetHumanoid = TargetChar:FindFirstChildWhichIsA("Humanoid")
					if TargetHumanoid then
						if TargetHumanoid.Health <= 0 then
							return
						end
					end

					local Combo = 1

					for _, Tag in pairs(CollectionService:GetTags(Tool)) do
						if Tag == "3" then
							Combo = 3
						else
							if Tag == "2" then
								Combo = 2
							end
						end
					end
					
					if not CharStats[TargetChar.Name].Downed.Value then
						Tag(TargetHumanoid, Player)
					end
					
					Combat(Player, true, 30)
					Combat(TargetChar, true, 30)

					for _, Tag in pairs(CollectionService:GetTags(Tool)) do
						if string.match(Tag, "seed") then
							CollectionService:RemoveTag(Tool, Tag)
						end
					end

					local seed = math.random()
					CollectionService:AddTag(Tool, "seed "..seed)

					local ComboConfig = Config.Mains.S1
					if Config.Mains["S"..Combo] then
						ComboConfig = Config.Mains["S"..Combo]
					end

					local HitmarkerCombo = 1

					if Config.SlashStages ~= 3 then
						--Combo = 3
						HitmarkerCombo = 3
					end

					if Config.SlashStages == 3 then
						if CollectionService:HasTag(Tool, "Hit") then
							Tool.Event:FireClient(Player, "Hitmarker", (HitPart.Name == "Head"), nil, true)
						else
							if CollectionService:HasTag(Tool, Player.Name.." 1") and not CollectionService:HasTag(Tool, Player.Name.." 2") then
								HitmarkerCombo = 2
							elseif CollectionService:HasTag(Tool, Player.Name.." 2") then
								HitmarkerCombo = 3

								CollectionService:RemoveTag(Tool, Player.Name.." 1")
								CollectionService:RemoveTag(Tool, Player.Name.." 2")
							end

							Tool.Event:FireClient(Player, "Hitmarker", (HitPart.Name == "Head"), HitmarkerCombo)

							if HitmarkerCombo ~= 3 then
								if not CollectionService:HasTag(Tool, Player.Name.." "..HitmarkerCombo) then
									CollectionService:AddTag(Tool, Player.Name.." "..HitmarkerCombo)
								end
							end

							task.spawn(function()
								task.wait(ComboConfig.DebounceTime + ComboConfig.ComboEndTime)

								local seedcheck = CollectionService:HasTag(Tool, "seed "..seed)
								if seedcheck then
									CollectionService:RemoveTag(Tool, Player.Name.." 1")
									CollectionService:RemoveTag(Tool, Player.Name.." 2")
									CollectionService:RemoveTag(Tool, Player.Name.." 3")
									ResetBars:FireClient(Player)
								end
							end)

							CollectionService:AddTag(Tool, "Hit")
						end
					else
						Tool.Event:FireClient(Player, "Hitmarker", (HitPart.Name == "Head"), 3)
					end

					CollectionService:AddTag(Tool.Values.Slashing1, TargetChar.Name)

					local Damage = Config.Damage
					local DamageMulti1 = ComboConfig.DmgMulti
					local DamageMulti2 = 1
					local DamageMulti3 = 1
					if CharStats[TargetChar.Name].Downed.Value then
						DamageMulti3 = 3
					end
					if HitPart.Name == "Head" then
						DamageMulti2 = ComboConfig.DmgMulti2
					end

					local vel = nil
					if ReplicatedStorage.Values.ZaWarudo.Value then
						CollectionService:AddTag(HitPart, "ZWHIT")
						if Tool.Name == "ERADICATOR" then
							vel = (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 2000
						elseif Tool.Name == "Bat" then
							if Combo == 1 then
								vel = (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1300
							elseif Combo == 2 then
								vel = (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1300
							elseif Combo == 3 then
								vel = (Vector3.new(0, -1, 0)) * 1200
							end
						elseif Tool.Name == "BRUHBAR" then
							if Combo == 1 then
								vel = (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 10000
							elseif Combo == 2 then
								vel = (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 10000
							elseif Combo == 3 then
								vel = (Vector3.new(0, -1, 0)) * 5000
							end
						elseif Tool.Name == "Metal-Bat" then
							if Combo == 1 then
								vel = (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1800
							elseif Combo == 2 then
								vel = (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1800
							elseif Combo == 3 then
								vel = (Vector3.new(0, -1, 0)) * 1650
							end
						elseif Tool.Name == "Shovel" then
							if Combo == 1 then
								vel = (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1700
							elseif Combo == 2 then
								vel = (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1700
							end
						elseif Tool.Name == "Crowbar" or Tool.Name == "Golfclub" then
							if Combo == 1 then
								vel = (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500
							elseif Combo == 2 then
								vel = (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1500
							end
						elseif Tool.Name == "Wrench" then
							if Combo == 1 then
								vel = (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, -1, 0)) * 900
							elseif Combo == 2 then
								vel = (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 900
							end
						elseif Tool.Name == "BBaton" then
							if Combo == 1 then
								vel = (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, -1, 0)) * 1300
							elseif Combo == 2 then
								vel = (Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -1, 0)) * 1300
							end
						elseif Tool.Name == "Fists" or Tool.Name == "GOD_FISTS" then
							if Combo == 3 then
								vel = (-Player.Character.HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 2, 0)) * 1250
							else
								if TargetHumanoid.Health - Damage <= 15 and not CharStats[TargetChar.Name].Downed.Value then
									vel = (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 2, 0)) * 1250
								end
							end
						end
						ReplicatedStorage.Values.ZaWarudo:GetPropertyChangedSignal("Value"):Wait()
					end

					CollectionService:RemoveTag(HitPart, "ZWHIT")

					local breaklimb = false

					pcall(function()
						if not CharStats[TargetChar.Name].Downed.Value then
							if Config.BreakSettings.Enabled then
								local LookFor = "Head"

								if HitPart.Name == "Left Arm" then
									LookFor = "LArm"
								elseif HitPart.Name == "Right Arm" then
									LookFor = "RArm"
								elseif HitPart.Name == "Left Leg" then
									LookFor = "LLeg"
								elseif HitPart.Name == "Right Leg" then
									LookFor = "RLeg"
								end

								if CharStats[TargetChar.Name].HealthValues:FindFirstChild(HitPart.Name) then
									local ComboConfig = Config.Mains["S"..Combo] or Config.Mains.S1
									if ComboConfig then
										if not CharStats[TargetChar.Name].HealthValues[HitPart.Name].Broken.Value then
											if CharStats[TargetChar.Name].HealthValues[HitPart.Name].Value - (Config.BreakSettings[LookFor].Dmg * DamageMulti2) * ArmorReduction <= 0 then
												if not CharStats[TargetChar.Name].HealthValues[HitPart.Name].Broken.Value then
													if not Config.BreakSettings[LookFor.CantBreak] then												
														CharStats[TargetChar.Name].HealthValues[HitPart.Name].Broken.Value = (Config.BreakSettings.CanBreak and Config.BreakSettings.BreakType == "BoneBreak")

														if HitPart.Name == "Head" then
															CharStats[TargetChar.Name].HealthValues[HitPart.Name].Destroyed.Value = Config.BreakSettings.ExplodeHead
															if CharStats[TargetChar.Name].HealthValues[HitPart.Name].Destroyed.Value then
																CharStats[TargetChar.Name].HealthValues[HitPart.Name].Broken.Value = false
															end
															task.wait()
														end

														local PlayerData = _G.PlayerData[Player.Name]
														if PlayerData then
															local Multi = 1
															if PlayerbaseData2[Player.Name].DoubleXP.Value then
																Multi = 2
															end
															local XP = XPAmounts.DecapLimb * Multi
															if CharStats[TargetChar.Name].HealthValues[HitPart.Name].Destroyed.Value then
																XP = XPAmounts.ExplodeHead * Multi
															elseif CharStats[TargetChar.Name].HealthValues[HitPart.Name].Broken.Value then
																XP = XPAmounts.BreakLimb * Multi
															end
															GotXP:FireClient(Player, XP)
															PlayerData.XP += XP
															UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
															breaklimb = true
														end
													end
												end
											end 

											local function DmgLimb()
												CharStats[TargetChar.Name].HealthValues[HitPart.Name].Value = CharStats[TargetChar.Name].HealthValues[HitPart.Name].Value - (Config.BreakSettings[LookFor].Dmg * DamageMulti2) * ArmorReduction
											end

											if not Config.BreakSettings[LookFor.CantBreak] then
												DmgLimb()
											else
												if CharStats[TargetChar.Name].HealthValues[HitPart.Name].Value - (Config.BreakSettings[LookFor].Dmg * DamageMulti2) * ArmorReduction > 10 then
													DmgLimb()
												else
													CharStats[TargetChar.Name].HealthValues[HitPart.Name].Value = 10
												end
											end
										end
									end
								end
							end
						end
					end)

					Damage = ((Damage * DamageMulti1) * DamageMulti2) * ArmorReduction

					local Is = TargetHumanoid.Health - Damage <= 15 and not CharStats[TargetChar.Name].Downed.Value

					local function hit()
						if Is then
							local function check2()
								if HitPart.Name == "Head" then
									return check(TargetChar, HitPart)
								end
							end

							if not check2() then
								TargetHumanoid.Health = 13
							else
								TargetHumanoid:TakeDamage(Damage / DamageMulti3)
							end
						else
							TargetHumanoid:TakeDamage(Damage / DamageMulti3)
						end
					end

					if HitPart.Name == "Head" then
						if not CharStats[TargetChar.Name].HealthValues[HitPart.Name].Broken.Value then
							hit()
						end
					else
						hit()
					end

					local ToolStun = ToolStuns[Tool.Name]
					if ToolStun then
						ToolStun(Player, TargetChar, HitPart, Config, Combo, Is, vel, breaklimb)
					end

					if Tool.Values:FindFirstChild("PoisonCharges") and not TargetChar:FindFirstChild("RUNNING_POISON_HANDLER") then
						if Tool.Values.PoisonCharges.Value > 0 then
							Tool.Values.PoisonCharges.Value -= 1

							local POISON_HANDLER = Resources.POISON_HANDLER:Clone()
							POISON_HANDLER.Name = "RUNNING_POISON_HANDLER"
							POISON_HANDLER.Disabled = false
							POISON_HANDLER.Creator.Value = Player
							POISON_HANDLER.Parent = TargetChar
						end
					end

					local function Flinch(Animation)
						if not CharStats[TargetChar.Name].Downed.Value then
							local AnimationTrack = TargetHumanoid:LoadAnimation(Animation)
							AnimationTrack:Play()

							if not CharStats:FindFirstChild(TargetChar.Name).Currents:FindFirstChild("SD_Flinching") then
								local SD_Flinching = Instance.new("NumberValue", CharStats:FindFirstChild(TargetChar.Name).Currents)
								SD_Flinching.Name = "SD_Flinching"
								SD_Flinching.Value = 8
								game:GetService("Debris"):AddItem(SD_Flinching, ComboConfig.FlinchTime)
							end
						end
					end

					local FindTool = TargetChar:FindFirstChildWhichIsA("Tool")
					if FindTool then
						if not FindTool:FindFirstChild("NoFlinchAnim") then
							if FindTool:FindFirstChild("CustomFlinch") then
								local AnimationTable = {}

								table.insert(AnimationTable, FindTool.AnimsFolder.Flinch1)
								table.insert(AnimationTable, FindTool.AnimsFolder.Flinch2)

								Flinch(AnimationTable[math.random(1, #AnimationTable)])
							else
								Flinch(Animations.Flinch:GetChildren()[math.random(1, #Animations.Flinch:GetChildren())])
							end
						end
					else
						Flinch(Animations.Flinch:GetChildren()[math.random(1, #Animations.Flinch:GetChildren())])
					end

					local BloodEffectA = Instance.new("Attachment", HitPart)
					BloodEffectA.WorldPosition = Pos1
					BloodHitEvent:FireAllClients(BloodEffectA)
					game:GetService("Debris"):AddItem(BloodEffectA, 1)

					local Attachment = GetBloodAttachment(TargetChar, HitPart)

					if Attachment then
						ReplicatedStorage.Events.BloodTrailEvent:FireAllClients(Attachment, Config.Blood.A, true)
					end

					local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
					if TargetPlayer then
						local DiedData = {
							["KillerName"] = Player.Character.Humanoid.DisplayName,
							["KillDistance"] = math.floor(Magnitude + 0.5).." STUDS",
							["WeaponName"] = Tool.Name
						}
						DiedDataa:FireClient(TargetPlayer, DiedData)
					end

					local ActualMeleeSounds = MeleeSounds:FindFirstChild(Tool.Name)

					if ActualMeleeSounds then
						local HitsFolder = ActualMeleeSounds:FindFirstChild("Hit")
						if HitsFolder then
							local function DoHit(is)
								if is then
									local Hit = ActualMeleeSounds.ComboHit:Clone()
									Hit.Parent = HitPart
									Hit.PlaybackSpeed += math.random(-100, 100) / 1000
									Hit:Play()
									game:GetService("Debris"):AddItem(Hit, 2)
								else
									local Hits = HitsFolder:GetChildren()

									local Hit = Hits[math.random(1, #Hits)]:Clone()
									Hit.Parent = HitPart
									Hit.PlaybackSpeed += math.random(-100, 100) / 1000
									Hit:Play()
									game:GetService("Debris"):AddItem(Hit, 2)	
								end
							end

							DoHit((ActualMeleeSounds:FindFirstChild("ComboHit") and HitmarkerCombo == 3))

							local HitSound2 = ActualMeleeSounds:FindFirstChild("HitSound2")
							if HitSound2 then
								HitSound2 = HitSound2:Clone()
								HitSound2.Parent = HitPart
								HitSound2.PlaybackSpeed += math.random(-100, 100) / 1000
								HitSound2:Play()
								game:GetService("Debris"):AddItem(HitSound2, 2)
							end
						end
					end
				end
			elseif Type == "REV2" then
				if not Tool.Values.Reviving.Value then
					return
				end

				Tool.Values.Reviving.Value = false

				pcall(function()
					ReplicatedStorage:WaitForChild("CharStats")[Player.Name].Currents["SD_Reviving"]:Destroy()
				end)
				pcall(function()
					for _, v in pairs(ReplicatedStorage:WaitForChild("CharStats")[Player.Name].Currents:GetChildren()) do
						if v.Name == "AJ" then
							v:Destroy()
						end
					end
				end)
			end
		end
	end,
	ATM = function(Player, Type, Amt, MainPart)
		local ATMValues = MainPart.Parent:WaitForChild("Values")
		local ATMParts = MainPart.Parent:WaitForChild("Parts")

		if ATMValues.Busy.Value or ATMValues.User.Value then
			return
		end

		local function GetMagnitude()
			if Player.Character then
				if Player.Character:FindFirstChild("Torso") then
					if (MainPart.Position - Player.Character.Torso.Position).Magnitude < 10 then
						return true
					end
				end
			end
		end

		if not GetMagnitude() then
			MainPart.error:Play()
			task.spawn(function()
				ATMParts.Screen.Color = Color3.fromRGB(255, 0, 0)
				ATMParts.Screen.PointLight.Color = Color3.fromRGB(255, 0, 0)
				task.wait(1.7)
				ATMParts.Screen.Color = Color3.fromRGB(152, 180, 175)
				ATMParts.Screen.PointLight.Color = Color3.fromRGB(152, 180, 175)
			end)
			return false, "An error has occured in your request"
		end
		
		ATMParts.Screen.Color = Color3.fromRGB(255, 255, 0)
		ATMParts.Screen.PointLight.Color = Color3.fromRGB(255, 255, 0)

		local PlayerData = _G.PlayerData[Player.Name]

		if Type == "WI" then
			if PlayerData.Bank < Amt then
				MainPart.error:Play()
				task.spawn(function()
					ATMParts.Screen.Color = Color3.fromRGB(255, 0, 0)
					ATMParts.Screen.PointLight.Color = Color3.fromRGB(255, 0, 0)
					task.wait(1.7)
					ATMParts.Screen.Color = Color3.fromRGB(152, 180, 175)
					ATMParts.Screen.PointLight.Color = Color3.fromRGB(152, 180, 175)
				end)
				return false, "YOUR REQUEST EXCEEDS YOUR BANK BALANCE"
			end
			if PlayerData.Cash + Amt > 100000 then
				MainPart.error:Play()
				task.spawn(function()
					ATMParts.Screen.Color = Color3.fromRGB(255, 0, 0)
					ATMParts.Screen.PointLight.Color = Color3.fromRGB(255, 0, 0)
					task.wait(1.7)
					ATMParts.Screen.Color = Color3.fromRGB(152, 180, 175)
					ATMParts.Screen.PointLight.Color = Color3.fromRGB(152, 180, 175)
				end)
				return false, "YOUR REQUEST MUST BE A MAXIMUM OF 100000."
			end
		elseif Type == "DP" then
			if CharStats[Player.Name].Tags:FindFirstChild("inCombat_") then
				MainPart.error:Play()
				task.spawn(function()
					ATMParts.Screen.Color = Color3.fromRGB(255, 0, 0)
					ATMParts.Screen.PointLight.Color = Color3.fromRGB(255, 0, 0)
					task.wait(1.7)
					ATMParts.Screen.Color = Color3.fromRGB(152, 180, 175)
					ATMParts.Screen.PointLight.Color = Color3.fromRGB(152, 180, 175)
				end)
				return false, "CANNOT DEPOSIT WHILE IN COMBAT"
			end
			if PlayerData.Cash < Amt then
				MainPart.error:Play()
				task.spawn(function()
					ATMParts.Screen.Color = Color3.fromRGB(255, 0, 0)
					ATMParts.Screen.PointLight.Color = Color3.fromRGB(255, 0, 0)
					task.wait(1.7)
					ATMParts.Screen.Color = Color3.fromRGB(152, 180, 175)
					ATMParts.Screen.PointLight.Color = Color3.fromRGB(152, 180, 175)
				end)
				return false, "YOUR REQUEST EXCEEDS YOUR CASH BALANCE"
			end
		elseif Type == "REDEEM" then
			local Code = Codes[string.lower(Amt)]
			if Code then
				if Code.Expired then
					return false, "CODE EXPIRED"
				end
				if PlayerData.RedeemedCodes[string.lower(Amt)] then
					return false, "CODE ALREADY REDEEMED"
				end

				PlayerData.RedeemedCodes[string.lower(Amt)] = string.lower(Amt)

				if Code.Bank then
					PlayerData.Bank += Code.Bank
				end
				if Code.DoubleXP then
					PlayerbaseData2[Player.Name].DoubleXP.Timer.Value = Code.DoubleXP.Duration
					PlayerbaseData2[Player.Name].DoubleXP.Value = true

					PlayerData.DoubleXP = {
						["Enabled"] = true,
						["Timer"] = PlayerData.DoubleXP.Timer + Code.DoubleXP.Duration
					}
				end

				UpdateClientEvent:FireClient(Player, true, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

				return true, "CODE REDEEMED"
			end

			return false, "INVALID CODE"
		end	

		if Amt < 50 and Type ~= "REDEEM" then
			ATMParts.Screen.Color = Color3.fromRGB(152, 180, 175)
			ATMParts.Screen.PointLight.Color = Color3.fromRGB(152, 180, 175)
			return false, "YOUR REQUEST MUST BE A MINIMUM OF 50."
		end

		ATMValues.Busy.Value = true
		ATMValues.User.Value = Player

		MainPart.process:Play()

		task.wait(1.7)

		if not GetMagnitude() then
			MainPart.error:Play()

			ATMValues.Busy.Value = false
			ATMValues.User.Value = nil
			
			task.spawn(function()
				ATMParts.Screen.Color = Color3.fromRGB(255, 0, 0)
				ATMParts.Screen.PointLight.Color = Color3.fromRGB(255, 0, 0)
				task.wait(1.7)
				ATMParts.Screen.Color = Color3.fromRGB(152, 180, 175)
				ATMParts.Screen.PointLight.Color = Color3.fromRGB(152, 180, 175)
			end)

			return false, "An error has occured in your request"
		end

		if Type == "WI" then
			MainPart.withdraw:Play()
			
			task.spawn(function()
				ATMParts.Screen.Color = Color3.fromRGB(0, 255, 0)
				ATMParts.Screen.PointLight.Color = Color3.fromRGB(0, 255, 0)
				task.wait(1.7)
				ATMParts.Screen.Color = Color3.fromRGB(152, 180, 175)
				ATMParts.Screen.PointLight.Color = Color3.fromRGB(152, 180, 175)
			end)
			
			task.spawn(function()
				task.wait(2)

				ATMValues.Busy.Value = false
				ATMValues.User.Value = nil
			end)

			if PlayerData.Bank >= Amt then
				PlayerData.Cash += Amt
				PlayerData.Bank -= Amt

				UpdateClientEvent:FireClient(Player, true, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

				return true, "SUCCESS"
			else
				return false, "AMOUNT EXCEEDS CASH"
			end
		elseif Type == "DP" then
			MainPart.deposit:Play()
			
			task.spawn(function()
				ATMParts.Screen.Color = Color3.fromRGB(0, 255, 0)
				ATMParts.Screen.PointLight.Color = Color3.fromRGB(0, 255, 0)
				task.wait(1.7)
				ATMParts.Screen.Color = Color3.fromRGB(152, 180, 175)
				ATMParts.Screen.PointLight.Color = Color3.fromRGB(152, 180, 175)
			end)

			task.spawn(function()
				task.wait(4)

				ATMValues.Busy.Value = false
				ATMValues.User.Value = nil
			end)

			if PlayerData.Cash >= Amt then
				PlayerData.Cash -= Amt
				PlayerData.Bank += Amt

				UpdateClientEvent:FireClient(Player, true, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

				return true, "SUCCESS"
			else
				return false, "AMOUNT EXCEEDS CASH"
			end
		end
	end,
	MOVZREP = function(Player, a, b, c, d, e, f, g, h, i)
		for _, Plr in pairs(Players:GetPlayers()) do
			if Player ~= Plr then
				MOVZREPEvent:FireClient(Plr, a, b, c, d, e, f, g, h, i)
			end
		end
	end,
	CLMZALOW = function(Player, MainPart)
		if Player.Character then
			if Player.Character:FindFirstChild("HumanoidRootPart") then
				if (MainPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude < 10 then
					if PlayerbaseData2[Player.Name].NextAllowance.Value <= 0 then
						PlayerbaseData2[Player.Name].NextAllowance.Claim.Value = false

						local PlayerData = _G.PlayerData[Player.Name]

						PlayerData.Bank += 350

						UpdateClientEvent:FireClient(Player, true, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

						return true, "ALLOWANCE CLAIMED"
					end
				end
			end
		end
	end,
	BYZERSPROTEC = function(Player, Is, Type, MainPart)
		if Player.Character then
			if Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChildWhichIsA("Humanoid") then
				if Is and MainPart and not PlayerProtection[Player.Name].Is then
					if (MainPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude < 10 then
						Player.Character.HumanoidRootPart.Anchored = true

						if not Player.Character:FindFirstChild("ProtectionFF") then
							local ProtectionFF = Instance.new("ForceField", Player.Character)
							ProtectionFF.Name = "ProtectionFF"
						end
					end
				else
					Player.Character.HumanoidRootPart.Anchored = false

					if Player.Character:FindFirstChild("ProtectionFF") then
						Player.Character:FindFirstChild("ProtectionFF"):Destroy()
					end
				end
			end
		end
	end,
	MenuLoad = function(Player)
		if not CollectionService:HasTag(Player, "Loaded") and not CollectionService:HasTag(Player, "Loading") and not CollectionService:HasTag(Player, "Respawning") then
			task.wait(3)

			Player:LoadCharacter()
			CollectionService:AddTag(Player, "Loaded")
			CollectionService:RemoveTag(Player, "Loading")

			if DataStore:GetAsync(Player.UserId.."Tools") then
				for _, v in pairs(DataStore:GetAsync(Player.UserId.."Tools")) do
					if ServerStorage.Tools:FindFirstChild(v.Name) then
						local Tool = ServerStorage.Tools:FindFirstChild(v.Name):Clone()
						
						local LOADEDFROMDATASTORE = Instance.new("BoolValue", Tool)
						LOADEDFROMDATASTORE.Name = "LOADEDFROMDATASTORE"
						
						if Tool:FindFirstChild("Values") then
							if Tool.Values:FindFirstChild("Ammo") then
								Tool.Values.ChildAdded:Connect(function(C)
									task.wait()

									if C.Name == "SERVER_Ammo" then
										C.MaxValue = require(Tool.Config).MagSize
										C.Value = v["Ammo"]
									elseif C.Name == "SERVER_StoredAmmo" then
										C.MaxValue = require(Tool.Config).StoredAmmo
										C.Value = v["StoredAmmo"]
									end
								end)
							end
						end
						
						Tool.Parent = Player.Backpack
					end
				end
			end
		end
	end,
	["0924023902330"] = function(Player)

	end,
	__DFfDD = function(Player, Key, a, b, c)
		if Player.Character:FindFirstChildOfClass("ForceField") then
			return
		end
		if Values.ZaWarudo.Value then
			if Values.ZaWarudo.Value ~= Player then
				while true do
					task.wait()
					
					if not Values.ZaWarudo.Value then
						break
					end
				end
			end
		end			
		local CharStat = CharStats:FindFirstChild(Player.Name)
		local Character = Player.Character
		if CharStat and Character then
			local ArmorReduction = CharStat.FallDamageProof.Value
			if Key == "__--r" then
				coroutine.wrap(r)(Player, 1.5)
				if Character:FindFirstChild("Head") then
					if Character.Head:FindFirstChild("scream") then
						Character.Head.scream:Destroy()
					end

					local Screams = Resources.Sounds:WaitForChild("Screams"):GetChildren()
					local Scream = Screams[math.random(1, #Screams)]:Clone()
					Scream.Parent = Character["Head"]
					Scream:Play()
					game:GetService("Debris"):AddItem(Scream, 3)
				end
			elseif Key == "FllH" then
				if a and b and c then
					if typeof(a) == "Instance" and typeof(b) == "Instance" then
						if a.Transparency < 1 and b.Transparency < 1 then
							if c > 25 and c < 75 and not CharStats[Player.Name].RagdollTime.RagdollSwitch.Value then
								pcall(function()
									local FallSmall = Sounds.FallDamage.Small.FallSmall:Clone()
									FallSmall.Parent = Player.Character.Torso
									FallSmall:Play()
									game.Debris:AddItem(FallSmall, FallSmall.TimeLength / FallSmall.PlaybackSpeed)
								end)
							elseif c >= 75 and c < 100 then
								if not CharStat.Currents:FindFirstChild("FL") then
									local FL = Instance.new("BoolValue")
									FL.Name = "FL"
									FL.Parent = CharStat.Currents
									game.Debris:AddItem(FL, 0.2)

									Player.Character.Humanoid:TakeDamage((c / 7) * ArmorReduction)

									pcall(function()
										local Sounds = Sounds.FallDamage.Medium:GetChildren()
										local Sound = Sounds[math.random(1, #Sounds)]:Clone()
										Sound.Parent = Player.Character.Torso
										Sound:Play()
										game:GetService("Debris"):AddItem(Sound, 3)
									end)
								end
							elseif c >= 100 and c < 250 then
								Player.Character.Humanoid:TakeDamage((c / 7) * ArmorReduction)

								pcall(function()
									local Sounds = Sounds.FallDamage.Medium:GetChildren()
									local Sound = Sounds[math.random(1, #Sounds)]:Clone()
									Sound.Parent = Player.Character.Torso
									Sound:Play()
									game:GetService("Debris"):AddItem(Sound, 3)
								end)

								local BloodEffectA = Instance.new("Attachment", a)
								BloodEffectA.WorldPosition = a.Position
								BloodHitEvent:FireAllClients(BloodEffectA)
								game:GetService("Debris"):AddItem(BloodEffectA, 1)

								local LimbHealth = CharStat.HealthValues:FindFirstChild(a.Name)
								if LimbHealth then
									if not LimbHealth.Broken.Value then
										LimbHealth.Broken.Value = (LimbHealth.Value - c * ArmorReduction <= 0)
										LimbHealth.Value -= c * ArmorReduction
									end
								end
							elseif c >= 250 then
								Player.Character.Humanoid:TakeDamage(c * ArmorReduction)

								local BloodEffectA = Instance.new("Attachment", a)
								BloodEffectA.WorldPosition = a.Position
								BloodHitEvent:FireAllClients(BloodEffectA)
								game:GetService("Debris"):AddItem(BloodEffectA, 1)

								local LimbHealth = CharStat.HealthValues:FindFirstChild(a.Name)
								if LimbHealth then
									if not LimbHealth.Broken.Value then
										LimbHealth.Value -= c * ArmorReduction
									end
								end

								Events.BloodTrailEvent:FireAllClients(BloodEffectA, LimbBlood2, true)
							end
						end
					end
				end
			end
		end
	end,
	GetPingR = function(Player)
		return Player:GetNetworkPing()
	end,
	GetPing = function(Player)
		return true
	end,
	RepWalkSpeed = function(Player, Value)
		if CharStats:FindFirstChild(Player.Name) then
			CharStats:FindFirstChild(Player.Name).RepWalkSpeed.Value = Value or 16
		end
	end,
	DownResist = function(Player, Is)
		if Is then
			local CharStat = CharStats[Player.Name]
			if CharStat then
				if CharStat.Downed.Value then
					CharStat.Downed.Resisting.Value = true
					return true
				end
			end
		else
			local CharStat = CharStats[Player.Name]
			if CharStat then
				CharStat.Downed.Resisting.Value = false
				return false
			end
		end
	end,
	PAZ_TA = function(Player, Tool, n, Velocity)
		if Tool:IsDescendantOf(Player.Backpack) then
			if Tool:FindFirstChild("CantDrop") then
				if Tool.CantDrop.Value then
					return
				end
			end
			if Player.Character then
				if Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChildWhichIsA("Humanoid") then
					local function Drop(H)
						Tool.Parent = ServerStorage.TempDroppedTools
						if Tool:FindFirstChild("Tool6D") then
							Tool.Tool6D.Part0 = nil
							Tool.Tool6D.Part1 = nil
						end
						if Tool:FindFirstChild("Tool6D_Torso") then
							Tool.Tool6D_Torso.Part0 = nil
							Tool.Tool6D_Torso.Part1 = nil
						end
						if Tool:FindFirstChild("Rocket6D") then
							Tool.Rocket6D.Part0 = nil
							Tool.Rocket6D.Part1 = nil
						end
						
						local Drop = Instance.new("Model", workspace.Filter.SpawnedTools)
						local Handle = H:Clone()

						PhysicsService:SetPartCollisionGroup(Handle, "SpawnedItems")			

						for _, v in pairs(Handle:GetDescendants()) do
							if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Union") then
								PhysicsService:SetPartCollisionGroup(v, "SpawnedItems")
								v.CanCollide = true
								v.CanQuery = false
								v.Massless = true
							end
						end

						Handle.Parent = Drop
						Handle.CanCollide = false
						Handle.Massless = true
						Drop.PrimaryPart = Handle

						local Debounce = false

						local QueryPart = Instance.new("Part", Handle)
						QueryPart.Size = Vector3.new(0.5, 0.5, 0.5)
						QueryPart.CanQuery = true
						QueryPart.Massless = true
						QueryPart.CFrame = Handle.CFrame
						QueryPart.Transparency = 1

						Events.B:FireClient(Player)

						QueryPart.Touched:Connect(function(h)
							if h:IsDescendantOf(Player.Character) or h:IsDescendantOf(workspace.Filter) or h:IsDescendantOf(workspace.Characters) then
								return
							end
							if Handle.Velocity.Magnitude > 0 then
								if Debounce then
									return
								end

								Debounce = true

								local ActualMeleeSounds = MeleeSounds:FindFirstChild(Tool.Name)

								if ActualMeleeSounds then
									if ActualMeleeSounds:FindFirstChild("Metal") then
										local PlaybackSpeed = 1

										if ActualMeleeSounds.Metal:FindFirstChildOfClass("NumberValue") then
											PlaybackSpeed = ActualMeleeSounds.Metal:FindFirstChildOfClass("NumberValue").Value
										end

										local Impact = Sounds.MetalImpact:Clone()
										Impact.Parent = QueryPart
										Impact.PlaybackSpeed = PlaybackSpeed + math.random(-100, 100) / 1000
										Impact:Play()
										game.Debris:AddItem(Impact, 2)
									else
										local Impact = Sounds.NormalImpact:Clone()
										Impact.Parent = QueryPart
										Impact.PlaybackSpeed += math.random(-100, 100) / 1000
										Impact:Play()
										game.Debris:AddItem(Impact, 2)
									end
								else
									local Impact = Sounds.NormalImpact:Clone()
									Impact.Parent = QueryPart
									Impact.PlaybackSpeed += math.random(-100, 100) / 1000
									Impact:Play()
									game.Debris:AddItem(Impact, 2)
								end

								task.wait(0.3)

								Debounce = false
							end
						end)

						PhysicsService:SetPartCollisionGroup(QueryPart, "SpawnedItems")

						local Weld = Instance.new("WeldConstraint", Handle)
						Weld.Part0 = Handle
						Weld.Part1 = QueryPart

						local AssociatedDrop = Instance.new("ObjectValue")
						AssociatedDrop.Name = "AssociatedDrop"
						AssociatedDrop.Value = Drop
						AssociatedDrop.Parent = Tool

						local CF = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
						Drop:SetPrimaryPartCFrame(CF)

						local BodyVelocity = Instance.new("BodyVelocity", Handle)
						BodyVelocity.Velocity = Player.Character.HumanoidRootPart.CFrame.LookVector * 15
						game.Debris:AddItem(BodyVelocity, 0.18)

						task.wait(0.1)
						
						local DisplayItems = Player.Character:FindFirstChild("DisplayItems")
						if DisplayItems then
							local Holster = DisplayItems:FindFirstChild(Tool.Name)
							if Holster then
								Holster:Destroy()
							end
						end

						local Raycast = Ray.new(Player.Character.HumanoidRootPart.Position, Player.Character.HumanoidRootPart.CFrame.LookVector * require(Tool.PassConfig).Range or 3)
						local FindPart = workspace:FindPartOnRayWithIgnoreList(Raycast, {workspace.Filter, Player.Character})

						if FindPart then
							if FindPart.Parent:FindFirstChildOfClass("Humanoid") then
								local DropTo = Players:GetPlayerFromCharacter(FindPart.Parent)
								if DropTo then
									if Drop then
										local SlotUsage = 0
										if InventorySlotValues[Tool.Name] then
											SlotUsage = InventorySlotValues[Tool.Name]
										end

										if CharStats[DropTo.Name].InventorySlots.Value + SlotUsage <= CharStats[DropTo.Name].InventorySlots.MaxValue then
											local CF
											if Drop:FindFirstChild("Handle") then
												CF = Drop.Handle.CFrame
											elseif Drop:FindFirstChild("HHandle") then
												CF = Drop.HHandle.CFrame
											end

											Drop:Destroy()

											Tool.AssociatedDrop:Destroy()
											Tool.Parent = DropTo.Backpack

											local SoundPart = Instance.new("Part", workspace.Filter)
											SoundPart.Size = Vector3.new()
											SoundPart.CanCollide = false
											SoundPart.CanQuery = false
											SoundPart.Massless = true
											SoundPart.Anchored = true
											SoundPart.CFrame = CF

											local Sound = Instance.new("Sound", SoundPart)
											Sound.SoundId = "rbxassetid://388889683"
											Sound.Volume = 0.3
											Sound.PlaybackSpeed = 3
											task.spawn(function()
												task.wait()
												Sound:Play()
											end)

											game.Debris:AddItem(SoundPart, 3)

											if not DropTo.Character:FindFirstChildOfClass("Tool") then
												DropTo.Character.Humanoid:EquipTool(Tool)

												if Tool:FindFirstChild("Values") then
													if Tool.Values:FindFirstChild("ComEvent") then
														Tool.Values.ComEvent:FireClient(DropTo, "Sync")
													end
												end
											end
										end
									end
								end
							end
						end
					end
					
					if Tool:FindFirstChild("Handle") then
						Drop(Tool:FindFirstChild("Handle"))
					elseif Tool:FindFirstChild("HHandle") then
						Drop(Tool:FindFirstChild("HHandle"))
					end
				end
			end
		end
	end,
	PIC_TLO = function(Player, PrimaryPart)
		if not PrimaryPart then
			return
		end
		local Drop = PrimaryPart:FindFirstAncestorWhichIsA("Model")
		if Drop then
			for _, Tool in pairs(ServerStorage.TempDroppedTools:GetChildren()) do
				if Tool:FindFirstChild("AssociatedDrop") then
					if Tool.AssociatedDrop.Value then
						if Tool.AssociatedDrop.Value == Drop then
							if CharStats:FindFirstChild(Player.Name) then
								local Magnitude = (Player.Character.Torso.Position - PrimaryPart.Position).Magnitude
								if Magnitude < 10 then
									local SlotUsage = 0
									if InventorySlotValues[Tool.Name] then
										SlotUsage = InventorySlotValues[Tool.Name]
									end

									if CharStats[Player.Name].InventorySlots.Value + SlotUsage > CharStats[Player.Name].InventorySlots.MaxValue then
										ClientWarn:FireClient(Player, { "Item exceeds inventory slots!", 1.5, Color3.fromRGB(255, 121, 121), Color3.new(0, 0, 0), "lost" })
									else
										Tool.AssociatedDrop:Destroy()
										Tool.Parent = Player.Backpack

										local CF
										if Drop:FindFirstChild("Handle") then
											CF = Drop.Handle.CFrame
										elseif Drop:FindFirstChild("HHandle") then
											CF = Drop.HHandle.CFrame
										end								

										local SoundPart = Instance.new("Part", workspace.Filter)
										SoundPart.Size = Vector3.new()
										SoundPart.CanCollide = false
										SoundPart.CanQuery = false
										SoundPart.Massless = true
										SoundPart.Anchored = true
										SoundPart.CFrame = CF

										local Sound = Instance.new("Sound")
										Sound.SoundId = "rbxassetid://388889683"
										Sound.Volume = 0.3
										Sound.PlaybackSpeed = 3
										Sound.Parent = SoundPart
										Sound:Play()

										game.Debris:AddItem(SoundPart, 3)

										if not Player.Character:FindFirstChildOfClass("Tool") then
											Player.Character.Humanoid:EquipTool(Tool)
										end

										Drop:Destroy()
									end
								end
							end
						end
					end
				end
			end
		end
	end,
	CZDPZUS = function(Player, PrimaryPart)
		local Drop = PrimaryPart
		if Drop and not PlayerbaseData2:FindFirstChild(tostring(Player)).Misc:FindFirstChild("DropDebounce") then
			local Value = Drop:FindFirstChild("Value")
			if Value then

				local Amount = Value.Value

				local PlayerData = _G.PlayerData[Player.Name]
				PlayerData.Cash = PlayerData.Cash + Amount

				UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

				local SoundPart = Instance.new("Part", workspace.Filter)
				SoundPart.Size = Vector3.new()
				SoundPart.CanCollide = false
				SoundPart.CanQuery = false
				SoundPart.Massless = true
				SoundPart.Anchored = true
				SoundPart.CFrame = Drop.CFrame

				local Sound = Instance.new("Sound")
				Sound.SoundId = "rbxassetid://388889683"
				Sound.Volume = 0.3
				Sound.PlaybackSpeed = 3
				Sound.Parent = SoundPart
				Sound:Play()

				game.Debris:AddItem(SoundPart, 3)

				Drop:Destroy()
			end
		end
	end,
	DCZSH = function(Player, Amount)
		local Character = Player.Character
		local PlayerData = _G.PlayerData[tostring(Player)]
		local PbD = PlayerbaseData2:FindFirstChild(tostring(Player))
		
		if PlayerData then
			if PlayerData.Cash - Amount < 0 then
				return false
			end
		end		
		if Character:FindFirstChild("HumanoidRootPart") then
			if (PbD.TotalDropped.Value + Amount) > PbD.TotalDropped.MaxValue then
				local Db = PbD.Misc:FindFirstChild("DropDebounce2")
				if not Db then
					Db = Instance.new("NumberValue", PbD.Misc)
					Db.Name = ("DropDebounce2")
				else
					return false, Db.Value
				end
				if Db then
					task.spawn(function()
						for i = 600, 0, -1 do
							task.wait(1)
							Db.Value = i
						end
						PbD.TotalDropped.Value = PbD.TotalDropped.Value - Amount
						Db:Destroy()
					end) 
				end
			end
			if Amount > 250 or Amount < 10 then
				return false, PbD.Misc:FindFirstChild("DropDebounce").Value or 0
			end

			local Debounce = Instance.new("NumberValue", PbD.Misc)
			Debounce.Name = ("DropDebounce")

			local CF = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)

			local PickupSound = Instance.new("Sound", Character:FindFirstChild("HumanoidRootPart"))
			PickupSound.SoundId = "rbxassetid://388889683"
			PickupSound.Volume = 0.3
			PickupSound.PlaybackSpeed = 3	

			local Cash = Resources.CashDrop:Clone()
			Cash.Value.Value = Amount
			Cash.A.GUI.TextLabel.Text = "$"..Amount
			Cash.CFrame = CF
			Cash.Orientation = Vector3.new(0, 180, 90)
			Cash.Parent = workspace.Filter.SpawnedBread
			PickupSound:Play()
			PlayerData.Cash = PlayerData.Cash - Amount
			PbD.TotalDropped.Value = PbD.TotalDropped.Value + Amount

			UpdateClientEvent:FireClient(Player, true, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)

			task.spawn(function()
				for i = 5, 0, -1 do
					task.wait(1)
					Debounce.Value = i
				end

				Debounce:Destroy()
			end)

			return true, nil
		end
	end,
	GZ_U = function(Player, Tick, Tool, Type, Is)
		if not Tool then
			return
		end
		if Type == "LaserSwitch" then
			Events.Effect:FireAllClients("LaserHandler", Tool, Is)
		elseif Type == "FirePump" then
			local CharStat = GVF(Player.Name)

			if CharStat then
				Events.Effect:FireAllClients("FirePump", Player, true, Tool, Is)	
			end
		elseif Type == "ChargeUp" then

		elseif Type == "ChargeDown" then

		elseif Type == "ScopeGlint" then
			local Config = Tool:FindFirstChild("Config")
			if Config then
				Config = require(Config)
				if Config.Customs then
					if Config.Customs.ScopeGlint then
						if Tool.Attachments:FindFirstChild("SGlarePart") then
							Events.Effect:FireAllClients("ScopeGlint", Tool.Attachments.SGlarePart, Is, Config.Customs.ScopeGlint)
						end
					end
				end
			end
		end
	end,
	GZ_S = function(Player, Tick, BulletCode, Tool, Key, Origin, Direction, BulletType, BulletInfo)
		local Character = Player.Character
		if Character then
			if not Tool:IsDescendantOf(Player.Character) and not Tool:IsDescendantOf(Player.Backpack) then
				return
			end

			local Config = require(Tool.Config)

			local ToolValues = Tool:FindFirstChild("Values")

			if ToolValues.SERVER_Ammo.Value <= 0 or ToolValues.Reloading.Value then
				return
			end

			ToolValues.SERVER_Ammo.Value = ToolValues.SERVER_Ammo.Value - 1

			task.wait()

			ToolValues.ComEvent:FireClient(Player, "Sync")

			if not Config.GrenadeLauncherEnabled and not Config.RocketLauncherEnabled and (not Config.Customs or not Config.Customs.Snowball) then
				Events.Effect:FireAllClients("Shoot", nil, Player, BulletCode, Tool, Origin, Direction, BulletInfo)
			else
				if Values.ZaWarudo.Value then
					while true do
						task.wait()
						if not Values.ZaWarudo.Value then
							break
						end
					end			
				end
	
				Combat(Player, true, 30)
				local RocketFind = Resources.Effects.Rockets:FindFirstChild(Config.RocketName)
				if RocketFind then
					local Rocket = RocketFind:Clone()
					Rocket.Parent = workspace.Debris.VParts
					Rocket:SetNetworkOwner(Player)
					Rocket.CFrame = CFrame.new(Origin, Direction[1])
					Rocket.Sound:Play()
					if Rocket:FindFirstChild("Laugh") then
						Rocket.Laugh:Play()
					end

					local Handle = Tool:FindFirstChild("Handle")
					if Handle then
						local FireSound = Handle.Muzzle:FindFirstChild("FireSound")
						if FireSound then
							local Clone = FireSound:Clone()
							Clone.Name = "FireSound1"
							Clone.Parent = Handle.Muzzle
							Clone.PlaybackSpeed += math.random(-100, 100) / 1000
							Clone:Play()
							game.Debris:AddItem(Clone, 5)
						end
					end

					local BodyForce = Instance.new("BodyForce")
					BodyForce.Force = Vector3.new(0, Config.RocketUpForce, 0)
					BodyForce.Parent = Rocket

					Rocket.Velocity = Rocket.CFrame.LookVector * Config.RocketSpeed

					local Hit = false

					task.spawn(function()
						task.wait(Config.RotStartTime)

						if not Hit and Rocket:FindFirstChild("RotPart") then
							local BodyAngularVelocity = Instance.new("BodyAngularVelocity", Rocket.RotPart)
							BodyAngularVelocity.P = 1250
							BodyAngularVelocity.MaxTorque = Vector3.new(99999997952, 99999997952, 99999997952)
							BodyAngularVelocity.AngularVelocity = -Rocket.RotPart.CFrame.RightVector * Config.RocketRotVel
						end
					end)

					local function Explode(Position, DidReach)
						if Rocket then
							if Rocket:FindFirstChild("Rocket") and Rocket:FindFirstChild("RotPart") and Rocket:FindFirstChild("EffectA") and not Hit then
								Rocket.Event:FireClient(Player)
								
								Rocket.Anchored = true
								Rocket.Rocket.Transparency = 1
								Rocket.RotPart:ClearAllChildren()
								Rocket.EffectA.Smoke.Enabled = false
								for _, v in pairs(Rocket.EffectA:GetChildren()) do
									if v:IsA("ParticleEmitter") then
										v.Enabled = false
									end
								end
								Rocket.EffectA.PointLight.Enabled = false
								Rocket.Sound:Stop()
								if Rocket:FindFirstChild("Laugh") then
									Rocket.Laugh:Stop()
								end
								game.Debris:AddItem(Rocket, 3)

								Hit = true

								local ExplosionFind = game:GetService("ServerStorage").Resources.Effects.Explosions:FindFirstChild(Config.ExplosionName)
								if Config.DistExplosionType then
									if Config.DistExplosionType.ExplosionName then
										ExplosionFind = game:GetService("ServerStorage").Resources.Effects.Explosions:FindFirstChild(Config.DistExplosionType.ExplosionName)
									end
								end
								if DidReach then
									ExplosionFind = game:GetService("ServerStorage").Resources.Effects.Explosions:FindFirstChild(Config.ExplosionName)
								end
								if ExplosionFind then
									local Explosion = ExplosionFind:Clone()
									Explosion.Parent = workspace.Debris
									Explosion.Position = Position or Rocket.Position
									Explosion.Creator.Value = Player
									Explosion.Creator.Tool.Value = Tool.Name
									if Tool:FindFirstChild("REDACT") then
										Explosion.Creator.Tool.Value = "[REDACTED]"
									end
									Explosion.Attachment.Emitter.Disabled = false
									game.Debris:AddItem(Explosion, 3)
								end
							end
						end
					end

					task.spawn(function()
						task.wait(Config.RocketMaxTime)

						Explode()
					end)

					Events.ProjectileMonitor:FireClient(Player, Rocket, {workspace.Filter, workspace.Debris, Character, Tool, Rocket}, Origin)

					local Event = Rocket:FindFirstChild("Event")
					if not Event then
						Event = Instance.new("RemoteEvent", Rocket)
						Event.Name = "Event"
					end

					local Has = false

					Event.OnServerEvent:Connect(function(Player, Key, Rocket, Position)
						if Key == "Custom" then
							if not Has and Rocket:FindFirstChild("Custom") then
								Has = true
								require(Rocket.Custom)()
							end
						else
							if Rocket then
								Explode(Position, Has)
							end
						end
					end)		
				end
			end
		end
	end,
	GZ_R = function(Player, Tick, Key, Tool, Rand)
		if not Player.Character then
			return
		end		
		if not Tool then
			return
		end
		if not Tool:IsDescendantOf(Player.Character) then
			return
		end		

		local CharStat = GVF(Player.Name)

		if CharStat then
			if Key == "STZNRD" then		
				local LeftArmBroken = CharStat.HealthValues["Left Arm"].Broken.Value	
				local RightArmBroken = CharStat.HealthValues["Right Arm"].Broken.Value	

				Tool.Values.Reloading.Value = true

				local Config = require(Tool.Config)

				local Speed = Config.ReloadAnimSpeed
				local Time = Config.ReloadTime
				if LeftArmBroken then
					Time = Time * 1.25
					Speed = Speed / 1.25
				end
				if RightArmBroken then
					Time = Time * 1.25
					Speed = Speed / 1.25
				end
				if CharStat.Currents:FindFirstChild("RL_SPM") then
					Time = Time / CharStat.Currents.RL_SPM.Value
					Speed = Speed * CharStat.Currents.RL_SPM.Value
				end	

				Events.Effect:FireAllClients("Reload", Player, Tool, true, nil, Speed)
				
				if Config.ShotgunSettings.ShotgunReload then
					local MagSize = Config.MagSize - Tool.Values.SERVER_Ammo.Value
					if Tool.Values.SERVER_StoredAmmo.Value < MagSize and (not Config.Customs or not Config.Customs.SnowReload) then
						MagSize = Tool.Values.SERVER_StoredAmmo.Value
					end
					local Value1 = Tool.Values.SERVER_Ammo.Value
					local Value2 = Tool.Values.SERVER_StoredAmmo.Value			
					for i = 1, MagSize do
						task.wait(Config.ShotgunSettings.ShellInTime / Speed)
						if not Tool.Values.Reloading.Value then
							break
						end
						Tool.Values.SERVER_Ammo.Value = Value1 + i
						Tool.Values.SERVER_StoredAmmo.Value = Value2 - i
						
						Tool.Values.ComEvent:FireClient(Player, "Sync")
					end
				else
					local CurrentTime = 0
					local CurrentTick = tick()

					while true do
						game:GetService("RunService").Heartbeat:Wait()
						CurrentTime = tick() - CurrentTick
						if not Tool then
							break
						end
						if not Tool.Values.Reloading.Value then
							break
						end
						if CurrentTime >= Time then
							break
						end
						if not Tool:IsDescendantOf(Player.Character) then
							break
						end
					end

					if CurrentTime >= Time and Tool.Values.Reloading.Value and Tool:IsDescendantOf(Player.Character) then
						local MagSize = Config.MagSize - Tool.Values.SERVER_Ammo.Value
						if Tool.Values.SERVER_StoredAmmo.Value < MagSize and (not Config.Customs or not Config.Customs.SnowReload) then
							MagSize = Tool.Values.SERVER_StoredAmmo.Value
						end

						Tool.Values.SERVER_Ammo.Value = Tool.Values.SERVER_Ammo.Value + MagSize
						Tool.Values.SERVER_StoredAmmo.Value = Tool.Values.SERVER_StoredAmmo.Value - MagSize
					end
				end

				local ToolValues = Tool:FindFirstChild("Values")
				ToolValues.ComEvent:FireClient(Player, "Sync")

				Tool.Values.Reloading.Value = false
			elseif Key == "CANZZELCULTUUUR" then
				if not Tool:IsDescendantOf(Player.Character) and not Tool:IsDescendantOf(Player.Backpack) then
					return
				end
				if not Tool.Values.Reloading.Value then
					return
				end
				
				Tool.Values.Reloading.Value = false

				Events.Effect:FireAllClients("ReloadCancel", Player, Tool, true)
			end
		end
	end,
	ZFKLF_H = function(Player, Key, Tick, Tool, TargetChar, Number, HitPart, Pos1, Pos2, Unknown1, Unknown2, HitTag)
		if not Tool then
			return
		end
		if not Player.Character then
			return
		end
		if not Tool:IsDescendantOf(Player.Character) then
			return
		end
		if not HitPart then
			return
		end
		if not HitPart.Parent then
			return
		end
		if not HitPart.Parent:FindFirstChildWhichIsA("Humanoid") then
			return
		end
		
		TargetChar = HitPart.Parent
		
		if not Player.Character:FindFirstChild("HumanoidRootPart") then
			return
		end
		if not TargetChar:FindFirstChild("HumanoidRootPart") then
			return
		end
		if TargetChar:FindFirstChildWhichIsA("ForceField") then
			return
		end
		if not CharStats:FindFirstChild(TargetChar.Name) then
			return
		end
		if Players:GetPlayerFromCharacter(TargetChar) then
			if TeamCheck(Player, Players:GetPlayerFromCharacter(TargetChar)) then
				return
			end
		end
		
		local TargetHumanoid = TargetChar:FindFirstChildWhichIsA("Humanoid")
		
		if not TargetHumanoid then
			return
		end
		
		local Magnitude = (TargetChar.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude

		local Config = require(Tool.Config)
		
		local ArmorReduction = 1
		
		local breaklimb = false
		
		local Vel = nil
		if ReplicatedStorage.Values.ZaWarudo.Value then
			Vel = (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 2, 0)) * 1500
			ReplicatedStorage.Values.ZaWarudo:GetPropertyChangedSignal("Value"):Wait()
		end
		
		if not CharStats:FindFirstChild(TargetChar.Name) then
			return
		end
		
		local IsArmored = require(Modules.IsArmored).Check(HitPart, TargetChar)
		if IsArmored.Value then
			if HitPart.Name == "HumanoidRootPart" or HitPart.Name == "Torso" then
				ArmorReduction = CharStats[TargetChar.Name].BulletProof["Torso"].Value
			else
				ArmorReduction = CharStats[TargetChar.Name].BulletProof[HitPart.Name].Value
			end			
			
			local ArmorDamage = Config.ArmorPenetration * 8
			
			local ArmorHP = "Body"
			if HitPart.Name == "Head" then
				ArmorHP = "Head"
			end
			
			if CharStats[TargetChar.Name].ArmorHP:FindFirstChild(ArmorHP).Value > 0 then
				if CharStats[TargetChar.Name].ArmorHP:FindFirstChild(ArmorHP).Value - ArmorDamage <= 0 then
					Events.Effect:FireAllClients("ArmorBreak", Player, HitPart, HitPart, Pos1, Pos1)
					Tool.Hitmarker2:FireClient(Player, "AR")
					
					local PlayerData = _G.PlayerData[Player.Name]
					if PlayerData then
						local Multi = 1
						if PlayerbaseData2[Player.Name].DoubleXP.Value then
							Multi = 2
						end
						local XP = XPAmounts.ArmorBreak * Multi
						GotXP:FireClient(Player, XP)
						PlayerData.XP += XP
						UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
					end
				end

				CharStats[TargetChar.Name].ArmorHP:FindFirstChild(ArmorHP).Value -= ArmorDamage
			else
				ArmorReduction = 1
			end
		end
		
		local Damage = GunDamage.Calculate(Tool, HitPart, TargetChar.HumanoidRootPart.Position, Player.Character.HumanoidRootPart.Position) * ArmorReduction

		if not CharStats[TargetChar.Name].Downed.Value then
			Tag(TargetHumanoid, Player)

			local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
			if TargetPlayer then
				local DiedData = {
					["KillerName"] = Player.Character.Humanoid.DisplayName,
					["KillDistance"] = math.floor(Magnitude + 0.5).." STUDS",
					["WeaponName"] = Tool.Name
				}
				DiedDataa:FireClient(TargetPlayer, DiedData)
			end
		end

		pcall(function()
			if not CharStats[TargetChar.Name].Downed.Value then
				if CharStats[TargetChar.Name].HealthValues:FindFirstChild(HitPart.Name) then
					if not CharStats[TargetChar.Name].HealthValues[HitPart.Name].Broken.Value then
						if Config.Customs then
							if Config.Customs.LimbDamage2 then
								if CharStats then
									local Dmg = Config.Customs.LimbDamage2.Dmg
									if HitPart.Name == "Head" then
										Dmg *=
										Config.Customs.LimbDamage2.HeadMultiplier
									else
										Dmg *= Config.Customs.LimbDamage2.Multiplier
									end

									Dmg *= ArmorReduction

									if CharStats[TargetChar.Name].HealthValues[HitPart.Name].Value - Dmg <= 0 then
										if HitPart.Name == "Head" then
											CharStats[TargetChar.Name].HealthValues[HitPart.Name].Destroyed.Value = (Config.Customs.LimbDamage2.HeadBreakType == "Explode")
										else
											CharStats[TargetChar.Name].HealthValues[HitPart.Name].Broken.Value = (Config.Customs.LimbDamage2.LimbBreakType ~= "Destroy")
										end
									end

									CharStats[TargetChar.Name].HealthValues[HitPart.Name].Value -= Dmg
								end

								local PlayerData = _G.PlayerData[Player.Name]
								if PlayerData then
									local Multi = 1
									if PlayerbaseData2[Player.Name].DoubleXP.Value then
										Multi = 2
									end
									local XP = XPAmounts.DecapLimb * Multi
									if CharStats[TargetChar.Name].HealthValues[HitPart.Name].Destroyed.Value then
										XP = XPAmounts.ExplodeHead * Multi
									elseif CharStats[TargetChar.Name].HealthValues[HitPart.Name].Broken.Value then
										XP = XPAmounts.BreakLimb * Multi
									end
									GotXP:FireClient(Player, XP)
									PlayerData.XP += XP
									UpdateClientEvent:FireClient(Player, false, PlayerData.Data, PlayerData.Bank, PlayerData.Cash, PlayerData, PlayerData.Bounty)
								end

								breaklimb = true
							end
						end
					end
				end
			end
		end)
		
		Combat(Player, true, 30)
		if Players:GetPlayerFromCharacter(TargetChar) then
			Combat(Players:GetPlayerFromCharacter(TargetChar), true, 30)
		end
		
		if Config.Customs then
			if Config.Customs.ExplosiveHit then
				local ExplosionFind = game:GetService("ServerStorage").Resources.Effects.Explosions:FindFirstChild(Config.Customs.ExplosiveHit.Type)
				if ExplosionFind then
					local Explosion = ExplosionFind:Clone()
					Explosion.Parent = workspace.Debris
					Explosion.Position = Pos1
					Explosion.Creator.Value = Player
					Explosion.Creator.Tool.Value = Tool.Name
					if Tool:FindFirstChild("REDACT") then
						Explosion.Creator.Tool.Value = "[REDACTED]"
					end
					Explosion.Attachment.Emitter.Disabled = false
					game.Debris:AddItem(Explosion, 3)
				end
			end
		end
		
		local function Flinch(Animation)
			if not CharStats[TargetChar.Name].Downed.Value then
				local AnimationTrack = TargetHumanoid:LoadAnimation(Animation)
				AnimationTrack:Play()
			
				if not CharStats:FindFirstChild(TargetChar.Name).Currents:FindFirstChild("SD_Flinching") then
					local SD_Flinching = Instance.new("NumberValue", CharStats:FindFirstChild(TargetChar.Name).Currents)
					SD_Flinching.Name = "SD_Flinching"
					SD_Flinching.Value = 8
					game:GetService("Debris"):AddItem(SD_Flinching, Config.FlinchTime)
				end
			end
		end

		local FindTool = TargetChar:FindFirstChildWhichIsA("Tool")
		if FindTool then
			if not FindTool:FindFirstChild("IsGun") then
				if FindTool:FindFirstChild("CustomFlinch") then
					local AnimationTable = {}

					table.insert(AnimationTable, FindTool.AnimsFolder.Flinch1)
					table.insert(AnimationTable, FindTool.AnimsFolder.Flinch2)

					Flinch(AnimationTable[math.random(1, #AnimationTable)])
				else
					Flinch(Animations.Flinch:GetChildren()[math.random(1, #Animations.Flinch:GetChildren())])
				end
			end
		else
			Flinch(Animations.Flinch:GetChildren()[math.random(1, #Animations.Flinch:GetChildren())])
		end
		
		if TargetHumanoid.Health - Damage <= 14 then
			if CharStats[TargetChar.Name].Downed.Value then
				GunDamage.Damage(TargetHumanoid, Damage / Config.DownedDiv)
			else
				if not (HitPart.Name == "Head" and breaklimb) then
					TargetHumanoid.Health = 13	
				end
				
				if not CollectionService:HasTag(TargetChar, "Vel") then
					CollectionService:AddTag(TargetChar, "Vel")
					
					local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)
					if TargetPlayer then
						if breaklimb and HitPart.Name == "Head" then
							HitPart = TargetChar.HumanoidRootPart
						end

						Events.FT_:FireClient(TargetPlayer, HitPart, Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 2, 0)) * 1500, 0.18)
					else
						local Force = Instance.new("BodyForce")
						Force.Force = Vel or (Player.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 2, 0)) * 1500
						Force.Parent = HitPart
						game:GetService("Debris"):AddItem(Force, 0.18)
					end
				end
			end
		else
			GunDamage.Damage(TargetHumanoid, Damage)
			
			CollectionService:RemoveTag(TargetChar, "Vel")
		end
	end,
}

for _, Event in pairs(Events:GetChildren()) do
	if EventsTable[Event.Name] then
		if Event:IsA("RemoteEvent") then
			Event.OnServerEvent:Connect(EventsTable[Event.Name])
		elseif Event:IsA("RemoteFunction") then
			Event.OnServerInvoke = EventsTable[Event.Name]
		end
	end
end

local RestockTime = 300

for _, Dealer in pairs(workspace.Map.Shopz:GetChildren()) do
	Dealer.RestockTime.Value = RestockTime
end

local MinuteIncrement = 1 / 25

local Success, ErrorMessage = pcall(function()
	local Response = HttpService:GetAsync("http://ip-api.com/json/", true)
	local Data = HttpService:JSONDecode(Response)
	local UsedData = Data.countryCode

	if Data.status == "success" then

		for _,v in pairs(Values:GetChildren()) do
			if v.Name == "ServerRegion" then

				v.Value = (UsedData)

			end
		end
	end
end)

if not Success then
	warn("There was an error retrieving server location")
	warn(ErrorMessage)
end

task.spawn(function()
	while true do
		task.wait(1)
		
		Values.ServerTick.Value = tick()
		
		for _, Dealer in pairs(workspace.Map.Shopz:GetChildren()) do
			if Dealer.RestockTime.Value <= 0 then
				Dealer.RestockTime.Value = RestockTime
				for _, Stock in pairs(Dealer.CurrentStocks:GetChildren()) do
					Stock.Value = Stock.MaxValue
				end
			else
				Dealer.RestockTime.Value -= 1
			end
		end

		if Values.TimeState.Enabled.Value then
			Values.TimeState.Value += MinuteIncrement
		end

		if Values.TimeState.Value >= 24 then
			Values.TimeState.Value = 0
		end
		
		for _, Player in pairs(Players:GetPlayers()) do
			task.spawn(function()
				if CollectionService:HasTag(Player, "Loaded") and not CollectionService:HasTag(Player, "Loading") then
					local PlayerbaseData = PlayerbaseData2:FindFirstChild(Player.Name)
					if PlayerbaseData then
						if PlayerbaseData:FindFirstChild("NextAllowance") and PlayerbaseData:FindFirstChild("DoubleXP") then
							if PlayerbaseData.NextAllowance.Value - 1 < 0 then
								PlayerbaseData.NextAllowance.Value = 600
							end

							PlayerbaseData.NextAllowance.Value -= 1 

							if PlayerbaseData.DoubleXP.Value then
								if PlayerbaseData.DoubleXP.Timer.Value - 1 < 0 then
									PlayerbaseData.DoubleXP.Value = false
									PlayerbaseData.DoubleXP.Timer.Value = 0
								end

								PlayerbaseData.DoubleXP.Timer.Value -= 1
							end
						end
					end
				end
			end)
		end
	end
end)