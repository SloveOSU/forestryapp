import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:forestryapp/components/read_only.dart';
import 'package:forestryapp/components/portrait_handling_sized_box.dart';
import 'package:forestryapp/screens/basic_information_form.dart';
import 'package:forestryapp/screens/site_characteristics_form.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/components/unsaved_changes.dart';
// photo picker
import 'package:image_picker/image_picker.dart';
import 'dart:io';


/// Represents a form for attaching a photo from the gallery linked to internal storage area.
///
/// This form allows users to display an image of their subject area for the report.
/// It includes a text input field for providing a name, along with a description for guidance.
class PhotosFilesForm extends StatefulWidget {

  /// Creates a screen to attach photos and files for report.
  PhotosFilesForm({super.key});


  @override
  State<PhotosFilesForm> createState() => _PhotosFilesFormState();
}

class _PhotosFilesFormState extends State<PhotosFilesForm> {
  // key used in constructor for FormScaffold
  final _formKey = GlobalKey<FormState>();

  static const _title                       = "Photos and Files"                  ;    
  static const _photoTitleLabel             = "Photo title"                       ;
  static const _photoTitleHelperText        = "Enter a title for the photo"       ;  
  static const _photoDescriptionLabel       = "Photo description"                 ;
  static const _photoDescriptionHelperText  = "Enter a description for the photo" ;
  static const _photoFilePathLabel          = "Photo File Path"                   ;
  static const _photoFilePathHelperText     = "Photo File Path Helper Text"       ;

  // used with photo gallery to store selected image file
  File?     _imageFile        ;
  String?   _imageFileString  ;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {



    return ForestryScaffold(
        showFormLinks : true                      ,
        title         : _title    ,        
        body          : FormScaffold(          

          prevPage  : BasicInformationForm()      ,
          nextPage  : SiteCharacteristicsForm()   ,
          child     : Form(

            key     : _formKey                      ,
            child   : Wrap(

              children: <Widget>[
                _buildPhotoTitle(context)             ,
                const SizedBox(height: 100)           ,
                _buildPhotoDescription(context)       ,
                const SizedBox(height: 100)           ,
                // _buildPhotoFilePath(context)          ,
                // const SizedBox(height: 100)           ,
                _accessPhotoGallery(context)                 ,
                const SizedBox(height: 200)           ,

                // add camera
                //CameraWidget()                        ,
              ],
            ),
          ),
        )
    );
  }

  /// Enter photo title 
  Widget _buildPhotoTitle(BuildContext context) {
    final photosAndFilesData      = Provider.of<Area>(context);
    final unsavedChangesNotifier  = Provider.of<UnsavedChangesNotifier>(context);

    return PortraitHandlingSizedBox(
      child: TextFormField(

          // form fields
          decoration: const InputDecoration(          
            labelText     : _photoTitleLabel        ,
            helperText    : _photoTitleHelperText   ,
          ),
          initialValue  : photosAndFilesData.photoName,
          onChanged     : (text) {
            
            // update object field
            photosAndFilesData.photoName = text            ;
            unsavedChangesNotifier.setUnsavedChanges(true)  ;
          }),
    );
  }

  /// Access or take pictures from internal camera
  Widget _buildPhotoDescription(BuildContext context) {
    final photosAndFilesData      = Provider.of<Area>(context)                    ;
    final unsavedChangesNotifier  = Provider.of<UnsavedChangesNotifier>(context)  ;

    //enter photo description
    return FreeTextBox(
        labelText     : _photoDescriptionLabel        ,
        helperText    : _photoDescriptionHelperText   ,
        initialValue  : photosAndFilesData.photoDescription           ,
        onChanged     : (text) {

          // update object field
          photosAndFilesData.photoDescription = text      ;
          unsavedChangesNotifier.setUnsavedChanges(true)  ;
        });
  }


  /// Access or take pictures from internal camera
  Widget _buildPhotoFilePath(BuildContext context) {
    final photosAndFilesData      = Provider.of<Area>(context)                    ;
    final unsavedChangesNotifier  = Provider.of<UnsavedChangesNotifier>(context)  ;
    
    String filePath = "No file selected";
    
    if (photosAndFilesData.photoFilePath != "null"){ 
      filePath = photosAndFilesData.photoFilePath.toString(); 
    }



    //enter photo description
    return ReadOnlyText(
        labelText     : _photoFilePathLabel                         ,
        helperText    : _photoDescriptionHelperText                 ,
        initialValue  :  filePath                                   ,
        onChanged     : (filePath) {

          if (photosAndFilesData.photoFilePath.toString() != "null"){ 
            filePath = photosAndFilesData.photoFilePath.toString(); 
            
          }

          unsavedChangesNotifier.setUnsavedChanges(true)  ;
        });
  }


  // displays selected photo from gallery
  Widget showImage() {
    if (_imageFile != null) {
      return Image.file(
        _imageFile!,
        width     : 300   ,
        height    : 300   ,
      );
    } else {
      return const Text(
        "No image selected"             ,
        textAlign: TextAlign.center     ,
      );
    }
  }


  // Access photo gallery
  Widget _accessPhotoGallery(BuildContext context) {


    final photosAndFilesData      = Provider.of<Area>(context)                    ;
    final unsavedChangesNotifier  = Provider.of<UnsavedChangesNotifier>(context)  ;

    if(photosAndFilesData.photoFilePath != null){
        _imageFile = photosAndFilesData.photoFile;
    }

  // used with button press to view photo gallery
  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        photosAndFilesData.photoFile = _imageFile;

        _imageFileString = _imageFile.toString();
        photosAndFilesData.photoFilePath = _imageFileString;
        unsavedChangesNotifier.setUnsavedChanges(true)  ;        
      }
    });
  }



  // remove image from current display and selection
  void removeImage(){
    setState(() {    
      _imageFileString                  = null                ;
      _imageFile                        = null                ;
      photosAndFilesData.photoFilePath  = null                ;
      photosAndFilesData.photoFile      = null                ;
      unsavedChangesNotifier.setUnsavedChanges(true)          ;           
    });
  }


    //enter photo description
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            
            Row( // select from gallery button
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text("Select Image from Gallery"),
                IconButton(
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  icon: const Icon(Icons.photo_library),
                ),

              ],

            ),

            // display selected image             
            showImage(),
            
            Row( // remove selected image button 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Remove Selected Image"),
                IconButton(
                  onPressed: () {                 
                      removeImage();                      
                  },
                  icon: const Icon(Icons.highlight_remove),
                ),
              ],              
            ),

            // display image
          ],
        ),
      );
  }








  
}
















