require "dotenv/load"
require "discordrb"
require "httparty"
require "terminal-table"

module DiscordBot
  require_relative "discord_bot/commands.rb"

  BOT = Discordrb::Commands::CommandBot.new(token: ENV["TOKEN"],
                                            application_id: ENV["CLIENT_ID"],
                                            prefix: "!",
                                            fancy_log: true)

  Commands.include!

  BOT.run
end
