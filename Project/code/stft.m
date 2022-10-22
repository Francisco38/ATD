function [] = stft(array_z, figure_num, activitie)
    Fs = 50;
    N = numel(array_z); %Periódo Fundamental
    t = linspace(0,(N-1)/Fs,N);

    if (mod(N,2)==0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
    else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end
    
    %BLACKMAN WINDOWS
    black_win_z = blackman(numel(array_z));
    dft_black_z = fftshift(fft(detrend(array_z).*black_win_z));
    m_black_z = abs(dft_black_z);

    figure(figure_num)
    subplot(2, 1, 1)
    plot(t,array_z)
    axis tight
    xlabel('t [s]')
    ylabel('Amplitude')
    title(activitie)
    
    subplot(2, 1, 2)
    p1 = plot(f,m_black_z, 'black');
    hold off;
    title('|DFT| WINDOWS Z');
    ylabel('Magnitude = |X|')
    xlabel('f [Hz]')
    legend(p1, 'BLACKMAN');
    axis tight
end