require 'benchmark'
require './array_search'

GC.disable

k = 100_000_000

vacant_search = nil

Benchmark.bmbm do |x|
  x.report(:fill_in) { vacant_search = VacantSearch.new(k) }
  x.report(:sequental_search) { vacant_search.sequental_search }
  x.report(:quicksearch) { vacant_search.quicksearch }
end
