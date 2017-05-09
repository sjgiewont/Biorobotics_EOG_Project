import matlab.engine
import numpy as np

names = matlab.engine.find_matlab()

print names[0]
eng = matlab.engine.connect_matlab(names[0])

# print eng.sqrt(4.0)

ans = np.array(eng.workspace['all_training_output'])

while True:
    print np.mean(ans[:, 1])


all_training_vertical = eng.workspace['all_training_vertical']
all_training_horizontal = eng.workspace['all_training_horizontal']

all_training_x = eng.workspace['all_training_x']
all_training_y = eng.workspace['all_training_y']


