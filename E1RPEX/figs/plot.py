## import and assigned variables

import matplotlib.pyplot as plt
import numpy as np
results1 = np.genfromtxt('../data/case1.out',dtype=None)
results2 = np.genfromtxt('../data/case2.out',dtype=None)
results3 = np.genfromtxt('../data/case3.out',dtype=None)
results4 = np.genfromtxt('../data/case4.out',dtype=None)
results5 = np.genfromtxt('../data/case5.out',dtype=None)


xpos1 = results1[:,0]
ds1 = results1[:,1]
us1 = results1[:,2]
ps1 = results1[:,3]
internal_energy1 = results1[:,4]

xpos2 = results2[:,0]
ds2 = results2[:,1]
us2 = results2[:,2]
ps2 = results2[:,3]
internal_energy2 = results2[:,4]


xpos3 = results3[:,0]
ds3 = results3[:,1]
us3 = results3[:,2]
ps3 = results3[:,3]
internal_energy3 = results3[:,4]


xpos4 = results4[:,0]
ds4 = results4[:,1]
us4 = results4[:,2]
ps4 = results4[:,3]
internal_energy4 = results4[:,4]


xpos5 = results5[:,0]
ds5 = results5[:,1]
us5 = results5[:,2]
ps5 = results5[:,3]
internal_energy5 = results5[:,4]

## plot and save

fig1 = plt.figure(figsize=(19.2,10.8), dpi=100)
plt.suptitle('CASE 1: $W_L = [1.0, 0.0,1.0]$, \
             $W_R = [0.125,0.0,0.1]$, $t = 0.25$',fontsize=30)
plt.subplot(2,2,1)
plt.xlabel('Position')
plt.ylabel('Density')
plt.yticks([0,0.5,1])
plt.xticks([0,1])
plt.plot(xpos1,ds1)

plt.subplot(2,2,2)
ax = plt.gca()
plt.xlabel('Position')
plt.ylabel('Velocity')
ax.set_ylim([0,1])
plt.yticks([0,0.5,1])
plt.xticks([0,1])
plt.plot(xpos1,us1)

plt.subplot(2,2,3)
plt.xlabel('Position')
plt.ylabel('Pressure')
plt.yticks([0,0.5,1])
plt.xticks([0,1])
plt.plot(xpos1,ps1)

plt.subplot(2,2,4)
plt.xlabel('Position')
plt.ylabel('Internal Energy')
plt.xticks([0,1])
plt.plot(xpos1,internal_energy1)

plt.savefig('case1.png', dpi=60)




fig2 = plt.figure(figsize=(19.2,10.8), dpi=100)
plt.suptitle('CASE 2: $W_L = [1.0,-2.0,0.4]$, \
             $W_R = [1.0,2.0,0.4]$, $t = 0.15$',fontsize=30)
plt.subplot(2,2,1)
plt.xlabel('Position')
plt.ylabel('Density')
plt.yticks([0,0.5,1])
plt.xticks([0,1])
plt.plot(xpos2,ds2)

plt.subplot(2,2,2)
plt.xlabel('Position')
plt.ylabel('Velocity')
plt.yticks([-2.0,0.0,2.2])
plt.xticks([0,1])
plt.plot(xpos2,us2)

plt.subplot(2,2,3)
plt.xlabel('Position')
plt.ylabel('Pressure')
plt.yticks([0,0.2,0.4])
plt.xticks([0,1])
plt.plot(xpos2,ps2)

plt.subplot(2,2,4)
plt.xlabel('Position')
plt.ylabel('Internal Energy')
plt.xticks([0,1])
plt.yticks([0,0.5,1])
plt.plot(xpos2,internal_energy2)
plt.savefig('case2.png', dpi=60)



fig3 = plt.figure(figsize=(19.2,10.8), dpi=100)
plt.suptitle('CASE 3: $W_L = [1.0,0.0,1000.0]$, \
             $W_R = [1.0,0.0,0.01]$, $t = 0.012$',fontsize=30)
plt.subplot(2,2,1)
plt.xlabel('Position')
plt.ylabel('Density')
plt.yticks([0,3,6])
plt.xticks([0,1])
plt.plot(xpos3,ds3)

plt.subplot(2,2,2)
plt.xlabel('Position')
plt.ylabel('Velocity')
plt.yticks([0,12.5,25])
plt.xticks([0,1])
plt.plot(xpos3,us3)

plt.subplot(2,2,3)
plt.xlabel('Position')
plt.ylabel('Pressure')
plt.yticks([0,500,1000])
plt.xticks([0,1])
plt.plot(xpos3,ps3)

plt.subplot(2,2,4)
plt.xlabel('Position')
plt.ylabel('Internal Energy')
plt.xticks([0,1])
plt.yticks([0,1300,2600])
plt.plot(xpos3,internal_energy3)
plt.savefig('case3.png', dpi=60)


fig4 = plt.figure(figsize=(19.2,10.8), dpi=100)
plt.suptitle('CASE 4: $W_L = [1.0,0.0,0.01]$, \
             $W_R = [1.0,0.0,100.0]$, $t = 0.035$',fontsize=30)
plt.subplot(2,2,1)
plt.xlabel('Position')
plt.ylabel('Density')
plt.yticks([0,3,6])
plt.xticks([0,1])
plt.plot(xpos4,ds4)

plt.subplot(2,2,2)
plt.xlabel('Position')
plt.ylabel('Velocity')
plt.yticks([-7,-3.5,0])
plt.xticks([0,1])
plt.plot(xpos4,us4)

plt.subplot(2,2,3)
plt.xlabel('Position')
plt.ylabel('Pressure')
plt.yticks([10,50,100])
plt.xticks([0,1])
plt.plot(xpos4,ps4)

plt.subplot(2,2,4)
plt.xlabel('Position')
plt.ylabel('Internal Energy')
plt.xticks([0,1])
plt.yticks([0,230,260])
plt.plot(xpos4,internal_energy4)
plt.savefig('case4.png', dpi=60)


fig5 = plt.figure(figsize=(19.2,10.8), dpi=100)
plt.suptitle('CASE 5: $W_L = [5.99924,19.5975,460.894]$,\
             $W_R = [5.99242,-6.19633,46.0950]$, \
             $t = 0.035$',fontsize=30)
plt.subplot(2,2,1)
plt.xlabel('Position')
plt.ylabel('Density')
plt.yticks([0,20,40])
plt.xticks([0,1])
plt.plot(xpos5,ds5)

plt.subplot(2,2,2)
plt.xlabel('Position')
plt.ylabel('Velocity')
plt.yticks([0,12.5,25])
plt.xticks([0,1])
plt.plot(xpos5,us5)

plt.subplot(2,2,3)
plt.xlabel('Position')
plt.ylabel('Pressure')
plt.yticks([0,100,2000])
plt.xticks([0,1])
plt.plot(xpos5,ps5)

plt.subplot(2,2,4)
plt.xlabel('Position')
plt.ylabel('Internal Energy')
plt.xticks([0,1])
plt.yticks([0,200,400])
plt.plot(xpos5,internal_energy5)
plt.savefig('case5.png', dpi=60)