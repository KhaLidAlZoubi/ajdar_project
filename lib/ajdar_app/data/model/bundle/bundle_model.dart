import 'package:flutter/material.dart';

class BundleModel {
  IconData icon;
  String title;
  String description;
  String date;
  String status;
  BundleModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });
}

List<BundleModel> bundles = [
  BundleModel(
    icon: Icons.category_outlined,
    title: 'YNB - 0001',
    description: 'الأحد 14 مارس الساعة 12 مساءا حتى الساعة الرابعة فجرا',
    date: '14/7/2024',
    status: 'h',
  ),
  BundleModel(
      icon: Icons.category_outlined,
      title: 'باقة لؤلؤة الديار',
      description: 'تنتهي الباقة بعد عشرة ايام',
      date: '20/7/2024',
      status: 'c'),
  BundleModel(
      icon: Icons.edit_note,
      title: 'YNB - 001',
      description: 'الأحد 14 مارس الساعة 12 مساءا حتى الساعة الرابعة فجرا',
      date: '20/7/2024',
      status: 'co'),
  BundleModel(
    icon: Icons.access_time,
    title: 'YNB - 001',
    description: 'الأحد 14 مارس الساعة 12 مساءا حتى الساعة الرابعة فجرا',
    date: '20/7/2024',
    status: 'nr',
  ),
  BundleModel(
    icon: Icons.done,
    title: 'YNB - 001',
    description: 'الأحد 14 مارس الساعة 12 مساءا حتى الساعة الرابعة فجرا',
    date: '20/7/2024',
    status: 'dn',
  ),
  BundleModel(
      icon: Icons.category_outlined,
      title: 'YNB - 001',
      description: 'الأحد 14 مارس الساعة 12 مساءا حتى الساعة الرابعة فجرا',
      date: '20/7/2024',
      status: 's'),
];
