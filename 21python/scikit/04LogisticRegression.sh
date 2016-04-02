Logistic Regression:
    Binary classification with logistic regression:
        Spam filtering:
            Dataset can be downloaded from 
                http://archive.ics.uci.edu/ml/datasets/SMS+Spam+Collection
            >>> import pandas as pd
            >>> df = pd.read_csv('data/SMSSpamCollection', delimiter='\t',
                    header=None)
            >>> print df.head()
            print 'Number of spam messages:', df[df[0] == 'spam'][0].count()
            print 'Number of ham messages:', df[df[0] == 'ham'][0].count()

            spam is 1  and ham is 0 下面是整个过程:
            >>> import numpy as np
            >>> import pandas as pd
            >>> from sklearn.feature_extraction.text import TfidfVectorizer
            >>> from sklearn.linear_model.logistic import LogisticRegression
            from sklearn.cross_validation import train_test_split, 
                cross_val_score
                #导入各种库
            df = pd.read_csv('data/SMSSpamCollection', delimiter='\t',
                     header=None)
            >>> X_train_raw, X_test_raw, y_train, y_test = 
                    train_test_split(df[1], df[0])

            #提取 词频统计 特征
            >>> vectorizer = TfidfVectorizer()
            >>> X_train = vectorizer.fit_transform(X_train_raw)
            >>> X_test = vectorizer.transform(X_test_raw)

            #训练
            >>> classifier = LogisticRegression()
            >>> classifier.fit(X_train, y_train)
            >>> predictions = classifier.predict(X_test)
            >>> for i, prediction in enumerate(predictions[:5]):
                    print 'Prediction: %s. Message: %s' % (prediction, 
                    X_test_raw[i])

Binary classification performance metrics:
                from sklearn.metrics import confusion_matrix
                >>> import matplotlib.pyplot as plt
                y_test = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1]
                y_pred = [0, 1, 0, 0, 0, 0, 0, 1, 1, 1]
                confusion_matrix = confusion_matrix(y_test, y_pred)
                print(confusion_matrix)
                plt.matshow(confusion_matrix)
                plt.title('Confusion matrix')
                plt.colorbar()
                plt.ylabel('True label')
                plt.xlabel('Predicted label')
                plt.show()
    Accuracy:
            >>> from sklearn.metrics import accuracy_score
            >>> y_pred, y_true = [0, 1, 1, 0], [1, 1, 1, 1]
            >>> print 'Accuracy:', accuracy_score(y_true, y_pred)
            0.5
        LogisticRegression.score() predicts and scores labels for a test 
                set using accuracy
                >>> import numpy as np
                >>> import pandas as pd
                from sklearn.feature_extraction.text import TfidfVectorizer
                from sklearn.linear_model.logistic import LogisticRegression
               from sklearn.cross_validation import train_test_split, 
                        cross_val_score
                >>> df = pd.read_csv('data/sms.csv')
                >>> X_train_raw, X_test_raw, y_train, y_test = 
                        train_test_split(df['message'], df['label'])
                >>> vectorizer = TfidfVectorizer()
                >>> X_train = vectorizer.fit_transform(X_train_raw)
                >>> X_test = vectorizer.transform(X_test_raw)
                >>> classifier = LogisticRegression()
                >>> classifier.fit(X_train, y_train)
               scores = cross_val_score(classifier, X_train, y_train, cv=5)
                >>> print np.mean(scores), scores

    Precision and recall:
            scikit-learn provides a function to calculate the precision and
                 recall for a classifier
            >>> import numpy as np
            >>> import pandas as pd
            >>> from sklearn.feature_extraction.text import TfidfVectorizer
            >>> from sklearn.linear_model.logistic import LogisticRegression
            >>> from sklearn.cross_validation import train_test_split, 
                    cross_val_score
            >>> df = pd.read_csv('data/sms.csv')
            >>> X_train_raw, X_test_raw, y_train, y_test = 
                    train_test_split(df['message'], df['label'])
            >>> vectorizer = TfidfVectorizer()
            >>> X_train = vectorizer.fit_transform(X_train_raw)
            >>> X_test = vectorizer.transform(X_test_raw)
            >>> classifier = LogisticRegression()
            >>> classifier.fit(X_train, y_train)
           precisions = cross_val_score(classifier, X_train, y_train, cv=5,
                scoring='precision')
            >>> print 'Precision', np.mean(precisions), precisions
            >>> recalls = cross_val_score(classifier, X_train, y_train, cv=5
                    ,scoring='recall')
            >>> print 'Recalls', np.mean(recalls), recalls

            只关注一个类别: 对这个类别的 precision and recall
        假设原始样本中有两类，其中：
            1：总共有 P个类别为1的样本，假设类别1为正例。 
            2：总共有N个类别为0 的样本，假设类别0为负例。 
        经过分类后：
            3：有 TP个类别为1 的样本被系统正确判定为类别1，FN 个类别为1
                     的样本被系统误判定为类别 0，
            显然有P=TP+FN； 
            4：有 FP 个类别为0 的样本被系统误判断定为类别1，TN 个类别为0
                        的样本被系统正确判为类别 0，
            显然有N=FP+TN； 
 
            那么：
        精确度（Precision）：
            P = TP/(TP+FP) ;  反映了被分类器判定的正例中真正的正例样本的比重
        准确率（Accuracy）
            A = (TP + TN)/(P+N) = (TP + TN)/(TP + FN + FP + TN);    
        反映了分类器统对整个样本的判定能力——能将正的判定为正，负的判定为负
            召回率(Recall)，也称为 True Positive Rate:
            R = TP/(TP+FN) = 1 - FN/T;反映了被正确判定的正例占总的正例的比重
            转移性（Specificity，不知道这个翻译对不对，这个指标用的也不多）
            也称为 True NegativeRate 
            S = TN/(TN + FP) = 1 – FP/N；   明显的这个和召回率是对应的指标
            只是用它在衡量类别0 的判定能力。 
            
        F-measure or balanced F-score
            F = 2 * 召回率* 准确率/(召回率+准确率)；
                    这就是传统上通常说的F1 measure，


