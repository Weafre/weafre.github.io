---
layout: post
title: "Video Compression"
date: 2020-01-05
---

<p>In this post, we are going through the key techniques using in video compresison algorithm such as (motion estimation, DCT transformation, quantization..). As you might know, the standards (MPEG-1,2,4; H264, H265(HEVC)) only defines the bitstream syntax and the
decoder behavior without defining the encoder. So, the principles of those techniques are used from the past standards to the state of the arts one.</p>

<img src='{{site.url}}/images/videoCodec.png' alt='Video coding standardization ' style="width:480px;height:320px;">

<figure>
 <img src='{{site.url}}/images/videoCodec.png' alt='Video coding standardization ' style="width:480px;height:320px;"/>
 <figcaption>
 Video coding standardization by <a href="https://www.slideshare.net/MathiasWien/trends-and-recent-developments-in-video-coding-standardization">placekitten.com</a>
 </figcaption>
</figure>

