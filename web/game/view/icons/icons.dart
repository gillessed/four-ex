part of view;

class Icons {

  static void drawRingedPlanetIcon(
      CanvasRenderingContext2D context,
      num radius,
      String strokeColor,
      String fillColor,
      num planetLineWidth,
      num ringLineWidth) {
    context
      ..save()
      ..strokeStyle = strokeColor
      ..fillStyle = fillColor
      ..lineWidth = planetLineWidth
      ..beginPath()
      ..arc(0, 0, radius, 0, 2 * 3.14159)
      ..fill()
      ..stroke()
      ..save()
      ..lineWidth = ringLineWidth
      ..beginPath()
      ..rotate(-3.14159 / 4)
      ..scale(1.5, 0.5)
      ..arc(0, 0, radius, 0, 2 * 3.14159)
      ..stroke()
      ..restore()
      ..save()
      ..beginPath()
      ..rotate(-3.14159 / 4)
      ..arc(0, 0, radius, 3.14159, 2 * 3.14159)
      ..fill()
      ..stroke()
      ..restore()
      ..restore();
  }
}