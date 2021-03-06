#include <stdio.h>
#include <stdlib.h>
#include <opencv/highgui.h>

#include "imageWrapper.h"

using namespace cv;

Mat mat;

unsigned char * readImage(const char* path, long& width, long& height, long& nchannels)
{
  mat = imread(path, IMREAD_COLOR);

  printf("Read Image %s: %d x %d\n", path, mat.cols, mat.rows);

  unsigned char *data = (unsigned char*) mat.data;
  width = mat.cols;
  height = mat.rows;
  nchannels = 3;

  return data;
}

void writeImage(const char* path)
{
  imwrite(path, mat);
}
