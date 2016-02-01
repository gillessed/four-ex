part of game_view;

class TechnologyBubble extends View {
  Player player;
  ResearchContextView contextView;
  Technology technology;
  Translation translation;
  List<TechnologyBubble> childrenBubbles = [];
  
  TechnologyBubble(this.player, this.contextView, this.technology, this.translation) {
    listen.on(Event.MOUSE_UP, onMouseUp);
    listen.on(Event.MOUSE_ENTERED, onMouseEntered);
    listen.on(Event.MOUSE_EXITED, onMouseExited);
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    //TODO: Colour in edge technologies?
    if(technology == player.research.currentTechnology) {
      num ratioCompleted = player.research.researchProgress / player.research.currentTechnology.cost;
      context
        ..save()
        ..shadowBlur = 40
        ..shadowOffsetX = 0
        ..shadowOffsetY = 0
        ..shadowColor = player.color.color2;
      _pathRectangle(context, 0, 0, width, height, technology.repeatable);
      context
        ..fillStyle = 'rgb(0, 0, 0)'
        ..fill()
        ..restore();

      context
        ..save();
      _pathRectangle(context, 0, 0, width, height, technology.repeatable);
      context
        ..clip()
        ..beginPath()
        ..moveTo(0, 0)
        ..lineTo(0, height)
        ..lineTo(ratioCompleted * width, height)
        ..lineTo(ratioCompleted * width, 0)
        ..closePath()
        ..globalAlpha = 0.5
        ..fillStyle = player.color.color2
        ..fill()
        ..restore();

      _pathRectangle(context, 0, 0, width, height, technology.repeatable);
      context
        ..strokeStyle = player.color.color1
        ..stroke();
    } else if(player.research.researchedTechnologies.contains(technology)) {
      context
        ..save();
      _pathRectangle(context, 0, 0, width, height, technology.repeatable);
      context
        ..clip()
        ..globalAlpha = 0.5
        ..fillStyle = player.color.color2;
      _pathRectangle(context, 0, 0, width, height, technology.repeatable);
      context
        ..fill()
        ..restore();

      _pathRectangle(context, 0, 0, width, height, technology.repeatable);
      context
        ..strokeStyle = player.color.color1
        ..stroke();
    } else {
      _pathRectangle(context, 0, 0, width, height, technology.repeatable);
      context
        ..strokeStyle = 'rgb(255,255,255)'
        ..stroke();
    }

    String nameText;
    if(technology.repeatable) {
      nameText = '${technology.name} (${player.research.getResearchCount(technology)})';
    } else {
      nameText = technology.name;
    }
    context
      ..fillStyle = 'rgb(255,255,255)'
      ..font = '20px geo'
      ..textAlign = 'center'
      ..textBaseline = 'middle'
      ..fillText(nameText, width / 2, height / 2);
    
    childrenBubbles.forEach((TechnologyBubble child) {
      
      if(player.research.researchedTechnologies.contains(child.technology) ||
          child.technology == player.research.currentTechnology) {
        context.strokeStyle = player.color.color1;
      } else {
        context.strokeStyle = 'rgb(255,255,255)';   
      }
      
      TPoint start = new TPoint(width, height / 2);
      TPoint end = new TPoint(
          child.translation.dx - translation.dx,
          child.translation.dy - translation.dy + height / 2);
      
      context
        ..beginPath()
        ..moveTo(start.x, start.y)
        ..lineTo(end.x, end.y)
        ..stroke();
    });
  }

  void _pathRectangle(
      CanvasRenderingContext2D context,
      num x,
      num y,
      num width,
      num height,
      bool curved) {
    if(!curved) {
      context
        ..beginPath()
        ..moveTo(x, y)
        ..lineTo(x + width, y)
        ..lineTo(x + width, y + height)
        ..lineTo(x, y + height)
        ..closePath();
    } else {
      num radius = height / 2;
      context
        ..beginPath()
        ..moveTo(x + radius, y)
        ..lineTo(x + width - radius, y)
        ..arcTo(x + width, y, x + width, y + radius, radius)
        ..arcTo(x + width, y + height, x + width - radius, y + height, radius)
        ..lineTo(x + radius, y + height)
        ..arcTo(x, y + height, x, y + radius, radius)
        ..arcTo(x, y, x + radius, y, radius);
    }
  }

  void onMouseUp(MouseEvent e) {
    if(player.research.prerequisitesMet(technology) 
        && technology != player.research.currentTechnology) {
      player.research.currentTechnology = technology;
      //TODO: half progress if changing tech choices while unfinished
    }
  }

  void onMouseEntered() {
    contextView.technologyPopup.technology = technology;
    contextView.technologyPopup.bubblePoint = new TPoint(
        translation.dx + width / 2 + contextView.layerTranslation.dx,
        translation.dy + height / 2 + contextView.layerTranslation.dy
        );
    contextView.technologyPopup.isVisible = true;
  }

  void onMouseExited() {
    contextView.technologyPopup.isVisible = false;
  }
}