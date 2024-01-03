class SignToLanguageEntity {
  bool? status;
  int? resultCode;

  SignToLanguageEntity({this.status, this.resultCode});

  SignToLanguageEntity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    resultCode = json['resultCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['resultCode'] = this.resultCode;
    return data;
  }
}
