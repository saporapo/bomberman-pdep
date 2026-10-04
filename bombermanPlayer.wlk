import wollok.game.*

import example.bombermanGame

class BombermanPlayer {
  var property position
  var radius = 2
  var stepsPerMove = 1

  method image() = "player.png"

  method reset() {
    radius = 2
    stepsPerMove = 1
  }

  method move(dx, dy) {
    self.moveSteps(dx, dy, stepsPerMove)
  }

  method moveSteps(dx, dy, steps) {
    if (bombermanGame.currentStatus() == "playing" && steps > 0) {
      const nextPosition = game.at(position.x() + dx, position.y() + dy)
      if (bombermanGame.canPlayerEnter(nextPosition)) {
        self.position(nextPosition)
        if (bombermanGame.hasEnemy(position)) bombermanGame.lose()
        bombermanGame.collectPowerUpsAt(position)
        bombermanGame.reachExit()
        self.moveSteps(dx, dy, steps - 1)
      }
    }
  }

  method bombRadius() = radius
  method movesPerKey() = stepsPerMove
  method increaseBombRadius() { radius += 1 }
  method increaseSpeed() {
    if (stepsPerMove < 3) stepsPerMove += 1
  }
}
