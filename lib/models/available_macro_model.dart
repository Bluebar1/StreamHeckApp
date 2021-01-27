class AvailableMacro {
  final int id;
  final String combo;
  final bool alreadyInUse;

  AvailableMacro(this.id, this.combo, this.alreadyInUse);

  AvailableMacro.fromJson(Map<dynamic, dynamic> parsedJson)
      : id = parsedJson['id'],
        combo = parsedJson['combo'],
        alreadyInUse = parsedJson['alreadyInUse']; //TODO what is thissss

  Map<dynamic, dynamic> toJson() =>
      {'id': id, 'combo': combo, 'alreadyInUse': alreadyInUse};
}
