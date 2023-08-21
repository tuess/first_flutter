import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NewRoute extends StatelessWidget {
  const NewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('new route'),
        ),
        body: const Center(
          child: Text('this is a new rout'),
        ));
  }
}

class TipRoute extends StatelessWidget {
  const TipRoute({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('提示'),
        ),
        body: Video());
  }
}

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    //设置视频参数 (..)是级联的意思
    _controller = VideoPlayerController.network(
        'https://iwater.zze.com.cn:9000/uploads/organization/2022/05/20220524164809014.mp4')
      ..initialize().then((_) {
        // 确保在初始化视频后显示第一帧，直至在按下播放按钮。
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //  _controller.value.initialized表示视频是否已加载并准备好播放，
        // 如果是true则返回AspectRatio（固定宽高比的组件,宽高比为视频本身的宽高比）
        // VideoPlayer为视频插放器，对像就是前面定义的_controller
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )

            //如果视频没有加载好或者因网络原因加载不出来则返回Container 组件
            //一般用于放置过渡画面
            : Container(
                child: Text("没有要播放的视频"),
              ),
      ),

      //右下角图标按钮onPressed中需要调用setState方法，用于刷新界面
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //_controller.value.isPlaying：判断视频是否正在播放
            //_controller.pause()：如果是则暂停视频。
            // _controller.play():如果不是则播放视频
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },

        //子组件为按钮图标
        //_controller.value.isPlaying：判断视频是否正在播放
        //Icons.pause：如果是则显示这个图标
        //Icons.play_arrow：如果不是，则显示这个图标
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
