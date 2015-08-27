part of view;

class StatusBarView extends View {
  static const num OFFSET = 5;
  static const num STATUS_BAR_HEIGHT = 250;
  static const num MINIMAP_SIZE = STATUS_BAR_HEIGHT - 2 * OFFSET;
  static Dimension MINIMAP_DIMENSIONS = new Dimension(MINIMAP_SIZE, MINIMAP_SIZE);
  
  Game model;
  SpaceContextView spaceContextView;
  MinimapView minimap;
  
  StatusBarView(this.model, this.spaceContextView) {
    minimap = new MinimapView(model, spaceContextView);
    addChild(
      minimap,
      new Placement(
        (num parentWidth, num parentHeight) {
          return new Translation(parentWidth - STATUS_BAR_HEIGHT + OFFSET, OFFSET);
        },
        (num parentWidth, num parentHeight) {
          return MINIMAP_DIMENSIONS;
        }
      )
    );
  }

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