class HistoryModel {
  List<History>? history;

  HistoryModel({this.history});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add( History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  Word? word;
  List<String>? images;

  History({this.word, this.images});

  History.fromJson(Map<String, dynamic> json) {
    word = json['word'] != null ? Word.fromJson(json['word']) : null;
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (word != null) {
      data['word'] = word!.toJson();
    }
    data['images'] = images;
    return data;
  }
}

class Word {
  int? id;
  String? word;
  String? createdAt;
  String? updatedAt;

  Word({this.id, this.word, this.createdAt, this.updatedAt});

  Word.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['word'] = word;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
