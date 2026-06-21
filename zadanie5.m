clear
sys = tf(1, [1 8 12]);
dsys = c2d(sys, 0.1);
P=17;
I=0;
samples = 500
uchyb = [samples];
out = sim("zadanie5sim.slx");
for I=samples-100:samples%sum(out.uchyb.*out.uchyb) < min_uchyb
    uchyb(I) = sum(out.uchyb.*out.uchyb);
    out = sim("zadanie5sim.slx");
end
plot(uchyb)
for j = 1:100
if uchyb(j) == min(uchyb)
j
end
end
%figure
%hold on
%step(sys, dsys)
%title("Odpowiedź skokowa dla T=0.5")
%xlabel("czas")
%ylabel("Amplituda")