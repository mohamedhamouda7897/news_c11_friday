import 'package:flutter/material.dart';
import 'package:news_c11_friday/apis/api_manager.dart';
import 'package:news_c11_friday/models/categoryModel.dart';
import 'package:news_c11_friday/screens/categories.dart';
import 'package:news_c11_friday/screens/drawer_tab.dart';
import 'package:news_c11_friday/screens/tab_bar.dart';
import 'package:news_c11_friday/screens/tab_item.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image:
              DecorationImage(image: AssetImage("assets/images/pattern.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: DrawerTab(
          onClick: onDrawerClick,
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          iconTheme: IconThemeData(color: Colors.white, size: 35),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )),
          title: Text(
            "News App",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
        body: selectedCategory == null
            ? CategoriesTab(
                onClick: onCategorySelect,
              )
            : TabBarWidget(
                id: selectedCategory!.id,
              ),
      ),
    );
  }

  CategoryModel? selectedCategory = null;

  onDrawerClick(id) {
    if (id == DrawerTab.CATEGORY_ID) {
      selectedCategory = null;
      Navigator.pop(context);
    } else if (id == DrawerTab.SETTINGS_ID) {}
    setState(() {});
  }

  onCategorySelect(CategoryModel cat) {
    selectedCategory = cat;
    setState(() {});
  }
}
