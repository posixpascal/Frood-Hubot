module.exports = (robot) ->
	robot.fetchBabes = (msg) ->
		api_url = "http://www.reddit.com/r/babes/new.json?sort=new"

		robot.http(api_url)
		.get() (err, res, body) ->
			body = JSON.parse body
			items = body.data.children

			item = msg.random items
			msg.send "(#{item.title} - (#{item.url}) - ups: #{item.ups} - downs: #{item.downs}"


	robot.hear /b0rg/, (msg) ->
		robot.fetchBabes(msg)