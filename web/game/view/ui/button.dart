part of view;

abstract class Button extends View {
  
  Function onClick;

  String defaultFillColor;
  String hoverFillColor;
  String clickFillColor;
  
  String defaultStrokeColor;
  String hoverStrokeColor;
  String clickStrokeColor;
  
  Button(
      this.onClick,{
      this.defaultFillColor,
      this.hoverFillColor,
      this.clickFillColor,
      this.defaultStrokeColor,
      this.hoverStrokeColor,
      this.clickStrokeColor});
  
  String getFillColor() {
    if (View.hoveredViews.last == this) {
      if (View.mouse0Down) {
        return clickFillColor;
      } else {
        return hoverFillColor;
      }
    } else {
      return defaultFillColor;
    }
  }

  String getStrokeColor() {
    if (View.hoveredViews.last == this) {
      if (View.mouse0Down) {
        return clickStrokeColor;
      } else {
        return hoverStrokeColor;
      }
    } else {
      return defaultStrokeColor;
    }
  }
  
  @override 
  void doMouseUp(MouseEvent e) {
    onClick();
  }
}