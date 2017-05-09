# search.py
"""Python module demonstrates passing MATLAB types to Python functions"""
def search(x, y):
    """Return list of words containing 'son'"""
    import cPickle as pickle
    from myAnfis import anfis
    import numpy
    
    with open('fuzzy_log_20.pkl', 'rb') as f:
        anf = pickle.load(f)
        
    var = numpy.array([[x, y]])
    ans = anfis.predict(anf, var)
    return ans

def theend(words):
    """Append 'The End' to list of words"""
    words.append('The End')
    return words