import time as t
import signal_generator


def calculate_time(signal_harmonics, start_frequency, number_discrete_calls):
    time = []
    for n in range(number_discrete_calls):
        start_time = t.time()
        signal_generator.generate_signal(signal_harmonics, start_frequency, n)
        end_time = t.time()
        time.append(end_time - start_time)
    return time
