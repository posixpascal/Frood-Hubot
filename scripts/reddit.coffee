module.exports = (robot) ->
	robot.fetchBabes = (reddit, msg) ->
		api_url = "http://www.reddit.com/r/#{reddit}/new.json?sort=new"

		robot.http(api_url)
		.get() (err, res, body) ->
			body = JSON.parse body
			items = body.data.children

			item = msg.random items
			item = item.data
			msg.send "#{item.title} - (#{item.url}) - ups: #{item.ups} - downs: #{item.downs}"


	robot.hear /b0rg/, (msg) ->
		robot.fetchReddit("babes", msg)

	robot.hear /randnsfw/, (msg) ->
		robot.fetchReddit("randnsfw", msg)