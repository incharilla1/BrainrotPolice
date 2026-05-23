return function(section)
    print("reached with king", section)
    local elements = loadstring(game:HttpGet(getgitpath("src").."elements.lua"))()

    local repStorage = game:GetService("ReplicatedStorage")

    getgenv().Farming = false

    elements:Toggle("Farming", section, function(isOn)
        if isOn then
            getgenv().Farming = true
            while getgenv().Farming do
                repStorage.RemoteHandler.Fishing:FireServer(
                    "Caught",
                    3
                )
                task.wait(0.1)
            end
        else
            getgenv().Farming = false
        end
    end)
end
