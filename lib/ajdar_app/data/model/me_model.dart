class MeModel {
  String? id;
  String? userName;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  bool? emailConfirmed;
  bool? phoneNumberConfirmed;
  bool? twoFactorEnabled;
  bool? lockoutEnabled;
  bool? isBlocked;
  String? lockoutEnd;
  int? accessFailedCount;
  List<String>? roles;
  int? totalAds;
  int? activeAds;
  int? inactiveAds;

  MeModel({
    this.id,
    this.userName,
    this.email,
    this.phoneNumber,
    this.imageUrl,
    this.emailConfirmed,
    this.phoneNumberConfirmed,
    this.twoFactorEnabled,
    this.lockoutEnabled,
    this.isBlocked,
    this.lockoutEnd,
    this.accessFailedCount,
    this.roles,
    this.totalAds,
    this.activeAds,
    this.inactiveAds,
  });

  MeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
    emailConfirmed = json['emailConfirmed'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnabled = json['lockoutEnabled'];
    isBlocked = json['isBlocked'];
    lockoutEnd = json['lockoutEnd'];
    accessFailedCount = json['accessFailedCount'];
    roles = json['roles'].cast<String>();
    totalAds = json['totalAds'];
    activeAds = json['activeAds'];
    inactiveAds = json['inactiveAds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['imageUrl'] = this.imageUrl;
    data['emailConfirmed'] = this.emailConfirmed;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['lockoutEnabled'] = this.lockoutEnabled;
    data['isBlocked'] = this.isBlocked;
    data['lockoutEnd'] = this.lockoutEnd;
    data['accessFailedCount'] = this.accessFailedCount;
    data['roles'] = this.roles;
    data['totalAds'] = this.totalAds;
    data['activeAds'] = this.activeAds;
    data['inactiveAds'] = this.inactiveAds;
    return data;
  }
}
