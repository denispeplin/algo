```
ruby array_search_benchmark.rb
```

```
Rehearsal ---------------------------------------------------------
fill_in_1M              0.070000   0.000000   0.070000 (  0.080417)
fill_in_10M             0.710000   0.050000   0.760000 (  0.831788)
fill_in_100M            7.730000   0.360000   8.090000 (  8.379558)
sequental_search_1M     0.030000   0.000000   0.030000 (  0.032495)
sequental_search_10M    0.470000   0.000000   0.470000 (  0.468323)
sequental_search_100M   3.210000   0.000000   3.210000 (  3.213990)
quicksearch_1Mx100K     1.260000   0.040000   1.300000 (  1.299348)
quicksearch_10Mx100K    1.070000   0.000000   1.070000 (  1.068213)
quicksearch_100Mx100K   1.150000   0.000000   1.150000 (  1.150775)
----------------------------------------------- total: 16.150000sec

                            user     system      total        real
fill_in_1M              0.070000   0.000000   0.070000 (  0.073868)
fill_in_10M             0.750000   0.030000   0.780000 (  0.807587)
fill_in_100M            7.310000   0.350000   7.660000 (  7.966401)
sequental_search_1M     0.050000   0.000000   0.050000 (  0.053419)
sequental_search_10M    0.470000   0.000000   0.470000 (  0.468957)
sequental_search_100M   4.570000   0.000000   4.570000 (  4.568481)
quicksearch_1Mx100K     0.950000   0.000000   0.950000 (  0.945330)
quicksearch_10Mx100K    1.050000   0.000000   1.050000 (  1.049334)
quicksearch_100Mx100K   1.220000   0.000000   1.220000 (  1.222030)
```
