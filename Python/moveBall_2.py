from visual import *
import time
import numpy as np
import cPickle as pickle
from myAnfis import anfis
import matlab.engine


def setupAnimation():
    global ball

    # scene2 = display(title='Examples of Tetrahedrons',
    #                  x=0, y=0, width=1080, height=920,
    #                  center=(840, 525, 0), background=(0, 0, 0))
    # scene2.visible = True
    # scene2.fullscreen = True

    coordinate = np.array([850, 650])
    # draw the pivot points of the base
    ball = sphere(pos=(coordinate), radius=10, material=materials.rough)

    scene.up = vector(0, 1, 0)
    # scene.up = scene.up.rotate(angle=1.57, axis=scene.forward)
    scene.forward = scene.forward.rotate(angle=0, axis=scene.up)
    # scene.forward = vector(1, 0, 0)
    scene.up = scene.up.rotate(angle=0, axis=scene.forward)

    scene.center = (850, 525, 0)

    rate(20)

    scene.fullscreen = True
    scene.range = 500
    scene.autocenter
    scene.center


def displayPosition(coordinate):
    global ball
    # scene2.visible = True
    ball.visible = False
    ball = sphere(pos=(coordinate), radius=15, material=materials.rough, color=color.yellow)
    # foot_1.pos = foot_pt

    rate(30)


names = matlab.engine.find_matlab()
eng = matlab.engine.connect_matlab(names[0])


with open('fuzzy_log_20.pkl', 'rb') as f:
    anf = pickle.load(f)



angle = 0
setupAnimation()
x = 850
y = 100

while 1:
    angle += 0.1
    x = x + 1
    y = 525
    # coord = [x, y]
    rawWindow = eng.workspace['rawWindow']
    
    var = np.array([[input_1, input_2]])
    ans = anfis.predict(anf, var)
    coord = [ans[0][0], ans[0][1]]
    displayPosition(coord)
    time.sleep(0.01)