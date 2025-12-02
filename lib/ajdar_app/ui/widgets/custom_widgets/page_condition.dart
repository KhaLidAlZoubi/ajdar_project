import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/page_status.dart';
import 'package:flutter/material.dart';

import '../../../data/model/status_model.dart';

Widget pageCondition({required String status, required Widget widget}) {
  if (status == 'No Data') {
    return PageStatus(model: statusData[0]);
  } else if (status == 'Error') {
    return PageStatus(model: statusData[1]);
  } else if (status == 'Error Connect') {
    return PageStatus(model: statusData[2]);
  } else {
    return widget;
  }
}
