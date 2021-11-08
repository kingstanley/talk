// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:uzum/helpers/camera.helper.dart';
// import 'package:uzum/helpers/functions.dart';

// class VideoCall extends StatefulWidget {
//   VideoCall();

//   @override
//   _VideoCallState createState() => _VideoCallState();
// }

// class _VideoCallState extends State<VideoCall> {
//   // late RTCVideoRenderer _localVideoRender =
//   //     Provider.of<ChatProvider>(context, listen: false).localVideoRenderer;
//   // debugPrint('localVideo $_localVideoRender');
//   final _localRenderer = RTCVideoRenderer();
//   var mediaStream;
//   @override
//   void dispose() {
//     _localRenderer.dispose();
//     // mediaStream.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     initRenderers();
//     // _getCameraMedia();
//     _getLocalMedia();
//     super.initState();
//   }

//   initRenderers() async {
//     await _localRenderer.initialize();
//   }

//   _getCameraMedia() async {
//     mediaStream = await getCameraMedia(context, 0, {
//       "audio": "true",
//       "video": {"facingMode": "user"}
//     });
//     if (Platform.isAndroid || Platform.isIOS) {
//       // Use CameraPreview
//     } else {
//       _localRenderer.srcObject = mediaStream;
//     }
//   }

//   _getLocalMedia() async {
//     try {
//       final Map<String, dynamic> constraints = <String, dynamic>{
//       'audio': true,
//       'video': {
//         'mandatory': {
//           'minWidth':
//               '1280', // Provide your own width, height and frame rate here
//           'minHeight': '720',
//           'minFrameRate': '30',
//         },
//         'facingMode': 'user',
//         'optional': [],
//       }
//     };

//       MediaStream stream =
//           await navigator.mediaDevices.getUserMedia(constraints);
//       _localRenderer.srcObject = stream;
//       debugPrint('media gotten');
//     } catch (e) {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Positioned(
//               top: 0.0,
//               right: 0.0,
//               left: 0.0,
//               bottom: 0.0,
//               child: Container(width: 500, height: 300, child: RTCVideoView(
//         _localRenderer,
//         objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//       )
//               // camPreview()
//               )),
//           Positioned(
//             top: 100,
//             bottom: 0,
//             left: 30,
//             right: 30,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.blue,
//                   ),
//                   child:
//                       IconButton(onPressed: () {}, icon: Icon(Icons.add_call)),
//                   // color: Colors.blue,
//                 ),
//                 SizedBox(
//                   width: 10.0,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.red,
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.call_end),
//                     onPressed: () {
//                       Navigator.pop(context);
//                       //  _localRenderer.dispose();
//                     },
//                   ),
//                   // color: Colors.white,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget camPreview() {
//     if (Platform.isAndroid || Platform.isIOS) {
//       return CameraPreview(mediaStream);
//     } else {
//       return RTCVideoView(
//         _localRenderer,
//         objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//       );
//     }
//   }
// }

