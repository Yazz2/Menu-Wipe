ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

RegisterNetEvent("yWipe:Wipe")
AddEventHandler("yWipe:Wipe", function(joueur)
    Wipe(source, joueur)
end)

function Wipe(id, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    local steam = xPlayer.getIdentifier(target)


    DropPlayer(target, "Vous avez était wipe de yzBase Bonne chance !")
-- Rajouter les tables que vous voulez au dessus de celle deja mise exemple = "DELETE FROM "nom de votre table" WHERE identifier = @id;" 
-- Pour savoir quelle table mettre regardez dans votre BDD

    MySQL.Async.execute([[ 
		
        DELETE FROM users WHERE identifier = @id;	]], {
            ['@id'] = steam,
            
        }, function(rowsChanged)

        print("^1Wipe effectuer ! SteamID :"..steam.."^0")
        TriggerClientEvent('esx:showNotification', id, "Player wipe successfully performed")
    end)

end






