import 'package:flutter/material.dart';
import 'package:tasks_ealim/Core/Utils/app_colors.dart';

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
