import matplotlib.pyplot as plt
import signal_generator
import complexity_generator
import statistics_utils

HARMONICS = 10
FREQUENCY = 1500
DISCRETE_CALLS = 256

signal = signal_generator.generate_signal(
  HARMONICS,
  FREQUENCY,
  DISCRETE_CALLS
)

time = complexity_generator.calculate_time(
  HARMONICS,
  FREQUENCY,
  2500
)

print("Math expectation = " + str(statistics_utils.math_expectation(signal)))
print("Math variance = " + str(statistics_utils.math_variance(signal)))

fig, (ax1, ax2) = plt.subplots(2)
fig.suptitle('Laboratorka 1.1')
fig.set_size_inches(18.5, 10.5)

ax1.plot(signal)
ax1.set_title('Generated signal')
ax1.set(xlabel='time', ylabel='generated signal')

ax2.plot(time)
ax2.set_title('Complexity of signal generation')
ax2.set(xlabel='number of discrete calls', ylabel='time (seconds)')
fig.savefig('lab1_1.png')

plt.show()
