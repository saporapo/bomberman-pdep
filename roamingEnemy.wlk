import wollok.game.*

import example.bombermanGame

class RoamingEnemy {
  var property position

  method image() = "enemy-roaming.png"
  method isRoaming() = true

  method moveRandomly() {
    const direction = 0.randomUpTo(4).truncate(0)
    self.tryRandomDirection(direction, 0)
  }

  method tryRandomDirection(direction, attempts) {
    if (attempts < 4 && !self.tryDirection(direction)) {
      self.tryRandomDirection(self.nextDirection(direction), attempts + 1)
    }
  }

  method nextDirection(direction) =
    if (direction == 3) 0 else direction + 1

  method tryDirection(direction) {
    if (direction == 0) return self.tryMove(1, 0)
    if (direction == 1) return self.tryMove(-1, 0)
    if (direction == 2) return self.tryMove(0, 1)
    return self.tryMove(0, -1)
  }

  method tryMove(dx, dy) {
    const destination = game.at(position.x() + dx, position.y() + dy)
    if (bombermanGame.canEnemyEnter(destination)) {
      self.position(destination)
      return true
    }
    return false
  }
}
