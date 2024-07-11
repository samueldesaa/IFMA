import pyautogui as py # type: ignore
import numpy as np
import time as t

t.sleep(2)
i=0;
while(i<100):
    py.click(1416,386)
    t.sleep(2)
    py.click(1378,542)
    # t.sleep(7)
    t.sleep(np.random.random_integers(10,15))
    py.click(1432,330)
    t.sleep(2)
    i+=1
    print(f'Voto: {i}')