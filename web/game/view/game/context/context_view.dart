part of view;

abstract class ContextView extends View {
  Game model;
  ContextButton getContextButton();
  ContextView(this.model);
}