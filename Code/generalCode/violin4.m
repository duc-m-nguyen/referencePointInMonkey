%__________________________________________________________________________
% violin4.m - Simple violin plot using matlab default kernel density estimation
%
% updated 2024/12/05 DN - keep original mean and media but cutoff distribution
%__________________________________________________________________________

% INPUT
%
% Y:     Data to be plotted, being either
%        a) n x m matrix. A 'violin' is plotted for each column m, OR
%        b) 1 x m Cellarry with elements being numerical colums of nx1 length.
%
% varargin:
% xlabel:    xlabel. Set either [] or in the form {'txt1','txt2','txt3',...}
% facecolor: FaceColor. (default [1 0.5 0]); Specify abbrev. or m x 3 matrix (e.g. [1 0 0])
% edgecolor: LineColor. (default 'k'); Specify abbrev. (e.g. 'k' for black); set either [],'' or 'none' if the mean should not be plotted
% facealpha: Alpha value (transparency). default: 0.5
% mc:        Color of the bars indicating the mean. (default 'k'); set either [],'' or 'none' if the mean should not be plotted
% medc:      Color of the bars indicating the median. (default 'r'); set either [],'' or 'none' if the mean should not be plotted
% bw:        Kernel bandwidth. (default []); prescribe if wanted as follows:
%            a) if bw is a single number, bw will be applied to all
%            columns or cells
%            b) if bw is an array of 1xm or mx1, bw(i) will be applied to cell or column (i).
%            c) if bw is empty (default []), the optimal bandwidth for
%            gaussian kernel is used (see Matlab documentation for
%            ksdensity()
%
% OUTPUT
%
% h:     figure handle
% L:     Legend handle
% MX:    Means of groups
% MED:   Medians of groups
% bw:    bandwidth of kernel
%

function[h,L,MX,MED,bw] = violin(Y,varargin)
    

    %%%% defaults:
    xL=[];
    fc=[1 0.5 0];
    lc='k';
    alp=0.5;
    mc='k';
    medc='w';
    b=[]; %bandwidth
    plotlegend=1;
    plotmean=1;
    plotmedian=1;
    x = [];
    
    
    %%%% convert single columns to cells:
    if iscell(Y)==0
        Y = num2cell(Y,1);
    end
    
    %get additional input parameters (varargin)
    if isempty(find(strcmp(varargin,'xlabel')))==0
        xL = varargin{find(strcmp(varargin,'xlabel'))+1};
    end
    if isempty(find(strcmp(varargin,'facecolor')))==0
        fc = varargin{find(strcmp(varargin,'facecolor'))+1};
    end
    if isempty(find(strcmp(varargin,'edgecolor')))==0
        lc = varargin{find(strcmp(varargin,'edgecolor'))+1};
    end
    if isempty(find(strcmp(varargin,'facealpha')))==0
        alp = varargin{find(strcmp(varargin,'facealpha'))+1};
    end
    if isempty(find(strcmp(varargin,'mc')))==0
        if isempty(varargin{find(strcmp(varargin,'mc'))+1})==0
            mc = varargin{find(strcmp(varargin,'mc'))+1};
            plotmean = 1;
        else
            plotmean = 0;
        end
    end
    if isempty(find(strcmp(varargin,'medc')))==0
        if isempty(varargin{find(strcmp(varargin,'medc'))+1})==0
            medc = varargin{find(strcmp(varargin,'medc'))+1};
            plotmedian = 1;
        else
            plotmedian = 0;
        end
    end
    if isempty(find(strcmp(varargin,'bw')))==0
        b = varargin{find(strcmp(varargin,'bw'))+1}
        if length(b)==1
            disp(['same bandwidth bw = ',num2str(b),' used for all cols'])
            b=repmat(b,size(Y,2),1);
        elseif length(b)~=size(Y,2)
            warning('length(b)~=size(Y,2)')
            error('please provide only one bandwidth or an array of b with same length as columns in the data set')
        end
    end
    if isempty(find(strcmp(varargin,'plotlegend')))==0
        plotlegend = varargin{find(strcmp(varargin,'plotlegend'))+1};
    end
    if isempty(find(strcmp(varargin,'x')))==0
        x = varargin{find(strcmp(varargin,'x'))+1};
    end
    
    % create face color matrix
    if size(fc,1)==1
        fc=repmat(fc,size(Y,2),1);
    end
    
    %%%%%%%% Calculate the kernel density -------------------------------------
    i=1;
    for i=1:size(Y,2)
        
        MED(:,i)=nanmedian(Y{i});
        MX(:,i)=nanmean(Y{i});
        MSE(:,i)=nanstd(Y{i})/sqrt(numel(Y{i}));
        
        mm = nanmean(Y{i});
        se = nanstd(Y{i});
        Y{i} = Y{i}( Y{i} > (mm - 3*se) & Y{i} < (mm + 3*se) );

        if ~isempty(b)
            [f, u, bb] = ksdensity(Y{i}, 'bandwidth', b(i));
            f = f(u >= min(Y{i}) & u <= max(Y{i}));
            u = u(u >= min(Y{i}) & u <= max(Y{i}));
            u(1) = min(Y{i});
            u(end) = max(Y{i});
            u = [u(1)*(1-1E-5), u, u(end)*(1+1E-5)];
            f = [0, f, 0];

            % all data is identical
            if min(Y{i}) == max(Y{i})
                f = 1;
                u= mean(u);
            end

            bb = bb/max(f);
        elseif isempty(b)
            [f, u, bb] = ksdensity(Y{i});
            
            
            f = f(u >= min(Y{i}) & u <= max(Y{i}));
            u = u(u >= min(Y{i}) & u <= max(Y{i}));
            u(1) = mm - 3*se;
            u(end) = mm + 3*se;
            u = [u(1)*(1-1E-5), u, u(end)*(1+1E-5)];
            f = [0, f, 0];
            
            % all data is identical
            if min(Y{i}) == max(Y{i})
                f = 1;
                u= mean(u);
            end
            
            bb = bb/max(f);
        end

        f=f/max(f)*0.3; %normalize
        F(:,i)=f;
        U(:,i)=u;
        
        bw(:,i)=bb;

    end
    %%%%%%%% -------------------------------------
    
    
    
%% PLOT
%-------------------------------------------------------------------------
% Put the figure automatically on a second monitor
% mp = get(0, 'MonitorPositions');
% set(gcf,'Color','w','Position',[mp(end,1)+50 mp(end,2)+50 800 600])
%-------------------------------------------------------------------------
%Check x-value options
if isempty(x)
    x = zeros(size(Y,2));
    setX = 0;
else
    setX = 1;
    if isempty(xL)==0
        disp('_________________________________________________________________')
        warning('Function is not designed for x-axis specification with string label')
        warning('when providing x, xlabel can be set later anyway')
        error('please provide either x or xlabel. not both.')
    end
end
% Plot the violins
i=1;
for i=i:size(Y,2)
    if isempty(lc) == 1
        if setX == 0
            h(i)=fill([F(:,i)+i;flipud(i-F(:,i))],[U(:,i);flipud(U(:,i))],fc(i,:),'FaceAlpha',alp,'EdgeColor','none');
        else
            h(i)=fill([F(:,i)+x(i);flipud(x(i)-F(:,i))],[U(:,i);flipud(U(:,i))],fc(i,:),'FaceAlpha',alp,'EdgeColor','none');
        end
    else
        if setX == 0
            h(i)=fill([F(:,i)+i;flipud(i-F(:,i))],[U(:,i);flipud(U(:,i))],fc(i,:),'FaceAlpha',alp,'EdgeColor',lc);
        else
            h(i)=fill([F(:,i)+x(i);flipud(x(i)-F(:,i))],[U(:,i);flipud(U(:,i))],fc(i,:),'FaceAlpha',alp,'EdgeColor',lc);
        end
    end
    hold on
    if setX == 0
        if plotmean == 1
            p(1)=plot([interp1(U(:,i),F(:,i)+i,MX(:,i)), interp1(flipud(U(:,i)),flipud(i-F(:,i)),MX(:,i)) ],[MX(:,i) MX(:,i)],fc(i,:),'LineWidth',2);
        end
        if plotmedian == 1
            p(2)=scatter(x(i), MED(:,i), 24, 'o', 'MarkerFaceColor', [.5 .5 .5], 'MarkerEdgeColor', [.5 .5 .5]);
        end
    elseif setX == 1
        if plotmean == 1
            p(1)=plot([interp1(U(:,i),F(:,i)+i,MX(:,i))+x(i)-i, interp1(flipud(U(:,i)),flipud(i-F(:,i)),MX(:,i))+x(i)-i], ...
                [MX(:,i) MX(:,i)], 'Color', fc(i,:), 'LineWidth',2);
            
        end
        if plotmedian == 1
            p(2)=scatter(x(i), MED(:,i), 24, 'o', 'MarkerFaceColor', [.5 .5 .5], 'MarkerEdgeColor', [.1 .1 .1]);
        end
    end
end

end