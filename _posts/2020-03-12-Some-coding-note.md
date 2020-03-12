layout: post
title: "Some note while doing code"
date: 2020-03-12
---

1/ defaultdict:
create a library to store anytype of value with a string as key. Example

from collections import defaultdict

city_state=       defaultdict(list)
lis=[('vietnam','hanoi'),('vietnam','danang'), ('france','paris')]
for country,city in lis:
  city_state[country].append(city)
for country, city in city_state.items():
  print(country,','.join(city))

comment: join() is use to concatenate string of a iterable variable. Output is: 
vietnam hanoi,danang
france paris
