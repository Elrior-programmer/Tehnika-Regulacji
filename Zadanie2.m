clear; close all; clc;

a = 8;  b = 12;
G = tf(1, [1 a b]);

C_ana = [ 31  78 121]/255;
C_num = [224 123  57]/255;
C_acc = [ 46 139  87]/255;
C_gry = [119 119 119]/255;

w = logspace(-2, 3, 2000).';
D      = (b - w.^2).^2 + (a*w).^2;
re_ana =  (b - w.^2) ./ D;
im_ana = -(a*w)      ./ D;

w_meas  = [0.5 1 2 3 4 6 9];
re_meas = zeros(size(w_meas));
im_meas = zeros(size(w_meas));

for k = 1:numel(w_meas)
    wk  = w_meas(k);
    Tk  = 2*pi/wk;
    dt  = Tk/400;
    tt  = (0:dt:max(8, 18*Tk)).';
    u   = sin(wk*tt);
    yy  = lsim(G, u, tt);

    tmin = tt(end) - 10*Tk;
    sel  = tt >= tmin;
    ts   = tt(sel);  ys = yy(sel);
    Twin = ts(end) - ts(1);

    re_meas(k) = (2/Twin) * trapz(ts, ys.*sin(wk*ts));
    im_meas(k) = (2/Twin) * trapz(ts, ys.*cos(wk*ts));
end

mag_meas = abs(re_meas + 1i*im_meas);
faz_meas = angle(re_meas + 1i*im_meas) * 180/pi;

T = table(w_meas(:), re_meas(:), im_meas(:), mag_meas(:), faz_meas(:), ...
    'VariableNames', {'omega','Re','Im','modul','faza_deg'});
disp(T);

fprintf('%6s & %10s & %10s & %10s & %10s \\\\\n', ...
    '$\omega$', 'Re', 'Im', '$|G|$', '$\varphi$ [deg]');
fprintf('\\hline\n');
for k = 1:numel(w_meas)
    fprintf('%6.2f & %10.5f & %10.5f & %10.5f & %10.2f \\\\\n', ...
        w_meas(k), re_meas(k), im_meas(k), mag_meas(k), faz_meas(k));
end

G_ana_m  = 1 ./ ((b - w_meas.^2) + 1i*a*w_meas);

fig = figure('Color','w','Units','centimeters','Position',[2 2 16 13]);
tiledlayout(4,1,'TileSpacing','compact','Padding','compact');

ax1 = nexttile([3 1]);
plot(re_ana, im_ana, 'Color', C_ana, 'LineWidth', 2); hold on;
plot(re_meas, im_meas, 'o', 'Color', C_num, 'MarkerFaceColor', C_num, ...
     'MarkerSize', 7, 'LineWidth', 1.2);

axis equal;
xlim([-0.02 0.10]);
ylim([-0.06 0.]);
xlabel('Re\{G(j\omega)\}'); ylabel('Im\{G(j\omega)\}');
title('Charakterystyka Nyquista  G(j\omega)=1/((j\omega)^2+8j\omega+12)');
legend({'analitycznie','pomiar (odp. ustalona)'}, 'Location','north');
styluj(ax1);

exportgraphics(fig, 'latex/fig/nyquist.png', 'Resolution', 300);
disp('Zapisano: nyquist.png');

function styluj(ax)
    grid(ax,'on'); box(ax,'on');
    set(ax, 'FontName','Helvetica', 'FontSize', 11, 'LineWidth', 0.9, ...
        'TickDir','in', 'XMinorTick','on', 'YMinorTick','on', ...
        'GridColor',[0.80 0.80 0.80], 'GridAlpha', 0.9, ...
        'MinorGridColor',[0.92 0.92 0.92], 'MinorGridAlpha', 0.5, ...
        'Layer','top');
end