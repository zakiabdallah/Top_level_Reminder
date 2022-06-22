final String Tableusersauth = 'users';

class usersauthFields {
  static final List<String> values = [
    id,
    First_name,
    Last_name,
    Username,
    Email,
    adress,
    phone,
    Organization,
    Role,
    url_img,
    Password,
    Data_createdTime,
    Data_LastModification
  ];
  static final String id = '_id';
  static final String First_name = 'First_name';
  static final String Last_name = 'Last_name';
  static final String Username = 'Username';
  static final String Email = 'Email';
  static final String adress = 'adress';
  static final String phone = 'phone';
  static final String Organization = 'Organization';
  static final String Role = 'Role';
  static final String url_img = 'url_img';
  static final String Password = 'Password';
  static final String Data_createdTime = 'Data_createdTime';
  static final String Data_LastModification = 'Data_LastModification';
}

class usersauth {
  final int? id;
  final String First_name;
  final String Last_name;
  final String Username;
  final String Email;
  final String adress;
  final String phone;
  final String Organization;
  final String Role;
  final String Password;
  final String url_img;
  final DateTime Data_createdTime;
  final DateTime Data_LastModification;
  const usersauth({
    this.id,
    required this.First_name,
    required this.Last_name,
    required this.Username,
    required this.Email,
    required this.adress,
    required this.phone,
    required this.Organization,
    required this.Role,
    required this.url_img,
    required this.Password,
    required this.Data_createdTime,
    required this.Data_LastModification,
  });
  static usersauth fromJson(Map<String, Object?> json) => usersauth(
      id: json[usersauthFields.id] as int?,
      First_name: json[usersauthFields.First_name] as String,
      Last_name: json[usersauthFields.Last_name] as String,
      Username: json[usersauthFields.Username] as String,
      Email: json[usersauthFields.Email] as String,
      adress: json[usersauthFields.adress] as String,
      phone: json[usersauthFields.phone] as String,
      Organization: json[usersauthFields.Organization] as String,
      Role: json[usersauthFields.Role] as String,
      Password: json[usersauthFields.Password] as String,
      url_img: json[usersauthFields.url_img] as String,
      Data_createdTime:
          DateTime.parse(json[usersauthFields.Data_createdTime] as String),
      Data_LastModification: DateTime.parse(
          json[usersauthFields.Data_LastModification] as String));
  Map<String, Object?> toJson() => {
        usersauthFields.id: id,
        usersauthFields.First_name: First_name,
        usersauthFields.Last_name: Last_name,
        usersauthFields.Username: Username,
        usersauthFields.Email: Email,
        usersauthFields.adress: adress,
        usersauthFields.phone: phone,
        usersauthFields.Organization: Organization,
        usersauthFields.Role: Role,
        usersauthFields.Password: Password,
        usersauthFields.url_img: url_img,
        usersauthFields.Data_createdTime: Data_createdTime.toIso8601String(),
        usersauthFields.Data_LastModification:
            Data_LastModification.toIso8601String(),
      };

  usersauth copy({
    int? id,
    String? First_name,
    String? Last_name,
    String? Username,
    String? Email,
    String? adress,
    String? phone,
    String? Organization,
    String? Role,
    String? url_img,
    String? Password,
    DateTime? Data_createdTime,
    DateTime? Data_LastModification,
  }) =>
      usersauth(
          id: id ?? this.id,
          First_name: First_name ?? this.First_name,
          Last_name: Last_name ?? this.Last_name,
          Username: Username ?? this.Username,
          Email: Email ?? this.Email,
          adress: adress ?? this.adress,
          phone: phone ?? this.phone,
          Organization: Organization ?? this.Organization,
          Role: Role ?? this.Role,
          url_img: url_img ?? this.url_img,
          Password: Password ?? this.Password,
          Data_createdTime: Data_createdTime ?? this.Data_createdTime,
          Data_LastModification:
              Data_LastModification ?? this.Data_LastModification);
}