import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCall extends StatefulWidget {
  static String tag = 'loopback_sample';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<VideoCall> {
  MediaStream? _localStream;
  RTCPeerConnection? _peerConnection;
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  bool _inCalling = false;
  Timer? _timer;

  String get sdpSemantics =>
      WebRTC.platformIsWindows ? 'plan-b' : 'unified-plan';

  @override
  void initState() {
    super.initState();
    initRenderers();
    _makeCall();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _hangUp();
  }

  @override
  void deactivate() {
    super.deactivate();
    if (_inCalling) {
      _hangUp();
    }
    _localRenderer.dispose();
    _remoteRenderer.dispose();
  }

  void initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void handleStatsReport(Timer timer) async {
    if (_peerConnection != null) {
/*
      var reports = await _peerConnection.getStats();
      reports.forEach((report) {
        print('report => { ');
        print('    id: ' + report.id + ',');
        print('    type: ' + report.type + ',');
        print('    timestamp: ${report.timestamp},');
        print('    values => {');
        report.values.forEach((key, value) {
          print('        ' + key + ' : ' + value.toString() + ', ');
        });
        print('    }');
        print('}');
      });
*/
      /*
      var senders = await _peerConnection.getSenders();
      var canInsertDTMF = await senders[0].dtmfSender.canInsertDtmf();
      print(canInsertDTMF);
      await senders[0].dtmfSender.insertDTMF('1');
      var receivers = await _peerConnection.getReceivers();
      print(receivers[0].track.id);
      var transceivers = await _peerConnection.getTransceivers();
      print(transceivers[0].sender.parameters);
      print(transceivers[0].receiver.parameters);
      */
    }
  }

  void _onSignalingState(RTCSignalingState state) {
    print(state);
  }

  void _onIceGatheringState(RTCIceGatheringState state) {
    print(state);
  }

  void _onIceConnectionState(RTCIceConnectionState state) {
    print(state);
  }

  void _onPeerConnectionState(RTCPeerConnectionState state) {
    print(state);
  }

  void _onAddStream(MediaStream stream) {
    print('New stream: ' + stream.id);
    _remoteRenderer.srcObject = stream;
  }

  void _onRemoveStream(MediaStream stream) {
    _remoteRenderer.srcObject = null;
  }

  void _onCandidate(RTCIceCandidate candidate) {
    print('onCandidate: ${candidate.candidate}');
    _peerConnection?.addCandidate(candidate);
  }

  void _onTrack(RTCTrackEvent event) {
    print('onTrack');
    if (event.track.kind == 'video') {
      _remoteRenderer.srcObject = event.streams[0];
    }
  }

  void _onAddTrack(MediaStream stream, MediaStreamTrack track) {
    if (track.kind == 'video') {
      _remoteRenderer.srcObject = stream;
    }
  }

  void _onRemoveTrack(MediaStream stream, MediaStreamTrack track) {
    if (track.kind == 'video') {
      _remoteRenderer.srcObject = null;
    }
  }

  void _onRenegotiationNeeded() {
    print('RenegotiationNeeded');
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void _makeCall() async {
    final mediaConstraints = <String, dynamic>{
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth':
              '1280', // Provide your own width, height and frame rate here
          'minHeight': '720',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };

    var configuration = <String, dynamic>{
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ],
      'sdpSemantics': sdpSemantics
    };

    final offerSdpConstraints = <String, dynamic>{
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': true,
      },
      'optional': [],
    };

    final loopbackConstraints = <String, dynamic>{
      'mandatory': {},
      'optional': [
        {'DtlsSrtpKeyAgreement': false},
      ],
    };

    if (_peerConnection != null) return;

    try {
      _peerConnection =
          await createPeerConnection(configuration, loopbackConstraints);

      _peerConnection!.onSignalingState = _onSignalingState;
      _peerConnection!.onIceGatheringState = _onIceGatheringState;
      _peerConnection!.onIceConnectionState = _onIceConnectionState;
      _peerConnection!.onConnectionState = _onPeerConnectionState;
      _peerConnection!.onIceCandidate = _onCandidate;
      _peerConnection!.onRenegotiationNeeded = _onRenegotiationNeeded;

      _localStream =
          await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localRenderer.srcObject = _localStream;

      switch (sdpSemantics) {
        case 'plan-b':
          _peerConnection!.onAddStream = _onAddStream;
          _peerConnection!.onRemoveStream = _onRemoveStream;
          await _peerConnection!.addStream(_localStream!);
          break;
        case 'unified-plan':
          _peerConnection!.onTrack = _onTrack;
          _peerConnection!.onAddTrack = _onAddTrack;
          _peerConnection!.onRemoveTrack = _onRemoveTrack;
          _localStream!.getTracks().forEach((track) {
            _peerConnection!.addTrack(track, _localStream!);
          });
          break;
      }

      /*
      await _peerConnection.addTransceiver(
        track: _localStream.getAudioTracks()[0],
        init: RTCRtpTransceiverInit(
            direction: TransceiverDirection.SendRecv, streams: [_localStream]),
      );
      */
      /*
      // ignore: unused_local_variable
      var transceiver = await _peerConnection.addTransceiver(
        track: _localStream.getVideoTracks()[0],
        init: RTCRtpTransceiverInit(
            direction: TransceiverDirection.SendRecv, streams: [_localStream]),
      );
      */

      /*
      // Unified-Plan Simulcast
      await _peerConnection.addTransceiver(
          track: _localStream.getVideoTracks()[0],
          init: RTCRtpTransceiverInit(
            direction: TransceiverDirection.SendOnly,
            streams: [_localStream],
            sendEncodings: [
              // for firefox order matters... first high resolution, then scaled resolutions...
              RTCRtpEncoding(
                rid: 'f',
                maxBitrate: 900000,
                numTemporalLayers: 3,
              ),
              RTCRtpEncoding(
                rid: 'h',
                numTemporalLayers: 3,
                maxBitrate: 300000,
                scaleResolutionDownBy: 2.0,
              ),
              RTCRtpEncoding(
                rid: 'q',
                numTemporalLayers: 3,
                maxBitrate: 100000,
                scaleResolutionDownBy: 4.0,
              ),
            ],
          ));
      
      await _peerConnection.addTransceiver(
          kind: RTCRtpMediaType.RTCRtpMediaTypeVideo);
      await _peerConnection.addTransceiver(
          kind: RTCRtpMediaType.RTCRtpMediaTypeVideo);
      await _peerConnection.addTransceiver(
          kind: RTCRtpMediaType.RTCRtpMediaTypeVideo,
          init:
              RTCRtpTransceiverInit(direction: TransceiverDirection.RecvOnly));
      */
      var description = await _peerConnection!.createOffer(offerSdpConstraints);
      var sdp = description.sdp;
      print('sdp = $sdp');
      await _peerConnection!.setLocalDescription(description);
      //change for loopback.
      description.type = 'answer';
      await _peerConnection!.setRemoteDescription(description);

      // _peerConnection!.getStats();
      /* Unfied-Plan replaceTrack
      var stream = await MediaDevices.getDisplayMedia(mediaConstraints);
      _localRenderer.srcObject = _localStream;
      await transceiver.sender.replaceTrack(stream.getVideoTracks()[0]);
      // do re-negotiation ....
      */
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;

    _timer = Timer.periodic(Duration(seconds: 1), handleStatsReport);

    setState(() {
      _inCalling = true;
    });
  }

  void _hangUp() async {
    try {
      await _localStream?.dispose();
      await _peerConnection?.close();
      _peerConnection = null;
      _localRenderer.srcObject = null;
      _remoteRenderer.srcObject = null;
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _inCalling = false;
    });
    _timer?.cancel();
  }

  void _sendDtmf() async {
    var dtmfSender =
        _peerConnection?.createDtmfSender(_localStream!.getAudioTracks()[0]);
    await dtmfSender?.insertDTMF('123#');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
              child: Container(
                  width: 500,
                  height: 300,
                  child: RTCVideoView(
                    _localRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )
                  // camPreview()
                  )),
          Positioned(
              top: 10.0,
              right: 10.0,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: RTCVideoView(
                  _localRenderer,
                ),
                radius: 100.0,
              )),
          Positioned(
            top: 100,
            bottom: 0,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child:
                      IconButton(onPressed: () {}, icon: Icon(Icons.add_call)),
                  // color: Colors.blue,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.call_end),
                    onPressed: () {
                      Navigator.pop(context);
                      //  _localRenderer.dispose();
                    },
                  ),
                  // color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
