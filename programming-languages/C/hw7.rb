# University of Washington, Programming Languages, Homework 7, hw7.rb 
# (See also ML code)

# a little language for 2D geometry objects

# each subclass of GeometryExpression, including subclasses of GeometryValue,
#  needs to respond to messages preprocess_prog and eval_prog
#
# each subclass of GeometryValue additionally needs:
#   * shift
#   * intersect, which uses the double-dispatch pattern
#   * intersectPoint, intersectLine, and intersectVerticalLine for 
#       for being called by intersect of appropriate clases and doing
#       the correct intersection calculuation
#   * (We would need intersectNoPoints and intersectLineSegment, but these
#      are provided by GeometryValue and should not be overridden.)
#   *  intersectWithSegmentAsLineResult, which is used by 
#      intersectLineSegment as described in the assignment
#
# you can define other helper methods, but will not find much need to

# Note: geometry objects should be immutable: assign to fields only during
#       object construction

# Note: For eval_prog, represent environments as arrays of 2-element arrays
# as described in the assignment

class GeometryExpression  
  # do *not* change this class definition
  Epsilon = 0.00001
end

class GeometryValue 
  # do *not* change methods in this class definition
  # you can add methods if you wish

#  private
  # some helper methods that may be generally useful
  def real_close(r1,r2) 
    (r1 - r2).abs < GeometryExpression::Epsilon
  end
  def real_close_point(x1,y1,x2,y2) 
    real_close(x1,x2) && real_close(y1,y2)
  end
  # two_points_to_line could return a Line or a VerticalLine
  def two_points_to_line(x1,y1,x2,y2) 
    if real_close(x1,x2)
      VerticalLine.new x1
    else
      m = (y2 - y1).to_f / (x2 - x1)
      b = y1 - m * x1
      Line.new(m,b)
    end
  end

  public
  # we put this in this class so all subclasses can inherit it:
  # the intersection of self with a NoPoints is a NoPoints object
  def intersectNoPoints np
    np # could also have NoPoints.new here instead
  end

  # we put this in this class so all subclasses can inhert it:
  # the intersection of self with a LineSegment is computed by
  # first intersecting with the line containing the segment and then
  # calling the result's intersectWithSegmentAsLineResult with the segment
  def intersectLineSegment seg
    line_result = intersect(two_points_to_line(seg.x1,seg.y1,seg.x2,seg.y2))
    line_result.intersectWithSegmentAsLineResult seg
  end
end

class NoPoints < GeometryValue
  # do *not* change this class definition: everything is done for you
  # (although this is the easiest class, it shows what methods every subclass
  # of geometry values needs)
  # However, you *may* move methods from here to a superclass if you wish to

  # Note: no initialize method only because there is nothing it needs to do
  def eval_prog env 
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def shift(dx,dy)
    self # shifting no-points is no-points
  end
  def intersect other
    other.intersectNoPoints self # will be NoPoints but follow double-dispatch
  end
  def intersectPoint p
    self # intersection with point and no-points is no-points
  end
  def intersectLine line
    self # intersection with line and no-points is no-points
  end
  def intersectVerticalLine vline
    self # intersection with line and no-points is no-points
  end
  # if self is the intersection of (1) some shape s and (2) 
  # the line containing seg, then we return the intersection of the 
  # shape s and the seg.  seg is an instance of LineSegment
  def intersectWithSegmentAsLineResult seg
    self
  end
end


class Point < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods

  # Note: You may want a private helper method like the local
  # helper function inbetween in the ML code
  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end
  def eval_prog env
    self
  end
  def preprocess_prog
    self
  end
  def shift(dx, dy)
    Point.new(x + dx, y + dy)
  end
  def intersect other
    other.intersectPoint self
  end
  def intersectNoPoints
    NoPoints.new()
  end
  def intersectPoint p
    if real_close_point(x, y, p.x, p.y)
    then Point.new(x, y)
    else NoPoints.new
    end
  end
  def intersectLine line
    if real_close(y, line.m * x + line.b)
    then Point.new(x, y)
    else NoPoints.new
    end
  end
  def intersectVerticalLine vline
    if real_close(x, vline.x)
    then Point.new(x, y)
    else NoPoints.new
    end
  end
  def intersectWithSegmentAsLineResult seg
    e = GeometryExpression::Epsilon
    if (seg.x1 - e <= x) and (x <= seg.x2 + e)
      Point.new(x,y)
    else NoPoints.new
    end
  end
end

class Line < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  attr_reader :m, :b 
  def initialize(m,b)
    @m = m
    @b = b
  end
  def eval_prog env
    self
  end
  def preprocess_prog
    self
  end
  def shift (dx, dy)
    Line.new(m, dy + b - (m * dx))
  end
  def intersect other
    other.intersectLine self
  end
  def intersectPoint p
    if real_close(p.y, m * p.x + b)
      Point.new(p.x, p.y)
    else NoPoints.new
    end
  end
  def intersectLine line
    if real_close(line.m, m) and real_close(line.b, b)
      Line.new(m, b)
    elsif real_close(line.m, m)
      NoPoints.new
    else x = (line.b - b) / (m - line.m)
      y = m * x + b
      Point.new(x, y)
    end
  end
  def intersectVerticalLine vline
    Point.new(vline.x, m * vline.x + b)
  end
  def intersectWithSegmentAsLineResult seg
    LineSegment.new(seg.x1,seg.y1,seg.x2,seg.y2)
  end
end

