% Sophie SAKKA 

function data2=Interpolate(data)
nanData = isnan(data);
index   = 1:numel(data);
data2   = data;
data2(nanData) = interp1(index(~nanData), data(~nanData), index(nanData));
end