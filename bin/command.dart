import 'package:meta/meta.dart';

import 'command_store.dart';

class Command {
  final String pattern;
  final Function execute;
  final List<String> subPatterns;

  const Command({
    @required this.pattern,
    @required this.subPatterns,
    this.execute,
  });

  Command handleInput(String pattern) {
    return CommandStore.instance.getCommand(pattern);
  }

  @override
  String toString() {
    return '$pattern -> $subPatterns)';
  }
}
