
% group all data and calculate FR aligned to different event

cd('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\rawData');


% data structure: n cells
%   FR: -1000ms to +2000ms (can subset later if needed)
%       only spike, not smoothed
%   FRgood: 0/1: 0 for neurons with average FR < 1Hz
%   dataOrigin: M0007 for example
%   brainArea: character data
%   brainAreaIndex: integer data
%   stimulus: 1-4
%   bar-size: integer
%   trialOrderWithinBlock (playedTrial): 1-6
%   


%% aligned to CUE onset
% DONE - 20231122

allFilesNames = importdata('_fulldata_filelist.txt');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');


% each cell is for each neuron
FRs = [];
FRgood = [];
dataOrigin = [];
brainArea = [];
brainAreaIndex = [];
stimulus = [];
barSize = [];
playedTrial = [];
errorTrials = [];

for ff = 1:numel(allFilesNames)
    
    try
        load([allFilesNames{ff} '.mat']);
    catch
        continue
    end
    
    eventIdx = cellfun(@(x) strcmp(x, 'target on'), data.BHV.CodeNamesUsed, 'uni', 0);
    eventIdx = cat(1, eventIdx{:});
    eventIdx = find(eventIdx);
    eventIdx = data.BHV.CodeNumbersUsed(eventIdx);
    eventOn = nan(data.NEURO.NumTrials,1);
    for k = 1:length(eventOn)
        if ismember(eventIdx,data.NEURO.CodeNumbers2{k})   
            eventOn(k) = data.NEURO.CodeTimes2{k}((data.NEURO.CodeNumbers2{k}==eventIdx));
        end
    end
    
    % neurons
    neurons = fieldnames(data.NEURO.Neuron);
    for nCell = 1:numel(neurons)
        
        channel = fieldnames(data.NEURO.LFP);
        spikes = zeros(1,length(data.NEURO.LFP.(channel{1})));
        if length(data.NEURO.Neuron.(neurons{nCell})) < length(spikes)/1000
            FRgood = [FRgood; 0];
        else
            FRgood = [FRgood; 1];
        end
        spikes( data.NEURO.Neuron.(neurons{nCell}) ) = 1000;

        % putting spikes into trials aligned with cue on
        trials = NaN(data.NEURO.NumTrials, 3000);
        for trialIdx = 1:length(eventOn)
            if ~isnan(eventOn(trialIdx))
                trials(trialIdx, :) = spikes( eventOn(trialIdx)-999 : eventOn(trialIdx)+2000 );
            end
        end
        
        dataOrigin{end+1,1} = string(allFilesNames{ff});
        brainAreaIndex{end+1,1} = data.NEURO.areaIdx(nCell);
        if ~isnan(data.NEURO.areaIdx(nCell))
            brainArea{end+1,1} = string(brainAreaNumbers{data.NEURO.areaIdx(nCell)});
        else
            brainArea{end+1,1} = [];
        end
        FRs{end+1,1} = trials;
        
        % bar size
        stimulus{end+1,1} = data.BHV.Picture;
        barSize{end+1,1} = data.BHV.BarSz + 3;
        playedTrial{end+1,1} = data.BHV.PlayedTrials;
        errorTrials{end+1,1} = data.BHV.TrialError;
    end
    
end

save('allDataAlignedToCueOnset.mat', 'FRs', 'FRgood', 'dataOrigin', ...
    'brainArea', 'brainAreaIndex', 'stimulus', 'barSize', 'playedTrial', 'errorTrials', '-v7.3');



%% aligned to REWARD BAR onset
% DONE - 20231122

allFilesNames = importdata('_fulldata_filelist.txt');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');


% each cell is for each neuron
FRs = [];
FRgood = [];
dataOrigin = [];
brainArea = [];
brainAreaIndex = [];
stimulus = [];
barSize = [];
playedTrial = [];
errorTrials = [];

