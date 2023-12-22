import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/data/models/agenda/agenda_model.dart';
import 'package:next_starter/presentation/routes/app_router.dart';
import 'package:next_starter/utils/constant.dart';

class HomeMainLayout extends StatefulWidget {
  const HomeMainLayout({super.key});

  @override
  State<HomeMainLayout> createState() => _HomeMainLayoutState();
}

class _HomeMainLayoutState extends State<HomeMainLayout> {
  final _stream = supabase.from('agendas').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, elevation: 0),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: (snapshot.data ?? [])
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          context.router.push(AgendaDetailRoute(model: AgendaModel.fromJson({})));
                        },
                        child: Text(e['name']),
                      ),
                    )
                    .toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
