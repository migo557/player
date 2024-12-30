import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/brightness_cubit/brightness_cubit.dart';

class CustomBrightnessShaderMask extends StatelessWidget {
  const CustomBrightnessShaderMask({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrightnessCubit, BrightnessState>(
      builder: (context, state) {
        return ShaderMask(
          shaderCallback: (bounds) {
            // Applying a linear gradient based on brightness value
            return LinearGradient(
              colors: [
                Colors.black.withValues(alpha:  1 -
                    state.videoPlayerBrightness), // Top half of the gradient
                Colors.black.withValues(
                    alpha: 1 -
                    state.videoPlayerBrightness), // Bottom half of the gradient
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn, // Mask the video using the shader
          child: child ??
              const SizedBox
                  .shrink(), // Default to an empty widget if child is null
        );
      },
    );
  }
}
