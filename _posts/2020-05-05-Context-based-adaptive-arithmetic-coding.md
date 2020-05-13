---
layout: post
title: "Context based adaptive arithmetic coding"
date: 2020-05-05
---
<ol>
<h1> Arithmetic Coding Introduction</h1>
<li style="font-size:140%;color:blue;" >Arithmetic Coding </li>
<ul>
<li style="list-style-type:circle;font-size:16px;color:black;">Encoding: using cumulative	distribution	function of symbols, fit cdf in a range of symbol in sequence and compute new range until end the sequence. Output is any number between final range </li> 
<li style="list-style-type:circle;font-size:16px;color:black;">Decoding: current value --> find range --> symbol, next value  = (last value-low)/last_range --> range --> symbol  </li>
<li style="list-style-type:circle;font-size:16px;color:black;">How does decoder know the end of sequence: specific in metadata or use a special flag in sequence </li>  
<li style="list-style-type:circle;font-size:16px;color:black;">Fixed point coding: instead of using floating point --> use 16 bit, range from 0 to 65535 --> interger number represent sequence. problem: the precision will be limit, there may be a range when can not futher split (s.t.[182-184])  </li>
<li style="list-style-type:circle;font-size:16px;color:black;">Slove by scaling:  
<ul>
	<li style="list-style-type:circle;font-size:16px;color:black;">E1: if current range is in the first half (0-32767), output 0 and scale back to full range (0-65535)  </li>
	<li style="list-style-type:circle;font-size:16px;color:black;">E2: if current range is in the second half (32767-65535), output 1 and scale back to full range (0-65535)  </li>
	<li style="list-style-type:circle;font-size:16px;color:black;">E3: If our low value is greater than one quarter of our range (16,383), and our high value is less than  
	three quarters of our range (49,151), then we perform an e3 scaling operation to push both
	values outward. and keep performing encoding and use counter to specific howmany time in E3 case, then:   
		<ul>
			<li style="list-style-type:circle;font-size:16px;color:black;">	If e1 scaling, output a 0 and then n 1's, where n equals the e3 counter.  </li>
			<li style="list-style-type:circle;font-size:16px;color:black;">	If e2 scaling, output a 1 and then n 0's, where n equals the e3 counter. </li>
		</ul> 
		</li>
</ul>
</li>
</ul>


<p style="font-size:16px">Decoding:  After we decode each symbol we check our high and low values. If the criteria for an e-scale has been met, we perform the necessary scaling operation but instead of writing out a 0 or a 1, we shift in the next bit from our input stream</p>

<li style="font-size:140%;color:blue;" >Binary Arithmetic Coding</li> Only binary (0 and 1 symbol), 2 symbol cdf 
<li style="font-size:140%;color:blue;" >Adaptive Arithmetic Coding</li> 
		<p style="font-size:16px">Probability model: estimating the occurance of 0 and 1 </p>
	<ul>
		<li style="list-style-type:circle;font-size:16px;color:black;">Start by 0.5/0/5 and if meet 0 --> increase rate of 0, if meet 1--> increase rate of 1 </li>
		<li style="list-style-type:circle;font-size:16px;color:black;">Drawback: cdf may contain inaccurate data leading wrong prob model --> less efficient --> context adaptive</li>
	</ul>
		
<li style="font-size:140%;color:blue;" >Context Adaptive Arithmetic Coding</li>
	<ul>
		<li style="list-style-type:circle;font-size:16px;color:black;"> Inaccurate data--> less efficient but will be recover over time --> how to recover fast?</li>
		<li style="list-style-type:circle;font-size:16px;color:black;">After each symbol is coded, we examine the set of recently processed symbols and decide whether to
		continue using the current context, or switch to another one.</li>
		<li style="list-style-type:circle;font-size:16px;color:black;">While a context is active, it's probabilities are updated in the same manner as our adaptive binary
		coder</li>
		<p style="font-size:16px">This gives us the ability to adapt to large or global
		probability changes, while maintaining our ability to adapt to more gradual, or local changes
		explained my self:  Global change > select the same context/model --> update is perform on that global model  
		Local change: update only on local model/context  
		Key: do not mix global model and local model like not context coding.(only have one prob model)</p>
	</ul>

<h1> Introduction to arithmetic coding (book)</h1>
<li style="font-size:140%;color:blue;" >Introduction to arithmetic coding</li>

<figure>
 <img src='{{site.url}}/images/iid.png' alt='independent and identically distributed definition ' style="width:680;height:380px;" class="center"/>
 <figcaption>
 	<center>
