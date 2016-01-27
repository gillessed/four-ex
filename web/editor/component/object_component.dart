part of component;

class ObjectComponent extends Component<ObjectSchema> {
  ObjectComponent(ObjectSchema schema) : super(schema);

  @override
  Element show() {
    TableElement table = new TableElement();
    table.classes = ['object-table'];

    schema.fields.forEach((String key, Schema target) {
      TableRowElement row = new TableRowElement();
      row.classes = ['object-row'];

      TableCellElement cell1 = _generateLabelCell(key);
      row.children.add(cell1);

      TableCellElement cell2 = _generateChildContainerCell(target, 2);
      row.children.add(cell2);
      table.children.add(row);
    });

    schema.optionalFields.forEach((String key, Schema target) {
      TableRowElement row = new TableRowElement();
      row.classes = ['object-row'];

      TableCellElement cell1 = _generateLabelCell(key.substring(0, key.length - 1));
      row.children.add(cell1);

      TableCellElement cell2 = _generateChildContainerCell(target, 1);
      row.children.add(cell2);

      TableCellElement cell3 = _generateDeleteOptionalButtonCell(target);
      row.children.add(cell3);

      table.children.add(row);
    });

    return createPanel(table);
  }

  TableCellElement _generateLabelCell(String key) {
    LabelElement label = new LabelElement();
    label.innerHtml = '${key}: ';
    TableCellElement cell = new TableCellElement();
    cell.classes = ['object-label-cell'];
    cell.children.add(label);
    return cell;
  }

  TableCellElement _generateChildContainerCell(Schema target, int colspan) {
    Element childContainer = Component.createComponent(target).show();
    if(childContainer is DivElement) {
      childContainer.classes.add('object-child-container');
    }
    TableCellElement cell = new TableCellElement();
    cell.classes = ['object-value-container'];
    cell.children.add(childContainer);
    cell.colSpan = colspan;
    return cell;
  }

  TableCellElement _generateDeleteOptionalButtonCell(Schema target) {
    SpanElement span = new SpanElement();
    span.classes = ['glyphicon', 'glyphicon-remove'];
    ButtonElement button = new ButtonElement()..classes = ['btn', 'btn-danger'];
    button.children.add(span);
    TableCellElement cell = new TableCellElement()..classes = ['delete-optional-object'];
    cell.children.add(button);
    return cell;
  }
}