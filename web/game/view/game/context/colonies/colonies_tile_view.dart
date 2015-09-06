part of view;

class ColoniesTileView extends View {
  Colony colony;
  ColoniesTileView(this.colony);
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..strokeStyle = colony.player.color.color2
      ..lineWidth = 2
      ..beginPath()
      ..moveTo(0, 0)
      ..lineTo(0, height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..closePath()
      ..stroke();
    
    context
      ..font = '20px geo'
      ..fillStyle = 'rgb(255,255,255)'
      ..fillText('${colony.planet.name}', 60, 60);
    
    context.translate(100, 100);
    _getHexagon(50).drawPath(context);
    context.stroke();
  }
  
  Polygon _getHexagon(int radius) {
    num y = sqrt(3) / 2 * radius;
    return new Polygon([
      new TPoint(-radius, 0),
      new TPoint(-radius/2, y),
      new TPoint(radius/2, y),
      new TPoint(radius, 0),
      new TPoint(radius/2, -y),
      new TPoint(-radius/2, -y)]);
  }
}