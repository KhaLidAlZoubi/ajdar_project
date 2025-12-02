class ServicesDataModel {
  bool? status;
  String? message;
  List<ServicesData>? data;

  ServicesDataModel({this.status, this.message, this.data});

  ServicesDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServicesData>[];
      json['data'].forEach((v) {
        data!.add(new ServicesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesData {
  int? id;
  String? name;
  String? description;
  int? price;

  List<ServicesImages>? images;
  // Category? category;

  ServicesData({
    this.id,
    this.name,
    this.description,
    this.price,
    this.images,
    // this.category,
  });

  ServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    if (json['images'] != null) {
      images = <ServicesImages>[];
      json['images'].forEach((v) {
        images!.add(new ServicesImages.fromJson(v));
      });
    }
    // category = json['category'] != null
    //     ? new Category.fromJson(json['category'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    // if (this.category != null) {
    //   data['category'] = this.category!.toJson();
    // }
    return data;
  }
}

class ServicesImages {
  String? path;

  ServicesImages({this.path});

  ServicesImages.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    return data;
  }
}

// class Category {
//   int? id;
//   String? name;
//   List<ServicesImages>? images;

//   Category({this.id, this.name, this.images});

//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     if (json['images'] != null) {
//       images = <ServicesImages>[];
//       json['images'].forEach((v) {
//         images!.add(new ServicesImages.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
