extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
  String id() => split('@')[0];
  String firstName() => split(' ').elementAt(0);
  String cardID() =>
      '${substring(0, 4)} ${substring(4, length - 4).toUpperCase()} ${substring(length - 4, length)}';
}

String truncateStatus(String? userString) {
  if (userString != null && userString.length > 18) {
    return userString.substring(0, 18) + '...';
  }
  return userString ?? '';
}