part of game_view;

class HudBar extends View {
  
  static const num HUD_BAR_HEIGHT = 40;
  static const num CONTEXT_BUTTON_OFFSET = 30;
  static const num CONTEXT_BUTTON_MID_OFFSET = (TurnButton.BEVEL_WIDTH + TurnButton.HEIGHT) / 2 + CONTEXT_BUTTON_OFFSET;
  
  Polygon get polygon {
    return new Polygon([
      new TPoint(1, 1),
      new TPoint(width - 1, 1),
      new TPoint(width - 1, HUD_BAR_HEIGHT),
      new TPoint(width / 2 + TurnButton.BEVEL_WIDTH / 2, HUD_BAR_HEIGHT),
      new TPoint(width / 2 + TurnButton.BEVEL_WIDTH / 2 - TurnButton.DEPTH, HUD_BAR_HEIGHT + TurnButton.DEPTH),
      new TPoint(width / 2 - TurnButton.BEVEL_WIDTH / 2 + TurnButton.DEPTH, HUD_BAR_HEIGHT + TurnButton.DEPTH),
      new TPoint(width / 2 - TurnButton.BEVEL_WIDTH / 2, HUD_BAR_HEIGHT),
      new TPoint(1, HUD_BAR_HEIGHT)
    ]);
  }
  TurnButton turnButton;
  GameView parent;
  Game model;
  
  HudBar(this.model, GameView gameView) {
    turnButton = new TurnButton(model);
    addChild(
      turnButton,
      new Placement(
        (num parentWidth, num parentHeight) {
          return new Translation(parentWidth / 2, TurnButton.OFFSET);
        },
        (num parentWidth, num parentHeight) {
          return new Dimension(0, 0);
        }
      ));
    
    int i = gameView.contextViews.length;
    gameView.contextViews.forEach((contextView) {
      ContextButton button = contextView.getContextButton();
      button.index = i;
      this.addChild(
        button,
        new Placement(
          (num parentWidth, num parentHeight) {
            return new Translation(parentWidth / 2 - CONTEXT_BUTTON_MID_OFFSET - button.index * HUD_BAR_HEIGHT, ContextButton.OFFSET);
          },
          (num parentWidth, num parentHeight) {
            return new Dimension(ContextButton.SIZE, ContextButton.SIZE);
          }
        ));
      i--;
    });
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.save();
    context
      ..strokeStyle = model.humanPlayer.color.color1
      ..fillStyle = 'rgb(0,0,0)'
      ..lineWidth = 2;
    
    context
      ..beginPath()
      ..moveTo(1, 1)
      ..lineTo(width - 1, 1)
      ..lineTo(width - 1, height - 1)
      ..lineTo(1, height - 1)
      ..closePath()
      ..stroke();
    
    context..beginPath();
    polygon.drawPath(context);
    context
      ..fill()
      ..stroke();
     
    context.restore();
  }

  @override
  bool containsPoint(TPoint point) {
    return polygon.contains(point);
  }
}