
% DONE - 2024/09/25



%% 1 - REWARD-BAR ONSET
% fig S1

% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_rewardBar.mat');


%%%%%%%% average coefficients

figure; hold on
for mdl = 1:4
    switch mdl
        case 1
            stl = 'o';
        case 2
            stl = '^';
        case 3
            stl = 'd';
        case 4
            stl = 's';
    end
    allBetas = lmeBetas(:,mdl);
    for ii = 1:6
        switch ii
            case 1
                clr = [0 0.4470 0.7410];
            case 2
                clr = [0.8500 0.3250 0.0980];
            case 3
                clr = [0.9290 0.6940 0.1250];
            case 4
                clr = [0.4940 0.1840 0.5560];
            case 5
                clr = [0.4660 0.6740 0.1880];
            case 6
                clr = [0.3010 0.7450 0.9330];
        end
        xx = (allBetas(brainAreaIndex == ii));
        [~, yy] = ttest(xx, 0);
        if ii == 6
            disp(yy);
        end
        plot(ii, log(yy), stl, 'Color', clr, 'MarkerSize', 10);
    end
end
plot([0.5 6.5], [log(0.05) log(0.05)], 'k--');
ylabel('log(p values  + .003)');
axis padded
xlim([0.5 6.5]);
axis square
% title('vACC: barSize');
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
set(gcf, 'position', [77 77 333 333]);




%%%%%%%% PoP



for threshID = 2
    switch  threshID
        case 1
            thresh = 0.05;
        case 2
            thresh = 0.01;
    end

figure; hold on
for mdl = 1:4
    switch mdl
        case 1
            stl = 'o';
            offset = -.15;
        case 2
            stl = '^';
            offset = -.05;
        case 3
            stl = 'd';
            offset = .05;
        case 4
            stl = 's';
            offset = .15;
    end
    allBetas = lmeBetas(:,mdl);
    allPs = lmePs(:,mdl);
    for ii = 1:6
        switch ii
            case 1
                clr = [0 0.4470 0.7410];
            case 2
                clr = [0.8500 0.3250 0.0980];
            case 3
                clr = [0.9290 0.6940 0.1250];
            case 4
                clr = [0.4940 0.1840 0.5560];
            case 5
                clr = [0.4660 0.6740 0.1880];
            case 6
                clr = [0.3010 0.7450 0.9330];
        end
        xx = (allBetas(brainAreaIndex == ii));
        xx = xx(~isnan(xx));
        yy = (allPs(brainAreaIndex == ii));
        yy = yy(~isnan(yy));
        
        nPos = sum(yy < thresh & xx > 0);
        nNeg = sum(yy < thresh & xx < 0);
        [~,p] = chi2test( nPos, nNeg, length(xx), length(xx) );
        if ii == 6
            disp(p);
        end
        plot(ii+offset, log(p), stl, 'Color', clr, 'MarkerSize', 10);
        
    end
end
plot([0.5 6.5], [log(0.05) log(0.05)], 'k--');
ylabel('log(p values  + .003)');
axis padded
xlim([0.5 6.5]);
axis square
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
% title(['vACC: PoP - thresh=' num2str(thresh)]);
set(gcf, 'position', [77*threshID*3 77 333 333]);
end








%% 1b - REWARD-BAR ONSET
% after regressing out trial-number
% fig S2

% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_rewardBar_regressOutTrialth.mat');


%%%%%%%% average coefficients

figure; hold on
for mdl = 1:4
    switch mdl
        case 1
            stl = 'o';
        case 2
            stl = '^';
        case 3
            stl = 'd';
        case 4
            stl = 's';
    end
    allBetas = lmeBetas(:,mdl);
    for ii = 1:6
        switch ii
            case 1
                clr = [0 0.4470 0.7410];
            case 2
                clr = [0.8500 0.3250 0.0980];
            case 3
                clr = [0.9290 0.6940 0.1250];
            case 4
                clr = [0.4940 0.1840 0.5560];
            case 5
                clr = [0.4660 0.6740 0.1880];
            case 6
                clr = [0.3010 0.7450 0.9330];
        end
        xx = (allBetas(brainAreaIndex == ii));
        [~, yy] = ttest(xx, 0);
        if ii == 6
            disp(yy);
        end
        plot(ii, log(yy), stl, 'Color', clr, 'MarkerSize', 10);
    end
