import 'package:flutter/material.dart';
import 'package:streamheck/models/macro.dart';
import 'package:provider/provider.dart';

class MacroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('wow');
  }
}

// class MacroList extends StatelessWidget {
//   final DataState<List<Macro>> state;
//   const MacroList(this.state, {Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (state.isLoading) {
//       return Center(child: const CircularProgressIndicator());
//     }
//     return ListView.separated(
//       itemBuilder: (context, i) {
//         final macro = state.model[i];
//         return GestureDetector(
//           onDoubleTap: () => print('tapped'),
//           // Todo(id: todo.id, title: todo.title, completed: !todo.completed)
//           //     .save(),
//           child: Dismissible(
//             child: Text(
//                 '${macro.completed ? "✅" : "◻️"} [id: ${macro.id}] ${macro.title}'),
//             key: ValueKey(macro),
//             direction: DismissDirection.endToStart,
//             background: Container(
//               color: Colors.red,
//               child: Icon(Icons.delete, color: Colors.white),
//             ),
//             onDismissed: (_) async {
//               await macro.delete();
//             },
//           ),
//         );
//       },
//       itemCount: state.model.length,
//       separatorBuilder: (context, i) => Divider(),
//       padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
//     );
//   }
// }
