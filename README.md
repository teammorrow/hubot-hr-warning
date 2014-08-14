## hubot-sbc-warning

[![NPM](https://nodei.co/npm/hubot-sbc-warning.png)](https://nodei.co/npm/hubot-sbc-warning/)

A [Hubot](https://github.com/github/hubot) plugin to give users a [SBC](http://en.wikipedia.org/wiki/Business_ethics) violation yellow card.

For every 10 yellow cards somebody receives, a red card will be thrown out to that person. Shame on you.

### Usage

    hubot warn <name> - Give somebody an SBC card.
    hubot warn stats - Print out a list of who all has received cards, and how many.

### Installation
1. `npm install hubot-sbc-warning --save`
2. Add `"hubot-sbc-warning"` to your `external-scripts.json` file.
3. Reboot Hubot.

_Note that if you want warning stats to persist, you need to have a database hooked up to your Hubot instance (via a brain)._
