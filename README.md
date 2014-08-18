## hubot-hr-warning

[![NPM](https://nodei.co/npm/hubot-hr-warning.png)](https://nodei.co/npm/hubot-hr-warning/)

A [Hubot](https://github.com/github/hubot) plugin to give users a HR violation yellow card.

For every 10 yellow cards somebody receives, a red card will be thrown out to that person. Shame on you.

### Usage

    hubot warn <name> - Give somebody an HR yellow card.
    hubot warn stats - Print out a list of who all has received warnings, and how many.

### Installation
1. `npm install hubot-hr-warning --save`
2. Add `"hubot-hr-warning"` to your `external-scripts.json` file.
3. Reboot Hubot.

_Note that if you want warning stats to persist, you need to have a database hooked up to your Hubot instance (via a brain)._
