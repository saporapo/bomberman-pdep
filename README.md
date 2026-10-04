# Bomberman

Juego de Bomberman hecho en Wollok. Recorre el laberinto, rompe ladrillos con bombas,
derrota a los 2 enemigos para desbloquear la salida. 
Enemigo rojo: sigue a player.
Enemigo violeta: estático.
Hay ladrillos que esconden poderes:
- Sol: aumenta el alcance de la bomba.
- Rayo: aumenta la velocidad de player.

## Ejecutar

Desde la carpeta "mi-juego-en-wollok", ejecuta:

```sh
npm start
```
Vista:
<img width="626" height="435" alt="image" src="https://github.com/user-attachments/assets/c27b77a8-bffe-421f-93c9-9c72528a4d84" />

También puedes abrir `mainExample.wpgm` desde Wollok y ejecutar el programa
`mainExample.BombermanGame`.

## Archivos Wollok

El objeto que arma el nivel y controla la partida está en `example.wlk`.
Cada clase del juego tiene su propio archivo: `bombermanPlayer.wlk`,
`bomb.wlk`, `blast.wlk`, `breakableWall.wlk`, `indestructibleWall.wlk`,
`levelExit.wlk`, `powerUp.wlk`, `roamingEnemy.wlk` y `huntingEnemy.wlk`.
`example.wlk` importa las clases que utiliza.

## Controles

- Flechas: moverse por la cuadrícula.
- Espacio: colocar una bomba. Explota después de 1,8 segundos.
- R: reiniciar después de ganar o perder.

Las paredes grises son indestructibles. Las cajas marrones se destruyen con
explosiones; algunas liberan una mejora de alcance o de velocidad. El enemigo
violeta no se mueve y el rojo persigue al jugador. La salida se abre al
derrotar a ambos.
