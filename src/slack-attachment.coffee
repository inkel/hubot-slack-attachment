# Description:
#   Enable again the 'slack-attachment' event
#
# Environment:
#   HUBOT_SLACK_INCOMING_WEBHOOK

module.exports = (robot) ->
  options =
    webhook: process.env.HUBOT_SLACK_INCOMING_WEBHOOK

  return robot.logger.error "Missing configuration HUBOT_SLACK_INCOMING_WEBHOOK" unless options.webhook?

  getChannel = (msg) ->
    if msg.match /^[#@]/
      # the channel already has an appropriate prefix
      msg.room
    else if msg.user && msg.room == msg.user.name
      "@#{msg.room}"
    else
      "##{msg.room}"

  getUsername = (data) ->
    data.username || robot.name

  attachment = (data) ->
    payload = data.content

    payload.channel  = data.channel || getChannel data.message
    payload.username = getUsername data

    if data.icon_url?
      payload.icon_url = data.icon_url
    else if data.icon_emoji?
      payload.icon_emoji = data.icon_emoji

    reqbody = JSON.stringify(payload)

    robot.http(options.webhook)
      .header("Content-Type", "application/json")
      .post(reqbody) (err, res, body) ->
        return if res.statusCode == 200

        robot.logger.error "Error!", res.statusCode, body

  robot.on "slack-attachment", (data) ->
    robot.logger.warning "Using deprecated event 'slack-attachment'"
    attachment data

  robot.on "slack.attachment", (data) ->
    attachment data
