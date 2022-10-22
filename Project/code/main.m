%%CLEAR
close all
clc
clear
%%
expNumbers = {42, 43, 44, 45, 46, 47, 48, 49};
labels = importdata("labels.txt");
activities = importdata("activity_labels.txt");
activitiesGraph = {'W', 'W\_U', 'W\_D', 'SIT', 'STAND', 'LAY', 'S\_SIT', 'S\_STAND', 'S\_lay', 'L\_SIT', 'S\_lay', 'L\_STAND'};
axisLabels = {'ACC X','ACC Y','ACC Z', 'Time (min)'};

for i=1:1:1 %1-8
    %% LOAD FILES
    
    exp = expNumbers{i};
    user = floor(exp/2);
    filename = sprintf('acc_exp%s_user%s.txt', num2str(exp), num2str(user)); %%create custum string
    
    data = readmatrix(filename);

    dataSet_label = find(labels(:, 1) == exp);

    [points, eixos] = size(data);
    Fs = 50;
    t = [0: points - 1]./Fs;

    %% EX2
    figure(1+(i*19)-19)
    
    pos = "down";
    for j=1:3
        subplot(3, 1, j);
        plot(t./60, data(:, j), 'Black');
        xlabel(axisLabels{4});
        ylabel(axisLabels{j});
        hold on
        for k = 1 : numel(dataSet_label)
            plot(t(labels(dataSet_label(k), 4):labels(dataSet_label(k), 5))./60, data(labels(dataSet_label(k), 4):labels(dataSet_label(k), 5), j));
            if pos == "down"
                ypos = min(data(:, j)) - (0.2 * min(data(:, j)));
                pos = "up";
            else
                ypos = max(data(:, j)) - (0.2 * min(data(:, j)));
                pos = "down";
            end
            text(t(labels(dataSet_label(k), 4))/60, ypos, activitiesGraph{labels(dataSet_label(k), 3)}, 'FontSize', 7);
        end
    end

    %% VARIAVEIS PARA EXERCICIO 4
    walking_z = [];
    walking_upstairs_z = [];
    walking_downstairs_z = [];

    %% EX3
    for j=1:12
        x=[];
        y=[];
        z=[];
        vals = find(labels(dataSet_label, 3) == j);

        for c=1:numel(vals)
            x = cat(1, x, data(labels(dataSet_label(vals(c)),4): labels(dataSet_label(vals(c)),5),1));
            y = cat(1, y, data(labels(dataSet_label(vals(c)),4): labels(dataSet_label(vals(c)),5),2));
            z = cat(1, z, data(labels(dataSet_label(vals(c)),4): labels(dataSet_label(vals(c)),5),3));
        end
        dft(x,y,z,1+j+(i*19)-19,activitiesGraph(j));
        if j==1
            countSteps(x,y,z);
            walking_z = z;
        elseif j==2
            countSteps(x,y,z);
            walking_upstairs_z = z;
        elseif j==3
            countSteps(x,y,z);
            walking_downstairs_z = z;
        end
    end

    %%EX4
    figure(17+(i*19)-19)
    stft(walking_z, 17+(i*19)-19, 'WALKING_Z');
    stft(walking_upstairs_z, 18+(i*19)-19, 'WALKING UPSTAIRS');
    stft(walking_downstairs_z, 19+(i*19)-19, 'WALKING DOWNSTAIRS');
    hold off;
end