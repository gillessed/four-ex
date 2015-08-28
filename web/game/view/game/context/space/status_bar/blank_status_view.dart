part of view;

class BlankStatusView extends View {
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..strokeStyle = HudBar.HUD_COLOUR
      ..fillStyle = 'rgb(0,0,0)'
      ..lineWidth = 2;
    
    context
      ..beginPath()
      ..moveTo(0, 0)
      ..lineTo(0, height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..closePath()
      ..fill()
      ..stroke();
    
    context
      ..fillStyle = "rgb(50,13,0)"
      ..font = "50px Geo"
      ..textAlign = "center"
      ..fillText("STATUS", width / 2, height / 2);
  }  
}