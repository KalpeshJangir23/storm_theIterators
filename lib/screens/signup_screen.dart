import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexus/resources/auth_methods.dart';
import 'package:nexus/responsive/mobile_screen_layout.dart';
import 'package:nexus/responsive/responsive_layout_screen.dart';
import 'package:nexus/screens/login_screen.dart';
import 'package:nexus/utils/colors.dart';
import 'package:nexus/utils/utils.dart';
import 'package:nexus/widgets/text_field_input.dart';

import '../responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _addBioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _addBioController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpScreen() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _userNameController.text,
      bio: _addBioController.text,
      file: _image ?? Uint8List(0),
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg"),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ))
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            TextFieldInput(
              textEditingController: _userNameController,
              hintText: "Enter your User Name",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 18,
            ),
            TextFieldInput(
              textEditingController: _emailController,
              hintText: "Enter your Email",
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 18,
            ),
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: "Enter your Password",
              textInputType: TextInputType.text,
              isPass: true,
            ),
            const SizedBox(
              height: 18,
            ),
            TextFieldInput(
              textEditingController: _addBioController,
              hintText: "Enter your Bio",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 18,
            ),
            InkWell(
              onTap: signUpScreen,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: blueColor,
                ),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Sign up'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don't have an account?"),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Login ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
