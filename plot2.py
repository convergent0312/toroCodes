import matplotlib.pyplot as plt
import numpy as np
results = np.genfromtxt('case2.out',dtype=None)

print(np.shape(results))

xpos = results[:,0]
ds = results[:,1]
us = results[:,2]
ps = results[:,3]
internal_energy = results[:,4]



plt.subplot(2,2,1)
plt.xlabel('Position')
plt.ylabel('Density')
plt.yticks([0,0.5,1])
plt.xticks([0,1])

plt.plot(xpos,ds)

plt.subplot(2,2,2)
ax = plt.gca()
plt.xlabel('Position')
plt.ylabel('Velocity')
# ax.set_ylim([-2,2])
plt.yticks([-2,0.0,2])
plt.xticks([0,1])
plt.plot(xpos,us)

plt.subplot(2,2,3)
plt.xlabel('Position')
plt.ylabel('Pressure')
ax = plt.gca()
# ax.set_ylim([0,0.4])
plt.yticks([0,0.2,0.4])
plt.xticks([0,1])
plt.plot(xpos,ps)

plt.subplot(2,2,4)
plt.xlabel('Position')
plt.ylabel('Internal Energy')
ax = plt.gca()
# ax.set_ylim([0,1])
plt.xticks([0,1])
plt.yticks([0,0.5,1])
plt.plot(xpos,internal_energy)
plt.suptitle('CASE 2: $W_L = [1.0,-2.0,0.4]$, $W_R = [1.0,2.0,0.4]$, $t = 0.15$',fontsize=20)
plt.show()



