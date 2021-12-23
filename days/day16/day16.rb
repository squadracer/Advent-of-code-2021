module Day16
  def self.parse(input)
    input.chars.map { |char| char.to_i(16).to_s(2).rjust(4, '0') }.join
  end

  class PacketParser
    def initialize(binary)
      @binary = binary
      @read_pointer = 0
    end

    def advance_pointer!(size)
      value = @binary[@read_pointer...@read_pointer + size].to_i(2)
      @read_pointer += size
      value
    end

    def parse_packet
      return if @binary.nil?

      version = advance_pointer!(3)
      type = advance_pointer!(3)
      sub_packets = []

      if type == 4
        value = []
        value << advance_pointer!(4) while advance_pointer!(1) == 1
        value << advance_pointer!(4)
        value = value.reduce { |a, b| a * 16 + b }
      else
        length_type = advance_pointer!(1)
        if length_type.zero?
          length = advance_pointer!(15)
          max = @read_pointer + length
          sub_packets << parse_packet while @read_pointer < max
        else
          subpackets_count = advance_pointer!(11)
          subpackets_count.times { sub_packets << parse_packet }
        end
      end
      Day16::Packet.new(version, type, sub_packets, value)
    end
  end

  class Packet
    attr_accessor :version, :type, :sub_packets

    def initialize(version, type, sub_packets, value)
      @version = version
      @type = type
      @sub_packets = sub_packets || []
      @value = value
    end

    def versions_sum
      version + sub_packets&.sum(&:versions_sum)
    end

    def value
      case type
      when 4
        @value
      when 0
        sub_packets.sum(&:value)
      when 1
        sub_packets.map(&:value).reduce(:*)
      when 2
        sub_packets.map(&:value).min
      when 3
        sub_packets.map(&:value).max
      when 5
        first, second = sub_packets.map(&:value)
        first > second ? 1 : 0
      when 6
        first, second = sub_packets.map(&:value)
        first < second ? 1 : 0
      when 7
        first, second = sub_packets.map(&:value)
        first == second ? 1 : 0
      end
    end
  end

  def self.part1(input)
    binary = parse(input)
    parser = PacketParser.new(binary)
    packet = parser.parse_packet
    packet.versions_sum
  end

  def self.part2(input)
    binary = parse(input)
    parser = PacketParser.new(binary)
    packet = parser.parse_packet
    packet.value
  end
end
