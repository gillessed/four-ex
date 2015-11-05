part of view;

enum Quadrant {
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT
}

class TechnologyPopup extends View {
  static const num WIDTH = 400;
  static const num HEIGHT = 400;
  static const num ARROW_WIDTH = 40;
  static const num ARROW_HEIGHT = 20;
  static const num MARGIN = 10;
  static const num LINE_HEIGHT = 24;
  static const num BASELINE = 16;
  
  Player player;
  Technology technology;
  Quadrant mouseQuadrant = Quadrant.TOP_LEFT;
  TPoint bubblePoint;
  
  TechnologyPopup(this.player) {
    isVisible = false;
    isTransparent = true;
  }
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.translate(bubblePoint.x, bubblePoint.y);
    context.strokeStyle = player.color.color1;
    context.lineWidth = 2;
    context.fillStyle = 'rgb(0,0,0)';
    context.globalAlpha = 1;
    switch (mouseQuadrant) {
      case Quadrant.TOP_LEFT:
        context
          ..beginPath()
          ..moveTo(0, 0)
          ..lineTo(ARROW_WIDTH + WIDTH, 0)
          ..lineTo(ARROW_WIDTH + WIDTH, HEIGHT)
          ..lineTo(ARROW_WIDTH, HEIGHT)
          ..lineTo(ARROW_WIDTH, ARROW_HEIGHT)
          ..closePath()
          ..fill()
          ..stroke()
          ..translate(ARROW_WIDTH, 0);
        break;
      case Quadrant.TOP_RIGHT:
        context
          ..beginPath()
          ..moveTo(0, 0)
          ..lineTo(-ARROW_WIDTH - WIDTH, 0)
          ..lineTo(-ARROW_WIDTH - WIDTH, HEIGHT)
          ..lineTo(-ARROW_WIDTH, HEIGHT)
          ..lineTo(-ARROW_WIDTH, ARROW_HEIGHT)
          ..closePath()
          ..fill()
          ..stroke()
          ..translate(-ARROW_WIDTH - WIDTH, 0);
        break;
      case Quadrant.BOTTOM_LEFT:
        context
          ..beginPath()
          ..moveTo(0, 0)
          ..lineTo(ARROW_WIDTH + WIDTH, 0)
          ..lineTo(ARROW_WIDTH + WIDTH, -HEIGHT)
          ..lineTo(ARROW_WIDTH, -HEIGHT)
          ..lineTo(ARROW_WIDTH, -ARROW_HEIGHT)
          ..closePath()
          ..fill()
          ..stroke()
          ..translate(ARROW_WIDTH, -HEIGHT);
        break;
      case Quadrant.BOTTOM_RIGHT:
        context
          ..beginPath()
          ..moveTo(0, 0)
          ..lineTo(-ARROW_WIDTH - WIDTH, 0)
          ..lineTo(-ARROW_WIDTH - WIDTH, -HEIGHT)
          ..lineTo(-ARROW_WIDTH, -HEIGHT)
          ..lineTo(-ARROW_WIDTH, -ARROW_HEIGHT)
          ..closePath()
          ..fill()
          ..stroke()
          ..translate(-ARROW_WIDTH - WIDTH, -HEIGHT);
        break;
    }

    context
      ..lineWidth = 1
      ..translate(WIDTH / 2, 35)
      ..fillStyle = 'rgb(255,255,255)'
      ..font = '30px geo'
      ..textAlign = 'center'
      ..fillText(technology.name, 0, 0);

    String subText = '';
    if (technology == player.research.currentTechnology) {
      subText = 'Progress: ${player.research.researchProgress} / ${technology.cost}';
    } else if (player.research.researchedTechnologies.contains(technology)) {
      subText = 'Researched';
    } else {
      subText = 'Undiscovered: 0 / ${technology.cost}';
    }
    context
      ..translate(0, 20)
      ..fillStyle = 'rgb(255,255,255)'
      ..font = '20px geo'
      ..textAlign = 'center'
      ..fillText(subText, 0, 0);

    context
      ..translate(-WIDTH / 2, 20)
      ..fillStyle = 'rgb(255,255,255)'
      ..font = '20px geo';
    int lines = Paragraph.drawParagraph(
        context,
        technology.description,
        Justification.CENTER,
        MARGIN,
        0,
        WIDTH - 4 * MARGIN,
        LINE_HEIGHT);
    context
      ..strokeStyle = 'rgb(255, 255, 255)'
      ..beginPath()
      ..moveTo(MARGIN, 0)
      ..lineTo(WIDTH - MARGIN, 0)
      ..lineTo(WIDTH - MARGIN, lines * LINE_HEIGHT + BASELINE)
      ..lineTo(MARGIN, lines * LINE_HEIGHT + BASELINE)
      ..closePath()
      ..stroke();

    if(technology.staticBonuses.isNotEmpty) {
      context.translate(0, lines* LINE_HEIGHT + BASELINE + MARGIN);
      context.textAlign = 'left';
      int bonuses = technology.staticBonuses.length;
      technology.staticBonuses.forEach((Bonus bonus) {
        context.fillText(bonus.humanReadableString(), 2 * MARGIN, LINE_HEIGHT);
      });
      context
        ..strokeStyle = 'rgb(255, 255, 255)'
        ..beginPath()
        ..moveTo(MARGIN, 0)
        ..lineTo(WIDTH / 2 - MARGIN / 2, 0)
        ..lineTo(WIDTH / 2 - MARGIN / 2, bonuses * LINE_HEIGHT + BASELINE)
        ..lineTo(MARGIN, bonuses * LINE_HEIGHT + BASELINE)
        ..closePath()
        ..stroke();
    }
  }
}