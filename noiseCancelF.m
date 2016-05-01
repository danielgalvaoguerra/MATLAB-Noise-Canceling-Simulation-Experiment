function noiseCancelF(handles, noise, playSound, option)
% function noiseCancelF(handles, noise, playSound, option) defines
% various signals dealing w/ noise cancelling and either plots them 
% or plays a specific signal dictated by input option
% input handles is the handles object from the GUI
% input n is the noise generated beforehand by another function
% input playSound is a boolean determining whether the function will
%   play a specific signal, or just plot the signals
% input option decides which signal to play if playSound is true

% 'noise' is saved as structured array, this converts it to 
% a single dimensional array in order to use conventional '*' operator
% on it later
noise=cell2mat(struct2cell(noise));

[song,fs]=audioread('song.wav');
Ts = 1/fs;

T = 3;
N = T/Ts;

song_trimmed = song(1:N);

% Noise Removal Index (num from 0 to 1)
a = handles.NRI_slider.Value; % the lower this is, the less effective the noise removal

for i=1:N
    % generates and anti tone signal to remove noise from song
    % the rand function based off the interval is used to simulate
    % the imperfect noise removal in real-world applications
    anti_noise(i) = (-1)*(rand(1)*(1-a) + a)*noise(i);
end

% define signals for song+noise and final noise-cancelled signal
songAndNoise = (song_trimmed + noise);
signal_final = songAndNoise + anti_noise;

if playSound == false
    
    % plot all signals
    axes(handles.noiseAxes);
    plot(0:Ts:(N-1)*Ts,noise);
    axes(handles.songAxes);
    plot(0:Ts:(N-1)*Ts,song_trimmed);
    axes(handles.songNoiseAxes);
    plot(0:Ts:(N-1)*Ts,songAndNoise);
    axes(handles.cancelledAxes);
    plot(0:Ts:(N-1)*Ts,signal_final);
    
else
    
    % play a specific signal
    switch option
        case 'noise'
            sound(noise, fs);
        case 'song'
            sound(song_trimmed, fs);
        case 'songAndNoise'
            sound(songAndNoise,fs);
        case 'noiseCancelled'
            sound(signal_final,fs);
    end
end
