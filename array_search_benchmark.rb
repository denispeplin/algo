require 'benchmark'
require './array_search'

k_10 = 10_000_000
k_100 = 100_000_000

vacant_search_10 = nil
vacant_search_100 = nil

Benchmark.bmbm do |x|
  x.report(:fill_in_10M) { vacant_search_10 = VacantSearch.new(k_10) }
  x.report(:fill_in_100M) { vacant_search_100 = VacantSearch.new(k_100) }
  x.report(:sequental_search_10M) { vacant_search_10.sequental_search }
  x.report(:sequental_search_100M) { vacant_search_100.sequental_search }
  x.report(:quicksearch_100Mx100K) { 100_000.times { vacant_search_100.quicksearch } }
end
