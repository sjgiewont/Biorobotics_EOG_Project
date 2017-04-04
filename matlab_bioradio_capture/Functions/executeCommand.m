function executeCommand(filterWindow)
global mean_variance
global labels
bb = filterWindow'; 
 results= testClassify(bb,mean_variance);
 outputDisplayNew(results,labels);
        