for ff = 1:numel(allFilesNames)
    
    try
        load([allFilesNames{ff} '.mat']);
    catch
        continue
    end
    
    eventIdx = cellfun(@(x) strcmp(x, 'initial reward bar on'), data.BHV.CodeNamesUsed, 'uni', 0);
    eventIdx = cat(1, eventIdx{:});
    eventIdx = find(eventIdx);
    eventIdx = data.BHV.CodeNumbersUsed(eventIdx);
    eventOn = nan(data.NEURO.NumTrials,1);
    for k = 1:length(eventOn)
        if ismember(eventIdx,data.NEURO.CodeNumbers2{k})   
            eventOn(k) = data.NEURO.CodeTimes2{k}((data.NEURO.CodeNumbers2{k}==eventIdx));
        end
    end
    
    % neurons
    neurons = fieldnames(data.NEURO.Neuron);
    for nCell = 1:numel(neurons)
        
        channel = fieldnames(data.NEURO.LFP);
        spikes = zeros(1,length(data.NEURO.LFP.(channel{1})));
        if length(data.NEURO.Neuron.(neurons{nCell})) < length(spikes)/1000
            FRgood = [FRgood; 0];
        else
            FRgood = [FRgood; 1];
        end
        spikes( data.NEURO.Neuron.(neurons{nCell}) ) = 1000;

        % putting spikes into trials aligned with cue on
        trials = NaN(data.NEURO.NumTrials, 3000);
        for trialIdx = 1:length(eventOn)
            if ~isnan(eventOn(trialIdx))
                trials(trialIdx, :) = spikes( eventOn(trialIdx)-999 : eventOn(trialIdx)+2000 );
            end
        end
        
        dataOrigin{end+1,1} = string(allFilesNames{ff});
        brainAreaIndex{end+1,1} = data.NEURO.areaIdx(nCell);
        if ~isnan(data.NEURO.areaIdx(nCell))
            brainArea{end+1,1} = string(brainAreaNumbers{data.NEURO.areaIdx(nCell)});
        else
            brainArea{end+1,1} = [];
        end
        FRs{end+1,1} = trials;
        
        % bar size
        stimulus{end+1,1} = data.BHV.Picture;
        barSize{end+1,1} = data.BHV.BarSz + 3;
        playedTrial{end+1,1} = data.BHV.PlayedTrials;
        errorTrials{end+1,1} = data.BHV.TrialError;
    end
    
end

save('allDataAlignedToRewardBarOnset.mat', 'FRs', 'FRgood', 'dataOrigin', ...
    'brainArea', 'brainAreaIndex', 'stimulus', 'barSize', 'playedTrial', 'errorTrials', '-v7.3');




%% aligned to FEEDBACK
% done 20221204

allFilesNames = importdata('_fulldata_filelist.txt');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');


% each cell is for each neuron
FRs = [];
FRgood = [];
dataOrigin = [];
brainArea = [];
brainAreaIndex = [];
stimulus = [];
barSize = [];
playedTrial = [];
errorTrials = [];
absReward = [];     % new bar-size = bar-size + absolute reward
                    % relative reward = stimulus-valence x absolute-reward

for ff = 1:numel(allFilesNames)
    
    try
        load([allFilesNames{ff} '.mat']);
    catch
        continue
    end
    rew = [];
    
    eventIdx = cellfun(@(x) contains(x, 'feedback='), data.BHV.CodeNamesUsed, 'uni', 0);
    eventIdx = cat(1, eventIdx{:});
    eventIdx = find(eventIdx);
    eventIdx = data.BHV.CodeNumbersUsed(eventIdx);
    eventOn = nan(data.NEURO.NumTrials,1);
    for k = 1:length(eventOn)
        ii = find(ismember(eventIdx,data.NEURO.CodeNumbers2{k}));
        if ii
            evIdx = eventIdx(ii);
            eventOn(k) = data.NEURO.CodeTimes2{k}((data.NEURO.CodeNumbers2{k}==evIdx));
            if ii == 1
                rew = [rew; -1];
            elseif ii == 2
                rew = [rew; 0];
            elseif ii == 3
                rew = [rew; 1];
            end
        else
            rew = [rew; nan];
        end
    end
    
    % neurons
    neurons = fieldnames(data.NEURO.Neuron);
    for nCell = 1:numel(neurons)
        
        channel = fieldnames(data.NEURO.LFP);
        spikes = zeros(1,length(data.NEURO.LFP.(channel{1})));
        if length(data.NEURO.Neuron.(neurons{nCell})) < length(spikes)/1000
            FRgood = [FRgood; 0];
        else
            FRgood = [FRgood; 1];
        end
        spikes( data.NEURO.Neuron.(neurons{nCell}) ) = 1000;

        % putting spikes into trials aligned with cue on
        trials = NaN(data.NEURO.NumTrials, 3000);
        for trialIdx = 1:length(eventOn)
            if ~isnan(eventOn(trialIdx))
                trials(trialIdx, :) = spikes( eventOn(trialIdx)-999 : eventOn(trialIdx)+2000 );
            end
        end
        
        dataOrigin{end+1,1} = string(allFilesNames{ff});
        brainAreaIndex{end+1,1} = data.NEURO.areaIdx(nCell);
        if ~isnan(data.NEURO.areaIdx(nCell))
            brainArea{end+1,1} = string(brainAreaNumbers{data.NEURO.areaIdx(nCell)});
        else
            brainArea{end+1,1} = [];
        end
        FRs{end+1,1} = trials;
        
        % bar size
        stimulus{end+1,1} = data.BHV.Picture;
        barSize{end+1,1} = data.BHV.BarSz + 3;
        playedTrial{end+1,1} = data.BHV.PlayedTrials;
        errorTrials{end+1,1} = data.BHV.TrialError;
        absReward{end+1,1} = rew;
    end
    
