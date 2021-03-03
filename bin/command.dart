import 'package:meta/meta.dart';

import 'command_store.dart';
import 'history_commands.dart';
import 'special_patterns.dart';

typedef Execution = void Function(List<HistoryCommand> commands);

class Command {
  final String pattern;
  final Execution execute;
  final Map<String, Command> subCommands;

  Command({
    @required this.pattern,
    this.execute,
  }) : subCommands = {};

  Command getSubCommand(String pattern) {
    final foundPattern = specialPatterns
            .firstWhere(
                (specialPattern) => specialPattern.regex.hasMatch(pattern),
                orElse: () => null)
            ?.pattern
            ?.toString() ??
        pattern;

    return subCommands[CommandStore.instance.formatPatternToKey(foundPattern)];
  }

  @override
  String toString() {
    return '$pattern\n-> ${subCommands.values.map((command) => command)}';
  }
}