Calculating the F1 measure:
            The F1 measure is the harmonic mean, or weighted average, of the
                precision and recall scores.
                >>> f1s = cross_val_score(classifier, X_train, y_train, 
                        cv=5, scoring='f1')
                >>> print 'F1', np.mean(f1s), f1s

ROC AUC:
        Receiver Operating Characteristic curve 感受性曲线
        F = FP/ (TN + FP)
            >>> import numpy as np
                >>> import pandas as pd
                >>> import matplotlib.pyplot as plt
                >>> from sklearn.feature_extraction.text import 
                        TfidfVectorizer
                >>> from sklearn.linear_model.logistic import 
                    LogisticRegression
                >>> from sklearn.cross_validation import train_test_split,
                     cross_val_score
                >>> from sklearn.metrics import roc_curve, auc
                >>> df = pd.read_csv('data/sms.csv')
                >>> X_train_raw, X_test_raw, y_train, y_test = train_test_
                split(df['message'], df['label'])
                >>> vectorizer = TfidfVectorizer()
                >>> X_train = vectorizer.fit_transform(X_train_raw)
                >>> X_test = vectorizer.transform(X_test_raw)
                >>> classifier = LogisticRegression()
                >>> classifier.fit(X_train, y_train)
                >>> predictions = classifier.predict_proba(X_test)
                >>> false_positive_rate, recall, thresholds = 
                        roc_curve(y_test,predictions[:, 1])
                >>> roc_auc = auc(false_positive_rate, recall)
                >>> plt.title('Receiver Operating Characteristic')
                >>> plt.plot(false_positive_rate, recall, 'b', 
                    label='AUC = %0.2f' %roc_auc)
                >>> plt.legend(loc='lower right')
                >>> plt.plot([0, 1], [0, 1], 'r--')
                >>> plt.xlim([0.0, 1.0])
                >>> plt.ylim([0.0, 1.0])
                >>> plt.ylabel('Recall')
                >>> plt.xlabel('Fall-out')
                >>> plt.show()

                

