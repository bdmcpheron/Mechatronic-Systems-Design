%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% solveACmx                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written : 11/7/2014                                                     %
% Author  : Benjamin D. McPheron, Ph.D.                                   %
% Course  : ENGR 240                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose : This program asks the user to input complex matrices for A and% 
%           B and provides an output in polar form.  The output consists  %
%           of r which is the magnitude, and phi, which is the phase of   %
%           the polar represntation of the phasor. The relationship       %
%           between input and output is X=inv(A)*B                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Begin Program.
clear all              % Clear all variables
close all              % Close all open windows
clc                    % Clear the command window

% Ask for user input for matrix A
A = input('Enter A matrix now (must be n x n): ')    
% Get user input for A matrix
% A matrix MUST be square, n x n!

% Check if A matrix is square.  If not square, terminate program.
if size(A,1)~=size(A,2)
    disp('Error: A Matrix Not n x n (Square)!... terminating program')
    return
end

% Find the order of the system
szA = size(A,1);

% Ask for user input for matrix B
B = input('Enter B matrix now (must be n x 1): ')
% Get user input for B matrix
% B matrix must be n x 1!

% Check if B matrix is n x 1
if size(B,1)~=szA
    disp('Error: B Matrix Not n x 1!... terminating program')
    return
end


% Solve for X
X = inv(A) * B;

% The resulting values are in rectangular form.  Convert to polar.
[phi,r] = cart2pol(real(X),imag(X)); % returns angle phi and magnitude r
                                     % phi is in radians

phi = phi*180/pi; % convert phi to degrees

disp('Polar Magnitude: r = ')   % display the polar magnitude
disp(num2str(r))

disp('Polar Phase: phi = ')     % display the polar phase
disp(num2str(phi))

