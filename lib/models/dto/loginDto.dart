class LoginDto {
  String email;
  String password;

  LoginDto({email, password}) {
    this.email = email;
    this.password = password;
  }
  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(email: json['email'], password: json['password']);
  }
}
