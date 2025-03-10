import "package:flutter/material.dart";

/// Widget for entering readonly text, can be reused in different pages.
///
/// It can be customized with various parameters
/// such as label text, helper text, hint text, initial value, and an
/// onChanged callback to handle text changes.
class ReadOnlyText extends StatelessWidget {
  // Instance variables ////////////////////////////////////////////////////////
  final String  labelText                 ;
  final String? helperText                ;
  final String? hintText                  ;
  final String? initialValue              ;
  final void Function(String) onChanged;

  /// Constructs a [ReadOnlyText] widget.
  ///
  /// The [labelText] parameter is required, while [helperText], [hintText],
  /// and [initialValue] are optional. The [onChanged] callback must be provided
  /// to handle text input changes.
  const ReadOnlyText({
    required  this.labelText      ,
              this.helperText     ,
              this.hintText       ,
              this.initialValue   ,
    required  this.onChanged      ,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines      : null                      , // allows infinite length
      keyboardType  : TextInputType.multiline   ,
      decoration    : InputDecoration(
          labelText   : labelText       ,
          helperText  : helperText      ,
          hintText    : hintText        ,
      ),
      initialValue  : initialValue              ,
      readOnly      : true                      ,
      onChanged     : onChanged                 ,
    );
  }
}
