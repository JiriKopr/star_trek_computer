import 'package:meta/meta.dart';

enum SpecialPatterns { Time }

class SpecialPatternRegex {
  final RegExp regex;
  final SpecialPatterns pattern;

  SpecialPatternRegex({
    @required this.regex,
    @required this.pattern,
  });
}

final List<SpecialPatternRegex> specialPatterns = [
  SpecialPatternRegex(
    pattern: SpecialPatterns.Time,
    regex: RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$'),
  ),
];