end

save('allDataAlignedToFeedback.mat', 'FRs', 'FRgood', 'dataOrigin', ...
    'brainArea', 'brainAreaIndex', 'stimulus', 'barSize', 'playedTrial', 'errorTrials', 'absReward', '-v7.3');



%% BEHAVIORAL
% done - 20240119

allFilesNames = importdata('_fulldata_filelist.txt');


% each cell is for each neuron
RTs = [];
dataOrigin = [];
dataIndex = [];
stimulus = [];
barSize = [];
playedTrial = [];
errorTrials = [];


for ff = 1:numel(allFilesNames)
    
    try
        load([allFilesNames{ff} '.mat']);
    catch
        continue
    end
    
    
    % neurons
    neurons = fieldnames(data.NEURO.Neuron);
    for nCell = 1:numel(neurons)
        dataOrigin{end+1,1} = string(allFilesNames{ff});
        dataIndex = [dataIndex ff];
        RTs{end+1,1} = data.BHV.ReactionTime;
        stimulus{end+1,1} = data.BHV.Picture;
        barSize{end+1,1} = data.BHV.BarSz + 3;
        playedTrial{end+1,1} = data.BHV.PlayedTrials;
        errorTrials{end+1,1} = data.BHV.TrialError;
    end
    
end

save('allBehavioralData.mat', 'RTs', 'dataOrigin', 'dataIndex', 'stimulus', 'barSize', 'playedTrial', 'errorTrials');



%% aligned to FIXATION
% done - 20240223

allFilesNames = importdata('_fulldata_filelist.txt');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');


% each cell is for each neuron
FRs = [];
FRgood = [];
dataOrigin = [];
brainArea = [];
brainAreaIndex = [];
stimulus = [];
barSize = [];
playedTrial = [];
errorTrials = [];


for ff = 1:numel(allFilesNames)
    
    try
        load([allFilesNames{ff} '.mat']);
    catch
        continue
    end
    
    eventIdx = cellfun(@(x) strcmp(x, 'fixation held'), data.BHV.CodeNamesUsed, 'uni', 0);
    eventIdx = cat(1, eventIdx{:});
    eventIdx = find(eventIdx);
    eventIdx = data.BHV.CodeNumbersUsed(eventIdx);
    eventOn = nan(data.NEURO.NumTrials,1);
    for k = 1:length(eventOn)
        if ismember(eventIdx,data.NEURO.CodeNumbers2{k})   
            eventOn(k) = data.NEURO.CodeTimes2{k}((data.NEURO.CodeNumbers2{k}==eventIdx));
        end
    end
    
    % neurons
    neurons = fieldnames(data.NEURO.Neuron);
    for nCell = 1:numel(neurons)
        
        channel = fieldnames(data.NEURO.LFP);
        spikes = zeros(1,length(data.NEURO.LFP.(channel{1})));
        if length(data.NEURO.Neuron.(neurons{nCell})) < length(spikes)/1000
            FRgood = [FRgood; 0];
        else
            FRgood = [FRgood; 1];
        end
        spikes( data.NEURO.Neuron.(neurons{nCell}) ) = 1000;

        % putting spikes into trials aligned with cue on
        trials = NaN(data.NEURO.NumTrials, 3000);
        for trialIdx = 1:length(eventOn)
            if ~isnan(eventOn(trialIdx))
                trials(trialIdx, :) = spikes( eventOn(trialIdx)-999 : eventOn(trialIdx)+2000 );
            end
        end
        
        dataOrigin{end+1,1} = string(allFilesNames{ff});
        brainAreaIndex{end+1,1} = data.NEURO.areaIdx(nCell);
        if ~isnan(data.NEURO.areaIdx(nCell))
            brainArea{end+1,1} = string(brainAreaNumbers{data.NEURO.areaIdx(nCell)});
        else
            brainArea{end+1,1} = [];
        end
        FRs{end+1,1} = trials;
        
        % bar size
        stimulus{end+1,1} = data.BHV.Picture;
        barSize{end+1,1} = data.BHV.BarSz + 3;
        playedTrial{end+1,1} = data.BHV.PlayedTrials;
        errorTrials{end+1,1} = data.BHV.TrialError;
    end
    
