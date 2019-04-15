require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
        arr = self.dup
        if accumulator == nil 
              accumulator = arr[0]
              arr = arr[1..-1]
        end   

        arr.each { |el| accumulator = prc.call(accumulator, el)}

        accumulator
   end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
    (2...num).each { |n| return false if num % n == 0}
    true
end 

def primes(num)
    prime_arr = []
    (2..num*100).each do |el|

      prime_arr << el if is_prime?(el) 
      return prime_arr if prime_arr.length == num
    end
    prime_arr
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
    return [1] if num == 1
    return [1,1] if num == 2

    fact = factorials_rec(num - 1)
    fact << (fact.last * (num - 1))
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups

    dup_hash = Hash.new{ |h, k| h[k] = [] }

      self.each_with_index do |ele, idx|
        
            dup_hash[ele] << idx if ele == self[idx]
      end
      dup_hash.select{ |_, v| v.count > 1 }
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings

      sym_str = [] 
       
       (0...self.length-1).each do |idx_1|

        (idx_1 +1...self.length).each do |idx_2|
          sub = self[idx_1..idx_2]
          if !sym_str.include?(sub) && sub == sub.reverse
            sym_str << sub 
          end
        end
      end
      sym_str

  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
        return self if self.length <= 1 
        prc ||= Proc.new{ |a, b| a <=> b }

        mid = self.length / 2 
        left_sort = self.take(mid).merge_sort(&prc)
        right_sort = self.drop(mid).merge_sort(&prc) 

        Array.merge(left_sort, right_sort, &prc)
  end

  private
  def self.merge(left, right, &prc)
        merged_arr = [] 

              until left.empty? || right.empty?
                case prc.call(left.first, right.first)
                  when -1 
                    merged_arr << left.shift 
                  when 0
                    merged_arr << left.shift 
                  when 1
                    merged_arr << right.shift
                end
              end
          merged_arr + left + right
   
  end
end
