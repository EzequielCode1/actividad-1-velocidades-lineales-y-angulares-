%% =========================
%% 1. Limpieza del entorno
%% =========================
clear
clc
close all


%% =========================
%% 2. Definición de variables simbólicas
%% =========================
syms th1 th2 th3 l1 l2 l3 real
syms th1p th2p th3p real


%% =========================
%% 3. Coordenadas generalizadas
%% =========================
Q  = [th1 th2 th3];
Qp = [th1p th2p th3p];


%% =========================
%% 4. Definición geométrica de cada eslabón
%% =========================
% Para un robot planar 3R:
% - Cada junta rota sobre el eje Z
% - Cada eslabón se traslada sobre el eje X local

% --- Eslabón 1 ---
P1 = [l1; 0; 0];   % Traslación en X local
R1 = [cos(th1) -sin(th1) 0;
      sin(th1)  cos(th1) 0;
      0         0        1];

% --- Eslabón 2 ---
P2 = [l2; 0; 0];
R2 = [cos(th2) -sin(th2) 0;
      sin(th2)  cos(th2) 0;
      0         0        1];

% --- Eslabón 3 ---
P3 = [l3; 0; 0];
R3 = [cos(th3) -sin(th3) 0;
      sin(th3)  cos(th3) 0;
      0         0        1];


%% =========================
%% 5. Construcción de transformaciones homogéneas locales
%% =========================
A1 = simplify([R1 P1; 0 0 0 1]);
A2 = simplify([R2 P2; 0 0 0 1]);
A3 = simplify([R3 P3; 0 0 0 1]);


%% =========================
%% 6. Transformaciones homogéneas globales
%% =========================
T1 = A1;
T2 = simplify(T1 * A2);
T3 = simplify(T2 * A3);


%% =========================
%% 7. Posición del efector final
%% =========================
PO = simplify(T3(1:3,4));


%% =========================
%% 8. Jacobiano lineal
%% =========================
% El Jacobiano lineal relaciona:
% velocidades articulares → velocidad cartesiana

Jv = simplify(jacobian(PO, Q));


%% =========================
%% 9. Jacobiano angular
%% =========================
% En un robot planar 3R:
% Todas las juntas rotan sobre Z

Jw = [0 0 0;
      0 0 0;
      1 1 1];


%% =========================
%% 10. Cálculo de velocidades
%% =========================

% ---------------------------------
% Velocidad lineal del efector final
% ---------------------------------
% Se obtiene multiplicando el Jacobiano lineal por el vector
% de velocidades articulares.
%
% Interpretación física:
% Cada columna del Jacobiano representa cómo contribuye
% una articulación a la velocidad cartesiana.
%
% Resultado esperado:
% V = [Vx; Vy; 0]

V = simplify(Jv * Qp.');

% ---------------------------------
% Velocidad angular del efector final
% ---------------------------------
% Se obtiene multiplicando el Jacobiano angular por el vector
% de velocidades articulares.
%
% Interpretación física:
% En un robot planar 3R, todas las juntas rotan sobre Z:
%
% ωz = th1p + th2p + th3p
%
% Resultado:
% W = [0; 0; ωz]

W = simplify(Jw * Qp.');


%% =========================
%% Visualización de resultados
%% =========================
disp('============================')
disp('Posición efector final:')
pretty(PO)

disp('============================')
disp('Jacobiano lineal:')
pretty(Jv)

disp('============================')
disp('Velocidad lineal:')
pretty(V)

disp('============================')
disp('Velocidad angular:')
pretty(W)
