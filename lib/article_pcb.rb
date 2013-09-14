class Wire
	attr_accessor :p

	def initialize p = true
		@p = !!p
	end
	
	def switch_no i
		@p = {
			[false, false] => false,
			[false, true] => false,
			[true, false] => false,
			[true, true] => true
		}[[@p, i]]
		
		self
	end
	
	def switch_nc i 
		@p = {
			[false, false] => false,
			[false, true] => false,
			[true, false] => true,
			[true, true] => false
		}[[@p, i]]
		
		self
	end

	def split
		Wire.new @p
	end

	def merge pcb
		@p = {
			[false, false] => false,
			[false, true] => true,
			[true, false] => true,
			[true, true] => true
		}[[pcb.p, p]]
		
		self
	end
end

class Door
	attr_accessor :wires
	
	def initialize *i
		@wires = i.map{ |p| Wire.new p }
	end
	
	def method_missing method_name, *args, &block
		p "mm"
		case method_name
		when :youpi #/^[a-z]$/
		  p method_name, (a..z).to_a.index(method_name), @wires
			@wires[(a..z).to_a.index(method_name)] ||= Wire.new
		else
		  raise NoMethodError
		end
	end
	
	def a
	  p @wires
	  @wires[0] ||= Wire.new
	end
	def b
	  @wires[1] ||= Wire.new
	end

	def yes i
		a.switch_no i
	end

	def no i
		a.switch_nc i
	end

	def d_and *i
		a.switch_no(i[0]).switch_no(i[0])
	end

	def d_or *i
		a.switch_no i[0]
		b.switch_no i[1]
		
		a.merge(b)
	end

	def not_and *i
		a.switch_nc i[0]
		b.switch_nc i[1]
		
		a.merge(b)
	end

	def not_or *i
		a.switch_nc(i[0]).switch_nc(i[0])
	end

	def xor *i
		a.switch_nc(i[0]).switch_no(i[1])
		b.switch_no(i[0]).switch_nc(i[0])
		
		a.merge(b)
	end
end

class Adder
	def half_adder *i
		o = Door.new.xor *i
		r = Door.new.d_and *i
		
		return o, r
	end

	def adder *i
		o, r1 = half_adder i[0], i[1]
		o, r2 = half_adder o, i[2]
		
		r = Door.new.d_or r1, r2
		
		return o, r
	end

	def parallel_adder_4bit *i
		o = Array.new 4

		#premier nombre 4 bit == i[0..3]
		#second nombre 4 bit == i[4..7]
		#premiere retenue == i[8]

		o[3], r = adder i[3], i[7], i[8]
		o[2], r = adder i[2], i[6], r
		o[1], r = adder i[1], i[5], r
		o[0], r = adder i[0], i[4], r 

		return r, *o
	end
end
	
