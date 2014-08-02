function handle = plot_mean_std(data, time, fig, curve_color, correct_data)

if exist('correct_data') && correct_data, data = data - repmat(mean(mean(data,2)),size(data)); end

n_spline = size(data,3);

if ~exist('time') || isempty(time), time = linspace(0,100,size(data,2)); end
if ~exist('fig') || isempty(fig), handle = figure(); else handle = figure(fig); end
if ~exist('curve_color') || isempty(curve_color), curve_color = rand(n_spline,3); end

n_smooth = 1;

data = permute(data, [2,1,3]);

for i=1:n_spline
    
    y_mean = mean(data(:,:,i))';
    delta = std(data(:,:,i),[])';
    
    y = [y_mean-delta y_mean+delta];
    ymin = smooth(min(y,[],2),n_smooth)';
    ymax = smooth(max(y,[],2),n_smooth)';
    
    y_mean = smooth(y_mean,n_smooth);
    
   
    jbfill(time, ymax, ymin, curve_color(i,:), curve_color(i,:), 1, 0.3);
    hold on
    plot(time, y_mean, 'color', curve_color(i,:),'LineWidth',5)
    
end
