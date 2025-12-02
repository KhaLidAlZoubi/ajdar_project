class WishlistModel {
  int? adId;
  String? title;
  String? description;
  double? price;
  List<String>? imageUrl;
  String? location;
  String? categoryName;
  String? subCategoryName;
  String? addedAt;

  WishlistModel(
      {this.adId,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.location,
      this.categoryName,
      this.subCategoryName,
      this.addedAt});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    adId = json['adId'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['imageUrl'].cast<String>();
    location = json['location'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    addedAt = json['addedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adId'] = this.adId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    data['location'] = this.location;
    data['categoryName'] = this.categoryName;
    data['subCategoryName'] = this.subCategoryName;
    data['addedAt'] = this.addedAt;
    return data;
  }
}
