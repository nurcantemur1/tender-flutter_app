class RegisterDto {
  String email;
  String password;
  String firstName;
  String lastName;
  RegisterDto({email, password, firstName, lastname}) {
    this.email = email;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
  }
  factory RegisterDto.fromJson(Map<String, dynamic> json) {
    return RegisterDto(
        email: json['email'],
        firstName: json['firstname'],
        lastname: json['lastname'],
        password: json['password']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}
