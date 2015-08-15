library canvas;

import "dart:html";
import "dart:async";

class Canvas {
  static const backgroundColor = "#000000";
  
  CanvasElement canvas;
  var doDraw;
  int width;
  int height;
  
  Canvas(this.canvas, this.doDraw);
  
  start() {
    window.addEventListener('resize', resizeCanvas, false);
    canvas.addEventListener('click', requestRedraw);
    const oneSec = const Duration(milliseconds:20);
    new Timer.periodic(oneSec, requestRedraw);
    resizeCanvas(null);
  }
  
  stop() {
    window.removeEventListener('resize', resizeCanvas);
    canvas.removeEventListener('click', requestRedraw);
  }
  
  void draw([_]) {
    var context = canvas.context2D;
    
    context..fillStyle = backgroundColor
           ..strokeStyle = backgroundColor
           ..fillRect(0, 0, width, height);
    
    doDraw(context, width, height);
  }

  void resizeCanvas(_) {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    width = canvas.width;
    height = canvas.height;
    requestRedraw(null);
  }
  
  void requestRedraw(_) {
    window.requestAnimationFrame(draw);
  }
}
