import time
from random import random

GRID_SIZE = 50
P = {i for i in range(GRID_SIZE**2) if random() < 0.1}
N = range(GRID_SIZE)

while 1:
    for i in N:
        print("".join(" ⬛"[i * GRID_SIZE + j in P] for j in N))
    time.sleep(0.1)
    Q = [(p + d) % (GRID_SIZE**2) for d in (-GRID_SIZE-1, -GRID_SIZE, -GRID_SIZE+1, -1, 1, GRID_SIZE-1, GRID_SIZE, GRID_SIZE+1) for p in P]
    P = set(p for p in Q if 2 - ({p} < P) < Q.count(p) < 4)
