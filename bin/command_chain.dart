import 'package:meta/meta.dart';

import 'command.dart';

class CommandChain {
  final String patternChain;
  final Execution execute;

  CommandChain({
    @required this.patternChain,
    @required this.execute,
  });

  List<String> get patterns => patternChain.trim().toLowerCase().split(' ');

  List<Command> get commands {
    int i = -1;

    return patterns.map((pattern) {
      i++;

      return Command(
        pattern: pattern,
        execute: i == patterns.length - 1 ? execute : null,
      );
    }).toList();
  }
}
