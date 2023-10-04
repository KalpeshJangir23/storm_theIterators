import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nexus/utils/colors.dart';

import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          colorFilter: const ColorFilter.mode(
            primaryColor,
            BlendMode.srcIn,
          ),
          height: 32,
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.chat))],
      ),
      body: PostCard(),
    );
  }
}
