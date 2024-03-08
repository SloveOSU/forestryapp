import "package:flutter/material.dart";
import "package:forestryapp/components/db_listenable_builder.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/landowner.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:forestryapp/screens/site_characteristics_form.dart";
import "package:forestryapp/util/validation.dart";
import 'package:provider/provider.dart';
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import 'package:forestryapp/components/unsaved_changes.dart';

class BasicInformationForm extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Basic Information";
  static const _nameHeading = "Area name";
  static const _nameDescription =
      "If the landowner does not have a name for the "
      "area, make up a descriptive name (meadow, young DF stand, etc.).";
  static const _acresHeading = "Acres";
  static const _acresDescription = "Approximate acres for the stand or area.";
  static const _landownerHeading = "Landowner";
  static const _goalsHeading = "Landowner Goals and Objectives";
  static const _goalDescription =
      "The landowner's goals and objectives for this "
      "specific stand/area.";

  final _formKey = GlobalKey<FormState>();

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen with a form to add name, landowner, and acres to the area.
  BasicInformationForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        showFormLinks: true,
        title: BasicInformationForm._title,
        body: FormScaffold(
            nextPage: SiteCharacteristicsForm(),
            child: Form(
              key: _formKey,
              child: Wrap(
                children: <Widget>[
                  _buildNameInput(context),
                  _buildAcresInput(context),
                  _buildLandownerInput(context),
                  _buildGoalsInput(context),
                ],
              ),
            )));
  }

  /// Builds a text input field to enter the stand/area name.
  Widget _buildNameInput(BuildContext context) {
    final basicInfoData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return PortraitHandlingSizedBox(
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: BasicInformationForm._nameHeading,
          helperText: BasicInformationForm._nameDescription,
        ),
        initialValue: basicInfoData.name,
        onChanged: (text) {
          basicInfoData.name = text;
          unsavedChangesNotifier.setUnsavedChanges(true);

          // Okay to run validation after because the only thing being validated
          // is if it is empty or not.
          if (!_formKey.currentState!.validate()) {
            // Set null to allow full deletion of name.
            basicInfoData.name = null;
          }
        },
        validator: Validation.isNotEmpty,
      ),
    );
  }

  /// Builds a numeric input field to enter the acres for the area.
  Widget _buildAcresInput(BuildContext context) {
    final basicInfoData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return PortraitHandlingSizedBox(
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: BasicInformationForm._acresHeading,
          helperText: BasicInformationForm._acresDescription,
        ),
        initialValue: () {
          if (basicInfoData.acres == null) {
            return '';
          }
          return basicInfoData.acres.toString();
        }(),
        onChanged: (text) {
          if (text.isNotEmpty) {
            basicInfoData.acres = double.tryParse(text);
            unsavedChangesNotifier.setUnsavedChanges(true);
          } else {
            basicInfoData.acres = null;
          }
        },
      ),
    );
  }

  /// Builds a Search bar to select a Landowner for the area.
  Widget _buildLandownerInput(BuildContext context) {
    final basicInfoData = Provider.of<Area>(context);

    List<Landowner> landownerOptions =
        Provider.of<LandownerCollection>(context).landowners;

    Landowner? getInitialValue() {
      if (basicInfoData.landownerID != null) {
        return landownerOptions
            .firstWhere((element) => basicInfoData.landownerID == element.id);
      }
      return null;
    }

    // Use [DBListenableBuilder] here because if there is an option to create a
    // new user, saving that user to the database would change the state of the
    // listenable which would in turn force this to rebuild. This is needed in
    // the event we do a `Navigator.pop(context)` from the creation screen to
    // get back here, otherwise the list of landowners will be out of date.
    return DBListenableBuilder(
      builder: (context, _) {
        return DropdownMenu(
            enableFilter: true,
            requestFocusOnTap: true,
            expandedInsets: EdgeInsets.zero,
            leadingIcon: const Icon(Icons.search),
            label: const Text(_landownerHeading),
            initialSelection: getInitialValue(),
            dropdownMenuEntries:
                landownerOptions.map<DropdownMenuEntry<Landowner>>(
              (Landowner landowner) {
                return DropdownMenuEntry(
                    value: landowner, label: landowner.name);
              },
            ).toList(),
            onSelected: (Landowner? value) {
              if (value != null) {
                basicInfoData.landownerID = value.id;
              }
            },
            errorText: () {
              if (basicInfoData.landownerID == null) {
                return "Please select a landowner.";
              }
            }());
      },
    );
  }

  /// Builds a text input field to enter the landowner's goals for the area.
  Widget _buildGoalsInput(BuildContext context) {
    final basicInfoData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return FreeTextBox(
        labelText: BasicInformationForm._goalsHeading,
        helperText: BasicInformationForm._goalDescription,
        initialValue: basicInfoData.goals,
        onChanged: (text) {
          basicInfoData.goals = text;
          unsavedChangesNotifier.setUnsavedChanges(true);
        });
  }
}
