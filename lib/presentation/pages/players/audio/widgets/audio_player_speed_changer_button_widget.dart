import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/presentation/common/widgets/nothing_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class AudioPlayerSpeedChangerButtonWidget extends StatelessWidget {
  const AudioPlayerSpeedChangerButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          context.pop();
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: SizedBox(
                  height: 200,
                  width: 250,
                  child: BlocSelector<AudioPlayerBloc, AudioPlayerState,
                      AudioPlayerSuccessState?>(
                    selector: (state) {
                      return state is AudioPlayerSuccessState ? state : null;
                    },
                    builder: (context, state) {
                      if (state == null) return nothing;

                      return StreamBuilder(
                          stream: state.audioPlayer.speedStream,
                          builder: (context, snapshot) {
                            final value = snapshot.data!;
                            return snapshot.hasData
                                ? [
                                    //-------- Heading
                                    "Speed"
                                        .text
                                        .size(20)
                                        .white
                                        .makeCentered()
                                        .p12(),
                                    Gap(10),

                                    //----------------   SPEED VALUE -----------------//
                                    value.text.size(20).white.make(),

                                    Slider(
                                        min: 0.5,
                                        max: 2.0,
                                        divisions: 15,
                                        value: value,
                                        onChanged: (v) {
                                          context.read<AudioPlayerBloc>().add(
                                              AudioPlayerChangeSpeedEvent(
                                                  value: v));
                                          clog.debug(" Speed Value : $v");
                                        }),
                                    Gap(10),
                                    TextButton(
                                        onPressed: () {
                                          context.read<AudioPlayerBloc>().add(
                                              AudioPlayerChangeSpeedEvent(
                                                  value: 1.0));
                                        },
                                        child: Text("Default")),
                                  ].column()
                                : nothing;
                          });
                    },
                  )).glassMorphic(),
            ),
          );
        },
        icon: Icon(
          Icons.speed,
          color: Colors.white,
          size: 35,
        ),
      ),
      "Speed".text.white.xs.make(),
    ].column();
  }
}
