#!/bin/env ruby
# encoding: utf-8

@screencast_hardware_1 = Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "class Hardware",
  :summary => "Dans cette série, on va tenter de représenter le hardware d'un ordinateur en ruby, avec des classes. Ça promet !",
  :embed => "sUP_4s0S_EI",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class Wire
  attr_accessor :powered

  def initialize powered
    @powered = powered
  end

  def split
    Wire.new @powered
  end

  def join wire
    @powered = @powered || wire.powered
    self
  end

  ###
  def switch_nc input
    SwitchNc.new(self).trigger input
  end

  def switch_no input
    SwitchNo.new(self).trigger input
  end
end

class SwitchNo
  attr_accessor :wire

  def initialize wire
    @wire = wire
  end

  def on
    @wire
  end

  def off
    @wire.powered = false
    @wire
  end

  def trigger input
    if input
      on
    else
      off
    end
  end
end

class SwitchNc
  attr_accessor :wire

  def initialize wire
    @wire = wire
  end

  def on
    @wire.powered = false
    @wire
  end

  def off
    @wire
  end

  def trigger input
    if input
      on
    else
      off
    end
  end
end
    <% end %>

    <%= coderay do %>
class DoorYes
  attr_accessor :input, :output

  def initialize input
    @input = input
  end

  def compute
    @output = Wire.new(true)
      .switch_no(@input)
      .powered
  end
end      
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "01-11-2013".to_datetime,
  :serie => :hardware

@screencast_hardware_2 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "On continue notre série et on va s'attaquer aux portes logiques un peu plus évoluées.",
  :embed => "7BMjaVbDBSg",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class DoorNot
  attr_accessor :input, :output

  def initialize input
    @input = input
  end

  def compute
    @output = Wire.new(true)
      .switch_nc(@input)
      .powered
  end
end


class DoorAnd
  attr_accessor :inputs, :output

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    @output = Wire.new(true)
      .switch_no(@inputs[0])
      .switch_no(@inputs[1])
      .powered
  end
end

class DoorOr
  attr_accessor :inputs, :output

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    wire = Wire.new(true)
    wire_split = wire.split

    @outpout = wire
      .switch_no(@inputs[0])
      .join(
        wire_split.switch_no(@inputs[1])
      )
      .powered
  end
end
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "01-11-2013".to_datetime,
  :following => @screencast_hardware_1
  
@screencast_hardware_3 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Toujours dans les portes logiqies, au programme, not and et not or.",
  :embed => "Qf463dEaHlY",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class DoorNotAnd
  attr_accessor :inputs, :output

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    wire = Wire.new(true)
    wire_split = wire.split

    @outpout = wire
      .switch_nc(@inputs[0])
      .join(
        wire_split.switch_nc(@inputs[1])
      )
      .powered
  end
end

class DoorNotOr
  attr_accessor :inputs, :output

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    @output = Wire.new(true)
      .switch_nc(@inputs[0])
      .switch_nc(@inputs[1])
      .powered
  end
end
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "01-11-2013".to_datetime,
  :following => @screencast_hardware_2
  
@screencast_hardware_4 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Cette fois, on fini de coder les portes logiques, avec la dernière, le xor. Et on va aussi refactorer un peu.",
  :embed => "4yzCijAGHyQ",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class DoorXor
  attr_accessor :inputs, :output

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    wire = Wire.new(true)
    wire_split = wire.split

    @output = wire
      .switch_nc(@inputs[0])
      .switch_no(@inputs[1])
      .join(
        wire_split
          .switch_no(@inputs[0])
          .switch_nc(@inputs[1])
      )
      .powered
  end
end
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "01-11-2013".to_datetime,
  :following => @screencast_hardware_3
  
@screencast_hardware_5 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "On peut enfin commencer à parler des additionneurs, avant-dernière étape de notre périple.",
  :embed => "W7t3IWhOsgs",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class HalfAdder
  attr_accessor :inputs, :output, :retain

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    [compute_output, compute_retain]
  end

  def compute_output
    @output = DoorXor.new(*@inputs).compute
  end

  def compute_retain
    @retain = DoorAnd.new(*@inputs).compute
  end
