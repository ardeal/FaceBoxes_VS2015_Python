#! /usr/bin/env python
"""
Author: Zhiqiang Liang
Program: fd_faceboxes.py
Date: Tuesday, Mar. 12 2019
Description: re-write demo.py functionalities of faceboxes.
"""

import sys
import os
import numpy as np
import matplotlib.pyplot as plt
import cv2
import argparse

caffe_root = r'../'
# os.chdir(caffe_root)
sys.path.insert(0, caffe_root + '/python')
import caffe
import datetime



def imglist_in_folder(root_dir, ext_names):

    imglist = []
    for root, dirs, files in os.walk(root_dir, topdown=False):
        for i in range(len(files)):
            filename, fileext = os.path.splitext(files[i])
            if fileext in ext_names:
                imglist.append(os.path.join(root, files[i]))
    for i in range(len(imglist)):
        print(imglist[i])

    aaaaaa=0
    return imglist

def predict_imgs_infolder(root_dir, ext_names):
    algo_output_folder = 'algo_output'
    if not os.path.exists(algo_output_folder):
        os.makedirs(algo_output_folder)

    img_list = imglist_in_folder(root_dir, ext_names)
    fd = FD_Faceboxes(args.network_file, args.trained_model_file)
    for i in range(len(img_list)):
        img_path = img_list[i]
        img_path = "D:/datasets/test_images/fd/0_Parade_Parade_0_178.jpg"
        filepath, fullfilename = os.path.split(img_path)

        shortname, extension = os.path.splitext(fullfilename)


        t0 = datetime.datetime.now()
        prediction = fd.predict_one_image(img_path)
        t1 = datetime.datetime.now()
        delta_t = t1 - t0
        msecond = delta_t.microseconds / 1000 + delta_t.seconds * 1000
        print(msecond)


        det_label = prediction[0, 0, :, 1]
        det_conf = prediction[0, 0, :, 2]
        det_xmin = prediction[0, 0, :, 3]
        det_ymin = prediction[0, 0, :, 4]
        det_xmax = prediction[0, 0, :, 5]
        det_ymax = prediction[0, 0, :, 6]

        # face boxes with confidence greater than args.face_threshold.
        top_indices = [i for i, conf in enumerate(det_conf) if conf >= args.face_threshold]
        top_conf = det_conf[top_indices]
        top_xmin = det_xmin[top_indices]
        top_ymin = det_ymin[top_indices]
        top_xmax = det_xmax[top_indices]
        top_ymax = det_ymax[top_indices]

        img = cv2.imread(img_path)
        if img is None:
            print("can not open image:", img_path)
            return

        for i in range(top_conf.shape[0]):
            xmin = int(round(top_xmin[i] * img.shape[1]))
            ymin = int(round(top_ymin[i] * img.shape[0]))
            xmax = int(round(top_xmax[i] * img.shape[1]))
            ymax = int(round(top_ymax[i] * img.shape[0]))

            cv2.rectangle(img, (xmin, ymin + 4), (xmax, ymax), (0, 255, 0), 1)
            font_size = 1 if (xmax-xmin)/60.0>1 else (xmax-xmin)/60.0
            cv2.putText(img, '{:.3f}'.format(top_conf[i]), (xmin, ymin), cv2.FONT_HERSHEY_COMPLEX_SMALL, font_size, (0, 255, 0))
            cv2.putText(img, 'face_threshold == {}'.format(args.face_threshold), (20, 20), cv2.FONT_HERSHEY_COMPLEX_SMALL, 1, (0, 255, 0))

        cv2.imshow('facebox', img)
        cv2.imwrite(os.path.join(algo_output_folder, fullfilename), img)

        cv2.waitKey(1)
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=0

    aaaaaa=0
    return

class FD_Faceboxes():
    def __init__(self, model_def, model_weights):
        # caffe.set_device(0)
        # caffe.set_mode_gpu()
        caffe.set_mode_cpu()

        self.model_def = model_def
        self.model_weights = model_weights
        self.net = caffe.Net(self.model_def, self.model_weights, caffe.TEST)
        return

    def predict_one_image(self, image_path):
        image_file = image_path
        image = caffe.io.load_image(image_file)
        im_scale = 1.0
        if im_scale != 1.0:
            image = cv2.resize(image, None, None, fx=im_scale, fy=im_scale, interpolation=cv2.INTER_LINEAR)
        self.net.blobs['data'].reshape(1, 3, image.shape[0], image.shape[1])
        transformer = caffe.io.Transformer({'data': self.net.blobs['data'].data.shape})
        transformer.set_transpose('data', (2, 0, 1))
        transformer.set_mean('data', np.array([104, 117, 123]))  # mean pixel
        transformer.set_raw_scale('data', 255)  # the reference model operates on images in [0,255] range instead of [0,1]
        transformer.set_channel_swap('data', (2, 1, 0))  # the reference model has channels in BGR order instead of RGB
        transformed_image = transformer.preprocess('data', image)
        self.net.blobs['data'].data[...] = transformed_image

        detections = self.net.forward()['detection_out']

        return detections

def parse_args():
    parser = argparse.ArgumentParser(description='Faceboxes prediction of the original code of the author', formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--trained_model', dest='trained_model_file', default='../models/faceboxes/faceboxes.caffemodel', help='model file of facboxes', type=str)
    parser.add_argument('--network_file', dest='network_file', default='../models/faceboxes/deploy.prototxt', help='network_file', type=str)
    parser.add_argument('--face_threshold', dest='face_threshold', default=0.4, help='threshold of face', type=float)

    args = parser.parse_args()
    return args

if __name__ == '__main__':

    # --------------------------------------
    args = parse_args()

    root_dir = 'test_images'
    root_dir = r'D:\datasets\test_images\fd_fl'
    ext_names = ['.jpg', '.png']
    predict_imgs_infolder(root_dir, ext_names)

    aaaaaaaaaaaaaaa=0

