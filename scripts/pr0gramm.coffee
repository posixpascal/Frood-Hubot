cheerio = require 'cheerio'

module.exports = (robot) ->
	robot.pr0gramm = (msg, boobs) ->
		robot.http("http://pr0gramm.com/api/items/get?flags=1&promoted=1&tags=#{boobs ? 'boobs' : ''}")
		.get() (err, res, body) ->
			body = JSON.parse body
			r = msg.random body.items
			msg.send "http://img.pr0gramm.com/#{r.image} (up: #{r.up} - down: #{r.down} - by: #{r.user})"

	robot.shouldPost = false

	robot.hear /(pr0gramm)/, (msg) ->
		robot.pr0gramm(msg)

	robot.hear /(borg)/, (msg) ->
		robot.pr0gramm(msg, true)

	robot.hear /(.+)/, (msg) ->
		if robot.shouldPost
			robot.pr0gramm(msg)

	setInterval () ->
		robot.shouldPost = true
	, 1000 * 60 * 10 