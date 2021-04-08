import math

from lab2.dft import calc_w


def fast_fourier_transform(signal):
    N = len(signal)
    spectre = [0] * N
    if N == 1: return signal
    even_signal, odd_signal = signal[::2], signal[1::2]
    even_transformed = fast_fourier_transform(even_signal)
    odd_transformed = fast_fourier_transform(odd_signal)
    for k in range(0, int(N / 2)):
        w = calc_w(1, k, N)
        spectre[k] = even_transformed[k] + w * odd_transformed[k]
        spectre[k + int( N / 2)] = even_transformed[k] - w * odd_transformed[k]
    return [*map(lambda el: abs(el), spectre)]

