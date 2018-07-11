% polygonCreater.m

numberOfPolygons = 5;
x1 = Inf([1,numberOfPolygons]);
y1 = Inf([1,numberOfPolygons]);
x2 = Inf([1,numberOfPolygons]);
y2 = Inf([1,numberOfPolygons]);
i = 1;

while i < numberOfPolygons
x1(i) = randi(100,1);
y1(i) = randi(100,1);
x2(i) = randi(100,1);
y2(i) = randi(100,1);

% check if lines intersect
i = i+1;

end
