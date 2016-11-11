// ------------------------------------------------------------------
// Fast R-CNN
// Copyright (c) 2015 Microsoft
// Licensed under The MIT License [see fast-rcnn/LICENSE for details]
// Written by Ross Girshick
// ------------------------------------------------------------------

#include <cfloat>
#include <math.h>
#include"caffe/gpu_nms.hpp"
#include "caffe/fast_rcnn_layers.hpp"
#include<boost/timer.hpp>
#include <armadillo>

#define max(a,b)(a>b?a:b)
#define min(a,b)(a>b?b:a)
namespace caffe {

typedef struct tagCtrs
{
	float x_ctr;
	float y_ctr;
	float w;
	float h;
}CTRS,*PCTRS;

typedef struct tagCRect
{
	int x;
	int y;
	int width;
	int height;
}CRECT,*PCRECT;

typedef struct tagCandidatebox
{
	float fScore;//class Prob
	int nLabel;// class label
	int nBoxID;//candi box id
	CRECT rcPos;//class position
}CANDIDATEBOX,*PCANDIDATEBOX;

bool lessmark(const CANDIDATEBOX& s1,const CANDIDATEBOX& s2)  
{  
	return s1.fScore < s2.fScore;  
}

bool greatermark(const CANDIDATEBOX& s1,const CANDIDATEBOX& s2)  
{  
	return s1.fScore > s2.fScore;  

}

bool compfun(vector<float> v1,vector<float> v2)  
{  
	return v1[v1.size() -1] > v2[v2.size() - 1];

}



float Overlap(vector<float> rc1,vector<float> rc2)
{
	float width1 = rc1[2] - rc1[0] + 1;
	float height1 = rc1[3] - rc1[1] + 1;
	float width2 = rc2[2] - rc2[0] + 1;
	float height2 = rc2[3] - rc2[1] + 1;
	float area1 = width1 * height1;
	float area2 = width2 * height2;
	if (area2 <= 0 || area1 <= 0)
	{
		return 0.0f;
	}
	float xx1 = max(rc1[0], rc2[0]);
	float yy1 = max(rc1[1], rc2[1]);
	float xx2 = min(rc1[2], rc2[2]);
	float yy2 = min(rc1[3], rc2[3]);

	float w = max(0.0f,xx2-xx1+1);
	float h = max(0.0f,yy2-yy1+1);

	float inter = w * h;
	float o = inter / (area1 + area2 - inter);
	return o;
}

struct Info
{
    float score;
    const std::vector<float> *head;
};
bool compare(const Info& Info1, const Info& Info2)
{
    return Info1.score > Info2.score;
}

void boxes_sort(const int num, const std::vector<vector<float> > &pred, float* sorted_pred)
{
    //已经排好序了 不需要排序了
    /*vector<Info> my(num);
     *
    Info tmp;
    for (int i = 0; i< num; i++)
    {
        tmp.score = pred[i][4];
        tmp.head = &pred[i];
        my.push_back(tmp);
    }
    std::sort(my.begin(), my.end(), compare);
    */
    for (int i=0; i<num; i++)
    {
        for (int j=0; j<5; j++)
            //sorted_pred[i*5+j] = (*my[i].head)[j];
            sorted_pred[i*5+j] = pred[i][j];
    }
    
}
void NMS(std::vector<vector<float> > &candires, std::vector<vector<float> > &pickout,float nmsthresh)
{
    int boxes_num = candires.size();
    int boxes_dim = candires[0].size();
    int num_out;

    int *keep = NULL;
    float *sorted_pred = NULL;
    
    keep = new int[boxes_num];
    sorted_pred = new float[boxes_num*5];
    
    boxes_sort(boxes_num, candires, sorted_pred); 

    _nms(keep,&num_out, sorted_pred, boxes_num, boxes_dim, nmsthresh, 0);

    std::vector<float> tmp(5);
   for(int i = 0; i < num_out; i++) {
       tmp[0] = sorted_pred[keep[i]*5+0];
       tmp[1] = sorted_pred[keep[i]*5+1];
       tmp[2] = sorted_pred[keep[i]*5+2];
       tmp[3] = sorted_pred[keep[i]*5+3];
       tmp[4] = sorted_pred[keep[i]*5+4];
       pickout.push_back(tmp);
   }

   if(keep){
        delete []keep;
   }
   if(sorted_pred){
        delete []sorted_pred;
   }
}


CTRS _whctrs(vector<float> anchor)
{
	//Return width, height, x center, and y center for an anchor (window).
	
	float w = anchor[2] - anchor[0] + 1;
	float h = anchor[3] - anchor[1] + 1;
	float x_ctr = anchor[0] + 0.5 * (w - 1);
	float y_ctr = anchor[1] + 0.5 * (h - 1);
	CTRS ctr;
	ctr.w = w;
	ctr.h = h;
	ctr.x_ctr = x_ctr;
	ctr.y_ctr = y_ctr;
	return ctr;
}

vector<vector<float> > _mkanchors(vector<CTRS> ctrs)
{
	//Given a vector of widths (ws) and heights (hs) around a center
	//(x_ctr, y_ctr), output a set of anchors (windows).
	vector<vector<float> > anchors;
	for (int i = 0; i < ctrs.size(); i++)
	{
		vector<float> anchor(4);
		anchor[0] = ctrs[i].x_ctr - 0.5 * (ctrs[i].w - 1);
		anchor[1] = ctrs[i].y_ctr - 0.5 * (ctrs[i].h - 1);
		anchor[2] = ctrs[i].x_ctr + 0.5 * (ctrs[i].w - 1);
		anchor[3] = ctrs[i].y_ctr + 0.5 * (ctrs[i].h - 1);
		anchors.push_back(anchor); 
	}	
	
	return anchors;
}

vector<vector<float> > _ratio_enum(vector<float> anchor, vector<float> ratios)
{
	//Enumerate a set of anchors for each aspect ratio wrt an anchor.
	//w, h, x_ctr, y_ctr = _whctrs(anchor)
	//	size = w * h
	//	size_ratios = size / ratios
	//	ws = np.round(np.sqrt(size_ratios))
	//	hs = np.round(ws * ratios)
	//	anchors = _mkanchors(ws, hs, x_ctr, y_ctr)
	//	return anchors
	CTRS ctranchor = _whctrs(anchor);
	float size = ctranchor.w * ctranchor.h;
	float x_ctr = ctranchor.x_ctr;
	float y_ctr = ctranchor.y_ctr;
	vector<CTRS> ctrs;
	for (int i = 0; i < ratios.size(); i++)
	{
		CTRS ctr;
		float size_ratio = size / ratios[i];
		float ws = round(sqrt(size_ratio));
		float hs = round(ws * ratios[i]);
		ctr.w = ws;
		ctr.h = hs;
		ctr.x_ctr = x_ctr;
		ctr.y_ctr = y_ctr;
		ctrs.push_back(ctr);
	}
	
	
	vector<vector<float> > anchors = _mkanchors(ctrs);
	return anchors;
}
vector<vector<float> > _scale_enum(vector<float> anchor, vector<float> scales)
{
	//Enumerate a set of anchors for each scale wrt an anchor.
	//
	//w, h, x_ctr, y_ctr = _whctrs(anchor)
	//ws = w * scales
	//hs = h * scales
	//anchors = _mkanchors(ws, hs, x_ctr, y_ctr)
	//return anchors

	CTRS ctranchor = _whctrs(anchor);
	float w = ctranchor.w ;
	float h = ctranchor.h;
	float x_ctr = ctranchor.x_ctr;
	float y_ctr = ctranchor.y_ctr;
	vector<CTRS> ctrs;
	for (int i = 0; i < scales.size(); i++)
	{
		CTRS ctr;		
		float ws = w * scales[i];
		float hs = h* scales[i];
		ctr.w = ws;
		ctr.h = hs;
		ctr.x_ctr = x_ctr;
		ctr.y_ctr = y_ctr;
		ctrs.push_back(ctr);
	}


	vector<vector<float> > anchors = _mkanchors(ctrs);
	return anchors;
}

//#array([[ -83.,  -39.,  100.,   56.],
//#       [-175.,  -87.,  192.,  104.],
//#       [-359., -183.,  376.,  200.],
//#       [ -55.,  -55.,   72.,   72.],
//#       [-119., -119.,  136.,  136.],
//#       [-247., -247.,  264.,  264.],
//#       [ -35.,  -79.,   52.,   96.],
//#       [ -79., -167.,   96.,  184.],
//#       [-167., -343.,  184.,  360.]])

//def generate_anchors(base_size=16, ratios=[0.5, 1, 2],
//	scales=2**np.arange(3, 6))
//"""
//	Generate anchor (reference) windows by enumerating aspect ratios X
//	scales wrt a reference (0, 0, 15, 15) window.
//	"""
//
//	base_anchor = np.array([1, 1, base_size, base_size]) - 1
//	ratio_anchors = _ratio_enum(base_anchor, ratios)
//	print ratio_anchors.shape
//	print ratio_anchors
//	anchors = np.vstack([_scale_enum(ratio_anchors[i, :], scales)
//	for i in xrange(ratio_anchors.shape[0])])
//		return anchors

vector<vector<float> > generate_anchors(int base_size, vector<float> ratios, vector<float> scales)
{
	//Generate anchor (reference) windows by enumerating aspect ratios X
	//scales wrt a reference (0, 0, 15, 15) window.	

	vector<float> base_anchor(4);
	base_anchor[0] = 0;
	base_anchor[1] = 0;
	base_anchor[2] = base_size - 1;
	base_anchor[3] = base_size - 1;
	vector<vector<float> > ratio_anchors= _ratio_enum(base_anchor, ratios);

	vector<vector<float> > anchors;
	for (int i = 0; i < ratio_anchors.size(); i++)
	{
		vector<vector<float> > scale_anchors = _scale_enum(ratio_anchors[i], scales);
		for (int j = 0; j < scale_anchors.size(); j++)
		{
			vector<float> scale_anchor = scale_anchors[j];
			anchors.push_back(scale_anchor);
		}
		
	}
	return anchors;
}
//pred2gt+clipbox+filterbox
vector<vector<float> > bbox_transform_inv(vector<vector<float> > &boxes, vector<vector<float> > &deltas, vector<vector<float> > &scores, float fImgHeight,float fImgWidth,float fMinSize)
{
	vector<vector<float> > pred_boxes;
	CHECK_EQ(boxes.size(), deltas.size()) << "boxes num not matched";
	CHECK_EQ(boxes.size(), scores.size()) << "boxes num not matched";
	CHECK_EQ(scores.size(), deltas.size()) << "boxes num not matched";
	for (int i = 0; i < boxes.size(); i++)
	{
		vector<float> box = boxes[i];
		vector<float> delta = deltas[i];
		vector<float> score = scores[i];
		float width = box[2] - box[0] + 1.0;
		float height = box[3] - box[1] + 1.0;
		float ctr_x = box[0] + 0.5 * width;
		float ctr_y = box[1] + 0.5 * height;

		float dx = delta[0];
		float dy = delta[1];
		float dw = delta[2];
		float dh = delta[3];

		float pred_ctr_x = dx * width + ctr_x;
		float pred_ctr_y = dy * height + ctr_y;
		float pred_w = exp(dw) * width;
		float pred_h = exp(dh) * height;

		vector<float> pred_box(5);
		//x1
		pred_box[0] = pred_ctr_x - 0.5 * pred_w;
		//y1
		pred_box[1] = pred_ctr_y - 0.5 * pred_h;
		//x2
		pred_box[2] = pred_ctr_x + 0.5 * pred_w;
		//y2
		pred_box[3] = pred_ctr_y + 0.5 * pred_h;
		//score
		pred_box[4] = score[0];
		//Clip boxes to image boundaries.		
		
		//x1 >= 0		
		pred_box[0] = max(min(pred_box[0], fImgWidth - 1), 0);
		//y1 >= 0
		pred_box[1] = max(min(pred_box[1], fImgHeight - 1), 0);
		//x2 < im_shape[1]
		pred_box[2] = max(min(pred_box[2], fImgWidth - 1), 0);
		//y2 < im_shape[0]
		pred_box[3] = max(min(pred_box[3], fImgHeight - 1), 0);

		float ws = pred_box[2] - pred_box[0] + 1;
		float hs = pred_box[3] - pred_box[1] + 1;
		
		if (ws >= fMinSize && hs >= fMinSize)
		{
			pred_boxes.push_back(pred_box);
		}
		
		
	}
	return pred_boxes;
}


