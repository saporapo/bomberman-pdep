import wollok.game.*

import bombermanPlayer.BombermanPlayer
import indestructibleWall.IndestructibleWall
import breakableWall.BreakableWall
import bomb.Bomb
import blast.Blast
import levelExit.LevelExit
import powerUp.PowerUp
import roamingEnemy.RoamingEnemy
import huntingEnemy.HuntingEnemy

object bombermanGame {
  const player = new BombermanPlayer(position = game.at(1, 1))
  const exit = new LevelExit(position = game.at(11, 7))
  const solidWalls = []
  const crates = []
  const powerUps = []
  const enemies = []
  const bombs = []
  const flames = []
  var status = "ready"

  method startLevel() {
    game.clear()
    status = "playing"
    solidWalls.clear()
    crates.clear()
    powerUps.clear()
    enemies.clear()
    bombs.clear()
    flames.clear()
    player.position(game.at(1, 1))
    player.reset()

    self.buildWalls()
    self.buildCrates()
    self.addEnemy(new RoamingEnemy(position = game.at(9, 1)))
    self.addEnemy(new HuntingEnemy(position = game.at(11, 5)))
    game.addVisual(exit)
    game.addVisual(player)
    self.bindControls()
    game.onTick(650, "roaming-enemy", { => self.moveRoamingEnemies() })
    game.onTick(520, "hunting-enemy", { => self.moveHuntingEnemies() })
  }

