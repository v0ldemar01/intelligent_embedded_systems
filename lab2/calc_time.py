from lab2 import signal_generator
import fft
import numpy as np
from time import perf_counter

HARMONICS = 10
FREQUENCY = 1500

for i in range(5,12):
    DISCRETE_CALLS = 2**i
    signal = signal_generator.generate_signal(
        HARMONICS,
        FREQUENCY,
        DISCRETE_CALLS
    )
    print("N = 2^{0} ".format(i))

    time_start = perf_counter()
    fft.fast_fourier_transform(signal)
    time_end = perf_counter()
    print("time : {0}s (own fft)".format(time_end - time_start))

    time_start = perf_counter()
    np.fft.fft(signal)
    time_end = perf_counter()
    print("time : {0}s (numpy fft)\n".format(time_end - time_start))