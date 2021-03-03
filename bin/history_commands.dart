import 'package:meta/meta.dart';

import 'command.dart';

class HistoryCommand {
  final String pattern;
  final Command command;

  HistoryCommand({
    @required this.pattern,
    @required this.command,
  });
}
