import 'package:meta/meta.dart';

import 'command_store.dart';

class Command {
  final String pattern;
  final Function execute;
  final Map<String, Command> subCommands;

  Command({
    @required this.pattern,
    this.execute,
  }) : subCommands = {};

  Command getSubCommand(String pattern) {
    return subCommands[CommandStore.instance.formatPatternToKey(pattern)];
  }

  @override
  String toString() {
    return '$pattern\n-> ${subCommands.values.map((command) => command)}';
  }
}
