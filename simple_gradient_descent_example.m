clc
clear
close all 
syms w

%% Tune this parameters

% Training input
x = 1;

% Expected output
y_x = 0;

% Weight initial value
w1 = 9;

% Learning rate
eta = 0.5;

% Max steps
steps = 10000;

%% Do not edit past this point

% Activation function
a_x = x*w;

% Cost function
C = (y_x - a_x)^2;

% Gradient
dC_dw = diff(C);

% Initial cost
C_w = double(subs(C, w1));

% Target cost
C_t = 0.005;

plot_cost(y_x, C);

%% Gradient descent iterations

for x = 1 : steps

    init_step(x, w1, C_w, eta)

    % Stop if target cost is reached
    if(C_w <= C_t)
        break;
    end

    % Partial derivative of C wrt w1
    dC_dw1 = double(subs(dC_dw, w1));

    % Weight update
    w1 = w1 - eta * dC_dw1;

    % Cost update
    C_w = double(subs(C, w1));

    animate_step(w1_prev, w1, w_ax, C_ax, y_x, hDot)
  
end

%% Functions

function plot_cost(y_x,C)

    w_ax = (-10:0.1:10) + y_x;
    C_ax = double(subs(C, w_ax));
    
    figure(1);
    set(gcf, 'color', 'w');

    plot(w_ax, C_ax, 'LineWidth', 2);
    hold on;
    hDot = plot(0, 0, 'o', 'MarkerSize', 10, 'MarkerFaceColor', [1 .6 .6]);
    set(gca,'fontname','consolas')
    
    ylabel('Cost')
    xlabel('Weight')
    xlim([min(w_ax), max(w_ax)]);
    ylim([min(C_ax), max(C_ax)]);

    assignin('base', 'hDot',hDot);
    assignin('base', 'w_ax',w_ax);
    assignin('base', 'C_ax',C_ax);

end

function animate_step(w1_prev, w1, w_ax, C_ax, y_x, hDot)

    if (w1 >= y_x && w1_prev < y_x) || (w1 <= y_x && w1_prev <= y_x)
        mask = w_ax >= w1_prev & w_ax <= w1;
    elseif (w1 < y_x && w1_prev >= y_x) || (w1 >= 0 && w1_prev >= y_x)
        mask = w_ax <= w1_prev & w_ax >= w1;
    end

    filtered_x = w_ax(mask);
    filtered_y = C_ax(mask);

    if (w1 <= y_x && w1_prev >= y_x) || (w1 >= y_x && w1_prev >= y_x)
        filtered_x = flip(filtered_x);
        filtered_y = flip(filtered_y);
    end

    for k = 1 : length(filtered_x)
        set(hDot, 'XData', filtered_x(k) - filtered_x(k) * 0.035, 'YData', filtered_y(k) + 2.5);
        assignin('base', 'hDot',hDot);
        pause(0.005);
    end

end

function init_step(x, w1, C_w, eta)

    title(['Step: ' num2str(x - 1) ' - Cost: ' num2str(round(C_w, 2)) ' - Learning Rate: ' num2str(eta)]);
    assignin('base', 'w1_prev', w1);

end
