part of view;

class GameView extends View {
  
  Game model;
  HudBar hudBar;
  
  GameView(this.model) {
    hudBar = new HudBar(model);
    addChild(
      hudBar,
      new Placement(
        Translation.ZERO_F,
        (parentWidth, parentHeight) {
          return new Dimension(parentWidth, HudBar.TITLE_BAR_HEIGHT + TurnButton.DEPTH);
    }));
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.save();
    context..strokeStyle = HudBar.HUD_COLOUR
           ..lineWidth = 2;
    
    context..beginPath()
           ..moveTo(1, 1)
           ..lineTo(width - 1, 1)
           ..lineTo(width - 1, height - 1)
           ..lineTo(1, height - 1)
           ..closePath()
           ..stroke();
     
    context.restore();
  }

  @override
  bool containsPoint(TPoint point) {
    return true;
  }
}