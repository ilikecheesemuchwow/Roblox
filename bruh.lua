print(madeby)
local r = math.rad
local center = CFrame.new(1.5, 2.5, -1.5)
local character = game:GetService("Players").LocalPlayer.Character
local localPlayer = game:GetService("Players").LocalPlayer
local int = distance
local backpack = game:GetService("Players").LocalPlayer.Backpack
local primary = character:FindFirstChild("HumanoidRootPart")
local function getAllTools()
	 local tools = {}
	 local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
	 if backpack then
		 for i, v in pairs(backpack:GetChildren()) do
			 if v:IsA("Tool") then
				 table.insert(tools, v)
			 end
		 end
	 end
	 for i, v in pairs(character:GetChildren()) do
		 if v:IsA("Tool") then
			 table.insert(tools, v)
		 end
	 end
	 return tools
 end
if backpack and primary then
    local tools = getAllTools()
    for i, tool in pairs(tools) do
        if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
            local circ = (i / #tools) * (math.pi * 2)
            
            local function editGrip(tool, cframe, offset)
                local origin = CFrame.new(cframe.p):inverse()
                local x, y, z = cframe:toEulerAnglesXYZ()
                local newGrip = CFrame.Angles(x, y, z)
                local grip = (origin * newGrip):inverse()
                tool.Parent = backpack
                tool.Grip = offset * grip
                tool.Parent = character
                
                for _, v in pairs(tool:GetDescendants()) do
                    if v:IsA("Sound") then
                        v:Stop()
                    end
                end
            end
            
            tool.Handle.Massless = true
            
            local s = {}
            local x, y
            
            if madeby == "ilikecheesemuchwow" then
                x, y = 0, math.pi / 2
                s.x = math.sin(x)
                s.y = math.sin(y)
                x, y = x + 0.1, y + 0.1
                
                local cframe = center * CFrame.new(0, 0, 0) *
                    CFrame.Angles(0, circ, 0)
                local offset = CFrame.new(s.y * 1, 0, int) *
                    CFrame.Angles(0, 0, r(0))
                editGrip(tool, cframe, offset)
            end
        else
            print("error")
            table.remove(tools, i)
        end
    end
end
local function toHex(num)
    return string.format("0x%X", num);
end
local function playSongOnBoombox(boombox)
    local remote = boombox:FindFirstChild("Remote");
    if remote then
        local hexSongID = toHex(songID);
        remote:FireServer("PlaySong", hexSongID);
    end
end
for _, descendant in pairs(character:GetDescendants()) do
    if (descendant.Name == "BoomBox") then
        playSongOnBoombox(descendant);
    end
end
