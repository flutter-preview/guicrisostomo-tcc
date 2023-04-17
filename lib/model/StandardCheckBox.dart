class CheckBoxList {
  String value;
  String? description;
  bool isChecked;

  CheckBoxList({
    required this.value,
    this.description,
    this.isChecked = false,
  });
}