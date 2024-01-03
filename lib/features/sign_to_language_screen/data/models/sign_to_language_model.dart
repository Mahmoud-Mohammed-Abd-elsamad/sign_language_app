import '../../domain/entities/sign_to_language_entity.dart';

class SignToLanguageModel extends SignToLanguageEntity {
  String? message;

  SignToLanguageModel({super.status, super.resultCode, this.message});

  SignToLanguageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    resultCode = json['resultCode'];
    message = json['message'];
  }
}
