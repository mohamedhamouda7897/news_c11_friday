import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  Color color;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.color});

  static List<CategoryModel> getCategories() {
    return [
      CategoryModel(
          id: "business",
          name: "Business",
          image: "assets/images/bussines.png",
          color: Color(0xFFCF7E48)),
      CategoryModel(
          id: "sports",
          name: "Sports",
          image: "assets/images/sports.png",
          color: Colors.red),
      CategoryModel(
          id: "entertainment",
          name: "Entertainment",
          image: "assets/images/Politics.png",
          color: Color(0xFF003E90)),
      CategoryModel(
          id: "health",
          name: "Health",
          image: "assets/images/health.png",
          color: Colors.pink),
      CategoryModel(
          id: "science",
          name: "Science",
          image: "assets/images/science.png",
          color: Colors.yellow),
      CategoryModel(
          id: "technology",
          name: "Technology",
          image: "assets/images/environment.png",
          color: Colors.green),
      CategoryModel(
          id: "general",
          name: "General",
          image: "assets/images/Politics.png",
          color: Colors.red),
    ];
  }
}
