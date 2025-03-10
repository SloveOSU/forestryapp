import 'package:flutter/material.dart';
import 'package:forestryapp/database/dao_area.dart';
import 'package:forestryapp/database/dao_landowner.dart';
import 'package:forestryapp/document_converters/docx_converter.dart';
import 'package:forestryapp/models/area_collection.dart';
import 'package:forestryapp/models/landowner_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "forestryapp.dart";
import 'package:forestryapp/database/database_manager.dart';

// Winter 2025 commits begin
// creating new branch feature-gallery

void main() async {
  // Need `ensureInitialized()` when main is `async` because the we are waiting
  // for shared preferences to be initialized before calling `runApp()`.
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseManager.initialize();

  runApp(
    ForestryApp(
      await SharedPreferences.getInstance(),
      LandownerCollection(await DAOLandowner.fetchFromDatabase()),
      AreaCollection(await DAOArea.fetchFromDatabase()),
      await DOCXConverter.create(),
    ),
  );
}
