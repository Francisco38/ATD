function [media, desvio] = countSteps(array_x, array_y, array_z)
    Fs = 50;
    minute = 60;
    N = numel(array_x);
    thresholdMultiplier = 0.8;
    
    if (mod(N,2)==0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
    else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end

    black_win_x =  blackman(numel(array_x));
    dft_black_x = fftshift(fft(detrend(array_x).*black_win_x));
    m_black_x = abs(dft_black_x); 

    black_win_y =  blackman(numel(array_y));
    dft_black_y = fftshift(fft(detrend(array_y).*black_win_y));
    m_black_y = abs(dft_black_y);

    black_win_z =  blackman(numel(array_z));
    dft_black_z = fftshift(fft(detrend(array_z).*black_win_z));
    m_black_z = abs(dft_black_z);
    
    threshold_x = max(m_black_x)*thresholdMultiplier;
    [~,locs_x] = findpeaks(m_black_x, 'MinPeakHeight', threshold_x);
    f_relevant_x = f(locs_x);   
    f_relevant_x = f_relevant_x(f_relevant_x > 0);
    round(f_relevant_x);
    
    threshold_y = max(m_black_y)*thresholdMultiplier;
    [~,locs_y] = findpeaks(m_black_y, 'MinPeakHeight', threshold_y);
    f_relevant_y = f(locs_y);   
    f_relevant_y = f_relevant_y(f_relevant_y > 0);
    round(f_relevant_y);
    
    threshold_z = max(m_black_z)*thresholdMultiplier;  
    [~,locs_z] = findpeaks(m_black_z, 'MinPeakHeight', threshold_z);
    f_relevant_z = f(locs_z);
    f_relevant_z = f_relevant_z(f_relevant_z > 0);
    round(f_relevant_z);
    
    media = [mean(f_relevant_x.*minute) mean(f_relevant_y.*minute) mean(f_relevant_z.*minute)]
    desvio = [std(f_relevant_x.*minute) std(f_relevant_y.*minute) std(f_relevant_z.*minute)]
end