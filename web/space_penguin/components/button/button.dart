part of space_penguin;

abstract class Button extends View {

  String defaultFillColor;
  String hoverFillColor;
  String clickFillColor;
  
  String defaultStrokeColor;
  String hoverStrokeColor;
  String clickStrokeColor;
  
  Button({Function onClick}) {
    if(onClick != null) {
      eventListeners[Event.MOUSE_UP] = (MouseEvent e) {onClick();};
    }
  }
  
  String getFillColor() {
    if (mouseHover) {
      if (View.mouse0Down) {
        return 'rgb(255,255,255)';
      } else {
        return 'rgb(50,50,50)';
      }
    } else {
      return 'rgb(0,0,0)';
    }
  }

  String getStrokeColor() {
    if (mouseHover) {
      if (View.mouse0Down) {
        return 'rgb(0,0,0)';
      } else {
        return 'rgb(255,255,255)';
      }
    } else {
      return theme.color2;
    }
  }
}