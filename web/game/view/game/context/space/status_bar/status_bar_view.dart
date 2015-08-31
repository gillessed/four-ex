part of view;

class StatusBarView extends View {
  static const num OFFSET = 5;
  static const num STATUS_BAR_HEIGHT = 250;
  static const num MINIMAP_SIZE = STATUS_BAR_HEIGHT - 2 * OFFSET;
  static Dimension MINIMAP_DIMENSIONS = new Dimension(MINIMAP_SIZE, MINIMAP_SIZE);
  
  Game model;
  SpaceContextView spaceContextView;
  SpaceView spaceView;
  MinimapView minimap;
  SpaceObject selected;
  View selectedView;
  
  StatusBarView(this.model, this.spaceContextView, this.spaceView) {
    minimap = new MinimapView(model, spaceContextView, spaceView);
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
    selected = null;
    selectedView = new BlankStatusView(model);
    addChild(
      selectedView,
      new Placement(
        (num parentWidth, num parentHeight) {
          return new Translation(OFFSET, OFFSET);
        },
        (num parentWidth, num parentHeight) {
          return new Dimension(parentWidth - STATUS_BAR_HEIGHT - OFFSET, STATUS_BAR_HEIGHT - OFFSET);
        }
      )
    );
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..strokeStyle = model.humanPlayer.color
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
  
  void setStatusView(SpaceObject object) {
    if(selected != null && object == null) {
      View newStatusView = new BlankStatusView(model);
      replaceChild(selectedView, newStatusView);
      selected = object;
      selectedView = newStatusView;
    } else if(object != selected) {
      View newStatusView = null;
      if(object is StarSystem) {
        newStatusView = new StarSystemStatusView(model, object, spaceView);
      }
      replaceChild(selectedView, newStatusView);
      selected = object;
      selectedView = newStatusView;
    }
  }
}