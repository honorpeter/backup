Nonlinear Classification and Regression with Decision Trees
        Decision trees with scikit-learn:
                Internet Advertisements Data Set from http://archive.ics.
                            uci.edu/ml/datasets/Internet+Advertisements 

                import pandas as pd
                from sklearn.tree import DecisionTreeClassifier
                from sklearn.cross_validation import train_test_split
                from sklearn.metrics import classification_report
                from sklearn.pipeline import Pipeline
                from sklearn.grid_search import GridSearchCV


                if __name__ == '__main__':
                    df = pd.read_csv('data/ad.data', header=None)
                    explanatory_variable_columns = set(df.columns.values)
                    response_variable_column = df[len(df.columns.values)-1]
                    # The last column describes the targets
                    explanatory_variable_columns.remove(len(df.columns.values)-1)
                    y = [1 if e == 'ad.' else 0 for e in response_variable_column]
                    X = df[list(explanatory_variable_columns)]

            









