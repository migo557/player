# Keep the Flutter engine and widgets
-keep class io.flutter.** { *; }
-keep class flutter.** { *; }

# Keep the Flutter plugins
-keep class com.example.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep the dependencies
-keep class cupertino_icons.** { *; }
-keep class flutter_bloc.** { *; }
-keep class bloc_concurrency.** { *; }
-keep class bloc.** { *; }
-keep class equatable.** { *; }
-keep class just_audio.** { *; }
-keep class animate_do.** { *; }
-keep class permission_handler.** { *; }
-keep class rxdart.** { *; }
-keep class gap.** { *; }
-keep class device_info_plus.** { *; }
-keep class get_it.** { *; }
-keep class path_provider.** { *; }
-keep class hugeicons.** { *; }
-keep class audiotags.** { *; }
-keep class go_router.** { *; }
-keep class flutter_slidable.** { *; }
-keep class hive.** { *; }
-keep class intl.** { *; }
-keep class flutter_svg.** { *; }
-keep class color_log.** { *; }
-keep class image_picker.** { *; }
-keep class percent_indicator.** { *; }
-keep class url_launcher.** { *; }
-keep class share_plus.** { *; }
-keep class uuid.** { *; }
-keep class badges.** { *; }
-keep class logger.** { *; }
-keep class flutter_hooks.** { *; }
-keep class just_audio_background.** { *; }
-keep class flutter_local_notifications.** { *; }
-keep class flutter_vlc_player.** { *; }
-keep class flutter_animate.** { *; }
-keep class amlv.** { *; }
-keep class external_path.** { *; }
-keep class animated_text_kit.** { *; }
-keep class velocity_x.** { *; }
-keep class volume_controller.** { *; }
-keep class audio_metadata_reader.** { *; }
-keep class flutter_native_splash.** { *; }
-keep class icons_launcher.** { *; }
-keep class video_compress.** { *; }
-keep class flutter_email_sender.** { *; }

# Keep the VLC player
-keep class org.videolan.libvlc.** { *; }

# Keep the native libraries
-keep class com.furqanuddin.player.NativeLibs { *; }

# Keep the assets
-keep class assets.** { *; }

# Keep the fonts
-keep class fonts.** { *; }

# Keep the icons
-keep class icons.** { *; }

# Keep the images
-keep class images.** { *; }

# Keep the svgs
-keep class svgs.** { *; }

# Keep the flags
-keep class flags.** { *; }

# Keep the MarckScript font
-keep class MarckScript-Regular.ttf { *; }

# Keep the Nabla font
-keep class Nabla-Regular.ttf { *; }

# Keep the Neonderthaw-Regular font
-keep class Neonderthaw-Regular.ttf { *; }

# Keep the Poppins font
-keep class Poppins-Bold.ttf { *; }
-keep class Poppins-Regular.ttf { *; }
-keep class Poppins-SemiBold.ttf { *; }

# Keep the SourceCodePro font
-keep class SourceCodePro-VariableFont_wght.ttf { *; }

# Keep the Google Play Core classes
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Additional rules from missing_rules.txt
-keep class com.google.android.play.core.splitcompat.SplitCompatApplication { *; }
-keep class com.google.android.play.core.splitinstall.SplitInstallException { *; }
-keep class com.google.android.play.core.splitinstall.SplitInstallManager { *; }
-keep class com.google.android.play.core.splitinstall.SplitInstallManagerFactory { *; }
-keep class com.google.android.play.core.splitinstall.SplitInstallRequest { *; }
-keep class com.google.android.play.core.splitinstall.SplitInstallRequest$Builder { *; }
-keep class com.google.android.play.core.splitinstall.SplitInstallSessionState { *; }
-keep class com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener { *; }
-keep class com.google.android.play.core.tasks.OnFailureListener { *; }
-keep class com.google.android.play.core.tasks.OnSuccessListener { *; }
-keep class com.google.android.play.core.tasks.Task { *; }