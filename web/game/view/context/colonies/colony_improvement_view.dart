part of game_view;

class ColonyImprovementsView extends View {
  static final MARGIN = 20;
  static final TILE_STATUS_HEIGHT = 300;
  static final IMPROVEMENT_LIST_WIDTH = 400;

  Function colonyGetter;
  Colony get colony => colonyGetter();
  ColonyTileView colonyTileView;
  ImprovementListView improvementListView;
  BuildQueueView buildQueueView;
  ShipListView shipListView;
  ShipQueueView shipQueueView;

  ColonyImprovementsView(this.colonyGetter) {
    colonyTileView = new ColonyTileView(colonyGetter);
    addChildAt(
      colonyTileView,
      Translation.CONSTANT(IMPROVEMENT_LIST_WIDTH, 5 + 30),
      (num parentWidth, num parentHeight) {
        return new Dimension(parentWidth - 2 * IMPROVEMENT_LIST_WIDTH, parentHeight - TILE_STATUS_HEIGHT - MARGIN - 5 - 30);
      }
    );

    createImprovementListView();
    createBuildQueueView();
    createShipListView();
    createShipQueueView();
  }

  void createImprovementListView() {
    improvementListView = new ImprovementListView();
    VerticalScrollView scrollView = new VerticalScrollView(improvementListView, improvementListView.computeHeight);
    TitleView titleView = new TitleView('Improvements', scrollView);

    addChildAt(
      titleView,
      Translation.CONSTANT(MARGIN, 5),
      (num parentWidth, num parentHeight) {
        return new Dimension(IMPROVEMENT_LIST_WIDTH - MARGIN * 2, parentHeight - TILE_STATUS_HEIGHT - MARGIN - 5);
      }
    );
  }

  void createBuildQueueView() {
    buildQueueView = new BuildQueueView();
    VerticalScrollView scrollView = new VerticalScrollView(buildQueueView, buildQueueView.computeHeight);
    TitleView titleView = new TitleView('Build Queue', scrollView);

    addChildAt(
      titleView,
      (num parentWidth, num parentHeight) {
        return new Translation(MARGIN, parentHeight - TILE_STATUS_HEIGHT);
      },
      (num parentWidth, num parentHeight) {
        return new Dimension(IMPROVEMENT_LIST_WIDTH - MARGIN * 2, TILE_STATUS_HEIGHT - MARGIN);
      }
    );
  }

  void createShipListView() {
    ShipListView shipListView = new ShipListView();
    VerticalScrollView scrollView = new VerticalScrollView(shipListView, shipListView.computeHeight);
    TitleView titleView = new TitleView('Ships', scrollView);

    addChildAt(
      titleView,
      (num parentWidth, num parentHeight) {
        return new Translation(parentWidth - IMPROVEMENT_LIST_WIDTH + MARGIN, 5);
      },
      (num parentWidth, num parentHeight) {
        return new Dimension(IMPROVEMENT_LIST_WIDTH - MARGIN * 2, parentHeight - TILE_STATUS_HEIGHT - MARGIN - 5);
      }
    );
  }

  void createShipQueueView() {
    shipQueueView = new ShipQueueView();
    VerticalScrollView scrollView = new VerticalScrollView(shipQueueView, shipQueueView.computeHeight);
    TitleView titleView = new TitleView('Ship Queue', scrollView);

    addChildAt(
      titleView,
      (num parentWidth, num parentHeight) {
        return new Translation(parentWidth - IMPROVEMENT_LIST_WIDTH + MARGIN, parentHeight - TILE_STATUS_HEIGHT);
      },
      (num parentWidth, num parentHeight) {
        return new Dimension(IMPROVEMENT_LIST_WIDTH - MARGIN * 2, TILE_STATUS_HEIGHT - MARGIN);
      }
    );
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = theme.color2Alpha
      ..beginPath()
      ..rect(0, 0, width, height)
      ..fill();
  }
}
