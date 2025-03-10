import 'package:flutter/material.dart';
import 'package:forestryapp/database/dao_area.dart';
import 'package:forestryapp/database/dao_landowner.dart';
import 'package:forestryapp/document_converters/docx_converter.dart';
import 'package:forestryapp/models/area_collection.dart';
import 'package:forestryapp/models/landowner_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "forestryapp.dart";
import 'package:forestryapp/database/database_manager.dart';
// needed for database reinstantiate
import 'package:sqflite/sqflite.dart' as sqflite;

// Winter 2025 commits begin
// creating new branch feature-gallery
// commit #1 - added changes to gradle, kotlin, and pubspec
// commit #2 - adding screen
// commit #3 - PDF export feature
// commit #4 - updated SQL files for database persistence

void main() async {
  // Need `ensureInitialized()` when main is `async` because the we are waiting
  // for shared preferences to be initialized before calling `runApp()`.
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseManager.initialize();


  // modify this variable to reinstantiate the flutter database
  // this is needed if the DDL or DML is altered in a structural way
  // set the variable to false if you want to keep the database structure
  // set the variable to true if you want to update the database structure
  // run twice after delete
  bool reinstatiateDatabase = false;
  // ignore: dead_code
  if(reinstatiateDatabase) {
    await sqflite.deleteDatabase('forestryapp.db');  
  }  

  runApp(
    ForestryApp(
      await SharedPreferences.getInstance(),
      LandownerCollection(await DAOLandowner.fetchFromDatabase()),
      AreaCollection(await DAOArea.fetchFromDatabase()),
      await DOCXConverter.create(),
    ),
  );
}
