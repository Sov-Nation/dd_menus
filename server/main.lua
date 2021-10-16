ESX.RegisterServerCallback('dd_menus:getPlayers', function(source, cb, players)
	local Players = {}

	for k, v in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(v)
		table.insert(Players, {
			label = '(' .. v .. ') ' .. xPlayer.name .. ' - ' .. xPlayer.job.label,
			id = v,
			name = xPlayer.name,
			identifier = xPlayer.identifier,
			job = xPlayer.job.label
		})
	end

	cb(Players)
end)

