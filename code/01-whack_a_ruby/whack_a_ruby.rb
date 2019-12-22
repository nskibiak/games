require 'gosu'

class WhackARuby < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Whack the Ruby!'
    @ruby_image = Gosu::Image.new('ruby.png')
    @x = 200
    @y = 200
    @width = 50
    @height = 43
    # velocity is pixels per frame (at 60 frames(?) per second)
    @velocity_x = 2
    @velocity_y = 2
    @visible = 0
    @hammer_image = Gosu::Image.new('hammer.png')
    @hit = 0
    @font = Gosu::Font.new(30)
    @score = 0
  end

  def draw
    # using new syntax; instead of:
    # if @visible > 0
    # using this:
    @ruby_image.draw(@x - @width / 2, @y - @height / 2, 1) if @visible.positive?
    @hammer_image.draw(mouse_x - 30, mouse_y - 30, 1)
    if @hit == 0
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end
    # this requires 12 parameters and draws quadrilateral
    # if hit == 1, we fill the screen with green
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
    @hit = 0
  end

  def update
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0
    @velocity_y *= -1 if @y + @width / 2 > 600 || @y - @width / 2 < 0
    @visible -= 1
    @visible = 30 if @visible < -10 && rand < 0.01
  end

  def button_down(id)
    if (id == Gosu::MsLeft)
      # if the position of the mouse and the ruby (@x, @y) are within 50 pixels
      if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
        @hit = 1
        @score += 5
      else
        @hit = -1
        @score -= 1
      end
    end
  end
end

window = WhackARuby.new
window.show
