require "./game_state"
require "./ansi_codes"

def draw(game_state : GameState)
  puts "\033[-1;-1}"
  puts CLEAR_SCREEN
  puts CLEAR_CURSOR

  puts "\033[#{game_state.player_y};#{game_state.player_x}H@"
  # puts game_state.to_s

  puts "\033[-1;-1}"
end

def init
  puts ALTERNATE_SCREEN
end

def exit_game
  puts CLEAR_SCREEN
  puts RETURN_SCREEN
  exit(0)
end
