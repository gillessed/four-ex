part of view;

class TabbedPanel extends View {
  Map<String, View> panels;
  num margin;

  TabbedPanel(this.panels, this.margin);
}