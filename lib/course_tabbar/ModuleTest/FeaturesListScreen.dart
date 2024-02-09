import 'package:flutter/material.dart';

import '../../models/submodule_model.dart';

class FeaturesListScreen extends StatelessWidget {
  final Submodule submodule;

  const FeaturesListScreen({Key? key, required this.submodule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(submodule.title),
      ),
      body: ListView.builder(
        itemCount: submodule.featureCallbacks.length,
        itemBuilder: (context, index) {
          final feature = submodule.featureCallbacks[index];
          return ListTile(
            leading: Icon(feature.icon, color: feature.iconColor), // Uses icon and color based on completion
            title: Text(feature.title),
            onTap: feature.callback,
          );
        },
      ),
    );
  }
}
