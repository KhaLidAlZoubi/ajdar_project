import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/image_background_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoUserPage extends StatelessWidget {
  PhotoUserPage({super.key});
  // String url;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: Center(
            child: ImageBackgroundContainer(
              isNetwork: cubit.meData != null,
              network: cubit.meData!.imageUrl,
              isCircle: true,
              height: MediaQuery.of(context).size.width,
              width: double.infinity,
            ),
          ),
        );
      },
    );
  }
}
