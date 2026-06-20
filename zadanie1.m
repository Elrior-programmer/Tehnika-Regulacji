a = 8;
b = 12;
x = linspace(0,4,10000);
sys = ode;
sys.ODEFcn = @(t, y, p) [y;-a*y-b*p];
sys.InitialValue = 0;
sys.SelectedSolver
hold off
out = solve(sys, 0, 15);
plot(x, -(1/4)*(exp(-6*x)-exp(-2*x)))
figure
plot(x, 1/12+1/24*exp(-6*x)-1/8*exp(-2*x))
s = tf(1, [1 8 12]);
figure
stepplot(s)
figure
impulseplot(s)
%plot(out.Time, out.Solution)