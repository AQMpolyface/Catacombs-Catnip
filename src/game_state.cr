require "io/console"

class GameState
  @player_x : Int
  @player_z : Int
  def initialize
    begin
    @player_x, @player_z = get_dimension
    rescue
    end
  end
end
 # shamelessly stolen from https://github.com/crystal-lang/crystal/issues/2061#issuecomment-1872464520
def get_dimension() : Tuple(Int32, Int32)
print "\x1b[999C\x1b[999B"
print "\x1b[6n"

puts ""
size = String::Builder.new

STDIN.raw do |io|
  io.each_char do |c|
    unless c.nil?
      unless c.ascii_control?
        size << c
        break if c == 'R'
      end
    end
  end

  matches = size.to_s.match(/(\d+);(\d+)/)

  if matches
    _all, rows_s, cols_s = matches
    # puts "\n\ncolumns: #{cols_s}, rows: #{rows_s}"
    return {cols_s, rows_s}
  else
    raise "\n\nCould not determine screen size, exiting"
  end
end
end