end
plot([0.5 6.5], [log(0.05) log(0.05)], 'k--');
ylabel('log(p values  + .003)');
axis padded
xlim([0.5 6.5]);
axis square
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
% title('vACC: barSize');
set(gcf, 'position', [77 77 333 333]);




%%%%%%%% PoP



for threshID = 2
    switch  threshID
        case 1
            thresh = 0.05;
        case 2
            thresh = 0.01;
    end

figure; hold on
for mdl = 1:4
    switch mdl
        case 1
            stl = 'o';
            offset = -.15;
        case 2
            stl = '^';
            offset = -.05;
        case 3
            stl = 'd';
            offset = .05;
        case 4
            stl = 's';
            offset = .15;
    end
    allBetas = lmeBetas(:,mdl);
    allPs = lmePs(:,mdl);
    for ii = 1:6
        switch ii
            case 1
                clr = [0 0.4470 0.7410];
            case 2
                clr = [0.8500 0.3250 0.0980];
            case 3
                clr = [0.9290 0.6940 0.1250];
            case 4
                clr = [0.4940 0.1840 0.5560];
            case 5
                clr = [0.4660 0.6740 0.1880];
            case 6
                clr = [0.3010 0.7450 0.9330];
        end
        xx = (allBetas(brainAreaIndex == ii));
        xx = xx(~isnan(xx));
        yy = (allPs(brainAreaIndex == ii));
        yy = yy(~isnan(yy));
        
        nPos = sum(yy < thresh & xx > 0);
        nNeg = sum(yy < thresh & xx < 0);
        [~,p] = chi2test( nPos, nNeg, length(xx), length(xx) );
        if ii == 6
            disp(p);
        end
        plot(ii+offset, log(p), stl, 'Color', clr, 'MarkerSize', 10);
        
    end
end
plot([0.5 6.5], [log(0.05) log(0.05)], 'k--');
ylabel('log(p values  + .003)');
axis padded
xlim([0.5 6.5]);
axis square
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
% title(['vACC: PoP - thresh=' num2str(thresh)]);
set(gcf, 'position', [77*threshID*3 77 333 333]);
end




%% 1b - REWARD-BAR ONSET
% after regressing out trial-number

% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_rewardBar_regressOutTrialth.mat');


% pValues = [0.05:-0.01:0.01 0.009:-0.001:0.001];
pValues = [0.001:0.001:0.009 0.01:0.01:0.05];

figure; hold on
for mdl = 1:2:4
    switch mdl
        case 1
            stl = 'o';
            offset = -.15;
        case 2
            stl = '^';
            offset = -.05;
        case 3
            stl = 'd';
            offset = .05;
        case 4
            stl = 's';
            offset = .15;
    end
    allBetas = lmeBetas(:,mdl);
    allPs = lmePs(:,mdl);
    for ii = 1:6
        switch ii
            case 1
                clr = [0 0.4470 0.7410];
            case 2
                clr = [0.8500 0.3250 0.0980];
            case 3
                clr = [0.9290 0.6940 0.1250];
            case 4
                clr = [0.4940 0.1840 0.5560];
            case 5
                clr = [0.4660 0.6740 0.1880];
            case 6
                clr = [0.3010 0.7450 0.9330];
        end
        
        realPs = nan(size(pValues));
        for jj = 1:numel(pValues)
            thresh = pValues(jj);

            xx = (allBetas(brainAreaIndex == ii));
            xx = xx(~isnan(xx));
            yy = (allPs(brainAreaIndex == ii));
            yy = yy(~isnan(yy));

            nPos = sum(yy < thresh & xx > 0);
            nNeg = sum(yy < thresh & xx < 0);
            [~,realPs(jj)] = chi2test( nPos, nNeg, length(xx), length(xx) );
        end
        
        plot(pValues, log(realPs), 'Color', clr, 'marker', stl);
    end
