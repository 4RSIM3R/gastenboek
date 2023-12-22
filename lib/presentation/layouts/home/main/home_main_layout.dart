import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/data/models/agenda/agenda_model.dart';
import 'package:next_starter/presentation/routes/app_router.dart';
import 'package:next_starter/presentation/theme/theme.dart';
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
      body: Column(
        children: [
          Text('Event List'),
          StreamBuilder<List<Map<String, dynamic>>>(
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
                              context.router.push(AgendaDetailRoute(
                                  model: AgendaModel.fromJson({})));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.red),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e['date'],
                                          style: AppStyles.text12Px.copyWith(
                                            color: Colors.red[600],
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          e['name'],
                                          style: AppStyles.text12PxMedium,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          e['location'] ?? 'Unknown Location',
                                          style: AppStyles.text12Px.copyWith(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(CupertinoIcons.chevron_forward,
                                      color: Colors.redAccent)
                                ],
                              ),
                            ),
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
        ],
      ),
    );
  }
}
