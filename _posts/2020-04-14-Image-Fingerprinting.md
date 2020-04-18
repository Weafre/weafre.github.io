---
layout: post
title: "Image fingerprinting using DNN"
date: 2020-04-14
---

<p style="font-size:100%;">
	There are several techniques for image/video protection. One of the algorithms is watermarking meaning inserting marks into your content to protect content from copying, republishing and making money from it. Those marks can be visible or invisible, but they will introduce distortions on the original content. Another techniques is creating an compact identification for the images. A wellknown techniques is statistic analysis meaning the statistic in the pixel or transformed domain will be collected (hand crafted) and after used to generate a compact content representation which can be stored and identify the original content. Deep Neural Networks is raising as a powerful techniques in the recent years and using DNN to solve image fingerprinting problem is obviously not a bad idea :)). 
</p>
<figure>
 <img src='{{site.url}}/images/munich.jpg' alt='Video coding standardization ' style="width:480px;height:320px;" class="center"/>
 <figcaption>
 	<center>
English garden in Munich, Germany
 </center>
 </figcaption>
</figure>
<p style="font-size:100%;">
	So, what is a good image fingerprinting? yes, after googling we got the answers. It should have at least 2 properties, uniqueness and robustness. Uniqueness means the fingerprint of 2 diffrent image should be diffrent or classified diffrent. And when you modify the image such as adding some text, rotate, screenshoot or changing brightness at a certain level the fingerprint should be the same, it is robustness. We are going to see how to develop and train a Neural Networks to extract a embedding vector (call fingerprinting) from an image and of course fullfill  uniqueness and robustness requirement.
</p>
<p style="font-size:100%;">
Suppose that you are having an image that you want to protect, do not alow anyone modify and republish it. But some how bad guys have it and apply some changes on your images such as changing brightness, adding some text, rotate... And what you want is an algorithm to identify an image from internet is a duplicate of your image or not. Using triplet loss for is the first idea come up in my mind. Our problem can be express as finding a mapping function from pixel space to d-dimensional Euclidean space f(x) (in R<sup>d</sup>).  The formula of triplet loss was shown in figure below. 
</p>
<figure>
 <img src='{{site.url}}/images/tripletloss.png' alt='Video coding standardization ' style="width:480px;height:80px;" class="center"/>
 <figcaption>
 	<center>
Triplet loss.
 </center>
 </figcaption>
</figure>
<p style="font-size:100%;">
where f<sup>a</sup> is the embedding vector of original image called anchor image,f<sup>b</sup> is embedding vector of modified image (positive image) and f<sup>n</sup> is for negative image (any other image except anchor and its replicas). By using this loss, we are maximize L2 distance between anchor and negative while minimize L2 distance between anchor and its duplicates. If we found the optimal function, the embedding of anchor and positive will be identical and diffrent to the embedding of negative (how far is depend on the alpha).
</p>
<figure>
 <img src='{{site.url}}/images/triplet_training.png' alt='Video coding standardization ' style="width:480px;height:80px;" class="center"/>
 <figcaption>
 	<center>
Triplet training.
 </center>
 </figcaption>
</figure>
<p style="font-size:110%;">
There is a problem with the loss function. Let assume that positive distance =0.5, negative distance =0.9 and alpha =0.3. Then the loss will be 0.5-0.9+0.3=-0.1 a negative value and our final loss will be max (0,loss)=0 and our model will not improve even we still want to have a smaller positive distance and bigger negative distance. There is a proposal to solve this problem by limit output by a sigmoid activation function in the last layer and use the loss less triplet loss as below: 
</p>
<figure>
 <img src='{{site.url}}/images/lossLess.png' alt='Video coding standardization ' style="width:480px;height:80px;" class="center"/>
 <figcaption>
 	<center>
Lossless triplet loss
 </center>
 </figcaption>
</figure>
<p> 
[Lossless Tripletloss] https://towardsdatascience.com/lossless-triplet-loss-7e932f990b24
</p>