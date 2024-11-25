import 'package:flutter/material.dart';


class RepresentativePhotoLabel extends StatelessWidget {
  const RepresentativePhotoLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        color: Colors.black.withOpacity(0.5),
        child: const Text(
          '대표사진',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
      ),
    );
  }
}