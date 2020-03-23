layout: post
title: "Some coding notes"
date: 2020-03-12
---

<ol>
<li>Default dict</li>
<p>Create a library to store anytype of value with a string as key. Example </p>
<pre><code>
	from collections import defaultdict

	city_state=       defaultdict(list)
	lis=[('vietnam','hanoi'),('vietnam','danang'), ('france','paris')]
	for country,city in lis:
	  city_state[country].append(city)
	for country, city in city_state.items():
	  print(country,','.join(city))
</code></pre>

<p>comment: join() is use to concatenate string of a iterable variable. Output is: </p>
vietnam hanoi,danang
france paris

<li>Space discrete</li>
<pre><code>
action_space=gym.space.discrete(8)
action_space.sample()
x=choice(action_space.n,p=[0,1,0..])
action_space.contains(x)
</code></pre>
</ol>