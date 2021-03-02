import 'package:meta/meta.dart';

import 'command.dart';

class CommandChain {
  final String patternChain;
  final Function execute;

  CommandChain({
    @required this.patternChain,
    @required this.execute,
  });

  List<String> get patterns => patternChain.trim().toLowerCase().split(' ');

  List<Command> get commands {
    // ignore: omit_local_variable_types
    List<Command> createdCommands = [];

    for (var pattern in patterns.reversed) {
      final command = Command(
        pattern: pattern,
        subPatterns:
            createdCommands.isEmpty ? [] : [createdCommands.last.pattern],
        execute: createdCommands.isEmpty ? execute : null,
      );

      createdCommands.add(command);
    }

    return createdCommands;
  }
}