end
plot(xlim, [log(0.05) log(0.05)], 'k:');
xlabel('threshold (p-value)'); ylabel('log(p-value) of \chi^2 test');
set(gca, 'XDir', 'reverse');
axis padded
set(gcf, 'position', [77 77 666 333]);






%% 2 - CUE ONSET
% fig S4

% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_cue.mat');


reg = 5;    % val x bar-size

%%%%%%%% average coefficients

figure; hold on
for mdl = 1:4
    switch mdl
        case 1
            stl = 'o';
        case 2
            stl = '^';
        case 3
            stl = 'd';
        case 4
            stl = 's';
    end
    allBetas = lmeBetas{mdl};
    for ii = 1:6
        switch ii
            case 1
                clr = [0 0.4470 0.7410];
            case 2
                clr = [0.8500 0.3250 0.0980];
            case 3
                clr = [0.9290 0.6940 0.1250];
            case 4
                clr = [0.4940 0.1840 0.5560];
            case 5
                clr = [0.4660 0.6740 0.1880];
            case 6
                clr = [0.3010 0.7450 0.9330];
        end
        xx = allBetas(brainAreaIndex == ii, reg);
        [~, yy] = ttest(xx, 0);
        plot(ii, log(yy), stl, 'Color', clr, 'MarkerSize', 10);
    end
end
plot([0.5 6.5], [log(0.05) log(0.05)], 'k--');
ylabel('log(p values)');
axis padded
xlim([0.5 6.5]);
axis square
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
% title('dACC: rp x val');
set(gcf, 'position', [77 77 333 333]);



%%%%%%%% PoP
for threshID = 2
    switch threshID
        case 1
            thresh = .05;
        case 2
            thresh = .01;
    end

    figure; hold on
    for mdl = 1:4
        switch mdl
            case 1
                stl = 'o';
                offset = -.15;
            case 2
                stl = '^';
                offset = -.05;
            case 3
                stl = 'd';
                offset = .05;
            case 4
                stl = 's';
                offset = .15;
        end
        allBetas = lmeBetas{mdl};
        allPs = lmePs{mdl};
        for param = 1:6
            switch param
                case 1
                    clr = [0 0.4470 0.7410];
                case 2
                    clr = [0.8500 0.3250 0.0980];
                case 3
                    clr = [0.9290 0.6940 0.1250];
                case 4
                    clr = [0.4940 0.1840 0.5560];
                case 5
                    clr = [0.4660 0.6740 0.1880];
                case 6
                    clr = [0.3010 0.7450 0.9330];
            end
            xx = allBetas(brainAreaIndex == param, reg);
            xx = xx(~isnan(xx));
            yy = allPs(brainAreaIndex == param, reg);
            yy = yy(~isnan(yy));
            nPos = sum(yy < thresh & xx > 0);
            nNeg = sum(yy < thresh & xx < 0);
            [~,p] = chi2test( nPos, nNeg, length(xx), length(xx) );
            if param == 1
                disp(p);
            end
            plot(param+offset, log(p), stl, 'Color', clr, 'MarkerSize', 10);
        end
    end
    plot([0.5 6.5], [log(0.05) log(0.05)], 'k--');
    ylabel('log(p values)');
    axis padded
    xlim([0.5 6.5]);
    axis square
    set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
%     title(['dACC: PoP - thresh=' num2str(thresh)]);
    set(gcf, 'position', [77*threshID*3 77 333 333]);
end





%% 2b - CUE ONSET
% all regressors
% fig S5

% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_cue.mat');


