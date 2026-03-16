
extension StringExtension on String {
  bool get isEmail {
    if (isEmpty) return false;
    final regex = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return regex.hasMatch(this);
  }
}