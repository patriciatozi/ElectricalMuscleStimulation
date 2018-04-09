%Entradas
frequencia = input('Insira a frequencia aplicada (em Hz): ');
pulsos = input('Insira a quantidade de pulsos aplicados: ');
te = (0:1e-3:2)';
u = zeros(size(te));
i = 2;

%Vetor contendo caracteres do RA
ra = [2,1,0,2,7,3,1,5];

%Frequencia natural (rad/s):
w = 10; 

%Coeficiente de amortecimento:
s = 0.6;

%Ganho (N/s):
b = 25;

%For para definir valores de constantes w, s e b:
for n = (1:8)
    if n<6
        if n<4
            w = w + 0.01*ra(n);
        elseif n == 4
            w = w + 0.01*ra(n);
            b = b + 0.01*ra(n); 
        else
            b = b + 0.01*ra(n); 
        end
    else
        s = s + 0.01*ra(n);
    end
end

%Elemento da posicao 2 do vetor u:
u(2) = 1000;

for j =(1:pulsos-1)
    i = i + 1000/frequencia;
    u(i) = 1000;
end

% Sistema
A = [0,1;-w^2,-2*w*s];
B = [0;b*(w^2)];
C = [1,0];
D = [0];
sys = ss(A,B,C,D);
[y, ts, x] = lsim(sys, u, te);

% Resultados
ax = plotyy(ts, y, te, u);
xlabel('Tempo (s)');
ylabel(ax(1),'Forca (N)');
ylabel(ax(2),'Intensidade');
legend('f(t)', 'x(t)');
