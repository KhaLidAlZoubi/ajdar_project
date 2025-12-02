class AdsHomeModel {
  int? id;
  String? title;
  String? description;
  double? price;
  String? phonNumber;
  String? categoryTitle;
  String? location;
  List<String>? imageUrl;
  String? userId;
  bool? isActive;
  String? userName;
  String? createdAt;
  String? updatedAt;
  List<AdFieldDtos>? adFieldDtos;

  AdsHomeModel(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.phonNumber,
      this.categoryTitle,
      this.location,
      this.imageUrl,
      this.userId,
      this.isActive,
      this.userName,
      this.createdAt,
      this.updatedAt,
      this.adFieldDtos});

  AdsHomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    phonNumber = json['phonNumber'];
    categoryTitle = json['categoryTitle'];
    location = json['location'];
    imageUrl = json['imageUrl'].cast<String>();
    userId = json['userId'];
    isActive = json['isActive'];
    userName = json['userName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['adFieldDtos'] != null && json['adFieldDtos'].isNotEmpty) {
      adFieldDtos = <AdFieldDtos>[];
      json['adFieldDtos'].forEach((v) {
        adFieldDtos!.add(new AdFieldDtos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['phonNumber'] = this.phonNumber;
    data['categoryTitle'] = this.categoryTitle;
    data['location'] = this.location;
    data['imageUrl'] = this.imageUrl;
    data['userId'] = this.userId;
    data['isActive'] = this.isActive;
    data['userName'] = this.userName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.adFieldDtos != null) {
      data['adFieldDtos'] = this.adFieldDtos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdFieldDtos {
  String? title;
  int? dynamicFieldId;
  String? value;

  AdFieldDtos({this.title, this.dynamicFieldId, this.value});

  AdFieldDtos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    dynamicFieldId = json['dynamicFieldId'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['dynamicFieldId'] = this.dynamicFieldId;
    data['value'] = this.value;
    return data;
  }
}
