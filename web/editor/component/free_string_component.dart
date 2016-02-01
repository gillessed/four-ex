part of component;

class FreeStringComponent extends Component<StringSchema> {

  FreeStringComponent(StringSchema schema) : super(schema);

  @override
  View show() {
    Input input = new Input();
    input.value = schema.value;
    input.style
      ..background = 'rgb(255, 255, 255)'
      ..textColor = 'rgb(0, 0, 0)'
      ..fontFamily = 'helvetica'
      ..fontSize = 16
      ..textAlign = 'center'
      ..verticalAlign = 'middle';
    return input;
  }

  @override
  int computeHeight() {
    return 32;
  }
}