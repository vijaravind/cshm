% Sophie SAKKA 
% Creates filename.mat file from filename.drf 
% filename.mat contains the following data:
% -- T_F1 to T_F20: data for JOINT frames for each time sample
% -- T_TR1 to T_TR17: data for TRACKED frames for each time sample
%    (when a frame is lost, that time sample is padded with NaNs)
% -- time: vector of time stamps
% -- filename
% -- LostSamples
%

% Name of .drf file to be opened
%filename = 'MediumJump';         
% Path to save generated files
pathname = './';       

% For filtering
WINDOWSIZE=15;

fid = fopen(strcat(filename,'.drf'),'rt','n',feature('DefaultCharacterSet'));
B = textscan(fid,'%s','delimiter', '\n');
fclose(fid);

samples = length(B{1});

k_time = 1;
k_6dj = 1;
k_6dt = 1;
trackedMax = 0;
for k = 1:samples
    % Time samples
    B{1}{k};
    if (length(B{1}{k}) > 0) && (B{1}{k}(1) == 't') && (B{1}{k}(2) == 's')
        A = textscan(B{1}{k},'ts %f');
        time(k_time,1) = A{1};
        k_time = k_time + 1;
    end
    % 20 frames corresponding to each of the 20 joints (F1~F20)
    if (length(B{1}{k}) > 3) && (B{1}{k}(3) == 'j')
        str=B{1}{k};
        y=regexp(str,'[','split');
        Ntracked=(length(y)-2)/3;
        for i=1:Ntracked
            f=cell2mat(textscan(y{3*(i-1)+3},'%f %f]'));
            xyzRxyz=cell2mat(textscan(y{3*(i-1)+4},'%f %f %f %f %f %f]'));
            xyz=xyzRxyz(1:3)/1000;
            r=cell2mat(textscan(y{3*(i-1)+5},'%f %f %f %f %f %f %f %f %f]'));
            T=buildSingleT(xyz,r);
            eval(['T_F' int2str(f(1) + 1) '(:,:, k_6dj)=T;']);
        end
        k_6dj = k_6dj + 1;
    end
    % 17 frames corresponding to each of the 17 segments (TR1~TR17)
    if (length(B{1}{k}) > 4) && (B{1}{k}(2) == 'd') && (B{1}{k}(4) == '1')
        str=B{1}{k};
        y=regexp(str,'[','split');
        Ntracked=(length(y)-1)/3;
        for i=1:Ntracked
            f=cell2mat(textscan(y{3*(i-1)+2},'%f %f]'));
            xyzRxyz=cell2mat(textscan(y{3*(i-1)+3},'%f %f %f %f %f %f]'));
            xyz=xyzRxyz(1:3)/1000;
            r=cell2mat(textscan(y{3*(i-1)+4},'%f %f %f %f %f %f %f %f %f]'));
            T=buildSingleT(xyz,r);
            eval(['T_TR' int2str(f(1) + 1) '(:,:, k_6dt)=T;']);
        end
        k_6dt = k_6dt + 1;
    end
end

Nsamples=k_6dt-1;
% Substitute T with zeros for T with NaNs and interpolate missing frames
% For TR set
for i=1:17
    I=int2str(i);
    eval(['tr=T_TR' I ';'])
    if length(tr)<Nsamples
        taux=tr(:,:,length(tr));
        tr = padarray(tr,[0,0,Nsamples-length(tr)],'replicate','post');
    end
    samples(i) = length(tr);
    indexLostSamples=(find(sum(sum(tr))==0));
    LostSamples(i)=length(indexLostSamples);
    if LostSamples(i)>0
        tr(:,:,indexLostSamples)=ones(4,4,LostSamples(i))*NaN;
    end
    %interpolation
    for p=1:4
        for j=1:4
            tr(p,j,:)=smooth(interpolate(squeeze(tr(p,j,:))),WINDOWSIZE);
        end
    end
    eval(['T_TR' I '=tr;']);
end

% Substitute T with zeros for T with NaNs and interpolate missing frames
% For F set
for i=1:20
    I=int2str(i);
    eval(['tr=T_F' I ';'])
    %Smoothing
    for p=1:3
        for j=1:4
            tr(p,j,:)=smooth(squeeze(tr(p,j,:)),WINDOWSIZE);
        end
    end
    eval(['T_F' I '=tr;']);
end

clearvars A B fid frames j k k_6dj k_6dt k_time samples tracked vars varst ans trackedMax i C
clearvars F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 F13 F14 F15 F16 F17 F18 F19 F20
clearvars TR1 TR2 TR3 TR4 TR5 TR6 TR7 TR8 TR9 TR10 TR11 TR12 TR13 TR14 TR15 TR16 TR17
clearvars WINDOWSIZE f p r str tr xyz xyzRxyz y Nsamples Ntracked I T indexLostSamples

samples = size(T_F1,3);
frames = 20;
tracked = 17;

save(strcat(pathname,filename,'.mat'))