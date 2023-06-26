class ArtAttack
  def initialize
    @canvas = Array.new(2000) { Array.new(2000) { 0 } }
  end

  def draw_line(x0, y0, x1, y1)
    if x0 == x1
      (y0..y1).each { |y| @canvas[x0][y] = 1 }
    else
      m = (y1 - y0).to_f / (x1 - x0)
      (x0..x1).each do |x|
        y = m * (x - x0) + y0
        @canvas[x][y] = 1
      end
    end
  end

  def draw_rectangle(x1, y1, x2, y2)
    draw_line(x1, y1, x2, y1)
    draw_line(x2, y1, x2, y2)
    draw_line(x2, y2, x1, y2)
    draw_line(x1, y2, x1, y1)
  end

  def draw_circle(x, y, radius)
    (0...radius).each do |side|
      draw_line(x, y + side, x + side, y)
      draw_line(x + side, y, x, y - side)
      draw_line(x, y - side, x - side, y)
      draw_line(x - side, y, x, y + side)
    end
  end

  def draw_ellipse(x, y, a, b)
    (1..a).each do |length|
      x1 = x - length
      x2 = x + length
      y1 = y - (b * (1 - (length.to_f / a)**2)**0.5).ceil
      y2 = y + (b * (1 - (length.to_f / a)**2)**0.5).ceil
      draw_line(x1, y1, x2, y2)
    end
  end

  def draw_polygon(x1, y1, x2, y2, x3, y3)
    draw_line(x1, y1, x2, y2)
    draw_line(x2, y2, x3, y3)
    draw_line(x3, y3, x1, y1)
  end
end