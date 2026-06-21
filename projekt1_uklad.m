clear; close all; clc;

a = 8;  b = 12;
K = tf(1, [1 a b]);

C_ana = [ 31  78 121]/255;
C_num = [224 123  57]/255;
C_acc = [ 46 139  87]/255;
C_gry = [119 119 119]/255;

t = linspace(0, 3, 800).';

k_ana = 0.25*(exp(-2*t) - exp(-6*t));
k_num = impulse(K, t);
err_k = abs(k_ana - k_num) + eps;

fig = figure('Color','w','Units','centimeters','Position',[2 2 16 11]);
tiledlayout(4,1,'TileSpacing','compact','Padding','compact');

ax1 = nexttile([3 1]);
plot(t, k_ana, 'Color', C_ana, 'LineWidth', 2); hold on;
plot(t, k_num, '--', 'Color', C_num, 'LineWidth', 2);
ylabel('k(t)');
title('Odpowiedź impulsowa k(t)');
legend({'analitycznie $\frac{1}{4}(e^{-2t}-e^{-6t})$','numerycznie'}, ...
       'Interpreter','latex','Location','northeast');
styluj(ax1);

ax2 = nexttile;
semilogy(t, err_k, 'Color', C_acc, 'LineWidth', 1.5);
xlabel('czas t [s]'); ylabel('|błąd|');
title('Różnica analityka – symulacja');
styluj(ax2);

exportgraphics(fig, 'latex/fig/odpowiedz_impulsowa.png', 'Resolution', 300);

lam_ana = 1/12 - (1/8)*exp(-2*t) + (1/24)*exp(-6*t);
lam_num = step(K, t);
err_l   = abs(lam_ana - lam_num) + eps;

fig = figure('Color','w','Units','centimeters','Position',[2 2 16 11]);
tiledlayout(4,1,'TileSpacing','compact','Padding','compact');

ax1 = nexttile([3 1]);
plot(t, lam_ana, 'Color', C_ana, 'LineWidth', 2); hold on;
plot(t, lam_num, '--', 'Color', C_num, 'LineWidth', 2);
yline(1/12, ':', 'wart. ustalona 1/12', 'Color', C_gry, ...
      'LineWidth', 1.4, 'LabelHorizontalAlignment','left');
ylabel('\lambda(t)');
title('Odpowiedź skokowa \lambda(t)');
legend({'analitycznie','numerycznie'}, 'Location','southeast');
styluj(ax1);

ax2 = nexttile;
semilogy(t, err_l, 'Color', C_acc, 'LineWidth', 1.5);
xlabel('czas t [s]'); ylabel('|błąd|');
title('Różnica analityka – symulacja');
styluj(ax2);

exportgraphics(fig, 'latex/fig/odpowiedz_skokowa.png', 'Resolution', 300);

disp('Zapisano: odpowiedz_impulsowa.png, odpowiedz_skokowa.png');

function styluj(ax)
    grid(ax,'on'); box(ax,'on');
    set(ax, 'FontName','Helvetica', 'FontSize', 11, 'LineWidth', 0.9, ...
            'TickDir','in', 'XMinorTick','on', 'YMinorTick','on', ...
            'GridColor',[0.80 0.80 0.80], 'GridAlpha', 0.9, ...
            'MinorGridColor',[0.92 0.92 0.92], 'MinorGridAlpha', 0.5, ...
            'Layer','top');
end