class RegisterBloggerDTO {
  final String name;
  final String social_network;
  final String email;
  final String nick_name;

  final String phone;
  final String password;

  const RegisterBloggerDTO({
    required this.name,
    required this.social_network,
    required this.email,
    required this.nick_name,
    required this.phone,
    required this.password,
  });
}
