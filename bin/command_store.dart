import 'command.dart';
import 'commands.dart';

class _UnknownCommand implements Command {
  @override
  Command handleInput(String pattern) {
    return null;
  }

  @override
  String get pattern => null;

  @override
  List<String> get subPatterns => [];

  @override
  Function get execute => () => print('Cannot comply, Unknown command');
}

class CommandStore {
  static final CommandStore _instance = CommandStore._();

  CommandStore._();

  static CommandStore get instance => _instance;

  final Map<String, Command> _commands = {};

  void addCommand(Command command) {
    final key = formatPatternToKey(command.pattern);
    final foundCommand = _commands[key];

    if (foundCommand == null) {
      // No Command with this pattern is stored at this moment
      _commands[key] = command;
    } else {
      // Command with this pattern already exists

      assert(command.execute == null && foundCommand.execute == null,
          'Command is already in store, no execute function can be added\n Pattern: ${foundCommand.pattern}');

      foundCommand.subPatterns.addAll(command.subPatterns);
    }
  }

  void addCommands(List<Command> commands) {
    for (var command in commands) {
      addCommand(command);
    }
  }

  final List<Command> previousCommands = [];

  void handleInput(String input) {
    final splitInput = input
        .toLowerCase()
        .split(' ')
        .map((pattern) => pattern.trim())
        .where((pattern) => pattern.isNotEmpty);

    if (splitInput.length > 1) {
      // More then one pattern has been inputted at the same time
      for (var pattern in splitInput) {
        handleInput(pattern);
      }
    } else if (splitInput.isEmpty) {
      // Only space/s were inputted
      return;
    }

    final pattern = splitInput.first;

    // 'computer' is pattern starting the assistant
    if (pattern == 'computer') previousCommands.add(root);

    // If there is no previous command, there is no
    // ongoing chain of commands and user didn't start
    // new chain using the 'computer' command
    if (previousCommands.isEmpty) return;

    // Get next Command from the current (which is previous at this point)
    final currentCommand = previousCommands.last.handleInput(pattern);

    // Well... just execute the bad boy
    currentCommand.execute?.call();

    // Save currentCommand to history
    previousCommands.add(currentCommand);

    // If there is no next Command, the chain ends
    if (currentCommand.subPatterns.isEmpty) {
      previousCommands.clear();
    }
  }

  String formatPatternToKey(String pattern) => pattern.trim().toLowerCase();

  Command getCommand(String pattern) =>
      _commands[formatPatternToKey(pattern)] ?? _UnknownCommand();
}
