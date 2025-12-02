class ContractModel {
  String img;
  String title;
  ContractModel({
    required this.img,
    required this.title,
  });
}

List<ContractModel> contractData = [
  ContractModel(img: 'personal_info', title: 'المعومات الشخصية'),
  ContractModel(img: 'address_info', title: 'معلومات الموقع'),
  ContractModel(img: 'neighborhood', title: 'معلومات السكن'),
];