  method buildWalls() {
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].forEach({ x =>
      self.addSolidWall(game.at(x, 0))
      self.addSolidWall(game.at(x, 8))
    })
    [1, 2, 3, 4, 5, 6, 7].forEach({ y =>
      self.addSolidWall(game.at(0, y))
      self.addSolidWall(game.at(12, y))
    })
    [    game.at(2, 4), game.at(2, 6),
      game.at(4, 2), game.at(4, 4), game.at(4, 6),
      game.at(6, 2), game.at(6, 4), game.at(6, 6),
      game.at(8, 2), game.at(8, 4), game.at(8, 6),
      game.at(10, 2), game.at(10, 4), game.at(10, 6)
    ].forEach({ position => self.addSolidWall(position) })
  }

  method buildCrates() {
    self.addCrate(game.at(3, 1), "range")
    self.addCrate(game.at(5, 1), "none")
    self.addCrate(game.at(7, 1), "none")
    self.addCrate(game.at(8, 1), "none")
    self.addCrate(game.at(10, 1), "none")
    self.addCrate(game.at(3, 2), "none")
    self.addCrate(game.at(5, 2), "none")
    self.addCrate(game.at(7, 2), "none")
    self.addCrate(game.at(9, 2), "none")
    self.addCrate(game.at(11, 2), "none")
    self.addCrate(game.at(1, 3), "none")
    self.addCrate(game.at(3, 3), "none")
    self.addCrate(game.at(5, 3), "speed")
    self.addCrate(game.at(7, 3), "none")
    self.addCrate(game.at(9, 3), "none")
    self.addCrate(game.at(11, 3), "none")
    self.addCrate(game.at(3, 4), "none")
    self.addCrate(game.at(5, 4), "none")
    self.addCrate(game.at(7, 4), "none")
    self.addCrate(game.at(9, 4), "none")
    self.addCrate(game.at(11, 4), "none")
    self.addCrate(game.at(1, 5), "none")
    self.addCrate(game.at(3, 5), "none")
    self.addCrate(game.at(5, 5), "none")
    self.addCrate(game.at(7, 5), "none")
    self.addCrate(game.at(9, 5), "none")
    self.addCrate(game.at(1, 6), "none")
    self.addCrate(game.at(3, 6), "none")
    self.addCrate(game.at(5, 6), "none")
    self.addCrate(game.at(7, 6), "none")
    self.addCrate(game.at(9, 6), "none")
    self.addCrate(game.at(11, 6), "none")
    self.addCrate(game.at(3, 7), "none")
    self.addCrate(game.at(5, 7), "none")
    self.addCrate(game.at(7, 7), "none")
    self.addCrate(game.at(9, 7), "none")
  }

  method addSolidWall(position) {
    const wall = new IndestructibleWall(position = position)
    solidWalls.add(wall)
    game.addVisual(wall)
  }

  method addCrate(position, powerUp) {
    const crate = new BreakableWall(position = position, powerUp = powerUp)
    crates.add(crate)
    game.addVisual(crate)
  }

  method addEnemy(enemy) {
    enemies.add(enemy)
    game.addVisual(enemy)
  }

  method bindControls() {
    keyboard.up().onPressDo({ player.move(0, 1) })
    keyboard.down().onPressDo({ player.move(0, -1) })
    keyboard.left().onPressDo({ player.move(-1, 0) })
    keyboard.right().onPressDo({ player.move(1, 0) })
    keyboard.space().onPressDo({ self.placeBomb() })
    keyboard.r().onPressDo({ self.restart() })
  }

  method movePlayer(dx, dy) {
    player.move(dx, dy)
  }

  method canPlayerEnter(position) =
    self.insideBoard(position) &&
    !self.hasSolidWall(position) &&
    !self.hasCrate(position) &&
    !self.hasBomb(position) &&
    (self.exitIsOpen() || !game.onSameCell(position, exit.position()))

  method insideBoard(position) =
    position.x() > 0 && position.x() < 12 &&
    position.y() > 0 && position.y() < 8

  method hasSolidWall(position) =
    solidWalls.any({ wall => game.onSameCell(wall.position(), position) })

  method hasCrate(position) =
    crates.any({ crate => game.onSameCell(crate.position(), position) })

  method hasBomb(position) =
    bombs.any({ bomb => game.onSameCell(bomb.position(), position) })

  method hasEnemy(position) =
    enemies.any({ enemy => game.onSameCell(enemy.position(), position) })

  method placeBomb() {
    if (status == "playing" && !self.hasBomb(player.position())) {
      const bomb = new Bomb(position = player.position().clone(), radius = player.bombRadius())
      bombs.add(bomb)
      game.addVisual(bomb)
      game.schedule(1800, { => self.detonate(bomb) })
    }
  }

  method detonate(bomb) {
    if (bombs.contains(bomb) && status == "playing") {
      bombs.remove(bomb)
      game.removeVisual(bomb)
      self.checkBlastAt(bomb.position())
      self.spreadBlast(bomb.position(), 1, 0, bomb.radius())
      self.spreadBlast(bomb.position(), -1, 0, bomb.radius())
      self.spreadBlast(bomb.position(), 0, 1, bomb.radius())
      self.spreadBlast(bomb.position(), 0, -1, bomb.radius())
      if (game.onSameCell(player.position(), bomb.position())) self.lose()
    }
  }

  method spreadBlast(origin, dx, dy, remaining) {
    if (remaining > 0) {
      const position = game.at(origin.x() + dx, origin.y() + dy)
      if (self.insideBoard(position) && !self.hasSolidWall(position)) {
        self.checkBlastAt(position)
        if (self.hasCrate(position)) {
          self.destroyCrateAt(position)
        } else {
          self.spreadBlast(position, dx, dy, remaining - 1)
        }
      }
    }
  }

  method checkBlastAt(position) {
    const flame = new Blast(position = position.clone())
    flames.add(flame)
    game.addVisual(flame)
    game.schedule(420, { => self.removeFlame(flame) })
    if (game.onSameCell(player.position(), position)) self.lose()
    self.removeEnemiesAt(position)
    self.collectPowerUpsAt(position)
  }

  method removeFlame(flame) {
    if (flames.contains(flame)) {
      flames.remove(flame)
      game.removeVisual(flame)
    }
  }

  method destroyCrateAt(position) {
    const crate = crates.find({ candidate => game.onSameCell(candidate.position(), position) })
    if (crate != null) {
      crates.remove(crate)
      game.removeVisual(crate)
      if (crate.powerUp() != "none") self.spawnPowerUp(position, crate.powerUp())
    }
  }

  method spawnPowerUp(position, kind) {
    const powerUp = new PowerUp(position = position.clone(), kind = kind)
    powerUps.add(powerUp)
    game.addVisual(powerUp)
  }

  method collectPowerUpsAt(position) {
    const found = powerUps.filter({ powerUp => game.onSameCell(powerUp.position(), position) })
    found.forEach({ powerUp =>
      if (powerUps.contains(powerUp)) {
        powerUps.remove(powerUp)
        game.removeVisual(powerUp)
        if (powerUp.kind() == "range") player.increaseBombRadius()
        if (powerUp.kind() == "speed") player.increaseSpeed()
        game.say(player, if (powerUp.kind() == "range") "¡Alcance aumentado!" else "¡Velocidad aumentada!")
      }
    })
  }

  method removeEnemiesAt(position) {
    const defeated = enemies.filter({ enemy => game.onSameCell(enemy.position(), position) })
    defeated.forEach({ enemy =>
      enemies.remove(enemy)
      game.removeVisual(enemy)
    })
    if (!defeated.isEmpty() && enemies.isEmpty()) game.say(player, "¡Salida abierta! Busca la puerta")
  }

  method moveRoamingEnemies() {
    if (status == "playing") {
      enemies.filter({ enemy => enemy.isRoaming() }).forEach({ enemy =>
        enemy.moveRandomly()
        self.checkEnemyContact(enemy)
      })
    }
  }

  method moveHuntingEnemies() {
    if (status == "playing") {
      enemies.filter({ enemy => !enemy.isRoaming() }).forEach({ enemy =>
        enemy.moveToward(player.position())
        self.checkEnemyContact(enemy)
      })
    }
  }

  method canEnemyEnter(position) =
    self.insideBoard(position) &&
    !self.hasSolidWall(position) &&
    !self.hasCrate(position) &&
    !self.hasBomb(position)

  method checkEnemyContact(enemy) {
    if (game.onSameCell(enemy.position(), player.position())) self.lose()
  }

  method exitIsOpen() = enemies.isEmpty()

  method reachExit() {
    if (status == "playing" && self.exitIsOpen() &&
      game.onSameCell(player.position(), exit.position())) {
      status = "won"
      game.say(player, "¡Ganaste! Presiona R para jugar otra vez")
    }
  }

  method lose() {
    if (status == "playing") {
      status = "lost"
      game.say(player, "¡Te atraparon! Presiona R para reintentar")
    }
  }

  method restart() {
    if (status != "playing") self.startLevel()
  }

  method currentStatus() = status
  method playerPosition() = player.position()
  method remainingEnemies() = enemies.size()
  method numberOfCrates() = crates.size()
  method numberOfPowerUps() = powerUps.size()
  method bombRadius() = player.bombRadius()
  method movesPerKey() = player.movesPerKey()
  method huntingEnemyPosition() =
    enemies.find({ enemy => !enemy.isRoaming() }).position()
  method crateAt(position) = self.hasCrate(position)
  method solidWallAt(position) = self.hasSolidWall(position)
}
