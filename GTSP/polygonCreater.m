% polygonCreater.m
% creates n number of line segments which represent the middle line of a
% polygon.

fileName = 'testInput.txt';
numberOfPolygons = 10;
randNum = 100;

x1 = Inf([1,numberOfPolygons]);
y1 = Inf([1,numberOfPolygons]);
x2 = Inf([1,numberOfPolygons]);
y2 = Inf([1,numberOfPolygons]);
[x1, y1, x2, y2] = updateXYs(x1, y1, x2, y2, 1, 'rand', 1, randNum);

i = 2;
while i < numberOfPolygons+1
    repeat = 0;
    [x1, y1, x2, y2] = updateXYs(x1, y1, x2, y2, i, 'rand', 1, randNum);
    newLine = [x1(i), y1(i), x2(i), y2(i)]; % get new line
    
    for j = 1:i-1
        tempLine = [x1(j), y1(j), x2(j), y2(j)]; % get all previous lines
        intersect = lineSegmentIntersect(tempLine, newLine); % check if lines intersect
        if intersect.intAdjacencyMatrix == 1
            [x1, y1, x2, y2] = updateXYs(x1, y1, x2, y2, i, Inf, 0, randNum); % remove newline segment
            repeat = 1;
            break;
        end
    end
    
    if repeat == 0
        i = i+1;
    end
    
    tempX1 = x1;
    tempY1 = y1;
    tempX2 = x2;
    tempY2 = y2;
    tempX1(isinf(x1)) = [];
    tempY1(isinf(y1)) = [];
    tempX2(isinf(x2)) = [];
    tempY2(isinf(y2)) = [];
    
    clf
    hold on
    for j = 1:length(tempX1)
        figure(1)
        plot([tempX1; tempX2], [tempY1; tempY2]);
    end
end

ugvPossible1 = ones([1, length(x1)]);
ugvPossible2 = ones([1, length(x2)]);

createPolygonFile(fileName, x1, y1, ugvPossible1, x2, y2, ugvPossible2)
