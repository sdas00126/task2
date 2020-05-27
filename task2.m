clc;
clear all;
close all;
disp('Hello User!!!  PLease select START RECORDING from  the menu to start recording an audio for 10 seconds');
k=menu('WELCOME TO AUDIO RECORDER','START RECORDING','CANCEL');
switch k
case 1
fs=10000;
a=audiorecorder(10000,8,1);
disp('Audio Recording has started!! Please speak');
record(a,10);
pause(10);
disp('An audio of duration 10 seconds is recorded');
b=getaudiodata(a);
disp('Please select a folder where you want to save the audio file you have recorded');
folder=uigetdir(path,'SAVE THE AUDIO FILE');
if folder==0
    disp('Unfortunately you have not selected any folder')
else
file=input('Enter a name for your audio file: ','s');
filename=strcat(file,'.wav');
filename=strcat(folder,'\',filename);
disp('The selected path for the saved AUDIO file is: ');
disp(filename);
audiowrite(filename,b,10000);
t=linspace(1,10,length(b));
fc=2000;
ec=cos(2*pi*fc*t);%carrier wave
c=menu('PLEASE CHOOSE THE TYPE OF MODULATION','AMPLITUDE MODULATION','FREQUENCY MODULATION');
switch c
    case 1
        M=modulate(b,fc,fs,'am');
        D=demod(M,fc,fs,'am');
        DA=D*100;
        p=audioplayer(DA,fs);
        figure('Name','AMPLITUDE MODULATION');
    case 2
        M=modulate(b,fc,fs,'fm');
        D=demod(M,fc,fs,'fm');
        DA=D*100;
        p=audioplayer(DA,fs);
        figure('Name','FREQUENCY MODULATION');
    case 0
        disp('You have closed the menu..TRY AGAIN');
        close all;
        return;
end
subplot(411);
plot(t',b);
xlabel('Time->')
ylabel('Amplitude->');
title('Input Signal');
subplot(412);
plot(t',ec);
xlabel('Time->')
ylabel('Amplitude->');
title('Carrier Signal');
subplot(413);
plot(t',M);
xlabel('Time->');
ylabel('Amplitude->');
title('Modulated Signal');
subplot(414);
plot(t',D);
xlabel('Time->')
ylabel('Amplitude->');
title('De-modulated Signal');
pause(5);
play(p);
end
    case 2
        close all;
        disp('You have cancelled the audio recording');
        return;
    case 0
        disp('Unfortunately you closed the menu ..TRY AGAIN');
end