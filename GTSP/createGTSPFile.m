

function [] = createGTSPFile(filename, matrix, vertices, batteryLevels)

fileID = fopen(filename,'w');

fprintf(fileID, 'NAME: TEST\n');
fprintf(fileID, 'TYPE: AGTSP\n');
fprintf(fileID, 'COMMENT: NA\n');
fprintf(fileID, 'DIMENSION:  %d\n', (vertices*batteryLevels)+1);
fprintf(fileID, 'GTSP_SETS: %d\n', vertices+1);
fprintf(fileID, 'EDGE_WEIGHT_TYPE: EXPLICIT\n');
fprintf(fileID, 'EDGE_WEIGHT_FORMAT: FULL_MATRIX\n');
fprintf(fileID, 'EDGE_WEIGHT_SECTION\n');
fprintf(fileID, '%d\n', matrix);
fprintf(fileID, 'GTSP_SET_SECTION:\n');

counter = 1;
for a = 1:(vertices)
    fprintf(fileID, '%d ', a);
    for b = 1:batteryLevels
        fprintf(fileID, '%d ', counter);
        counter = counter+1;
    end
    fprintf(fileID, '-1\n');
end
fprintf(fileID, '%d %d -1\n', vertices+1, counter);
fprintf(fileID, 'EOF');

fclose(fileID);

end