Tuning models with grid search:
            import pandas as pd
            from sklearn.feature_extraction.text import TfidfVectorizer
            from sklearn.linear_model.logistic import LogisticRegression
            from sklearn.grid_search import GridSearchCV
            from sklearn.pipeline import Pipeline
            from sklearn.cross_validation import train_test_split
            from sklearn.metrics import precision_score, recall_score, 
                        accuracy_score
            pipeline = Pipeline([
            ('vect', TfidfVectorizer(stop_words='english')),
            ('clf', LogisticRegression())
            ])
            parameters = {
            'vect__max_df': (0.25, 0.5, 0.75),
            'vect__stop_words': ('english', None),
            'vect__max_features': (2500, 5000, 10000, None),
            'vect__ngram_range': ((1, 1), (1, 2)),
            'vect__use_idf': (True, False),
            'vect__norm': ('l1', 'l2'),
            'clf__penalty': ('l1', 'l2'),
            'clf__C': (0.01, 0.1, 1, 10),
            }


            GridSearchCV() takes an estimator, a parameter space, and 
                performance measure.  The argument n_jobs specifies the 
                maximum number of concurrent jobs; set n_jobs to -1 to 
                use all CPU cores   must be executed as a script
            if __name__ == "__main__":
            grid_search = GridSearchCV(pipeline, parameters, n_jobs=-1,
            verbose=1, scoring='accuracy', cv=3)
            df = pd.read_csv('data/sms.csv')
            X, y, = df['message'], df['label']
            X_train, X_test, y_train, y_test = train_test_split(X, y)
            grid_search.fit(X_train, y_train)
            print 'Best score: %0.3f' % grid_search.best_score_
            print 'Best parameters set:'
            best_parameters = grid_search.best_estimator_.get_params()
            for param_name in sorted(parameters.keys()):
            print '\t%s: %r' % (param_name, best_parameters[param_name])
            predictions = grid_search.predict(X_test)
            print 'Accuracy:', accuracy_score(y_test, predictions)
            print 'Precision:', precision_score(y_test, predictions)
            print 'Recall:', recall_score(y_test, predictions)

Multi-class classification:
            scikit-learn uses a strategy called one-vs.-all, or 
                    one-vs.-the-rest, to support multi-class classification
            data can be downloaded from 
            http://www.kaggle.com/c/sentiment-analysis-on-movie-reviews/data

            import pandas as pd
            from sklearn.feature_extraction.text import TfidfVectorizer
            from sklearn.linear_model.logistic import LogisticRegression
            from sklearn.cross_validation import train_test_split
            from sklearn.metrics.metrics import classification_report, 
                    accuracy_score, confusion_matrix
            from sklearn.pipeline import Pipeline
            from sklearn.grid_search import GridSearchCV

            def main():
                pipeline = Pipeline([
                    ('vect', TfidfVectorizer(stop_words='english')),
                    ('clf', LogisticRegression())
                ])
                parameters = {
                    'vect__max_df': (0.25, 0.5),
                    'vect__ngram_range': ((1, 1), (1, 2)),
                    'vect__use_idf': (True, False),
                    'clf__C': (0.1, 1, 10),
                }
                df = pd.read_csv('data/train.tsv', header=0, delimiter='\t')
                X, y = df['Phrase'], df['Sentiment'].as_matrix()
                X_train, X_test, y_train, y_test = train_test_split(X, y, 
                        train_size=0.5)
                grid_search = GridSearchCV(pipeline, parameters, n_jobs=3,
                     verbose=1, scoring='accuracy')

                grid_search.fit(X_train, y_train)
                print 'Best score: %0.3f' % grid_search.best_score_
                print 'Best parameters set:'
                best_parameters = grid_search.best_estimator_.get_params()
                for param_name in sorted(parameters.keys()):
                print '\t%s: %r' % (param_name, best_parameters[param_name])
            if __name__ == '__main__':
                main()

    Multi-class classification performance metrics:
            predictions = grid_search.predict(X_test)
            print 'Accuracy:', accuracy_score(y_test, predictions)
            print 'Confusion Matrix:', confusion_matrix(y_test, predictions)
            print 'Classification Report:', classification_report(y_test,
                        predictions)

Multi-label classification and problem transformation:
            we will discuss is multi-label classification, in which each 
                    instance can be assigned a subset of the set of classes.
                            
            

            


            









