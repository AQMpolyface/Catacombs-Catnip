record Enemy, pos_x : Int32, pos_y : Int32, life : Int32

class GameState
  @x_limit : Int32
  @y_limit : Int32
  @player_x : Int32
  @player_y : Int32
  @enemies : Enemy | Nil

  def initialize
    @player_x = 0
    @player_y = 0
    @x_limit = 0
    @y_limit = 0

    begin
      @x_limit, @y_limit = get_dimension
      @player_x = @x_limit // 2
      @player_y = @y_limit // 2
    rescue
      puts "there was an error registering the size ofyour terminal."
      exit(0)
    end
  end

  def advance_x(val : Int32)
    new_x = @player_x + val
    if new_x >= 0 && new_x <= @x_limit
      @player_x = new_x
    end
  end

  def advance_y(val : Int32)
    new_y = @player_y + val
    if new_y >= 0 && new_y <= @y_limit
      @player_y = new_y
    end
  end

  def player_x
    @player_x
  end

  def player_y
    @player_y
  end

  def to_s
    str = "Player position: (#{@player_x}, #{@player_y})\n"
    if @enemies
      # If enemies is a single Enemy instance, just show it
      str += "Enemy:\n"
      str += "  #{@enemies}\n"
    else
      str += "No enemies around.\n"
    end
    str
  end
end

# shamelessly stolen from https://github.com/crystal-lang/crystal/issues/2061#issuecomment-1872464520
def get_dimension : Tuple(Int32, Int32)
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
      return {cols_s.to_i, rows_s.to_i}
    else
      raise "\n\nCould not determine screen size, exiting"
    end
  end
end
