import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
//import 'package:socket_io/socket_io.dart';

/*
Created NB 5/2020

SocketServerProvider acts as a client for communicating to 
the websocket server. 

The IP address is hardcoded and will need to be dynamic

This class is used to send the action data to the server 
when an action tile is tapped
*/

class SocketServerProvider with ChangeNotifier {
  final String _host = 'http://192.168.1.100:3003';
  IO.Socket _socket;
  IO.Socket get socket => _socket;

  SocketServerProvider() {
    print('SOCKET SERVER CALLED');
    connectToServer();
  }

  Future connectToServer() async {
    print('CONNECT TO SERVER CALLED');
    //IO.Socket socket;
    try {
      _socket = IO.io(_host, <String, dynamic>{
        'transports': ['websocket']
      });
    } catch (error) {
      print('MARKER 1 ERROR: $error');
    }
    print('MARKER 2');
    try {
      socket.on('connect', (_) {
        print('connect');
        //socket.emit('msg', 'TESTING FRMOM SOCKETSERVER IOS');
      });
    } catch (err) {
      print('SOCKET ERROR: $err');
    }

    socket.on('event', (data) => print(data));
    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  void runCommand(String cmd) {
    print('run command called');
    socket.emit('commandline', cmd);
  }

  void runHotKey(String hotkey) async {
    print('run hot key called');
    socket.emit('hotkey', hotkey);
  }

  void runSocketTest(String keyStrokes) {
    //print('RUN SOCKET TEST CALLED');
    socket.emit('macrosignal', keyStrokes);
  }

  void runPaste(int index) {
    print('RUN PASSTE CALLED');
    socket.emit('pastesignal', index);
  }

  void runPasteLine(String line) {
    print('run paste line called on :: $line');
    socket.emit('pasteline', line);
  }

  void changeVolume(int vol) {
    print('change vol called');
    socket.emit('volumesignal', vol);
  }
}
