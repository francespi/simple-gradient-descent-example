clc
clear
close all 
syms v

%% Tune this parameters

% Learning rate
eta = 0.8;

% Weight initial value
v1 = 9;

% Max steps
steps = 10000;

%% Do not edit past this point

% Cost function
C = v^2;

% Gradient
dC_dv = diff(C);

x = -10:0.1:10;
y = x.^2 ;

figure(1);
set(gcf, 'color', 'w');
plot(x, y, 'LineWidth', 2);
ylabel('Cost')
xlabel('Weight')
hold on;
Cv = double(subs(C, v1));
hDot = plot(0, 0, 'o', 'MarkerSize', 10, 'MarkerFaceColor', [1 .6 .6]);
xlim([min(x), max(x)]);
ylim([min(y), max(y)]);

for i=1:steps

    title(['Step: ' num2str(i - 1) ' - Cost: ' num2str(round(Cv, 2)) ' - Learning Rate: ' num2str(eta)]);

    if(Cv < 0.005)
            break;
    end

    v1_prev = v1;

    % Weight update
    v1 = v1 - eta * double(subs(dC_dv, v1));

    % Cost update
    Cv = double(subs(C, v1));

    if (v1 >= 0 && v1_prev < 0) || (v1 <= 0 && v1_prev <= 0)
        mask = x >= v1_prev & x <= v1;
    elseif (v1 < 0 && v1_prev >= 0) || (v1 >= 0 && v1_prev >= 0)
        mask = x <= v1_prev & x >= v1;
    end

    filtered_x = x(mask);
    filtered_y = y(mask);

    if (v1 <= 0 && v1_prev >= 0) || (v1 >= 0 && v1_prev >= 0)
        filtered_x = flip(filtered_x);
        filtered_y = flip(filtered_y);
    end

    for k = 1:length(filtered_x)
        set(hDot, 'XData', filtered_x(k) - filtered_x(k) * 0.035, 'YData', filtered_y(k) + 2.5);
        pause(0.005);
    end

end