class SubSectionModel {
  int? id;
  String? title;
  int? categoryId;
  String? categoryTitle;
  bool? isDeleted;

  SubSectionModel(
      {this.id,
      this.title,
      this.categoryId,
      this.categoryTitle,
      this.isDeleted});

  SubSectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['categoryId'];
    categoryTitle = json['categoryTitle'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['categoryId'] = this.categoryId;
    data['categoryTitle'] = this.categoryTitle;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}
