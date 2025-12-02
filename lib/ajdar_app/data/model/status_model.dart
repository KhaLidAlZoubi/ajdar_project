class StatusModel {
  String img;
  String status;
  StatusModel({
    required this.img,
    required this.status,
  });
}

List<StatusModel> statusData = [
  StatusModel(img: 'no_data', status: 'Online'),
  StatusModel(img: 'error', status: 'Offline'),
  StatusModel(img: 'error_connect', status: 'Offline'),
  StatusModel(img: 'no_search_data', status: 'Offline'),
];
