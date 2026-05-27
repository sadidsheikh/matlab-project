function filtered = movingAverageFilter(signal, windowSize)
%MOVINGAVERAGEFILTER Applies a simple moving average filter to a signal
%   signal     - Input signal vector
%   windowSize - Number of samples in the moving average window
%
%   Returns:
%   filtered   - Filtered signal vector

    b = (1/windowSize)*ones(1, windowSize);
    a = 1;
    filtered = filter(b, a, signal);
end