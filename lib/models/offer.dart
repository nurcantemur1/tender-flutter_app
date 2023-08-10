class Offer {
  int id;
  int productId;
  int userId;
  String peytime;
  int pey;

  Offer({this.id, this.productId, this.userId, this.peytime, this.pey});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    userId = json['userId'];
    peytime = json['peytime'];
    pey = json['pey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['userId'] = this.userId;
    data['peytime'] = this.peytime;
    data['pey'] = this.pey;
    return data;
  }
}
