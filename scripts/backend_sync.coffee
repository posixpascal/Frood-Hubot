module.exports = (robot) ->
	robot.router.post "/backend/synced", () ->
		robot.messageRoom "#frood-backend", "Frood Backend wird synchronisiert. http://vankash.de:3333/"