import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:provider/provider.dart';
import 'package:streamheck/Providers/socket_server_provider.dart';
import 'package:streamheck/modules/radial_menu.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _currentVol = 50;

//final serverProvider = ServerProvider();
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var socketServerProvider = Provider.of<SocketServerProvider>(context);
    return Scaffold(
      body: SizedBox.expand(child: RadialMenu()),

      // Container(
      //   decoration: BoxDecoration(color: Colors.black),
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         // RaisedButton(
      //         //     child: SizedBox(
      //         //         height: 200,
      //         //         width: 200,
      //         //         child: Center(child: Text('Minimize All Windows'))),
      //         //     onPressed: () => print(
      //         //         'Radial Menu') //socketServerProvider.runSocketTest(),
      //         //     ),
      //         SizedBox.expand(child: RadialMenu()),
      //         // SizedBox(
      //         //   height: 400,
      //         //   width: 100,
      //         //   child: BoomMenu(
      //         //     child: Text('test'),
      //         //     children: [
      //         //       MenuItem(
      //         //         child: Icon(Icons.accessibility, color: Colors.black),
      //         //         title: "Profiles",
      //         //         titleColor: Colors.white,
      //         //         subtitle: "You Can View the Noel Profile",
      //         //         subTitleColor: Colors.white,
      //         //         backgroundColor: Colors.deepOrange,
      //         //         onTap: () => print('FIRST CHILD'),
      //         //       ),
      //         //       MenuItem(
      //         //         child: Icon(Icons.brush, color: Colors.black),
      //         //         title: "Profiles",
      //         //         titleColor: Colors.white,
      //         //         subtitle: "You Can View the Noel Profile",
      //         //         subTitleColor: Colors.white,
      //         //         backgroundColor: Colors.green,
      //         //         onTap: () => print('SECOND CHILD'),
      //         //       ),
      //         //       MenuItem(
      //         //         child: Icon(Icons.keyboard_voice, color: Colors.black),
      //         //         title: "Profile",
      //         //         titleColor: Colors.white,
      //         //         subtitle: "You Can View the Noel Profile",
      //         //         subTitleColor: Colors.white,
      //         //         backgroundColor: Colors.blue,
      //         //         onTap: () => print('THIRD CHILD'),
      //         //       ),
      //         //       MenuItem(
      //         //         child: Icon(Icons.ac_unit, color: Colors.black),
      //         //         title: "Profiles",
      //         //         titleColor: Colors.white,
      //         //         subtitle: "You Can View the Noel Profile",
      //         //         subTitleColor: Colors.white,
      //         //         backgroundColor: Colors.blue,
      //         //         onTap: () => print('FOURTH CHILD'),
      //         //       )
      //         //     ],
      //         //   ),
      //         // ),
      //         // SizedBox(
      //         //     height: 200,
      //         //     width: 600,
      //         //     child: Slider(
      //         //       //divisions: 25,

      //         //       max: 100,
      //         //       min: 0,
      //         //       value: _currentVol.toDouble(),
      //         //       onChangeEnd: (value) =>
      //         //           socketServerProvider.changeVolume(value.round()),
      //         //       //onChangeEnd: (value) => socketServerProvider.changeVolume(value.round()),
      //         //       onChanged: (value) {
      //         //         //socketServerProvider.changeVolume(value.round());
      //         //         setState(() {
      //         //           _currentVol = value.round();
      //         //         });
      //         //         //value.round()
      //         //         //print(value.round());
      //         //         //print(value.round().runtimeType);
      //         //       },
      //         //       //onChangeEnd: (value) => socketServerProvider.changeVolume(value.round()),
      //         //     )),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
