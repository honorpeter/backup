import neurolab as nl
import numpy as np

train_x = [[4,11],[7,340],[10,95],[3,29],[7,43],[5,128]]
input = np.array(train_x)
d = [[1],[0],[1],[0],[1],[0]]
target = np.array(d)
net = nl.net.newff([[3,10],[11,400]],[5,1])
err = net.train(input, target,show=15)









