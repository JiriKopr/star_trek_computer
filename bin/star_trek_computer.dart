import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:rxdart/rxdart.dart';

import 'command_store.dart';
import 'commands.dart';

Stream<String> readLine() =>
    stdin.transform(utf8.decoder).transform(const LineSplitter());

void main(List<String> arguments) {
  CommandStore.instance.addCommands(chainCommands);

  readLine()
      .map((pattern) => pattern.trim().toLowerCase())
      .buffer(Stream.periodic(Duration(seconds: 1, milliseconds: 500)))
      .listen(CommandStore.instance.handleInput);
}
