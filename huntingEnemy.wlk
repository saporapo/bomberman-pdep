import wollok.game.*

import example.bombermanGame

class HuntingEnemy {
  var property position

  method image() = "enemy-hunting.png"
  method isRoaming() = false

  method moveToward(target) {
    const dx = target.x() - position.x()
    const dy = target.y() - position.y()
    if (dx.abs() >= dy.abs() && dx != 0) {
      if (!self.tryMove(self.directionOf(dx), 0) && dy != 0) {
        self.tryMove(0, self.directionOf(dy))
      }
    } else if (dy != 0) {
      if (!self.tryMove(0, self.directionOf(dy)) && dx != 0) {
        self.tryMove(self.directionOf(dx), 0)
      }
    } else if (dx != 0) {
      self.tryMove(self.directionOf(dx), 0)
    }
  }

  method directionOf(value) = if (value > 0) 1 else -1

  method tryMove(dx, dy) {
    const destination = game.at(position.x() + dx, position.y() + dy)
    if (bombermanGame.canEnemyEnter(destination)) {
      self.position(destination)
      return true
    }
    return false
  }
}
