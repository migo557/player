import 'package:flutter/material.dart';
import 'package:open_player/presentation/common/widgets/custom_back_button.dart';
import 'package:velocity_x/velocity_x.dart';

class EqualizerPage extends StatelessWidget {
  const EqualizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: "Equalizer".text.make(),
      ),
      body: "Coming Soon".text.makeCentered(),
    );
  }
}
