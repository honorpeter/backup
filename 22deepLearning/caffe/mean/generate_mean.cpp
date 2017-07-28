#include <stdint.h>
#include <algorithm>
#include <string>
#include <utility>
#include <vector>

#include "caffe/proto/caffe.pb.h"
#include "caffe/util/io.hpp"

using namespace caffe;  // NOLINT(build/namespaces)


int main(int argc, char** argv) {

  BlobProto sum_blob;
  // load first datum
  int channels = 3;
  int height = 104;
  int width = 104;
  sum_blob.set_num(1);
  sum_blob.set_channels(channels);
  sum_blob.set_height(height);
  sum_blob.set_width(width);
  int size = channels * height * width;

  for (int i = 0; i < size; ++i) {
    sum_blob.add_data(128.0);
  }
  WriteProtoToBinaryFile(sum_blob, "mean.binarayproto");
  return 0;
}
