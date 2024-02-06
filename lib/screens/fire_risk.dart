import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/util/break_points.dart';

class FireRisk extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  static const _title = "Fire Risk";
  static const _fireDescription =
      "Note the level of fuel on the ground (high, medium, low), "
      "as well as the density and structure of the forest. "
      "Are there abundant ladder fuels? What is the potential for ignition?";
  static const _buttonLabelPrevious = "Previous";
  static const _buttonLabelNext = "Next";

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildFireRiskInput(context),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonPrevious(context),
              _buildButtonNext(context),
            ],
          ),
        ],
      ),
    );
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds a TextField with a label, helper text, and an outline.
  Widget _buildTextInput(BuildContext context, label, helper) {
    return TextField(
      controller: _textEditingController,
      maxLines:
          null, // Setting this to null allows the TextField to expand as needed
      keyboardType: TextInputType.multiline, // Specify the keyboard type
      decoration: InputDecoration(
        labelText: label,
        helperText: helper,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildFireRiskInput(BuildContext context) {
    return _buildTextInput(context, _title, _fireDescription);
  }

  // Buttons ///////////////////////////////////////////////////////////////////
  Widget _buildButtonPrevious(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(_buttonLabelPrevious),
    );
  }

  Widget _buildButtonNext(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(_buttonLabelNext),
    );
  }
}
