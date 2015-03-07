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

		user = robot.brain.userForId travis.author_name
		if typeof user.failedBuilds == "undefined"
			user.failedBuilds = 0

		user.travis_realname = travis.author_name

		if travis.status.toLowerCase() != "passed"
			user.failedBuilds += 1
			robot.messageRoom '#general', "#{travis.author_name} hats verkackt. (URL: #{travis.url}, ##{travis.buildnumber})"
			robot.messageRoom "#general", "#{travis.author_name} hat insgesamt #{user.failedBuilds}x nicht delivered. (Gib den anderen mal ein Bier aus.)"
		robot.brain.save()


	robot.hear /build:stats/i, (msg) ->
		@users = robot.brain.users
		max = 0
		topUsers = []
		for user in @users
			if user.failedBuilds > max
				max = user.failedBuilds
				topUsers = []
				topUsers.push user
			if user.failedBuilds == max
				topUsers.push user

		if topUsers.length > 1
			msg.send "Den Rekord halten: "
			for user in topUsers
				msg.send "#{user.travis_name} mit #{user.failedBuilds} verkackten Builds"
		else
			msg.send "Den Rekord hält: "
			user = topUsers[0]
			msg.send "#{user.travis_name} mit #{user.failedBuilds} verkackten Builds"
