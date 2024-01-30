class ResetPasswordModel {
  String? message;

  ResetPasswordModel({this.message});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

}
