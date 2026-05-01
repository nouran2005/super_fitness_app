import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';

class ProfileAvatar extends StatelessWidget {
  final double? radius;
  final String image;
  final bool isUploading;
  final void Function(File photo)? onPhotoPicked;

  const ProfileAvatar({
    super.key,
    this.radius,
    required this.image,
    this.isUploading = false,
    this.onPhotoPicked,
  });

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile != null && onPhotoPicked != null) {
      onPhotoPicked!(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarRadius = radius ?? MediaQuery.of(context).size.width * 0.13;

    return Stack(
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundColor: Colors.grey.shade800,
          child: ClipOval(
            child: isUploading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade400,
                    child: Container(
                      width: avatarRadius * 2,
                      height: avatarRadius * 2,
                      color: Colors.grey.shade700,
                    ),
                  )
                : image.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: image,
                    cacheKey: image,
                    fit: BoxFit.cover,
                    width: avatarRadius * 2,
                    height: avatarRadius * 2,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade400,
                      child: Container(
                        width: avatarRadius * 2,
                        height: avatarRadius * 2,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.person,
                      size: avatarRadius,
                      color: Colors.white54,
                    ),
                  )
                : Icon(Icons.person, size: avatarRadius, color: Colors.white54),
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: isUploading ? null : _pickImage,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: const Icon(
                Icons.edit_outlined,
                color: AppColors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
