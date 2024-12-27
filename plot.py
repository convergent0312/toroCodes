import matplotlib.pyplot as plt
import numpy as np
results = np.genfromtxt('case1.out',dtype=None)

print(np.shape(results))

xpos = results[:,0]
ds = results[:,1]
us = results[:,2]
ps = results[:,3]
internal_energy = results[:,4]


plt.title('CASE 1: $W_L = [1.0, 0.0,1.0]$, $W_R = [0.125,0.0,0.1]$, $t = 0.25$',fontsize=20)
# plt.title('CASE 2: $W_L = [1.0,-2.0,0.4]$, $W_R = [1.0,2.0,0.4]$, $t = 0.15$',fontsize=20)
# plt.title('CASE 3: $W_L = [1.0,0.0,1000.0]$, $W_R = [1.0,0.0,0.01]$, $t = 0.012$',fontsize=20)
# plt.title('CASE 4: $W_L = [1.0,0.0,0.01]$, $W_R = [1.0,0.0,100.0]$, $t = 0.035$',fontsize=20)
# plt.title('CASE 5: $W_L = [5.99924,19.5975,460.894]$, $W_R = [5.99242,-6.19633,46.0950]$, $t = 0.035$',fontsize=20)

plt.subplot(2,2,1)
plt.xlabel('Position')
plt.ylabel('Density')
plt.plot(xpos,ds)

plt.subplot(2,2,2)
plt.xlabel('Position')
plt.ylabel('Velocity')
plt.plot(xpos,us)

plt.subplot(2,2,3)
plt.xlabel('Position')
plt.ylabel('Pressure')
plt.plot(xpos,ps)

plt.subplot(2,2,4)
plt.xlabel('Position')
plt.ylabel('Internal Energy')
plt.plot(xpos,internal_energy)
plt.show()



