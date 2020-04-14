---
layout: post
title: "Image fingerprinting using DNN"
date: 2020-04-14
---

<p>
	There are several techniques for image/video protection. One of the algorithms is watermarking meaning inserting marks into your content to protect content from copying, republishing and making money from it. Those marks can be visible or invisible, but they will introduce distortions on the original content. Another techniques is creating an compact identification for the images. A wellknown techniques is statistic analysis meaning the statistic in the pixel or transformed domain will be collected (hand crafted) and after used to generate a compact content representation which can be stored and identify the original content. Deep Neural Networks is raising as a powerful techniques in the recent years and using DNN to solve image fingerprinting problem is obviously not a bad idea :)). So, what is a good image fingerprinting? yes, after googling we got the answers. It should have at least 2 properties, uniqueness and robustness. Uniqueness means the fingerprint of 2 diffrent image should be diffrent or classified diffrent. And when you modify the image such as adding some text, rotate, screenshoot or changing brightness at a certain level the fingerprint should be the same, it is robustness. 
</p>
<p>
We are going to see how to develop and train a Neural Networks to extract a embedding vector (call fingerprinting) from an image and of course fullfill  uniqueness and robustness requirement.
</p>

