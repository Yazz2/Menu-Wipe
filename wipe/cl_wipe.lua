ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)
-- WebHooks --

WipeLogs = "https://discord.com/api/webhooks/929080295985123369/nKGo68wiHHIccDnh477hUHbmmiciOzpS4PUWzNUTh9ojtyK7oAyyzHtGWjN55NTHAHBA"-- Votre Webhook 

-- Menu --
local open = false
local main = RageUI.CreateMenu("Menu Wipe", "Intéractions disponibles")
local Confirmation = RageUI.CreateSubMenu(main, "Menu Wipe", "Intéractions disponibles")
main.Display.Header = true
main.Closed = function()
    open = false
end
local SelectionJoueur = nil

function OpenMenuWipe() 
    if open then 
        open = false
        RageUI.Visible(main, false)
        return
    else
        open = true
        RageUI.Visible(main, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(main, function()
                    for k,v in pairs(GetActivePlayers()) do 
                    RageUI.Button(GetPlayerServerId(v).." - "..GetPlayerName(v), nil, { RightLabel = "~b~Wipe~s~→"}, true , {
                        onSelected = function()
                            SelectionJoueur = GetPlayerServerId(v)
                        end
                    },Confirmation)
                end

                end)
                RageUI.IsVisible(Confirmation, function()
                    RageUI.Button("Oui", nil, {Color = {BackgroundColor = {0, 255, 0, 50}}, RightLabel = "→→→"}, true , {
                        onSelected = function()
                            RageUI.CloseAll()
                            TriggerServerEvent("sWipe:WipePlayer", SelectionJoueur)
                        end
                    })
                    RageUI.Button("Non", nil, {Color = {BackgroundColor = {255, 0, 0, 50}}, RightLabel = "→→→"}, true , {
                        onSelected = function()
                            RageUI.CloseAll()
                            SelectionJoueur = nil
                        end
                    })
                end)

            Wait(0)
            end
        end)
    end
end







RegisterCommand("wipe", function()

    OpenMenuWipe()

end, false)