Independent and identically distributed [wikipedia]
 </center>
 </figcaption>
</figure>

<ul>
<li style="list-style-type:circle;font-size:16px;color:black;" > Code value representation: coded messages mapped to real numbers in the
interval [0, 1).For example a mapping procedure: put 0. before code, and interpreting the result as a number in
base-D notation</li>
<figure>
 <img src='{{site.url}}/images/codeValue.png' alt='independent and identically distributed definition ' style="width:400;height:100px;" class="center"/>
 <figcaption>
 	<center>
Simple Code value generated from coded symbols(base 2 in this case)
 </center>
 </figcaption>
</figure>

<li style="list-style-type:circle;font-size:16px;color:black;">How to measure the efficiency of a coding scheme? From Shannon’s information theory [1] we know that, if a
coding method is optimal, then the cumulative distribution [22] of its code values has to be
a straight line from point (0, 0) to point (1, 1). The straight-line distribution means that if a coding method is optimal then there is
no statistical dependence or redundancy left in the compressed sequences, and consequently
its code values (the code value will independent) are uniformly distributed on the interval [0, 1). </li>
<figure>
 <img src='{{site.url}}/images/cdfCodeValue.png' alt='independent and identically distributed definition ' style="width:400;height:400px;" class="center"/>
 <figcaption>
 	<center>
Cummulative distribution of code value for diffrent coding scheme.
 </center>
 </figcaption>
</figure>
<li style="list-style-type:circle;font-size:16px;color:black;"> One flnal comment about code values: two inflnitely long difierent sequences can correspond to the same code value. </li>
</ul>
<li style="font-size:140%;color:blue;" >Arithmetic coding</li>
<ul>
	<li style="list-style-type:circle;font-size:16px;color:black;">Generating final interval: In order to have an uniform distribution of code value (optimal), the interval lengths must be reduced by factors equal to symbol probabilities. (For example, if 20% of the
sequences start with symbol \0", then 20% of the code values must be in the interval
assigned to those sequences, which can only be achieved if we assign to the flrst symbol
\0" an interval with length equal to its probability, 0.2. The same reasoning applies to
the assignment of the subinterval lengths: every occurrence of symbol \0" must result
in a reduction of the interval length to 20% its current length. This way, after encoding several symbols the distribution of code values should be a very good approximation
of a uniform distribution. Assure the fairness between symbols) </li>
<li style="list-style-type:circle;font-size:16px;color:black;"> Choose code value by interval value ln: </li>
<figure>
 <img src='{{site.url}}/images/selectnumberofbit.png' alt='independent and identically distributed definition ' style="width:120;height:50px;" class="center"/>
 <figcaption>
 	<center>
Number of bit of code value
 </center>
 </figcaption>
</figure>
<li style="list-style-type:circle;font-size:16px;color:black;"> Decoding process: How to stop the decoding process :in manifest file or flag symbol (which is coded only at the end of the data
sequence, and assign to this symbol the smallest probability value allowed by the
encoder/decoder. when meet this prob --> end) Arithmetic coding guarantee that difierent sequences cannot produce the same code value </li>
</ul>
<li style="font-size:140%;color:blue;" >Optimality of Arithmetic Coding: the bit per symbol converge to entropy of the source</li>
<figure>
 <img src='{{site.url}}/images/optimality.png' alt='independent and identically distributed definition ' style="width:140;height:140px;" class="center"/>
 <figcaption>
 	<center>
Average bits per symbol
 </center>
 </figcaption>
</figure>
<ul>
	<li style="list-style-type:circle;font-size:16px;color:black;"> The result above is for 2 symbol output (0 and 1, base 2) to represent code value, the code value can be represented by using D symbol output. For example v3 = 0:202001113(base 3)=0.742722146, which means
that the sequence S = {2; 1; 0; 0; 1; 3} can be transmitted as the sequence of electrical
signals {+V, 0, +V, 0, 0, -V, -V, -V} </li>
</ul>
<li style="font-size:140%;color:blue;" > Arithmetic Coding Properties 
<ul>
	<li style="list-style-type:circle;font-size:16px;color:black;"> Dynamic Sources: generalize arithmetic coding for situations where the probabilities
change for each symbol coded, i.e., the k-th symbol in the data sequence S is a random
variable with probabilities pk and distribution ck. For example: Instead of having a single input alphabet with M symbols, we have a sequence of alphabet sizes {M1; M2; : : : ; MN}.</li>

