import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamheck/Providers/box_create_provider.dart';
import 'package:streamheck/Providers/http_provider.dart';
import 'package:streamheck/Providers/macro_pages_provider.dart';
import 'package:streamheck/Services/available_macro_service.dart';
import 'package:streamheck/stream_heck.dart';
import 'Providers/socket_server_provider.dart';

void main() {
  //timeDilation = 10.0;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<SocketServerProvider>(
        create: (_) => SocketServerProvider()),
    ChangeNotifierProvider<BoxCreateProvider>(
        create: (context) => BoxCreateProvider()),
    ChangeNotifierProvider<AvailMacroService>(
        create: (context) => AvailMacroService()),
    ChangeNotifierProvider<MacroPagesProvider>(
        create: (context) => MacroPagesProvider())
    //ChangeNotifierProvider<HttpProvider>(create: (_) => HttpProvider())
  ], child: StreamHeck()));
}
