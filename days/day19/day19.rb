require 'pry'
module Day19
  class Scanner
    attr_accessor :beacons
    attr_accessor :index
    attr_accessor :rotations
    attr_accessor :scanner_position

    BEACONS_COUNT = 12
    def initialize(index, beacons)
      @index = index
      @beacons = beacons
      @rotations = {}
      compute_rotations
      @scanner_position = [0, 0, 0]
    end
    
    def realign(aligned_beacons, new_scanner_position)
      @beacons = aligned_beacons
      @rotations = {}
      @scanner_position = new_scanner_position
    end

    def to_s
      "Scanner #{index}, position: #{scanner_position} : #{beacons.size} beacons"
    end
    
    def rotate_6_sides(x, y, z)
      [[x,y,z],
      [z,y,-x],
      [-x,y,-z],
      [-z,y,x],
      [x,z,-y],
      [x,-z,y]]
    end

    def rotate_4_faces(x, y, z)
      [[x,y,z],
      [y,-x,z],
      [-x,-y,z],
      [-y,x,z]]
    end

    # return 24 lists of beacons
    def compute_rotations
      @rotations = beacons.map do |x ,y, z|
        rotate_6_sides(x, y, z).flat_map do |rx, ry, rz|
          rotate_4_faces(rx, ry, rz)
        end
      end.transpose
    end

    def match(other_scanner)
      other_scanner.rotations.each do |other_beacons|
        @beacons.each_with_index do |ref_beacon, index|
          other_beacons.each_with_index do |other_ref_beacon, other_index|
            # on considère que ref_beacon et other_ref_beacon sont le même beacon
            vector = ref_beacon.zip(other_ref_beacon).map{_1-_2}
            aligned_other_beacons = other_beacons.map{|other_beacon| other_beacon.zip(vector).map{_1+_2} }
            if (@beacons & aligned_other_beacons).size >= BEACONS_COUNT
              # vector sera la position relative
              # other_beacons sera bien orienté
              other_scanner.realign(aligned_other_beacons, vector.map{-_1})
              return true
            end
          end
        end
      end
      return false
    end

  end

  def self.parse(input)
    scanner_datas = input.split(/--- scanner \d+ ---/)[1..]
    scanner_datas.each.with_index.map do |scanner_data, index|
      Scanner.new(index, 
        scanner_data.split("\n")[1..].map do |beacon_datas|
          beacon_datas.split(",").map(&:to_i)
        end
      )
    end
  end

  def self.part1(input)
    dontmatch = {}
    scanners = parse(input)
    aligned_scanners = [scanners.shift]
    while scanners.size > 0
      scanners.each do |scanner|
        aligned_scanners.each do |aligned_scanner|
          next if dontmatch[[aligned_scanner.index, scanner.index]]
          if aligned_scanner.match(scanner)
            aligned_scanners.push scanner
            scanners.delete scanner
            break
          else
            dontmatch[[aligned_scanner.index, scanner.index]] = true
          end
        end
      end
    end

    aligned_scanners.map(&:beacons).flatten(1).uniq.size
  end
  
  def self.part2(input)
    dontmatch = {}
    scanners = parse(input)
    aligned_scanners = [scanners.shift]
    while scanners.size > 0
      scanners.each do |scanner|
        aligned_scanners.each do |aligned_scanner|
          next if dontmatch[[aligned_scanner.index, scanner.index]]
          if aligned_scanner.match(scanner)
            aligned_scanners.push scanner
            scanners.delete scanner
            break
          else
            dontmatch[[aligned_scanner.index, scanner.index]] = true
          end
        end
      end
    end
    # In the above example, scanners 2 (1105,-1205,1229) and 3 (-92,-2380,-20)
    # 1197 + 1175 + 1249 = 3621
    # scanner 1 must be at 68,-1246,-43 (relative to scanner 0).
    # So, scanner 4 is at -20,-1133,1061 (relative to scanner 0).
    # scanner 2 must be at 1105,-1205,1229 (relative to scanner 0).
    # scanner 3 must be at -92,-2380,-20 (relative to scanner 0)
    aligned_scanners.flat_map do |s1|
      aligned_scanners.map do |s2|
        s1.scanner_position.zip(s2.scanner_position).sum{(_2-_1).abs}
      end
    end.max
  end
end
