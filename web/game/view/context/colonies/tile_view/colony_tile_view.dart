part of game_view;

class ColonyTileView extends View {
  static const num SELECTOR_HEIGHT = 40;

  Function colonyGetter;
  Colony get colony => colonyGetter();
  ListSelectorView selectorView;
  LatticeView latticeView;
  Selector<Surface> surfaceSelector;

  ColonyTileView(this.colonyGetter) {
    surfaceSelector = new IndexSelector<Surface>(() {return colony.getSurfaces();});
    selectorView = new ListSelectorView(
      surfaceSelector,
      300,
      (Surface surface) {return surface.name;},
      colony.system.player.color.color1,
      'rgb(255,255,255)',
      '20px geo',
      2);
    addChild(
      selectorView,
      new Placement(
          Translation.ZERO_F,
          (num parentWidth, num parentHeight) {
            return new Dimension(parentWidth, SELECTOR_HEIGHT);
      })
    );

    latticeView = new LatticeView(() => surfaceSelector.current().lattice);
    addChildAt(
      latticeView,
      Translation.CONSTANT(1, SELECTOR_HEIGHT + 1),
      Dimension.PLUS(-2, - SELECTOR_HEIGHT - 2)
    );
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..lineWidth = 2
      ..strokeStyle = theme.color1
      ..beginPath()
      ..rect(0, 0, width, height)
      ..stroke();
  }
}