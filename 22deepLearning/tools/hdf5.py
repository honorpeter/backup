import h5py, os
import caffe
import numpy as np

SIZE = 224 # fixed size to all images
with open( 'train.txt', 'r' ) as T :
    lines = T.readlines()
# If you do not have enough memory split data into
# multiple batches and generate multiple separate h5 files
X = np.zeros( (len(lines), 1, SIZE, SIZE), dtype='f4' ) 
y = np.zeros( (len(lines),1), dtype='f4' )
z = np.zeros( (len(lines),1), dtype='f4' )
q = np.zeros( (len(lines),1), dtype='f4' )
for i,l in enumerate(lines):
    sp = l.split(' ')
    path_tmp = "train_data/" + str(sp[0])
    img = caffe.io.load_image( path_tmp )
    img = caffe.io.resize( img, (SIZE, SIZE, 1) ) # resize to fixed size
    # you may apply other input transformations here...
    # Note that the transformation should take img from size-by-size-by-3 and transpose it to 3-by-size-by-size
    # for example
    #transposed_img = img.transpose((2,0,1))[::-1,:,:] # RGB->BGR
    transposed_img = img.transpose((2,0,1)) # RGB->BGR
    X[i] = transposed_img
    y[i] = float(sp[1])
    z[i] = float(sp[2])
    q[i] = float(sp[3])
with h5py.File('train.h5','w') as H:
    H.create_dataset( 'data', data=X ) # note the name X given to the dataset!
    H.create_dataset( 'label', data=y ) # note the name y given to the dataset!
    H.create_dataset( 'label_bu', data=z ) # note the name y given to the dataset!
    H.create_dataset( 'label_ph', data=q ) # note the name y given to the dataset!
with open('train_h5_list.txt','w') as L:
    L.write( 'train.h5' ) # list all h5 files you are going to use



#train.prototxt 怎么写
#layer {
   #name: "input"
   #type: "HDF5Data"
   #top: "data" # same name as given in create_dataset!
   #top: "label"
   #top: "label_bu"
   #top: "label_ph"
   #hdf5_data_param {
     #source: "train_h5_list.txt" # do not give the h5 files directly, but the list.
     #batch_size: 32
   #}
 #
 #}

