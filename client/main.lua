Config = {
	defaultDist = 50
}

function nearbyPlayers(options, nextup, close)
	local distance = options.distance or Config.defaultDist
	local id = GetPlayerServerId(PlayerId())
	local ped = PlayerPedId()
	local pedPos = GetEntityCoords(ped)
	local nearPlayers = ESX.Game.GetPlayersInArea(pedPos, distance)
	for k, v in pairs(nearPlayers) do
		nearPlayers[k] = GetPlayerServerId(v)
	end
	if options.self then
		table.insert(nearPlayers, id)
	elseif not next(nearPlayers) then
		ESX.ShowNotification('~r~No players nearby', false, true, nil)
		return
	end
	ESX.TriggerServerCallback('dd_menus:getPlayers', function(elements)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'nearbyplayers', {
			title    = options.title or 'Pick a player',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
			menu.close()
			nextup(data, menu)
		end,
		function(data, menu)
			menu.close()
			if close then
				close(data, menu)
			end
		end)
	end, nearPlayers)
end

function amount(options, nextup, close)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'amount', {
		title = options.title or 'Enter amount'
	}, 
	function(data, menu)
		data.value = tonumber(data.value)
		if options.max and data.value > options.max then
			ESX.ShowNotification('~r~Value invalid', false, true, nil)
			return
		end
		if options.min and data.value < options.min then
			ESX.ShowNotification('~r~Value invalid', false, true, nil)
			return
		end
		menu.close()
		nextup(data, menu)
	end, 
	function(data, menu)
		menu.close()
		if close then
			close(data, menu)
		end
	end)
end

function text(options, nextup, close)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text', {
		title = options.title or 'Enter text'
	},
	function(data, menu)
		menu.close()
		nextup(data, menu)
	end, 
	function(data, menu)
		menu.close()
		if close then
			close(data, menu)
		end
	end)
end

function areYouSure(options, nextup, close)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'areyousure', {
		title    = options.title or 'Are you sure?',
		align    = 'center',
		elements = {
			{label = 'No', value = 'no'},
			{label = 'Yes', value = 'yes'}
		}
	},
	function(data, menu)
		menu.close()
		if data.current.value == 'no' then
			if close then
				close(data, menu)
			end
			return
		end
		nextup(data, menu)
	end,
	function(data, menu)
		menu.close()
		if close then
			close(data, menu)
		end
	end)
end

--[[ export templates
	exports.dd_menus:nearbyPlayers({
		title = nil, 
		self = true,
		distance = nil
	},
	function(datad, menud)
	end, false)
	
	exports.dd_menus:amount({
		title = nil, 
		min = 1, 
		max = nil
	},
	function(datad, menud)
	end, false)
	
	exports.dd_menus:text({
		title = nil
	},
	function(datad, menud)
	end, false)
	
	exports.dd_menus:areYouSure({
		title = nil
	},
	function(datad, menud)
	end, false)
--]]