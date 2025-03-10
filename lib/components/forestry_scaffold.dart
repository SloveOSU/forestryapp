// material library
import 'package:flutter/material.dart';
// models
import 'package:forestryapp/models/settings.dart';
// screens
import 'package:forestryapp/screens/area_index.dart';
import 'package:forestryapp/screens/basic_information_form.dart';
import 'package:forestryapp/screens/form_review.dart';
import 'package:forestryapp/screens/home.dart';
import 'package:forestryapp/screens/invasive_form.dart';
import 'package:forestryapp/screens/landowner_index.dart';
import 'package:forestryapp/screens/mistletoe_form.dart';
import 'package:forestryapp/screens/insects_form.dart';
import 'package:forestryapp/screens/photos_files_form.dart';
import 'package:forestryapp/screens/settings_review.dart';
import 'package:forestryapp/screens/site_characteristics_form.dart';
import 'package:forestryapp/screens/vegetative_conditions_form.dart';
import 'package:forestryapp/screens/road_health_form.dart';
import 'package:forestryapp/screens/water_issues_form.dart';
import 'package:forestryapp/screens/fire_risk_form.dart';
import 'package:forestryapp/screens/other_issues_form.dart';
import 'package:forestryapp/screens/diagnosis_form.dart';
// components
import 'package:forestryapp/components/unsaved_changes.dart';
// state
import 'package:provider/provider.dart';

/// A component to ensure common high level layout across screens of the app.
///
/// This scaffold can be used to ensure each screen has the same drawer
/// navigation as well as common layout choices like padding.
class ForestryScaffold extends StatelessWidget {
  // Instance variables ////////////////////////////////////////////////////////
  final String  _title        ;
  final Widget  _body         ;
  final Widget? _fab          ;
  final bool    _showFormLinks;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates Material design scaffold with provided [title] and [body].
  ///
  /// Can optionally provide a Floating Action Button to shower in lower right
  /// corner. If not specified, no FAB will be shown.
  const ForestryScaffold({
    required  String    title                   ,
    required  Widget    body                    ,
              Widget?   fab                     ,
              bool      showFormLinks = false   ,
    super.key,
  })  : _title          = title                 ,
        _body           = body                  ,
        _fab            = fab                   ,
        _showFormLinks  = showFormLinks         ;



  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    
    // builds app bar template
    return Scaffold(
      appBar  : AppBar(
        title       : Text(_title),
        centerTitle : true
      ),
      body    : Padding(
        padding     : const EdgeInsets.all(30),
        child       : _body
      ),
      drawer  : Drawer(
        child       : ListView(children : _buildDrawerItems(context))
      ),
      floatingActionButton: _fab ?? Container(),
    );
  }













  List<Widget> _buildDrawerItems(BuildContext context) {

    // use provider created in forestryapp()
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(
          context,
          listen: false
        ); // Access the UnsavedChangesNotifier

    //
    //  Core list of links to be included into menu selection
    //
    List<Widget> mainLinks = [

        ListTile(
        title: const Text('Home'),
        leading: const Icon(Icons.home),
        onTap: () {
          _navigateWithUnsavedChanges(
            context,
            unsavedChangesNotifier,
            const Home(),
          );
        },
      ),
      ListTile(
        title: const Text('Settings'),
        leading: const Icon(Icons.settings),
        onTap: () {
          _navigateWithUnsavedChanges(
            context,
            unsavedChangesNotifier,
            SettingsReview(
              settings: Provider.of<Settings>(context, listen: false),
            ),
          );
        },
      ),
      ListTile(
        title: const Text('Landowners'),
        leading: const Icon(Icons.person),
        onTap: () {
          _navigateWithUnsavedChanges(
              context, unsavedChangesNotifier, const LandownerIndex());
        },
      ),
      ListTile(
        title: const Text('Areas'),
        leading: const Icon(Icons.forest),
        onTap: () {
          _navigateWithUnsavedChanges(
              context, unsavedChangesNotifier, const AreaIndex());
        },
      ),
    ];


    //
    // Secondary area links - not available until basic information filled out
    // 
    // Links to the Area form input screens
    List<Widget> areaFormLinks = [
      const Divider(),




      ListTile(
        title: const Text('Basic Information'),
        leading: const Icon(Icons.badge),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BasicInformationForm()),
          );
        },
      ),


      ///////////////////////////////////////////////////
      //
      //  New Tile - Photos and Files
      //
      ///////////////////////////////////////////////////
      ListTile(
        title: const Text('Photos and Files'),
        leading: const Icon(Icons.camera),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PhotosFilesForm()),
          );
        },
      ),
      ///////////////////////////////////////////////////


      ListTile(
        title: const Text('Site Characteristics'),
        leading: const Icon(Icons.place),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SiteCharacteristicsForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Vegetative Conditions'),
        leading: const Icon(Icons.grass),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VegetativeConditionsForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Insects & Diseases'),
        leading: const Icon(Icons.pest_control),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InsectsForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Invasives & Wildlife'),
        leading: const Icon(Icons.pest_control_rodent),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InvasiveForm()));
        },
      ),
      ListTile(
        title: const Text('Mistletoe'),
        leading: const Icon(Icons.spa),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MistletoeForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Road Health'),
        leading: const Icon(Icons.edit_road),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RoadHealthForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Water Issues'),
        leading: const Icon(Icons.water_drop),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WaterIssuesForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Fire Risk'),
        leading: const Icon(Icons.local_fire_department),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FireRiskForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Other Issues'),
        leading: const Icon(Icons.report),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OtherIssuesForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Diagnosis & Suggestions'),
        leading: const Icon(Icons.lightbulb_outline_rounded),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DiagnosisForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Summary'),
        leading: const Icon(Icons.fact_check),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormReview()),
          );
        },
      ),
    ];


    //
    //  "Hamburger" menu controller
    //
    // Form links only appear when you are editing or creating an Area
    if (_showFormLinks) {
      mainLinks.addAll(areaFormLinks);
    }

    return mainLinks;
  }







  void _navigateWithUnsavedChanges(BuildContext context,
      UnsavedChangesNotifier unsavedChangesNotifier,
      Widget destination) {
    if (unsavedChangesNotifier.unsavedChanges) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title   : const Text('Unsaved Changes'),
          content : const Text('Are you sure you want to leave? Any unsaved changes will be lost.'),
          actions : [


            TextButton(
              onPressed : () {
                Navigator.pop(context); // Dismiss the dialog
              },
              child     : const Text('Cancel'),
            ),


            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dismiss the dialog
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => destination));
                unsavedChangesNotifier
                    .setUnsavedChanges(false); // Resetting to false here
              },
              child: const Text('Leave'),
            ),



          ],
        ),
      );
    } else {
      Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => destination
          )
      );
    }
  }
}