<li style="list-style-type:circle;font-size:16px;color:black;">Encoder and Decoder Synchronized Decisions: the probability of sequence does not have to transparent to decoder as long as the probability is updated along sequence, from previous decoded symbol.</li>

<figure>
 <img src='{{site.url}}/images/sourcemodeling.png' alt='independent and identically distributed definition ' style="width:400;height:400px;" class="center"/>
 <figcaption>
 	<center>

 </center>
 </figcaption>
</figure>

<li style="list-style-type:circle;font-size:16px;color:black;">Separation of Coding and Source Modeling: it allows us to develop
complex compression schemes without worrying about the details in the coding algorithm,
and/or use them with difierent coding methods and implementations..</li>
<li style="list-style-type:circle;font-size:16px;color:black;">Interval Rescaling: the actual intervals used during coding depend on the initial interval and the previously coded data, but the
proportions within subdivided intervals do not. This shows that we can scale interval along with scale code value obtained at a certained level to have a wider interval. And the decoder will need to know information about scaling in order to recover the original code value and start decoding.</li>
<li style="list-style-type:circle;font-size:16px;color:black;">
Approximate Arithmetic: Inexact multiplications are mathematically equivalent to making approximations in the
source model and then using exact multiplications (see example 7). And we do not have to worry about the inexact probabilities, the decoder can decode the exact input sequence as long as encoder and decoder have the same distribution model i.e., if the decoder is making exactly the
same approximations as the encoder. Therefore we have to pay the compression performance, the coding archieve the optimal performance only when the distribution of symbol are exactly the same as the real distribution. But the loss to pay is reasonably small if the multiplicationi approximate at 4 digit(shown in equation 1.43)</li>

<li style="list-style-type:circle;font-size:16px;color:black;">
Conditions for Correct Decoding:
<ul>
	<li style="list-style-type:square;font-size:16px;color:black;">The interval length must be positive and intervals must be disjoint. Decode error occurs whenever a code value belongs to the intersection. Or when  then the interval length collapses to zero but  we also have to be sure that all symbol probabilities are larger than a
minimum value deflned by the arithmetic precision</li>
		<li style="list-style-type:square;font-size:16px;color:black;">Sub-intervals must be nested: We have to be sure that the accumulation of the approximation errors, as we continue coding
symbols, does not move the interval base to a point outside all the previous intervals. This condition is not guarantee in the approximate case. This solved by setting aside small regions, indicated as gray areas in Figure below, that are
not used for coding, and serve as a safety net allow the sub interval will always inside the previous interval. With reasonable precision, leakage can be made extremely small. For
instance, if p(s)=p0(s) = 1:001 (low precision) then leakage is less than 0.0015 bits/symbol.</li>
<li style="list-style-type:square;font-size:16px;color:black;">Inverse arithmetic operations must not produce error accumulation. Decoder also introduce approximate subtraction and division, which have to be consistent with the encoder’s approximations</li>

</ul>


</li>
</ul>
</li>
<figure>
 <img src='{{site.url}}/images/leakage.png' alt='independent and identically distributed definition ' style="width:400;height:400px;" class="center"/>
 <figcaption>
 	<center>

 </center>
 </figcaption>
</figure>


<h1> Arithmetic Coding Implementation (book)</h1>

<li style="font-size:140%;color:blue;" >Coding with Fixed-Precision Arithmetic

<ul>
<li style="list-style-type:circle;font-size:16px;color:black;">Coding with Fixed-Precision Arithmetic:
<ul>
	<li style="list-style-type:square;font-size:16px;color:black;"> Problem of precision solved by using P-bits register to save interval length, and results of multiplications, all bit with significance smaller that that bit are truncated.</li>
<figure>
 <img src='{{site.url}}/images/renomalization.png' alt='independent and identically distributed definition ' style="width:400;height:220px;" class="center"/>
 <figcaption>
 	<center>
Renormalization scaling,using this we will always have b in [0,1) and l in (0.5,1]
 </center>
 </figcaption>
</figure>

<figure>
 <img src='{{site.url}}/images/codestructure.png' alt='independent and identically distributed definition ' style="width:400;height:220px;" class="center"/>
 <figcaption>
 	<center>
Interval length and base in binary representation.
 </center>
 </figcaption>
</figure>


