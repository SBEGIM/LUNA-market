class BloggerDTO {
  final String? firstName;
  final String? lastName;
  final String? surName;
  final String? nick;
  final String? phone;
  final String? password;
  final String? legalStatus;
  final String? iin;
  final String? bankName;
  final String? bankBik;
  final String? check;
  final dynamic avatar;
  final String? card;
  final String? email;
  final String? socialNetwork;

  const BloggerDTO({
    this.firstName,
    this.lastName,
    this.surName,
    this.nick,
    this.phone,
    this.password,
    this.legalStatus,
    this.iin,
    this.bankName,
    this.bankBik,
    this.check,
    this.avatar,
    this.card,
    this.email,
    this.socialNetwork,
  });

  BloggerDTO copyWith({
    String? firstName,
    String? lastName,
    String? surName,
    String? nick,
    String? phone,
    String? password,
    String? legalStatus,
    String? iin,
    String? bankName,
    String? bankBik,
    String? check,
    dynamic avatar,
    String? card,
    String? email,
    String? socialNetwork,
  }) {
    return BloggerDTO(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      surName: surName ?? this.surName,
      nick: nick ?? this.nick,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      legalStatus: legalStatus ?? this.legalStatus,
      iin: iin ?? this.iin,
      bankName: bankName ?? this.bankName,
      bankBik: bankBik ?? this.bankBik,
      check: check ?? this.check,
      avatar: avatar ?? this.avatar,
      card: card ?? this.card,
      email: email ?? this.email,
      socialNetwork: socialNetwork ?? this.socialNetwork,
    );
  }
}
