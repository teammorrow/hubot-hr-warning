# Description:
#   Give users a SBC violation yellow card.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot warn <name>
#   hubot warn stats
#
# Author:
#   llkats, jonursenbach

module.exports = (robot) ->
  robot.respond /warn (.*)/i, (msg) ->
    robot.brain.data.sbc_violations ||= {}

    user = msg.match[1].trim()
    if user != ""
      if user != 'stats' && user != 'list'
        user = getWarnedUser robot, user

        if typeof robot.brain.data.sbc_violations[user] != 'undefined'
          robot.brain.data.sbc_violations[user] += 1
        else
          robot.brain.data.sbc_violations[user] = 1

        emit = ''
        if robot.brain.data.sbc_violations[user] % 10 > 0
          msg.send user + ' gets an SBC violation yellow card. http://i.imgur.com/EHKAkR3.gif'
        else
          msg.send user + ' gets an SBC violation red card. This is your 10th consecutive yellow card. You are bad and you should feel bad.'

        return

      size = 0
      emit = 'SBC violation stats:\n'
      array = []
      users = for user, cards of robot.brain.data.sbc_violations
        size++
        userCards = getCards robot, user
        array.push userCards

      array.sort (a, b) ->
        if a.total < b.total
          return 1
        if a.total > b.total
          return -1
        return 0

      for sortedUser in array
        userEmit = []

        if sortedUser.red > 1
          userEmit.push sortedUser.red + ' red cards'
        else if sortedUser.red == 1
          userEmit.push sortedUser.red + ' red card'

        if sortedUser.yellow > 1
          userEmit.push sortedUser.yellow + ' yellow cards'
        else if sortedUser.yellow == 1
          userEmit.push sortedUser.yellow + ' yellow card'

        emit += ' - ' + sortedUser.user + ' has ' + userEmit.join(' and ') + '\n'

      if size == 0
        msg.send 'No SBC violations! Something is amok...'
        return

      msg.send emit

getWarnedUser = (robot, user) ->
  users = robot.brain.usersForFuzzyName(user)
  if users.length is 1
    user = users[0]
    return user.name.replace(/[\s](.*)/, '')

  return user

# returns an object of red and yellow card counts
getCards = (robot, user) ->
  yellow = 0
  red = 0
  cards = robot.brain.data.sbc_violations[user]

  # if cards are evenly divisble by 10, only red cards exist
  # count red cards with division
  if (cards % 10 == 0)
    red = cards / 10
    yellow = 0

  # if the remainder of cards / 10 is less than one, only yellow cards exist
  # count yellow cards with mod
  else if (cards / 10 < 1)
    red = 0
    yellow = cards % 10

  # if the remainder of cards / 10 is greater than one, a mix of yellow and red cards exist
  # count red cards by subtracting 10 from cards until cards is less than 10 and
  # greater than 0 remaining cards are the yellow cards
  else if (cards / 10 > 1)
    temp = cards
    while (temp > 1 && (temp - 10) > 0)
      red += 1
      temp -= 10
    yellow = temp

  return { 'total': cards, 'red' : red, 'yellow' : yellow, 'user', user }
