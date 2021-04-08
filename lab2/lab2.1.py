import matplotlib.pyplot as plt
from lab2 import signal_generator
import dft

HARMONICS = 10
FREQUENCY = 1500
DISCRETE_CALLS = 256

signal = signal_generator.generate_signal(
  HARMONICS,
  FREQUENCY,
  DISCRETE_CALLS
)
spectrum_dft = dft.discrete_fourier_transform(signal)

fig, (ax1, ax2) = plt.subplots(2)
fig.suptitle('Laboratorka 2.1')
fig.set_size_inches(18.5, 10.5)

ax1.plot(signal)
ax1.set_title('Generated signal')
ax1.set(xlabel='time', ylabel='generated signal')

ax2.plot(spectrum_dft)
ax2.set_title('Discrete Fourier transform of generated signal')
ax2.set(xlabel='time', ylabel='dft')
fig.savefig('lab2_1.png')

plt.show()