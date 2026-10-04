# Bomberman

Juego de Bomberman hecho en Wollok. Recorre el laberinto, rompe cajas con bombas,
derrota a los dos enemigos y llega a la salida. Algunas cajas esconden mejoras.

## Ejecutar

Desde esta carpeta, ejecuta:

```sh
npm start
```

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
violeta se mueve al azar y el rojo persigue al jugador. La salida se abre al
derrotar a ambos.
