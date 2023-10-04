import 'package:flutter/material.dart';
import 'package:nexus/provider/user_provider.dart';
import 'package:nexus/screens/post_add.dart';

import 'package:provider/provider.dart';

class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new UserProvider(),
      child: PostAdd(),
    );
  }
}
