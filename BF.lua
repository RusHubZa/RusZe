local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Rus Hub", "DarkTheme")
local AutoFarmTab = Main:Tab("Auto Farm")
	local MainAutoFarmFunction = AutoFarm(Ms,NameQuest,LevelQuest,NameMon,CFrameMon,CFrameQuest,"AutoFarmLevel")
	spawn(function()
		while true do CheckQuest()
			if Auto_Farm then
				MainAutoFarmFunction:Update(Ms,NameQuest,LevelQuest,NameMon,CFrameMon,CFrameQuest)
			end
			fastWait(.09)
		end
	end)
	AutoFarmTab:Toggle("Auto Farm Level", getgenv().Setting["Auto Farm Level"],function(a)
		Auto_Farm = a
		MainAutoFarmFunction:UpdateFarmMode("AutoFarmLevel")
		if Auto_Farm then
			MainAutoFarmFunction:Start()
		else
			MainAutoFarmFunction:Stop()
		end
	end)
	FastTween = false
	AutoFarmTab:Toggle("Very Fast Tween ( Not Recommend For KaiTun )", false,function(a)
		FastTween = a
	end)
	
	fastattack = true
	AutoFarmTab:Toggle("Fast Attack", true,function(a)
		fastattack = a
	end)
	if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("Candies","Check") then
		AutoFarmTab:Line()
		AutoFarmTab:Toggle("Auto Buy Exp x2", getgenv().Setting["Auto Buy Exp x2"],function(a)
			_G.AutoBuyExp = a
		end)
		AutoFarmTab:Toggle("Auto Buy Exp x2 [ Exp Expire ]", getgenv().Setting["Auto Buy Exp x2[ Exp Expire ]"],function(a)
			_G.AutoBuyExpExpire = a
		end)
		spawn(function()
			while wait() do
				if _G.AutoBuyExp then
					local args = {
						[1] = "Candies",
						[2] = "Buy",
						[3] = 1,
						[4] = 1
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
				if _G.AutoBuyExpExpire and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main") and not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Level.Exp.Text,"2x ends in") then
					local args = {
						[1] = "Candies",
						[2] = "Buy",
						[3] = 1,
						[4] = 1
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
			end
		end)
	end
	if OldWorld then
		AutoFarmTab:Line()
		-- Auto New World
		AutoFarmTab:Toggle("Auto New World", getgenv().Setting["Auto New World"],function(vu)
			AutoNew = vu
		end)
		spawn(function()
			while wait() do
				if AutoNew then
					local MyLevel = game.Players.localPlayer.Data.Level.Value
					if MyLevel >= 700 and OldWorld and AutoNew then
						if Auto_Farm then
							MainAutoFarmFunction:Stop()
						end
						if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then
							if Workspace.Map.Ice.Door.Transparency == 1 then
								if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
									if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
										local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
										wait(.4)
										game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
									end
									DoorNewWorldTween = toTarget(CFrame.new(1347.7124, 37.3751602, -1325.6488).Position,CFrame.new(1347.7124, 37.3751602, -1325.6488))
									if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if DoorNewWorldTween then DoorNewWorldTween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1347.7124, 37.3751602, -1325.6488)
									end
								elseif game.Workspace.Enemies:FindFirstChild("Ice Admiral [Lv. 700] [Boss]") and game.Workspace.Map.Ice.Door.CanCollide == false and game.Workspace.Map.Ice.Door.Transparency == 1 and (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
									if DoorNewWorldTween then DoorNewWorldTween:Stop() end
									CheckBoss = true
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if CheckBoss and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Ice Admiral [Lv. 700] [Boss]" then
											repeat wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													Usefastattack = true
													if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
														local args = {
															[1] = "Buso"
														}
														game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
													Click()
												end 
											until not CheckBoss or not v.Parent or v.Humanoid.Health <= 0 or AutoNew == false
											Usefastattack = false
										end
									end
									CheckBoss = false
								end 
							else
								if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") or game.Players.LocalPlayer.Character:FindFirstChild("Key") then
									DoorNewWorldTween = toTarget(CFrame.new(1347.7124, 37.3751602, -1325.6488).Position,CFrame.new(1347.7124, 37.3751602, -1325.6488))
									if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if DoorNewWorldTween then DoorNewWorldTween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1347.7124, 37.3751602, -1325.6488)
										local args = {
											[1] = "DressrosaQuestProgress",
											[2] = "Detective"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										wait(0.5)
										if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
											local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
											wait(.4)
											game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
										end
									end
								else
									AutoNewWorldTween = toTarget(CFrame.new(4849.29883, 5.65138149, 719.611877).Position,CFrame.new(4849.29883, 5.65138149, 719.611877))
									if (CFrame.new(4849.29883, 5.65138149, 719.611877).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if DoorNewWorldTween then DoorNewWorldTween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4849.29883, 5.65138149, 719.611877)
										local args = {
											[1] = "DressrosaQuestProgress",
											[2] = "Detective"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										wait(0.5)
										if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
											local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
											wait(.4)
											game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
										end
									end
								end
							end
						else
							local args = {
								[1] = "TravelDressrosa" -- OLD WORLD to NEW WORLD
							}
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
						end
					end
				end
			end
		end)
	elseif NewWorld then
		AutoFarmTab:Line()
		AutoFarmTab:Toggle("Auto Factory", getgenv().Setting["Auto Factory"],function(A)
			Factory = A
			if not Factory then
				FactoryCore = false
			end
		end)
		spawn(function()
			while wait() do
				if Factory then
					if game.Workspace.Enemies:FindFirstChild("Core") then
						FactoryCore = true
						MainAutoFarmFunction:Stop()
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if FactoryCore and v.Name == "Core" and v.Humanoid.Health > 0 then
								repeat wait(.1)
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
									elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
										if Farmtween then
											Farmtween:Stop()
										end
										EquipWeapon(SelectToolWeapon)
										Usefastattack = true
										if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
											local args = {
												[1] = "Buso"
											}
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 20)
										Click()
									end
								until not FactoryCore or v.Humanoid.Health <= 0 or Factory == false
								Usefastattack = false
							end
						end
					elseif game.ReplicatedStorage:FindFirstChild("Core") and game.ReplicatedStorage:FindFirstChild("Core"):FindFirstChild("Humanoid") then
						FactoryCore = true
						MainAutoFarmFunction:Stop()
						GOtween = toTarget(CFrame.new(448.46756, 199.356781, -441.389252).Position,CFrame.new(448.46756, 199.356781, -441.389252).CFrame)
						if (CFrame.new(448.46756, 199.356781, -441.389252).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
							if Farmtween then
								GOtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(448.46756, 199.356781, -441.389252)
						end
					elseif Auto_Farm then
						FactoryCore = false
						MainAutoFarmFunction:Start()
					end
				end
			end
		end)
		AutoFarmTab:Toggle("Auto third World", getgenv().Setting["Auto third World"],function(vu)
			if SelectToolWeapon == "" and vu then
				Flux:Notification("Select Weapon First in Tab Auto Farm")
			else
				OldSelectToolWeapon = SelectToolWeapon
				Autothird = vu
			end	
		end)
		spawn(function()
			while wait() do
				if Autothird then
					local MyLevel = game.Players.localPlayer.Data.Level.Value
					if MyLevel >= 1500 and NewWorld and Autothird then
						if Auto_Farm then
							MainAutoFarmFunction:Stop()
						end
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 then
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
								local args = {
									[1] = "TravelZou" -- OLD WORLD to NEW WORLD
								}
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								
								if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 0 then
									if game.Workspace.Enemies:FindFirstChild("rip_indra [Lv. 1500] [Boss]") then 	
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if v.Name == "rip_indra [Lv. 1500] [Boss]" and v:FindFirstChild("Humanoid")and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
															local args = {
																[1] = "Buso"
															}
															game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
														end
														game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
														Click()
													end 
												until not Autothird or not v.Parent or v.Humanoid.Health <= 0 
												wait(.5)
												asmrqq = 2
												repeat wait()
													local args = {
														[1] = "TravelZou" -- OLD WORLD to NEW WORLD
													}
													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
												until asmrqq == 1
												Usefastattack = false
											end
										end
									else -- SlashHit : rbxassetid://2453605589
										local string_1 = "ZQuestProgress";
										local string_2 = "Check";
										local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
										Target:InvokeServer(string_1, string_2);
										wait()
										local string_1 = "ZQuestProgress";
										local string_2 = "Begin";
										local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
										Target:InvokeServer(string_1, string_2);
									end
								elseif game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
									local args = {
										[1] = "TravelZou" -- OLD WORLD to NEW WORLD
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								else
									if game.Workspace.Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") then 	
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if v.Name == "Don Swan [Lv. 1000] [Boss]" and v:FindFirstChild("Humanoid")and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
															local args = {
																[1] = "Buso"
															}
															game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
														end
														game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
														Click()
													end 
												until not Autothird or not v.Parent or v.Humanoid.Health <= 0 
												Usefastattack = false
											end
										end
									else -- SlashHit : rbxassetid://2453605589
										TweenDonSwanthireworld = toTarget(CFrame.new(2288.802, 15.1870775, 863.034607).Position,CFrame.new(2288.802, 15.1870775, 863.034607))
										if (CFrame.new(2288.802, 15.1870775, 863.034607).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if TweenDonSwanthireworld then
												TweenDonSwanthireworld:Stop()
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2288.802, 15.1870775, 863.034607)
											end
										end
									end
								end
							else
								if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
									TabelDevilFruitStore = {}
									TabelDevilFruitOpen = {}
	
									for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
										for i1,v1 in pairs(v) do
											if i1 == "Name" then 
												table.insert(TabelDevilFruitStore,v1)
											end
										end
									end
	
									for i,v in next,game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
										if v.Price >= 1000000 then  
											table.insert(TabelDevilFruitOpen,v.Name)
										end
									end
	
									for i,DevilFruitOpenDoor in pairs(TabelDevilFruitOpen) do
										for i1,DevilFruitStore in pairs(TabelDevilFruitStore) do
											if DevilFruitOpenDoor == DevilFruitStore and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then    
												if not game.Players.LocalPlayer.Backpack:FindFirstChild(DevilFruitStore) then   
													local string_1 = "LoadFruit";
													local string_2 = DevilFruitStore;
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
												else
													local string_1 = "TalkTrevor";
local string_2 = "1";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "TalkTrevor";
local string_2 = "2";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "TalkTrevor";
local string_2 = "3";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
end
end
end
end

local string_1 = "TalkTrevor";
local string_2 = "1";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "TalkTrevor";
local string_2 = "2";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "TalkTrevor";
local string_2 = "3";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
end
end
else
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then 
if game.Workspace.Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if v.Name == "Swan Pirate [Lv. 775]" then
pcall(function()
repeat wait()
    if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
        Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
    elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
        if Farmtween then
            Farmtween:Stop()
        end
        EquipWeapon(SelectToolWeapon)
        Usefastattack = true
        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
            local args = {
                [1] = "Buso"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
        Click()
    end 
until not v.Parent or v.Humanoid.Health <= 0 or Autothird == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
AutoBartiloBring = false
Usefastattack = false
end)
end
end
else
Questtween = toTarget(CFrame.new(1057.92761, 137.614319, 1242.08069).Position,CFrame.new(1057.92761, 137.614319, 1242.08069))
if (CFrame.new(1057.92761, 137.614319, 1242.08069).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1057.92761, 137.614319, 1242.08069)
end
end
else
Bartilotween = toTarget(CFrame.new(-456.28952, 73.0200958, 299.895966).Position,CFrame.new(-456.28952, 73.0200958, 299.895966))
if ( CFrame.new(-456.28952, 73.0200958, 299.895966).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Bartilotween then
Bartilotween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =  CFrame.new(-456.28952, 73.0200958, 299.895966)
local args = {
[1] = "StartQuest",
[2] = "BartiloQuest",
[3] = 1
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end 
elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
if game.Workspace.Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
Ms = "Jeremy [Lv. 850] [Boss]"
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if v.Name == Ms then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
    Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
    local args = {
        [1] = "Buso"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not v.Parent or v.Humanoid.Health <= 0 or Autothird == false
Usefastattack = false
end
end
else
Bartilotween = toTarget(CFrame.new(2099.88159, 448.931, 648.997375).Position,CFrame.new(2099.88159, 448.931, 648.997375))
if (CFrame.new(2099.88159, 448.931, 648.997375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Bartilotween then
Bartilotween:Stop()
end
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2099.88159, 448.931, 648.997375)
end
end
elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
if (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Bartilotween = toTarget(CFrame.new(-1836, 11, 1714).Position,CFrame.new(-1836, 11, 1714))
elseif (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Bartilotween then
Bartilotween:Stop()
end
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1836, 11, 1714)
wait(.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1850.49329, 13.1789551, 1750.89685)
wait(.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
wait(.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
wait(.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
wait(.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1869.54224, 15.987854, 1681.00659)
wait(.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1800.0979, 16.4978027, 1684.52368)
wait(.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1819.26343, 14.795166, 1717.90625)
wait(.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1813.51843, 14.8604736, 1724.79541)
end
end
end
end
end
end
end)
end
AutoFarmTab:Line()
-- Auto Superhuman
AutoFarmTab:Toggle("Auto Superhuman", getgenv().Setting["Auto Superhuman"],function(vu)
Superhuman = vu
if vu then
local args = {
[1] = "BuyElectro"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end)
AutoFarmTab:Toggle("Auto Superhuman [Full]", getgenv().Setting["Auto Superhuman [Full]"],function(vu)
SuperhumanFull = vu
end)
-- Auto Death Step
AutoFarmTab:Toggle("Auto Death Step",getgenv().Setting["Auto Death Step"],function(vu)
DeathStep = vu
if vu then
local args = {
[1] = "BuyBlackLeg"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end)
-- Auto Dargon Talon
AutoFarmTab:Toggle("Auto Dragon Talon", getgenv().Setting["Auto Dragon Talon"],function(vu)
DargonTalon = vu
if vu then
local args = {
[1] = "BlackbeardReward",
[2] = "DragonClaw",
[3] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end)
-- Auto Electric clow
AutoFarmTab:Toggle("Auto Electric Clow", getgenv().Setting["Auto Electric Clow"],function(vu)
Electricclow = vu
if vu then
local args = {
[1] = "BuyElectro"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end)
spawn(function()
while wait(.25) do
if Superhuman or SuperhumanFull and game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then 
if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
local args = {
[1] = "BuyElectro"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end   
if game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") then
SelectToolWeapon = "Superhuman"
end  
if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value <= 299  then
SelectToolWeapon = "Black Leg"
end
if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value <= 299  then
SelectToolWeapon = "Electro"
end
if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value <= 299  then
SelectToolWeapon = "Fishman Karate"
end
if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 299  then
SelectToolWeapon = "Dragon Claw"
end
if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 300  then
local args = {
[1] = "BuyFishmanKarate"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 300  then
local args = {
[1] = "BuyFishmanKarate"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 100  then
local args = {
[1] = "BuyBlackLeg"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 300  then
local args = {
[1] = "BuyBlackLeg"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 300  then
if SuperhumanFull and game.Players.LocalPlayer.Data.Fragments.Value < 1500 then
if game.Players.LocalPlayer.Data.Level.Value > 1100 then
RaidsSelected = "Flame"
AutoRaids = true
RaidsArua = true
end
else
AutoRaids = false
RaidsArua = false
local args = {
[1] = "BlackbeardReward",
[2] = "DragonClaw",
[3] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end
if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300  then
if SuperhumanFull and game.Players.LocalPlayer.Data.Fragments.Value < 1500 then
if game.Players.LocalPlayer.Data.Level.Value > 1100 then
RaidsSelected = "Flame"
AutoRaids = true
RaidsArua = true
end
else
AutoRaids = false
RaidsArua = false
local args = {
[1] = "BlackbeardReward",
[2] = "DragonClaw",
[3] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end
if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 300  then
local args = {
[1] = "BuySuperhuman"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 300  then
local args = {
[1] = "BuySuperhuman"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end 
end
if DeathStep and game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 400 then
local args = {
[1] = "BuyDeathStep"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
SelectToolWeapon = "Death Step"
end  
if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 400 then
local args = {
[1] = "BuyDeathStep"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

SelectToolWeapon = "Death Step"
end  
if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value < 400 then
SelectToolWeapon = "Black Leg"
end 
end
if DargonTalon and game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 399 and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
SelectToolWeapon = "Dragon Claw"
end
if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value <= 399 and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
SelectToolWeapon = "Dragon Claw"
end

if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 400 and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
SelectToolWeapon = "Dragon Claw"
if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 3 then
local string_1 = "Bones";
local string_2 = "Buy";
local number_1 = 1;
local number_2 = 1;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2, number_1, number_2);

local string_1 = "BuyDragonTalon";
local bool_1 = true;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, bool_1);
elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon")
else
local string_1 = "BuyDragonTalon";
local bool_1 = true;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, bool_1);
local string_1 = "BuyDragonTalon";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1);
end 
end
end
if Electricclow and game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value < 400 then
SelectToolWeapon = "Electro"
end  
if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value < 400 then
SelectToolWeapon = "Electro"
end  
if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 then
local v175 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", true);
if v175 == 4 then
local v176 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start");
if v176 == nil then
game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12548, 337, -7481)
end
else
local string_1 = "BuyElectricClaw";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1);
end
end
if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
local v175 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", true);
if v175 == 4 then
local v176 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start");
if v176 == nil then
game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12548, 337, -7481)
end
else
local string_1 = "BuyElectricClaw";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1);
end
end
end
end
end)
-- Auto Buy Legendary Sword
AutoFarmTab:Toggle("Auto Buy Legendary Sword", getgenv().Setting["Auto Buy Legendary Sword"],function(Value)
Legendary = Value    
end)
AutoFarmTab:Toggle("Auto Buy Legendary Sword Hop", getgenv().Setting["Auto Buy Legendary Sword Hop"],function(Value)
LegendaryHop = Value    
end)
-- Auto Buy Enhancement
AutoFarmTab:Toggle("Auto Buy Enhancement", getgenv().Setting["Auto Buy Enhancement"],function(Value)
Enhancement = Value    
end)
spawn(function()
while wait() do
if Legendary then
local args = {
[1] = "LegendarySwordDealer",
[2] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end 
if LegendaryHop then
local args = {
[1] = "LegendarySwordDealer",
[2] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
wait(7)
local args = {
[1] = "LegendarySwordDealer",
[2] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
wait()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(v.maxPlayers) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
local delFile = pcall(function()
-- delfile("NotSameServers.json")
AllIDs = {}
table.insert(AllIDs, actualHour)
end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(.1)
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
wait(3)
end 
if Enhancement then
local args = {
[1] = "ColorsDealer",
[2] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end 
end
end)   
AutoFarmTab:Line()
-- Mastery Tab
AutoFarmTab:Label("-- Auto Farm Mastery --")
AutoFarmTab:Toggle("Auto Farm Devil Fruit Mastery",autofarmmasterybf,function(v)
if SelectToolWeapon == "" and v then
VLib:Notification("Select Weapon First")
else
MasteryDevilFruit = v
MainAutoFarmFunction:UpdateFarmMode("AutoFarmDevilfruit")
if MasteryDevilFruit then
MainAutoFarmFunction:Start()
else
MainAutoFarmFunction:Stop()
end
end	
end)
AutoFarmTab:Toggle("Auto Farm Gun Mastery",autofarmmasterybf,function(v)
if SelectToolWeapon == "" and v then
VLib:Notification("Select Weapon First")
else
MasteryGun = v
MainAutoFarmFunction:UpdateFarmMode("AutoFarmGun")
if MasteryGun then
MainAutoFarmFunction:Start()
else
MainAutoFarmFunction:Stop()
end
end	
end)
AutoFarmTab:Toggle("Auto Farm Weapon Mastery",autofarmmasterybf,function(v)
if SelectToolWeapon == "" and v then
VLib:Notification("Select Weapon First")
else
MasteryWeapon = v
MainAutoFarmFunction:UpdateFarmMode("AutoFarmWeapon")
if MasteryWeapon then
MainAutoFarmFunction:Start()
else
MainAutoFarmFunction:Stop()
end
end	
end)
Persen = 15
AutoFarmTab:Slider("Health %",1,100,Persen,nil,function(v)
Persen = v
end)

Weapon = {}
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
if v:IsA("Tool") then
table.insert(Weapon ,v.Name)
end
end
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
if v:IsA("Tool") then
table.insert(Weapon, v.Name)
end
end
AutoFarmTab:Line()
SelectToolWeapon = getgenv().Setting["Select Weapon"] or ""
AutoFarmTab:Label("Select Weapon",true)
local SelectedWeapon = AutoFarmTab:Dropdown("Selected Weapon",Weapon,0,function(a)
SelectToolWeapon = a 
end)
AutoFarmTab:Button("Refrash", function()
Weapon = {}
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
if v:IsA("Tool") then
table.insert(Weapon ,v.Name)
end
end
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
if v:IsA("Tool") then
table.insert(Weapon, v.Name)
end
end
SelectedWeapon:Refresh(Weapon,0)
end)

AutoFarmTab:Line()
AutoFarmTab:Label("Auto Farm Setting",true)
AUTOHAKI = true
AutoFarmTab:Toggle("Auto Haki", AUTOHAKI,function(Value)
AUTOHAKI = Value  
end)
AutoFarmTab:Toggle("Auto Observation haki", false,function(Value)
AUTOHAKIObs = Value  
end)
AutoRejoin = _G.AutoRejoin or false
AutoFarmTab:Toggle("Auto Rejoin", getgenv().Setting["Auto Rejoin"],function(a)
AutoRejoin = a
end)
UseTP = false
-- Bypass_TP_Toggle = AutoFarmTab:Toggle("Bypass TP",false,function(Value)
--     UseTP = Value
-- end)
-- AdminSettingTp = false
-- spawn(function()
--     while wait() do
--         if game:GetService("Players").LocalPlayer:FindFirstChild("Data").Stats.Defense.Level.Value <= 1 and AdminSettingTp then
--             Bypass_TP_Toggle:Unlock()
--         else
--             Bypass_TP_Toggle:Lock()
--         end
--         wait(10)
--     end
-- end)
AutoFarmTab:Toggle("Magnet", true,function(Value)
Magnet = Value  
end)
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
wait(1)
vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
AutoFarmTab:Toggle("Anit AFK", true,function(vu)
game:GetService("Players").LocalPlayer.Idled:connect(function()
vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
wait(1)
vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
end)
AutoFarmTab:Label("Auto Farm Mastery Skill Setting",true)
AutoFarmTab:Toggle("Skill Z", true,function(a)
SkillZ = a
end)
AutoFarmTab:Toggle("Skill X", true,function(a)
SkillX = a
end)
AutoFarmTab:Toggle("Skill C", true,function(a)
SkillC = a
end)
AutoFarmTab:Toggle("Skill V", true,function(a)
SkillV = a
end)
spawn(function()
while wait(.1) do
if game.Players.LocalPlayer.PlayerGui.Main.HP.TextLabel.Text == "Health 100/100" and StatsBypass == "Bypassed" then
StatsBypass = "NoBypassTP"
end
if AUTOHAKI then 
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end
if AUTOHAKIObs then 
if game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") and game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
else wait(1)
game:service('VirtualUser'):CaptureController()
game:service('VirtualUser'):SetKeyDown('0x65')
wait(2)
game:service('VirtualUser'):SetKeyUp('0x65')
end
end
end
end)

----------------------------------------------------------------------------------------------------------------------------

local AutoFarmMiscTab = Main:Tab("Auto Farm Misc")
AutoFarmMiscTab:Label("Auto Farm Boss",true)
AutoQuestBoss = true
function CheckQuestBoss()
-- Old World
if SelectBoss == "Saber Expert [Lv. 200] [Boss]" then
MsBoss = "Saber Expert [Lv. 200] [Boss]"
CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564, 0.858821094, 1.13848939e-08, 0.512275636, -4.85649254e-09, 1, -1.40823326e-08, -0.512275636, 9.6063415e-09, 0.858821094)
elseif SelectBoss == "The Saw [Lv. 100] [Boss]" then
MsBoss = "The Saw [Lv. 100] [Boss]"
CFrameBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854, -0.290192783, 6.88365773e-08, 0.956968188, 6.98413629e-08, 1, -5.07531119e-08, -0.956968188, 5.21077759e-08, -0.290192783)
elseif SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" then
MsBoss = "Greybeard [Lv. 750] [Raid Boss]"
CFrameBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666, -0.433646321, -1.03394289e-08, 0.901083171, -3.0443168e-08, 1, -3.17633075e-09, -0.901083171, -2.88092288e-08, -0.433646321)
elseif SelectBoss == "The Gorilla King [Lv. 25] [Boss]" then
MsBoss = "The Gorilla King [Lv. 25] [Boss]"
NameQuestBoss = "JungleQuest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
CFrameBoss = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-08, 0.950426519, -3.37275488e-08, 1, 7.06501808e-08, -0.950426519, -5.40241736e-08, 0.310949147)
elseif SelectBoss == "Bobby [Lv. 55] [Boss]" then
MsBoss = "Bobby [Lv. 55] [Boss]"
NameQuestBoss = "BuggyQuest1"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
CFrameBoss = CFrame.new(-1147.65173, 32.5966301, 4156.02588, 0.956680477, -1.77109952e-10, -0.29113996, 5.16530874e-10, 1, 1.08897802e-09, 0.29113996, -1.19218679e-09, 0.956680477)
elseif SelectBoss == "Yeti [Lv. 110] [Boss]" then
MsBoss = "Yeti [Lv. 110] [Boss]"
NameQuestBoss = "SnowQuest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(1384.90247, 87.3078308, -1296.6825, 0.280209213, 2.72035177e-08, -0.959938943, -6.75690828e-08, 1, 8.6151708e-09, 0.959938943, 6.24481444e-08, 0.280209213)
CFrameBoss = CFrame.new(1221.7356, 138.046906, -1488.84082, 0.349343032, -9.49245944e-08, 0.936994851, 6.29478194e-08, 1, 7.7838429e-08, -0.936994851, 3.17894653e-08, 0.349343032)
elseif SelectBoss == "Mob Leader [Lv. 120] [Boss]" then
MsBoss = "Mob Leader [Lv. 120] [Boss]"
CFrameBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.92824)
elseif SelectBoss == "Vice Admiral [Lv. 130] [Boss]" then
MsBoss = "Vice Admiral [Lv. 130] [Boss]"
NameQuestBoss = "MarineQuest2"
LevelQuestBoss = 2
CFrameQuestBoss = CFrame.new(-5035.42285, 28.6520386, 4324.50293, -0.0611100644, -8.08395768e-08, 0.998130739, -1.57416586e-08, 1, 8.00271849e-08, -0.998130739, -1.08217701e-08, -0.0611100644)
CFrameBoss = CFrame.new(-5078.45898, 99.6520691, 4402.1665, -0.555574954, -9.88630566e-11, 0.831466436, -6.35508286e-08, 1, -4.23449258e-08, -0.831466436, -7.63661632e-08, -0.555574954)
elseif SelectBoss == "Warden [Lv. 175] [Boss]" then
MsBoss = "Warden [Lv. 175] [Boss]"
NameQuestBoss = "ImpelQuest"
LevelQuestBoss = 1
CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
elseif SelectBoss == "Chief Warden [Lv. 200] [Boss]" then
MsBoss = "Chief Warden [Lv. 200] [Boss]"
NameQuestBoss = "ImpelQuest"
LevelQuestBoss = 2
CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
elseif SelectBoss == "Swan [Lv. 225] [Boss]" then
MsBoss = "Swan [Lv. 225] [Boss]"
NameQuestBoss = "ImpelQuest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
elseif SelectBoss == "Magma Admiral [Lv. 350] [Boss]" then
MsBoss = "Magma Admiral [Lv. 350] [Boss]"
NameQuestBoss = "MagmaQuest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-5317.07666, 12.2721891, 8517.41699, 0.51175487, -2.65508806e-08, -0.859131515, -3.91131572e-08, 1, -5.42026761e-08, 0.859131515, 6.13418294e-08, 0.51175487)
CFrameBoss = CFrame.new(-5530.12646, 22.8769703, 8859.91309, 0.857838571, 2.23414389e-08, 0.513919294, 1.53689133e-08, 1, -6.91265853e-08, -0.513919294, 6.71978384e-08, 0.857838571)
elseif SelectBoss == "Fishman Lord [Lv. 425] [Boss]" then
MsBoss = "Fishman Lord [Lv. 425] [Boss]"
NameQuestBoss = "FishmanQuest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(61123.0859, 18.5066795, 1570.18018, 0.927145958, 1.0624845e-07, 0.374700129, -6.98219367e-08, 1, -1.10790765e-07, -0.374700129, 7.65569368e-08, 0.927145958)
CFrameBoss = CFrame.new(61351.7773, 31.0306778, 1113.31409, 0.999974668, 0, -0.00714713801, 0, 1.00000012, 0, 0.00714714266, 0, 0.999974549)
elseif SelectBoss == "Wysper [Lv. 500] [Boss]" then
MsBoss = "Wysper [Lv. 500] [Boss]"
NameQuestBoss = "SkyExp1Quest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-7862.94629, 5545.52832, -379.833954, 0.462944925, 1.45838088e-08, -0.886386991, 1.0534996e-08, 1, 2.19553424e-08, 0.886386991, -1.95022007e-08, 0.462944925)
CFrameBoss = CFrame.new(-7925.48389, 5550.76074, -636.178345, 0.716468513, -1.22915289e-09, 0.697619379, 3.37381434e-09, 1, -1.70304748e-09, -0.697619379, 3.57381835e-09, 0.716468513)
elseif SelectBoss == "Thunder God [Lv. 575] [Boss]" then
MsBoss = "Thunder God [Lv. 575] [Boss]"
NameQuestBoss = "SkyExp2Quest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-7902.78613, 5635.99902, -1411.98706, -0.0361216255, -1.16895912e-07, 0.999347389, 1.44533963e-09, 1, 1.17024491e-07, -0.999347389, 5.6715117e-09, -0.0361216255)
CFrameBoss = CFrame.new(-7917.53613, 5616.61377, -2277.78564, 0.965189934, 4.80563429e-08, -0.261550069, -6.73089886e-08, 1, -6.46515304e-08, 0.261550069, 8.00056768e-08, 0.965189934)
elseif SelectBoss == "Cyborg [Lv. 675] [Boss]" then
MsBoss = "Cyborg [Lv. 675] [Boss]"
NameQuestBoss = "FountainQuest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(5253.54834, 38.5361786, 4050.45166, -0.0112687312, -9.93677887e-08, -0.999936521, 2.55291371e-10, 1, -9.93769547e-08, 0.999936521, -1.37512213e-09, -0.0112687312)
CFrameBoss = CFrame.new(6041.82813, 52.7112198, 3907.45142, -0.563162148, 1.73805248e-09, -0.826346457, -5.94632716e-08, 1, 4.26280238e-08, 0.826346457, 7.31437524e-08, -0.563162148)
-- New World
elseif SelectBoss == "Diamond [Lv. 750] [Boss]" then
MsBoss = "Diamond [Lv. 750] [Boss]"
NameQuestBoss = "Area1Quest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601, -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
CFrameBoss = CFrame.new(-1736.26587, 198.627731, -236.412857, -0.997808516, 0, -0.0661673471, 0, 1, 0, 0.0661673471, 0, -0.997808516)
elseif SelectBoss == "Jeremy [Lv. 850] [Boss]" then
MsBoss = "Jeremy [Lv. 850] [Boss]"
NameQuestBoss = "Area2Quest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
CFrameBoss = CFrame.new(2203.76953, 448.966034, 752.731079, -0.0217453763, 0, -0.999763548, 0, 1, 0, 0.999763548, 0, -0.0217453763)
elseif SelectBoss == "Fajita [Lv. 925] [Boss]" then
MsBoss = "Fajita [Lv. 925] [Boss]"
NameQuestBoss = "MarineQuest3"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301, 5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
CFrameBoss = CFrame.new(-2297.40332, 115.449463, -3946.53833, 0.961227536, -1.46645796e-09, -0.275756449, -2.3212845e-09, 1, -1.34094433e-08, 0.275756449, 1.35296352e-08, 0.961227536)
elseif SelectBoss == "Don Swan [Lv. 1000] [Boss]" then
MsBoss = "Don Swan [Lv. 1000] [Boss]"
CFrameBoss = CFrame.new(2288.802, 15.1870775, 863.034607, 0.99974072, -8.41247214e-08, -0.0227668174, 8.4774733e-08, 1, 2.75850098e-08, 0.0227668174, -2.95079072e-08, 0.99974072)
elseif SelectBoss == "Smoke Admiral [Lv. 1150] [Boss]" then
MsBoss = "Smoke Admiral [Lv. 1150] [Boss]"
NameQuestBoss = "IceSideQuest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-6059.96191, 15.9868021, -4904.7373, -0.444992423, -3.0874483e-09, 0.895534337, -3.64098796e-08, 1, -1.4644522e-08, -0.895534337, -3.91229982e-08, -0.444992423)
CFrameBoss = CFrame.new(-5115.72754, 23.7664986, -5338.2207, 0.251453817, 1.48345061e-08, -0.967869282, 4.02796978e-08, 1, 2.57916977e-08, 0.967869282, -4.54708946e-08, 0.251453817)
elseif SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" then
MsBoss = "Cursed Captain [Lv. 1325] [Raid Boss]"
CFrameBoss = CFrame.new(916.928589, 181.092773, 33422, -0.999505103, 9.26310495e-09, 0.0314563364, 8.42916226e-09, 1, -2.6643713e-08, -0.0314563364, -2.63653774e-08, -0.999505103)
elseif SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
MsBoss = "Darkbeard [Lv. 1000] [Raid Boss]"
CFrameBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777, -0.976951957, 4.97356325e-08, 0.213458836, 4.57335361e-08, 1, -2.36868622e-08, -0.213458836, -1.33787044e-08, -0.976951957)
elseif SelectBoss == "Order [Lv. 1250] [Raid Boss]" then
MsBoss = "Order [Lv. 1250] [Raid Boss]"
CFrameBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584, -0.380726993, 7.41463495e-08, 0.924687505, 5.85604774e-08, 1, -5.60738549e-08, -0.924687505, 3.28013137e-08, -0.380726993)
elseif SelectBoss == "Awakened Ice Admiral [Lv. 1400] [Boss]" then
MsBoss = "Awakened Ice Admiral [Lv. 1400] [Boss]"
NameQuestBoss = "FrostQuest"
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(5669.33203, 28.2118053, -6481.55908, 0.921275556, -1.25320829e-08, 0.388910472, 4.72230788e-08, 1, -7.96414241e-08, -0.388910472, 9.17372489e-08, 0.921275556)
CFrameBoss = CFrame.new(6407.33936, 340.223785, -6892.521, 0.49051559, -5.25310213e-08, -0.871432424, -2.76146022e-08, 1, -7.58250565e-08, 0.871432424, 6.12576301e-08, 0.49051559)
elseif SelectBoss == "Tide Keeper [Lv. 1475] [Boss]" then
MsBoss = "Tide Keeper [Lv. 1475] [Boss]"
NameQuestBoss = "ForgottenQuest"             
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-3053.89648, 236.881363, -10148.2324, -0.985987961, -3.58504737e-09, 0.16681771, -3.07832915e-09, 1, 3.29612559e-09, -0.16681771, 2.73641976e-09, -0.985987961)
CFrameBoss = CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -1.3857326e-08, 0.885206044, 4.0332897e-09, 1, 1.35347511e-08, -0.885206044, -2.72606271e-09, 0.465199202)
-- Thire World
elseif SelectBoss == "Stone [Lv. 1550] [Boss]" then
MsBoss = "Stone [Lv. 1550] [Boss]"
NameQuestBoss = "PiratePortQuest"             
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-290, 44, 5577)
CFrameBoss = CFrame.new(-1085, 40, 6779)
elseif SelectBoss == "Island Empress [Lv. 1675] [Boss]" then
MsBoss = "Island Empress [Lv. 1675] [Boss]"
NameQuestBoss = "AmazonQuest2"             
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(5443, 602, 752)
CFrameBoss = CFrame.new(5659, 602, 244)
elseif SelectBoss == "Kilo Admiral [Lv. 1750] [Boss]" then
MsBoss = "Kilo Admiral [Lv. 1750] [Boss]"
NameQuestBoss = "MarineTreeIsland"             
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(2178, 29, -6737)
CFrameBoss =CFrame.new(2846, 433, -7100)
elseif SelectBoss == "Captain Elephant [Lv. 1875] [Boss]" then
MsBoss = "Captain Elephant [Lv. 1875] [Boss]"
NameQuestBoss = "DeepForestIsland"             
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-13232, 333, -7631)
CFrameBoss = CFrame.new(-13221, 325, -8405)
elseif SelectBoss == "Beautiful Pirate [Lv. 1950] [Boss]" then
MsBoss = "Beautiful Pirate [Lv. 1950] [Boss]"
NameQuestBoss = "DeepForestIsland2"             
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-12686, 391, -9902)
CFrameBoss = CFrame.new(5182, 23, -20)
elseif SelectBoss == "Cake Queen [Lv. 2175] [Boss]" then
MsBoss = "Cake Queen [Lv. 2175] [Boss]"
NameQuestBoss = "IceCreamIslandQuest"             
LevelQuestBoss = 3
CFrameQuestBoss = CFrame.new(-716, 382, -11010)
CFrameBoss = CFrame.new(-821, 66, -10965)
elseif SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" then
MsBoss = "rip_indra True Form [Lv. 5000] [Raid Boss]"
CFrameBoss = CFrame.new(-5359, 424, -2735)
elseif SelectBoss == "Longma [Lv. 2000] [Boss]" then
MsBoss = "Longma [Lv. 2000] [Boss]"
CFrameBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
elseif SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" then
MsBoss = "Soul Reaper [Lv. 2100] [Raid Boss]"
CFrameBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
end
end
local Boss = {}
for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
if string.find(v.Name, "Boss") then
if v.Name == "Ice Admiral [Lv. 700] [Boss]" then
else
table.insert(Boss, v.Name)
end
end
end
for i, v in pairs(game.workspace.Enemies:GetChildren()) do
if string.find(v.Name, "Boss") then
if v.Name == "Ice Admiral [Lv. 700] [Boss]" then
else
table.insert(Boss, v.Name)
end
end
end
SelectBoss = ""
local BossName = AutoFarmMiscTab:Dropdown("Select Boss",Boss,0,function(Value)
SelectBoss = Value
Don = false
end)
AutoFarmMiscTab:Button("Refresh Boss",function()
local Boss = {}
for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
if string.find(v.Name, "Boss") then
if v.Name == "Ice Admiral [Lv. 700] [Boss]" then
else
table.insert(Boss, v.Name)
end
end
end
for i, v in pairs(game.workspace.Enemies:GetChildren()) do
if string.find(v.Name, "Boss") then
if v.Name == "Ice Admiral [Lv. 700] [Boss]" then
else
table.insert(Boss, v.Name)
end
end
end
BossName:Refresh(Boss,0)
end)

function AutoFramBoss()
CheckQuestBoss()
if MsBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" or MsBoss == "Order [Lv. 1250] [Raid Boss]" or MsBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" or MsBoss == "Longma [Lv. 2000] [Boss]" or MsBoss == "The Saw [Lv. 100] [Boss]" or MsBoss == "Greybeard [Lv. 750] [Raid Boss]" or MsBoss == "Don Swan [Lv. 1000] [Boss]" or MsBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" or MsBoss == "Saber Expert [Lv. 200] [Boss]" or MsBoss == "Mob Leader [Lv. 120] [Boss]" or MsBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if FramBoss and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == MsBoss then
repeat wait() 
if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 30)
Click()
end
until not FramBoss or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
end
else
Usefastattack = false
Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
if (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
wait(1)
end 
end
else
if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
Usefastattack = false
CheckQuestBoss()
Questtween = toTarget(CFrameQuestBoss.Position,CFrameQuestBoss)
if (CFrameQuestBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuestBoss
wait(1.1)
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuestBoss, LevelQuestBoss)
end 
elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
if game:GetService("Workspace").Enemies:FindFirstChild(MsBoss) then print("Find")
for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if FramBoss and v.Name == MsBoss and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()
if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
EquipWeapon(SelectToolWeapon)
if Farmtween then
Farmtween:Stop()
end
if Modstween then
Modstween:Stop()
end
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end
until not FramBoss or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
Usefastattack = false
end
end
else
Usefastattack = false
Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
if ThreeWorld and game:GetService("Players").LocalPlayer.Data.Level.Value >= 1925 and MsBoss == "Beautiful Pirate [Lv. 1950] [Boss]" and (CFrameBoss.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude < 500 then
if Questtween then
Questtween:Stop()
end
local TouchInterest = game:GetService("Workspace").Map.Turtle.Entrance.Door.BossDoor.Hitbox
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TouchInterest.CFrame
UseTween = false
wait(.1)
elseif (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
end 
end
end
end
end
AutoFarmMiscTab:Toggle("Auto Farm Boss",false,function(Value)
local args = {
[1] = "AbandonQuest"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
FramBoss = Value
end)
spawn(function()
while wait() do
if FramBoss then
AutoFramBoss()
end
end
end)

AutoFarmMiscTab:Line()

local BossNameHop = AutoFarmMiscTab:Dropdown("Select Boss To Farm Hop",Boss,0,function(Value)
_G.SelectBossHop = Value
end)

AutoFarmMiscTab:Button("Refresh Boss",function()
local Boss = {}
for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
if string.find(v.Name, "Boss") then
if v.Name == "Ice Admiral [Lv. 700] [Boss]" then
else
table.insert(Boss, v.Name)
end
end
end
for i, v in pairs(game.workspace.Enemies:GetChildren()) do
if string.find(v.Name, "Boss") then
if v.Name == "Ice Admiral [Lv. 700] [Boss]" then
else
table.insert(Boss, v.Name)
end
end
end
BossNameHop:Refresh(Boss,0)
end)

AutoFarmMiscTab:Toggle("Auto Farm Select Boss Hop",getgenv().Setting["Auto Farm Select Boss Hop"],function(Value)
FramBossSelectHop = Value
end)

spawn(function()
while wait() do 
pcall(function()
if FramBossSelectHop then
if game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBossHop) then
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if v.Name == _G.SelectBossHop then
if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()
if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
end
Click()
EquipWeapon(SelectToolWeapon)
v.HumanoidRootPart.Transparency = 1
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
MytoTarget(v.HumanoidRootPart.CFrame * CFrame.new(1,20,1))
end
until not FramBossSelectHop or not v.Parent or v.Humanoid.Health == 0
end
end	
end
elseif game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBossHop) then
MytoTarget(game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBossHop).HumanoidRootPart.CFrame * CFrame.new(1,60,1))
elseif game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBossHop) == nil and game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBossHop) == nil then
if syn then
syn.queue_on_teleport([[
_G.SelectBossHop = "]] .. _G.SelectBossHop .. [["
]])
else
queue_on_teleport([[
_G.SelectBossHop = "]] .. _G.SelectBossHop .. [["
]])
end
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
--[[
local File = pcall(function()
AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
table.insert(AllIDs, actualHour)
writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
]]
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(v.maxPlayers) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
local delFile = pcall(function()
-- delfile("NotSameServers.json")
AllIDs = {}
table.insert(AllIDs, actualHour)
end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(4)
end
end
end
end

function Teleport()
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end

Teleport()
wait(4)
end
end
end)
end
end)

AutoFarmMiscTab:Line()

KillBossuseGet = false
function AutoFramAllBoss()
for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
if not KillBossuseGet then
if v.Name == "Diamond [Lv. 750] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 750 then
SelectBoss = "Diamond [Lv. 750] [Boss]"
elseif v.Name == "Jeremy [Lv. 850] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 850 then
SelectBoss = "Jeremy [Lv. 850] [Boss]"
elseif v.Name == "Fajita [Lv. 925] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 925  then
SelectBoss = "Fajita [Lv. 925] [Boss]"
elseif v.Name == "Don Swan [Lv. 1000] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1000 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1") == 0 then
SelectBoss = "Don Swan [Lv. 1000] [Boss]" 
elseif v.Name == "Smoke Admiral [Lv. 1150] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1150 then
SelectBoss = "Smoke Admiral [Lv. 1150] [Boss]"
elseif v.Name == "Cursed Captain [Lv. 1325] [Raid Boss]" and game.Players.localPlayer.Data.Level.Value >= 1325 then
SelectBoss = "Cursed Captain [Lv. 1325] [Raid Boss]"
elseif v.Name == "Awakened Ice Admiral [Lv. 1400] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1400  then
SelectBoss = "Awakened Ice Admiral [Lv. 1400] [Boss]"
elseif v.Name == "Tide Keeper [Lv. 1475] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1475  then
SelectBoss = "Tide Keeper [Lv. 1475] [Boss]"
-- Old World
elseif v.Name == "The Gorilla King [Lv. 25] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 20  then
SelectBoss = "The Gorilla King [Lv. 25] [Boss]"
elseif v.Name == "Bobby [Lv. 55] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 55  then
SelectBoss = "Bobby [Lv. 55] [Boss]" 
elseif v.Name == "Yeti [Lv. 110] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 105  then
SelectBoss = "Yeti [Lv. 110] [Boss]"
elseif v.Name == "Mob Leader [Lv. 120] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 120 then
SelectBoss = "Mob Leader [Lv. 120] [Boss]"
elseif v.Name == "Vice Admiral [Lv. 130] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 130 then
SelectBoss = "Vice Admiral [Lv. 130] [Boss]"
elseif v.Name == "Warden [Lv. 175] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 175 then
SelectBoss = "Warden [Lv. 175] [Boss]"
elseif v.Name == "Saber Expert [Lv. 200] [Boss]" and game.Workspace.Map.Jungle.Final.Part.Transparency == 1 then
SelectBoss = "Saber Expert [Lv. 200] [Boss]"
elseif v.Name == "Chief Warden [Lv. 200] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 200 then
SelectBoss = "Chief Warden [Lv. 200] [Boss]"
elseif v.Name == "Swan [Lv. 225] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 250 then
SelectBoss = "Swan [Lv. 225] [Boss]"
elseif v.Name == "Magma Admiral [Lv. 350] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 350  then
SelectBoss = "Magma Admiral [Lv. 350] [Boss]"
elseif v.Name == "Fishman Lord [Lv. 425] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 425  then
SelectBoss = "Fishman Lord [Lv. 425] [Boss]"
elseif v.Name == "Wysper [Lv. 500] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 500 then
SelectBoss = "Wysper [Lv. 500] [Boss]"
elseif v.Name == "Thunder God [Lv. 575] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 575 then
SelectBoss = "Thunder God [Lv. 575] [Boss]"
elseif v.Name == "Cyborg [Lv. 675] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 675 then
SelectBoss = "Cyborg [Lv. 675] [Boss]"
-- Thire World
elseif v.Name == "Stone [Lv. 1550] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1550 then
SelectBoss = "Stone [Lv. 1550] [Boss]"
elseif v.Name == "Island Empress [Lv. 1675] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1675 then
SelectBoss = "Island Empress [Lv. 1675] [Boss]"
elseif v.Name == "Kilo Admiral [Lv. 1750] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1750 then
SelectBoss = "Kilo Admiral [Lv. 1750] [Boss]"
elseif v.Name == "Captain Elephant [Lv. 1875] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1875 then
SelectBoss = "Captain Elephant [Lv. 1875] [Boss]"
elseif v.Name == "Beautiful Pirate [Lv. 1950] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1950 then
SelectBoss = "Beautiful Pirate [Lv. 1950] [Boss]"
end 
end 
end
CheckQuestBoss()
if SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" or SelectBoss == "Order [Lv. 1250] [Raid Boss]" or SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" or SelectBoss == "Longma [Lv. 2000] [Boss]" or SelectBoss == "The Saw [Lv. 100] [Boss]" or SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" or SelectBoss == "Don Swan [Lv. 1000] [Boss]" or SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" or SelectBoss == "Saber Expert [Lv. 200] [Boss]" or SelectBoss == "Mob Leader [Lv. 120] [Boss]" or SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if KillAllBoss and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == MsBoss then
repeat wait() 
KillBossuseGet = true
if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 30)
Click()
end
until not KillAllBoss or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
KillBossuseGet = false
end
end
else
KillBossuseGet = true
Usefastattack = false
Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
if (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
wait(1)
end 
end
else
if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
Usefastattack = false
KillBossuseGet = true
CheckQuestBoss()
Questtween = toTarget(CFrameQuestBoss.Position,CFrameQuestBoss)
if (CFrameQuestBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuestBoss
wait(1.1)
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuestBoss, LevelQuestBoss)
end 
elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
if game:GetService("Workspace").Enemies:FindFirstChild(MsBoss) then print("Find")
for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if KillAllBoss and v.Name == MsBoss and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()
if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
EquipWeapon(SelectToolWeapon)
if Farmtween then
Farmtween:Stop()
end
if Modstween then
Modstween:Stop()
end
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end
until not KillAllBoss or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
Usefastattack = false
KillBossuseGet = false
end
end
else
KillBossuseGet = true
Usefastattack = false
Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
if ThreeWorld and game:GetService("Players").LocalPlayer.Data.Level.Value >= 1925 and MsBoss == "Beautiful Pirate [Lv. 1950] [Boss]" and (CFrameBoss.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 20000 then
if Questtween then
Questtween:Stop()
end
local TouchInterest = game:GetService("Workspace").Map.Turtle.Entrance.Door.BossDoor.Hitbox
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TouchInterest.CFrame
wait(.1)
UseTween = false
elseif (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
end 
end
end
end
end
AutoFarmMiscTab:Toggle("Auto Farm All Boss",false,function(Value)
KillAllBoss = Value
MsBoss = ""
KillBossuseGet = false
end)
spawn(function()
while wait() do
if KillAllBoss then
AutoFramAllBoss()
end
end
end)

AutoFarmMiscTab:Line()
-- Auto Farm Near Mods
AutoFarmMiscTab:Label("Auto Farm Mob Aura",true)
AutoFarmMiscTab:Toggle("Auto Farm Mob Aura",false,function(v)
AutoMobAura = v 
if not AutoMobAura then
Usefastattack = false
end
end)
do -- Init
task = task or getrenv().task;
fastSpawn,fastWait,delay = task.spawn,task.wait,task.delay
end
DistanceMobAura = 100
spawn(function()
while wait() do
if AutoMobAura then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoMobAura and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= DistanceMobAura then
repeat wait()
EquipWeapon(SelectToolWeapon)
PosMonAura = v.HumanoidRootPart.CFrame
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
MagnetMobAura = true
if delay then
delay(1,function()
MagnetMobAura = true
end)
end 
until not AutoMobAura or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
end
end
end
end)
spawn(function()
while true do game:GetService("RunService").RenderStepped:Wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
if MagnetMobAura and AutoMobAura then
for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if MagnetMobAura and AutoMobAura and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
v.HumanoidRootPart.CFrame = PosMon
v.Humanoid.JumpPower = 0
v.Humanoid.WalkSpeed = 0
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.Size = Vector3.new(80,80,80)
if v.Humanoid:FindFirstChild("Animator") then
v.Humanoid.Animator:Destroy()
end
sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
v.Humanoid:ChangeState(11)
end
end
end
end
end
end)
AutoFarmMiscTab:Slider("Distance",1,400,100,DistanceMobAura,function(A)
DistanceMobAura = A
end)
AutoFarmMiscTab:Line()
-- Auto Farm Observation
AutoFarmMiscTab:Label("Auto Farm Observation",true)
local ObservationVirtualUser = game:GetService('VirtualUser')
AutoFarmMiscTab:Toggle("Auto Farm Observation",false ,function(a)
Observation = a
if Observation and not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
ObservationVirtualUser:CaptureController()
ObservationVirtualUser:SetKeyDown('0x65')
wait(2)
ObservationVirtualUser:SetKeyUp('0x65')
end
end)
spawn(function()
while wait() do
if Observation then
if ThreeWorld then
if game.Workspace.Enemies:FindFirstChild("Musketeer Pirate [Lv. 1925]") then
if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
repeat wait()
if (game.Workspace.Enemies:FindFirstChild("Musketeer Pirate [Lv. 1925]").HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game.Workspace.Enemies:FindFirstChild("Musketeer Pirate [Lv. 1925]").HumanoidRootPart.Position,game.Workspace.Enemies:FindFirstChild("Musketeer Pirate [Lv. 1925]").HumanoidRootPart.CFrame)
elseif (game.Workspace.Enemies:FindFirstChild("Musketeer Pirate [Lv. 1925]").HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Enemies:FindFirstChild("Musketeer Pirate [Lv. 1925]").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
end
until Observation == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
else
spawn(function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(2) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
    Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
    local delFile = pcall(function()
        -- delfile("NotSameServers.json")
        AllIDs = {}
        table.insert(AllIDs, actualHour)
    end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(4)
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
end)
repeat wait()
-- game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Enemies:FindFirstChild("Musketeer Pirate [Lv. 1925]").HumanoidRootPart.CFrame * CFrame.new(10,15,0)
until Observation == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
end
else
Modstween = toTarget(CFrame.new(-13330, 449, -9919).Position, CFrame.new(-13330, 449, -9919))
if game.Workspace.Enemies:FindFirstChild("Ship Engineer [Lv. 1275]") and (CFrame.new(-13330, 449, -9919).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Modstween then
Modstween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13330, 449, -9919)
end 
end
elseif NewWorld then
if game.Workspace.Enemies:FindFirstChild("Ship Engineer [Lv. 1275]") then
if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
repeat wait()
if (game.Workspace.Enemies:FindFirstChild("Ship Engineer [Lv. 1275]").HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game.Workspace.Enemies:FindFirstChild("Ship Engineer [Lv. 1275]").HumanoidRootPart.Position,game.Workspace.Enemies:FindFirstChild("Musketeer Pirate [Lv. 1925]").HumanoidRootPart.CFrame)
elseif (game.Workspace.Enemies:FindFirstChild("Ship Engineer [Lv. 1275]").HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Enemies:FindFirstChild("Ship Engineer [Lv. 1275]").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
end
until Observation == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
else
spawn(function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(2) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
    Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
    local delFile = pcall(function()
        -- delfile("NotSameServers.json")
        AllIDs = {}
        table.insert(AllIDs, actualHour)
    end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(4)
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
end)
repeat wait()
-- game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Enemies:FindFirstChild("Ship Engineer [Lv. 1275]").HumanoidRootPart.CFrame * CFrame.new(10,15,0)
until Observation == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
end
else
Modstween = toTarget(CFrame.new(918.558777, 40.0827065, 32766.498).Position, CFrame.new(918.558777, 40.0827065, 32766.498))
if game.Workspace.Enemies:FindFirstChild("Ship Engineer [Lv. 1275]") and (CFrame.new(918.558777, 40.0827065, 32766.498).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Modstween then
Modstween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918.558777, 40.0827065, 32766.498)
end 
end
elseif OldWorld then
if game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]") then
if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
repeat wait()
if (game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.Position,game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame)
elseif (game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
end
until Observation == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
else
spawn(function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(2) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
    Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
    local delFile = pcall(function()
        -- delfile("NotSameServers.json")
        AllIDs = {}
        table.insert(AllIDs, actualHour)
    end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait()
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
end)
repeat wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame * CFrame.new(10,15,0)
until Observation == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
end
else
Modstween = toTarget(CFrame.new(5533.29785, 88.1079102, 4852.3916).Position, CFrame.new(5533.29785, 88.1079102, 4852.3916))
if game.Workspace.Enemies:FindFirstChild("Ship Engineer [Lv. 1275]") and (CFrame.new(5533.29785, 88.1079102, 4852.3916).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Modstween then
Modstween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5533.29785, 88.1079102, 4852.3916)
end 
end
end
end
end
end)
spawn(function()
while wait() do wait(40)
pcall(function()
if Observation and not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
ObservationVirtualUser:CaptureController()
ObservationVirtualUser:SetKeyDown('0x65')
wait(2)
ObservationVirtualUser:SetKeyUp('0x65')
end
end)
end
end)
AutoFarmMiscTab:Line()
-- Auto Farm Observation
AutoFarmMiscTab:Label("Auto Farm Chest",true)

AutoFarmMiscTab:Toggle("Auto Farm Chest",false,function(v)
AutoFarmChest = v
end)
_G.MagnitudeAdd = 0
spawn(function()
while wait() do 
pcall(function()
if AutoFarmChest then
for i,v in pairs(game:GetService("Workspace"):GetChildren()) do 
if v.Name:find("Chest") then
if game:GetService("Workspace"):FindFirstChild(v.Name) then
if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5000+_G.MagnitudeAdd then
repeat wait()
if game:GetService("Workspace"):FindFirstChild(v.Name) then
SlowtoTarget(v.CFrame)
end
until AutoFarmChest == false or not v.Parent
_G.MagnitudeAdd = _G.MagnitudeAdd+1500
end
end
end
end
end
end)
end
end)

AutoFarmMiscTab:Line()
AutoFarmMiscTab:Label("Sea 1 (Old World)",true)
AutoFarmMiscTab:Toggle("Auto Open Saber Room",_G.AutoOpenSaberRoom,function(vu)
if not OldWorld then
Flux:Notification("Use In Old World","Okey")
elseif SelectToolWeapon == "" and vu then
Flux:Notification("Select Weapon First in Tab Auto Farm","Okey")
elseif game.Workspace.Map.Jungle.Final.Part.Transparency == 1 and vu then
Flux:Notification("Saber Room Succeed","Okey")
else
AutoSaber = vu
end  
end)
spawn(function()
while wait() do
if AutoSaber then
if game.Players.localPlayer.Data.Level.Value < 200 then
else
if game.Workspace.Map.Jungle.Final.Part.CanCollide == false then
if game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if v.Name == "Saber Expert [Lv. 200] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
Click()
end
until not AutoSaber or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
end
else
Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
end
end
elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") and game.Players.localPlayer.Data.Level.Value >= 200 then
EquipWeapon("Relic")
wait(0.5)
Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
end
else
if Workspace.Map.Jungle.QuestPlates.Door.CanCollide == false then
if game.Workspace.Map.Desert.Burn.Part.CanCollide == false then
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") == 0 then
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
if game.Workspace.Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoSaber and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Mob Leader [Lv. 120] [Boss]" then
repeat
    pcall(function() wait() 
        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
            Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
        elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
            if Farmtween then
                Farmtween:Stop()
            end
            EquipWeapon(SelectToolWeapon)
            Usefastattack = true
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                local args = {
                    [1] = "Buso"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
            Click()
        end
    end)
until not AutoSaber or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
end
else
Questtween = toTarget(CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position,CFrame.new(-2848.59399, 7.4272871, 5342.44043))
if (CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.928248107)
end
end
elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") then
EquipWeapon("Relic")
wait(0.5)
Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055)
end
else
Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624).Position,CFrame.new(-910.979736, 13.7520342, 4078.14624))
if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624, 0.00685182028, -1.53155766e-09, -0.999976516, 9.15205245e-09, 1, -1.46888401e-09, 0.999976516, -9.14177267e-09, 0.00685182028)
wait(.5)
local args = {
[1] = "ProQuestProgress",
[2] = "RichSon"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end
else
Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624).Position,CFrame.new(-910.979736, 13.7520342, 4078.14624))
if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624)
local args = {
[1] = "ProQuestProgress",
[2] = "RichSon"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end
else
if game.Players.LocalPlayer.Backpack:FindFirstChild("Cup") or game.Players.LocalPlayer.Character:FindFirstChild("Cup") then
EquipWeapon("Cup")
if game.Players.LocalPlayer.Character.Cup.Handle:FindFirstChild("TouchInterest") then
Questtween = toTarget(CFrame.new(1397.229, 37.3480148, -1320.85217).Position,CFrame.new(1397.229, 37.3480148, -1320.85217))
if (CFrame.new(1397.229, 37.3480148, -1320.85217).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1397.229, 37.3480148, -1320.85217, -0.11285457, 2.01368788e-08, 0.993611455, 1.91641178e-07, 1, 1.50028845e-09, -0.993611455, 1.90586206e-07, -0.11285457)
end
else
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1458.54285, 88.2521744, -1390.34912, -0.00596274994, 1.13679788e-09, -0.999982238, 7.28181793e-10, 1, 1.132476e-09, 0.999982238, -7.21416205e-10, -0.00596274994)
wait(0.5)
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
local args = {
[1] = "ProQuestProgress",
[2] = "SickMan"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end
else
Questtween = toTarget(game.Workspace.Map.Desert.Cup.Position,game.Workspace.Map.Desert.Cup.CFrame)
if (game.Workspace.Map.Desert.Cup.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Desert.Cup.CFrame
end
-- firetouchinterest(game.Workspace.Map.Desert.Cup.TouchInterest,game.Players.LocalPlayer.Character.Head, 1)
end
end
else
if game.Players.LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
EquipWeapon("Torch")
Questtween = toTarget(CFrame.new(1114.87708, 4.9214654, 4349.8501).Position,CFrame.new(1114.87708, 4.9214654, 4349.8501))
if (CFrame.new(1114.87708, 4.9214654, 4349.8501).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1114.87708, 4.9214654, 4349.8501, -0.612586915, -9.68697833e-08, 0.790403247, -1.2634203e-07, 1, 2.4638446e-08, -0.790403247, -8.47679615e-08, -0.612586915)
end
else
Questtween = toTarget(CFrame.new(-1610.00757, 11.5049858, 164.001587).Position,CFrame.new(-1610.00757, 11.5049858, 164.001587))
if (CFrame.new(-1610.00757, 11.5049858, 164.001587).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408)
end
end
end
else
for i,v in pairs(Workspace.Map.Jungle.QuestPlates:GetChildren()) do
if v:IsA("Model") then wait()
if v.Button.BrickColor ~= BrickColor.new("Camo") then
repeat wait()
Questtween = toTarget(v.Button.Position,v.Button.CFrame)
if (v.Button.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Button.CFrame
end
until not AutoSaber or v.Button.BrickColor == BrickColor.new("Camo")
end
end
end    
end
end
end 
end
end
end)
-- Auto Pole V.1
AutoFarmMiscTab:Label("Auto Pole V.1",true)
AutoFarmMiscTab:Toggle("Auto Pole V.1",_G.AutoPole,function(v)
if OldWorld then
if SelectToolWeapon == "" and v then
Flux:Notification("Selected Weapon First","Okey")
else
AutoPole = v
end
else
Flux:Notification("Use In Old World","Okey")    
end 
end)
spawn(function()
while wait() do
if AutoPole and game.ReplicatedStorage:FindFirstChild("Thunder God [Lv. 575] [Boss]") or game.Workspace.Enemies:FindFirstChild("Thunder God [Lv. 575] [Boss]") then
if game.Workspace.Enemies:FindFirstChild("Thunder God [Lv. 575] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoPole and v.Name == "Thunder God [Lv. 575] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()  
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
Click()
end 
until not AutoPole or v.Humanoid.Health <= 0 or not v.Parent
Usefastattack = false
end
end
else
Questtween = toTarget(CFrame.new(-7900.66406, 5606.90918, -2267.46436).Position,CFrame.new(-7900.66406, 5606.90918, -2267.46436))
if (CFrame.new(-7900.66406, 5606.90918, -2267.46436).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7900.66406, 5606.90918, -2267.46436)
end
end
end
end
end)
AutoFarmMiscTab:Toggle("Auto Pole V.1 HOP",_G.AutoPoleHop,function(v)
if OldWorld then
AutoPoleHOP = v
else
Flux:Notification("Use In Old World","Okey")    
end 
end)
spawn(function()
while wait() do
if AutoPoleHOP then 
if game.ReplicatedStorage:FindFirstChild("Thunder God [Lv. 575] [Boss]") or game.Workspace.Enemies:FindFirstChild("Thunder God [Lv. 575] [Boss]") then
if game.Workspace.Enemies:FindFirstChild("Thunder God [Lv. 575] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoPoleHOP and v.Name == "Thunder God [Lv. 575] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()  
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
Click()
end 
until not AutoPoleHOP or v.Humanoid.Health <= 0 or not v.Parent
Usefastattack = false
end
end
else
Questtween = toTarget(CFrame.new(-7900.66406, 5606.90918, -2267.46436).Position,CFrame.new(-7900.66406, 5606.90918, -2267.46436))
if (CFrame.new(-7900.66406, 5606.90918, -2267.46436).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7900.66406, 5606.90918, -2267.46436)
end
end
else
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(v.maxPlayers) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
local delFile = pcall(function()
-- delfile("NotSameServers.json")
AllIDs = {}
table.insert(AllIDs, actualHour)
end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(.1)
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
end
end
end
end)
AutoFarmMiscTab:Line()
AutoFarmMiscTab:Label("Sea 2 ( New World )",true)
-- Auto Quest Bartilo
AutoFarmMiscTab:Label("Auto Quest Bartilo",true)
WeaponBartilo = ""
AutoFarmMiscTab:Toggle("Auto Quest Bartilo",_G.AutoQuestBartilo,function(v)
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 and v == true then
Flux:Notification("Quest Bartilo Successfully")
else
AutoQuestBartilo = v
end
end)
spawn(function()
while wait() do
if AutoQuestBartilo and game.Players.LocalPlayer.Data.Level.Value >= 850 then
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then 
if game.Workspace.Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if v.Name == "Swan Pirate [Lv. 775]" then
pcall(function()
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
    [1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not v.Parent or v.Humanoid.Health <= 0 or AutoQuestBartilo == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
AutoBartiloBring = false
Usefastattack = false
end)
end
end
else
Questtween = toTarget(CFrame.new(1057.92761, 137.614319, 1242.08069).Position,CFrame.new(1057.92761, 137.614319, 1242.08069))
if (CFrame.new(1057.92761, 137.614319, 1242.08069).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1057.92761, 137.614319, 1242.08069)
end
end
else
Bartilotween = toTarget(CFrame.new(-456.28952, 73.0200958, 299.895966).Position,CFrame.new(-456.28952, 73.0200958, 299.895966))
if ( CFrame.new(-456.28952, 73.0200958, 299.895966).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Bartilotween then
Bartilotween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =  CFrame.new(-456.28952, 73.0200958, 299.895966)
local args = {
[1] = "StartQuest",
[2] = "BartiloQuest",
[3] = 1
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end 
elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
if game.Workspace.Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
Ms = "Jeremy [Lv. 850] [Boss]"
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if v.Name == Ms then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not v.Parent or v.Humanoid.Health <= 0 or AutoQuestBartilo == false
Usefastattack = false
end
end
else
Bartilotween = toTarget(CFrame.new(2099.88159, 448.931, 648.997375).Position,CFrame.new(2099.88159, 448.931, 648.997375))
if (CFrame.new(2099.88159, 448.931, 648.997375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Bartilotween then
Bartilotween:Stop()
end
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2099.88159, 448.931, 648.997375)
end
end
elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
if (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Bartilotween = toTarget(CFrame.new(-1836, 11, 1714).Position,CFrame.new(-1836, 11, 1714))
elseif (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Bartilotween then
Bartilotween:Stop()
end
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1836, 11, 1714)
wait(.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1850.49329, 13.1789551, 1750.89685)
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1869.54224, 15.987854, 1681.00659)
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1800.0979, 16.4978027, 1684.52368)
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1819.26343, 14.795166, 1717.90625)
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1813.51843, 14.8604736, 1724.79541)
end
end
end 
end
end)
AutoFarmMiscTab:Label("Auto Quest Flower",true)
AutoFarmMiscTab:Toggle("Auto Quest Flower",_G.AutoQuestFlower,function(Bool)
if game.Players.LocalPlayer.Data.Level.Value < 850 and Bool then
Flux:Notification("Need Level More 850")
else
if SelectToolWeapon == "" and Bool then
Flux:Notification("Selected Weapon First")
elseif  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") ~= 3 and Bool == true then
Flux:Notification("Quest Bartilo Not Successfully")
elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","3") == -2 and Bool == true then
Flux:Notification("Evo Race V.2 Successfully")
else
AutoEvoRace2 = Bool
end
end
end)
spawn(function()
while wait() do
if AutoEvoRace2 then
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","3") ~= -2 then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") and game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") and game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") then
if (CFrame.new(-2777.6001, 72.9661407, -3571.42285).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(CFrame.new(-2777.6001, 72.9661407, -3571.42285).Position,CFrame.new(-2777.6001, 72.9661407, -3571.42285))
elseif (CFrame.new(-2777.6001, 72.9661407, -3571.42285).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2777.6001, 72.9661407, -3571.42285)
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","3")
end 
else
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "2")
if not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") then
if workspace.Flower1.Transparency ~= 1 then
if (workspace.Flower1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(workspace.Flower1.Position,workspace.Flower1.CFrame)
elseif (workspace.Flower1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Flower1.CFrame
end 
end
end 
if not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") then
if workspace.Flower2.Transparency ~= 1 then
if (workspace.Flower2.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(workspace.Flower2.Position,workspace.Flower2.CFrame)
elseif (workspace.Flower2.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Flower2.CFrame
end 
end
end
if not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") then
if game.Workspace.Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if v.Name == "Swan Pirate [Lv. 775]" and v:FindFirstChild("Humanoid") and v.Humanoid.Health >= 0 then
pcall(function()
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
    Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
    local args = {
        [1] = "Buso"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
Click()
end 
until not v.Parent or v.Humanoid.Health <= 0 or AutoEvoRace2 == false or LocalPlayer.Backpack:FindFirstChild("Flower 3")
AutoEvoBring = false
Usefastattack = false
end)
end
end
else
if (CFrame.new(1057.92761, 137.614319, 1242.08069).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(CFrame.new(1057.92761, 137.614319, 1242.08069).Position,CFrame.new(1057.92761, 137.614319, 1242.08069))
elseif (CFrame.new(1057.92761, 137.614319, 1242.08069).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1057.92761, 137.614319, 1242.08069)
end 
end
end
end
end
end
end
end)
AutoFarmMiscTab:Label("Auto true triple Katana",true)
AutoFarmMiscTab:Toggle("Auto true triple Katana",false,function(Value)
truetripleKatana = Value    
end)
spawn(function()
while wait() do
if truetripleKatana then
local string_1 = "MysteriousMan";
local string_2 = "2";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);   
end 
end
end)
-- Auto Rengoku
RengokuWeapon = ""
AutoFarmMiscTab:Label("Auto Rengoku",true)
AutoFarmMiscTab:Toggle("Auto Rengoku",_G.AutoRengoku,function(v)
if not NewWorld then
Flux:Notification("Use in New World")
elseif SelectToolWeapon == "" and v then
Flux:Notification("Select Wapon First")
else
AutoRengoku = v
end 
end)
spawn(function()
while wait() do
if AutoRengoku then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Hidden Key") or  game.Players.LocalPlayer.Character:FindFirstChild("Hidden Key") then
EquipWeapon("Hidden Key")
if (CFrame.new(6571.81885, 296.689758, -6966.76514).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(CFrame.new(6571.81885, 296.689758, -6966.76514).Position,CFrame.new(6571.81885, 296.689758, -6966.76514))
elseif (CFrame.new(6571.81885, 296.689758, -6966.76514).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6571.81885, 296.689758, -6966.76514, 0.825126112, 8.412257e-10, 0.564948559, -2.42370835e-08, 1, 3.39100339e-08, -0.564948559, -4.16727595e-08, 0.825126112)
end 
elseif game.Workspace.Enemies:FindFirstChild("Snow Lurker [Lv. 1375]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoRengoku and v.Name == "Snow Lurker [Lv. 1375]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
StatrMagnetRengoku = false
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
PosMonRengoku = v.HumanoidRootPart.CFrame
EquipWeapon(SelectToolWeapon)
Usefastattack = true
StatrMagnetRengoku = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
Click()
end 
until game.Players.LocalPlayer.Backpack:FindFirstChild("Hidden Key") or AutoRengoku == false or not v.Parent or v.Humanoid.Health <= 0
StatrMagnetRengoku = false
Usefastattack = false
if (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(CFrame.new(5518.00684, 60.5559731, -6828.80518).Position,CFrame.new(5518.00684, 60.5559731, -6828.80518))
elseif (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5518.00684, 60.5559731, -6828.80518, 0.825126112, 8.412257e-10, 0.564948559, -2.42370835e-08, 1, 3.39100339e-08, -0.564948559, -4.16727595e-08, 0.825126112)
end 
end
end
else
StatrMagnetRengoku = false
if (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(CFrame.new(5518.00684, 60.5559731, -6828.80518).Position,CFrame.new(5518.00684, 60.5559731, -6828.80518))
elseif (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =CFrame.new(5518.00684, 60.5559731, -6828.80518, -0.650781393, -3.64292951e-08, 0.759265184, -4.07668654e-09, 1, 4.44854642e-08, -0.759265184, 2.58550248e-08, -0.650781393)
end 
end
end
end
end)
-- Auto Farm Ectoplasm
AutoFarmMiscTab:Label("Auto Farm Ectoplasm",true)
AutoFarmMiscTab:Toggle("Auto Farm Ectoplasm",_G.AutoFarmEctoplasm,function(A)
if NewWorld then
AutoFramEctoplasm = A
else
Flux:Notification("Use in New World")
end
end)
spawn(function()
while wait() do
if AutoFramEctoplasm then
if game.Workspace.Enemies:FindFirstChild("Ship Deckhand [Lv. 1250]") or game.Workspace.Enemies:FindFirstChild("Ship Engineer [Lv. 1275]") or game.Workspace.Enemies:FindFirstChild("Ship Steward [Lv. 1300]") or game.Workspace.Enemies:FindFirstChild("Ship Officer [Lv. 1325]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if string.find(v.Name, "Ship") then
repeat wait()
Usefastattack = true
if string.find(v.Name, "Ship") then
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
StatrMagnetEctoplasm = false
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
PosMonEctoplasm = v.HumanoidRootPart.CFrame
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
StatrMagnetEctoplasm = true
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
Click()
end 
else
StatrMagnetEctoplasm = false
if (CFrame.new(920.14447, 129.581833, 33442.168).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(CFrame.new(920.14447, 129.581833, 33442.168).Position,CFrame.new(920.14447, 129.581833, 33442.168))
elseif (CFrame.new(920.14447, 129.581833, 33442.168).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(920.14447, 129.581833, 33442.168, -0.999913812, 0, -0.0131403487, 0, 1, 0, 0.0131403487, 0, -0.999913812)
end 
end
until AutoFramEctoplasm == false or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
StatrMagnetEctoplasm = false
if (CFrame.new(920.14447, 129.581833, 33442.168).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(CFrame.new(920.14447, 129.581833, 33442.168).Position,CFrame.new(920.14447, 129.581833, 33442.168))
elseif (CFrame.new(920.14447, 129.581833, 33442.168).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(920.14447, 129.581833, 33442.168, -0.999913812, 0, -0.0131403487, 0, 1, 0, 0.0131403487, 0, -0.999913812)
end 
end
end
else
if (CFrame.new(920.14447, 129.581833, 33442.168).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(CFrame.new(920.14447, 129.581833, 33442.168).Position,CFrame.new(920.14447, 129.581833, 33442.168))
elseif (CFrame.new(920.14447, 129.581833, 33442.168).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(920.14447, 129.581833, 33442.168, -0.999913812, 0, -0.0131403487, 0, 1, 0, 0.0131403487, 0, -0.999913812)
end 
end
end
end
end)
AutoFarmMiscTab:Toggle("Auto Buy Bizarre Rifle",_G.AutoBuyBizarreRifle,function(A)
if NewWorld then
AutoBuyBizarreRifle = A
else
Flux:Notification("Use in New World")
end
end)
AutoFarmMiscTab:Toggle("Auto Buy Ghoul Mask",_G.AutoBuyGhoulMask,function(A)
if NewWorld then
AutoBuyGhoulMask = A
else
Flux:Notification("Use in New World")
end
end)
AutoFarmMiscTab:Toggle("Auto Buy Midnight Blade",_G.AutoBuyMidnightBlade,function(A)
if NewWorld then
AutoBuyMidnightBlade = A
else
Flux:Notification("Use in New World")
end
end)
spawn(function()
while wait() do
if AutoBuyBizarreRifle then
local args = {
[1] = "Ectoplasm",
[2] = "Buy",
[3] = 1
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
if AutoBuyGhoulMask then
local args = {
[1] = "Ectoplasm",
[2] = "Buy",
[3] = 2
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
if AutoBuyMidnightBlade then
local args = {
[1] = "Ectoplasm",
[2] = "Buy",
[3] = 3
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end
end)
AutoFarmMiscTab:Line()
AutoFarmMiscTab:Label("Sea 3 (Thire World)",true)
-- Auto Buddy Swords
AutoFarmMiscTab:Label("🍬 Buddy Swords 🍬")
AutoFarmMiscTab:Toggle("Auto Buddy Swords",_G.AutoBuddySwords,function(v)
if not ThreeWorld then
library:Notification("Notification","Use In Thire World","Okey")    
else
AutoBuddySwords = v
end 
end)
AutoFarmMiscTab:Toggle("Auto Buddy Swords HOP",_G.AutoBuddySwordsHop,function(v)
if not ThreeWorld then
library:Notification("Notification","Use In Thire World","Okey")    
else
AutoBuddySwords = v
AutoBuddySwordsHOP = v
end 
end)
spawn(function()
while wait() do
if AutoBuddySwords then
if game.ReplicatedStorage:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") or game.Workspace.Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
if game.Workspace.Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoBuddySwords and v.Name == "Cake Queen [Lv. 2175] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat wait()
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
game:GetService'VirtualUser':CaptureController()
game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
end 
until not AutoBuddySwords or v.Humanoid.Health <= 0 or not v.Parent
Usefastattack = false
end
end
else
BuddySwordsTween = toTarget(CFrame.new(-821, 66, -10965).Position,CFrame.new(-821, 66, -10965))
if (CFrame.new(-821, 66, -10965).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if BuddySwordsTween then
BuddySwordsTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-821, 66, -10965)
end
end
elseif AutoBuddySwordsHOP then
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(v.maxPlayers) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
local delFile = pcall(function()
-- delfile("NotSameServers.json")
AllIDs = {}
table.insert(AllIDs, actualHour)
end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(1)
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
end
end
end
end)
AutoFarmMiscTab:Label("🎃 Hallow Ween 🎃")
AutoFarmMiscTab:Toggle("Auto Farm Bone",_G.AutoFarmBone,function(vu)
if not ThreeWorld and vu then
Flux:Notification('Use In Sea 3 (Three World)')
else 
AutoFarmBone = vu
MainAutoFarmBone = vu
end  
end)    
spawn(function()
while wait() do
if AutoFarmBone then
if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoFarmBone and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
MagnetFarmBone = false
Usefastattack = false
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
Usefastattack = true
PosFarmBone = v.HumanoidRootPart.CFrame
EquipWeapon(SelectToolWeapon)
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
MagnetFarmBone = true
end
until not AutoFarmBone or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
MagnetFarmBone = false
end
end
else
MagnetFarmBone = false
Usefastattack = false
Questtween = toTarget(CFrame.new(-9506.14648, 172.130661, 6101.79053).Position,CFrame.new(-9506.14648, 172.130661, 6101.79053))
if (CFrame.new(-9506.14648, 172.130661, 6101.79053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9506.14648, 172.130661, 6101.79053, -0.999731541, 0, -0.0231563263, 0, 1, 0, 0.0231563263, 0, -0.999731541)
end
end
end
end
end)
spawn(function()
while wait() do
if MagnetFarmBone and AutoFarmBone then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if MagnetFarmBone  and AutoFarmBone and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
v.HumanoidRootPart.CFrame = PosFarmBone
v.HumanoidRootPart.CanCollide = false
end
end
end
end
end)

local string_1 = "getInventoryWeapons";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
local ListInventoryWeapons = Target:InvokeServer(string_1);
AutoFarmMiscTab:Toggle("Auto Hallow Scythe",_G.AutoHallowScythe,function(a)
HaveHallowScythe = false
for i,v in pairs(ListInventoryWeapons) do
if v.Name == "Hallow Scythe" then   
HaveHallowScythe = true
end
end
if not ThreeWorld and a then
Flux:Notification('Use In Sea 3 (Three World)')
elseif HaveHallowScythe and a then
Flux:Notification('You Have Hallow Scythe')
else    
AutoHallowScythe = a
end 
end)
spawn(function()
while wait() do
if AutoHallowScythe then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") then
if MainAutoFarmBone then
AutoFarmBone = false
end
Questtween = toTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position,game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
if (game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame
end
elseif game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") or game.ReplicatedStorage:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
if MainAutoFarmBone then
AutoFarmBone = false
end
if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoHallowScythe and v.Name == "Soul Reaper [Lv. 2100] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
PosFarmBone = v.HumanoidRootPart.CFrame
EquipWeapon(SelectToolWeapon)

if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end
until not AutoHallowScythe or not v.Parent or v.Humanoid.Health <= 0

end
end
else
Questtween = toTarget(CFrame.new(-9521, 316, 6684).Position,CFrame.new(-9521, 316, 6684))
if (CFrame.new(-9521, 316, 6684).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9521, 316, 6684)
end
end 
else
if MainAutoFarmBone then
AutoFarmBone = true
end
local string_1 = "Bones";
local string_2 = "Buy";
local number_1 = 1;
local number_2 = 1;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2, number_1, number_2);
end
end
end
end)
AutoFarmMiscTab:Toggle("Auto Farm Soul Reaper",_G.AutoFarmSoulReaper,function(a)
if not ThreeWorld and a then
Flux:Notification('Use In Sea 3 (Three World)')
else    
AutoSoulReaper = a
end 
end)
spawn(function()
while wait() do
if AutoSoulReaper then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") then
if MainAutoFarmBone then
AutoFarmBone = false
end
Questtween = toTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position,game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
if (game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame
end
elseif game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") or game.ReplicatedStorage:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
if MainAutoFarmBone then
AutoFarmBone = false
end
if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoHallowScythe and v.Name == "Soul Reaper [Lv. 2100] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
PosFarmBone = v.HumanoidRootPart.CFrame
EquipWeapon(SelectToolWeapon)

if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end
until not AutoSoulReaper or not v.Parent or v.Humanoid.Health <= 0

end
end
else
Questtween = toTarget(CFrame.new(-9521, 316, 6684).Position,CFrame.new(-9521, 316, 6684))
if (CFrame.new(-9521, 316, 6684).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then
Questtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9521, 316, 6684)
end
end 
else
if MainAutoFarmBone then
AutoFarmBone = true
end
local string_1 = "Bones";
local string_2 = "Buy";
local number_1 = 1;
local number_2 = 1;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2, number_1, number_2);
end
end
end
end)
AutoFarmMiscTab:Toggle("Auto Random bone",_G.AutoRandombone,function(value)
brandom = value
end)
spawn(function()
while wait() do
if brandom then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
end
end
end)  
AutoFarmMiscTab:Label("🌀 Portal 🌀")
PortalKill = AutoFarmMiscTab:Label("N/S")
spawn(function()
while wait() do
if game.ReplicatedStorage:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") then
PortalKill:Refresh("Can Open Door To Kill Cake Prince")
else
PortalKill:Refresh("Need Kill Mods : " .. string.match(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true), "%d+") .. " To Open Kill Cake Prince")
end
end
end)
AutoFarmMiscTab:Toggle("Auto Farm Cake Prince",_G.AutoFarmCakePrince,function(vu)
if not ThreeWorld and vu then
VLib:Notification('Use In Sea 3 (Three World)')
else 
AutoFarmCakePrince = vu
end  
end)    
spawn(function()
while wait() do
if AutoFarmCakePrince then
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
if game.ReplicatedStorage:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") then
if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoFarmCakePrince and v.Name == "Cake Prince [Lv. 2300] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
Usefastattack = false
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
PosFarmBone = v.HumanoidRootPart.CFrame
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end
until not AutoFarmCakePrince or not v.Parent or v.Humanoid.Health <= 0 or game.ReplicatedStorage:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]")
Usefastattack = false
end
end
else
Usefastattack = false
Questtween = toTarget(CFrame.new(-2151.82153, 149.315704, -12404.9053).Position,CFrame.new(-2151.82153, 149.315704, -12404.9053))
if (CFrame.new(-2151.82153, 149.315704, -12404.9053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then Questtween:Stop() end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2151.82153, 149.315704, -12404.9053)
end
end
else
if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter [Lv. 2200]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard [Lv. 2225]") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff [Lv. 2250]") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker [Lv. 2275]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if 0 and (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
MagnetFarmCakePrince = false
Usefastattack = false
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then Farmtween:Stop() end
Usefastattack = true
PosFarmCakePrince = v.HumanoidRootPart.CFrame
EquipWeapon(SelectToolWeapon)
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
MagnetFarmCakePrince = true
end
until not AutoFarmCakePrince or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
MagnetFarmBone = false
end
end
else
MagnetFarmCakePrince = false
Usefastattack = false
Questtween = toTarget(CFrame.new(-2077, 252, -12373).Position,CFrame.new(-2077, 252, -12373))
if (CFrame.new(-2077, 252, -12373).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Questtween then Questtween:Stop() end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2077, 252, -12373)
end
end
end
end
end
end)
spawn(function()
while wait() do
if MagnetFarmCakePrince and AutoFarmCakePrince then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if MagnetFarmCakePrince  and AutoFarmCakePrince and (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
v.HumanoidRootPart.CFrame = PosFarmCakePrince
v.HumanoidRootPart.CanCollide = false
end
end
end
end
end)

AutoFarmMiscTab:Label("Auto Tushita",true)
AutoFarmMiscTab:Toggle("Auto Tushita",_G.AutoEnma,function(v)
if NewWorld or OldWorld then
VLib:Notification("Use In Thire World")    
else
AutoTushitaSword = v
end 
end)
AutoFarmMiscTab:Toggle("Auto Tushita Hop",_G.AutoEnmaHop,function(v)
if NewWorld or OldWorld then
VLib:Notification("Use In Thire World")    
else
AutoTushitaSword = v
HopFunction = v
end 
end)

spawn(function()
while wait(.1) do
if AutoTushitaSword then
autoTushita()
end
end
end)


function enemyrip()
repeat 
MytoTarget(CFrame.new(-5332.30371, 423.985413, -2673.48218)) 
wait() 
until _G.StopTween == true or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-5332.30371, 423.985413, -2673.48218)).Magnitude <= 10
wait()
if game.Workspace.Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") then
local mobs = game.Workspace.Enemies:GetChildren()
for i,v in pairs(mobs) do
if v.Name == "rip_indra True Form [Lv. 5000] [Raid Boss]" and v:IsA("Model") and v:FindFirstChild("Humanoid") and
v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
return v
end
end
end
return game.ReplicatedStorage:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")
end
function enemyEliteBoss()
if game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]") then
local mobs = game.Workspace.Enemies:GetChildren()
for i,v in pairs(mobs) do
if v.Name == "Deandre [Lv. 1750]" or v.Name == "Diablo [Lv. 1750]" or v.Name == "Urban [Lv. 1750]"  and v:IsA("Model") and v:FindFirstChild("Humanoid") and
v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
return v
end
end
end
return game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")
end

function enemylongma()
repeat 
MytoTarget(CFrame.new(-10171.7051, 406.981995, -9552.31738)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-10171.7051, 406.981995, -9552.31738)).Magnitude <= 10
if game.Workspace.Enemies:FindFirstChild("Longma [Lv. 2000] [Boss]") then
local mobs = game.Workspace.Enemies:GetChildren()
for i,v in pairs(mobs) do
if v.Name == "Longma [Lv. 2000] [Boss]" and v:IsA("Model") and v:FindFirstChild("Humanoid") and
v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
return v
end
end
end
return game.ReplicatedStorage:FindFirstChild("Longma [Lv. 2000] [Boss]")
end

_G.checkup = true
function autoTushita()
if _G.checkup and not game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") and not game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") then
if game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]") then
if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
repeat 
MytoTarget(CFrame.new(-5420.49219, 314.446045, -2823.07373)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-5420.49219, 314.446045, -2823.07373)).Magnitude <= 10
wait(1.1)
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
wait(1)
elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
CheckQuest()
pcall(function()
EquipWeapon(_G.SelectWeapon)
pcall(function()
local v = enemyEliteBoss()
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
MytoTarget(v.HumanoidRootPart.CFrame * CFrame.new(1,20,1)) 
end)
end)
end
elseif HopFunction then
MytoTarget(CFrame.new(-12554.9443, 337.194092, -7501.44727, 0.906377554, 4.23948272e-08, -0.422468632, -1.89128269e-08, 1, 5.97740595e-08, 0.422468632, -4.61877896e-08, 0.906377554))				wait(1)
HopServer()
end
elseif game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") then
_G.checkup = false
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Winter Sky")
wait(0.5)
repeat 
MytoTarget(CFrame.new(-5420.16602, 1084.9657, -2666.8208)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-5420.16602, 1084.9657, -2666.8208)).Magnitude <= 10
wait(0.5)
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Pure Red")
wait(0.5)
repeat 
MytoTarget(CFrame.new(-5414.41357, 309.865753, -2212.45776)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-5414.41357, 309.865753, -2212.45776)).Magnitude <= 10
wait(0.5)
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Snow White")
wait(0.5)
repeat 
MytoTarget(CFrame.new(-4971.47559, 331.565765, -3720.02954)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-4971.47559, 331.565765, -3720.02954)).Magnitude <= 10
wait(0.5)
EquipWeapon("God's Chalice")
wait(0.5)
repeat 
MytoTarget(CFrame.new(-5560.27295, 313.915466, -2663.89795)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-5560.27295, 313.915466, -2663.89795)).Magnitude <= 10
wait(0.5)
repeat 
MytoTarget(CFrame.new(-5561.37451, 313.342529, -2663.49487)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-5561.37451, 313.342529, -2663.49487)).Magnitude <= 10
wait(1)
repeat 
MytoTarget(CFrame.new(5154.17676, 141.786423, 911.046326)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(5154.17676, 141.786423, 911.046326)).Magnitude <= 10
wait(0.2)
repeat 
MytoTarget(CFrame.new(5148.03613, 162.352493, 910.548218)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(5148.03613, 162.352493, 910.548218)).Magnitude <= 10
wait(1)
EquipWeapon("Holy Torch")
wait(1)
wait(0.4)
repeat 
MytoTarget(CFrame.new(-10752.7695, 412.229523, -9366.36328)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-10752.7695, 412.229523, -9366.36328)).Magnitude <= 10
wait(0.4)
repeat 
MytoTarget(CFrame.new(-11673.4111, 331.749023, -9474.34668)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-11673.4111, 331.749023, -9474.34668)).Magnitude <= 10
wait(0.4)
repeat 
MytoTarget(CFrame.new(-12133.3389, 519.47522, -10653.1904)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-12133.3389, 519.47522, -10653.1904)).Magnitude <= 10
wait(0.4)
repeat 
MytoTarget(CFrame.new(-13336.5, 485.280396, -6983.35254, 0.912677109)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-13336.5, 485.280396, -6983.35254, 0.912677109)).Magnitude <= 10
wait(0.4)
repeat 
MytoTarget(CFrame.new(-13487.4131, 334.84845, -7926.34863)) 
wait() 
until _G.StopTween == true or not _G.AutoYamaSword or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-13487.4131, 334.84845, -7926.34863)).Magnitude <= 10
wait(1)
elseif game.Workspace.Enemies:FindFirstChild("Longma [Lv. 2000] [Boss]") or game.ReplicatedStorage:FindFirstChild("Longma [Lv. 2000] [Boss]") then
pcall(function()
EquipWeapon(_G.SelectWeapon)
pcall(function()
local v = enemylongma()
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
MytoTarget(v.HumanoidRootPart.CFrame * CFrame.new(1, _G.DistanceFarm, 0))
end)
end)
elseif game.Workspace.Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")  or game.ReplicatedStorage:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") then
pcall(function()
EquipWeapon(_G.SelectWeapon)
pcall(function()
local v = enemyrip()
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
MytoTarget(v.HumanoidRootPart.CFrame * CFrame.new(1, _G.DistanceFarm, 0))
end)
end)
elseif HopFunction then
MytoTarget(CFrame.new(-12554.9443, 337.194092, -7501.44727, 0.906377554, 4.23948272e-08, -0.422468632, -1.89128269e-08, 1, 5.97740595e-08, 0.422468632, -4.61877896e-08, 0.906377554))
wait(1)
HopServer()
end
end

AutoFarmMiscTab:Label("Auto Enma/Yama",true)
AutoFarmMiscTab:Toggle("Auto Enma/Yama",_G.AutoEnma,function(v)
if NewWorld or OldWorld then
VLib:Notification("Use In Thire World")    
else
AutoYama = v
end 
end)
AutoFarmMiscTab:Toggle("Auto Enma/Yama HOP",_G.AutoEnmaHop,function(v)
if NewWorld or OldWorld then
VLib:Notification("Use In Thire World")    
else
AutoYama = v
AutoYamaHOP = v
end 
end)
spawn(function()
while wait() do
if AutoYama then
if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter", "Progress") < 30 then
if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
if string.find(v.Name,"Diablo") then
YemaTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if YemaTween then
YemaTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
end
end	
if string.find(v.Name,"Urban") then
YemaTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if YemaTween then
YemaTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
end
end	
if string.find(v.Name,"Deandre") then
YemaTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if YemaTween then
YemaTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
end
end	
end
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoYama and string.find(v.Name,"Diablo") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not AutoYama or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
if AutoYama and string.find(v.Name,"Urban") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not AutoYama or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
if AutoYama and string.find(v.Name,"Deandre") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not AutoYama or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
end
else
local string_1 = "EliteHunter";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1);
end
else
if AutoYamaHOP and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(v.maxPlayers) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
local delFile = pcall(function()
    -- delfile("NotSameServers.json")
    AllIDs = {}
    table.insert(AllIDs, actualHour)
end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(1)
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
else
local string_1 = "EliteHunter";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1);
end
end
else
TweenYema = toTarget(game.Workspace.Map.Waterfall.SealedKatana.Handle.Position,game.Workspace.Map.Waterfall.SealedKatana.Handle.CFrame)
if (game.Workspace.Map.Waterfall.SealedKatana.Handle.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if TweenYema then
TweenYema:Stop()
end
if game.Workspace.Enemies:FindFirstChild("Ghost [Lv. 1500]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoYama and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Ghost [Lv. 1500]" then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not AutoYama or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
end
else
if TweenYema then
TweenYema:Stop()
end
fireclickdetector(game.Workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
end
end
end
end
end
end)
-- Auto Holy Torch
AutoFarmMiscTab:Label("Auto Holy Torch",true)
AutoFarmMiscTab:Toggle("Auto Holy Torch",_G.AutoHolyTorch,function(v)
if NewWorld or OldWorld then
VLib:Notification("Use In Thire World")    
else
HolyTorch = v
end 
end)
spawn(function()
while wait() do
if HolyTorch then
if game.ReplicatedStorage:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") or game.Workspace.Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") and game:GetService("Workspace").Map.Turtle.TushitaGate.TushitaGate.Transparency == 1 then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Holy Torch") then
EquipWeapon("Holy Torch")
elseif game.Players.LocalPlayer.Character:FindFirstChild("Holy Torch") then
if game:GetService("Workspace").Map.Turtle.QuestTorches.Torch1.Particles.Main.Enabled ~= true then
if (game:GetService("Workspace").Map.Turtle.QuestTorches.Torch1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
HolyTorchtween = toTarget(game:GetService("Workspace").Map.Turtle.QuestTorches.Torch1.Position,game:GetService("Workspace").Map.Turtle.QuestTorches.Torch1.CFrame)
elseif (game:GetService("Workspace").Map.Turtle.QuestTorches.Torch1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if HolyTorchtween then
HolyTorchtween:Stop()
end
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Turtle.QuestTorches.Torch1.CFrame
end
elseif game:GetService("Workspace").Map.Turtle.QuestTorches.Torch2.Particles.Main.Enabled ~= true then
if (game:GetService("Workspace").Map.Turtle.QuestTorches.Torch2.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
HolyTorchtween = toTarget(game:GetService("Workspace").Map.Turtle.QuestTorches.Torch2.Position,game:GetService("Workspace").Map.Turtle.QuestTorches.Torch2.CFrame)
elseif (game:GetService("Workspace").Map.Turtle.QuestTorches.Torch2.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if HolyTorchtween then
HolyTorchtween:Stop()
end
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Turtle.QuestTorches.Torch2.CFrame
end
elseif game:GetService("Workspace").Map.Turtle.QuestTorches.Torch3.Particles.Main.Enabled ~= true then
if (game:GetService("Workspace").Map.Turtle.QuestTorches.Torch3.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
HolyTorchtween = toTarget(game:GetService("Workspace").Map.Turtle.QuestTorches.Torch3.Position,game:GetService("Workspace").Map.Turtle.QuestTorches.Torch3.CFrame)
elseif (game:GetService("Workspace").Map.Turtle.QuestTorches.Torch3.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if HolyTorchtween then
HolyTorchtween:Stop()
end
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Turtle.QuestTorches.Torch3.CFrame
end
elseif game:GetService("Workspace").Map.Turtle.QuestTorches.Torch4.Particles.Main.Enabled ~= true then
if (game:GetService("Workspace").Map.Turtle.QuestTorches.Torch4.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
HolyTorchtween = toTarget(game:GetService("Workspace").Map.Turtle.QuestTorches.Torch4.Position,game:GetService("Workspace").Map.Turtle.QuestTorches.Torch4.CFrame)
elseif (game:GetService("Workspace").Map.Turtle.QuestTorches.Torch4.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if HolyTorchtween then
HolyTorchtween:Stop()
end
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Turtle.QuestTorches.Torch4.CFrame
end
elseif game:GetService("Workspace").Map.Turtle.QuestTorches.Torch5.Particles.Main.Enabled ~= true then
if (game:GetService("Workspace").Map.Turtle.QuestTorches.Torch5.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
HolyTorchtween = toTarget(game:GetService("Workspace").Map.Turtle.QuestTorches.Torch5.Position,game:GetService("Workspace").Map.Turtle.QuestTorches.Torch5.CFrame)
elseif (game:GetService("Workspace").Map.Turtle.QuestTorches.Torch5.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if HolyTorchtween then
HolyTorchtween:Stop()
end
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Turtle.QuestTorches.Torch5.CFrame
end
end
else
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Waterfall.SecretRoom.Room.Door.Door.Hitbox.CFrame
end
end
end
end
end)
-- Auto Fram Elite Hunter
local CheckEliteHunter = AutoFarmMiscTab:Label("Kill " .. game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") .. " Elite Enemies",true)
spawn(function()
while wait() do
CheckEliteHunter:Refresh("Kill " .. game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") .. " Elite Enemies")
end
end)
AutoFarmMiscTab:Toggle("Auto Elite Hunter",_G.AutoEliteHunter,function(a)
if ThreeWorld then
AutoEliteHunter = a
else
VLib:Notification("Use In Thire World")
end
end)
AutoFarmMiscTab:Toggle("Auto Elite Hunter HOP",_G.AutoEliteHunterHop,function(a)
if ThreeWorld then
AutoEliteHunter = a
AutoEliteHunterHOP = a
else
VLib:Notification("Use In Thire World")
end
end)
spawn(function()
while wait() do
if AutoEliteHunter then
if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
if string.find(v.Name,"Diablo") then
EliteHunter = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if EliteHunter then
EliteHunter:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
end
end	
if string.find(v.Name,"Urban") then
EliteHunter = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if EliteHunter then
EliteHunter:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
end
end	
if string.find(v.Name,"Deandre") then
EliteHunter = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if EliteHunter then
EliteHunter:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
end
end	
end
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoEliteHunter and string.find(v.Name,"Diablo") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not AutoEliteHunter or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
if AutoEliteHunter and string.find(v.Name,"Urban") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not AutoEliteHunter or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
if AutoEliteHunter and string.find(v.Name,"Deandre") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not AutoEliteHunter or not v.Parent or v.Humanoid.Health <= 0
Usefastattack = false
end
end
else
if AutoEliteHunterHOP and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(4) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
local delFile = pcall(function()
    -- delfile("NotSameServers.json")
    AllIDs = {}
    table.insert(AllIDs, actualHour)
end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(1)
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
else
local string_1 = "EliteHunter";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1);
end
end
else
if AutoEliteHunterHOP and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(4) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
local delFile = pcall(function()
-- delfile("NotSameServers.json")
AllIDs = {}
table.insert(AllIDs, actualHour)
end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(1)
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
else
local string_1 = "EliteHunter";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1);
end
end
end
end	
end)

AutoFarmMiscTab:Label("Auto Haki Rainbow",true)
AutoFarmMiscTab:Toggle("Auto Haki Rainbow",_G.AutoHakiRainbow,function(a)
if ThreeWorld then
AutoHakiRainbow = a
else
Flux:Notification("Use In Three World")
end
end)
spawn(function()
while wait() do
if AutoHakiRainbow then
if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Island Empress") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
if game.Workspace.Enemies:FindFirstChild("Stone [Lv. 1550] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoHakiRainbow and v.Name == "Stone [Lv. 1550] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat
pcall(function() wait() 
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
    Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
    local args = {
        [1] = "Buso"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
end)
until not AutoHakiRainbow or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
Usefastattack = true
end
end
else 
if (CFrame.new(-1134, 40, 6877).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
HakiRainbowTween = toTarget(CFrame.new(-1134, 40, 6877).Position,CFrame.new(-1134, 40, 6877))
elseif (CFrame.new(-1134, 40, 6877).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if HakiRainbowTween then
HakiRainbowTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1134, 40, 6877)
end
end
elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Island Empress") then
if game.Workspace.Enemies:FindFirstChild("Island Empress [Lv. 1675] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoHakiRainbow and v.Name == "Island Empress [Lv. 1675] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat
pcall(function() wait() 
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
    Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
    local args = {
        [1] = "Buso"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
end)
until not AutoHakiRainbow or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
Usefastattack = true
end
end
else
if (CFrame.new(5614, 603, 339).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
HakiRainbowTween = toTarget(CFrame.new(5614, 603, 339).Position,CFrame.new(5614, 603, 339))
elseif (CFrame.new(5614, 603, 339).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if HakiRainbowTween then
HakiRainbowTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5614, 603, 339)
end
end	
elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
if game.Workspace.Enemies:FindFirstChild("Kilo Admiral [Lv. 1750] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoHakiRainbow and v.Name == "Kilo Admiral [Lv. 1750] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat
pcall(function() wait() 
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
    Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
    local args = {
        [1] = "Buso"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
end)
until not AutoHakiRainbow or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
Usefastattack = true
end
end
else
if (CFrame.new(2879, 433, -7090).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
HakiRainbowTween = toTarget(CFrame.new(2879, 433, -7090).Position,CFrame.new(2879, 433, -7090))
elseif (CFrame.new(2879, 433, -7090).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if HakiRainbowTween then
HakiRainbowTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2879, 433, -7090)
end
end	
elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
if game.Workspace.Enemies:FindFirstChild("Captain Elephant [Lv. 1875] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoHakiRainbow and v.Name == "Captain Elephant [Lv. 1875] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat
pcall(function() wait() 
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
    Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
    local args = {
        [1] = "Buso"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
end)
until not AutoHakiRainbow or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
Usefastattack = true
end
end
else
if (CFrame.new(-13348, 406, -8574).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
HakiRainbowTween = toTarget(CFrame.new(-13348, 406, -8574).Position,CFrame.new(-13348, 406, -8574))
elseif (CFrame.new(-13348, 406, -8574).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if HakiRainbowTween then
HakiRainbowTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13348, 406, -8574)
end
end	
elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
if game.Workspace.Enemies:FindFirstChild("Beautiful Pirate [Lv. 1950] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoHakiRainbow and v.Name == "Beautiful Pirate [Lv. 1950] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat
pcall(function() wait() 
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
    Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
    local args = {
        [1] = "Buso"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
end)
until not AutoHakiRainbow or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
Usefastattack = true
end
end
else
if (CFrame.new(5206, 23, -80).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
HakiRainbowTween = toTarget(CFrame.new(5206, 23, -80).Position,CFrame.new(5206, 23, -80))
elseif (CFrame.new(5206, 23, -80).Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 20000 then
if HakiRainbowTween then
HakiRainbowTween:Stop()
end
local TouchInterest = game:GetService("Workspace").Map.Turtle.Entrance.Door.BossDoor.Hitbox
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TouchInterest.CFrame
elseif (CFrame.new(5206, 23, -80).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if HakiRainbowTween then
HakiRainbowTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5206, 23, -80)
end
end	
end
else
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
end
else
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
local string_1 = "HornedMan";
local string_2 = "Bet";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
end
end
end
end)
AutoFarmMiscTab:Label("Auto Musketee Hat " )
AutoFarmMiscTab:Toggle("Auto Musketee Hat",_G.AutoMusketeeHat,function(a)
if ThreeWorld then
MusketeeHat = a
else
Flux:Notification("Use In Three World")
end
end)
spawn(function()
while wait() do
if MusketeeHat then
local v86 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
if v86 == 0 then
if not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50 Forest Pirates") then
local string_1 = "StartQuest";
local string_2 = "CitizenQuest";
local number_1 = 1;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2, number_1);
else
if game.Workspace.Enemies:FindFirstChild("Forest Pirate [Lv. 1825]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if v.Name == "Forest Pirate [Lv. 1825]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat wait() 
MusketeeHatPos = v.HumanoidRootPart.CFrame
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
MusketeeHatMagnet = false
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
MusketeeHatMagnet = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not MusketeeHat or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text == "Defeat 50 Forest Pirates (50/50)"
Usefastattack = false
MusketeeHatMagnet = false
end 
end
else
if (CFrame.new(-13265, 428, -7781).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
MusketeeTween = toTarget(CFrame.new(-13265, 428, -7781).Position,CFrame.new(-13265, 428, -7781))
elseif (CFrame.new(-13265, 428, -7781).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if MusketeeTween then
MusketeeTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13265, 428, -7781)
end
end
end
elseif v86 == 1 then
MusketeeHatMagnet = false
if not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13350, 406, -8573)
else
if game.Workspace.Enemies:FindFirstChild("Captain Elephant [Lv. 1875] [Boss]") then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if v.Name == "Captain Elephant [Lv. 1875] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat wait()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
if Farmtween then
Farmtween:Stop()
end
EquipWeapon(SelectToolWeapon)
Usefastattack = true
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
Click()
end 
until not MusketeeHat or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text == "Defeat  Captain Elephant (1/1)"
Usefastattack = false
end 
end
else
if (CFrame.new(-13350, 406, -8573).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
MusketeeTween = toTarget(CFrame.new(-13350, 406, -8573).Position,CFrame.new(-13350, 406, -8573))
elseif (CFrame.new(-13350, 406, -8573).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if MusketeeTween then
MusketeeTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13350, 406, -8573)
end
end
end
elseif v86 == 2 then
if game.Workspace.Map.Turtle:FindFirstChild("Treasure") then
if (game.Workspace.Map.Turtle:FindFirstChild("Treasure").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
MusketeeTween = toTarget(game.Workspace.Map.Turtle:FindFirstChild("Treasure").Position,game.Workspace.Map.Turtle:FindFirstChild("Treasure").CFrame)
elseif (game.Workspace.Map.Turtle:FindFirstChild("Treasure").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
if MusketeeTween then
MusketeeTween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Turtle:FindFirstChild("Treasure").CFrame
end
end
end
end
end
end)
AutoFarmMiscTab:Label("Auto Observation Haki V2" )
AutoFarmMiscTab:Toggle("Auto Observation Haki V2",_G.AutoObservationHakiV2,function(a)
if ThreeWorld then
if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 4 or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 3 and game:GetService("Players").LocalPlayer.VisionRadius == 3000 then
AutoObservationHakiV2 = a
elseif game:GetService("Players").LocalPlayer.VisionRadius < 3000 then
Flux:Notification("Observation Haki Not Max")
else
Flux:Notification("Quest Musketee Hat No Compete")
end 
else
Flux:Notification("Use In Three World")
end
end)
spawn(function()
while wait() do
if AutoObservationHakiV2 then
if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 4 or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 3  then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or game.Players.LocalPlayer.Character:FindFirstChild("Fruit Bowl") then
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2", "Start")
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
else
if ( game.Players.LocalPlayer.Character:FindFirstChild("Pineapple") or game.Players.LocalPlayer.Backpack:FindFirstChild("Pineapple") ) and ( game.Players.LocalPlayer.Character:FindFirstChild("Banana") or game.Players.LocalPlayer.Backpack:FindFirstChild("Banana") ) and ( game.Players.LocalPlayer.Character:FindFirstChild("Apple") or game.Players.LocalPlayer.Backpack:FindFirstChild("Apple") ) then
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
else
if game:GetService("Workspace").AppleSpawner:FindFirstChild("Apple") and not ( game.Players.LocalPlayer.Character:FindFirstChild("Apple") or game.Players.LocalPlayer.Backpack:FindFirstChild("Apple") ) then  
for i,v in pairs(game:GetService("Workspace").AppleSpawner:GetChildren()) do
if v:IsA("Tool") then wait(1)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)    
end
end
end 
if game:GetService("Workspace").PineappleSpawner:FindFirstChild("Pineapple") and not ( game.Players.LocalPlayer.Character:FindFirstChild("Pineapple") or game.Players.LocalPlayer.Backpack:FindFirstChild("Pineapple") ) then  
for i,v in pairs(game:GetService("Workspace").PineappleSpawner:GetChildren()) do
if v:IsA("Tool") then wait(1)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)    
end
end
end 
if game:GetService("Workspace").BananaSpawner:FindFirstChild("Banana") and not ( game.Players.LocalPlayer.Character:FindFirstChild("Banana") or game.Players.LocalPlayer.Backpack:FindFirstChild("Banana") ) then  
for i,v in pairs(game:GetService("Workspace").BananaSpawner:GetChildren()) do
if v:IsA("Tool") then wait(1)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)    
end
end
end 
end
end
end
end
end
end)

----------------------------------------------------------------------------------------------------------------------------
local StatsTab = Main:Tab("Stats")
PlayerServer = StatsTab:Label("Players in Server : "..game.Players.NumPlayers .. "/"..game.Players.MaxPlayers)
Fruit = StatsTab:Label("Fruit : 0")
Chest = StatsTab:Label("Chest : 0")
spawn(function()
while wait() do
local count10 = 0
local count = 0
for i,v in pairs(game.workspace:GetChildren()) do
if string.find(v.Name,"Chest") and v:IsA("Part") then
count10 = count10 + 1
end
end
for i,v in pairs(game.Workspace:GetChildren()) do
if v.Name == "Blox Fruit Dealer" then
else
if string.find(v.Name, "Fruit") and v:IsA("Tool") then
count = count + 1
end
if string.find(v.Name, "Fruit") and v:IsA("Model") then
count = count + 1
end
end
end
Fruit:Refresh("Fruit : "..count)
Chest:Refresh("Chest : "..count10)
PlayerServer:Refresh("Players in Server : "..game.Players.NumPlayers .. "/"..game.Players.MaxPlayers)
wait(5)
end
end)
StatsTab:Line()
StatsTab:Label("Stats")
local Point = StatsTab:Label("Point :")
Point:Refresh("Point : "..game.Players.localPlayer.Data.Points.Value)
local MeleeStats = StatsTab:Toggle("Melee",getgenv().Setting["Melee"],function(value)
melee = value    
end)
local DefenseStats = StatsTab:Toggle("Defense",getgenv().Setting["Defense"],function(value)
defense = value
end)
local SwordStats = StatsTab:Toggle("Sword",getgenv().Setting["Sword"],function(value)
sword = value
end)
local GunStats = StatsTab:Toggle("Gun",getgenv().Setting["Gun"],function(value)
gun = value
end)
local DemonFruitStats = StatsTab:Toggle("Demon Fruit",getgenv().Setting["Demon Fruit"],function(value)
demonfruit = value
end)
PointStats = 1
StatsTab:Slider("Point",1,10,PointStats,nil,function(a)
PointStats = a
end)
spawn(function()
while wait() do
pcall(function()
MeleeStats:Refresh("Melee : " .. game:GetService("Players").LocalPlayer.Data.Stats.Melee.Level.Value )
DefenseStats:Refresh("Defense : " .. game:GetService("Players").LocalPlayer.Data.Stats.Defense.Level.Value )
SwordStats:Refresh("Sword : " .. game:GetService("Players").LocalPlayer.Data.Stats.Sword.Level.Value )
GunStats:Refresh("Gun : " .. game:GetService("Players").LocalPlayer.Data.Stats.Gun.Level.Value )
DemonFruitStats:Refresh("Demon Fruit : " .. game:GetService("Players").LocalPlayer.Data.Stats["Demon Fruit"].Level.Value )
end)
if game.Players.localPlayer.Data.Points.Value >= PointStats then
if melee then
local args = {
[1] = "AddPoint",
[2] = "Melee",
[3] = PointStats
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end 
if defense then
local args = {
[1] = "AddPoint",
[2] = "Defense",
[3] = PointStats
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end 
if sword then
local args = {
[1] = "AddPoint",
[2] = "Sword",
[3] = PointStats
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end 
if gun then
local args = {
[1] = "AddPoint",
[2] = "Gun",
[3] = PointStats
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end 
if demonfruit then
local args = {
[1] = "AddPoint",
[2] = "Demon Fruit",
[3] = PointStats
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end
Point:Refresh("Point : "..game.Players.localPlayer.Data.Points.Value) 
end
end)
----------------------------------------------------------------------------------------------------------------------------
local TeleportTab = Main:Tab("Teleport")
TeleportTab:Button("Teleport To Sea 1" ,function()
local args = {
[1] = "TravelMain" -- OLD WORLD to NEW WORLD
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
TeleportTab:Button("Teleport To Sea 2" ,function()
local args = {
[1] = "TravelDressrosa" -- NEW WORLD to OLD WORLD
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)

TeleportTab:Button("Teleport To Sea 3" ,function()
local args = {
[1] = "TravelZou" -- OLD WORLD to NEW WORLD
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
TeleportTab:Line()
if OldWorld then
Island = {
["Start Island"] = CFrame.new(1071.2832, 16.3085976, 1426.86792),
["Marine Start"] = CFrame.new(-2573.3374, 6.88881969, 2046.99817),
["Middle Town"] = CFrame.new(-655.824158, 7.88708115, 1436.67908),
["Jungle"] = CFrame.new(-1249.77222, 11.8870859, 341.356476),
["Pirate Village"] = CFrame.new(-1122.34998, 4.78708982, 3855.91992),
["Desert"] = CFrame.new(1094.14587, 6.47350502, 4192.88721),
["Frozen Village"] = CFrame.new(1198.00928, 27.0074959, -1211.73376),
["MarineFord"] = CFrame.new(-4505.375, 20.687294, 4260.55908),
["Colosseum"] = CFrame.new(-1428.35474, 7.38933945, -3014.37305),
["Sky 1st Floor"] = CFrame.new(-4970.21875, 717.707275, -2622.35449),
["Sky 2st Floor"] = CFrame.new(-4813.0249, 903.708557, -1912.69055),
["Sky 3st Floor"] = CFrame.new(-7952.31006, 5545.52832, -320.704956),
["Prison"] = CFrame.new(4854.16455, 5.68742752, 740.194641),
["Magma Village"] = CFrame.new(-5231.75879, 8.61593437, 8467.87695),
["UndeyWater City"] = CFrame.new(61163.8516, 11.7796879, 1819.78418),
["Fountain City"] = CFrame.new(5132.7124, 4.53632832, 4037.8562),
["House Cyborg's"] = CFrame.new(6262.72559, 71.3003616, 3998.23047),
["Shank's Room"] = CFrame.new(-1442.16553, 29.8788261, -28.3547478),
["Mob Island"] = CFrame.new(-2850.20068, 7.39224768, 5354.99268),
}
-- NPC
NPC = {
["Random Devil Fruit"] = CFrame.new(-1436.19727, 61.8777695, 4.75247526, -0.557794094, 2.74216543e-08, 0.829979479, 5.83273234e-08, 1, 6.16037932e-09, -0.829979479, 5.18467118e-08, -0.557794094),
["Blox Fruits Dealer"] = CFrame.new(-923.255066, 7.67800522, 1608.61011, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Remove Devil Fruit"] = CFrame.new(5664.80469, 64.677681, 867.85907, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Ability Teacher"] = CFrame.new(-1057.67822, 9.65220833, 1799.49146, -0.865874112, -9.26330159e-08, 0.500262439, -7.33759435e-08, 1, 5.816689e-08, -0.500262439, 1.36579752e-08, -0.865874112),
["Dark Step"] = CFrame.new(-987.873047, 13.7778397, 3989.4978, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Electro"] = CFrame.new(-5389.49561, 13.283, -2149.80151, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Fishman Karate"] = CFrame.new(61581.8047, 18.8965912, 987.832703, 1, 0, 0, 0, 1, 0, 0, 0, 1),
}
elseif NewWorld then
Island = {
["First Spot"] = CFrame.new(82.9490662, 18.0710983, 2834.98779),
["Kingdom of Rose"] = game.Workspace["_WorldOrigin"].Locations["Kingdom of Rose"].CFrame,
["Dark Ares"] = game.Workspace["_WorldOrigin"].Locations["Dark Arena"].CFrame,
["Flamingo Mansion"] = CFrame.new(-390.096313, 331.886475, 673.464966),
["Flamingo Room"] = CFrame.new(2302.19019, 15.1778421, 663.811035),
["Green bit"] = CFrame.new(-2372.14697, 72.9919434, -3166.51416),
["Cafe"] = CFrame.new(-385.250916, 73.0458984, 297.388397),
["Factroy"] = CFrame.new(430.42569, 210.019623, -432.504791),
["Colosseum"] = CFrame.new(-1836.58191, 44.5890656, 1360.30652),
["Ghost Island"] = CFrame.new(-5571.84424, 195.182297, -795.432922),
["Ghost Island 2nd"] = CFrame.new(-5931.77979, 5.19706631, -1189.6908),
["Snow Mountain"] = CFrame.new(1384.68298, 453.569031, -4990.09766),
["Hot and Cold"] = CFrame.new(-6026.96484, 14.7461271, -5071.96338),
["Magma Side"] = CFrame.new(-5478.39209, 15.9775667, -5246.9126),
["Cursed Ship"] = CFrame.new(902.059143, 124.752518, 33071.8125),
["Frosted Island"] = CFrame.new(5400.40381, 28.21698, -6236.99219),
["Forgotten Island"] = CFrame.new(-3043.31543, 238.881271, -10191.5791),
["Usoapp Island"] = CFrame.new(4748.78857, 8.35370827, 2849.57959),
["Raids Low"] = CFrame.new(-5554.95313, 329.075623, -5930.31396),
["Minisky"] = CFrame.new(-260.358917, 49325.7031, -35259.3008),
}
-- NPC
NPC = {
["Dargon Berath"] = CFrame.new(703.372986, 186.985519, 654.522034, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Mtsterious Man"] = CFrame.new(-2574.43335, 1627.92371, -3739.35767, 0.378697902, -9.06400288e-09, 0.92552036, -8.95582009e-09, 1, 1.34578926e-08, -0.92552036, -1.33852689e-08, 0.378697902),
["Mysterious Scientist"] = CFrame.new(-6437.87793, 250.645355, -4498.92773, 0.502376854, -1.01223634e-08, -0.864648759, 2.34106086e-08, 1, 1.89508653e-09, 0.864648759, -2.11940012e-08, 0.502376854),
["Awakening Expert"] = CFrame.new(-408.098846, 16.0459061, 247.432846, 0.028394036, 6.17599138e-10, 0.999596894, -5.57905944e-09, 1, -4.59372484e-10, -0.999596894, -5.56376767e-09, 0.028394036),
["Nerd"] = CFrame.new(-401.783722, 73.0859299, 262.306702, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Bar Manager"] = CFrame.new(-385.84726, 73.0458984, 316.088806, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Blox Fruits Dealer"] = CFrame.new(-450.725464, 73.0458984, 355.636902, -0.780352175, -2.7266168e-08, 0.625340283, 9.78516468e-09, 1, 5.58128797e-08, -0.625340283, 4.96727601e-08, -0.780352175),
["Trevor"] = CFrame.new(-341.498322, 331.886444, 643.024963, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Plokster"] = CFrame.new(-1885.16016, 88.3838196, -1912.28723, -0.513468027, 0, 0.858108759, 0, 1, 0, -0.858108759, 0, -0.513468027),
["Enhancement Editor"] = CFrame.new(-346.820221, 72.9856339, 1194.36218, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Pirate Recruiter"] = CFrame.new(-428.072998, 72.9495239, 1445.32422, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Marines Recruiter"] = CFrame.new(-1349.77295, 72.9853363, -1045.12964, 0.866493046, 0, -0.499189168, 0, 1, 0, 0.499189168, 0, 0.866493046),
["Chemist"] = CFrame.new(-2777.45288, 72.9919434, -3572.25732, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Cyborg"] = CFrame.new(629.146851, 312.307373, -531.624146, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Ghoul Mark"] = CFrame.new(635.172546, 125.976357, 33219.832, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Guashiem"] = CFrame.new(937.953003, 181.083359, 33277.9297, 1, -8.60126406e-08, 3.81773896e-17, 8.60126406e-08, 1, -1.89969598e-16, -3.8177373e-17, 1.89969598e-16, 1),
["El Admin"] = CFrame.new(1322.80835, 126.345039, 33135.8789, 0.988783717, -8.69797603e-08, -0.149354503, 8.62223786e-08, 1, -1.15461916e-08, 0.149354503, -1.46101409e-09, 0.988783717),
["El Rodolfo"] = CFrame.new(941.228699, 40.4686775, 32778.9922, -0.818029106, -1.19524382e-08, 0.575176775, -1.28741648e-08, 1, 2.47053866e-09, -0.575176775, -5.38394795e-09, -0.818029106),
["Arowe"] = CFrame.new(-1994.51038, 125.519142, -72.2622986, -0.16715166, -6.55417338e-08, -0.985931218, -7.13315558e-08, 1, -5.43836585e-08, 0.985931218, 6.12376851e-08, -0.16715166),
} 
elseif ThreeWorld then
Island = {
["Prot Town"] = CFrame.new(-287, 30, 5388),
["Hydar Island"] = CFrame.new(3399.32227, 72.4142914, 1572.99963, -0.809679806, -4.48284467e-08, 0.586871922, 2.42332163e-08, 1, 1.09818842e-07, -0.586871922, 1.0313989e-07, -0.809679806),
["Room Enma/Yama & Secret Temple"] = CFrame.new(5247, 7, 1097),
["House Hydar Island"] = CFrame.new(5245, 602, 251),
["Great Tree"] = CFrame.new(2443, 36, -6573),
["Castle on the sea"] = CFrame.new(-5500, 314, -2855),
["Mansion"] = CFrame.new(-12548, 337, -7481),
["Floating Turtlea"] = CFrame.new(-10016, 332, -8326),
["Haunted Castle"] = CFrame.new(-9509.34961, 142.130661, 5535.16309),
["Peanut Island"] = CFrame.new(-2131, 38, -10106),
["Ice Cream Island"] = CFrame.new(-950, 59, -10907),
["CakeLoaf"] = CFrame.new(-1762, 38, -11878)
}
-- NPC
NPC = {
["Random Devil Fruit"] = CFrame.new(-12491, 337, -7449),
["Blox Fruits Dealer"] = CFrame.new(-12511, 337, -7448),
["Remove Devil Fruit"] = CFrame.new(-5571, 1089, -2661),
["Horned Man"] = CFrame.new(-11890, 931, -8760),
["Hungey Man"] = CFrame.new(-10919, 624, -10268),
["Previous Hero"] = CFrame.new(-10368, 332, -10128),
["Butler"] = CFrame.new(-5125, 316, -3130),
["Lunoven"] = CFrame.new(-5117, 316, -3093),
["Elite Hunter"] = CFrame.new(-5420, 314, -2828),
["Player Hunter"] = CFrame.new(-5559, 314, -2840),
["Uzoth"] = CFrame.new(-9785, 852, 6667),
}
end
SelectedNPC = ""
SelectedIsland = ""
TeleportTab:Label("Teleport Island")
TeleportTab:NewDropdown("Selected Island",Island,0,function(a)
SelectedIsland = a
end)
function tweenTarget(targetPos, targetCFrame)
local tweenfunc = {}
local tween_s = game:service"TweenService"
local info = TweenInfo.new((targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/325, Enum.EasingStyle.Linear)
local tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = targetCFrame * CFrame.fromAxisAngle(Vector3.new(1,0,0), math.rad(0))})
tween:Play()

function tweenfunc:Stop()
tween:Cancel()
return tween
end

if not tween then return tween end
return tweenfunc
end
spawn(function()
while true do wait()
if TweenIsland then
TweenIslandWork = tweenTarget(Island[SelectedIsland].Position,Island[SelectedIsland])
if (Island[SelectedIsland].Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if TweenIslandWork then
TweenIslandWork:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Island[SelectedIsland]
end
end
if TweenNPC then
TweenNPCWork = tweenTarget(NPC[SelectedNPC].Position,Island[SelectedIsland])
if (Island[SelectedIsland].Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if TweenNPCWork then
TweenNPCWork:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Island[SelectedIsland]
end
end
end
end)
TeleportTab:Toggle("Teleport Island",false,function(a)
TweenIsland = a
if not TweenIsland then
if TweenIslandWork then
TweenIslandWork:Stop()
end
end
end)
TeleportTab:Label("Teleport NPCs")
TeleportTab:NewDropdown("Selected NPC",NPC,0,function(a)
SelectedNPC = a
end)
TeleportTab:Toggle("Teleport NPC",false,function(a)
TweenNPC = a
if not TweenNPC then
if TweenNPCWork then
TweenNPCWork:Stop()
end
end
end)
----------------------------------------------------------------------------------------------------------------------------
local PlayerEspTab = Main:Tab("Players - Esp")

local SelectedPly = PlayerEspTab:Label("Selected Player : nil")
PlayerName = {}
for i,v in pairs(game.Players:GetChildren()) do  
table.insert(PlayerName ,v.Name)
end
SelectedKillPlayer = ""
local Player = PlayerEspTab:Dropdown("Selected Player",PlayerName,0,function(plys) --true/false, replaces the current title "Dropdown" with the option that t
SelectedKillPlayer = plys
SelectedPly:Refresh("Selected Player : "..SelectedKillPlayer)
end)
PlayerEspTab:Button("Refrsh Player",function()
PlayerName = {}
for i,v in pairs(game.Players:GetChildren()) do  
table.insert(PlayerName ,v.Name)
end
Player:Refresh(PlayerName,0)
end)
PlayerEspTab:Toggle("Kill Player",false,function(bool)
KillPlayer = bool
end)

PlayerEspTab:Toggle("Bounty Hop Only Melee",getgenv().Setting["Bounty Hop"],function(bool)
BountyHop = bool
end)

spawn(function()
while wait() do
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
if v:IsA("Tool") then
if v:FindFirstChild("RemoteFunctionShoot") then 
_G.WeaponUseKillGun = v.Name
end
end
end
end
end)

spawn(function()
game:GetService("RunService").Heartbeat:connect(function()
pcall(function()
if BountyHop == true or _G.HopServerOn == true then
if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
if syn then
game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
else
for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
if v:IsA("BasePart") then
v.CanCollide = false    
end
end
end
end
end
end)
end)
end)

spawn(function()
while wait() do
pcall(function()
if BountyHop then
wait(120)
_G.HopServerOn = true
end
end)
end
end)

spawn(function()
while wait(1) do
pcall(function()
if BountyHop then
if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.PvpDisabled.Visible == true then
local args = {
[1] = "EnablePvp"
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end
end)
end
end)
spawn(function()
if BountyHop then
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
end
end
end)

spawn(function()
while wait(1) do
pcall(function()
if BountyHop then
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
end
end
end)
end
end)

spawn(function()
while wait() do
pcall(function()
if BountyHop then
game:GetService'VirtualUser':CaptureController()
game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
end
end)
end
end)

spawn(function()
while wait(1) do
if BountyHop then
if OldWorld then
game.Players.LocalPlayer:Kick("Not Support First Sea")
break
end
end
end
end)
_G.GodModeOn = false

spawn(function()
while wait() do
if BountyHop then
wait(.1)
if OldWorld then
game.Players.LocalPlayer:Kick("\n Not Support First Sea ")
end
if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("CrewBBG") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CrewBBG:Destroy()
end
wait(.1)
_G.GodModeOn = true
break
end
end
end)

if _G.DistancePlayers == nil then
_G.DistancePlayers = 10
end

killandhopsize = false

spawn(function()
while wait() do
pcall(function()
if BountyHop and killandhopsize then
for i, v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
if v.Name == NameKill then
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.Size = Vector3.new(120,120,120)
end
end
end
end)
end
end)

spawn(function()
while wait() do
if _G.SelectWeaponKillHop == nil or _G.SelectWeaponKillHop == "" then
for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if v.ToolTip == "Melee" then
_G.SelectWeaponKillHop = v.Name
end
end
for i ,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v.ToolTip == "Melee" then
_G.SelectWeaponKillHop = v.Name
end
end
end
end
end)

spawn(function()
while wait() do
pcall(function()
if BountyHop then
for i, v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
if game:GetService("Players")[v.Name].Data.Level.Value >= 1200 and v.Name ~= game.Players.LocalPlayer.Name and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
repeat game:GetService('RunService').Stepped:wait()
if _G.GodModeOn then
if game.Players.LocalPlayer.Backpack:FindFirstChild(_G.SelectWeaponKillHop) or game.Players.LocalPlayer.Character:FindFirstChild(_G.SelectWeaponKillHop) then
if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
end
EquipWeapon(_G.SelectWeaponKillHop)
spawn(function()
if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 75 then
game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
wait()
game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
end
end)
NameKill = v.Name
KillHealt = v.Humanoid.Health
MaxKillHealt = v.Humanoid.MaxHealth
killandhopsize = true
MytoTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,_G.DistancePlayers,-15))
end
end
until not v.Parent or not v or not v:FindFirstChild("Humanoid") or not v:FindFirstChild("HumanoidRootPart") or BountyHop == false or v.Humanoid.Health <= 0 or NextPlayer == true or _G.HopServerOn == true
NextPlayer = false
killandhopsize = false
end
end
elseif _G.HopServerOn == true then
repeat wait()
killandhopsize = false
MytoTarget(CFrame.new(-390.096313, 331.886475, 673.464966))
until BountyHop == false or _G.HopServerOn == false
end
end)
end
end)

spawn(function()
while wait() do
if _G.HopServerOn == true then
pcall(function()
BountyHop = false
killandhopsize = false
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
--[[
local File = pcall(function()
AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
table.insert(AllIDs, actualHour)
writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
]]
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(v.maxPlayers) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
local delFile = pcall(function()
-- delfile("NotSameServers.json")
AllIDs = {}
table.insert(AllIDs, actualHour)
end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(4)
end
end
end
end

function Teleport()
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end

Teleport()
end)
end
end
end)

PlayerEspTab:Toggle("Spectate Player",false,function(bool)
Sp = bool
local plr1 = game.Players.LocalPlayer.Character.Humanoid
local plr2 = game.Players:FindFirstChild(SelectedKillPlayer)
repeat wait(.1)
game.Workspace.Camera.CameraSubject = plr2.Character.Humanoid
until Sp == false 
game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end)
PlayerEspTab:Button("Teleport Player",function()
local plr1 = game.Players.LocalPlayer.Character
local plr2 = game.Players:FindFirstChild(SelectedKillPlayer)
plr1.HumanoidRootPart.CFrame = plr2.Character.HumanoidRootPart.CFrame
end)
PlayerEspTab:Line()
PlayerEspTab:Toggle("Aimbot Gun",false,function(bool)
if SelectedKillPlayer == "" and bool then
library:Notification("Select Player to Aim")
else
Aimbot = bool
end
end)
local lp = game:GetService('Players').LocalPlayer
local mouse = lp:GetMouse()
mouse.Button1Down:Connect(function()
if Aimbot and game.Players.LocalPlayer.Character:FindFirstChild(SelectToolWeaponGun) and game:GetService("Players"):FindFirstChild(SelectedKillPlayer) then
tool = game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun]
v17 = workspace:FindPartOnRayWithIgnoreList(Ray.new(tool.Handle.CFrame.p, (game:GetService("Players"):FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position - tool.Handle.CFrame.p).unit * 100), { game.Players.LocalPlayer.Character, workspace._WorldOrigin });
game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].RemoteFunctionShoot:InvokeServer(game:GetService("Players"):FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position, (require(game.ReplicatedStorage.Util).Other.hrpFromPart(v17)));
end 
end)
PlayerEspTab:Toggle("Aimbot Skill",false,function(bool)
if SelectedKillPlayer == "" and bool then
library:Notification("Select Player to Aim")
else
Skillaimbot = bool
end
end)
spawn(function()
while wait() do
if KillPlayer then
if game.Players:FindFirstChild(SelectedKillPlayer) and (game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude >= 300 then
KillTween = toTarget(game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position,game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.CFrame)
elseif game.Players:FindFirstChild(SelectedKillPlayer) and (game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude >= 300 then
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.CFrame * CFrame.new(0,25,0)
game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.CanCollide = false
game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Size = Vector3.new(50,50,50)
EquipWeapon(SelectToolWeaponGun)
if game.Players.LocalPlayer.Character:FindFirstChild(SelectToolWeaponGun) then
spawn(function()
pcall(function()
local args = {
[1] = v.HumanoidRootPart.Position,
[2] = v.HumanoidRootPart
}
game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].RemoteFunctionShoot:InvokeServer(unpack(args))
end)
end)
end 
end
end 
if Skillaimbot then
if game.Players:FindFirstChild(SelectedKillPlayer) and game.Players:FindFirstChild(SelectedKillPlayer).Character:FindFirstChild("HumanoidRootPart") and game.Players:FindFirstChild(SelectedKillPlayer).Character:FindFirstChild("Humanoid") and game.Players:FindFirstChild(SelectedKillPlayer).Character.Humanoid.Health > 0 then
AimBotSkillPosition = game.Players:FindFirstChild(SelectedKillPlayer).Character:FindFirstChild("HumanoidRootPart").Position
end
end
end
end)
-- ESP
function isnil(thing)
return (thing == nil)
end
local function round(n)
return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
for i,v in pairs(game:GetService'Players':GetChildren()) do
pcall(function()
if not isnil(v.Character) then
if ESPPlayer then
if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild('NameEsp'..Number) then
local bill = Instance.new('BillboardGui',v.Character.Head)
bill.Name = 'NameEsp'..Number
bill.ExtentsOffset = Vector3.new(0, 1, 0)
bill.Size = UDim2.new(1,200,1,30)
bill.Adornee = v.Character.Head
bill.AlwaysOnTop = true
local name = Instance.new('TextLabel',bill)
name.Font = "GothamBold"
name.FontSize = "Size14"
name.TextWrapped = true
name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' M')
name.Size = UDim2.new(1,0,1,0)
name.TextYAlignment = 'Top'
name.BackgroundTransparency = 1
name.TextStrokeTransparency = 0.5
if v.Team == game.Players.LocalPlayer.Team then
name.TextColor3 = Color3.new(0,255,0)
else
name.TextColor3 = Color3.new(255,0,0)
end
else
v.Character.Head['NameEsp'..Number].TextLabel.Text = (v.Name ..' | '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' M\nHealth : ' .. round(v.Character.Humanoid.Health*100/v.Character.Humanoid.MaxHealth) .. '%')
end
else
if v.Character.Head:FindFirstChild('NameEsp'..Number) then
v.Character.Head:FindFirstChild('NameEsp'..Number):Destroy()
end
end
end
end)
end
end
function UpdateChestChams() 
for i,v in pairs(game.Workspace:GetChildren()) do
pcall(function()
if string.find(v.Name,"Chest") then
if ChestESP then
if string.find(v.Name,"Chest") then
if not v:FindFirstChild('NameEsp'..Number) then
local bill = Instance.new('BillboardGui',v)
bill.Name = 'NameEsp'..Number
bill.ExtentsOffset = Vector3.new(0, 1, 0)
bill.Size = UDim2.new(1,200,1,30)
bill.Adornee = v
bill.AlwaysOnTop = true
local name = Instance.new('TextLabel',bill)
name.Font = "GothamBold"
name.FontSize = "Size14"
name.TextWrapped = true
name.Size = UDim2.new(1,0,1,0)
name.TextYAlignment = 'Top'
name.BackgroundTransparency = 1
name.TextStrokeTransparency = 0.5
if v.Name == "Chest1" then
name.TextColor3 = Color3.fromRGB(109, 109, 109)
name.Text = ("Chest 1" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
end
if v.Name == "Chest2" then
name.TextColor3 = Color3.fromRGB(173, 158, 21)
name.Text = ("Chest 2" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
end
if v.Name == "Chest3" then
name.TextColor3 = Color3.fromRGB(85, 255, 255)
name.Text = ("Chest 3" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
end
else
v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
end
end
else
if v:FindFirstChild('NameEsp'..Number) then
v:FindFirstChild('NameEsp'..Number):Destroy()
end
end
end
end)
end
end
function UpdateDevilChams() 
for i,v in pairs(game.Workspace:GetChildren()) do
pcall(function()
if DevilFruitESP then
if string.find(v.Name, "Fruit") then   
if not v.Handle:FindFirstChild('NameEsp'..Number) then
local bill = Instance.new('BillboardGui',v.Handle)
bill.Name = 'NameEsp'..Number
bill.ExtentsOffset = Vector3.new(0, 1, 0)
bill.Size = UDim2.new(1,200,1,30)
bill.Adornee = v.Handle
bill.AlwaysOnTop = true
local name = Instance.new('TextLabel',bill)
name.Font = "GothamBold"
name.FontSize = "Size14"
name.TextWrapped = true
name.Size = UDim2.new(1,0,1,0)
name.TextYAlignment = 'Top'
name.BackgroundTransparency = 1
name.TextStrokeTransparency = 0.5
name.TextColor3 = Color3.fromRGB(255, 0, 0)
name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
else
v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
end
end
else
if v.Handle:FindFirstChild('NameEsp'..Number) then
v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
end
end
end)
end
end
function UpdateFlowerChams() 
for i,v in pairs(game.Workspace:GetChildren()) do
pcall(function()
if v.Name == "Flower2" or v.Name == "Flower1" then
if FlowerESP then 
if not v:FindFirstChild('NameEsp'..Number) then
local bill = Instance.new('BillboardGui',v)
bill.Name = 'NameEsp'..Number
bill.ExtentsOffset = Vector3.new(0, 1, 0)
bill.Size = UDim2.new(1,200,1,30)
bill.Adornee = v
bill.AlwaysOnTop = true
local name = Instance.new('TextLabel',bill)
name.Font = "GothamBold"
name.FontSize = "Size14"
name.TextWrapped = true
name.Size = UDim2.new(1,0,1,0)
name.TextYAlignment = 'Top'
name.BackgroundTransparency = 1
name.TextStrokeTransparency = 0.5
name.TextColor3 = Color3.fromRGB(255, 0, 0)
if v.Name == "Flower1" then 
name.Text = ("Blue Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
name.TextColor3 = Color3.fromRGB(0, 0, 255)
end
if v.Name == "Flower2" then
name.Text = ("Red Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
name.TextColor3 = Color3.fromRGB(255, 0, 0)
end
else
v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
end
else
if v:FindFirstChild('NameEsp'..Number) then
v:FindFirstChild('NameEsp'..Number):Destroy()
end
end
end   
end)
end
end
function UpdateRealFruitChams() 
for i,v in pairs(game.Workspace.AppleSpawner:GetChildren()) do
if v:IsA("Tool") then
if RealFruitESP then 
if not v.Handle:FindFirstChild('NameEsp'..Number) then
local bill = Instance.new('BillboardGui',v.Handle)
bill.Name = 'NameEsp'..Number
bill.ExtentsOffset = Vector3.new(0, 1, 0)
bill.Size = UDim2.new(1,200,1,30)
bill.Adornee = v.Handle
bill.AlwaysOnTop = true
local name = Instance.new('TextLabel',bill)
name.Font = "GothamBold"
name.FontSize = "Size14"
name.TextWrapped = true
name.Size = UDim2.new(1,0,1,0)
name.TextYAlignment = 'Top'
name.BackgroundTransparency = 1
name.TextStrokeTransparency = 0.5
name.TextColor3 = Color3.fromRGB(255, 0, 0)
name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
else
v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
end
else
if v.Handle:FindFirstChild('NameEsp'..Number) then
v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
end
end 
end
end
for i,v in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
if v:IsA("Tool") then
if RealFruitESP then 
if not v.Handle:FindFirstChild('NameEsp'..Number) then
local bill = Instance.new('BillboardGui',v.Handle)
bill.Name = 'NameEsp'..Number
bill.ExtentsOffset = Vector3.new(0, 1, 0)
bill.Size = UDim2.new(1,200,1,30)
bill.Adornee = v.Handle
bill.AlwaysOnTop = true
local name = Instance.new('TextLabel',bill)
name.Font = "GothamBold"
name.FontSize = "Size14"
name.TextWrapped = true
name.Size = UDim2.new(1,0,1,0)
name.TextYAlignment = 'Top'
name.BackgroundTransparency = 1
name.TextStrokeTransparency = 0.5
name.TextColor3 = Color3.fromRGB(255, 174, 0)
name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
else
v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
end
else
if v.Handle:FindFirstChild('NameEsp'..Number) then
v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
end
end 
end
end
for i,v in pairs(game.Workspace.BananaSpawner:GetChildren()) do
if v:IsA("Tool") then
if RealFruitESP then 
if not v.Handle:FindFirstChild('NameEsp'..Number) then
local bill = Instance.new('BillboardGui',v.Handle)
bill.Name = 'NameEsp'..Number
bill.ExtentsOffset = Vector3.new(0, 1, 0)
bill.Size = UDim2.new(1,200,1,30)
bill.Adornee = v.Handle
bill.AlwaysOnTop = true
local name = Instance.new('TextLabel',bill)
name.Font = "GothamBold"
name.FontSize = "Size14"
name.TextWrapped = true
name.Size = UDim2.new(1,0,1,0)
name.TextYAlignment = 'Top'
name.BackgroundTransparency = 1
name.TextStrokeTransparency = 0.5
name.TextColor3 = Color3.fromRGB(251, 255, 0)
name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
else
v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
end
else
if v.Handle:FindFirstChild('NameEsp'..Number) then
v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
end
end 
end
end
end
PlayerEspTab:Line()
PlayerEspTab:Label("ESP")
PlayerEspTab:Toggle("ESP Player",espplyer,function(a)
ESPPlayer = a
UpdatePlayerChams()
end)
PlayerEspTab:Toggle("ESP Chest",espchest,function(a)
ChestESP = a
UpdateChestChams() 
end)
PlayerEspTab:Toggle("ESP Devil Fruit",espdevilfruit,function(a)
DevilFruitESP = a
UpdateDevilChams() 
end)
PlayerEspTab:Toggle("ESP Flower",espflower,function(a)
FlowerESP = a
UpdateFlowerChams() 
end)
PlayerEspTab:Toggle("ESP Real Fruit",esprealfruit,function(a)
RealFruitESP = a
UpdateRealFruitChams() 
end)
spawn(function()
while wait() do
if FlowerESP then
UpdateFlowerChams() 
end
if DevilFruitESP then
UpdateDevilChams() 
end
if ChestESP then
UpdateChestChams() 
end
if ESPPlayer then
UpdatePlayerChams()
end
if RealFruitESP then
UpdateRealFruitChams()
end
end
end)
----------------------------------------------------------------------------------------------------------------------------
local MiscTab = Main:Tab("Misc")

MiscTab:Label("Server Time")
Time = MiscTab:Label("Server Time")
local function UpdateTime()
local GameTime = math.floor(workspace.DistributedGameTime+0.5)
local Hour = math.floor(GameTime/(60^2))%24
local Minute = math.floor(GameTime/(60^1))%60
local Second = math.floor(GameTime/(60^0))%60
Time:Refresh("Hour : "..Hour.." Minute : "..Minute.." Second : "..Second)
end
spawn(function()
while true do
UpdateTime()
game:GetService("RunService").RenderStepped:Wait()
end
end)
MiscTab:Line()
MiscTab:Label("Auto Farm Level Lock")
LockLevelValue = 2300
OldLevel = game.Players.localPlayer.Data.Level.Value
MiscTab:Slider("Select Level Lock",1,LockLevelValue,LockLevelValue,nil,function(value)
LockLevelValue = value
end)
MiscTab:Toggle("Lock Level",locklevel,function(value)
LockLevel = value
end)
spawn(function()
while wait(.1) do
if LockLevel then
if game.Players.localPlayer.Data.Level.Value >= LockLevelValue then
game.Players.localPlayer:Kick("\n Auto Farm Completed Level : "..game.Players.localPlayer.Data.Level.Value.."\n Old Level : "..OldLevel.."\nUsername : "..game.Players.LocalPlayer.Name)
end
end
end
end)
MiscTab:Line()
MiscTab:Button("Join Pirates Team",function()
local args = {
[1] = "SetTeam",
[2] = "Pirates"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) 
local args = {
[1] = "BartiloQuestProgress"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
MiscTab:Button("Join Marines Team",function()
local args = {
[1] = "SetTeam",
[2] = "Marines"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
local args = {
[1] = "BartiloQuestProgress"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
local args = {
[1] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
MiscTab:Line()
MiscTab:Button("Check Ectoplasm",function()
VLib:Notification("You have "..game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","Check").." Ectoplasm")
end)
MiscTab:Button("Open Devil Shop",function()
local args = {
[1] = "GetFruits"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
game.Players.localPlayer.PlayerGui.Main.FruitShop.Visible = true
end)
MiscTab:Button("Open Inventory",function()
local args = {
[1] = "getInventoryWeapons"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
game.Players.localPlayer.PlayerGui.Main.Inventory.Visible = true
end)
MiscTab:Button("Open Fruit Inventory",function()
game.Players.localPlayer.PlayerGui.Main.FruitInventory.Visible = true
end)
MiscTab:Button("Open Color Haki",function()
game.Players.localPlayer.PlayerGui.Main.Colors.Visible = true
end)
MiscTab:Button("Open Title Name",function()
local args = {
[1] = "getTitles"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true
end)
MiscTab:Line()

local LocalPlayer = game:GetService'Players'.LocalPlayer
local originalstam = LocalPlayer.Character.Energy.Value
function infinitestam()
game:GetService'Players'.LocalPlayer.Character.Energy.Changed:connect(function()
if InfinitsEnergy then
LocalPlayer.Character.Energy.Value = originalstam
end 
end)
end
nododgecool = false
function NoDodgeCool()
if nododgecool then
for i,v in next, getgc() do
if game.Players.LocalPlayer.Character.Dodge then
if typeof(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character.Dodge then
for i2,v2 in next, getupvalues(v) do
if tostring(v2) == "0.4" then
repeat wait(.1)
setupvalue(v,i2,0)
until not nododgecool
end
end
end
end
end
end
end
function NoGeppoCool()
if noGeppocool then
for i,v in next, getgc() do
if game.Players.LocalPlayer.Character.Geppo then
if typeof(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character.Geppo then
for i2,v2 in next, getupvalues(v) do
if tostring(v2) == "0" then
repeat wait(.1)
setupvalue(v,i2,0)
until not noGeppocool
end
end
end
end
end
end
end
function NoSoruCool()
for i, v in pairs(getgc()) do
if type(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character:WaitForChild("Soru") then
for i2,v2 in pairs(debug.getupvalues(v)) do
if type(v2) == 'table' then
if v2.LastUse then
repeat wait()
setupvalue(v, i2, {LastAfter = 0,LastUse = 0})
until not Sorunocool
end
end
end
end
end
end
MiscTab:Button("Dodge No Cooldown",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/NightsTimeZ/Donate-Me/main/Thx.lua"))()
end)
MiscTab:Toggle("Dodge No Cooldown",false,function(Value)
nododgecool = Value
NoDodgeCool()
end)
MiscTab:Toggle("Soru No Cooldown",false,function(Value)
Sorunocool = Value
NoSoruCool()
end)
MiscTab:Toggle("Infinits Geppo",false,function(Value)
noGeppocool = Value
NoGeppoCool()
end)
MiscTab:Toggle("Infinits Energy",infengergy,function(value)
InfinitsEnergy = value
infinitestam()
end)
MiscTab:Toggle("Infinits Range observations haki",false,function(Value)
infobservations = Value
end)
spawn(function()
while wait() do
if infobservations then
game.Players.LocalPlayer.VisionRadius.Value = math.huge
end
end
end)
MiscTab:Toggle("Auto Click",autoclick,function(value)
AuctoClick = value
end)
spawn(function()
while wait() do
if AuctoClick then
Click()
end
end
end)
Fly = false  
function activatefly()
local mouse=game.Players.LocalPlayer:GetMouse''
localplayer=game.Players.LocalPlayer
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
local torso = game.Players.LocalPlayer.Character.HumanoidRootPart
local speedSET=25
local keys={a=false,d=false,w=false,s=false}
local e1
local e2
local function start()
local pos = Instance.new("BodyPosition",torso)
local gyro = Instance.new("BodyGyro",torso)
pos.Name="EPIXPOS"
pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
pos.position = torso.Position
gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
gyro.cframe = torso.CFrame
repeat
wait()
localplayer.Character.Humanoid.PlatformStand=true
local new=gyro.cframe - gyro.cframe.p + pos.position
if not keys.w and not keys.s and not keys.a and not keys.d then
speed=1
end
if keys.w then
new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+speedSET
end
if keys.s then
new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+speedSET
end
if keys.d then
new = new * CFrame.new(speed,0,0)
speed=speed+speedSET
end
if keys.a then
new = new * CFrame.new(-speed,0,0)
speed=speed+speedSET
end
if speed>speedSET then
speed=speedSET
end
pos.position=new.p
if keys.w then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*15),0,0)
elseif keys.s then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*15),0,0)
else
gyro.cframe = workspace.CurrentCamera.CoordinateFrame
end
until not Fly
if gyro then 
gyro:Destroy() 
end
if pos then 
pos:Destroy() 
end
flying=false
localplayer.Character.Humanoid.PlatformStand=false
speed=0
end
e1=mouse.KeyDown:connect(function(key)
if not torso or not torso.Parent then 
flying=false e1:disconnect() e2:disconnect() return 
end
if key=="w" then
keys.w=true
elseif key=="s" then
keys.s=true
elseif key=="a" then
keys.a=true
elseif key=="d" then
keys.d=true
end
end)
e2=mouse.KeyUp:connect(function(key)
if key=="w" then
keys.w=false
elseif key=="s" then
keys.s=false
elseif key=="a" then
keys.a=false
elseif key=="d" then
keys.d=false
end
end)
start()
end
MiscTab:Toggle("Fly",false,function(Value)
Fly = Value
activatefly()
end)
MiscTab:Toggle("No Clip",false,function(value)
NoClip = value
end)
if game.workspace:FindFirstChild("WaterWalk") then
game.workspace:FindFirstChild("WaterWalk"):Destroy()
end
platform = Instance.new("Part")
platform.Name = "WaterWalk"
platform.Size = Vector3.new(math.huge, 1, math.huge)
platform.Transparency = 1
platform.Anchored = true
platform.Parent = game.workspace
MiscTab:Toggle("Water Walk",waterwalk,function(value)
WaterWalk = value
end)
spawn(function()
while wait() do
if WaterWalk then
platform.CanCollide = true
platform.Position = Vector3.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Y * 0 -5, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Z)
else
platform.CanCollide = false
platform.Position = Vector3.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Y * 0 -6, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Z)
end
end
end)
MiscTab:Button("Remove Lave",function()
for i,v in pairs(game.Workspace:GetDescendants()) do
if v.Name == "Lava" then   
v:Destroy()
end
end
for i,v in pairs(game.ReplicatedStorage:GetDescendants()) do
if v.Name == "Lava" then   
v:Destroy()
end
end
end)
MiscTab:Button("Redeem All Code",function()
function UseCode(Text)
game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
end
UseCode("SUB2GAMERROBOT_EXP1")
UseCode("StrawHatMaine")
UseCode("Sub2OfficialNoobie")
UseCode("FUDD10")
UseCode("BIGNEWS")
UseCode("THEGREATACE")
UseCode("SUB2NOOBMASTER123")
UseCode("Sub2Daigrock")
UseCode("Axiore")
UseCode("TantaiGaming")
UseCode("STRAWHATMAINE")
UseCode("Enyu_is_Pro")
UseCode("Magicbus")
UseCode("Sub2Fer999")
UseCode("JCWK")
UseCode("kittgaming")
UseCode("Bluxxy")	

end)

MiscTab:Button("FPS Boost",function()
local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(g:GetDescendants()) do
if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
v.Material = "Plastic"
v.Reflectance = 0
elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
v.Transparency = 1
elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
v.Lifetime = NumberRange.new(0)
elseif v:IsA("Explosion") then
v.BlastPressure = 1
v.BlastRadius = 1
elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
v.Enabled = false
elseif v:IsA("MeshPart") then
v.Material = "Plastic"
v.Reflectance = 0
v.TextureID = 10385902758728957
end
end
for i, e in pairs(l:GetChildren()) do
if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
e.Enabled = false
end
end
end)
----------------------------------------------------------------------------------------------------------------------------
local RaidsTab = Main:Tab("Raids")
RaidsTab:Label("Use In Raid Only",true)
Distance = 500
RaidsTab:Toggle("Kill Arua",killaura,function(value)
if NewWorld or ThreeWorld then
RaidsArua = value
elseif OldWorld then
VLib:Notification("Use In New World")
end
end)
RaidsTab:Toggle("Auto Next Island",autonextisland,function(value)
if NewWorld or ThreeWorld then
NextIsland = value
elseif OldWorld then
VLib:Notification("Use In New World")
end
end)
RaidsTab:Toggle("Auto Awakener",autoAwakener,function(value)
if NewWorld or ThreeWorld then
Awakener = value
elseif OldWorld then
VLib:Notification("Use In New World")
end
end)
spawn(function()
while wait() do
if Awakener and (game:GetService("Workspace")["_WorldOrigin"].Locations["l'Ã‰glise de ProphÃ©tie"].Position - game.Players.localPlayer.Character.HumanoidRootPart.Position).magnitude <= 100 then
local string_1 = "Awakener";
local string_2 = "Check";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);

local string_1 = "Awakener";
local string_2 = "Awaken";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
end
end
end)
RaidsTab:Button("Dungeon",function()
if NewWorld then
if StatsBypassTP == "Bypassed" and UseTP then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6438.73535, 250.645355, -4501.50684)
else
TP(CFrame.new(-6438.73535, 250.645355, -4501.50684))
end
elseif ThreeWorld then
if StatsBypassTP == "Bypassed" and UseTP then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5013.64941, 314.843842, -2817.8042)
else
TP(CFrame.new(-5013.64941, 314.843842, -2817.8042))
end
elseif OldWorld then
VLib:Notification("Use In New World","Button")
end
end)
RaidsTab:Button("Awakening Room",function()
if NewWorld then
if StatsBypassTP == "Bypassed" and UseTP then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations["l'Ã‰glise de ProphÃ©tie"].CFrame
else
TP(CFrame.new(266.227783, 1.39509034, 1857.00732))
end
elseif ThreeWorld then
if StatsBypassTP == "Bypassed" and UseTP then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations["l'Ã‰glise de ProphÃ©tie"].CFrame
else
TP(CFrame.new(266.227783, 1.39509034, 1857.00732))
end
elseif OldWorld then
VLib:Notification("Use In New World","Button")
end
end)
function TP(P)
NoClip = true
Distance = (P.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
if Distance < 10 then
Speed = 1000
elseif Distance < 170 then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
Speed = 350
elseif Distance < 1000 then
Speed = 350
elseif Distance >= 1000 then
Speed = 250
end
game:GetService("TweenService"):Create(
game.Players.LocalPlayer.Character.HumanoidRootPart,
TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
{CFrame = P}
):Play()
NoClip = false
end
RaidsTab:Line()
RaidsTab:Label("Auto Raids")
RaidsSelected = selectraids or ""
Raidslist = {}
RaidsModule = require(game.ReplicatedStorage.Raids)
for i,v in pairs(RaidsModule.raids) do
table.insert(Raidslist,v)
end
for i,v in pairs(RaidsModule.advancedRaids) do
table.insert(Raidslist,v)
end
RaidsTab:Dropdown("Select Raids",Raidslist,0,function(A)
RaidsSelected = A
end)
RaidsTab:Toggle("Auto Raids",autoraids,function(A)
if OldWorld then
VLib:Notification("Use In New World & Thire World")
else
if RaidsSelected == "" and A then
VLib:Notification("Select Auto Raids First")
else
AutoRaids = A
end
end
end)
InRaids = true
spawn(function()
while wait() do
if NextIsland then
if StatsBypassTP == "Bypassed" and UseTP and ( game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") ) then
if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame
end
else
if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.z)
if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").Position,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame)
elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame
end
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.z)
if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").Position,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame)
elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame
end
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.z)

if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").Position,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame)
elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame
end
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.z)

if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").Position,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame)
elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame
end
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.z)
if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame)
elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame
end
end
end
end
if RaidsArua then
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if RaidsArua and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 400 then
pcall(function()
repeat wait()
v.Humanoid.Health = 0
until not RaidsArua or v.Humanoid.Health <= 0 or not v.Parent
end)
end
end
end
if AutoRaids then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then

if NewWorld then
fireclickdetector(Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
elseif ThreeWorld then
fireclickdetector(Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
end
wait(16)
elseif game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then
Useraids = true
pcall(function()
repeat wait()
if StatsBypassTP == "Bypassed" and UseTP and ( game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") ) then
if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame
end
else
if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.z)
if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").Position,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame)
elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame
end
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.z)
if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").Position,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame)
elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame
end
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.z)

if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").Position,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame)
elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame
end
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.z)

if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").Position,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame)
elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame
end
elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.z)
if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
Farmtween = toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame)
elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
if Farmtween then
Farmtween:Stop()
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame
end
end
end
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if AutoRaids and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 400 then
pcall(function()
repeat wait()
v.HumanoidRootPart.Transparency = 0.75
v.Humanoid.Health = 0
until not AutoRaids or v.Humanoid.Health <= 0 or not v.Parent
end)
end
end
until AutoRaids == false or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") or game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false
end)
end
else
Useraids = false
local args = {
[1] = "RaidsNpc",
[2] = "Select",
[3] = RaidsSelected
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
end
end
end)
----------------------------------------------------------------------------------------------------------------------------
local ShopTab = Main:Tab("Shop")
if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("Candies","Check") then
ShopTab:Label("Candy",true)
local string_1 = "Candies";
local string_2 = "Check";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
BonePoint = ShopTab:Label("You Have ".. Target:InvokeServer(string_1, string_2) .." Candy",true)
spawn(function()
while wait() do
BonePoint:Refresh("You Have ".. Target:InvokeServer(string_1, string_2) .." Candy")
end
end)
local v237, v238 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Candies", "Check");
for i,v in pairs(v238[1]) do
ShopTab:Button(v[1] .. " [ ".. v[2] .. " Candy ]",function()
local args = {
[1] = "Candies",
[2] = "Buy",
[3] = 1,
[4] = i
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
end
for i,v in pairs(v238[2]) do
ShopTab:Button(v[1] .. " [ ".. v[2] .. " Candy ]",function()
local args = {
[1] = "Candies",
[2] = "Buy",
[3] = 2,
[4] = i
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
end
for i,v in pairs(v238[3]) do
ShopTab:Button(v[1] .. " [ ".. v[2] .. " Candy ]",function()
local args = {
[1] = "Candies",
[2] = "Buy",
[3] = 3,
[4] = i
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
end
ShopTab:Line()
end
ShopTab:Label("Abilities",true)
ShopTab:Button("Skyjump [ $10,000 Beli ]",function()
local args = {
[1] = "BuyHaki",
[2] = "Geppo"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Buso Haki [ $25,000 Beli ]",function()
local args = {
[1] = "BuyHaki",
[2] = "Buso"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Observation haki [ $750,000 Beli ]",function()
local args = {
[1] = "KenTalk",
[2] = "Buy"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Soru [ $100,000 Beli ]",function()
local args = {
[1] = "BuyHaki",
[2] = "Soru"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Buy Random Devil Fruit",function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
end)
ShopTab:Toggle("Auto Random Devil Fruit",false,function(v)
DevilAutoBuy = v
end)
spawn(function()
while wait() do 
if DevilAutoBuy then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
end
end
end)
ShopTab:Line()
ShopTab:Label("Fighting Style",true)
ShopTab:Button("Black Leg",function()
local args = {
[1] = "BuyBlackLeg"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Electro",function()
local args = {
[1] = "BuyElectro"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Fishman Karate",function()
local args = {
[1] = "BuyFishmanKarate"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Dragon Claw",function()
local args = {
[1] = "BlackbeardReward",
[2] = "DragonClaw",
[3] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Superhuman",function()
local args = {
[1] = "BuySuperhuman"
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Death Step",function()
local args = {
[1] = "BuyDeathStep"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Sharkman Karate",function()
local args = {
[1] = "BuySharkmanKarate",
[2] = true
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
local args = {
[1] = "BuySharkmanKarate"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Electric Claw",function()
local string_1 = "BuyElectricClaw";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1);
end)
ShopTab:Button("Dragon Talon",function()
local string_1 = "BuyDragonTalon";
local bool_1 = true;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, bool_1);
local string_1 = "BuyDragonTalon";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1);
end)
ShopTab:Line()
ShopTab:Label("Sword",true)
ShopTab:Button("Katana [ $1,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Katana"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Cutlass [ $1,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Cutlass"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)  
ShopTab:Button("Dual Katana [ $12,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Dual Katana"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Iron Mace [ $25,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Iron Mace"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Triple Katana [ $60,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Triple Katana"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Pipe [ $100,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Pipe"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Soul Cane [ $750,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Soul Cane"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Dual-Headed Blade [ $400,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Dual-Headed Blade"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Bisento [ $1,200,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Bisento"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Pole v.2 [ 5,000 Fragments )",function()
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk")
end)
ShopTab:Line()
ShopTab:Label("Gun",true)
ShopTab:Button("Slingshot [ $5,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Slingshot"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Musket [ $8,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Musket"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Flintlock [ $10,500 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Flintlock"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Refined Slingshot [ $30,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Refined Slingshot"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Refined Flintlock [ $65,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Refined Flintlock"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Kabucha [ 1,500 Fragments)",function()
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2")
end)
ShopTab:Line()
ShopTab:Label("Accessories",true)
ShopTab:Button("Black Cape [ $50,000 Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Black Cape"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Swordsman Hat [ 150k Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Swordsman Hat"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Tomoe Ring [ $500k Beli ]",function()
local args = {
[1] = "BuyItem",
[2] = "Tomoe Ring"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Line()
ShopTab:Label("Race & etc.",true)
ShopTab:Button("Race Ghoul",function()
local args = {
[1] = "Ectoplasm",
[2] = "BuyCheck",
[3] = 4
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
local args = {
[1] = "Ectoplasm",
[2] = "Change",
[3] = 4
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Race Cyborg",function()
local args = {
[1] = "CyborgTrainer",
[2] = "Buy"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Random Race (Use 3K Fragments)",function()
local args = {
[1] = "BlackbeardReward",
[2] = "Reroll",
[3] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
ShopTab:Button("Reset Stats (Use 2.5K Fragments)",function()
local args = {
[1] = "BlackbeardReward",
[2] = "Refund",
[3] = "2"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)

----------------------------------------------------------------------------------------------------------------------------
local Devil_Fruit_Sniper_Tab = Main:Tab("Devil Fruit Sniper")
local Remote_GetFruits = game.ReplicatedStorage:FindFirstChild("Remotes").CommF_:InvokeServer("GetFruits");
Table_DevilFruitSniper = {}
ShopDevilSell = {}
for i,v in next,Remote_GetFruits do
table.insert(Table_DevilFruitSniper,v.Name)
if v.OnSale then 
table.insert(ShopDevilSell,v.Name)
end
end
Devil_Fruit_Sniper_Tab:Label("Devil Fruit Sniper")
SelectDevil = ""
Devil_Fruit_Sniper_Tab:Dropdown("Select Devil Fruit Sniper",Table_DevilFruitSniper,0,function(a)
SelectDevil = a
end)
Devil_Fruit_Sniper_Tab:Toggle("Buy Devil Fruit Sinper",false,function(value)
if SelectDevil == "" and value then
VLib:Notification("Select Devil Fruit")
else
BuyFruitSinper = value
end	
end)
Devil_Fruit_Sniper_Tab:Toggle("Bring Devil Fruit",bringdevilfruit,function(value)
TeleportDF = value
end)
Devil_Fruit_Sniper_Tab:Button("Buy Random Devil Fruit",function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
end)
Devil_Fruit_Sniper_Tab:Toggle("Auto Random Devil Fruit",false,function(v)
DevilAutoBuy = v
end)
spawn(function()
while wait() do
if BuyFruitSinper then
local string_1 = "PurchaseRawFruit";
local string_2 = SelectDevil;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
end   
if TeleportDF then
for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
if v:IsA("Tool") and string.find(v.Name,"Fruit") then wait(5)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)    
end
end
end                              
end
end)
Devil_Fruit_Sniper_Tab:Line()
Devil_Fruit_Sniper_Tab:Label("Shop Devil Sell")
SelectedShopDevilSell = ""
local RefreshDevilFruitShop = Devil_Fruit_Sniper_Tab:Dropdown("Shop Devil Sell Now",ShopDevilSell,0,function(a)
SelectedShopDevilSell = a
end)
Devil_Fruit_Sniper_Tab:Button("Buy Devil Fruit",function()
local string_1 = "PurchaseRawFruit";
local string_2 = SelectedShopDevilSell;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
end)

local function RemoveSpaces(str)
return str:gsub(" Fruit", "")
end
Devil_Fruit_Sniper_Tab:Toggle("Auto Store Fruits",false,function(a)
AutoStoreFruits = a
if AutoStoreFruits then
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if string.find(v.Name,"Fruit") then
local FruitName = RemoveSpaces(v.Name)
if v.Name == "Bird: Falcon Fruit" then
NameFruit = "Bird-Bird: Falcon"
elseif v.Name == "Bird: Phoenix Fruit" then
NameFruit = "Bird-Bird: Phoenix"
elseif v.Name == "Human: Buddha Fruit" then
NameFruit = "Human-Human: Buddha"
else
NameFruit = FruitName.."-"..FruitName
end
end
end

local string_1 = "StoreFruit";
local string_2 = NameFruit;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
end
end)
spawn(function()
while wait() do
if AutoStoreFruits then wait()
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if string.find(v.Name,"Fruit") then
local FruitName = RemoveSpaces(v.Name)
if v.Name == "Bird: Falcon Fruit" then
NameFruit = "Bird-Bird: Falcon"
elseif v.Name == "Bird: Phoenix Fruit" then
NameFruit = "Bird-Bird: Phoenix"
elseif v.Name == "Human: Buddha Fruit" then
NameFruit = "Human-Human: Buddha"
else
NameFruit = FruitName.."-"..FruitName
end

local string_1 = "getInventoryFruits";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
for i1,v1 in pairs(Target:InvokeServer(string_1)) do
if v1.Name == NameFruit then
HaveFruitInStore = true
end
end
if not Have then
local string_1 = "StoreFruit";
local string_2 = NameFruit;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
end
HaveFruitInStore = false
end
end
end
end
end)
Devil_Fruit_Sniper_Tab:Line()
Devil_Fruit_Sniper_Tab:Label("List Store Fruits")

local string_1 = "getInventoryFruits";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
TabelDevilFruitStore = {}
for i,v in pairs(Target:InvokeServer(string_1)) do
for i1,v1 in pairs(v) do
if i1 == "Name" then 
table.insert(TabelDevilFruitStore,v1)
end
end
end

SelectedShopDevilStore = ""
local RefreshDevilFruitStore = Devil_Fruit_Sniper_Tab:Dropdown("List Store Fruits",TabelDevilFruitStore,0,function(a)
SelectedShopDevilStore = a
end)
Devil_Fruit_Sniper_Tab:Button("Load Store Devil Fruits Sele",function()
local string_1 = "LoadFruit";
local string_2 = SelectedShopDevilStore;
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
Target:InvokeServer(string_1, string_2);
end)

spawn(function()
while wait() do
local string_1 = "getInventoryFruits";
local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
TabelDevilFruitStore = {}
ShopDevilSell = {}
for i,v in next,Remote_GetFruits do
if v.OnSale then 
table.insert(ShopDevilSell,v.Name)
end
end
for i,v in pairs(Target:InvokeServer(string_1)) do
for i1,v1 in pairs(v) do
if i1 == "Name" then 
table.insert(TabelDevilFruitStore,v1)
end
end
end
wait(20)
RefreshDevilFruitShop:Refresh(ShopDevilSell,0)
RefreshDevilFruitStore:Refresh(TabelDevilFruitStore,0)
end
end)









----------------------------------------------------------------------------------------------------------------------------
local SettingTab = Main:Tab("Setting")
SettingTab:Button("Rejoin",function()
local ts = game:GetService("TeleportService")
local p = game:GetService("Players").LocalPlayer
ts:Teleport(game.PlaceId, p)
end)
local function HttpGet(url)
return game:GetService("HttpService"):JSONDecode(htgetf(url))
end
SettingTab:Button("Server Hop",function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(v.maxPlayers) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
local delFile = pcall(function()
-- delfile("NotSameServers.json")
AllIDs = {}
table.insert(AllIDs, actualHour)
end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(4)
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
end)
Server_Hop_LessPeople = SettingTab:Button("Server Hop (Less People)",function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
local Site;
if foundAnything == "" then
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
else
Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
end
local ID = ""
if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
foundAnything = Site.nextPageCursor
end
local num = 0;
for i,v in pairs(Site.data) do
local Possible = true
ID = tostring(v.id)
if tonumber(2) > tonumber(v.playing) then
for _,Existing in pairs(AllIDs) do
if num ~= 0 then
if ID == tostring(Existing) then
Possible = false
end
else
if tonumber(actualHour) ~= tonumber(Existing) then
local delFile = pcall(function()
-- delfile("NotSameServers.json")
AllIDs = {}
table.insert(AllIDs, actualHour)
end)
end
end
num = num + 1
end
if Possible == true then
table.insert(AllIDs, ID)
wait()
pcall(function()
-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
wait()
game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
end)
wait(1)
end
end
end
end
function Teleport() 
while wait() do
pcall(function()
TPReturner()
if foundAnything ~= "" then
TPReturner()
end
end)
end
end
Teleport()
end)
-- Server_Hop_LessPeople:Lock()
SettingTab:Line()
SettingTab:Button("Join discord",function()
local request = request or http_request or (syn and syn.request)
if not request then return end
local start = 6463
local invCode = 'jc66tSJzEF'
for i = start-10, start+1 do
spawn(function()
pcall(function()
request({Url = "http://127.0.0.1:"..tostring(i).."/rpc?v=1",Method = "POST",Headers = {["Content-Type"] = "application/json",["Origin"] = "https://discord.com"},Body = game:GetService("HttpService"):JSONEncode({["cmd"] = "INVITE_BROWSER",["nonce"] = game:GetService("HttpService"):GenerateGUID(false),["args"] = {["invite"] = {["code"] = invCode,},["code"] = invCode}})})
end)
end)
end
end)
SettingTab:DestroyGui()

local SecretTab = Main:Tab("Main Pvp",true)






SecretTab:Toggle("AimbotSkillFull",false,function(a)
AimBotFullFunction = a
end)

SecretTab:Toggle("Show Fov",false,function(a)
ShowFov = a
end)

_G.FOVSize = 200

SecretTab:Slider("Fov Size",1,700,_G.FOVSize,nil,function(v)
_G.FOVSize = v
end)
local SecretTab = Main:Tab("Info",true)
local ServerTimer = SecretTab:Label('อัพเดชล่าสุดเมื่อ:24/7/22')
local ServerTimer = SecretTab:Label('Facebook:Ruswe Ovz ')
local ServerTimer = SecretTab:Label('อยู่ในขั้นตอนการพัตนาต่อไปเรื่อยๆ') 


local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()
Mouse.Button1Down:connect(
function()
if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
return
end
if not Mouse.Target then
return
end
if CTRL then
Plr.Character:MoveTo(Mouse.Hit.p)
end
end)

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 460
FOVCircle.Filled = false
FOVCircle.Transparency = 0.5
FOVCircle.Radius = 200
FOVCircle.Color = Color3.fromRGB(255, 0, 0)

game:GetService("RunService").Stepped:Connect(function()
FOVCircle.Radius = _G.FOVSize
FOVCircle.Thickness = 1
FOVCircle.NumSides = 11
FOVCircle.Position = game:GetService('UserInputService'):GetMouseLocation()
if ShowFov then
FOVCircle.Visible = true
else
FOVCircle.Visible = false
end
end)

local lp = game:GetService('Players').LocalPlayer
local mouse = lp:GetMouse()
spawn(function()
while wait() do
if AimBotFullFunction then
pcall(function()
local MaxDist, Closest = math.huge
for i,v in pairs(game:GetService("Players"):GetChildren()) do 
local Head = v.Character:FindFirstChild("HumanoidRootPart")
local Pos, Vis = game.Workspace.CurrentCamera.WorldToScreenPoint(game.Workspace.CurrentCamera, Head.Position)
local MousePos, TheirPos = Vector2.new(mouse.X, mouse.Y), Vector2.new(Pos.X, Pos.Y)
local Dist = (TheirPos - MousePos).Magnitude
if Dist < MaxDist and Dist <= _G.FOVSize and v.Name ~= game.Players.LocalPlayer.Name then
MaxDist = Dist
_G.CharacterAimBot = v
end
end
end)
end
end
end)

spawn(function()
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg,false)
gg.__namecall = newcclosure(function(...)
local method = getnamecallmethod()
local args = {...}
if tostring(method) == "FireServer" then
if tostring(args[1]) == "RemoteEvent" then
if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
if AimBotFullFunction then
args[2] = _G.CharacterAimBot.Character.HumanoidRootPart.Position
return old(unpack(args))
end
end
end
end
return old(...)
end)
end)
spawn(function()
while wait() do
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
if v:IsA("Tool") then
if v:FindFirstChild("RemoteFunctionShoot") then 
SelectToolWeaponGun = v.Name
end
end
end
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
if v:IsA("Tool") then
if v:FindFirstChild("RemoteFunctionShoot") then 
SelectToolWeaponGun = v.Name
end
end
end
end
end)

spawn(function()
mouse.Button1Down:Connect(function()
if SelectToolWeaponGun ~= nil then
if AimBotFullFunction and game.Players.LocalPlayer.Character:FindFirstChild(SelectToolWeaponGun) and game:GetService("Players"):FindFirstChild(_G.CharacterAimBot.Name) then
tool = game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun]
v17 = workspace:FindPartOnRayWithIgnoreList(Ray.new(tool.Handle.CFrame.p, (game:GetService("Players"):FindFirstChild(_G.CharacterAimBot.Name).Character.HumanoidRootPart.Position - tool.Handle.CFrame.p).unit * 100), { game.Players.LocalPlayer.Character, workspace._WorldOrigin });
game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].RemoteFunctionShoot:InvokeServer(game:GetService("Players"):FindFirstChild(_G.CharacterAimBot.Name).Character.HumanoidRootPart.Position, (require(game.ReplicatedStorage.Util).Other.hrpFromPart(v17)));
end 
end
end)
end)

end
if OPL then
if game.CoreGui:FindFirstChild("LagoGui") then
game.CoreGui:FindFirstChild("LagoGui"):Destroy()
end
local Flux = {RainbowColorValue = 0, HueSelectionPosition = 0}
local PresetColor = Color3.fromRGB(66, 134, 255)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CloseBind = Enum.KeyCode.RightControl

local Lago = Instance.new("ScreenGui")
Lago.Name = "LagoGui"
Lago.Parent = game.CoreGui
Lago.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

coroutine.wrap(
function()
while wait() do
Flux.RainbowColorValue = Flux.RainbowColorValue + 1 / 255
Flux.HueSelectionPosition = Flux.HueSelectionPosition + 1

if Flux.RainbowColorValue >= 1 then
Flux.RainbowColorValue = 0
end

if Flux.HueSelectionPosition == 80 then
Flux.HueSelectionPosition = 0
end
end
end
)()

local function MakeDraggable(topbarobject, object)
local Dragging = nil
local DragInput = nil
local DragStart = nil
local StartPosition = nil

local function Update(input)
local Delta = input.Position - DragStart
local pos =
UDim2.new(
StartPosition.X.Scale,
StartPosition.X.Offset + Delta.X,
StartPosition.Y.Scale,
StartPosition.Y.Offset + Delta.Y
)
local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
Tween:Play()
end

topbarobject.InputBegan:Connect(
function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
Dragging = true
DragStart = input.Position
StartPosition = object.Position

input.Changed:Connect(
function()
if input.UserInputState == Enum.UserInputState.End then
Dragging = false
end
end
)
end
end
)

topbarobject.InputChanged:Connect(
function(input)
if
input.UserInputType == Enum.UserInputType.MouseMovement or
input.UserInputType == Enum.UserInputType.Touch
then
DragInput = input
end
end
)

UserInputService.InputChanged:Connect(
function(input)
if input == DragInput and Dragging then
Update(input)
end
end
)
end