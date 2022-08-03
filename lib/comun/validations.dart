import 'package:flutter/material.dart';

// Verifica si hay imagen guardada y colocar un suplente en caso contrario
ImageProvider verifyPhoto(String? photoRoute) {
    if (photoRoute!.isEmpty) {
      return const NetworkImage(
          'https://drive.google.com/uc?export=view&id=1KkKZ0bCSwVhhqhS5zIqw3Y5MBlQq0zs3');
    } else {
      return NetworkImage(photoRoute);
    }
  }

  // Verifica el genero del medico
  String verifyGender(String gender) {
    if (gender == 'F') {
      return "Dra.";
    } else {
      return "Dr.";
    }
  }
