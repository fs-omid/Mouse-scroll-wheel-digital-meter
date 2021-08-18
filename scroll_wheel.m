function scroll_wheel
% using mouse as a digital meter
% no input function
% designed by: Omid Feizi
% e-mail: f.somid@ymail.com

% cal: calibration ratio it should be recalibrate for each mouse
% individually.
% cal2: calibration sumation factor.
% the equation for measuring is: ---cal*(mouse rotation)+cal2---
% you can make cal=1 & cal2=0 to measure the wheel rotation by milimeter
% (10*cm+mm). then you hae to divide the rotation counter to measured
% length.

%% callibration ratio and factor:
cal  = 2.7; % ratio
cal2 = 0;   % sumation factor
% the equation for measuring is: ---cal*(mouse rotation)+cal2---

%% figure, annotation & push buttom:
fig = figure('WindowScrollWheelFcn',@figScroll,...
    'units','normalized','position',[0.4 0.4 0.3 0.1],...
    'NumberTitle','off','resize','off','name',...
    'Scroll-Wheel Digital Meter', 'MenuBar','none','ToolBar', 'none');

uicontrol('Parent',fig,'Style','pushbutton','String',...
    'Reset','Units','normalized','Position',...
    [0.45 0.05 0.1 0.25],'Visible','on','callback',@cleardatum);

ann = annotation('textbox',[0.45 0.7 0.1 0.1],'String',['Distance = ',...
    '0',' m - ','0',' cm - ','0',' mm'],'FontName','Times New Roman',...
    'FontSize',18,'HorizontalAlignment','center','edgecolor','none');
    
meter = 0; % initial measurment

%% function of push buttom:
    function cleardatum(~,~)
        meter = 0;
        ann.String = ['Distance = ',num2str(floor(meter/1000)) ,' m - ',...
            num2str(floor(mod(meter,1000)/10)),' cm - ',...
            num2str(floor(mod(mod(meter,1000),10))), ' mm'];
    end
%% function of rolling measurment:

    function figScroll(~,callbackdata)
        mes   = callbackdata.VerticalScrollCount;
        mes   = cal * mes + cal2;
        meter = meter + mes;
        meter = max(meter,0);
        ann.String = ['Distance = ',num2str(floor(meter/1000)) ,' m - ',...
            num2str(floor(mod(meter,1000)/10)),' cm - ',...
            num2str(floor(mod(mod(meter,1000),10))), ' mm'];
    end
end