require 'trello'
require 'yaml'

class TrelloPriorities

  CONFIG_FILE = "./config.yml".freeze

  def initialize
    @config = {}
  end

  def start
    if config_file_exists?
      load_existing_config
      ask_list_name
    else
      ask_config
      offer_to_save_config
    end
    authenticate
    set_priorities
  end

  private

  def config_file_exists?
    File.exists?(CONFIG_FILE)
  end

  def load_existing_config
    puts "\nConfig file found! Loading existing configuration..."
    @config = YAML.load_file(CONFIG_FILE)
  end

  def ask_config
    ask_credentials
    ask_board_id
    ask_list_name
  end

  def ask_credentials
    puts ""
    puts "Getting your public key... Copy it from browser and paste it bellow:"
    sleep 1
    Trello.open_public_key_url
    @config[:public_key] = gets.chomp

    puts ""
    puts "Getting your authorization token... Copy it from browser and paste it bellow:"
    sleep 1
    Trello.open_authorization_url key: @config[:public_key]
    @config[:token] = gets.chomp
  end

  def ask_board_id
    puts "\nEnter BOARD_ID (you can get it from board's URL https://trello.com/b/BOARD_ID/boardName):"
    @config[:board_id] = gets.chomp
  end

  def ask_list_name
    puts "\nEnter name name of the list which contains the cards to be prefixed"
    @config[:list_name] = gets.chomp
  end

  def offer_to_save_config
    puts "\nDo you want to save credentials and boardID for future uses? (y/n)"
    if gets.chomp == "y"
      File.write(CONFIG_FILE, YAML.dump(@config))
      puts "\n Config saved!"
    end
  end

  def authenticate
    puts "Authenticating..."
    Trello.configure do |config|
      config.developer_public_key = @config[:public_key]
      config.member_token = @config[:token]
    end
  end

  def set_priorities
    board = Trello::Board.find(@config[:board_id])
    todo_list = board.lists({filter: :all}).select{|l| l.name == @config[:list_name]}.first
    puts "\nUpdating #{todo_list.cards.count} cards: "
    priority = 1
    todo_list.cards.each do |card|
      card.name = "#{priority}. #{card.name}"
      card.save
      priority += 1
      puts card.name
    end
    puts "\ndone!"
  end

end

TrelloPriorities.new.start