<li style="list-style-type:square;font-size:16px;color:black;"> Problem of implementing the additions in when there is a large difierence between the magnitudes of the
interval base and interval length. and this can be solved by scaling interval. If we use binary output with limited Precision at P-bit level, we can represent our base and interval length (in binary) into 2 part. Phe first part has already save in buffer (settled and outstanding) and the second part is P bits of current base and interval + insignificant bits treated as zeros. All outstanding bits still can be change during the encoding, even they are already in buffer and they always have the form '01','011', or '0111'.... This come from the fact that:</li>
<figure>
 <img src='{{site.url}}/images/maxbase.png' alt='independent and identically distributed definition ' style="width:100;height:60px;" class="center"/>
 <figcaption>
 	<center>
The child base can not be exceed the upper bound of parent's interval.
 </center>
 </figcaption>
</figure>



</ul>

</li>
<li style="list-style-type:circle;font-size:16px;color:black;">Implementation with Bufier Carries: buffer carries means when the next base value (b+c(sk)*l>1), this happend because the interval has been scaled. When b>1, all bits in outstanding part are invert (0 to 1, 1 to 0), and some bits will turn to settle (before '01'). When doing encoding, b>0.5 --> output 1, b<0.5-->output 0. Some key points: sequential repetition of interval
resizing and renormalizations, use 2 type of renormalization, only have to select code value at final step. See the full algorithm in the book. </li>	
</ul>
<figure>
 <img src='{{site.url}}/images/encoding8bit.png' alt='independent and identically distributed definition ' style="width:40;height:300px;" class="center"/>
 <figcaption>
 	<center>

 </center>
 </figcaption>
</figure>




<li style="font-size:140%;color:blue;" >Efficient output: 
<ul>
	<li style="list-style-type:circle;font-size:16px;color:black;"> The encoding with short register cost CPU usage to normalize interval, shifting bit, this will cost many CPU cirles. If we use longer register (16 bits for example), we can shift more bit to output buffer and increase precision therefore improve the performance. This equivalent to using D symbols at output alphabet. For example, moving groups of 1, 2, 4, or 8 bits at a time, corresponds to output alphabets
with D = 2, 4, 16, and 256 symbols, respectively. Only 1 thing change is renormalization step having more threshold theta and smaller number of time interval have to scale. See the book </li>
<figure>
 <img src='{{site.url}}/images/encoding16bit.png' alt='independent and identically distributed definition ' style="width:40;height:300px;" class="center"/>
 <figcaption>
 	<center>

 </center>
 </figcaption>
</figure>

</ul>

 </li>

<li style="font-size:140%;color:blue;" >Alternative Renormalizations: to keep interval at diffrent interval [0.5 -1] or [0.75-1.5]...
</li>

</li>

<h1> Adaptive Coding (book)</h1>
<p> To have a good compression rate, we need to have a good model of data source, but information sources are normaly complex. Modeling
complex sources by decompose the source data in difierent categories with assumption: in each category the source symbols are approximately
independent and identically distributed. In general, we do not know the probabilities of the symbols in each category. Adaptive coding estimate the probability of symbol while encoding the source. Adaptive arithmetic coding = dynamic probability estimation + arithmetic coding.</p>
<li style="font-size:140%;color:blue;" >Strategies for Computing Symbol Distributions
<ul>
<li style="list-style-type:circle;font-size:16px;color:black;">  
Use a fixed probability model extracted from exist data source, typical data. This approach can be efficient in some case but typically the model is not dynamic (the model for english text is not fit for spanish text) or incorrect when apply for another sources which require model extracted from very large amount of data (overfitting or underfitting). 
</li>
<li style="list-style-type:circle;font-size:16px;color:black;">  
Use predefined distribution with parameter estimated from realdata. For example, assume data has Gaussian distribution and estimate mean and standard.
</li>
<li style="list-style-type:circle;font-size:16px;color:black;">  
Two-pass encoding, first pass will do statistic analysis about the source, the second pass use the model from the first pass and encode it. And the vector p or c are passed to decoder. Disavantage: computation overhead. but have a good compression rate.
</li>
<li style="list-style-type:circle;font-size:16px;color:black;">  
Update distribution based on occurence of previously encoded symbols</li>

</ul>
</li>















<li style="list-style-type:circle;font-size:16px;color:black;">  </li>

<li style="font-size:140%;color:blue;" >Questions</li>
<ul>
	<li style="list-style-type:circle;font-size:16px;color:black;" >floating point, infinite precision, fixed point</li>
	<li style="list-style-type:circle;font-size:16px;color:black;">optimal bit/symbol for each symbol = -log2(p(s))</li>
</ul>


</ol>
