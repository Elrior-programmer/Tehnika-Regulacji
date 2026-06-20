sys = tf(1,[1 8 12]);
nyquist(sys)
omega = linspace(0, 100000, 1000000);
y = 1./(-1*omega.*omega+8*omega*i+12);
figure
plot(y, '-')