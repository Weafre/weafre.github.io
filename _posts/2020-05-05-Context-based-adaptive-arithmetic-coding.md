---
layout: post
title: "Context based adaptive arithmetic coding"
date: 2020-05-05
---
<ol>

<li>Arithmetic Coding </li>
<ul>
<li style="list-style-type:lower-alpha;font-size:120%;color:black;">encoding: using cumula)ve	distribu)on	function of symbols, fit cdf in a range of symbol in sequence and compute new range until end the sequence. Output is any number between final range </li> 
<li style="list-style-type:lower-alpha;font-size:120%;color:black;">decoding: current value --> find range --> symbol, next value  = (last value-low)/last_range --> range --> symbol  </li>
<li style="list-style-type:lower-alpha;font-size:120%;color:black;">how does decoder know the end of sequence: specific in metadata or use a special flag in sequence </li>  
<li style="list-style-type:lower-alpha;font-size:120%;color:black;">fixed point coding: instead of using floating point --> use 16 bit, range from 0 to 65535 --> interger number represent sequence. problem: the precision will be limit, there may be a range when can not futher split (s.t.[182-184])  </li>
<li style="list-style-type:lower-alpha;font-size:120%;color:black;">slove by scaling:  
<ul>
	<li style="list-style-type:lower-alpha;font-size:120%;color:black;">E1: if current range is in the first half (0-32767), output 0 and scale back to full range (0-65535)  </li>
	<li style="list-style-type:lower-alpha;font-size:120%;color:black;">E2: if current range is in the second half (32767-65535), output 1 and scale back to full range (0-65535)  </li>
	<li style="list-style-type:lower-alpha;font-size:120%;color:black;">E3: If our low value is greater than one quarter of our range (16,383), and our high value is less than  
	three quarters of our range (49,151), then we perform an e3 scaling operation to push both
	values outward. and keep performing encoding and use counter to specific howmany time in E3 case, then:   </li>
		<ul>
			<li style="list-style-type:lower-alpha;font-size:120%;color:black;">	If e1 scaling, output a 0 and then n 1's, where n equals the e3 counter.  </li>
			<li style="list-style-type:lower-alpha;font-size:120%;color:black;">	If e2 scaling, output a 1 and then n 0's, where n equals the e3 counter. </li>
		</ul> 
</ul>
</li>
</ul>


<p>Decoding:  After we decode each symbol we check our high and low values. If the criteria for an e-scale has been met, we perform the necessary scaling operation but instead of writing out a 0 or a 1, we shift in the next bit from our input stream</p>

<li>Binary Arithmetic Coding</li> only binary (0 and 1 symbol), 2 symbol cdf 
<li>Adaptive Arithmetic Coding</li> 
		probability model: estimating the occurance of 0 and 1 
	<ul>
		<li style="list-style-type:lower-alpha;font-size:120%;color:black;">start by 0.5/0/5 and if meet 0 --> increase rate of 0, if meet 1--> increase rate of 1 </li>
		<li style="list-style-type:lower-alpha;font-size:120%;color:black;">drawback: cdf may contain inaccurate data leading wrong prob model --> less efficient</li>
	</ul>
		--> context adaptive
<li>Context Adaptive Arithmetic Coding</li>
	<ul>
		<li style="list-style-type:lower-alpha;font-size:120%;color:black;"> inaccurate data--> less efficient but will be recover over time --> how to recover fast?</li>
		<li style="list-style-type:lower-alpha;font-size:120%;color:black;">After each symbol is coded, we examine the set of recently processed symbols and decide whether to
		continue using the current context, or switch to another one.</li>
		<li style="list-style-type:lower-alpha;font-size:120%;color:black;">While a context is active, it's probabilities are updated in the same manner as our adaptive binary
		coder</li>
		<p>??????This gives us the ability to adapt to large or global
		probability changes, while maintaining our ability to adapt to more gradual, or local changes
		explained my self: global change > select the same context/model --> update is perform on that global model
		local change: update only on local model/context
		key: do not mix global model and local model like not context coding.(only have one prob model)</p>
	</ul>
<li>Introduction to arithmetic coding</li>

<figure>
 <img src='{{site.url}}/images/iid.png' alt='independent and identically distributed definition ' style="width:640;height:320px;" class="center"/>
 <figcaption>
 	<center>
Independent and identically distributed
 </center>
 </figcaption>
</figure>

<ul>
<li style="list-style-type:lower-alpha;font-size:120%;color:black;" > Code value representation: coded messages mapped to real numbers in the
interval [0, 1).</li>
<li style="list-style-type:lower-alpha;font-size:120%;color:black;">The straight-line distribution means that if a coding method is optimal then there is
no statistical dependence or redundancy left in the compressed sequences, and consequently
its code values are uniformly distributed on the interval [0, 1). </li>
</ul>



<li>Question</li>
<ul>
	<li style="list-style-type:lower-alpha;font-size:120%;color:black;" >floating point, infinite precision, fixed point</li>
	<li style="list-style-type:lower-alpha;font-size:120%;color:black;">optimal bit/symbol for each symbol = -log2(p(s))</li>
</ul>


</ol>
