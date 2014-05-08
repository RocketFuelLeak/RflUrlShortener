module Bijective
    class Encoder
        ALPHABET = "xJfmOnGq4phMrdH5y07oLBbUc3NuDkzZK891FCRPvI2alwATWg6tiESQVXjeYs".split(//)
        BASE = ALPHABET.length

        def self.encode(i)
            return ALPHABET[0] if i == 0
            s = ''
            while i > 0
                i, n = i.divmod(BASE)
                s << ALPHABET[n]
            end
            s.reverse
        end

        def self.decode(s)
            s.chars.reduce (0) { |n, ch| n * BASE + ALPHABET.index(ch) }
        end
    end
end
