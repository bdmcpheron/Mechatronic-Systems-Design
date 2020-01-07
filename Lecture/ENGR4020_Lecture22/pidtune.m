function [Kp,Ki,Kd] = pidtune(num,den,Kp,Ki,Kd)
% Inputs: num,den,Kp,Ki,Kd
% Outputs: Kp,Ki,Kd

% This function requires the plant (num,den) and the untuned guesses at PID
% parameters (Kp,Ki,Kd)

flag = 1;

while flag
    [po,y1,t] = pid_plot(num,den,Kp,Ki,Kd);
    [tr, ts, Mp, tp, yss] = find_resp_char(y1,t)
    Kp_old = Kp;
    Ki_old = Ki;
    Kd_old = Kd;
    % Request user input
    userin = input('Is the response satisfactory (0 = No, 1 = Yes) ? ');
    if userin == 1
        flag = 0;
    end
    % Ask for new gains if flag is still 1
    if flag
        % Kp
        Kp = input([' Enter new Kp gain (<return> = Old Kp Gain = ',...
                    num2str(Kp),') = ']);
        if isempty(Kp)
            Kp = Kp_old;
        end
        % Ki
        Ki = input([' Enter new Ki gain (<return> = Old Ki Gain = ',...
                    num2str(Ki),') = ']);
        if isempty(Ki)
            Ki = Ki_old;
        end
        %Kd
        Kd = input([' Enter new Kd gain (<return> = Old Kd Gain = ',...
                    num2str(Kd),') = ']);
        if isempty(Kd)
            Kd = Kd_old;
        end
    end
end
        