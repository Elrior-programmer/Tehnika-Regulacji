sys = tf(1,[1 8 12]);
[nyr, nyi, a] = nyquist(sys)
omega = linspace(0, 100000, 1000000);
y = 1./(-1*omega.*omega+8*omega*i+12);
figure
hold on
plot(y, '-')
for g=1:115
out(g) = nyr(1,1,g)+i*nyi(1,1,g);
end
plot(out, '-')