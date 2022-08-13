class QuotationsModdle {
  String? id;
  String? description;
  String? unity;
  int? unitaryPrice;
  int? agreedQuantity;

  QuotationsModdle(
      {this.id,
        this.description,
        this.unity,
        this.unitaryPrice,
        this.agreedQuantity});

  QuotationsModdle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    unity = json['unity'];
    unitaryPrice = json['unitaryPrice'];
    agreedQuantity = json['agreedQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['unity'] = this.unity;
    data['unitaryPrice'] = this.unitaryPrice;
    data['agreedQuantity'] = this.agreedQuantity;
    return data;
  }
}