import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;

import 'package:provider/provider.dart';

import '../../infraestructura/videollamada/modelo/cita.dart';
import '../../providers/cita_estado.dart';
import '../../../comun/infraestructura/config.dart';




class CallPage extends StatefulWidget {
  final ClientRole? role = ClientRole.Broadcaster;
  const CallPage({Key? key}) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  bool _seUnio = true;
  late RtcEngine _engine;
  Cita? videollamadaCita;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  void dispose() {

    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  Future<void> initialize() async {
    videollamadaCita = Provider.of<CitaEstado>(context, listen: false).cita;
    if(appId.isEmpty){
      setState(() {
        _infoStrings.add(
            'APP_ID missing, please provide your APP_ID in settings.dart'
        );
        _infoStrings.add(
            'Agora Engine is not starting'
        );
      });
      return;
    }
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role!);
    _addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(videollamadaCita!.videollamada.tokenTemp, videollamadaCita!.videollamada.nombreCanal, null, 0);

  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
        error: (code) {
          setState(() {
            final info = 'Error: $code';
            _infoStrings.add(info);
          });
        },

        joinChannelSuccess: (channel, uid, elapsed) {
          setState(() {
            final info = 'Join Channel: $channel, uid: $uid';
            _infoStrings.add(info);
          });
        },

        leaveChannel: (stats) {
          setState(() {
            _infoStrings.add('Leave Channel');
            _users.clear();
          });
        },

        userJoined: (uid, elapsed) {
          setState(() {
            final info = 'User Joined: $uid';
            _infoStrings.add(info);
            _users.add(uid);
            _seUnio = false;
          });
        },

        userOffline: (uid, elapsed){
          setState(() {
            final info = 'User offline: $uid';
            _infoStrings.add(info);
            _users.remove(uid);
          });
        },

        firstRemoteVideoFrame: (uid, width, height, elapsed) {
          setState(() {
            final info = 'First Remote video: $uid ${width} x $height';
            _infoStrings.add(info);
          });
        }


    ));
  }

  Widget _viewRows() {
    final List<StatefulWidget> list = [];
    StatefulWidget? broadcaster =  null;
    if(widget.role == ClientRole.Broadcaster) {
      broadcaster = const rtc_local_view.SurfaceView();
    }
    for (var uid in _users){
      list.add(rtc_remote_view.SurfaceView(
        uid: uid,
        channelId:  videollamadaCita!.videollamada.nombreCanal,
      ));

    }
    final views = list;
    return Stack(
      children: [
        Column(
          children: List.generate(
              views.length,
                  (index) => Expanded(
                child: views[index],
              )
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 220,
            height: 290,
            padding: const EdgeInsets.only(top: 30, left: 30),
            child: Center(
                child: broadcaster
            ),
          ),
        ),

      ],
    );
  }


  Widget _toolbar() {
    if(widget.role == ClientRole.Audience) return const SizedBox();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: (){
              setState(() {
                muted = !muted;
              });
              _engine.muteLocalAudioStream(muted);
            },
            child: Icon(
              muted ? Icons.mic_off: Icons.mic,
              color: muted? Colors.white : Colors.amberAccent,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.amberAccent: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: ()=> Navigator.pop(context),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine.switchCamera();
            },
            child: const Icon(
              Icons.switch_camera,
              color: Colors.amberAccent,
              size: 20,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  Widget _panel() {
    return Visibility(
      visible: viewPanel,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: ListView.builder(
                reverse: true,
                itemCount: _infoStrings.length,
                itemBuilder: (BuildContext context , int index) {
                  if(_infoStrings.isEmpty){
                    return const Text("Null");
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              _infoStrings[index],
                              style: const TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),

                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyOnlineDoctor'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                viewPanel = !viewPanel;
              });
            },
            icon: const Icon(Icons.info_outline),

          )
        ],

      ),
     //backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
           _seUnio ? Center(child:Text('Llamando...') ) : _viewRows(),
            _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}