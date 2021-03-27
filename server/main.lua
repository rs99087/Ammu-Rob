

local min_police = 0

local robbableItemsVeryCommon= {
    [1] = {chance = 1, id = 'disc_ammo_pistol', name = 'Prego', quantity = math.random(2, 4)},
    [2] = {chance = 1, id = 'SmallArmor', name = 'Prego', quantity = math.random(2, 4)},
    [3] = {chance = 6, id = 'arma_cao', name = 'Faca de Pesca', quantity = math.random(1, 2)},
    [4] = {chance = 6, id = 'arma_armacaopistola', name = 'Faca de Pesca', quantity = math.random(1, 2)},
    [5] = {chance = 4, id = 'arma_gatilho', name = 'Saco de Erva', quantity = math.random(1, 2)},
    [6] = {chance = 4, id = 'cuff_keys', name = 'Saco de Erva', quantity = math.random(1, 2)},
	[7] = {chance = 4, id = 'cuffs', name = 'Saco de Erva', quantity = math.random(1, 2)},

}

local robbableItemsCommon= {
    [1] = {chance = 1, id = 'bandage', name = 'Prego', quantity = math.random(10, 20)},
    [2] = {chance = 1, id = 'WEAPON_SNSPISTOL', name = 'Prego', quantity = 1},
    [3] = {chance = 6, id = 'arma_alcademira', name = 'Faca de Pesca', quantity = math.random(2, 4)},
    [4] = {chance = 6, id = 'arma_armacaopistola', name = 'Faca de Pesca', quantity = math.random(2, 4)},
    [5] = {chance = 4, id = 'arma_botao', name = 'Saco de Erva', quantity = math.random(2, 4)},
    [6] = {chance = 4, id = 'cuff_keys', name = 'Saco de Erva', quantity = math.random(1, 2)},
	[7] = {chance = 4, id = 'cuffs', name = 'Saco de Erva', quantity = math.random(1, 2)},
	[8] = {chance = 4, id = 'disc_ammo_smg', name = 'Saco de Erva', quantity = math.random(4, 6)},

}

local robbableItemsRare= {
    [1] = {chance = 6, id = 'arma_cano', name = 'Kit Médico', quantity = math.random(1, 3)},
    [2] = {chance = 6, id = 'tec9_body', name = 'Kit Médico', quantity = math.random(2, 4)},
    [3] = {chance = 6, id = 'armacaodb', name = 'Kit Médico', quantity = 1},
    [4] = {chance = 6, id = 'HeavyArmor', name = 'Kit Médico', quantity = 1},
    [5] = {chance = 6, id = 'WEAPON_SNSPISTOL', name = 'Kit Médico', quantity = math.random(1, 3)},
    [6] = {chance = 6, id = 'armacaodb', name = 'Kit Médico', quantity = math.random(1, 3)},
    [7] = {chance = 6, id = 'arma_mola', name = 'Kit Médico', quantity = math.random(2, 4)},
    [8] = {chance = 6, id = 'Pentrite', name = 'Pentrite', quantity = 1},
    [9] = {chance = 6, id = 'disc_ammo_smg', name = 'Pentrite', quantity = math.random(6, 8)},
}

local robbableItemsSuperRare= {
	[1] = {chance = 8, id = 'WEAPON_KNIFE', name = 'Extintor', quantity = 1},
    [2] = {chance = 8, id = 'WEAPON_SNSPISTOL', name = 'Extintor', quantity = 1},
    [3] = {chance = 6, id = 'disc_ammo_pistol', name = 'Kit Médico', quantity = math.random(2, 4)},
    [4] = {chance = 6, id = 'WEAPON_MACHETE', name = 'Machete', quantity = 1},
	[5] = {chance = 10, id = 'WEAPON_PISTOL', name = 'Punhal', quantity = 1},
    [6] = {chance = 6, id = 'disc_ammo_shotgun', name = 'Punhal', quantity = 1},
    [7] = {chance = 10, id = 'arma_tambor', name = 'Receita Vaso', quantity = math.random(2, 4)},
    [8] = {chance = 10, id = 'disc_ammo_smg', name = 'Receita Vaso', quantity = math.random(8, 10)},
}

local robbableItemsUltraRare= {
    [1] = {chance = 10, id = 'WEAPON_COMBATPISTOL', name = 'P2000', quantity = 1},
    [2] = {chance = 10, id = 'WEAPON_PISTOL', name = 'Taurus PT92AF', quantity = 1},
    [3] = {chance = 6, id = 'WEAPON_HEAVYPISTOL', name = 'Mossberg 500', quantity = 1},
	[4] = {chance = 9, id = 'WEAPON_MACHINEPISTOL', name = 'Taurus PT92AF', quantity = 1},
	[5] = {chance = 6, id = 'WEAPON_PISTOL', name = 'Musket M107', quantity = 1},
	[6] = {chance = 4, id = 'net_cracker', name = 'Munição para Pistola', quantity = 1},
}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[function Restart(_source)
    canRob = false
    Wait(timeout)
    TriggerClientEvent("ammurob:reset", _source)
    canRob = true
end]]

RegisterServerEvent('ammurob:giveMoney')
AddEventHandler('ammurob:giveMoney', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local cash = math.random(2500, 2500)
    xPlayer.addMoney(cash)
    Wait(2000)
end)

RegisterServerEvent('ammurob:giveItem')
AddEventHandler('ammurob:giveItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = ESX.GetPlayerFromId(source)
 local itemchance = math.random(1,100)
    if itemchance <= 2 then
        item = robbableItemsUltraRare[math.random(1, #robbableItemsUltraRare)]     --item[32]
        xPlayer.addInventoryItem(item.id, item.quantity)
    elseif itemchance <= 12 then
        item = robbableItemsSuperRare[math.random(1, #robbableItemsSuperRare)]
        xPlayer.addInventoryItem(item.id, item.quantity)
    elseif itemchance <= 61 then
        item = robbableItemsRare[math.random(1, #robbableItemsRare)]
        xPlayer.addInventoryItem(item.id, item.quantity)
    elseif itemchance <= 90 then
        item = robbableItemsCommon[math.random(1, #robbableItemsCommon)]
        xPlayer.addInventoryItem(item.id, item.quantity)
    else
        item = robbableItemsVeryCommon[math.random(1, #robbableItemsVeryCommon)]
        xPlayer.addInventoryItem(item.id, item.quantity)
    end
end)
