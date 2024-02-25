import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:tube_organize/core/colors.dart';
import 'package:tube_organize/services/firebase_services.dart';

class CreateFolderScreen extends StatefulWidget {
  const CreateFolderScreen({super.key});

  @override
  State<CreateFolderScreen> createState() => _CreateFolderScreenState();
}

class _CreateFolderScreenState extends State<CreateFolderScreen> {
  TextEditingController folderNameController = TextEditingController();

  File? selectedImage;

  final ImagePicker _imagePicker = ImagePicker();

  Future getImage() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  uploadFolder() async {
    if (selectedImage != null && folderNameController.text.isNotEmpty) {
      String id = randomAlphaNumeric(10);

      Reference storageRef =
          FirebaseStorage.instance.ref().child("FolderImage").child(id);
      final UploadTask task = storageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> folderInfo = {
        "id":id,
        "folder_name": folderNameController.text.trim(),
        "image": downloadUrl,
        "video_count":"0",
      };
      await FirebaseServicesMethods()
          .createNewFolder(folderInfo, id)
          .then((value) {
        CherryToast.success(
          title: const Text(
            "Folder created successfully",
            style: TextStyle(
              fontFamily: 'Raleway',
              color: Colors.black,
            ),
          ),
        ).show(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create New Folder",
          style: TextStyle(
            fontFamily: 'Raleway',
            color: txtBlackColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.chevron_left,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload an image for the folder.",
              style: TextStyle(
                fontFamily: 'Raleway',
                color: txtBlackColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            selectedImage == null
                ? GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          CupertinoIcons.camera,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  )
                : Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Add Folder Name",
              style: TextStyle(
                fontFamily: 'Raleway',
                color: txtBlackColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: TextField(
                controller: folderNameController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Folder Name',
                    hintStyle: TextStyle(
                      fontFamily: 'Raleway',
                    )),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                uploadFolder();
              },
              child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.all(
          width: 0.8,
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Center(
        child: Text(
          "Create",
          style: TextStyle(
            fontFamily: 'Raleway',
            color: Theme.of(context).colorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),),
          ],
        ),
      ),
    );
  }
}
