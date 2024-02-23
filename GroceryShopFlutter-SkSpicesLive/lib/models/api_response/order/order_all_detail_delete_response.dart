class OrderAllDetailDeleteResponse {
  List<OrderAllDetailDeleteResponseDetails> details;
  int totalCount;

  OrderAllDetailDeleteResponse({this.details, this.totalCount});

  OrderAllDetailDeleteResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new OrderAllDetailDeleteResponseDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class OrderAllDetailDeleteResponseDetails {
  String column1;
  int column2;

  OrderAllDetailDeleteResponseDetails({this.column1, this.column2});

  OrderAllDetailDeleteResponseDetails.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1'];
    column2 = json['Column2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;
    data['Column2'] = this.column2;
    return data;
  }
}
