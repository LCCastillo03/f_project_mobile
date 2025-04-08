import 'package:flutter/material.dart';

class AppCategories {
  static const Map<String, dynamic> categories = {
    "Healthcare": {
      "icon": Icons.health_and_safety,
      "color": Color(0xFF6A1B9A),
      "description": "Services and products related to health and wellness."
    },
    "Business": {
      "icon": Icons.business_center,
      "color": Color(0xFF6A1B9A),
      "description":
          "Everything related to the corporate world and enterprises."
    },
    "Education": {
      "icon": Icons.school,
      "color": Color(0xFF6A1B9A),
      "description": "Learning resources and academic opportunities."
    },
    "Science": {
      "icon": Icons.science,
      "color": Color(0xFF6A1B9A),
      "description": "Exploration, experiments, and scientific advancements."
    },
    "Personal Growth": {
      "icon": Icons.self_improvement,
      "color": Color(0xFF6A1B9A),
      "description": "Self-help, skills development, and personal enrichment."
    },
  };
}
