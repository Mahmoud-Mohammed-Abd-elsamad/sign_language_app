class SignToLanguageModel {
  bool? status;
  int? resultCode;
  String? message;
  Word? word;

  SignToLanguageModel({this.status, this.resultCode, this.message, this.word});

  SignToLanguageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    resultCode = json['resultCode'];
    message = json['message'];
    word = json['word'] != null ? Word.fromJson(json['word']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['resultCode'] = resultCode;
    data['message'] = message;
    if (word != null) {
      data['word'] = word!.toJson();
    }
    return data;
  }
}

class Word {
  String? result;

  Word({this.result});

  Word.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    return data;
  }
}
