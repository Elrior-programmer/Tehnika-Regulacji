k = [-15 -12 -5];
for i = k
sys = tf(i, [1 8 12+i]);
figure
impulseplot(sys);
end