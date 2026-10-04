class PowerUp {
  const property position
  const property kind

  method image() =
    if (kind == "range") "power-range.png" else "power-speed.png"
}
