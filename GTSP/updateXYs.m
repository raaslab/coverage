% updateXYs

function [x1, y1, x2, y2] = updateXYs(x1, y1, x2, y2, location, value, valueOrRandom)

if valueOrRandom == 1
    x1(location) =  randi(100,1);
    y1(location) =  randi(100,1);
    x2(location) =  randi(100,1);
    y2(location) =  randi(100,1);
else
    x1(location) = value;
    y1(location) = value;
    x2(location) = value;
    y2(location) = value;
end


end