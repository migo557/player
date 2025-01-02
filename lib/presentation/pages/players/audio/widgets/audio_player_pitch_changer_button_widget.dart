import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/presentation/common/widgets/nothing_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class AudioPlayerPitchChangerButtonWidget extends StatelessWidget {
  const AudioPlayerPitchChangerButtonWidget({
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
                          stream: state.audioPlayer.pitchStream,
                          builder: (context, snapshot) {
                            final value = snapshot.data!;
                            return snapshot.hasData
                                ? [
                                    //-------- Heading
                                    "Pitch"
                                        .text
                                        .size(20)
                                        .white
                                        .makeCentered()
                                        .p12(),
                                    Gap(10),

                                    //----------------   Pitch VALUE -----------------//
                                    value.text.size(20).white.make(),

                                    Slider(
                                        min: 0.5,
                                        max: 2.0,
                                        divisions: 15,
                                        value: value,
                                        onChanged: (v) {
                                          context.read<AudioPlayerBloc>().add(
                                              AudioPlayerChangePitchEvent(
                                                  value: v));
                                          clog.debug(" Pitch Value : $v");
                                        }),
                                    Gap(10),
                                    TextButton(
                                        onPressed: () {
                                          context.read<AudioPlayerBloc>().add(
                                              AudioPlayerChangePitchEvent(
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
          Icons.equalizer,
          color: Colors.white,
          size: 35,
        ),
      ),
      "Pitch".text.white.xs.make(),
    ].column();
  }
}
