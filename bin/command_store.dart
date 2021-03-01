import 'command.dart';

class _UnknownCommand implements Command {
  @override
  String get endCommandMessage => 'Cannot comply, Unknown command';

  @override
  Command handleInput(String pattern) {
    return null;
  }

  @override
  String get pattern => null;

  @override
  List<String> get subPatterns => [];
}

class CommandStore {
  static final CommandStore _instance = CommandStore._();

  CommandStore._();

  static CommandStore get instance => _instance;

  final List<Command> _commands = [];

  void addCommand(Command command) => _commands.add(command);

  Command getCommand(String pattern) =>
      _commands.firstWhere((command) => command.pattern == pattern,
          orElse: () => _UnknownCommand());
}
