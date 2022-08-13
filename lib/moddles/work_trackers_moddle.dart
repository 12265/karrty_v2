import 'dart:convert';

class WorkTrackerModdle {
  String? date;
  List<Contents>? workTrackerContents;

  WorkTrackerModdle({this.date, this.workTrackerContents});

  WorkTrackerModdle.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['workTrackerContents'] != null) {
      workTrackerContents = <Contents>[];
      json['workTrackerContents'].forEach((v) {
        workTrackerContents!.add(new Contents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.workTrackerContents != null) {
      data['workTrackerContents'] =
          this.workTrackerContents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contents {
  String? quotationId;
  num? quantity;

  Contents({this.quotationId, this.quantity});

  Contents.fromJson(Map<String, dynamic> json) {
    quotationId = json['quotationId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quotationId'] = this.quotationId;
    data['quantity'] = this.quantity;
    return data;
  }
}
