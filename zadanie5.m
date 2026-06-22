clear
sys = tf(1, [1 5 7 8 1]);
dsys = c2d(sys, 5);
P=2;
I=0;
samples = 100;
uchyb = [samples];
out = sim("zadanie5sim.slx");
it = 0;
for I=linspace(80,90, samples)
    it = it +1;
    uchyb(it) = sum(out.uchyb.*out.uchyb);
    i(it) = I;
    out = sim("zadanie5sim.slx");
end
plot(uchyb)
for j = 1:samples
if uchyb(j) == min(uchyb)
i(j)
end
end
%figure
%hold on
%step(sys, dsys)
%title("Odpowiedź skokowa dla T=5")
%xlabel("czas")
%ylabel("Amplituda")