class RegisterSellerDTO {
  final String iin;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String userName;
  final String catName;
  final String check;
  final int typeOrganization;
  final String? kpp;
  final String? ogrn;
  final String? okved;
  final String? tax_authority;
  final String? date_register;
  final String? founder;
  final String? date_of_birth;
  final String? citizenship;
  final String? CEO;
  final String? organization_fr;
  final String? bank;
  final String? company_name;
  final String? legal_address;

  const RegisterSellerDTO({
    required this.iin,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.userName,
    required this.catName,
    required this.check,
    required this.typeOrganization,
    this.kpp,
    this.ogrn,
    this.okved,
    this.tax_authority,
    this.date_register,
    this.founder,
    this.date_of_birth,
    this.citizenship,
    this.CEO,
    this.organization_fr,
    this.bank,
    this.company_name,
    this.legal_address,
  });
}
