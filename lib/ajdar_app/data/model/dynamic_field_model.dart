class DynamicFieldModel {
  int? id;
  String? title;
  String? name;
  String? type;
  int? categoryId;
  String? categoryTitle;
  int? subCategoryId;
  String? subCategoryTitle;
  bool? shouldFilterbyParent;
  List<Options>? options;

  DynamicFieldModel(
      {this.id,
      this.title,
      this.name,
      this.type,
      this.categoryId,
      this.categoryTitle,
      this.subCategoryId,
      this.subCategoryTitle,
      this.shouldFilterbyParent,
      this.options});

  DynamicFieldModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    type = json['type'];
    categoryId = json['categoryId'];
    categoryTitle = json['categoryTitle'];
    subCategoryId = json['subCategoryId'];
    subCategoryTitle = json['subCategoryTitle'];
    shouldFilterbyParent = json['shouldFilterbyParent'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['name'] = this.name;
    data['type'] = this.type;
    data['categoryId'] = this.categoryId;
    data['categoryTitle'] = this.categoryTitle;
    data['subCategoryId'] = this.subCategoryId;
    data['subCategoryTitle'] = this.subCategoryTitle;
    data['shouldFilterbyParent'] = this.shouldFilterbyParent;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  String? label;
  String? value;
  // Null? parentValue;
  int? dynamicFieldId;

  Options({this.id, this.label, this.value, this.dynamicFieldId});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    value = json['value'];
    // parentValue = json['parentValue'];
    dynamicFieldId = json['dynamicFieldId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['value'] = this.value;
    // data['parentValue'] = this.parentValue;
    data['dynamicFieldId'] = this.dynamicFieldId;
    return data;
  }
}
