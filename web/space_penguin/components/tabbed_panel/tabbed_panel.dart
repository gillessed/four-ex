part of space_penguin;

enum Layout {
  TOP,
  LEFT
}

class TabbedPanel extends View {
  Map<String, View> panels;
  Map<String, Tab> tabs;
  Tab selectedTab;
  num margin;
  num tabWidth;
  num tabHeight;
  Layout layout;
  TabView tabView;

  TabbedPanel(
      this.panels,
      String firstView,
      this.margin,
      this.tabWidth,
      this.tabHeight,
      this.layout) {
    tabView = new TabView(panels[firstView]);
    int x = 20;
    tabs = {};
    panels.forEach((String name, View view) {
      Tab newTab = new Tab(this, name);
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
    //TODO: Implement this
  }
}

class TabView extends View {
  View view;

  TabView(this.view) {
    addChild(view, Placement.NO_OP);
  }

  void setView(View newView) {
    _children.replaceSByS(view, newView);
    this.view = newView;
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..strokeStyle = theme.color2
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
  TabbedPanel tabbedPanel;
  String name;
  bool selected;
  int x;

  Tab(this.tabbedPanel, this.name) {
    selected = false;
    eventListeners[Event.MOUSE_UP] = (MouseEvent e) {
      tabbedPanel.selectedTab.selected = false;
      selected = true;
      tabbedPanel.selectedTab = this;
      tabbedPanel.tabView.setView(tabbedPanel.panels[name]);
    };
  }

  @override
  String getFillColor() {
    if(selected) {
      return theme.color2Alpha;
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
      ..strokeStyle = theme.color2
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
      ..font = '20px geo'
      ..fillText(name, 0, 0);
  }
}