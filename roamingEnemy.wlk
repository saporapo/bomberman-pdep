import wollok.game.*

import example.bombermanGame

class RoamingEnemy {
  var property position

  method image() = "enemy-roaming.png"
  method isRoaming() = true

  method moveRandomly() {
    const direction = 0.randomUpTo(3)
    if (direction == 0) self.tryMove(1, 0)
    if (direction == 1) self.tryMove(-1, 0)
    if (direction == 2) self.tryMove(0, 1)
    if (direction == 3) self.tryMove(0, -1)
  }

  method tryMove(dx, dy) {
    const destination = game.at(position.x() + dx, position.y() + dy)
    if (bombermanGame.canEnemyEnter(destination)) self.position(destination)
  }
}
