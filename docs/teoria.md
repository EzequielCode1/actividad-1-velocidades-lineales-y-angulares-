# Fundamento Teórico

## Robot Planar de 3 GDL
Se analiza un manipulador serial compuesto por tres juntas rotacionales (3R),
cuyo movimiento se restringe al plano XY.

## Cinemática Directa
La posición del efector final se obtiene mediante transformaciones homogéneas:

P_E = f(θ₁, θ₂, θ₃)

## Jacobiano
El Jacobiano relaciona las velocidades articulares con la velocidad del efector final:

V = J_v(q) q̇  
W = J_w(q) q̇

## Velocidad Lineal
Se obtiene derivando la posición respecto a las coordenadas articulares.

## Velocidad Angular
En robots planares con juntas rotacionales:

ω_z = θ̇₁ + θ̇₂ + θ̇₃
