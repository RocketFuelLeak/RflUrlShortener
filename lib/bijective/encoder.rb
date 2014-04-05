module Bijective
    class Encoder
        ALPHABET = "xJfmOnGq4phMrdH5y07oLBbUc3NuDkzZK891FCRPvI2alwATWg6tiESQVXjeYs".split(//)
        BASE = ALPHABET.length

        def self.encode(i)
            return ALPHABET[0] if i == 0
            s = ''
            while i > 0
                s << ALPHABET[i.modulo(BASE)]
                i /= BASE
            end
            s.reverse
        end

        def self.decode(s)
            i = 0
            s.each_char { |c| i = i * BASE + ALPHABET.index(c) }
            i
        end
    end
end
