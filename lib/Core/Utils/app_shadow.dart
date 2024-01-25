import 'package:flutter/material.dart';
import 'app_colors.dart';

List<Shadow> shadow = [
  const BoxShadow(
    color: AppColors.white,
    blurRadius: 10,
    offset: Offset(0, 1),
  ),
  const BoxShadow(
    color: AppColors.white,
    blurRadius: 10,
    offset: Offset(0, -1),
  ),
];
