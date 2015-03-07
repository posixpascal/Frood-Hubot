# who ever screws our builds has to buy us more beer.
# rules:
# 	- awesom-o is always right, no matter what happens.
#	- awesom-o never counts wrong. never.
#	- whenever travis says: broken build -> buy some beer
#	- you can replace beer with coffee if you wish

module.exports = (robot) ->
	robot.router.post "/travis", (req, res) ->
		body = req.body
		travis =
			buildnumber: body.number
			branch: body.branch
			author_name: body.author_name
			url: body.build_url
			status: body.status_message

		t = JSON.parse(robot.brain.get "travis")
		if typeof t[author_name] == "undefined"
			t[author_name] =
				name: travis.author_name
				failed: travis.failedBuilds


		if travis.status.toLowerCase() != "passed"
			t[author_name].failed += 1
			robot.messageRoom '#general', "#{travis.author_name} hats verkackt. (URL: #{travis.url}, ##{travis.buildnumber})"
			robot.messageRoom "#general", "#{travis.author_name} hat insgesamt #{user.failedBuilds}x nicht delivered. (Gib den anderen mal ein Bier aus.)"

		robot.brain.set("travis", JSON.stringify(t))


	robot.hear /build:stats/i, (msg) ->
		@users = JSON.parse(robot.brain.get "travis")
		max = 0
		topUsers = []
		for user of @users
			if user.failed > max
				max = user.failed
				topUsers = []
				topUsers.push user
			if user.failed == max
				topUsers.push failed

		if topUsers.length > 1
			msg.send "Den Rekord halten: "
			for user in topUsers
				msg.send "#{user.name} mit #{user.failed} verkackten Builds"
		else if topUsers.length == 0
			msg.send "Den Rekord hält: "
			user = topUsers[0]
			msg.send "#{user.name} mit #{user.failed} verkackten Builds"
		else
			msg.send "- Noch keine verkackten Builds. -""