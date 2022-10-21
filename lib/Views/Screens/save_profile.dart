import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grab_guard/Features/storage/storage_provider.dart';

import 'package:grab_guard/Models/user_model.dart';



import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class SaveProfileScreen extends ConsumerStatefulWidget {
  const SaveProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SaveProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<SaveProfileScreen> {
  XFile? _im;
  UserModel? user;
  bool loading = true;
  bool disabled = true;

  var networkImage = "";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  selectImageFromGallery() async {
    XFile? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      var imageUrl = await ref
          .read(storageProvider)
          .uploadImageToStorage('Add your Profile Pic', File(image.path));
      setState(() {
        networkImage = imageUrl;
      });
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file =
        await _imagePicker.pickImage(source: source, imageQuality: 50);
    if (_file != null) {
      return await _file;
    }
    print('No Image Selected');
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  " Profile Setup",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      _im != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(networkImage),
                              backgroundColor: Colors.amber,
                            )
                          : CircleAvatar(
                              radius: 64,
                              //already used profile pic shows here
                              backgroundImage: NetworkImage(networkImage),
                              backgroundColor: Colors.amber,
                            ),
                      Positioned(
                          bottom: 0,
                          left: 84,
                          child: InkWell(
                            onTap: () {
                              selectImageFromGallery();
                            },
                            child: ClipOval(
                              child: Container(
                                padding: EdgeInsets.all(3),
                                color: Colors.white,
                                child: ClipOval(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.amber,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'First Name *',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'Last Name *',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'phone number *',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'city *',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'Address *',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 35),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: 'email *',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // ToDo add addition Logic

                        if (emailController.text != null &&
                            phoneNumberController.text != null &&
                            addressController.text != null &&
                            firstNameController.text != null &&
                            networkImage != "") {
                          ref.read(storageProvider).saveUser( city :cityController.text,     firstName: firstNameController.text, lastName: lastNameController.text, phoneNumber: phoneNumberController.text, email: emailController.text, address: addressController.text, profilePicUrl: networkImage, context: context);
                        } else {
                          EasyLoading.showError("All field must be Selected");
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ));
  }
}
