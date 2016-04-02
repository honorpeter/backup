Feature Extraction and Preprocessing
    Extracting features from categorical variables
        Categorical variables are commonly encoded using one-of-k or one-hot
            one-hot: is binary
            the DictVectorizer class can be used to one-hot encode 
                        categorical features:

            >>> from sklearn.feature_extraction import DictVectorizer
            >>> onehot_encoder = DictVectorizer()
            >>> instances = [ {'city': 'New York'},
                        {'city': 'San Francisco'},
                        {'city': 'Chapel Hill'}>>> ]
            >>> print onehot_encoder.fit_transform(instances).toarray()
            [[ 0. 1. 0.] [ 0. 0. 1.][ 1. 0. 0.]]
    Extracting features from text:
        the bag-of-words model
            uses a multiset, or bag encodes the words;  the bag-of-words 
                does not encode any of the text's syntax, ignores the order
                of words, and disregards all grammar. Bag-of-words can be 
                thought of as an extension to one-hot encoding'

                from sklearn.feature_extraction.text import CountVectorizer
                corpus = [
                    'UNC played Duke in basketball',
                    'Duke lost the basketball game'
                ]
                >>> vectorizer = CountVectorizer()
                >>> print vectorizer.fit_transform(corpus).todense()
                >>> print vectorizer.vocabulary_
                [[1 1 0 1 0 1 0 1]
                [1 1 1 0 1 0 1 0]]
                {u'duke': 1, u'basketball': 0, u'lost': 4, u'played': 5, 
                    u'game': 2, u'unc': 7, u'in': 3, u'the': 6}
                    先计算corpus里面的所有单词 然后使用1,2,3.. 表示 如果
                    corpus 的一个句子中含有这个单词 就在相应位置上写1 否者0
                    每句的长度 等于单词个数

            Euclidean distance:
                >>> from sklearn.metrics.pairwise import euclidean_distances
                >>> counts = [
                [0, 1, 1, 0, 0, 1, 0, 1],
                [0, 1, 1, 1, 1, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 1, 0]
                ]
                >>> print 'Distance between 1st and 2nd
                distances(counts[0], counts[1])
                >>> print 'Distance between 1st and 3rd documents:', 
                        euclidean_distances(counts[0], counts[2])
        Stop-word filtering:
            >>> from sklearn.feature_extraction.text import CountVectorizer
            >>> corpus = [
            'UNC played Duke in basketball',
            'Duke lost the basketball game',
            'I ate a sandwich'
           ]
            >>> vectorizer = CountVectorizer(stop_words='english')
            >>> print vectorizer.fit_transform(corpus).todense()
            >>> print vectorizer.vocabulary_
            [[0 1 1 0 0 1 0 1]
            [0 1 1 1 1 0 0 0]
            [1 0 0 0 0 0 1 0]]
            {u'duke': 2, u'basketball': 1, u'lost': 4, u'played': 5, 
                    u'game': 3, u'sandwich': 6, u'unc': 7, u'ate': 0}  

    Stemming and lemmatization 词提取: two stages
            jumping and jumps are both forms of the word jump 
            >>> from sklearn.feature_extraction.text import CountVectorizer
            >>> corpus = [
            'He ate the sandwiches',
            'Every sandwich was eaten by him'
            >>> ]
            vectorizer = CountVectorizer(binary=True, stop_words='english')
            >>> print vectorizer.fit_transform(corpus).todense()
            >>> print vectorizer.vocabulary_
            [[1 0 0 1]
            [0 1 1 0]]
            {u'sandwich': 2, u'ate': 0, u'sandwiches': 3, u'eaten': 1}
        The documents have similar meanings, but their feature vectors 
                have no elements in common
                use Natural Language Tool Kit to stem and lemmatize  corpus.
                >>> from nltk import word_tokenize
                >>> from nltk.stem import PorterStemmer
                >>> from nltk.stem.wordnet import WordNetLemmatizer
                >>> from nltk import pos_tag
                >>> wordnet_tags = ['n', 'v']
                >>> corpus = [
                'He ate the sandwiches',
                'Every sandwich was eaten by him'
                ]
                >>> stemmer = PorterStemmer()
                print 'Stemmed:', [[stemmer.stem(token) for token in word_tokenize(document)] for document in corpus]
                >>> def lemmatize(token, tag):
                    if tag[0].lower() in ['n', 'v']:
                        return lemmatizer.lemmatize(token, tag[0].lower())
                    return token
                >>> lemmatizer = WordNetLemmatizer()
                tagged_corpus = [pos_tag(word_tokenize(document)) for 
                        document in corpus]
               print 'Lemmatized:', [[lemmatize(token, tag) for token, tag 
                    in document] for document in tagged_corpus]
               Stemmed: [['He', 'ate', 'the', 'sandwich'], 
                    ['Everi', 'sandwich', 'wa', 'eaten', 'by', 'him']]
                Lemmatized: [['He', 'eat', 'the', 'sandwich'], 
                    ['Every', 'sandwich', 'be', 'eat', 'by', 'him']]

    Extending bag-of-words with TF-IDF weights:
            encode the frequencies of words
                use an integer represents the number words appeared 
                from sklearn.feature_extraction.text import CountVectorizer
                >>> corpus = ['The dog ate a sandwich, the wizard 
                    transfigured a sandwich, and I ate a sandwich']
                >>> vectorizer = CountVectorizer(stop_words='english')
                >>> print vectorizer.fit_transform(corpus).todense()
                [[2 1 3 1 1]]
                {u'sandwich': 2, u'wizard': 4, u'dog': 1, u'transfigured':
                     3, u'ate': 0}
            单词符合长尾分布 减一下权重  TF-IDF
                from sklearn.feature_extraction.text import TfidfVectorizer
                >>> corpus = [
                'The dog ate a sandwich and I ate a sandwich',
                'The wizard transfigured a sandwich'
                >>> ]
                >>> vectorizer = TfidfVectorizer(stop_words='english')
                >>> print vectorizer.fit_transform(corpus).todense()
       Space-efficient feature vectorizing with the hashing trick
            维度非常大的时候 就需要降维 使用hash trick来实现降维 
               from sklearn.feature_extraction.text import HashingVectorizer
                >>> corpus = ['the', 'ate', 'bacon', 'cat']
                >>> vectorizer = HashingVectorizer(n_features=6)
                >>> print vectorizer.transform(corpus).todense()
                [[-1. 0. 0. 0. 0. 0.]
                [ 0. 0. 0. 1. 0. 0.]
                [ 0. 0. 0. 0. -1. 0.]
                [ 0. 1. 0. 0. 0. 0.]]           '

Extracting features from images:
        Extracting features from pixel intensities:
                直接使用像素值 作为一个向量来作为特征
                只能有在一些简单的场合 如:手写识别
        Extracting points of interest as features:
                import numpy as nps
                from skimage.feature import corner_harris, corner_peaks
                from skimage.color import rgb2gray
                import matplotlib.pyplot as plt
                import skimage.io as io
                from skimage.exposure import equalize_hist
                >>> def show_corners(corners, image):
                        fig = plt.figure()
                        plt.gray()
                plt.imshow(image)
                y_corner, x_corner = zip(*corners)
                plt.plot(x_corner, y_corner, 'or')
                plt.xlim(0, image.shape[1])
                plt.ylim(image.shape[0], 0)
                fig.set_size_inches(np.array(fig.get_size_inches()) * 1.5)
                plt.show()
                >>> mandrill = io.imread('mandrill.png')
                >>> mandrill = equalize_hist(rgb2gray(mandrill))
                >>> corners = corner_peaks(corner_harris(mandrill), min_distance=2)
                >>> show_corners(corners, mandrill)
                

    SIFT and SURF:               
            is less sensitive to the scale, rotation, and illumination of the image than the extraction methods we have previously discussed. Each SIFT feature, or descriptor, is a vector that describes edges and corners in a region of an image
            >>> import mahotas as mh
            >>> from mahotas.features import surf
            >>> image = mh.imread('zipper.jpg', as_grey=True)
            >>> print 'The first SURF descriptor:\n', surf.surf(image)[0]
            >>> print 'Extracted %s SURF descriptors' % len(surf.surf(image))


Data standardization:
        >>> from sklearn import preprocessing
        >>> import numpy as np
        >>> X = np.array([
        [0., 0., 5., 13., 9., 1.],
        [0., 0., 13., 15., 10., 15.],
        [0., 3., 15., 2., 0., 11.]
        >>> ])
        >>> print preprocessing.scale(X)
        [[ 0.  -0.70710678 -1.38873015 0.52489066 0.59299945 -1.35873244]
        [ 0.  -0.70710678 0.46291005 0.87481777 0.81537425 1.01904933]
        [ 0.  1.41421356 0.9258201 -1.39970842 -1.4083737 0.33968311]]














