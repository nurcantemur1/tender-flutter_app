class TokenModel {
  String token;
  String expiration;

  TokenModel({this.token, this.expiration});

  TokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expiration'] = this.expiration;
    return data;
  }
}
