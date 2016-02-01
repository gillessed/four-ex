part of space_penguin;

enum Justification {
  LEFT,
  CENTER,
  RIGHT
}

class Paragraph {
  static int drawParagraph(
      CanvasRenderingContext2D context,
      String text,
      Justification justification,
      num x,
      num y,
      num width,
      num lineHeight) {
    context.save();
    switch(justification) {
      case Justification.LEFT:
        context.textAlign = 'left';
        context.translate(x, y);
        break;
      case Justification.RIGHT:
        context.textAlign = 'right';
        context.translate(x + width, y);
        break;
      case Justification.CENTER:
        context.textAlign = 'center';
        context.translate(x + width / 2, y);
        break;
    }
    List<String> words = text.split(' ');
    List<List<String>> lines = [];
    while(words.isNotEmpty) {
      lines.add([]);
      while(words.isNotEmpty) {
        lines.last.add(words.first);
        String line = buildLine(lines.last);
        TextMetrics metrics = context.measureText(line);
        if(metrics.width > width) {
          lines.last.removeLast();
          if(lines.last.isEmpty) {
            throw new StateError('Paragraph width is too small. Cannot render.');
          }
          break;
        } else {
          words.removeAt(0);
        }
      }
    }
    for(List<String> line in lines) {
      context.translate(0, lineHeight);
      String text = buildLine(line);
      context.fillText(text, 0, 0);
    }
    context.restore();
    return lines.length;
  }

  static String buildLine(List<String> words) {
    String line = '';
    for(int i = 0; i < words.length; i++) {
      line += words[i];
      if(i < words.length - 1) {
        line += ' ';
      }
    }
    return line;
  }
}