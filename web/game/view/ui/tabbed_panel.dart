part of view;

enum Layout {
  TOP,
  LEFT
}

class TabbedPanel extends View {
  Player player;
  Map<String, View> panels;
  Map<String, Tab> tabs;
  Tab selectedTab;
  num margin;
  num tabWidth;
  num tabHeight;
  Layout layout;
  TabView tabView;

  TabbedPanel(
      this.player,
      this.panels,
      String firstView,
      this.margin,
      this.tabWidth,
      this.tabHeight,
      this.layout) {
    tabView = new TabView(player, panels[firstView]);
    int x = 0;
    tabs = {};
    panels.forEach((String name, View view) {
      Tab newTab = new Tab(player, name, (Tab tab) {
        selectedTab.selected = false;
        print(tab);
        print(tab.selected);
        tab.selected = true;
        selectedTab = tab;
        tabView.setView(panels[name]);
      });
      tabs[name] = newTab;
      newTab.x = x;
      addChild(
        newTab,
        new Placement(
          (num parentWidth, num parentHeight) {
            return new Translation(newTab.x, margin);
          },
          (num parentWidth, num parentHeight) {
            return new Dimension(tabWidth, tabHeight);
          })
      );
      x += tabWidth;
    });
    selectedTab = tabs[firstView];
    selectedTab.selected = true;

    //TODO: Implement LEFT layout
    addChild(
      tabView,
      new Placement(
        (num parentWidth, num parentHeight) {
          return new Translation(margin, margin + tabHeight);
        },
        (num parentWidth, num parentHeight) {
          return new Dimension(parentWidth - margin * 2, parentHeight - tabHeight - margin * 2);
        })
    );
  }

  void addPanel(String name, View view) {

  }
}

class TabView extends View {
  Player player;
  View view;

  TabView(this.player, this.view) {
    addChild(view, Placement.NO_OP);
  }

  void setView(View newView) {
    _children.replaceSByS(view, newView);
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..strokeStyle = player.color.color2
      ..lineWidth = 2
      ..beginPath()
      ..moveTo(0, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..closePath()
      ..stroke();
  }
}

class Tab extends Button {
  Player player;
  String text;
  bool selected;
  int x;

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
    selected = false;
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
      ..strokeStyle = player.color.color2
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
      onClick(this);
    }
  }
}