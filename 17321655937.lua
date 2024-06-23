local args = {
	[1] = game:GetService("Players").LocalPlayer
}
while true do
	game:GetService("ReplicatedStorage").cash:FireServer(unpack(args))
	wait()
end
