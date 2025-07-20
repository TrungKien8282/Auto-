-- Tải xong game
repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local autoPickup = false
local autoUse = false

-- GUI
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "AlmondWaterGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundTransparency = 1

-- Ảnh nền anime
local bg = Instance.new("ImageLabel", frame)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.Image = "rbxassetid://14567891234"
bg.BackgroundTransparency = 1

-- Tiêu đề Hoàng
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Hoàng"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Nút nhặt nước
local pickupBtn = Instance.new("TextButton", frame)
pickupBtn.Position = UDim2.new(0, 20, 0, 40)
pickupBtn.Size = UDim2.new(0, 210, 0, 30)
pickupBtn.Text = "Nhặt Nước: OFF"
pickupBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
pickupBtn.TextColor3 = Color3.new(0, 0, 0)
pickupBtn.Font = Enum.Font.Gotham
pickupBtn.TextScaled = true

-- Nút auto dùng
local useBtn = Instance.new("TextButton", frame)
useBtn.Position = UDim2.new(0, 20, 0, 80)
useBtn.Size = UDim2.new(0, 210, 0, 30)
useBtn.Text = "Auto Dùng: OFF"
useBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
useBtn.TextColor3 = Color3.new(0, 0, 0)
useBtn.Font = Enum.Font.Gotham
useBtn.TextScaled = true

-- Nút TPA tới Monitor
local tpaBtn = Instance.new("TextButton", frame)
tpaBtn.Position = UDim2.new(0, 20, 0, 120)
tpaBtn.Size = UDim2.new(0, 210, 0, 30)
tpaBtn.Text = "TPA tới Monitor"
tpaBtn.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
tpaBtn.TextColor3 = Color3.new(0, 0, 0)
tpaBtn.Font = Enum.Font.Gotham
tpaBtn.TextScaled = true

tpaBtn.MouseButton1Click:Connect(function()
	if Character and Character:FindFirstChild("HumanoidRootPart") then
		Character.HumanoidRootPart.CFrame = CFrame.new(-145.5, 1059.4137, 61.5, 1, 0, 0, 0, 0, -1, 0, 1, 0)
	end
end)

-- Nút đóng GUI (chữ "X")
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.AnchorPoint = Vector2.new(0, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.FredokaOne
closeBtn.TextScaled = true

local uicorner = Instance.new("UICorner", closeBtn)
uicorner.CornerRadius = UDim.new(0, 10)

local shadow = Instance.new("UIStroke", closeBtn)
shadow.Thickness = 2
shadow.Color = Color3.fromRGB(150, 0, 0)

-- Nút mở lại GUI
local reopenBtn = Instance.new("TextButton", gui)
reopenBtn.Size = UDim2.new(0, 100, 0, 35)
reopenBtn.Position = UDim2.new(0, 20, 0, 60)
reopenBtn.Text = "Mở GUI"
reopenBtn.BackgroundColor3 = Color3.fromRGB(0, 191, 255)
reopenBtn.TextColor3 = Color3.new(1, 1, 1)
reopenBtn.Font = Enum.Font.FredokaOne
reopenBtn.TextScaled = true
reopenBtn.Visible = false

local reopenUICorner = Instance.new("UICorner", reopenBtn)
reopenUICorner.CornerRadius = UDim.new(0, 10)

-- Sự kiện đóng mở GUI với hiệu ứng
closeBtn.MouseButton1Click:Connect(function()
    frame:TweenPosition(UDim2.new(0, 20, 0, -250), "Out", "Quad", 0.4, true)
    wait(0.4)
    frame.Visible = false
    reopenBtn.Visible = true
end)

reopenBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    frame:TweenPosition(UDim2.new(0, 20, 0, 100), "Out", "Quad", 0.4, true)
    reopenBtn.Visible = false
end)

-- Bắt sự kiện nút tính năng
pickupBtn.MouseButton1Click:Connect(function()
    autoPickup = not autoPickup
    pickupBtn.Text = "Nhặt Nước: " .. (autoPickup and "ON" or "OFF")
end)

useBtn.MouseButton1Click:Connect(function()
    autoUse = not autoUse
    useBtn.Text = "Auto Dùng: " .. (autoUse and "ON" or "OFF")
end)

-- Hàm tự động nhặt nước
local function AutoPickupAlmondWater()
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Tool") and item.Name == "Almond Water" and item:FindFirstChild("Handle") then
            firetouchinterest(Character.HumanoidRootPart, item.Handle, 0)
            wait(0.1)
            firetouchinterest(Character.HumanoidRootPart, item.Handle, 1)
        end
    end
end

-- Auto nhặt nước mỗi frame
RunService.RenderStepped:Connect(function()
    if autoPickup then
        pcall(AutoPickupAlmondWater)
    end
end)

-- Auto dùng nước mỗi 60 giây
task.spawn(function()
    while true do
        wait(60)
        if autoUse then
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool.Name == "Almond Water" then
                    LocalPlayer.Character.Humanoid:EquipTool(tool)
                    wait(0.2)
                    tool:Activate()
                    break
                end
            end
        end
    end
end)