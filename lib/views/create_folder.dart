import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tube_organize/core/colors.dart';
import 'package:tube_organize/views/widgets/custom_btn_widget.dart';

class CreateFolderScreen extends StatefulWidget {
  const CreateFolderScreen({super.key});

  @override
  State<CreateFolderScreen> createState() => _CreateFolderScreenState();
}

class _CreateFolderScreenState extends State<CreateFolderScreen> {
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
        margin: const EdgeInsets.only(top:10,left: 20,right: 20),
        child:  Column(
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
            const SizedBox(height: 15,),
            Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0,color: Theme.of(context).colorScheme.primary,),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Icon(CupertinoIcons.camera,color: Theme.of(context).colorScheme.primary,),
              ),
            ),
            const SizedBox(height: 15,),
            const Text(
              "Add Folder Name",
              style: TextStyle(
                fontFamily: 'Raleway',
                color: txtBlackColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10,),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Folder Name',
                  hintStyle: TextStyle(
                    fontFamily: 'Raleway',
                  )
                ),
              ),
            ),
            const SizedBox(height: 25,),
            const CustomBtnWidget(),
          ],
        ),
      ),
    );
  }
}
