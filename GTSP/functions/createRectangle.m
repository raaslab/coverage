% createRectangle.m

function [output] = createRectangle(x1, y1, x2, y2)

sensingRange = 0.5;
angle = atan2(y2-y1,x2-x1);
cent1L = [x1 - sensingRange*(cos(angle)+sin(angle)), y1 + sensingRange*(sin(angle)-cos(angle))];
cent1R = [x1 + sensingRange*(cos(angle)+sin(angle)), y1 - 10*sensingRange*(sin(angle)-cos(angle))];
% cent2L = [x2 - sensingRange*(cos(angle)+sin(angle)), y2 + sensingRange*(sin(angle)-cos(angle))];
% cent2R = [x2 + sensingRange*(cos(angle)+sin(angle)), y2 + sensingRange*(sin(angle)-cos(angle))];

output = [cent1L;cent1R;cent1L];
% ;cent2L;cent2R

% % find which point is on left
% if x1 > x2
%     TL = [x2-0.5, y2+0.5];
%     TR = [x1+0.5, y1+0.5];
%     BR = [x1+0.5, y1-0.5];
%     BL = [x2-0.5, y2-0.5];
%     
% elseif x1 < x2
%     TL = [x1-0.5, y1+0.5];
%     TR = [x2-0.5, y2+0.5];
%     BR = [x2+0.5, y2-0.5];
%     BL = [x1-0.5, y1-0.5];
%     
% else
%     if y1 > y2
%         TL = [x1-0.5, y1+0.5];
%         TR = [x2-0.5, y2+0.5];
%         BR = [x2+0.5, y2-0.5];
%         BL = [x1-0.5, y1-0.5];
%     elseif y1 < y2
%         TL = [x2-0.5, y2+0.5];
%         TR = [x1+0.5, y1+0.5];
%         BR = [x1+0.5, y1-0.5];
%         BL = [x2-0.5, y2-0.5];
%     else
%         TL = [0,0];
%         TR = [0,0];
%         BR = [0,0];
%         BL = [0,0];
%         disp('ERROR')
%     end
% end


end