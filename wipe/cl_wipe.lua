ESX = nil
Citizen.CreateThread(function()
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ESX.TriggerServerCallback('Wipe:Group', function(group)
    playergroup = group
end)
end)





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
                    for k,y in pairs(GetActivePlayers()) do 
                    RageUI.Button(GetPlayerServerId(y).." - "..GetPlayerName(y), nil, { RightLabel = "~b~wipe~s~→"}, true , {
                        onSelected = function()
                            SelectionJoueur = GetPlayerServerId(y)
                        end
                    },Confirmation)
                end

                end)
                RageUI.IsVisible(Confirmation, function()
                    RageUI.Button("Oui", nil, {Color = {BackgroundColor = {0, 255, 0, 50}}, RightLabel = "→→→"}, true , {
                        onSelected = function()
                            for _, PlayerID in ipairs(GetActivePlayers()) do                            
                            RageUI.CloseAll()
                                local name = GetPlayerName(PlayerId())
                                local receveur = GetPlayerName(PlayerID)
                                TriggerServerEvent("yWipe:Wipe", SelectionJoueur)
                                SelectionJoueur = true
                                TriggerServerEvent('LOGS:Wipe', name..' à wipe '..receveur, 'Mettez le lien de votre webhook')
                                ESX.ShowNotification('~r~Le joueur '..name..'~r à été Wipe avec succés')
                        end
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
    ESX.TriggerServerCallback('Wipe:Group', function(group)
    if group == 'superadmin' or group == 'admin'  then
    OpenMenuWipe()
    else 
        ESX.ShowNotification("~r~Vous devez être Staff")
    end
end)
end, false)
