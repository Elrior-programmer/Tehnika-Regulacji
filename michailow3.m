omega = linspace(0, 10, 1000);
m = -1*omega.*omega + 8*omega*i +12;
plot(m, '-')
xlabel("Rzeczywista");
ylabel("Urojona");
title("Charakterystyka Michajłowa");
grid on;