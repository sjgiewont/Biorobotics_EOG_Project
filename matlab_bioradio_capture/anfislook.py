# lookupVal.py
from myAnfis import anfis
import cPickle as pickle

def lookup2(x, y):
    from myAnfis import anfis
    import cPickle as pickle
    
    with open('fuzzy_log_20.pkl', 'rb') as f:
        anf = pickle.load(f)
    var = np.array([[x, y]])
    ans = anfis.predict(anf, var)
    return ans