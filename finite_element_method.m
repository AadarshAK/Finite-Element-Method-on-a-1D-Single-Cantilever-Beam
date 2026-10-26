%Creating elements of the beam
clc, clear all
elements = linspace(0, 75, 75);
a = 8e-4;
l = elements(2)-elements(1);
y = 2e11;
u = elements;
k = {};
%k_global = zeros(length(elements), length(elements));

d1 = zeros(length(elements), 1);
d2 = zeros(length(elements), 1);
%force = zeros(length(elements), 1);
force = linspace(0, 150, length(elements));
force = force.';

for i = 1:length(elements)
    d1(i) = (y*a/l);
end

d3 = d1.*-1;

for i = 2:length(elements)-1
    d2(i) = d1(i)+d1(i-1);
end

d2(1) = d1(1);
d2(end) = d1(end);

d1 = d1.*-1;

k_global = spdiags([d3, d2, d1], [-1, 0, 1], length(elements), length(elements));

k_global(1, :) = 0;
k_global(1, 1) = 1;

displacement = k_global\force;

stress = (y/l)*displacement;

plot(elements, displacement);
xlabel("length - x");
ylabel("displacement - u(x)");
title("displacement vs length")

plot(elements, stress);
xlabel("length - x");
ylabel("stress")

grid on;


