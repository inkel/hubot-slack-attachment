# Re-enable `slack-attachment` in [hubot-slack][hubot-slack]
When Slack introduced version 3 of their [hubot-slack][hubot-slack] adapter the old `slack-attachment` was removed due to [constraints in the RTM API](https://github.com/slackhq/hubot-slack/issues/108).

This module attempts to reintroduce the event using [Incoming Webhooks][incoming] to somehow replicate the lost feature.

To use again `slack-attachment` events, just run the following in your hubot repository:

```
npm install hubot-slack-attachment --save
```

And then add `hubot-slack-attachment` to `external-scripts.json`. 

Last but not least, you need to add the environment variable `HUBOT_SLACK_INCOMING_WEBHOOK` to the URL for the new [incoming webhook][incoming] you've just defined.

## Known Issues

* Attachments will be shown with the default incoming webhook icon (the same icon as `slackbot`)
* The user name sending the attachment will be `#{robot.name} (bot)`, so if your bot is named `hubot` it will appear as `hubot (bot)`

[hubot-slack]: https://github.com/slackhq/hubot-slack
[incoming]: https://my.slack.com/services/new/incoming-webhook

## License
This software is licensed under MIT License. See [License][license] for more details.