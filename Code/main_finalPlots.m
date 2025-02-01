
%% 1 - REWARD-BAR ONSET
% fig 3

mdl = 1;

% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_rewardBar.mat');

%%%%%%%% average coefficients
figure; hold on
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
    [~,p] = ttest(xx, 0); disp(p);
    
    % error-bar
    errorbar(ii, nanmean(xx), nanstd(xx)/sqrt(length(xx)), 'Color', clr, 'linewidth', 1.5, 'marker', 'o');
    
    % violin
%     xx = xx(xx < nanmean(xx) + 3*nanstd(xx) & xx > nanmean(xx) - 3*nanstd(xx));    
%     violin3((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2, 'mc', []);
%     violin3((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2);
%     violin4((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2);
end
plot([0.5 6.5], [0 0], 'k:');
xlim([0.5 6.5]); 
ylim([-.15 .12]);   % for error-bar
% ylim([-.04 .02]);   % for error-bar
% ylim([-.25 .2]);   % for error-bar
% ylim([-.05 .03]);   % for error-bar
% ylim([-.04 .02]);   % for error-bar
% ylim([-2 2]);       % for violin
axis square
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
set(gcf, 'position', [77 77 333 333]);



%%%%%%%% PoP

thresh = 0.01;
figure; hold on
allBetas = lmeBetas(:,mdl);
allPs = lmePs(:,1);
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

    plot(ii, mean( yy < thresh & xx > 0 ), ...
        'Marker', 'o', 'Color', clr, 'MarkerSize', 8);
    plot(ii, -mean( yy < thresh & xx < 0 ), ...
        'Marker', 'o', 'Color', clr, 'MarkerSize', 8);
    plot(ii, mean( yy < thresh & xx > 0 ) - mean( yy < thresh & xx < 0 ), ...
        'Marker', 'o', 'MarkerFaceColor', clr, 'Color', clr, 'MarkerSize', 12);
    plot([ii ii], [-mean( yy < thresh & xx < 0 ) mean( yy < thresh & xx > 0 )], ...
            '-.', 'Color', clr, 'linewidth', .1);

    nPos = sum(yy < thresh & xx > 0);
    nNeg = sum(yy < thresh & xx < 0);
    [~,p] = chi2test( nPos, nNeg, length(xx), length(xx) ); disp(p);
end
plot([0.5 6.5], [0 0], 'k:');
xlim([0.5 6.5]); ylim([-.25 .25]);
axis square
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
set(gcf, 'position', [555 77 333 333]);








%% 1b - REWARD-BAR ONSET
% after regressing out trialth
% fig S2

% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_rewardBar_regressOutTrialth.mat');

%%%%%%%% average coefficients
figure; hold on
allBetas = lmeBetas(:,1);
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
    [~,p] = ttest(xx, 0); disp(p);
    
    % error-bar
    errorbar(ii, nanmean(xx), nanstd(xx)/sqrt(length(xx)), 'Color', clr, 'linewidth', 1.5, 'marker', 'o');
    
%     % violin
%     xx = xx(xx < nanmean(xx) + 3*nanstd(xx) & xx > nanmean(xx) - 3*nanstd(xx));    
%     violin3((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2, 'mc', []);
%     violin3((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2);
end
plot([0.5 6.5], [0 0], 'k:');
xlim([0.5 6.5]); 
ylim([-.08 .08]);   % for error-bar
% ylim([-2 2]);       % for violin
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
set(gcf, 'position', [77 77 333 333]);



%%%%%%%% PoP

thresh = 0.01;
figure; hold on
allBetas = lmeBetas(:,1);
allPs = lmePs(:,1);
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

    plot(ii, mean( yy < thresh & xx > 0 ), ...
        'Marker', 'o', 'Color', clr, 'MarkerSize', 8);
    plot(ii, -mean( yy < thresh & xx < 0 ), ...
        'Marker', 'o', 'Color', clr, 'MarkerSize', 8);
    plot(ii, mean( yy < thresh & xx > 0 ) - mean( yy < thresh & xx < 0 ), ...
        'Marker', 'o', 'MarkerFaceColor', clr, 'Color', clr, 'MarkerSize', 12);
    plot([ii ii], [-mean( yy < thresh & xx < 0 ) mean( yy < thresh & xx > 0 )], ...
            '-.', 'Color', clr, 'linewidth', .1);

    nPos = sum(yy < thresh & xx > 0);
    nNeg = sum(yy < thresh & xx < 0);
    [~,p] = chi2test( nPos, nNeg, length(xx), length(xx) ); disp(p);
end
plot([0.5 6.5], [0 0], 'k:');
xlim([0.5 6.5]); ylim([-.15 .15]);
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
set(gcf, 'position', [555 77 333 333]);






%% 2 - CUE ONSET
% fig 4

% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_cue.mat');


reg = 5;    % val x bar-size

%%%%%%%% average coefficients

figure; hold on
allBetas = lmeBetas{1};
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
    [~, p] = ttest(xx, 0); disp(p);
    
    % error-bar
    errorbar(ii, nanmean(xx), nanstd(xx)/sqrt(length(xx)), 'Color', clr, 'linewidth', 1.5, 'marker', 'o');
    
    % violin
%     xx = xx(xx < nanmean(xx) + 3*nanstd(xx) & xx > nanmean(xx) - 3*nanstd(xx));    
%     violin3((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2, 'mc', []);
%     violin3((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2);
%     violin4((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2);
end
plot([0.5 6.5], [0 0], 'k:');
xlim([0.5 6.5]);
% ylim([-0.3 0.1]);   % for error-bar
ylim([-2 1.5]);
axis square
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
set(gcf, 'position', [77 77 333 333]);



%%%%%%%% PoP
thresh = 0.01;
figure; hold on
allBetas = lmeBetas{1};
allPs = lmePs{1};
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
    xx = xx(~isnan(xx));
    yy = allPs(brainAreaIndex == ii, reg);
    yy = yy(~isnan(yy));
    
    plot(ii, mean( yy < thresh & xx > 0 ), ...
        'Marker', 'o', 'Color', clr, 'MarkerSize', 8);
    plot(ii, -mean( yy < thresh & xx < 0 ), ...
        'Marker', 'o', 'Color', clr, 'MarkerSize', 8);
    plot(ii, mean( yy < thresh & xx > 0 ) - mean( yy < thresh & xx < 0 ), ...
        'Marker', 'o', 'MarkerFaceColor', clr, 'Color', clr, 'MarkerSize', 12);
    plot([ii ii], [-mean( yy < thresh & xx < 0 ) mean( yy < thresh & xx > 0 )], ...
            '-.', 'Color', clr, 'linewidth', .1);

    nPos = sum(yy < thresh & xx > 0);
    nNeg = sum(yy < thresh & xx < 0);
    [~,p] = chi2test( nPos, nNeg, length(xx), length(xx) ); disp(p);
end
plot([0.5 6.5], [0 0], 'k:');
xlim([0.5 6.5]); ylim([-.12 .06]);
axis square
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
set(gcf, 'position', [555 77 333 333]);





%% 3 - FEEDBACK
% fig 5

% load data
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaIndex.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\brainAreaNumbers.mat');
load('C:\Users\ducmn\Documents\_MATLAB\GlimcherLab\reference-dependent\dataFromErin\main_v8_feedback.mat');

reg = 10;        % absRew x bar-size

%%%%%%%% average coefficients
figure; hold on
allBetas = multiLmeBetas{1};
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
    [~, p] = ttest(xx, 0); disp(p);
%     
%     % error-bar
%     errorbar(ii, nanmean(xx), nanstd(xx)/sqrt(length(xx)), 'Color', clr, 'linewidth', 1.5, 'marker', 'o');
    
    % violin
%     xx = xx(xx < nanmean(xx) + 3*nanstd(xx) & xx > nanmean(xx) - 3*nanstd(xx));    
%     violin3((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2, 'mc', []);
%     violin3((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2);
    violin4((xx), 'x', ii, 'facecolor', clr, 'medc', [], 'facealpha', .2);
end
plot([0.5 6.5], [0 0], 'k:');
xlim([0.5 6.5]);
% ylim([-0.2 0.3]);   % for error-bar
ylim([-3 3.5]);
axis square;
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
set(gcf, 'position', [77 77 333 333]);




%%%%%%%% PoP
thresh = .01;
figure; hold on
allBetas = multiLmeBetas{1};
allPs = multiLmePs{1};
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
    xx = xx(~isnan(xx));
    yy = allPs(brainAreaIndex == ii, reg);
    yy = yy(~isnan(yy));
    plot(ii, mean( yy < thresh & xx > 0 ), ...
        'Marker', 'o', 'Color', clr, 'MarkerSize', 8);
    plot(ii, -mean( yy < thresh & xx < 0 ), ...
        'Marker', 'o', 'Color', clr, 'MarkerSize', 8);
    plot(ii, mean( yy < thresh & xx > 0 ) - mean( yy < thresh & xx < 0 ), ...
        'Marker', 'o', 'MarkerFaceColor', clr, 'Color', clr, 'MarkerSize', 12);
    plot([ii ii], [-mean( yy < thresh & xx < 0 ) mean( yy < thresh & xx > 0 )], ...
            '-.', 'Color', clr, 'linewidth', .1);

    nPos = sum(yy < thresh & xx > 0);
    nNeg = sum(yy < thresh & xx < 0);
    [~,p] = chi2test( nPos, nNeg, length(xx), length(xx) ); disp(p);
end
plot([0.5 6.5], [0 0], 'k:');
xlim([0.5 6.5]); ylim([-.04 .08]);
axis square;
set(gca, 'xtick', 1:6, 'xticklabel', brainAreaNumbers, 'xticklabelrotation', 45);
set(gcf, 'position', [555 77 333 333]);






%%
