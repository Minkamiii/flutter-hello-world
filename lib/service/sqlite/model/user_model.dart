class User {
  final int? id;
  final String username;
  final String? fullname;
  final String email;
  final String password;
  final String? role;
  final String? description;

  User({
    this.id,
    required this.username,
    this.fullname,
    required this.email,
    required this.password,
    this.role,
    this.description
  });

  User.loginSuccess({
    required this.username,
    required this.email,
    this.fullname,
    this.role,
    this.description,
    this.id
  }) : password = "";

  User.updateProfile({
    required this.id,
    required this.email,
    required this.fullname,
    required this.role,
    required this.description,
  }) : 
  username = "",
  password = "";

  Map<String, dynamic> toRegisterJson() => {
    'username': username,
    'password': password,
    'email': email,
    'fullname' : "",
    'role': "",
    'description': ""
  };

  Map<String, dynamic> toProfileJson() => {
    'id': id,
    'username': username,
    'fullname': fullname,
    'email': email,
    'role': role,
    'description': description
  };

  Map<String, dynamic> toUpdateProfileJson() => {
    'fullname': fullname,
    'email': email,
    'role': role,
    'description': description,
  };

  factory User.fromLoginJson(Map<String, dynamic> json) => User.loginSuccess(
    id: json['id'],
    username: json['username'], 
    email: json['email'],
    fullname: json['fullname'],
    role: json['role'],
    description: json['description']
  );

  factory User.fromProfileJson(Map<String, dynamic> json) => User.updateProfile(
    id: json['id'], 
    email: json['email'], 
    fullname: json['fullname'], 
    role: json['role'], 
    description: json['description']
  );
}