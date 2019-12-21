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
  end

  def draw
    # using new syntax; instead of:
    # if @visible > 0
    # using this:
    @ruby_image.draw(@x - @width / 2, @y - @height / 2, 1) if @visible.positive?
    @hammer_image.draw(mouse_x - 30, mouse_y - 30, 1)
  end

  def update
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0
    @velocity_y *= -1 if @y + @width / 2 > 600 || @y - @width / 2 < 0
    @visible -= 1
    @visible = 30 if @visible < -10 && rand < 0.01
  end
end

window = WhackARuby.new
window.show
