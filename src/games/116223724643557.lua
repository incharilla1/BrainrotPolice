-- +1 Magic Evolution
return function(section, data)
    local players = game:GetService("Players")
    local replicatedstorage = game:GetService("ReplicatedStorage")
    local httpservice = game:GetService("HttpService")

    local player = players.LocalPlayer

    local function get_character()
        return player.Character or player.CharacterAdded:Wait()
    end

    local function get_root()
        local character = get_character()
        return character and character:FindFirstChild("HumanoidRootPart")
    end

    local function get_target()
        return workspace:FindFirstChild("Stages")
            and workspace.Stages:FindFirstChild("Stage31")
            and workspace.Stages.Stage31:FindFirstChild("WinButton")
    end

    local function get_remotes()
        return replicatedstorage:FindFirstChild("Remotes")
    end

    local function get_staff()
        local staff_buttons = workspace:FindFirstChild("StaffButtons")
        local staff_button_20 = staff_buttons and staff_buttons["Staff Button20"]
        return staff_button_20 and staff_button_20:FindFirstChild("TouchPart")
    end

    local elements = loadstring(game:HttpGet(getgitpath("src") .. "elements.lua"))()

    getgenv().tp = getgenv().tp or false
    getgenv().train = getgenv().train or false
    getgenv().staff = getgenv().staff or false
    getgenv().rebirth = getgenv().rebirth or false

    local place_data = data[tostring(game.PlaceId)] or {}
    data[tostring(game.PlaceId)] = place_data
    httpservice:JSONEncode(data)

    elements:Toggle("Auto Win", section, getgenv().tp, function(v)
        getgenv().tp = v
        local target = get_target()

        if v and target then
            while getgenv().tp do
                local root = get_root()
                local character = get_character()

                if root and character and target then
                    local pivot = target:GetPivot()
                    character:PivotTo(CFrame.new(pivot.Position + Vector3.new(0, 2, 0)))
                end

                task.wait()
            end
        end
    end)

    elements:Toggle("Auto Train", section, getgenv().train, function(v)
        getgenv().train = v
        local remotes = get_remotes()
        local gain = remotes and remotes:FindFirstChild("GainMagicPower")

        if v and gain then
            while getgenv().train do
                pcall(function()
                    gain:FireServer()
                end)
                task.wait()
            end
        end
    end)

    elements:Toggle("Equip Best Staff", section, getgenv().staff, function(v)
        getgenv().staff = v
        if v then
            while getgenv().staff do
                local root = get_root()
                local touch = get_staff()

                if root and touch then
                    touch.CFrame = root.CFrame * CFrame.new(0, 0, -3)
                end

                task.wait()
            end
        end
    end)

    elements:Toggle("Auto Rebirth", section, getgenv().rebirth, function(v)
        getgenv().rebirth = v
        local remotes = get_remotes()
        local rebirth = remotes and remotes:FindFirstChild("Rebirth")

        if v and rebirth then
            while getgenv().rebirth do
                pcall(function()
                    rebirth:FireServer()
                end)
                task.wait()
            end
        end
    end)
end
