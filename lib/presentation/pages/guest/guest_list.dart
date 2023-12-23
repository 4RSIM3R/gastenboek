import 'package:auto_route/auto_route.dart';
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
        title: Text('Guest Lists'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: ListTile(
              leading: Icon(CupertinoIcons.person_alt),
              title: Text(
                'Elang Putra Adam',
                style: AppStyles.text12PxMedium,
              ),
              subtitle: Text('3520253735242'),
              trailing: Text('Status'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorTheme.primary2,
        onPressed: () {
          context.router.push(const ScanRoute());
        },
        child: Icon(CupertinoIcons.add),
      ),
    );
  }
}
