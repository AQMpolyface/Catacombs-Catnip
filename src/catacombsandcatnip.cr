require "./ansi_codes"
require "./game_state"
require "./render"

FPS        = 60
FRAME_TIME = 1.0 / FPS

main

def main
  init
  game_state = GameState.new

  STDIN.raw!
  STDIN.blocking = false

  loop do
    start = Time.monotonic

    begin
      spawn do
        if byte = STDIN.read_byte
          char = byte.chr
          puts char
          match_action char, game_state
        end
      end
    rescue IO::EOFError
      # No input available, continue loop
    end

    draw game_state

    elapsed = Time.monotonic - start
    sleep_time = FRAME_TIME - elapsed.total_seconds
    sleep sleep_time if sleep_time > 0
  end

  STDIN.cooked!
  STDIN.blocking = true
  exit_game
end

def match_action(action : Char, game_state : GameState)
  case action
  when 'w'
    game_state.advance_y(-1)
  when 's'
    game_state.advance_y(1)
  when 'd'
    game_state.advance_x 1
  when 'a'
    game_state.advance_x(-1)
  when 'q'
    exit_game
  end
end
