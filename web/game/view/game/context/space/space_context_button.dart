part of view;

class SpaceContextButton extends ContextButton {

  SpaceContextButton(GameView gameView, ContextView contextView)
      : super(gameView, contextView);

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = getFillColour()
      ..strokeStyle = HudBar.HUD_COLOUR
      ..lineWidth = 2;

    polygon.drawPath(context);
    context
      ..fill()
      ..stroke();
    
    context.save();
    context.translate(width / 2, height / 2);
    Icons.drawRingedPlanetIcon(context, ContextButton.SIZE / 2 - 5, getForegroundColour(), getFillColour(), 2, 2);
    context.restore();
  }
}
