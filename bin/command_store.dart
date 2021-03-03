import 'command.dart';
import 'command_chain.dart';

class CommandStore {
  static final CommandStore _instance = CommandStore._();

  CommandStore._();

  static CommandStore get instance => _instance;

  final Command root = Command(pattern: 'computer');

  void addCommands(List<CommandChain> commandChains) {
    final commands = commandChains
        .map((chain) => chain.commands)
        .reduce((acc, cur) => [...acc, ...cur]);

    Command parent = root;

    for (var command in commands) {
      final insertedCommand = parent.subCommands
          .putIfAbsent(formatPatternToKey(command.pattern), () => command);

      assert(
        insertedCommand.execute == command.execute,
        'Duplicate Command.execute registration',
      );

      parent = insertedCommand;
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

    // print(previousCommands);

    return;

    if (input.isEmpty && previousCommands.isNotEmpty) {
      // No new input in 1.5 seconds -> try executing last command
      if (previousCommands.last.execute != null) {
        previousCommands.last.execute();
        previousCommands.clear();
      }

      // return true;
    }

    final splitInput = input
        .reduce((acc, cur) => '$acc $cur')
        .toLowerCase()
        .split(' ')
        .map((pattern) => pattern.trim())
        .where((pattern) => pattern.isNotEmpty);

    if (splitInput.length > 1) {
      // More then one pattern has been inputted at the same time
      for (var pattern in splitInput) {
        // if (!handleInput([pattern])) {
        //   // return false;
        // }
      }
    } else if (splitInput.isEmpty) {
      // Only space/s were inputted
      // return true;
    }

    final pattern = splitInput.first;

    // 'computer' is pattern starting the assistant
    if (pattern == 'computer') {
      previousCommands.add(root);

      // If there is no previous command, there is no
      // ongoing chain of commands and user didn't start
      // new chain using the 'computer' command
      // if (previousCommands.isEmpty) return true;

      // Get next Command from the current (which is previous at this point)
      final currentCommand = previousCommands.last.getSubCommand(pattern);

      if (currentCommand == null) {
        // No Command with this pattern was found
        print('Cannot comply, Unknown command');
        previousCommands.clear();
        // return false;
      }

      // Save currentCommand to history
      previousCommands.add(currentCommand);
    }
  }

  String formatPatternToKey(String pattern) => pattern.trim().toLowerCase();

  @override
  String toString() {
    return root.toString();
  }
}