end

save('allDataAlignedToFixation.mat', 'FRs', 'FRgood', 'dataOrigin', ...
    'brainArea', 'brainAreaIndex', 'stimulus', 'barSize', 'playedTrial', 'errorTrials', '-v7.3');


%% aligned to RESPONSE
% DONE - 20240223

allFilesNames = importdata('_fulldata_filelist.txt');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');


% each cell is for each neuron
FRs = [];
FRgood = [];
dataOrigin = [];
brainArea = [];
brainAreaIndex = [];
stimulus = [];
barSize = [];
playedTrial = [];
errorTrials = [];


for ff = 1:numel(allFilesNames)
    
    try
        load([allFilesNames{ff} '.mat']);
    catch
        continue
    end
    
    eventOn = nan(data.NEURO.NumTrials,1);
    for res = 1:2
        switch res
            case 1
                eventIdx = cellfun(@(x) strcmp(x, 'left response'), data.BHV.CodeNamesUsed, 'uni', 0);
            case 2
                eventIdx = cellfun(@(x) strcmp(x, 'right response'), data.BHV.CodeNamesUsed, 'uni', 0);
        end

        eventIdx = cat(1, eventIdx{:});
        eventIdx = find(eventIdx);
        eventIdx = data.BHV.CodeNumbersUsed(eventIdx);

        for ii = 1:length(eventOn)
            % ismember since some trial, monkey failed to fixate -> no cue on
            if ismember( eventIdx, data.NEURO.CodeNumbers2{ii} )   
                eventOn(ii) = data.NEURO.CodeTimes2{ii}( (data.NEURO.CodeNumbers2{ii} == eventIdx) );
            end
        end
    end

    
    % neurons
    neurons = fieldnames(data.NEURO.Neuron);
    for nCell = 1:numel(neurons)
        
        channel = fieldnames(data.NEURO.LFP);
        spikes = zeros(1,length(data.NEURO.LFP.(channel{1})));
        if length(data.NEURO.Neuron.(neurons{nCell})) < length(spikes)/1000
            FRgood = [FRgood; 0];
        else
            FRgood = [FRgood; 1];
        end
        spikes( data.NEURO.Neuron.(neurons{nCell}) ) = 1000;

        % putting spikes into trials aligned with cue on
        trials = NaN(data.NEURO.NumTrials, 3000);
        for trialIdx = 1:length(eventOn)
            if ~isnan(eventOn(trialIdx))
                trials(trialIdx, :) = spikes( eventOn(trialIdx)-999 : eventOn(trialIdx)+2000 );
            end
        end
        
        dataOrigin{end+1,1} = string(allFilesNames{ff});
        brainAreaIndex{end+1,1} = data.NEURO.areaIdx(nCell);
        if ~isnan(data.NEURO.areaIdx(nCell))
            brainArea{end+1,1} = string(brainAreaNumbers{data.NEURO.areaIdx(nCell)});
        else
            brainArea{end+1,1} = [];
        end
        FRs{end+1,1} = trials;
        
        % bar size
        stimulus{end+1,1} = data.BHV.Picture;
        barSize{end+1,1} = data.BHV.BarSz + 3;
        playedTrial{end+1,1} = data.BHV.PlayedTrials;
        errorTrials{end+1,1} = data.BHV.TrialError;
    end
    
end

save('allDataAlignedToResponse.mat', 'FRs', 'FRgood', 'dataOrigin', ...
    'brainArea', 'brainAreaIndex', 'stimulus', 'barSize', 'playedTrial', 'errorTrials', '-v7.3');




%%
