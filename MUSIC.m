  function [phitarget, thetatarget, P] = MUSIC(selectedEigenvecs,Q,az_UEPos_Target,el_UEPos_Target,ueantpos)

step = 1;

azimuth = 0:step:(180 - step);
azimuth = azimuth/180 * pi;

elevation = 0:step:(180 - step);
elevationfirst = elevation(1);
elevationlast = elevation(end);

elevation = elevation*pi /180;

P = zeros(length(azimuth),length(elevation));
for i=1:length(azimuth)
    for i1=1:length(elevation)
        vec = [sin(elevation(i1))*cos(azimuth(i)), sin(elevation(i1))*sin(azimuth(i)),cos(elevation(i1))];
        a1 = exp(1j*pi*ueantpos*vec');
        P(i,i1) = abs(1/(a1'*selectedEigenvecs*selectedEigenvecs'*a1));

    end
end

% Find the Q maximum elements and their positions
[maxValues, maxIndices] = maxk(P(:), Q);
[rowsmax, colsmax] = ind2sub(size(P), maxIndices);
rows = az_UEPos_Target;
cols = el_UEPos_Target;
rowsmax = rowsmax .* step - step;

phitarget = rowsmax;
colsmax = colsmax.* step + elevationfirst - step;
thetatarget = colsmax;

% Create a 3D plot of the matrix P
% figure;
% % [x, y] = meshgrid(1:size(P, 2), 1:size(P, 1));
% % z = P;
% 
% % Plot the 3D surface
% surf( elevation*180/pi +step ,azimuth*180/pi+step, 10*log10(P),'EdgeColor', 'interp', 'FaceColor','interp' );
% 
% % Highlight the Q maximum elements
% hold on;
% scatter3(cols, rows, 10*log10(maxValues), 50, 'r', 'filled');
% % text(cols, rows, 10*log10(maxValues), strcat('(', num2str(rows), ',', num2str(cols), ')'), 'FontSize', 8);
% % 
% hold on;
% scatter3(colsmax, rowsmax, 10*log10(maxValues), 50, 'g', 'filled');
% text(colsmax, rowsmax, 10*log10(maxValues), strcat('(', num2str(abs(rowsmax - rows)), ',', num2str(abs(colsmax -cols)), ')'), 'FontSize', 8);
% 
% % Add labels and title
% xlabel('Elevation (degree)');
% ylabel('Azimuth (degree)');
% zlabel('Matrix Value');
% title(['3D Plot of Matrix P']);
% 
% % Show grid
% grid on;

end



