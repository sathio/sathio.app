import 'package:flutter/material.dart';

enum ServiceCategory {
  all,
  identity,
  subsidies,
  healthcare,
  education,
  finance,
  utilities,
  travel,
  shopping,
  other,
}

class ServiceModel {
  final String id;
  final String title;
  final String description;
  final IconData iconData; // Using IconData for MVP
  final ServiceCategory category;
  final List<String> steps;
  final bool isAutomated; // True for LAM-supported services

  const ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconData,
    required this.category,
    this.steps = const [],
    this.isAutomated = true,
  });
}