end


class Adder
  attr_accessor :inputs, :input_retain, :output, :retain

  def initialize *inputs
    @input_retain = inputs.pop
    @inputs = inputs
  end

  def compute
    o, s = HalfAdder.new(*@inputs).compute
    o2, s2 = HalfAdder.new(o, input_retain).compute

    @output = o2

    @retain = DoorOr.new(s, s2).compute

    [@output, @retain]
  end
end
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "01-11-2013".to_datetime,
  :following => @screencast_hardware_4
  
@screencast_hardware_6 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Rapide digression, on va faire un traducteur entier / binaire. Ça sera aussi chouette pour vous que pour moi.",
  :embed => "l8HT_EXPJKg",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class BitTranslator
  attr_accessor :int, :bits

  def initialize input
    if input.is_a? Fixnum
      @int = input
      @bits = to_bits input
    else
      @int = to_int input
      @bits = input
    end
  end

  def to_bits int
    ("%04d" % int.to_s(2)).split(//).map{ |b| b == "1" }.reverse
  end

  def to_int bits
    bits.reverse.map{ |b| b and "1" or "0" }.join.to_i(2)
  end
end
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "01-11-2013".to_datetime,
  :following => @screencast_hardware_5
  
@screencast_hardware_7 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Youpi ! On va enfin pouvoir chainer nos additionneurs, et réaliser notre additionneur 4 bit !!! Joie et volutée dans cet épisode.",
  :embed => "--DWbH8DG_g",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class Adder4Bit
  attr_accessor :inputs, :input_retain, :output, :retain

  def initialize *inputs
    @input_retain = inputs.pop
    @inputs = inputs

    @output = []
  end

  def compute

    s = input_retain
    @inputs[0].size.times do
      a, b = @inputs[0].shift, @inputs[1].shift
      o, s = Adder.new(a, b, s).compute
      @output << o
    end

    @retain = s

    [@output, @retain].flatten
  end
end
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "01-11-2013".to_datetime,
  :following => @screencast_hardware_6
  
@screencast_hardware_8 = Blog::Screencast.create :user => @primal_user.blog_user,
  :summary => "Allez, un épisode de cloture fini à la pisse (dédicasse mistermv). On régle les derniers bugs et on se la raconte.",
  :embed => "iZ30mlKokd8",
  :snippet => Blog::Snippet.create(:erb => %q{
    <%= coderay do %>
class Wire
  attr_accessor :powered

  def initialize powered
    @powered = powered
  end

  def split
    Wire.new @powered
  end

  def join wire
    @powered = @powered || wire.powered
    self
  end

  ###
  def switch_nc input
    SwitchNc.new(self).trigger input
  end

  def switch_no input
    SwitchNo.new(self).trigger input
  end
end

class SwitchNo
  attr_accessor :wire

  def initialize wire
    @wire = wire
  end

  def on
    @wire
  end

  def off
    @wire.powered = false
    @wire
  end

  def trigger input
    if input
      on
    else
      off
    end
  end
end

class SwitchNc
  attr_accessor :wire

  def initialize wire
    @wire = wire
  end

  def on
    @wire.powered = false
    @wire
  end

  def off
    @wire
  end

  def trigger input
    if input
      on
    else
      off
    end
  end
end
    <% end %>
    
    <%= coderay do %>
class DoorYes
  attr_accessor :input, :output

  def initialize input
    @input = input
  end

  def compute
    @output = Wire.new(true)
      .switch_no(@input)
      .powered
  end
end

class DoorNot
  attr_accessor :input, :output

  def initialize input
    @input = input
  end

  def compute
    @output = Wire.new(true)
      .switch_nc(@input)
      .powered
  end
end


class DoorAnd
  attr_accessor :inputs, :output

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    @output = Wire.new(true)
      .switch_no(@inputs[0])
      .switch_no(@inputs[1])
      .powered
  end
end

class DoorOr
  attr_accessor :inputs, :output

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    wire = Wire.new(true)
    wire_split = wire.split

    @outpout = wire
      .switch_no(@inputs[0])
      .join(
        wire_split.switch_no(@inputs[1])
      )
      .powered
  end
end


class DoorNotAnd
  attr_accessor :inputs, :output

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    wire = Wire.new(true)
    wire_split = wire.split

    @outpout = wire
      .switch_nc(@inputs[0])
      .join(
        wire_split.switch_nc(@inputs[1])
      )
      .powered
  end
end


class DoorNotOr
  attr_accessor :inputs, :output

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    @output = Wire.new(true)
      .switch_nc(@inputs[0])
      .switch_nc(@inputs[1])
      .powered
  end
end


class DoorXor
  attr_accessor :inputs, :output

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    wire = Wire.new(true)
    wire_split = wire.split

    @output = wire
      .switch_nc(@inputs[0])
      .switch_no(@inputs[1])
      .join(
        wire_split
          .switch_no(@inputs[0])
          .switch_nc(@inputs[1])
      )
      .powered
  end
end
    <% end %>
    
    <%= coderay do %>
class BitTranslator
  attr_accessor :int, :bits

  def initialize input
    if input.is_a? Fixnum
      @int = input
      @bits = to_bits input
    else
      @int = to_int input
      @bits = input
    end
  end

  def to_bits int
    ("%04d" % int.to_s(2)).split(//).map{ |b| b == "1" }.reverse
  end

  def to_int bits
    bits.reverse.map{ |b| b and "1" or "0" }.join.to_i(2)
  end
end
    <% end %>
    
    <%= coderay do %>
class HalfAdder
  attr_accessor :inputs, :output, :retain

  def initialize *inputs
    @inputs = inputs
  end

  def compute
    [compute_output, compute_retain]
  end

  def compute_output
    @output = DoorXor.new(*@inputs).compute
  end

  def compute_retain
    @retain = DoorAnd.new(*@inputs).compute
  end
end


class Adder
  attr_accessor :inputs, :input_retain, :output, :retain

  def initialize *inputs
    @input_retain = inputs.pop
    @inputs = inputs
  end

  def compute
    o, s = HalfAdder.new(*@inputs).compute
    o2, s2 = HalfAdder.new(o, input_retain).compute

    @output = o2

    @retain = DoorOr.new(s, s2).compute

    [@output, @retain]
  end
end

class Adder4Bit
  attr_accessor :inputs, :input_retain, :output, :retain

  def initialize *inputs
    @input_retain = inputs.pop
    @inputs = inputs

    @output = []
  end

  def compute

    s = input_retain
    @inputs[0].size.times do
      a, b = @inputs[0].shift, @inputs[1].shift
      o, s = Adder.new(a, b, s).compute
      @output << o
    end

    @retain = s

    [@output, @retain].flatten
  end
end
    <% end %>
    
    <%= coderay do %>
?> "res should be 31, 26, 19, 5, 11, 7"

?> res = Adder4Bit.new(BitTranslator.new(150).bits, BitTranslator.new(15).bits, true).compute
?> BitTranslator.new(res).int
=> 31

?> res = Adder4Bit.new(BitTranslator.new(15).bits, BitTranslator.new(10).bits, true).compute
?> BitTranslator.new(res).int
=> 26

?> res = Adder4Bit.new(BitTranslator.new(9).bits, BitTranslator.new(9).bits, true).compute
?> BitTranslator.new(res).int
=> 19

?> res = Adder4Bit.new(BitTranslator.new(3).bits, BitTranslator.new(1).bits, true).compute
?> BitTranslator.new(res).int
=> 5

?> res = Adder4Bit.new(BitTranslator.new(0).bits, BitTranslator.new(10).bits, true).compute
?> BitTranslator.new(res).int
=> 11

?> res = Adder4Bit.new(BitTranslator.new(4).bits, BitTranslator.new(2).bits, true).compute
?> BitTranslator.new(res).int
=> 7
    <% end %>
  }),
  :pool => :try_hard,
  :published => true,
  :published_at => "01-11-2013".to_datetime,
  :following => @screencast_hardware_7
