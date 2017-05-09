from Tkinter import *
import time
import numpy as np
import cPickle as pickle
from myAnfis import anfis

root = Tk()
canv = Canvas(root, highlightthickness=0)
canv.pack(fill='both', expand=True)
top = canv.create_line(0, 0, 1920, 0, fill='green', tags=('top'))
left = canv.create_line(0, 0, 0, 1000, fill='green', tags=('left'))
right = canv.create_line(1920, 0, 1920, 1000, fill='green', tags=('right'))
bottom = canv.create_line(0, 1000, 1920, 1000, fill='red', tags=('bottom'))

w, h = root.winfo_screenwidth(), root.winfo_screenheight()
root.overrideredirect(1)
root.geometry("%dx%d+0+0" % (w, h))
# root.geometry('%sx%s+%s+%s' %(1920, 1000, 400, 400))
root.resizable(0, 0)

ball = canv.create_oval(0, 20, 20, 40, outline='black', fill='gray40', tags=('ball'))

input_1, input_2 = 0, 0

with open('fuzzy_log_20.pkl', 'rb') as f:
    anf = pickle.load(f)


var = np.array([[input_1, input_2]])
print "input", var
# print the predicted value based on the trained set
ans = anfis.predict(anf, var)
new_x_pos = ans[0][0]
new_y_pos = ans[0][1]

while True:
    var = np.array([[input_1, input_2]])
    print "input", var
    # print the predicted value based on the trained set
    ans = anfis.predict(anf, var)
    print ans

    # canv.coords(ball, ans)
    canv.move(ball, 1, 1)
    canv.update()
    input_1 += 0.0001
    input_2 += 0
    time.sleep(1)


root.mainloop()
