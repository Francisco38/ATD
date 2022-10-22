function [] = dft(array_x,array_y, array_z, figure_num, activitie_name)
    Fs = 50;
    N = numel(array_x); %Periódo Fundamental
    t = linspace(0,(N-1)/Fs,N);

    if (mod(N,2)==0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
    else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end
    
    %BLACKMAN WINDOWS
    black_win_x = blackman(numel(array_x));
    dft_black_x = fftshift(fft(detrend(array_x).*black_win_x));
    m_black_x = abs(dft_black_x); 

    black_win_y = blackman(numel(array_y));
    dft_black_y = fftshift(fft(detrend(array_y).*black_win_y));
    m_black_y = abs(dft_black_y);

    black_win_z = blackman(numel(array_z));
    dft_black_z = fftshift(fft(detrend(array_z).*black_win_z));
    m_black_z = abs(dft_black_z);    

    figure(figure_num)
    subplot(2, 2, 1)
    plot(t,array_x)
    axis tight
    xlabel('t [s]')
    ylabel('Amplitude')
    title(activitie_name)
    subplot(2, 2, 2)
    p1 = plot(f,m_black_x, 'black'); 
    title('|DFT| WINDOWS X');
    ylabel('Magnitude = |X|')
    xlabel('f [Hz]')
    legend(p1, 'BLACKMAN');
    axis tight

    subplot(2, 2, 3)
    p1 = plot(f,m_black_y, 'black');
    title('|DFT| WINDOWS Y');
    ylabel('Magnitude = |X|')
    xlabel('f [Hz]')
    legend(p1, 'BLACKMAN');
    axis tight

    subplot(2, 2, 4)
    p1 = plot(f,m_black_z, 'black');
    title('|DFT| WINDOWS Z');
    ylabel('Magnitude = |X|')
    xlabel('f [Hz]')
    legend(p1, 'BLACKMAN');
    axis tight
end

