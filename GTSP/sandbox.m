% RSR, RSL, LSR, LSL, RLR, LRL

TR = 4; % turn radius
V = 5; % speed

sx = 0;
sy = 0;
syaw = 0;
ex = 5;
ey = 5;
eyaw = 0;
c = TR;

ex = ex - sx;
ey = ey - sy;

lex = cos(syaw)*ex + sin(syaw)*ey;
ley = -sin(syaw)*ex + cos(syaw)*ey;
leyaw = eyaw - syaw;
D = sqrt(lex^2.0 + ley^2.0);
d = D / c;
fprintf('D: %.4f\n', D)

theta = mod2pi(atan2(ley, lex));
alpha = mod2pi(-theta);
beta = mod2pi(leyaw-theta);

planners = ['LSL', 'RSR', 'LSR', 'RSL', 'RLR', 'LRL'];

bcost = Inf;
bt = 0;
bp = 0;
bq = 0;
bmode = 0;

for i = 1:length(planners) % planner in planners:
    [t,p,q,mode,cost,finished] = general_planner(planners(i), alpha, beta, d);
    if finished == 1 % if no solution was found skip to next type of planner
        continue
    end
    if bcost > cost
        bt = t;
        bp = p;
        bq = q;
        bmode = mode;
        bcost = cost;
    end
end

% zip(bmode, [bt*c, bp*c, bq*c], [c] * 3)



function [output] = mod2pi(theta)
output = theta - 2.0*pi*floor(theta/2.0/pi);
end

function [t,p,q,mode,cost,finished] = general_planner(planner, alpha, beta, d)
sa = sin(alpha);
sb = sin(beta);
ca = cos(alpha);
cb = cos(beta);
c_ab = cos(alpha - beta);
planner_uc = planner;
impossible = 0;
t = 0;
p = 0;
q = 0;
if strcmp(planner_uc,'LSL') == 1
    tmp0 = d + sa - sb;
    p_squared = 2 + (d * d) - (2 * c_ab) + (2 * d * (sa - sb));
    if p_squared < 0
        impossible = 1;
        mode = 0;
        cost = 0;
    end
    tmp1 = atan2((cb - ca), tmp0);
    t = mod2pi(-alpha + tmp1);
    p = sqrt(p_squared);
    q = mod2pi(beta - tmp1);
elseif strcmp(planner_uc,'RSR') == 1
    tmp0 = d - sa + sb;
    p_squared = 2 + (d * d) - (2 * c_ab) + (2 * d * (sb - sa));
    if p_squared < 0
        impossible = 1;
        mode = 0;
        cost = 0;
    end
    tmp1 = atan2((ca - cb), tmp0);
    t = mod2pi(alpha - tmp1);
    p = sqrt(p_squared);
    q = mod2pi(-beta + tmp1);
elseif strcmp(planner_uc,'LSR') == 1
    p_squared = -2 + (d * d) + (2 * c_ab) + (2 * d * (sa + sb));
    if p_squared < 0
        impossible = 1;
        mode = 0;
        cost = 0;
    end
    p = sqrt(p_squared);
    tmp2 = atan2((-ca - cb), (d + sa + sb)) - math.atan2(-2.0, p);
    t = mod2pi(-alpha + tmp2);
    q = mod2pi(-mod2pi(beta) + tmp2);
elseif strcmp(planner_uc,'RSL') == 1
    p_squared = (d * d) - 2 + (2 * c_ab) - (2 * d * (sa + sb));
    if p_squared < 0
        impossible = 1;
        mode = 0;
        cost = 0;
    end
    p = sqrt(p_squared);
    tmp2 = atan2((ca + cb), (d - sa - sb)) - math.atan2(2.0, p);
    t = mod2pi(alpha - tmp2);
    q = mod2pi(beta - tmp2);
elseif strcmp(planner_uc,'RLR') == 1
    tmp_rlr = (6.0 - d * d + 2.0 * c_ab + 2.0 * d * (sa - sb)) / 8.0;
    if abs(tmp_rlr) > 1.0
        impossible = 1;
        mode = 0;
        cost = 0;
    end
    p = mod2pi(2 * pi - acos(tmp_rlr));
    t = mod2pi(alpha - atan2(ca - cb, d - sa + sb) + mod2pi(p / 2.0));
    q = mod2pi(alpha - beta - t + mod2pi(p));
elseif strcmp(planner_uc,'LRL') == 1
    tmp_lrl = (6. - d * d + 2 * c_ab + 2 * d * (- sa + sb)) / 8.;
    if abs(tmp_lrl) > 1
        impossible = 1;
        mode = 0;
        cost = 0;
    end
    p = mod2pi(2 * math.pi - acos(tmp_lrl));
    t = mod2pi(-alpha - atan2(ca - cb, d + sa - sb) + p / 2.);
    q = mod2pi(mod2pi(beta) - alpha - t + mod2pi(p));
else
    fprintf('bad planner');
end
finished = impossible;
if finished == 0
    mode = planner;
end
% Lowercase directions are driven in reverse.
% 	for i in [0, 2]
% 		if planner[i].islower()
% 			path[i] = (2 * math.pi) - path[i]
%         end
%     end
% This will screw up whatever is in the middle.
% 	cost = sum(map(abs, path));
end