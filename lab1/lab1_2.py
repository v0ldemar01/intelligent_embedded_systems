import matplotlib.pyplot as plt
import signal_generator
import complexity_generator
import statistics_utils

HARMONICS = 10
FREQUENCY = 1500
DISCRETE_CALLS = 256

signal_first = signal_generator.generate_signal(
  HARMONICS,
  FREQUENCY,
  DISCRETE_CALLS
)
signal_second = signal_generator.generate_signal(
  HARMONICS,
  FREQUENCY,
  DISCRETE_CALLS
)

auto_correlation_signal = statistics_utils.auto_correlation(signal_first)
cross_correlation_signal = statistics_utils.cross_correlation(signal_first, signal_second)

# auto_correlation_time = complexity_generator.calculate_time_correlation(
#   HARMONICS,
#   FREQUENCY,
#   500,
#   'auto'
# )
#
# cross_correlation_time = complexity_generator.calculate_time_correlation(
#   HARMONICS,
#   FREQUENCY,
#   500,
#   'cross'
# )

fig, (((ax00), (ax01)), ((ax10), (ax11))) = plt.subplots(2, 2)
fig.suptitle('Laboratorka 1.2')
fig.set_size_inches(18.5, 10.5)

ax00.plot(signal_first)
ax00.set_title('Generate first signal')
ax00.set(xlabel='time', ylabel='generated signal')

ax01.plot(signal_second)
ax01.set_title('Generate second signal')
ax01.set(xlabel='time', ylabel='generated signal')

ax10.plot(auto_correlation_signal)
ax10.set_title('Autocorrelation of first signal')
ax10.set(xlabel='tau', ylabel='correlation')

ax11.plot(cross_correlation_signal)
ax11.set_title('Crosscorrelation of first and second signals')
ax11.set(xlabel='tau', ylabel='correlation')

fig.savefig('lab1_2.png')

# fig, (ax3, ax4) = plt.subplots(2)
# fig.suptitle('Laboratorka 1.2 Complexity')
# fig.set_size_inches(18.5, 10.5)
#
# ax3.plot(auto_correlation_time)
# ax3.set_title('Complexity of auto correlation')
# ax3.set(xlabel='number of discrete calls', ylabel='time (seconds)')
#
# ax4.plot(cross_correlation_time)
# ax4.set_title('Complexity of cross correlation')
# ax4.set(xlabel='number of discrete calls', ylabel='time (seconds)')
# fig.savefig('lab1_2_complexity.png')

plt.show()



