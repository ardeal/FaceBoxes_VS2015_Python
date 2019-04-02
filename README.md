# FaceBoxes_VS2015_Python: Modify Faceboxes cource code and build it on VS2015

[![License](https://img.shields.io/badge/license-BSD-blue.svg)](LICENSE)


### Introduction

Faceboxes achieve the state-of-the-art detection performance on several face detection benchmark datasets, including the AFW, PASCAL face, and
FDDB. Code is available at [Faceboxes](https://github.com/sfzhang15/FaceBoxes).

Faceboxes is based on SSD which is custormized from Caffe which is in C/CPP.
Faceboxes build caffe on Linux and generated pycaffe library. The prediction code which calls the trained model is in Python.
This implementation method makes sure the code is high efficiency in C/CPP and top interface is convenient in Python.


In order to run the code on VS2015, in this code base, I forked [Faceboxes](https://github.com/sfzhang15/FaceBoxes) code base, and made some modification on cmake files and cpp code.


### Compared to [Faceboxes](https://github.com/sfzhang15/FaceBoxes), what has been changed 
I forked Faceboxes on March 12 2019, and began to modify it. <br>
The commit ID of original Faceboxes is: eeb7b968cb2e4adc6b4b27c3d358a6333eebf047, <br>
and the start commit ID of my modification is: 3a58e3e41ee69a67f1ee32d7432747b272294bfe

If you are interested in what has been changed compared to Faceboxes code base, Please compare those upper 2 commit IDs.


### How to run this code base
1) git clone  git@github.com:ardeal/FaceBoxes_VS2015_Python.git
2) install VS2015 and Python3.5 on Windows 10. Python3.5 is corresponding to Anaconda3-4.2.0-Windows-x86_64.exe
3) run command build_win_python35_vs2015.cmd in Faceboxes_VS2015_Python/scripts folder on Windows command console.
4) once step 3) is done successfuuly without any error, copy Faceboxes_VS2015_Python/python/caffe folder to Anaconda3/Lib/site-packages. 
5) run FaceBoxes_VS2015_Python/test/fd_pycaffe.py. If nothing is wrong, you probably be able to see the algorithms output in folder: FaceBoxes_VS2015_Python/test/algo_output





### In addition
1) the model file in FaceBoxes_VS2015_Python/models/faceboxes/faceboxes.caffemodel was downloaded from [Faceboxes](https://github.com/sfzhang15/FaceBoxes). It is a CPU-only version model.
2) I have verified the code could be run on CPU correctly, but I didn't verify the GPU version.
3) During your building the code, there might be some errors. Search them on Google or post your questions on github.
4) You are wecome to point out any mistake in my modification.
<br>

### Time needed to run the code on CPU
On Windows 10, Intel(R) Xeon(R) W-2123 CPU @ 3.60GHz, 64G memory and SSD, the time needed to run:
<br>
for 640*480 input image, the time needed is around 60-70ms
<br>
for 320*240 input image, the time needed is around 20-30ms
<br>
<br>
<br>
### Output of the code
I tested a few images, and the output are followed:

<p align="left">
<img src="https://github.com/ardeal/FaceBoxes_VS2015_Python/blob/master/0_Parade_Parade_0_178.jpg" alt="FaceBoxes Performance" width="1024px">
</p>


<p align="left">
<img src="https://github.com/ardeal/FaceBoxes_VS2015_Python/blob/master/1.jpg" alt="FaceBoxes Performance" width="1024px">
</p>



<p align="left">
<img src="https://github.com/ardeal/FaceBoxes_VS2015_Python/blob/master/21_Festival_Festival_21_91.jpg" alt="FaceBoxes Performance" width="1024px">
</p>







