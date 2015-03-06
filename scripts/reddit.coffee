module.exports = (robot) ->
	robot.fetchReddit = (reddit, msg) ->
		api_url = "http://www.reddit.com/r/#{reddit}/new.json?sort=new"

		robot.http(api_url)
		.get() (err, res, body) ->
			body = JSON.parse body
			items = body.data.children

			item = msg.random items
			item = item.data
			msg.send "#{item.title} - (#{item.url}) - ups: #{item.ups} - downs: #{item.downs}"


	robot.hear /b0rg/i, (msg) ->
		robot.fetchReddit("babes", msg)

	robot.hear /reddit:(.+)/, (msg) ->
		robot.fetchReddit(msg.match[1], msg)