extension StringExtension on String {
  String inCaps() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}