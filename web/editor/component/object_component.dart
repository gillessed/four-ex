part of component;

class ObjectComponent extends Component<ObjectSchema> {

  static int LABEL_WIDTH = 300;
  ObjectComponentView table;

  ObjectComponent(ObjectSchema schema) : super(schema) {
    table = new ObjectComponentView();
  }

  @override
  View show() {
    table.style
      ..borderThickness = 2
      ..borderColor = 'rgb(0, 0, 0)';

    schema.fields.forEach((String key, Schema target) {
      Label label = new Label('${key}:');
      label.style
        ..background = 'rgb(255, 255 ,255)'
        ..textColor = 'rgb(0, 0, 0)'
        ..fontFamily = 'helvetica'
        ..fontSize = 16
        ..textAlign = 'left'
        ..verticalAlign = 'middle';

      Component subComponent = Component.createComponent(target);
      View subView = subComponent.show();

      RowView row = new RowView(() => subComponent.computeHeight());
      row.addChildAt(
        label,
        Translation.ZERO_F,
        (num parentWidth, num parentHeight) {
          return new Dimension(LABEL_WIDTH, parentHeight);
        }
      );
      row.addChildAt(
        subView,
        Translation.CONSTANT(LABEL_WIDTH, 0),
        Dimension.PLUS(-LABEL_WIDTH, 0)
      );

      table.addRow(row);
    });

    schema.optionalFields.forEach((String key, Schema target) {

    });

    return table;
  }

  @override
  int computeHeight() {
    return table.computeHeight();
  }
}

class ObjectComponentView extends View {
  static final int PADDING = 5;
  int offset = 10;
  List<RowView> _rows;
  Function sumFunction;

  ObjectComponentView() {
    _rows = [];
    sumFunction = (var value, RowView nextRow) => value + nextRow.computeHeight() + offset;
  }

  void addRow(RowView row) {
    _rows.add(row);
    addChildAt(
      row,
      (num parentWidth, num parentHeight) {
        if(_rows.indexOf(row) == 0) {
          return new Translation(PADDING, PADDING);
        } else {
          int sum = _rows.getRange(0, _rows.indexOf(row)).fold(0, sumFunction) + PADDING;
          return new Translation(PADDING, sum);
        }
      },
      (num parentWidth, num parentHeight) {
        return new Dimension(parentWidth - 2 * PADDING, row.computeHeight());
      }
    );
  }

  void removeRow(RowView row) {
    _rows.remove(row);
  }

  void removeRowAt(int index) {
    removeRow(_rows[index]);
  }

  int computeHeight() => _rows.fold(0, sumFunction) + PADDING;

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    if(style.borderColor != null && style.borderThickness != null) {
      context
        ..lineWidth = style.borderThickness
        ..strokeStyle = style.borderColor
        ..beginPath()
        ..rect(0, 0, width, height)
        ..stroke();
    }
  }
}

class RowView extends View {
  Function heightFunction;
  RowView(this.heightFunction);

  int computeHeight() => heightFunction();
}