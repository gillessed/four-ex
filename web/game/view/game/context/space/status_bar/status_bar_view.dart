part of view;

class StatusBarView extends View {
  static const num STATUS_BAR_HEIGHT = 250;
  
  Game model;
  SpaceContextView spaceContextView;
  
  StatusBarView(this.model, this.spaceContextView);

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
      ..fillStyle = "rgb(200,100,0)"
      ..font = "50px Geo"
      ..textAlign = "center"
      ..fillText("Status Bar", width / 2, height / 2);
  }
}