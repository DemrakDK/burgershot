local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "demrak_burgershot")

RegisterServerEvent('demrak_burgershot:add')
AddEventHandler('demrak_burgershot:add', function(type, amount, name)
	local source = source
	local user_id = vRP.getUserId({source})

	if type == 'money' then
		vRP.giveMoney({user_id,amount})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog '..amount..'DKK', length = 2500 })
	elseif type == 'item' then
		vRP.giveInventoryItem({user_id,name,amount,true})
	end
end)

RegisterServerEvent('demrak_burgershot:addburger')
AddEventHandler('demrak_burgershot:addburger', function(type, amount, name)
	local source = source
	local user_id = vRP.getUserId({source})

	if type == 'item' then
		vRP.giveInventoryItem({user_id,"hamburger",1,true})
	end
end)

RegisterServerEvent('demrak_burgershot:addcola')
AddEventHandler('demrak_burgershot:addcola', function(type, amount, name)
	local source = source
	local user_id = vRP.getUserId({source})

	if type == 'item' then
		vRP.giveInventoryItem({user_id,"cola",1,true})
	end
end)

RegisterServerEvent('demrak_burgershot:remove')
AddEventHandler('demrak_burgershot:remove', function(type, amount, name)
	local source = source
    local user_id = vRP.getUserId({source})

	if type == 'money' then
		vRP.tryFullPayment({user_id,amount})
	elseif type == 'item' then
		vRP.tryGetInventoryItem({user_id,name,amount,true})
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nogle burgere', length = 2500 })
	end
end)

RegisterServerEvent('demrak_burgershot:server')
AddEventHandler('demrak_burgershot:server', function()
	local source = source
	local user_id = vRP.getUserId({source})
	    if vRP.getBankMoney({user_id}) then
		vRP.tryFullPayment({user_id,Config.Startburger})
		
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok penge til at starte en burgershot levering', length = 2500 })
	end
end)

RegisterServerEvent('demrak_burgershot:buyburger')
AddEventHandler('demrak_burgershot:buyburger', function()
	local source = source
	local user_id = vRP.getUserId({source})

	    if vRP.tryFullPayment({user_id,25}) then
		vRP.giveInventoryItem({user_id,"hamburger",1,true})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Du købte en burger til 25DKK', length = 2500 })	
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok penge.', length = 2500 })
	end
end)

RegisterServerEvent('demrak_burgershot:sellburger')
AddEventHandler('demrak_burgershot:sellburger', function()
	local source = source
	local user_id = vRP.getUserId({source})
	local antal = math.random(100,250)

	if vRP.getInventoryItemAmount({user_id,"burgerpack"}) >= 1 then
		 vRP.tryGetInventoryItem({user_id,"burgerpack",1,true})
		 vRP.giveMoney({user_id,antal})
		 TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Du solgte en burger til '..antal..'DKK', length = 2500 })		
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok burgere.', length = 2500 })
	end
end)

RegisterServerEvent('demrak_burgershot:delivery')
AddEventHandler('demrak_burgershot:delivery', function()
	local source = source
	local user_id = vRP.getUserId({source})
	local reward = math.random(1500,3000)

	if vRP.getInventoryItemAmount({user_id,"burgerpack"}) >= 1 then
		 vRP.tryGetInventoryItem({user_id,"burgerpack",1,true})
		 vRP.giveMoney({user_id,reward})
		 TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Du solgte en burger til '..reward..'DKK', length = 2500 })		
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok poser med burgere.', length = 2500 })
	end
end)