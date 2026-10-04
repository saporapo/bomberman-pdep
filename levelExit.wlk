import example.bombermanGame

class LevelExit {
  const property position

  method image() =
    if (bombermanGame.exitIsOpen()) "exit-open.png" else "exit-closed.png"
}
