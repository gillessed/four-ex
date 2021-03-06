part of game_view;

class SpaceContextButton extends ContextButton {

  SpaceContextButton(Game model, GameView gameView, ContextView contextView)
      : super(model, gameView, contextView);

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = getFillColour()
      ..strokeStyle = model.humanPlayer.color.color1
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
