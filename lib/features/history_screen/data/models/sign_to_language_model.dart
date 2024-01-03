class HistoryModel {
  List<History>? history;

  HistoryModel({this.history});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  Word? word;
  List<String>? images;

  History({this.word, this.images});

  History.fromJson(Map<String, dynamic> json) {
    word = json['word'] != null ? new Word.fromJson(json['word']) : null;
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.word != null) {
      data['word'] = this.word!.toJson();
    }
    data['images'] = this.images;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['word'] = this.word;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
