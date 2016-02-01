library canvas;

import "dart:html";

class Canvas {
  static const backgroundColor = "#000000";
  
  CanvasElement canvas;
  var doDraw;
  int width;
  int height;
  bool cancelAnimation = false;
  
  Canvas(this.canvas, this.doDraw);
  
  start() {
    window.addEventListener('resize', resizeCanvas, false);
    resizeCanvas(null);
    requestRedraw();
  }
  
  stop() {
    cancelAnimation = true;
  }
  
  void draw([_]) {
    var context = canvas.context2D;
    
    context..fillStyle = backgroundColor
           ..strokeStyle = backgroundColor
           ..fillRect(0, 0, width, height);
    
    doDraw(context, width, height);
    if(!cancelAnimation) {
      requestRedraw();
    }
  }

  void resizeCanvas(_) {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    width = canvas.width;
    height = canvas.height;
  }
  
  void requestRedraw() {
    window.requestAnimationFrame(draw);
  }
}
