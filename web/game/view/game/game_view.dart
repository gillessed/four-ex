part of view;

class GameView extends View {
  
  static const String HUD_COLOUR = "rgb(0,0,256)";
  static const num TITLE_BAR_HEIGHT = 30;
  
  Game model;
  
  TurnButton turnButton;
  
  GameView(this.model) {
    turnButton = new TurnButton(model);
  }

  @override
  void drawComponent(CanvasRenderingContext2D context, double width, double height) {
    context.save();
    context..strokeStyle = HUD_COLOUR
           ..lineWidth = 2;
    
    context..beginPath()
           ..moveTo(1, 1)
           ..lineTo(width - 1, 1)
           ..lineTo(width - 1, height - 1)
           ..lineTo(1, height - 1)
           ..closePath()
           ..stroke();
    
    context..beginPath()
           ..moveTo(1, 1)
           ..lineTo(width - 1, 1)
           ..lineTo(width - 1, TITLE_BAR_HEIGHT)
           ..lineTo(width / 2 + TurnButton.BEVEL_WIDTH / 2, TITLE_BAR_HEIGHT)
           ..lineTo(width / 2 + TurnButton.BEVEL_WIDTH / 2 - TurnButton.DEPTH, TITLE_BAR_HEIGHT + TurnButton.DEPTH)
           ..lineTo(width / 2 - TurnButton.BEVEL_WIDTH / 2 + TurnButton.DEPTH, TITLE_BAR_HEIGHT + TurnButton.DEPTH)
           ..lineTo(width / 2 - TurnButton.BEVEL_WIDTH / 2, TITLE_BAR_HEIGHT)
           ..lineTo(1, TITLE_BAR_HEIGHT)
           ..lineTo(1, 0)
           ..stroke();
    
    turnButton.draw(context, width, height);
     
    context.restore();
  }
}