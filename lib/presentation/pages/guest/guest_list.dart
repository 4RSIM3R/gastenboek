import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/presentation/routes/app_router.dart';
import 'package:next_starter/presentation/theme/theme.dart';

class GuestList extends StatefulWidget {
  const GuestList({super.key});

  @override
  State<GuestList> createState() => _GuestListState();
}

class _GuestListState extends State<GuestList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest List'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Elang Putra Adam'),
            subtitle: Text('3520253735242'),
            trailing: Text('Status'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorTheme.primary2,
        onPressed: () {
          // context.route.push(const ScanRoute());
        },
        child: Icon(CupertinoIcons.add),
      ),
    );
  }
}
