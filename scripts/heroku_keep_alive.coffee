#
# Heroku lässt die Server periodisch einschlafen sobald keine Anfrage kommt
# bei der nächsten Anfrage muss der Server wieder aufwachen was einige Zeit kostet
# nun sendet Awesom-o periodische Aufrufe um das zu verhindern. Fuck the system.

module.exports = (robot) ->
	servers = [

	]

	setInterval ->
		for server in servers
			robot.http(server)
			.get() (u,se,less) ->
				console.log("Woke #{server}.")

	, 60 * 1000 * 55
