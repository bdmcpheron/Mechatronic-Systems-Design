function [tr, ts, Mp, tp, yss] = find_resp_char(y,t)
% FIND_REP_CHAR time response characteristics of dynamic responses

% ENGR 445
% McPheron

% assume last point of y vector represents steady-state value
yss = y(end);

% find Mp (percent) and tp
[Mp, tp_index] =  max(y);
Mp = 100*(Mp - yss)/yss;
tp = t(tp_index);

% find tr
% limit search to 0 < t < tp to find initial 10% to 90% rise in response
tr_range_indices = find( (y >= 0.1*yss) & (y <= 0.9*yss) & ( t <= tp));
tr = max( t(tr_range_indices) ) - min( t(tr_range_indices) );

% find ts by flipping t and y 
yud = flipud(y);
tud = flipud(t);
ts_indices = find( (yud >= 1.02*yss) | (yud <= 0.98*yss) );
ts = tud ( min(ts_indices) );