import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/Control_visibility/controls_visibility_cubit.dart';
import '../../../../../logic/video_player_bloc/video_player_bloc.dart';

class VideoPlayerSpeedButtonWidget extends HookWidget {
  const VideoPlayerSpeedButtonWidget({
    super.key,
    required this.state,
  });

  final VideoPlayerReadyState state;

  @override
  Widget build(BuildContext context) {
    // Use ValueNotifier for reactive speed updates
    final speedNotifier = useState<double>(1.0);

    // Predefined speed options for quick selection
    final speedOptions = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

    // Listen to actual player speed changes
    useEffect(() {
      final controller = state.vlcPlayerController;
      void listener() {
        speedNotifier.value = controller.value.playbackSpeed;
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [state.vlcPlayerController]);

    return IconButton(
      icon: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.speed, color: Colors.white),
          Positioned(
            bottom: 0,
            child: Text(
              '${speedNotifier.value.toStringAsFixed(1)}x',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => _SpeedControlSheet(
            currentSpeed: speedNotifier.value,
            speedOptions: speedOptions,
            onSpeedChanged: (newSpeed) {
              state.vlcPlayerController.setPlaybackSpeed(newSpeed);
              speedNotifier.value = newSpeed;
            },
          ),
        );

        // Toggle controls visibility
        context.read<ControlsVisibilityCubit>().toggleVideoControlsVisibilty();
      },
    );
  }
}

class _SpeedControlSheet extends StatefulWidget {
  const _SpeedControlSheet({
    required this.currentSpeed,
    required this.speedOptions,
    required this.onSpeedChanged,
  });

  final double currentSpeed;
  final List<double> speedOptions;
  final ValueChanged<double> onSpeedChanged;

  @override
  _SpeedControlSheetState createState() => _SpeedControlSheetState();
}

class _SpeedControlSheetState extends State<_SpeedControlSheet> {
  late double _currentSpeed;

  @override
  void initState() {
    super.initState();
    _currentSpeed = widget.currentSpeed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pull indicator
          const Gap(8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(20),

          // Title
          const Text(
            'Playback Speed',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(20),

          // Current speed display
          Text(
            '${_currentSpeed.toStringAsFixed(1)}x',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(24),

          // Speed option chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: widget.speedOptions
                  .map((speed) => _SpeedChip(
                        speed: speed,
                        isSelected: (speed - _currentSpeed).abs() < 0.01,
                        onTap: () {
                          setState(() {
                            _currentSpeed = speed;
                          });
                          widget.onSpeedChanged(speed);
                        },
                      ))
                  .toList(),
            ),
          ),
          const Gap(24),

          // Custom speed slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.blue,
                inactiveTrackColor: Colors.blue.withValues(alpha: 0.2),
                thumbColor: Colors.blue,
                overlayColor: Colors.blue.withValues(alpha: 0.1),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              ),
              child: Slider(
                value: _currentSpeed,
                min: 0.5,
                max: 2.0,
                divisions: 30,
                onChanged: (newSpeed) {
                  setState(() {
                    _currentSpeed = newSpeed;
                  });
                  widget.onSpeedChanged(newSpeed);
                },
              ),
            ),
          ),
          const Gap(24),
        ],
      ),
    );
  }
}

class _SpeedChip extends StatelessWidget {
  const _SpeedChip({
    required this.speed,
    required this.isSelected,
    required this.onTap,
  });

  final double speed;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.blue : Colors.grey[200],
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '${speed.toStringAsFixed(1)}x',
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
