import 'command.dart';
import 'command_chain.dart';

class CommandStore {
  static final CommandStore _instance = CommandStore._();

  CommandStore._();

  static CommandStore get instance => _instance;

  final Command root = Command(pattern: 'computer');

  void addCommands(List<CommandChain> commandChains) {
    for (var chain in commandChains) {
      Command parent = root;

      for (var command in chain.commands) {
        final insertedCommand = parent.subCommands
            .putIfAbsent(formatPatternToKey(command.pattern), () => command);

        assert(
          insertedCommand.execute == command.execute,
          'Duplicate Command.execute registration',
        );

        parent = insertedCommand;
      }
    }
  }

  final List<Command> previousCommands = [];

  void executeInputtedCommands() {
    if (previousCommands.isNotEmpty && previousCommands.last.execute != null) {
      // Execute last inputted Command
      previousCommands.last.execute();
      previousCommands.clear();
    }
  }

  void parseInputtedPatterns(List<String> patterns) {
    for (var pattern in patterns) {
      if (pattern == 'computer') {
        // The 'computer' keyword has been inputted
        previousCommands.add(root);

        continue;
      }

      if (previousCommands.isEmpty) {
        // The 'computer' keyword hasn't been used yet
        // skip this pattern
        continue;
      }

      final nextCommand = previousCommands.last.getSubCommand(pattern);

      if (nextCommand == null) {
        // There is no subCommand with passed pattern
        print('Cannot comply, Unknown command');
        previousCommands.clear();
        break;
      }

      previousCommands.add(nextCommand);
    }
  }

  void handleInput(List<String> input) {
    if (input?.isEmpty != false) {
      // No new command has been inputted in duration
      executeInputtedCommands();
      return;
    }

    // Parse patterns into Commands
    List<String> dividedPatterns = input
        .reduce((acc, cur) => '$acc $cur')
        .split(' ')
        .map((pattern) => pattern.trim().toLowerCase())
        .where((pattern) => pattern.isNotEmpty)
        .toList();

    parseInputtedPatterns(dividedPatterns);

    return;
  }

  String formatPatternToKey(String pattern) => pattern.trim().toLowerCase();

  @override
  String toString() {
    return root.toString();
  }
}
