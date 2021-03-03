import 'command.dart';
import 'command_chain.dart';

final List<CommandChain> chainCommands = [
  CommandChain(
    patternChain: 'Hey Hey people',
    execute: () => print('Sseth here'),
  ),
  CommandChain(
    patternChain: 'Tell me the time',
    execute: () {
      final date = DateTime.now();

      String minutesString =
          date.minute < 10 ? '0${date.minute}' : '${date.minute}';

      print('${date.hour}:$minutesString');
    },
  ),
  CommandChain(
    patternChain: 'Tell me the date',
    execute: () {
      final date = DateTime.now();

      print('${date.day}/${date.month}/${date.year}');
    },
  ),
];

final Command root = Command(
  pattern: 'computer',
);
