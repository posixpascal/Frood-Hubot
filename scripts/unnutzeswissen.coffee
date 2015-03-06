cheerio = require 'cheerio'

module.exports = (robot) ->
	robot.unnuetz = (channel) ->
		robot.http('http://www.unnutzes.com/wissen/')
		.get() (err, res, body) ->
			$ = cheerio.load(body)
			articles = $("article.post")
			$article = cheerio.load(articles.eq(Math.round( (articles.length - 1) * Math.random()) ).html())
			data = 
				image: $article.find(".wp-post-image").attr("src")
				message: $article.find(".wp-post-image").attr("alt")
				link: $article.find("a.article-hover").attr("href")

			message = "(#{data.link}) - #{data.image} #{data.message}"
			if typeof channel == "string"
				robot.messageRoom channel, message
			else
				channel.send message
			
	robot.hear /unnutzeswissen/i, (msg) ->
		robot.unnuetz msg

	setInterval () ->
		robot.unnuetz("#random")
	, 1000 * 60 * 20 