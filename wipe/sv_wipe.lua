ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

RegisterNetEvent("sWipe:WipePlayer")
AddEventHandler("sWipe:WipePlayer", function(player)
    WipePlayer(source, player)
end)

function WipePlayer(id, target, source)
    local xPlayer = ESX.GetPlayerFromId(target)
    local xPlayers = ESX.GetPlayerFromId(source)
    local steam = xPlayer.getIdentifier()

    DropPlayer(target, "Vous vous êtes fait wipe !")

    MySQL.Async.execute([[ 
		DELETE FROM billing WHERE identifier = @wipeID;
		DELETE FROM billing WHERE sender = @wipeID;
		DELETE FROM open_car WHERE identifier = @wipeID;
		DELETE FROM owned_vehicles WHERE owner = @wipeID;
        DELETE FROM user_accounts WHERE identifier = @wipeID;
        DELETE FROM user_accessories WHERE identifier = @wipeID;
		DELETE FROM phone_users_contacts WHERE identifier = @wipeID;
		DELETE FROM user_inventory WHERE identifier = @wipeID;
        DELETE FROM user_licenses WHERE owner = @wipeID;
        DELETE FROM user_tenue WHERE identifier = @wipeID;
 		DELETE FROM users WHERE identifier = @wipeID;	]], {
		['@wipeID'] = steam,
    }, function(rowsChanged)
        print("^5Wipe effectuer ! SteamID :"..steam.."^0")
        TriggerClientEvent('esx:showNotification', id, "~g~Joueur Wipe avec succés")
    end)
    --DELETE FROM owned_properties WHERE owner = @wipeID;
    --DELETE FROM playerstattoos WHERE identifier = @wipeID;
    --DELETE FROM owned_boats WHERE owner = @wipeID;

    -- ADD YOUR TABLE / DELETE WHAT YOU DON'T HAVE 
end

function sendToDiscordWithSpecialURL(name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
		}
		
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(WipeLogs, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


RegisterNetEvent('Wipe:MenuWipe')
AddEventHandler('Wipe:MenuWipe', function()
	local _src = source
    local xPlayer = ESX.GetPlayerFromId(target)
    local xPlayers = ESX.GetPlayerFromId(source)
	sendToDiscordWithSpecialURL(target,"Menu Wipe ",xPlayers.getName().." à utilisé le menu wipe", 0, WipeLogs)

end)