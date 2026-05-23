local env = getgenv()

function env.import(id)
    return game:GetObjects(id)[1]
end

function env.getgitpath(where)
    local mainBuild = "https://raw.githubusercontent.com/IcantAffordSynapse/BrainrotPolice/refs/heads/main/"
    if where == "src" then
        return mainBuild .. "src"
    end
end

