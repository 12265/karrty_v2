class MarcheModdle {
  String? id;
  String? displayId;
  String? name;
  String? owner;
  String? constructionType;
  String? laboratory;
  String? architect;
  String? technicalManager;
  String? designOffice;
  String? controlOffice;
  String? submissionDate;
  String? constructionStartDate;
  int? timeLimit;
  int? amount;
  int? additionalWorkAmount;

  MarcheModdle(
      {this.id,
        this.displayId,
        this.name,
        this.owner,
        this.constructionType,
        this.laboratory,
        this.architect,
        this.technicalManager,
        this.designOffice,
        this.controlOffice,
        this.submissionDate,
        this.constructionStartDate,
        this.timeLimit,
        this.amount,
        this.additionalWorkAmount});

  MarcheModdle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayId = json['displayId'];
    name = json['name'];
    owner = json['owner'];
    constructionType = json['constructionType'];
    laboratory = json['laboratory'];
    architect = json['architect'];
    technicalManager = json['technicalManager'];
    designOffice = json['designOffice'];
    controlOffice = json['controlOffice'];
    submissionDate = json['submissionDate'];
    constructionStartDate = json['constructionStartDate'];
    timeLimit = json['timeLimit'];
    amount = json['amount'];
    additionalWorkAmount = json['additionalWorkAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayId'] = this.displayId;
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['constructionType'] = this.constructionType;
    data['laboratory'] = this.laboratory;
    data['architect'] = this.architect;
    data['technicalManager'] = this.technicalManager;
    data['designOffice'] = this.designOffice;
    data['controlOffice'] = this.controlOffice;
    data['submissionDate'] = this.submissionDate;
    data['constructionStartDate'] = this.constructionStartDate;
    data['timeLimit'] = this.timeLimit;
    data['amount'] = this.amount;
    data['additionalWorkAmount'] = this.additionalWorkAmount;
    return data;
  }
}