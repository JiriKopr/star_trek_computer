import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'command.dart';
import 'command_store.dart';

final Command root = Command(
  endCommandMessage: null,
  pattern: 'computer',
  subPatterns: ['hello'],
);

final List<Command> commands = [
  root,
  Command(
    endCommandMessage: null,
    pattern: 'hello',
    subPatterns: ['world'],
  ),
  Command(
    endCommandMessage: 'What do you want?',
    pattern: 'world',
    subPatterns: [],
  ),
];

void registerCommands() {
  final instance = CommandStore.instance;

  for (var command in commands) {
    instance.addCommand(command);
  }
}

Stream<String> readLine() =>
    stdin.transform(utf8.decoder).transform(const LineSplitter());

Command previousCommand = root;

void handleInput(String pattern) {
  if (pattern == 'computer') previousCommand = root;

  previousCommand = previousCommand.handleInput(pattern);

  if (previousCommand.endCommandMessage != null) {
    print(previousCommand.endCommandMessage);

    if (previousCommand.subPatterns.isEmpty) {
      previousCommand = root;
    }
  }
}

void main(List<String> arguments) {
  registerCommands();

  readLine().map((pattern) => pattern.trim().toLowerCase()).listen(handleInput);
}
