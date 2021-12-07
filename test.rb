a=`dd`.split.filter{_1.scan(/[0-9]/) == []}.map(&:upcase).uniq
p a.filter{_1.scan(/[^AEIOU]/).size>4 && _1.scan(/[AEIOU]/).first=='O'}