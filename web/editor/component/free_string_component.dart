part of component;

class FreeStringComponent extends Component<StringSchema> {

  FreeStringComponent(StringSchema schema) : super(schema);

  @override
  Element show() {
    InputElement input = new InputElement();
    input.value = schema.value;
    input.type = 'text';
    input.style.width = '200px';
    return input;
  }
}