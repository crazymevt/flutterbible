import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  final controller = YoutubePlayerController.fromVideoId(videoId: 'test');
  // Check if controller has fullscreen listener
  controller.setFullScreenListener((isFullScreen) {
    print(isFullScreen);
  });
}
