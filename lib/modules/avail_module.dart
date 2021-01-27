import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamheck/Providers/avail_provider.dart';
import 'package:streamheck/Providers/box_create_provider.dart';
import 'package:streamheck/Providers/http_provider.dart';
import 'package:streamheck/Services/available_macro_service.dart';

class AvailModule extends StatelessWidget {
  // final HttpProvider provider;
  final BoxCreateProvider boxCreateProvider;

  AvailModule(this.boxCreateProvider);

  // AvailModule(this.provider);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AvailProvider(),
      child: Consumer<AvailProvider>(
        builder: (context, value, child) {
          return (value.menuList != null)
              ? ListView.builder(
                  itemCount: value.availList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${value.availList[index].id}'),
                      subtitle: Text('${value.availList[index].combo}'),
                      enabled: value.availList[index].alreadyInUse,
                    );
                  })
              : Text('loading');
        },
      ),
    );

    //var list = service.getAvailMacros()
  }
}