%%%%%%%% average coefficients
count = 1;
figure; hold on
for reg = 1:7
    switch reg
        case 1
            ttl1 = 'Valence';
        case 2
            ttl1 = 'Direction';
        case 3
            ttl1 = 'Bar Size';
        case 4
            ttl1 = 'val x dir';
        case 5
            ttl1 = 'val x bar-size';
        case 6
            ttl1 = 'dir x bar-size';
        case 7
            ttl1 = 'val x dir x bar-size';
    end
    subplot(2,4,count); hold on
    for mdl = 1:4
        switch mdl
            case 1
                stl = 'o';
            case 2
                stl = '^';
            case 3
                stl = 'd';
            case 4
                stl = 's';
        end
        allBetas = lmeBetas{mdl};
        for ii = 1:6
            switch ii
                case 1
                    clr = [0 0.4470 0.7410];
                case 2
                    clr = [0.8500 0.3250 0.0980];
                case 3
                    clr = [0.9290 0.6940 0.1250];
                case 4
                    clr = [0.4940 0.1840 0.5560];
                case 5
                    clr = [0.4660 0.6740 0.1880];
                case 6
                    clr = [0.3010 0.7450 0.9330];
            end
            xx = allBetas(brainAreaIndex == ii, reg);
            [~, yy] = ttest(xx, 0);
            plot(ii, log(yy+0.0028), stl, 'Color', clr, 'MarkerSize', 10);
        end
    end
    plot([0.5 6.5], [log(0.05+0.0028) log(0.05+0.0028)], 'k--');
    ylabel('log(p values)');
%     axis padded
    xlim([0.5 6.5]); ylim([-6.5 0.5]);
    axis square;
    set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
    title(ttl1);
    
    count = count+1;
end
set(gcf, 'position', [77 77 1333 678]);



%%%%%%%% PoP
thresh = .01;
count = 1;
figure; hold on
for reg = 1:7
    switch reg
        case 1
            ttl1 = 'Valence';
        case 2
            ttl1 = 'Direction';
        case 3
            ttl1 = 'Bar Size';
        case 4
            ttl1 = 'val x dir';
        case 5
            ttl1 = 'val x bar-size';
        case 6
            ttl1 = 'dir x bar-size';
        case 7
            ttl1 = 'val x dir x bar-size';
    end
    subplot(2,4,count); hold on
    for mdl = 1:4
        switch mdl
            case 1
                stl = 'o';
                offset = -.15;
            case 2
                stl = '^';
                offset = -.05;
            case 3
                stl = 'd';
                offset = .05;
            case 4
                stl = 's';
                offset = .15;
        end
        allBetas = lmeBetas{mdl};
        allPs = lmePs{mdl};
        for param = 1:6
            switch param
                case 1
                    clr = [0 0.4470 0.7410];
                case 2
                    clr = [0.8500 0.3250 0.0980];
                case 3
                    clr = [0.9290 0.6940 0.1250];
                case 4
                    clr = [0.4940 0.1840 0.5560];
                case 5
                    clr = [0.4660 0.6740 0.1880];
                case 6
                    clr = [0.3010 0.7450 0.9330];
            end
            xx = allBetas(brainAreaIndex == param, reg);
            xx = xx(~isnan(xx));
            yy = allPs(brainAreaIndex == param, reg);
            yy = yy(~isnan(yy));
            nPos = sum(yy < thresh & xx > 0);
            nNeg = sum(yy < thresh & xx < 0);
            [~,p] = chi2test( nPos, nNeg, length(xx), length(xx) );
            plot(param+offset, log(p+.0028), stl, 'Color', clr, 'MarkerSize', 10);
        end
    end
    plot([0.5 6.5], [log(0.05+.0028) log(0.05+.0028)], 'k--');
    ylabel('log(p values)');
%     axis padded
    xlim([0.5 6.5]); ylim([-6.5 0.5]);
    axis square;
    set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
    title(ttl1);
    
    count = count+1;
end
set(gcf, 'position', [333 77 1333 678]);




%% 3 - FEEDBACK
% fig S6

% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_feedback.mat');

reg = 10;        % absRew x bar-size

