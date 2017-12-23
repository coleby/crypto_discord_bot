module DiscordBot
  module Commands
    # Outputs the current ETN prices in a neat table
    module Etn
      CURRENT_ALT_COINS = %w[BTC LTC DOGE USDT].freeze

      extend Discordrb::Commands::CommandContainer
      command(:etn, description: "Gathers the current price of etn on cryptopia") do |event|
        event << output_message
      end

      def self.output_message
        prices = pull_all_prices
        return "There was an issue with the server. Please try again in 30s" if prices == "ERROR"
        "```" + formatted_table(prices).to_s + "```"
      end

      def self.pull_all_prices
        complete_prices = {}
        CURRENT_ALT_COINS.each { |second_coin| complete_prices["ETN/"+second_coin] = cryptopia_pull(second_coin) }
        return "ERROR" unless complete_prices.all? { |_, v| !v.nil? }
        complete_prices
      end

      # Parsing the scientific notation to a readable string with 8 decimal points (satoshis)
      def self.cryptopia_pull(second_coin)
        "%.8f" % HTTParty.get("https://www.cryptopia.co.nz/api/GetMarket/ETN_#{second_coin.capitalize}")["Data"]["LastPrice"]
      end

      def self.formatted_table(prices)
        Terminal::Table.new title: "CURRENT ETN PRICES", headings: ["ETN/XXXX", "Amount"], rows: prices.to_a
      end
    end
  end
end
