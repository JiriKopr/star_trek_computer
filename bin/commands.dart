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
  subPatterns: [
    // All ChainCommands start with the first patter
    ...chainCommands.map((chain) => chain.patterns.first)
  ],
);

// Commands to be stored in CommandStore in order
// to merge patterns to all its sub-patterns
final List<Command> commands = [
  root,
  ...chainCommands
      .map((chain) => chain.commands)
      .reduce((acc, cur) => [...acc, ...cur])
      .toList(),
];