class VerticalLine < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  attr_reader :x
  def initialize x
    @x = x
  end
  def eval_prog env
    self
  end
  def preprocess_prog
    self
  end
  def shift(dx, dy)
    VerticalLine.new(x + dx)
  end
  def intersect other
    other.intersectVerticalLine self
  end
  def intersectPoint p
    if real_close(x, p.x)
    then Point.new(x, p.y)
    else NoPoints.new
    end
  end
  def intersectLine line
    Point.new(x, line.m * x + line.b)
  end
  def intersectVerticalLine vline
    if real_close(vline.x, x)
    then VerticalLine.new(x)
    else NoPoints.new
    end
  end
  def intersectWithSegmentAsLineResult seg
    LineSegment.new(seg.x1,seg.y1,seg.x2,seg.y2)
  end
end

class LineSegment < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  # Note: This is the most difficult class.  In the sample solution,
  #  preprocess_prog is about 15 lines long and 
  # intersectWithSegmentAsLineResult is about 40 lines long
  attr_reader :x1, :y1, :x2, :y2
  def initialize (x1,y1,x2,y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end
  def eval_prog env
    self
  end
  def preprocess_prog
    if real_close_point(x1, y1, x2, y2)
    Point.new(x1, y1)
    elsif ((x1 - x2) > GeometryExpression::Epsilon)
    LineSegment.new(x2, y2, x1, y1)
    elsif real_close(x1, x2) and (y2 - y1 > GeometryExpression::Epsilon)
    LineSegment.new(x2, y2, x1, y1)
    else LineSegment.new(x1, y1, x2, y2)
    end
  end
  def shift(dx, dy)
    LineSegment.new(x1+dx,y1+dy,x2+dx,y2+dy)
  end
  def intersect other
    other.intersectLineSegment self
  end
  def intersectPoint p
    e = GeometryExpression::Epsilon
    if (self.x1 - e <= p.x) and (p.x <= self.x2 + e)
      line = two_points_to_line(self.x1,self.y1,self.x2,self.y2)
      line.intersect p
    else
      NoPoints.new
    end
  end
  def intersectLine line
    e = GeometryExpression::Epsilon
    l = two_points_to_line(x1,y1,x2,y2)
    ly1 = line.m * x1 + line.b
    ly2 = line.m * x2 + line.b
    if real_close(x1, x2)
      seg_y = line.m * x1 + line.b
      if (y1 - e <= seg_y) and (seg_y <= y2 + e)
        Point.new(x1, seg_y)
      else NoPoints.new
      end
    elsif real_close(line.m, (y2 - y1) / (x2 - x1)) and real_close(ly1, y1)
      LineSegment.new(x1,y1,x2,y2)
    elsif ((ly1 - e <= y1) and (y2 <= ly2 + 2)) or ((y1 - e <= ly1) and (ly2 <= y2 +  e))
      line.intersect l
    else NoPoints.new
    end
  end
  def intersectVerticalLine vline
    e = GeometryExpression::Epsilon
    l = two_points_to_line(x1,y1,x2,y2)
    if real_close(x1, x2) and real_close(x1, vline.x)
      LineSegment.new(x1,y1,x2,y2)
    elsif (x1 - e <= vline.x) and (vline.x <= x2 + e)
      Point.new(vline.x, l.m * vline.x + l.b)
    else NoPoints.new
    end
  end
  def intersectWithSegmentAsLineResult seg
    e = GeometryExpression::Epsilon
    l = two_points_to_line(x1,y1,x2,y2)
    if ((((x1 - e <= seg.x1) and (seg.x1 <= x2 + e)) or ((x1 - e <= seg.x2) and (seg.x2 <= x2 + e)) or ((seg.x1 - e <= x1) and (x1 <= seg.x2 + e)) or ((seg.x1 - e <= x2) and (x2 <= seg.x2 + e))) and (((y1 - e <= seg.y1) and (seg.y1 <= y2 + e)) or ((y1 - e <= seg.y2) and (seg.y2 <= y2 + e)) or ((seg.y1 - e <= y1) and (y1 <= seg.y2 + e)) or ((seg.y1 - e <= y2) and (y2 <= seg.y2 + e))))
      l.intersect seg
    else NoPoints.new
    end
  end
end

# Note: there is no need for getter methods for the non-value classes

class Intersect < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end
  def preprocess_prog
    Intersect.new(@e1.preprocess_prog, @e2.preprocess_prog)
  end
  def eval_prog env
    @e1.eval_prog(env).intersect (@e2.eval_prog(env))
  end
end

class Let < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  # Note: Look at Var to guide how you implement Let
  def initialize(s,e1,e2)
    @s = s
    @e1 = e1
    @e2 = e2
  end
  def preprocess_prog
    Let.new(@s, @e1.preprocess_prog, @e2.preprocess_prog)
  end
  def eval_prog env
    new_env = [[@s, @e1.eval_prog(env)]] + env
    @e2.eval_prog new_env
  end
end

class Var < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize s
    @s = s
  end
  def eval_prog env # remember: do not change this method
    pr = env.assoc @s
    raise "undefined variable" if pr.nil?
    pr[1]
  end
  def preprocess_prog
    self
  end
end

class Shift < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(dx,dy,e)
    @dx = dx
    @dy = dy
    @e = e
  end
  def preprocess_prog
    Shift.new(@dx,@dy,@e.preprocess_prog)
  end
  def eval_prog env
    @e.shift(@dx,@dy)
  end
end
