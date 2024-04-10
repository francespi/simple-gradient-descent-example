clc
clear
close all 
syms v

%% Tune this parameters

% Learning rate
eta = 0.99;

% Weight initial value
v1=-9;

% Gradient descent steps
steps = 1000;

%% Do not edit past this point

% Cost function
C = v^2;

% Gradient
dC_dv = diff(C);

x = -10:0.1:10;
y = x.^2 ;

figure(1);
set(gcf,'color','w');
plot(x,y,'LineWidth',2);
ylabel('Cost')
xlabel('Weight')
hold on;
C_value = double(subs(C,v1));
hDot = plot(0, 0, 'o','MarkerSize',10,'MarkerFaceColor',[1 .6 .6]);
xlim([min(x), max(x)]);
ylim([min(y), max(y)]);

for i=1:steps

    if(C_value < 0.005)
            break;
    end

    C_value_prev = C_value;
    v_value_prev = v1;

    % Weight update
    v1 = v1 - eta*double(subs(dC_dv,v1));

    % Cost update
    C_value = double(subs(C,v1));

    title(['Step: ' num2str(i) ' - Cost: ' num2str(round(C_value,2)) ' - Learning Rate: ' num2str(eta)]);

    if (v1 >=0 && v_value_prev < 0) ||(v1 <=0 && v_value_prev <= 0)
        mask = x>=v_value_prev & x<=v1;
    elseif (v1 <0 && v_value_prev >= 0) ||(v1 >=0 && v_value_prev >= 0)
        mask = x<=v_value_prev & x>=v1;
    end

    filtered_x = x(mask);
    filtered_y = y(mask);

    if (v1 <= 0 && v_value_prev >=0) || (v1 >= 0 && v_value_prev >=0)
        filtered_x=flip(filtered_x);
        filtered_y=flip(filtered_y);
    end

    for k = 1:length(filtered_x)
        set(hDot, 'XData', filtered_x(k)-filtered_x(k)*0.035, 'YData', filtered_y(k)+2.5);
        pause(0.005);
    end

end