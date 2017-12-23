module DiscordBot
  # Module for sapphire commands.
  module Commands
    # Require files from directory
    Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each { |file| require file }

    @commands = [
      Etn
    ]

    def self.include!
      @commands.each do |command|
        DiscordBot::BOT.include!(command)
      end
    end
  end
end
