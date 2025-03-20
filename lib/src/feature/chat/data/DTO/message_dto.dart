class messageDTO {
  final String type;
  final String name;
  final String text;
  final String user_id;

  const messageDTO({
    required this.type,
    required this.name,
    required this.text,
    required this.user_id,
  });
}
