import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexus/resources/firestore_methods.dart';
import 'package:nexus/utils/colors.dart';
import 'package:nexus/utils/utils.dart';

import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  // _selectImage(BuildContext parentContext) async {
  //   return showDialog(
  //       context: parentContext,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           title: const Text('Create a Post'),
  //           children: [
  //             SimpleDialogOption(
  //               padding: const EdgeInsets.all(20),
  //               onPressed: () async {
  //                 Navigator.of(context).pop();
  //                 Uint8List file = await pickImage(ImageSource.camera);
  //                 setState(() {
  //                   _file = file;
  //                 });
  //               },
  //               child: const Text('Take a photo'),
  //             ),
  //             SimpleDialogOption(
  //               padding: const EdgeInsets.all(20),
  //               onPressed: () async {
  //                 Navigator.of(context).pop();
  //                 Uint8List file = await pickImage(ImageSource.gallery);
  //                 setState(() {
  //                   _file = file;
  //                 });
  //               },
  //               child: const Text('Choose photo from gallery'),
  //             ),
  //             SimpleDialogOption(
  //               padding: const EdgeInsets.all(20),
  //               onPressed: () async {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Cancel'),
  //             ),
  //           ],
  //         );
  //       });
  // }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    try {
      String res = await FirestoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );

      if (res == "success") {
        showSnackBar('Posted!', context);
      } else {
        showSnackBar(res, context);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final UserProvider userProvider = Provider.of<UserProvider>(context);

    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              title: const Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {},
                  // () => postImage(
                  //   userProvider.getUser.uid,
                  //   userProvider.getUser.username,
                  //   userProvider.getUser.photoUrl,
                  // ),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/235986/pexels-photo-235986.jpeg?auto=compress&cs=tinysrgb&w=600",
                        // userProvider.getUser.photoUrl,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            hintText: 'Write a caption...',
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}
