require 'benchmark'

class VacantSearch
  attr_reader :k, :array

  def initialize(k)
    @k = k
    a = rand(k) + 1
    b = rand(k) + 1
    while(b == a)
      b = rand(k) + 1
    end
    @vacancies = [a, b] # for tests
    @array = (1..k).reject { |i| i == a || i == b }
  end

  def with_reference
    reference = (1..k).to_a
    test reference - array
  end

  # would use each_with_object, but it is slower here, roughly 25% loss
  def sequental_search
    found = []
    by_position = 1
    array.each do |i|
      unless by_position == i
        found << by_position
        break if found.size == 2
        by_position += 1
      end
      by_position += 1
    end
    found
  end

  private

  def test(found)
    fail "Vacant values are #{@vacancies}, found #{found}" unless (@vacancies - found).empty?
  end
end

vacant_search = nil

Benchmark.bmbm do |x|
  x.report(:fill_in) { vacant_search = VacantSearch.new(1000000) }
  x.report(:with_reference) { vacant_search.with_reference }
  x.report(:sequental_search) { vacant_search.sequental_search }
  x.report(:reduce) { vacant_search.array.reduce(:+) }
end

