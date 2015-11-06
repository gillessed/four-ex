part of view;

class TabbedPanel extends View {
  Player player;
  Map<String, View> panels;
  num margin;

  TabbedPanel(this.player, this.panels, String firstView, this.margin) {
    panels.forEach((String name, View view) {
       
    });
  }

  void addPanel(String name, View view) {

  }
}

class TabView extends View {
  Player player;
  View view;

  TabView(this.player, this.view);

  void setView(View view) {

  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {

  }
}

class Tab extends Button {
  Player player;
  String text;
  bool selected;

  Tab(Player player, this.text, Function onClick) : super(
      onClick,
      defaultFillColor: 'rgb(0, 0, 0)',
      hoverFillColor: 'rgb(50,50,50)',
      clickFillColor: 'rgb(255, ,255, 255)',
      defaultStrokeColor: player.color.color2,
      hoverStrokeColor: 'rgb(255, 255, 255)',
      clickStrokeColor: 'rgb(0, 0, 0)'
  ) {
    this.player = player;
  }

  @override
  String getFillColor() {
    if(selected) {
      return 'rgb(0, 0, 0)';
    } else {
      return super.getFillColor();
    }
  }

  String getStrokeColor() {
    if(selected) {
      return 'rgb(255, 255, 255)';
    } else {
      return super.getStrokeColor();
    }
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..strokeStyle = player.color.color1
      ..fillStyle = getFillColor()
      ..lineWidth = 2
      ..beginPath()
      ..moveTo(0, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..closePath()
      ..fill()
      ..stroke();

    context
      ..translate(width / 2, height / 2)
      ..fillStyle = getStrokeColor()
      ..textAlign = 'center'
      ..textBaseline = 'middle'
      ..fillText(text, 0, 0);
  }

  @override
  void doMouseUp(MouseEvent e) {
    if(!selected) {
      onClick();
    }
  }
}