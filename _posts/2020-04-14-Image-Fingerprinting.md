---
layout: post
title: "Image embedding using DNN"
date: 2020-04-14
---

<p style="font-size:110%;">
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
<p style="font-size:110%;">
	So, what is a good image fingerprinting? yes, after googling we got the answers. It should have at least 2 properties, uniqueness and robustness. Uniqueness means the fingerprint of 2 diffrent image should be diffrent or classified diffrent. And when you modify the image such as adding some text, rotate, screenshoot or changing brightness at a certain level the fingerprint should be the same, it is robustness. We are going to see how to develop and train a Neural Networks to extract a embedding vector (call fingerprinting) from an image and of course fullfill  uniqueness and robustness requirement.
</p>
<p style="font-size:110%;">
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
<p style="font-size:110%;">
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

<p style="font-size:110%;">
This loss will never be smaller than 0 like the previous loss function, but using sigmoid activation introduces another problem. The model can learn something but sigmoid saturate and vanishing at some point which leads embedding vector converge to only 0 or 1. We can solve this using weighted negative distance to reduce the effect of negative distance on the loss: 
</p>
<figure>
 <img src='{{site.url}}/images/weightedloss.png' alt='Video coding standardization ' style="width:480px;height:80px;" class="center"/>
 <figcaption>
 	<center>
Weighted triplet loss
 </center>
 </figcaption>
</figure>
<p style="font-size:110%;">
By using weight theta smaller than 1, gurantee at a certain level that the loss will not be smaller than 0. Assuming theta=0.4 and keeping positive distance =0.5, negative distance =0.9 and alpha =0.3 as in the previous example. Now the loss will be: 0.5-0.4*0.9+0.3=0.44 greater than 0, and model will keep learing to have a bigger negative distance. In this example, negative distance have to be greater than 2 assumming that positive distance still equal 0.5.
</p>
<figure>
 <img src='{{site.url}}/images/images.png' alt='Video coding standardization ' style="width:480px;height:360px;" class="center"/>
 <figcaption>
 	<center>
Sample modified images 
 </center>
 </figcaption>
</figure>
<p style="font-size:110%;">
For training, i use 2165 images from imagesNet as anchors. Applying some modifications such that adding text, changing brightness, screenshoot, mixing content to the anchor to create positive images. For negative, I use any image in dataset which are not anchor and positives. The same procedure also perform on another 1000 image from flick used as test dataset. All images are converted to black and white image to remove color similarity information. Some sample modified images before converting to black and white are shown above.
</p>
<figure>
 <img src='{{site.url}}/images/model.png' alt='Video coding standardization ' style="width:480px;height:360px;" class="center"/>
 <figcaption>
 	<center>
Siamese model
 </center>
 </figcaption>
</figure>
<p style="font-size:110%;">
I use 3 identical ResNet 18 base model to train triplet loss (Deep Network block in the figure above) with Adam optimizer (lr 5e-4 and then 1e-4 to avoid overfitting). Note that I do not using activation fuction in the last Dense 128 layer. The reason for doing that is using activation introduce lossing information from last Dense layer (Relu remove all negative value, sigmoid saturate all value out of range [0, 1]. After training for over 90 epochs when training loss is about 3.2 and validation loss equal 0.7, I stop the training (see the loss figure below). I use the base model to extract embedding vector of 1000 test images and save it as embedding database.  1000 randomly choosing test positive and 1000 negative image are use to comput confusion matrix. The test phase was perfomed  and final result are average over 10 runs. Recall, precision and F1 score are 0.95, 0.93 and 0.94 respectively.
</p>
<figure>
 <img src='{{site.url}}/images/loss.png' alt='Video coding standardization ' style="width:480px;height:360px;" class="center"/>
 <figcaption>
 	<center>
Loss over 90 epochs
 </center>
 </figcaption>
</figure>

<figure>
 <img src='{{site.url}}/images/wronglyclassified.jpeg' alt='Video coding standardization ' style="width:480px;height:360px;" class="center"/>
 <figcaption>
 	<center>
Wrongly classified image and distance
 </center>
 </figcaption>
</figure>
<p style="font-size:110%;"> 
[Lossless Tripletloss] https://towardsdatascience.com/lossless-triplet-loss-7e932f990b24
[Model] https://towardsdatascience.com/image-similarity-using-triplet-loss-3744c0f67973
</p>