	vector<vector<float> > keep_sorted(arma::uvec indices,vector<vector<float> > &proposals, int nKeepSize)
{
	vector<vector<float> > keepboxes;
	for (int i = 0; i < proposals.size(); i++)
	{
		if (i < nKeepSize)
		{
			vector<float> obbox = proposals[indices[i]];
			keepboxes.push_back(obbox);

		}
		else
		{
			break;
		}
	}
	return keepboxes;
}

//keepboxes
vector<vector<float> > keep(vector<vector<float> > &proposals, int nKeepSize)
{
	vector<vector<float> > keepboxes;
	for (int i = 0; i < proposals.size(); i++)
	{
		if (i < nKeepSize)
		{
			vector<float> obbox = proposals[i];
			keepboxes.push_back(obbox);
			
		}
		else
		{
			break;
		}
	}
	return keepboxes;
}

template <typename Dtype>
void RPNPLayer<Dtype>::LayerSetUp(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top) {
  RPNPParameter rpnp_param = this->layer_param_.rpnp_param();
  CHECK_GT(rpnp_param.scalefrom(), 1)
      << "scalefrom must be > 1";
  CHECK_GT(rpnp_param.scaleto(), 4)
      << "scaleto must be > 0";
  scalesfrom_ = rpnp_param.scalefrom();
  scalesto_ = rpnp_param.scaleto();
  aspect_ = rpnp_param.aspect();
  feat_stride_ = rpnp_param.feat_stride();
  LOG(INFO) << "Spatial scale: " << scalesfrom_ << "to" << scalesto_;
  LOG(INFO) << "Spatial aspect: " << aspect_;
  int aspectype = (aspect_ == 3) ? 3 : 1;//3 full aspects or 1:1 square aspect
  num_anchors_ = (scalesto_ - scalesfrom_ + 1) * aspectype;
  anchors_.Reshape(1,1,num_anchors_,4);
  vector<float> ratios(3);
  ratios[0] = 0.5;
  ratios[1] = 1;
  ratios[2] = 2;
  vector<float> scales;
  for (int i = scalesfrom_;i <= scalesto_;i++)
  {
	  float scale = pow(2.0,i);
	  //printf("%f,%f,%f\n",scales[0],scales[1],scales[2]);
	  scales.push_back(scale);
  }

  
  baseanchors_ = generate_anchors(feat_stride_,ratios,scales);
  LOG(INFO) << "anchors:";
  for (int i = 0; i < baseanchors_.size(); i++)
  {

	  vector<float> anchor= baseanchors_[i];
	  LOG(INFO) << anchor[0] << " " << anchor[1] << " " << anchor[2] << " " << anchor[3];


  }
  //rois blob: holds R regions of interest, each is a 5-tuple 
  //(n, x1, y1, x2, y2) specifying an image batch index n and a 
  //# rectangle (x1, y1, x2, y2) 
  vector<int> top_shape;
  top_shape.push_back(1);
  top_shape.push_back(5);
  top[0]->Reshape(top_shape);
  //top[0]->Reshape(1, 5, 1, 1);

  if (top.size() > 1)
  {
	  vector<int> score_shape;
	  score_shape.push_back(1);
	  score_shape.push_back(1);
	  top[1]->Reshape(score_shape);
  }
}

template <typename Dtype>
void RPNPLayer<Dtype>::Reshape(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top) {
  //channels_ = bottom[0]->channels();
  //height_ = bottom[0]->height();
  //width_ = bottom[0]->width();
  //top[0]->Reshape(bottom[1]->num(), channels_, pooled_height_,
  //    pooled_width_);
  //max_idx_.Reshape(bottom[1]->num(), channels_, pooled_height_,
  //    pooled_width_);
}

template <typename Dtype>
void RPNPLayer<Dtype>::Forward_cpu(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top) {

    boost::timer rpn;
  CHECK_EQ(1, bottom[0]->num()) << "Only single item batches are supported";
  const Dtype* bottom_scores = bottom[0]->cpu_data() + bottom[0]->offset(0,num_anchors_);//the first set of _num_anchors channels are bg probs,the second set are the fg probs, which we want
  const Dtype* bottom_bbox_deltas = bottom[1]->cpu_data();
  const Dtype* bottom_im_info = bottom[2]->cpu_data();
  
  //int batch_size = bottom[0]->num();  
  int width = bottom[0]->shape(3);
  int height = bottom[0]->shape(2);
  float min_size = 16;
  float nms_thresh = 0.7;
  int pre_nms_topN = 6000;
  int post_nms_topN = 300;
  
 /* vector<vector<float>> shifts(height * width);
  vector<vector<float>> shiftanchors(num_anchors_ * height * width);*/
  vector<vector<float> > shifts;
  vector<vector<float> > shiftanchors;

  //scores,bbox_deltas transpose
  vector<vector<float> > scores;
  vector<vector<float> > bbox_deltas;
  for (int i = 0; i < height; i++)
  {
	  for (int j = 0; j < width; j++)
	  {
		  vector<float> shift(4);
		  float c1 = j * feat_stride_;
		  float c2 = i * feat_stride_;
		  shift[0] = c1;
		  shift[1] = c2;
		  shift[2] = c1;
		  shift[3] = c2;
		  //shifts.push_back(shift);
		  for (int k = 0; k < num_anchors_; k++)
		  {
			  vector<float> anchorbox(4);
			  vector<float> baseanchor = baseanchors_[k];
			  anchorbox[0] = shift[0] + baseanchor[0];
			  anchorbox[1] = shift[1] + baseanchor[1];
			  anchorbox[2] = shift[2] + baseanchor[2];
			  anchorbox[3] = shift[3] + baseanchor[3];
			  shiftanchors.push_back(anchorbox);
		
			   //transpose deltas
			  int nIndex = i * width + j;
			  vector<float> bbox_delta(4);
			  bbox_delta[0] = static_cast<float>(bottom_bbox_deltas[nIndex+4*k*height*width]);
			  bbox_delta[1] = static_cast<float>(bottom_bbox_deltas[nIndex+(4*k+1)*height*width]);
			  bbox_delta[2] = static_cast<float>(bottom_bbox_deltas[nIndex+(4*k+2)*height*width]);
			  bbox_delta[3] = static_cast<float>(bottom_bbox_deltas[nIndex+(4*k+3)*height*width]);
			  bbox_deltas.push_back(bbox_delta);

			  vector<float> score(1);
			  score[0] = static_cast<float>(bottom_scores[nIndex+k*height*width]);	  
			  scores.push_back(score);

		  }
		  
	  }
	  
  }
 
  //Convert anchors into proposals via bbox transformations
  vector<vector<float> > proposals = bbox_transform_inv(shiftanchors, bbox_deltas, scores, static_cast<float>(bottom_im_info[0]),static_cast<float>(bottom_im_info[1]),min_size * static_cast<float>(bottom_im_info[2]));

	arma::vec proposals_vec(proposals.size());
    for (int l = 0; l < proposals.size(); ++l) {
       	proposals_vec[l] = proposals[l][4] ;
    }

	arma::uvec indices = arma::sort_index(proposals_vec,"descend");
	vector<vector<float> > proposalspre = keep_sorted(indices,proposals,pre_nms_topN);
	//std::sort(proposals.begin(),proposals.end(),compfun);
  //LOG(INFO) << "im_h:" << bottom_im_info[0] << "im_w:" << bottom_im_info[1] << "im_scale:" << bottom_im_info[2];
  //vector<vector<float> > proposalspre = keep(proposals,pre_nms_topN);


  vector<vector<float> > proposalsnms;
    std::cout << "nms before  time is " << rpn.elapsed()<< "s" << std::endl;
  NMS(proposalspre,proposalsnms,nms_thresh);
  
  vector<vector<float> > proposalspost = keep(proposalsnms,post_nms_topN);
    std::cout << " nms done  time is " << rpn.elapsed()<< "s" << std::endl;
  //# Output rois blob
  //Our RPN implementation only supports a single input image, so all batch inds are 0
  int proposalcount = proposalspost.size();
  
  vector<int> top_shape;
  top_shape.push_back(proposalcount);
  top_shape.push_back(5);

  vector<int> score_shape;
  score_shape.push_back(proposalcount);
  score_shape.push_back(1);

  Blob<Dtype> scorespost;
  scorespost.Reshape(score_shape);
  Dtype* scopost_data = scorespost.mutable_cpu_data();

  top[0]->Reshape(top_shape);
  Dtype* top_data = top[0]->mutable_cpu_data();
  for (int i = 0; i < proposalcount; i++)
  {
	  vector<float> candidate = proposalspost[i];
	  top_data[top[0]->offset(i,0)] = Dtype(0);
	  top_data[top[0]->offset(i,1)] = Dtype(candidate[0]);
	  top_data[top[0]->offset(i,2)] = Dtype(candidate[1]);
	  top_data[top[0]->offset(i,3)] = Dtype(candidate[2]);
	  top_data[top[0]->offset(i,4)] = Dtype(candidate[3]);
	  scopost_data[scorespost.offset(i,0)] = Dtype(candidate[4]);
  }
   
  if (top.size() > 1)
  {
	  top[1]->ReshapeLike(scorespost);
	  Dtype* top_scores = top[1]->mutable_cpu_data();
	  int top_count = top[1]->count();
	  //caffe_set(top_count, Dtype(1), top_scores);
	  caffe_copy(top_count,scorespost.cpu_data(),top_scores);
  }

    std::cout << "rpn layer done  time is " << rpn.elapsed()<< "s" << std::endl;
  
}

template <typename Dtype>
void RPNPLayer<Dtype>::Backward_cpu(const vector<Blob<Dtype>*>& top,
      const vector<bool>& propagate_down, const vector<Blob<Dtype>*>& bottom) {
  NOT_IMPLEMENTED;
}


INSTANTIATE_CLASS(RPNPLayer);
REGISTER_LAYER_CLASS(RPNP);

}  // namespace caffe
