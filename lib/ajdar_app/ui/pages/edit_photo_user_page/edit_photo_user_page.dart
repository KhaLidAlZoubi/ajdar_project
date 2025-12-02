import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// صفحة بسيطة لاختيار صورة الملف الشخصي وحفظها.
///
/// التعليمات:
/// - أضف `image_picker` إلى pubspec.yaml:
///   image_picker: ^0.8.7+4  // أو أحدث نسخة متوافقة
/// - ضع منطق الرفع (upload) داخل الدالة `_onSavePressed` حسب حاجتك.

class EditPhotoUserPage extends StatefulWidget {
  const EditPhotoUserPage({Key? key}) : super(key: key);

  @override
  State<EditPhotoUserPage> createState() => _EditPhotoUserPageState();
}

class _EditPhotoUserPageState extends State<EditPhotoUserPage> {
  // final ImagePicker _picker = ImagePicker();

  Widget _buildAvatar(double size) {
    final border = BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade300, width: 2),
    );

    if (AuthCubit.get(context).imageFile != null) {
      return Container(
        width: size,
        height: size,
        decoration: border,
        child: ClipOval(
          child: Image.file(
            File(AuthCubit.get(context).imageFile!.path),
            fit: BoxFit.cover,
            width: size,
            height: size,
          ),
        ),
      );
    }

    // صورة افتراضية (أيقونة)
    return Container(
      width: size,
      height: size,
      decoration: border.copyWith(color: Colors.white),
      child: Center(
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double avatarSize = 140;

    return Scaffold(
      appBar: AppBar(title: const Text('تعديل الصورة الشخصية')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            // Avatar
            Center(child: _buildAvatar(avatarSize)),
            const SizedBox(height: 16),

            // أزرار اختيار الصورة
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => AuthCubit.get(
                    context,
                  ).getImage(source: ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('اختيار من المعرض'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => AuthCubit.get(
                    context,
                  ).getImage(source: ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('التقاط صورة'),
                ),
              ],
            ),

            const Spacer(),

            // زر الحفظ
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                // onPressed: _isSaving ? null : _onSavePressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child:
                    //  _isSaving
                    //     ? const SizedBox(
                    //         height: 20,
                    //         width: 20,
                    //         child: CircularProgressIndicator(strokeWidth: 2),
                    //       )
                    //     :
                    const Text('حفظ'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
