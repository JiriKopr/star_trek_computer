import 'command.dart';
import 'command_chain.dart';

final List<CommandChain> chainCommands = [
  CommandChain(
    patternChain: 'Hey Hey people',
    execute: () => print('Sseth here'),
  ),
];

final Command root = Command(
  pattern: 'computer',
);
