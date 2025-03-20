class RegisterAdminDTO {
  final String iin;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String userName;
  final String catName;
  final String check;
  final bool typeOrganization;

  const RegisterAdminDTO(
      {required this.iin,
      required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.userName,
      required this.catName,
      required this.check,
      required this.typeOrganization});
}
