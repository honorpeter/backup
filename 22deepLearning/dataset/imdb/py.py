import scipy.io as sio
from datetime import datetime,timedelta
import os
import cv2

src_image = "wiki_crop"
tar_image = "target"

def mk_dir(dir):
    if(os.path.exists(dir)):
        return 0
    else:
        os.mkdir(dir)




data = sio.loadmat('wiki_crop/wiki.mat')
dobs = data['wiki']['dob'][0,0][0]
photo_takens = data['wiki']['photo_taken'][0,0][0]
full_paths = data['wiki']['full_path'][0,0][0]
genders = data['wiki']['gender'][0,0][0]
names = data['wiki']['name'][0,0][0]
face_locations = data['wiki']['face_location'][0,0][0]
face_scores = data['wiki']['face_score'][0,0][0]
#dobs = data['wiki']['dob'][0,0][0]

year =[] 
for i in xrange(len(dobs)):
    dob = dobs[i]
    datetime = datetime.fromordinal(int(dob)) + timedelta(days=dob%1) - timedelta(days = 366)
    dobs[i] = datetime.year


label_file = open("label.txt","w")

max_score = max(face_scores)
less_score = max_score*0.7

for i in xrange(len(dobs)):
    if face_scores[i] < less_score:
        continue

    age = int(photo_takens[i]) - int(dobs[i])
    path = full_paths[i][0]
    label_file.write(path+" "+str(age)+"\n")
    src_path = os.path.join(src_image,path)
    tar_path = os.path.join(tar_image,path)
    img = cv2.imread(src_path)
    face_location = face_locations[i][0]
    #if face_location[0] > img.shape[0]:
        #face_location[0] = img.shape[0]
    #if face_location[2] > img.shape[0]:
        #face_location[2] = img.shape[0]
    #if face_location[1] > img.shape[1]:
        #face_location[1] = img.shape[1]
    #if face_location[3] > img.shape[1]:
        #face_location[3] = img.shape[1]
    tar_path_dir = os.path.dirname(tar_path)
    mk_dir(tar_path_dir)
    #img = img[int(face_location[0]):int(face_location[2]),int(face_location[1]):int(face_location[3]),]
    cv2.imwrite(tar_path,img)




