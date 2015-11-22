require 'benchmark'
require './src/objects_search'

size = 10_000_000
people = nil

Benchmark.bmbm do |x|
  x.report(:fill_in) { people = People.new(size) }
  x.report(:make_index) { people.make_index }
  x.report(:find_by) { people.find_by([true, (1..50), (10..100), (111..10000), (10000..200000)]) }
end