%%%%%%%% average coefficients
figure; hold on
for mdl = 1:4
    switch mdl
        case 1
            stl = 'o';
        case 2
            stl = '^';
        case 3
            stl = 'd';
        case 4
            stl = 's';
    end
    allBetas = multiLmeBetas{mdl};
    for ii = 1:6
        switch ii
            case 1
                clr = [0 0.4470 0.7410];
            case 2
                clr = [0.8500 0.3250 0.0980];
            case 3
                clr = [0.9290 0.6940 0.1250];
            case 4
                clr = [0.4940 0.1840 0.5560];
            case 5
                clr = [0.4660 0.6740 0.1880];
            case 6
                clr = [0.3010 0.7450 0.9330];
        end
        xx = allBetas(brainAreaIndex == ii, reg);
        [~, yy] = ttest(xx, 0);
        if reg == 10 && ii == 2
            disp(yy);
        end
        plot(ii, log(yy), stl, 'Color', clr, 'markersize', 10);
    end
end
plot([0.5 6.5], [log(0.05) log(0.05)], 'k--');
ylabel('log(p values)');
axis padded
xlim([0.5 6.5]);
axis square
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
% title('dlPFC: rp x rew');
set(gcf, 'position', [77 77 333 333]);


%%%%%%%% PoP
for threshID = 2
    switch threshID
        case 1
            thresh = .05;
        case 2
            thresh = .01;
    end

    figure; hold on
    for mdl = 1:4
        switch mdl
            case 1
                stl = 'o';
                offset = -.15;
            case 2
                stl = '^';
                offset = -.05;
            case 3
                stl = 'd';
                offset = .05;
            case 4
                stl = 's';
                offset = .15;
        end
        allBetas = multiLmeBetas{mdl};
        allPs = multiLmePs{mdl};
        for param = 1:6
            switch param
                case 1
                    clr = [0 0.4470 0.7410];
                case 2
                    clr = [0.8500 0.3250 0.0980];
                case 3
                    clr = [0.9290 0.6940 0.1250];
                case 4
                    clr = [0.4940 0.1840 0.5560];
                case 5
                    clr = [0.4660 0.6740 0.1880];
                case 6
                    clr = [0.3010 0.7450 0.9330];
            end
            xx = allBetas(brainAreaIndex == param, reg);
            xx = xx(~isnan(xx));
            yy = allPs(brainAreaIndex == param, reg);
            yy = yy(~isnan(yy));
            nPos = sum(yy < thresh & xx > 0);
            nNeg = sum(yy < thresh & xx < 0);
            [~,p] = chi2test( nPos, nNeg, length(xx), length(xx) );
            if reg == 10 && param == 2
                disp(p);
            end
            if isnan(p) || p == 1
                p = 1-0.0028;
            elseif p == 0
                p = -0.0027;
            end
            plot(param+offset, log(p), stl, 'Color', clr, 'MarkerSize', 10);
        end
    end
    plot([0.5 6.5], [log(0.05) log(0.05)], 'k--');
    ylabel('log(p values)');
    axis padded
    xlim([0.5 6.5]);
    axis square
    set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
%     title(['dlPFC: PoP - thresh=' num2str(thresh)]);
    set(gcf, 'position', [77*threshID*3 77 333 333]);
end





%% 3b - FEEDBACK
% all regressors
% fig S7


% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_feedback.mat');

%%%%%%%% average coefficients
figure; hold on
for reg = 1:15
    switch reg
        case 1 % 1 - 100
            ttl1 = 'Val';
        case 2 % 2 - 200
            ttl1 = 'Dir';
        case 3 % 3 - 1
            ttl1 = 'barSize';
        case 4 % 4 - 2
            ttl1 = 'absReward';
        case 5
            ttl1 = 'val x dir';
        case 6
            ttl1 = 'val x barSize';
        case 7
            ttl1 = 'dir x barSize';
        case 8
            ttl1 = 'val x absReward';
        case 9
            ttl1 = 'dir x absReward';
        case 10 % 10 - 3
            ttl1 = 'barSize x absReward';
        case 11
            ttl1 = 'val x dir x barSz';
        case 12
            ttl1 = 'val x dir x absRew';
        case 13
            ttl1 = 'val x barSz x absRew';
        case 14
            ttl1 = 'dir x barSz x absRew';
        case 15
            ttl1 = 'all';
    end
    subplot(4,4,reg); hold on
    for mdl = 1:4
        switch mdl
            case 1
                stl = 'o';
            case 2
                stl = '^';
            case 3
                stl = 'd';
            case 4
                stl = 's';
        end
        allBetas = multiLmeBetas{mdl};
        for ii = 1:6
            switch ii
                case 1
                    clr = [0 0.4470 0.7410];
                case 2
                    clr = [0.8500 0.3250 0.0980];
                case 3
                    clr = [0.9290 0.6940 0.1250];
                case 4
                    clr = [0.4940 0.1840 0.5560];
                case 5
                    clr = [0.4660 0.6740 0.1880];
                case 6
                    clr = [0.3010 0.7450 0.9330];
            end
            xx = allBetas(brainAreaIndex == ii, reg);
            [~, yy] = ttest(xx, 0);
            plot(ii, log(yy+.0028), stl, 'Color', clr, 'markersize', 10);
        end
    end
    plot([0.5 6.5], [log(0.05+.0028) log(0.05+.0028)], 'k--');
    ylabel('log(p values)');
