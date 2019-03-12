# FaceBoxes_VS2015: Modify Faceboxes cource code and build it on VS2015

[![License](https://img.shields.io/badge/license-BSD-blue.svg)](LICENSE)


### Introduction

Faceboxes achieve the state-of-the-art detection performance on several face detection benchmark datasets, including the AFW, PASCAL face, and
FDDB. Code is available at [Faceboxes](https://github.com/sfzhang15/FaceBoxes).

Faceboxes is based on SSD which is custormized from Caffe which is in C/CPP.
Faceboxes build caffe on Linux and generatey pycaffe library. The prediction code which call the trained model is in Python.
This implementation method makes sure the code is high efficiency in C/CPP and top interface is convenient in Python.


In order to run the code on VS2015, in this code base, I forked Faceboxes code base, and made some modification on cmake files and cpp code.


### Compared to [Faceboxes](https://github.com/sfzhang15/FaceBoxes), what has been changed 
I forked Faceboxes on March 12 2019, and began to modify it. <br>
The commit ID of original Faceboxes is: eeb7b968cb2e4adc6b4b27c3d358a6333eebf047, <br>
and the start commit ID of my modification is: a58a27004ddb19b43eeecbae9f173f01e934d081

If you are interested in what has been changed compared to Faceboxes code base, Please compare those upper 2 commit IDs.


### How to run this code base
1) git clone git@github.com:ardeal/FaceBoxes_VS2015.git
2) install VS2015 and Python3.5 on Windows 10. Python3.5 is corresponding to Anaconda3-4.2.0-Windows-x86_64.exe
3) run command build_win_python35_vs2015.cmd in Faceboxes_VS2015/scripts folder on Windows command console.
4) once step 3) is done successfuuly without any error, copy Faceboxes_VS2015/python/caffe folder to Anaconda3/Lib/site-packages. 
5) run FaceBoxes_VS2015_0/testfd_pycaffe.py. If nothing is wrong, you probably be able to see the algorithms output in folder: FaceBoxes_VS2015_0/test/algo_output





### In addition
1) the model file in FaceBoxes_VS2015_0/models/faceboxes/faceboxes.caffemodel was downloaded from [Faceboxes](https://github.com/sfzhang15/FaceBoxes). It is a CPU-only version model.
2) During your building the code, there might be some errors. Search them on Google or post your questions on github.
3) You are wecome to point out any mistake in my modification.

