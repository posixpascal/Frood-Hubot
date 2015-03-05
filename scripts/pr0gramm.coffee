cheerio = require 'cheerio'

module.exports = (robot) ->
	robot.pr0gramm = (msg, tag) ->
		pr0gramm_url = "http://pr0gramm.com/api/items/get?flags=1&promoted=1"
		if tag
			pr0gramm_url = pr0gramm_url + "&tags=#{tag}"
		robot.http(pr0gramm_url)
		.get() (err, res, body) ->
			body = JSON.parse body
			items = []
			for item in body.items
				if item.image.indexOf("webm") == -1
					items.push item
			r = msg.random items
			msg.send "http://img.pr0gramm.com/#{r.image} (up: #{r.up} - down: #{r.down} - by: #{r.user})"

	robot.shouldPost = false

	robot.hear /pr0gramm\:(.+)/, (msg) ->
		if msg.match.length > 0
			robot.pr0gramm(msg, escape(msg.match[1]))
		else
			robot.pr0gramm(msg)


	robot.hear /(borg)/, (msg) ->
		robot.pr0gramm(msg, "boobs")

	robot.hear /(.+)/, (msg) ->
		if robot.shouldPost
			robot.pr0gramm(msg)

	setInterval () ->
		robot.shouldPost = true
	, 1000 * 60 * 10 