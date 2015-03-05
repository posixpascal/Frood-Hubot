cheerio = require 'cheerio'

module.exports = (robot) ->
	robot.pr0gramm = (msg) ->
		robot.http("http://pr0gramm.com/api/items/get?flags=1&promoted=1")
		.get() (err, res, body) ->
			body = JSON.parse body
			r = msg.random body.items
			msg.send "http://img.pr0gramm.com/#{r.image} (up: #{r.up} - down: #{r.down} - by: #{r.user})"

	robot.shouldPost = false

	robot.hear /(pr0gramm|borg)/, (msg) ->
		robot.pr0gramm(msg)

	robot.hear /(.+)/, (msg) ->
		if robot.shouldPost
			robot.pr0gramm(msg)

	setInterval () ->
		robot.shouldPost = true
	, 1000 * 60 * 10 