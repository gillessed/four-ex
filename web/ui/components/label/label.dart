part of view;

class Label extends View {
  String label;

  Label(this.label);

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = style.background
      ..beginPath()
      ..rect(0, 0, width, height)
      ..fill();

    if(style.borderColor != null && style.borderThickness != null) {
      context
        ..lineWidth = style.borderThickness
        ..strokeStyle = style.borderColor
        ..beginPath()
        ..rect(0, 0, width, height)
        ..stroke();
    }
    if(style.textAlign == 'middle') {
      context.translate(width / 2, 0);
    } else if(style.textAlign == 'right') {
      context.translate(width, 0);
    }
    if(style.verticalAlign == 'center') {
      context.translate(0, height / 2);
    }
    context
      ..textAlign = style.textAlign
      ..textBaseline = style.verticalAlign
      ..font = '${style.fontSize}px ${style.fontFamily}'
      ..fillText(label, style.paddingLeft ?? 0, 0);
  }
}