a = 8;
b = 12;
x = linspace(0,4,10000);
sys = ode;
sys.ODEFcn = @(t,y) [y(2); -b*y(1)-a*y(2)];
sys.InitialValue = [0, 1];
sys.SelectedSolver
hold off
out = solve(sys, 0, 4);
plot(x, -(1/4)*(exp(-6*x)-exp(-2*x)))
figure
plot(x, 1/12+1/24*exp(-6*x)-1/8*exp(-2*x))
s = tf(1, [1 8 12]);
figure
stepplot(s)
figure
impulseplot(s)
figure
plot(out.Time, abs(out.Solution(1,:)))