import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import '../../../widgets/subtitle_text.dart';

class PhotoSection extends StatefulWidget {
  @override
  State<PhotoSection> createState() => _PhotoSectionState();
}

class _PhotoSectionState extends State<PhotoSection> {
  var positionPage = 0.0;
  PageController pageController = PageController();
  bool isLast = false;
  bool isFirst = true;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        positionPage = pageController.page!;
      });
    });
  }

  // MyHomePageController controller = Get.find<MyHomePageController>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      HomeCubit cubit = HomeCubit.get(context);
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FlexibleSpaceBar(
              background: cubit.adsDetails.imageUrl!.isEmpty
                  ? Container(
                      color: Colors.grey[200],
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: getRes(context, 34),
                      ),
                    )
                  : PageView.builder(
                      itemCount: cubit.adsDetails.imageUrl!.length,
                      controller: pageController,
                      onPageChanged: (int i) {
                        if (i == cubit.adsDetails.imageUrl!.length - 1) {
                          setState(() {
                            isLast = true;
                          });
                        } else {
                          setState(() {
                            isLast = false;
                          });
                        }
                        if (i != 0) {
                          setState(() {
                            isFirst = false;
                          });
                        } else {
                          setState(() {
                            isFirst = true;
                          });
                        }
                      },
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: cubit.adsDetails.imageUrl![index],
                          imageBuilder: (context, imageProvider) => Container(
                            // height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                  getRes(context, 10),
                                ),
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(getRes(context, 10))),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(strokeWidth: 1),
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child:
                                Icon(Icons.error, color: Colors.red, size: 40),
                          ),
                          width: double.maxFinite,
                          fit: BoxFit.fill,
                        );
                      })),
          Positioned(
            child: Container(
              // height: 20,
              // width: 90,
              padding: EdgeInsets.symmetric(
                  vertical: getRes(context, 5),
                  horizontal: getRes(context, 12)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(getRes(context, 15))),
              child: SmoothPageIndicator(
                controller: pageController,
                count: cubit.adsDetails.imageUrl!.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.teal,
                  dotColor: Colors.teal.shade200,
                ),
              ),
              // color: Colors.white,
            ),
            bottom: 8,
          )
        ],
      );
    });
  }
}

// class PhotosSection extends StatefulWidget {
//   @override
//   State<PhotosSection> createState() => _PhotosSectionState();
// }

// class _PhotosSectionState extends State<PhotosSection> {
//   var positionPage = 0.0;
//   PageController pageController = PageController();
//   bool isLast = false;
//   bool isFirst = true;
//   @override
//   void initState() {
//     super.initState();
//     pageController.addListener(() {
//       setState(() {
//         positionPage = pageController.page!;
//       });
//     });
//   }

//   ProductController controller = Get.find<ProductController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Stack(
//         children: [
//           FlexibleSpaceBar(
//               background: controller.productDetails['files'].isEmpty
//                   ? Container(
//                       color: AppLightColors.primaryColor,
//                     )
//                   : PageView.builder(
//                       itemCount: controller.productDetails['files'].length,
//                       controller: pageController,
//                       onPageChanged: (int i) {
//                         if (i ==
//                             controller.productDetails['files'].length - 1) {
//                           setState(() {
//                             isLast = true;
//                           });
//                         } else {
//                           setState(() {
//                             isLast = false;
//                           });
//                         }
//                         if (i != 0) {
//                           setState(() {
//                             isFirst = false;
//                           });
//                         } else {
//                           setState(() {
//                             isFirst = true;
//                           });
//                         }
//                       },
//                       itemBuilder: (context, index) {
//                         return CachedNetworkImage(
//                           imageUrl: urlIMG +
//                               controller.productDetails['files'][index]['path'],
//                           imageBuilder: (context, imageProvider) => Container(
//                             // height: 150,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(
//                                   getRes(context,  10),
//                                 ),
//                               ),
//                               image: DecorationImage(
//                                 image: imageProvider,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           placeholder: (context, url) => Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(
//                                       getRes(context,  10))),
//                             ),
//                             child: BlurHash(
//                               hash:
//                                   'L5H2EC=PM+yV0g-mq.wG9c010J}I', // كود `blurhash` (يتم توليده من الصورة)
//                               imageFit: BoxFit.fill,
//                             ),
//                           ),
//                           errorWidget: (context, url, error) => Center(
//                             child:
//                                 Icon(Icons.error, color: Colors.red, size: 40),
//                           ),
//                           width: double.maxFinite,
//                           fit: BoxFit.fill,
//                         );
//                       })),
//           controller.productDetails['files'].length <= 1
//               ? Container()
//               : Positioned(
//                   bottom: getRes(context,  15),
//                   right: getRes(context,  5),
//                   // left: 20,
//                   left: getRes(context,  5),
//                   child: Container(
//                     // height: 50,
//                     width: double.infinity,
//                     // width: 50,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         isFirst
//                             ? Container()
//                             : IconButton(
//                                 onPressed: () {
//                                   pageController.previousPage(
//                                     duration: Duration(milliseconds: 750),
//                                     curve: Curves.ease,
//                                   );
//                                 },
//                                 icon: Icon(
//                                   Icons.arrow_back_ios,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                         isLast
//                             ? Container()
//                             : IconButton(
//                                 onPressed: () {
//                                   pageController.nextPage(
//                                     duration: Duration(milliseconds: 750),
//                                     curve: Curves.ease,
//                                   );
//                                 },
//                                 icon: Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: Colors.black,
//                                 ),
//                               )
//                       ],
//                     ),
//                     // color: Colors.red,
//                   ),
//                 )
//         ],
//       );
//     });
//   }
// }
