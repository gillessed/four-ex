part of view;

class TechnologyBubble extends View {
  Player player;
  ResearchContextView contextView;
  Technology technology;
  Translation translation;
  List<TechnologyBubble> childrenBubbles = [];
  
  TechnologyBubble(this.player, this.contextView, this.technology, this.translation);

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    //TODO: Colour in edge technologies?
    if(technology == player.research.currentTechnology) {
      context
        ..save()
        ..fillStyle = 'rgb(0,0,0)'
        ..strokeStyle = player.color.color1
        ..shadowBlur = 40
        ..shadowOffsetX = 0
        ..shadowOffsetY = 0
        ..shadowColor = player.color.color2
        ..beginPath()
        ..moveTo(0, 0)
        ..lineTo(0, height)
        ..lineTo(width, height)
        ..lineTo(width, 0)
        ..closePath()
        ..fill()
        ..stroke()
        ..restore();
    } else if(player.research.researchedTechnologies.contains(technology)) {
      context
        ..save()
        ..globalAlpha = 0.5
        ..fillStyle = player.color.color2
        ..beginPath()
        ..moveTo(0, 0)
        ..lineTo(0, height)
        ..lineTo(width, height)
        ..lineTo(width, 0)
        ..closePath()
        ..fill()
        ..restore();
      
      context
        ..strokeStyle = player.color.color1
        ..beginPath()
        ..moveTo(0, 0)
        ..lineTo(0, height)
        ..lineTo(width, height)
        ..lineTo(width, 0)
        ..closePath()
        ..stroke();
    } else {
      context
        ..strokeStyle = 'rgb(255,255,255)'
        ..beginPath()
        ..moveTo(0, 0)
        ..lineTo(0, height)
        ..lineTo(width, height)
        ..lineTo(width, 0)
        ..closePath()
        ..stroke();
    }
    
    context
      ..fillStyle = 'rgb(255,255,255)'
      ..font = '20px geo'
      ..textAlign = 'center'
      ..textBaseline = 'middle'
      ..fillText(technology.name, width / 2, height / 2);
    
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
  
  @override
  void doMouseUp(MouseEvent e) {
    if(player.research.prerequisitesMet(technology) 
        && technology != player.research.currentTechnology) {
      player.research.currentTechnology = technology;
      //TODO: half progress if changing tech choices while unfinished
    }
  }

  @override
  void doMouseEntered() {
    contextView.technologyPopup.technology = technology;
    contextView.technologyPopup.bubblePoint = new TPoint(
        translation.dx + width / 2,
        translation.dy + height / 2
        );
    contextView.technologyPopup.isVisible = true;
  }

  @override
  void doMouseExited() {
    print('Exited');
    contextView.technologyPopup.isVisible = false;
  }
}