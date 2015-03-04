
module.exports = (robot) ->
  quotes = [
    "faggot",
    "ja.ja.ja",
    "*bitch-slap jäckel*",
    "http://i.imgur.com/NqyBZSp.gif",
    "http://img.pandawhale.com/40235-party-hard-pug-gif-d7hV.gif",
    "http://i.imgur.com/d8EOp.gif",
    "http://i.imgur.com/Fqe8k.gif",
  ]

  robot.hear /(ineger|intger|inteegr)/, (msg) ->
    msg.send "Fuck it Oho."
  
  robot.hear /(jaeckel|buhl|sommerfeld)/i, (msg) ->
    msg.send msg.random quotes
