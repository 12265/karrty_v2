class ContractsModdle {
  String? id;
  String? displayId;
  String? subcontractor;
  String? market;
  String? date;
  String? field;
  String? label;
  String? responsibility;
  num? holdBackPercentage;

  ContractsModdle(
      {this.id,
        this.displayId,
        this.subcontractor,
        this.market,
        this.date,
        this.field,
        this.label,
        this.responsibility,
        this.holdBackPercentage});

  ContractsModdle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayId = json['displayId'];
    subcontractor = json['subcontractor'];
    market = json['market'];
    date = json['date'];
    field = json['field'];
    label = json['label'];
    responsibility = json['responsibility'];
    holdBackPercentage = json['holdBackPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayId'] = this.displayId;
    data['subcontractor'] = this.subcontractor;
    data['market'] = this.market;
    data['date'] = this.date;
    data['field'] = this.field;
    data['label'] = this.label;
    data['responsibility'] = this.responsibility;
    data['holdBackPercentage'] = this.holdBackPercentage;
    return data;
  }
}