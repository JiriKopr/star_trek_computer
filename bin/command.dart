import 'package:meta/meta.dart';

import 'command_store.dart';

class Command {
  final String pattern;
  final String endCommandMessage;
  final List<String> subPatterns;

  const Command({
    @required this.pattern,
    @required this.endCommandMessage,
    @required this.subPatterns,
  });

  Command handleInput(String pattern) {
    return CommandStore.instance.getCommand(pattern);
  }
}
