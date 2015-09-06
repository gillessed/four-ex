part of view;

abstract class Icon {
  void draw(CanvasRenderingContext2D context);
}

class Icons {

  static void drawStar(
      CanvasRenderingContext2D context,
      StarSystem starSystem,
      num radius,
      num shadowBlur) {

    context.save();
    var star1grd = context.createRadialGradient(0, 0, 0.01 * radius, 0, 0, 0.99 * radius);
    star1grd.addColorStop(0, starSystem.star.gradient0);
    star1grd.addColorStop(1, starSystem.star.gradient1);
    context
      ..fillStyle = star1grd
      ..beginPath()
      ..arc(0, 0, radius, 0, 2 * 3.14159)
      ..shadowColor = starSystem.star.gradient1
      ..shadowBlur = shadowBlur
      ..shadowOffsetX = 0
      ..shadowOffsetY = 0
      ..fill();
    context.restore();
  }
  
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