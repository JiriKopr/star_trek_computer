import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'command_store.dart';
import 'commands.dart';

Stream<String> readLine() =>
    stdin.transform(utf8.decoder).transform(const LineSplitter());

void main(List<String> arguments) {
  CommandStore.instance.addCommands(commands);

  readLine()
      .map((pattern) => pattern.trim().toLowerCase())
      .listen(CommandStore.instance.handleInput);
}
