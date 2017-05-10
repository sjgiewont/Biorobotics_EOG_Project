# search5.py
"""Python module demonstrates passing MATLAB types to Python functions"""
def search(x, y):
    """Return list of words containing 'son'"""
    import cPickle as pickle
    from myAnfis import anfis
    import numpy
    
    with open('fuzzy_log_15.pkl', 'rb') as f:
        anf = pickle.load(f)
        
    var = numpy.array([[x, y]])
    ans = anfis.predict(anf, var)
    x = ans[0][0]
    y = ans[0][1]
    ans = [x, y]
    return ans

def theend(words):
    """Append 'The End' to list of words"""
    words.append('The End')
    return words