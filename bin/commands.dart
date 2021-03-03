import 'command.dart';
import 'command_chain.dart';
import 'special_patterns.dart';

final List<CommandChain> chainCommands = [
  CommandChain(
    patternChain: 'Hey Hey people',
    execute: (_) => print('Sseth here'),
  ),
  CommandChain(
    patternChain: 'Hello there',
    execute: (_) => print('General Kenobi'),
  ),
  CommandChain(
    patternChain: 'Set alarm for ${SpecialPatterns.Time}',
    execute: (commands) {
      print('you inserted time: ${commands.last.pattern}');
    },
  ),
  CommandChain(
    patternChain: 'Tell me the time',
    execute: (_) {
      final date = DateTime.now();

      String minutesString =
          date.minute < 10 ? '0${date.minute}' : '${date.minute}';

      print('${date.hour}:$minutesString');
    },
  ),
  CommandChain(
    patternChain: 'Tell me the date',
    execute: (_) {
      final date = DateTime.now();

      print('${date.day}/${date.month}/${date.year}');
    },
  ),
];

final Command root = Command(
  pattern: 'computer',
);