%     axis padded
    xlim([0.5 6.5]); ylim([-6.5 0.5]);
    axis square;
    set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
    title(ttl1);

end
set(gcf, 'position', [77 22 1666 999]);


thresh = 0.01;
%%%%%%%% PoP
figure; hold on
for reg = 1:15
    switch reg
        case 1 % 1 - 100
            ttl1 = 'Val';
        case 2 % 2 - 200
            ttl1 = 'Dir';
        case 3 % 3 - 1
            ttl1 = 'barSize';
        case 4 % 4 - 2
            ttl1 = 'absReward';
        case 5
            ttl1 = 'val x dir';
        case 6
            ttl1 = 'val x barSize';
        case 7
            ttl1 = 'dir x barSize';
        case 8
            ttl1 = 'val x absReward';
        case 9
            ttl1 = 'dir x absReward';
        case 10 % 10 - 3
            ttl1 = 'barSize x absReward';
        case 11
            ttl1 = 'val x dir x barSz';
        case 12
            ttl1 = 'val x dir x absRew';
        case 13
            ttl1 = 'val x barSz x absRew';
        case 14
            ttl1 = 'dir x barSz x absRew';
        case 15
            ttl1 = 'all';
    end
    subplot(4,4,reg); hold on
    for mdl = 1:4
        switch mdl
            case 1
                stl = 'o';
                offset = -.15;
            case 2
                stl = '^';
                offset = -.05;
            case 3
                stl = 'd';
                offset = .05;
            case 4
                stl = 's';
                offset = .15;
        end
        allBetas = multiLmeBetas{mdl};
        allPs = multiLmePs{mdl};
        for param = 1:6
            switch param
                case 1
                    clr = [0 0.4470 0.7410];
                case 2
                    clr = [0.8500 0.3250 0.0980];
                case 3
                    clr = [0.9290 0.6940 0.1250];
                case 4
                    clr = [0.4940 0.1840 0.5560];
                case 5
                    clr = [0.4660 0.6740 0.1880];
                case 6
                    clr = [0.3010 0.7450 0.9330];
            end
            xx = allBetas(brainAreaIndex == param, reg);
            xx = xx(~isnan(xx));
            yy = allPs(brainAreaIndex == param, reg);
            yy = yy(~isnan(yy));
            nPos = sum(yy < thresh & xx > 0);
            nNeg = sum(yy < thresh & xx < 0);
            [~,p] = chi2test( nPos, nNeg, length(xx), length(xx) );
            if isnan(p) || p == 1
                p = 1-0.0028;
            elseif p == 0
                p = -0.0027;
            end
            plot(param+offset, log(p+.0028), stl, 'Color', clr, 'MarkerSize', 10);
        end
    end
    plot([0.5 6.5], [log(0.05+.0028) log(0.05+.0028)], 'k--');
    ylabel('log(p values)');
%     axis padded
    xlim([0.5 6.5]); ylim([-6.5 0.5]);
    axis square;
    set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
    title(ttl1);
end
set(gcf, 'position', [333 22 1666 999]);






%%
