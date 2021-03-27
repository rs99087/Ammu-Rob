ESX						= nil
local robbing = false

AllowedWeapons = {
    { name = 'WEAPON_SPECIALCARBINE', chance = 100 },
    { name = 'WEAPON_FIREEXTINGUISHER', chance = 7 },
    { name = 'WEAPON_GOLFCLUB', chance = 5 },
    { name = 'WEAPON_HAMMER', chance = 5 },
    { name = 'WEAPON_PISTOL', chance = 10 },
    { name = 'WEAPON_COMPACTRIFLE', chance = 50 },
    { name = 'WEAPON_SMG', chance = 40 },
    { name = 'WEAPON_BAT', chance = 5 },
    { name = 'WEAPON_CROWBAR', chance = 5 },
    { name = 'WEAPON_WRENCH', chance = 5 },
    { name = 'WEAPON_HEAVYPISTOL', chance = 20 },
    { name = 'WEAPON_MINISMG', chance = 25 },
}



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    local draw = false
    while true do
        Citizen.Wait(10)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k, v in ipairs(Config.AmmuStores) do
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.coords.x, v.coords.y, v.coords.z)

            if (dist <= 4.0 and not robbing) or draw then
                if hasgun() then
                    DrawMarker(27, v.coords.x, v.coords.y, v.coords.z-0.90, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if dist <= 1.0 then
                        draw = true
                        DrawText3D(v.coords.x, v.coords.y, v.coords.z, "[~g~H~w~] Iniciar roubo")
                        if IsControlJustPressed(0, 74) then
                            ESX.TriggerServerCallback('tqrp_base:getJobsOnline', function(ems, police, sheriff)
                                if v.copJob == 'police' then
                                    TriggerServerEvent('ammurob:start', police, k)
                                else
                                    TriggerServerEvent('ammurob:start', sheriff, k)
                                end
                                draw = false
                            end)
                            Citizen.Wait(500)
                        end
                    end
                else
                    draw = false
                    Citizen.Wait(1000)
                end
            else
                Citizen.Wait(1500)
            end
        end
    end
end)

--[[ Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, AmmuStore.x, AmmuStore.y, AmmuStore.z)

        if robbing then
            if dist >= 20.0 then
                robbing = false
                PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            end
        else
            Citizen.Wait(1500)
        end
    end
end) ]]

--[[ RegisterNetEvent('ammurob:reset')
AddEventHandler('ammurob:reset', function(store)
    local Store = store
    for _, Spot in pairs(Store.spots) do
        Spot.broke = false
    end
    Config.AmmuStores[store]['box'].open = false
end) ]]

RegisterNetEvent('ammurob:start')
AddEventHandler('ammurob:start', function(store)
    robbing = true
    local playerCoords = GetEntityCoords(PlayerPedId())
    DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
    TriggerServerEvent("tqrp_outlawalert:Vangelico",
        Config.AmmuStores[store].copJob, "Assalto AmmuNation", "Desconhecido", "person", "gps_fixed", 1,
        playerCoords.x, playerCoords.y, playerCoords.z, 119, 75, "10-90"
    )

    Citizen.CreateThread(function()
        local shockingevent = false
        while robbing do
            Citizen.Wait(10)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            for _, Spot in pairs(Config.AmmuStores[store].spots) do
                if not Spot.broke then
                    if (GetDistanceBetweenCoords(plyCoords, Spot.coord[1], Spot.coord[2], Spot.coord[3], true) < 1.0 ) then
                        DrawText3D(Spot.coord[1], Spot.coord[2], Spot.coord[3], "[~g~H~w~] Tentar partir vidro!")
                        local breakchance = math.random(1, 100)
                        if IsControlJustPressed(0, 74) then
                            if not shockingevent  then
                                AddShockingEventAtPosition(99, Spot.coord[1], Spot.coord[2], Spot.coord[3], 25.0)
                                shockingevent = true
                            end
                            local player = GetPlayerPed(-1)
                            TaskTurnPedToFaceCoord(player, Spot.coord[1], Spot.coord[2], Spot.coord[3], 1250)
                            if not HasAnimDictLoaded("missheist_jewel") then
                                RequestAnimDict("missheist_jewel")
                            end
                            while not HasAnimDictLoaded("missheist_jewel") do
                            Citizen.Wait(10)
                            end
                            TaskPlayAnim(player, 'missheist_jewel', 'smash_case', 1.0, -1.0,-1,1,0,0, 0,0)
                            TriggerServerEvent("big_skills:addStress", 10000)
                            if breakchance <= hasweapon.chance then
                                Spot.broke = true
                                TriggerServerEvent('tqrp_base:roblog','Assalto à ammunation ID: '.. store,'Partiu um vidro da Ammunation.', 13632027)
                                Citizen.Wait(3100)
                                ClearPedTasksImmediately(player)
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                    RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                    Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
                                StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", Spot.sfx[1], Spot.sfx[2], Spot.sfx[3], 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                                TriggerServerEvent('ammurob:giveItem')
                                Citizen.Wait(500)
                                TriggerServerEvent('ammurob:giveItem')
                                PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                            else
                                TriggerServerEvent("big_skills:addStress", 40000)
                                Citizen.Wait(2100)
                                ClearPedTasksImmediately(player)
                            end
                        end
                    end
                end
            end
            if not Config.AmmuStores[store]['box'].open then
                if (GetDistanceBetweenCoords(plyCoords, Config.AmmuStores[store]['box'].coord[1], Config.AmmuStores[store]['box'].coord[2], Config.AmmuStores[store]['box'].coord[3], true) < 1.0 ) then
                    DrawText3D(Config.AmmuStores[store]['box'].coord[1], Config.AmmuStores[store]['box'].coord[2], Config.AmmuStores[store]['box'].coord[3]+0.50, "[~g~H~w~] Abrir caixa registradora!")
                    if IsControlJustPressed(0, 74) then
                        TriggerServerEvent("big_skills:addStress", 55000)
                        animCaixa()
                        Config.AmmuStores[store]['box'].open = true
                    end
                end
            end
            for _, Spot in pairs(Config.AmmuStores[store].spots) do
                if Spot.broke then
                    robbing = true
                    break
                end
            end
            if Config.AmmuStores[store]['box'].open then
                robbing = true
            end


            ----
            local distancee = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.AmmuStores[store].coords.x, Config.AmmuStores[store].coords.y, Config.AmmuStores[store].coords.z)
            if robbing then
                if distancee >= 20.0 then
                    robbing = false
                    PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
                end
            else
                Citizen.Wait(1500)
            end
            ---
        end
    end)
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

    local scale = 0.3

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
		SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 10 )
    end
end

function hasgun()
	hasweapon = false
	local _, weaponname = GetCurrentPedWeapon(GetPlayerPed(-1))
	for index, weapon in pairs (AllowedWeapons) do
		if GetHashKey(weapon.name) == weaponname then
			hasweapon = weapon
			break
		end
	end
	return hasweapon
end

function animCaixa()
    RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
        Citizen.Wait(50)
    end
    local PedCoords = GetEntityCoords(GetPlayerPed(-1))
    torba = CreateObject(GetHashKey('prop_cs_heist_bag_02'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
    AttachEntityToEntity(torba, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
    TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    Citizen.Wait(45000)
    DeleteEntity(torba)
    ClearPedTasks(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1), false)
    SetPedComponentVariation(GetPlayerPed(-1), 5, 45, 0, 2)
    TriggerServerEvent("ammurob:giveMoney")
    Citizen.Wait(2500)
end
