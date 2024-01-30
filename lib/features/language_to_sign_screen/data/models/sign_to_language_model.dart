
class LanguageToSignModel {
  List<String>? images;
  String? word;

  LanguageToSignModel({this.images, this.word});

  LanguageToSignModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    word = json['word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    data['word'] = word;
    return data;
  }
}
