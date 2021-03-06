part of space_penguin;

class ListSelectorView<T> extends View {
  static const num OFFSET = 5;
  Selector<T> selector;
  num titleWidth;
  Function itemToString;
  String lineColor;
  String fontColor;
  String font;
  num lineWidth;
  Function onItemChanged;
  
  ListSelectorButton previousButton;
  ListSelectorButton nextButton;
  
  ListSelectorView(
      this.selector,
      this.titleWidth,
      this.itemToString,
      this.lineColor,
      this.fontColor,
      this.font,
      this.lineWidth, {
      this.onItemChanged
      }) {
    previousButton = new ListSelectorButton(
        () {
          T oldValue = selector.current();
          selector.previous();
          T newValue = selector.current();
          if(oldValue != newValue && onItemChanged != null) {
            print(onItemChanged);
            onItemChanged(newValue, oldValue);
          }
        },
        lineWidth,
        lineColor,
        true);
    addChild(
      previousButton,
      new Placement(
        (num parentWidth, num parentHeight) {
          return new Translation((parentWidth - titleWidth) / 2 - parentHeight, 0);
        }, (num parentWidth, num parentHeight) {
          return new Dimension(parentHeight, parentHeight);
    }));
    nextButton = new ListSelectorButton(
        () {
          T oldValue = selector.current();
          selector.next();
          T newValue = selector.current();
          if(oldValue != newValue && onItemChanged != null) {
            print(onItemChanged);
            onItemChanged(newValue, oldValue);
            print('huh');
          }
        },
        lineWidth,
        lineColor,
        false);
    addChild(
      nextButton,
      new Placement(
        (num parentWidth, num parentHeight) {
          return new Translation((parentWidth + titleWidth) / 2, 0);
        }, (num parentWidth, num parentHeight) {
          return new Dimension(parentHeight, parentHeight);
    }));
  }
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..strokeStyle = lineColor
      ..lineWidth = lineWidth
      ..beginPath()
      ..moveTo(0, 0)
      ..lineTo(0, height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..closePath()
      ..fillStyle = 'rgb(0,0,0)'
      ..fill()
      ..stroke();
    context
      ..save()
      ..strokeStyle = lineColor
      ..lineWidth = lineWidth
      ..translate(width / 2, height / 2)
      ..beginPath()
      ..moveTo(-titleWidth / 2, OFFSET - height / 2)
      ..lineTo(titleWidth / 2, OFFSET - height / 2)
      ..lineTo(titleWidth / 2, height / 2 - OFFSET)
      ..lineTo(-titleWidth / 2, height / 2 - OFFSET)
      ..closePath()
      ..stroke()
      ..fillStyle = fontColor
      ..textAlign = 'center'
      ..textBaseline = 'middle'
      ..font = font
      ..fillText(itemToString(selector.current()), 0, 0)
      ..restore();
  }
}

class ListSelectorButton extends Button {

  num borderWidth;
  String borderColor;
  bool left;
  ListSelectorButton(
      Function onClick,
      this.borderWidth,
      this.borderColor,
      this.left) : super(onClick: onClick) {
  }

  Polygon get polygon {
    if(left) {
      return new Polygon([
        new TPoint(ListSelectorView.OFFSET, height / 2),
        new TPoint(width - ListSelectorView.OFFSET, ListSelectorView.OFFSET),
        new TPoint(width - ListSelectorView.OFFSET, height - ListSelectorView.OFFSET)]);
    } else {
      return new Polygon([
        new TPoint(width - ListSelectorView.OFFSET, height / 2),
        new TPoint(ListSelectorView.OFFSET, ListSelectorView.OFFSET),
        new TPoint(ListSelectorView.OFFSET, height - ListSelectorView.OFFSET)]);
    }
  }
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = getFillColor()
      ..strokeStyle = borderColor
      ..lineWidth = borderWidth;
    polygon.drawPath(context);
    context
      ..fill()
      ..stroke();
  }
  
  @override
  bool containsPoint(TPoint point) {
    return polygon.contains(point);
  }
}

abstract class Selector<T> {
  void next();
  T current();
  void previous();
}