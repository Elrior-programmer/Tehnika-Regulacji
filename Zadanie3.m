k = [-15 -12 -5];
for i = k
    sys = tf(i, [1 8 12+i]);

    if i == -15
        [y, t] = impulse(sys, 160);
    else
        [y, t] = impulse(sys);
    end

    fig = figure('Color','w','Units','centimeters','Position',[2 2 16 13]);
    plot(t, y, 'LineWidth', 1.2);
    ax = gca;
    title(['Charakterystyka impulsowa dla k = ', num2str(i)]);
    xlabel('Czas (s)'); ylabel('Amplituda');
    grid(ax,'on');
    set(ax, 'Box','on', 'FontName','Helvetica', 'FontSize',11, 'LineWidth',0.9, ...
        'TickDir','in', 'XMinorTick','on', 'YMinorTick','on', ...
        'GridColor',[0.80 0.80 0.80], 'GridAlpha',0.9, ...
        'MinorGridColor',[0.92 0.92 0.92], 'MinorGridAlpha',0.5, 'Layer','top');
    set(ax, 'XMinorGrid','on', 'YMinorGrid','on');
    
    if i == -15
        ylim(ax, [-15e24 0]);
        xlim(ax, [0 320]);
    end
    exportgraphics(fig, ['latex/fig/k=', num2str(i), '.png'], 'Resolution', 300);
end

ksztalty = {'x', 'o', 's'};
kolory   = lines(numel(k));

fig = figure('Color','w','Units','centimeters','Position',[2 2 16 13]);
hold on;

xL = [-9 9];
yL = [-1 1];

fill([0 xL(2) xL(2) 0], [yL(1) yL(1) yL(2) yL(2)], [1 0.80 0.80], ...
     'EdgeColor','none', 'FaceAlpha',0.5, 'HandleVisibility','off');
text(xL(2)/2, yL(2)*0.92, 'Strefa niestabilnosci', 'Rotation',0, ...
     'HorizontalAlignment','center', 'VerticalAlignment','top', ...
     'Color',[0.6 0 0], 'FontWeight','bold', 'FontName','Helvetica', 'FontSize',10);
h = gobjects(numel(k),1);
for idx = 1:numel(k)
    i = k(idx);
    sys = tf(i, [1 8 12+i]);
    p = pole(sys);

    fprintf('\nk = %d   (mianownik: s^2 + 8s + %d)\n', i, 12+i);
    for n = 1:numel(p)
        fprintf('   biegun %d:  %+.4f %+.4fi\n', n, real(p(n)), imag(p(n)));
    end
    if any(real(p) > 0)
        fprintf('   -> NIESTABILNY\n');
    elseif any(abs(real(p)) < 1e-9)
        fprintf('   -> na granicy stabilnosci\n');
    else
        fprintf('   -> stabilny\n');
    end

    h(idx) = plot(real(p), imag(p), ksztalty{idx}, ...
                  'MarkerSize',12, 'LineWidth',2, 'Color', kolory(idx,:));
end
hold off;

ax = gca;
title('Bieguny ukladow dla roznych k');
xlabel('Re(s)'); ylabel('Im(s)');
grid(ax,'on');
set(ax, 'Box','on', 'FontName','Helvetica', 'FontSize',11, 'LineWidth',0.9, ...
    'TickDir','in', 'XMinorTick','on', 'YMinorTick','on', ...
    'GridColor',[0.80 0.80 0.80], 'GridAlpha',0.9, ...
    'MinorGridColor',[0.92 0.92 0.92], 'MinorGridAlpha',0.5, 'Layer','top');
set(ax, 'XMinorGrid','on', 'YMinorGrid','on');

ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim(ax, xL);
ylim(ax, yL);

legend(h, arrayfun(@(x) sprintf('k = %d', x), k, 'UniformOutput', false), ...
       'Location', 'best');
exportgraphics(fig, 'latex/fig/bieguny.png', 'Resolution', 300);