require "./ansi_codes"
require "./game_state"
def main
  puts ALTERNATE_SCREEN
  player = GameState.new
  STDIN.raw!
  STDIN.blocking = false
  loop do
    sleep 1.0 / 60.0

    begin
      if byte = STDIN.read_byte
        char = byte.chr
        match_action char
        break if char == 'q'
      end
    rescue IO::EOFError
      # No input available, continue loop
    end
  end

  STDIN.blocking = true
  STDIN.cooked!
  puts RETURN_SCREEN
end

def match_action(action : Char, player : GameState)
  case action
  when action == 'w'

  end
end

