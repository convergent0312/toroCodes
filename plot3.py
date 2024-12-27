import matplotlib.pyplot as plt
import numpy as np
results = np.genfromtxt('case3.out',dtype=None)

print(np.shape(results))

xpos = results[:,0]
ds = results[:,1]
us = results[:,2]
ps = results[:,3]
internal_energy = results[:,4]



plt.subplot(2,2,1)
plt.xlabel('Position')
plt.ylabel('Density')
plt.yticks([0,3,6])
plt.xticks([0,1])
plt.plot(xpos,ds)

plt.subplot(2,2,2)
ax = plt.gca()
plt.xlabel('Position')
plt.ylabel('Velocity')
# ax.set_ylim([-2,2])
plt.yticks([0,12.5,25])
plt.xticks([0,1])
plt.plot(xpos,us)

plt.subplot(2,2,3)
plt.xlabel('Position')
plt.ylabel('Pressure')
ax = plt.gca()
# ax.set_ylim([0,0.4])
plt.yticks([0,500,1000])
plt.xticks([0,1])
plt.plot(xpos,ps)

plt.subplot(2,2,4)
plt.xlabel('Position')
plt.ylabel('Internal Energy')
ax = plt.gca()
# ax.set_ylim([0,1])
plt.xticks([0,1])
plt.yticks([0,1300,2600])
plt.plot(xpos,internal_energy)
plt.suptitle('CASE 3: $W_L = [1.0,0.0,1000.0]$, $W_R = [1.0,0.0,0.01]$, $t = 0.012$',fontsize=20)
plt.show()



