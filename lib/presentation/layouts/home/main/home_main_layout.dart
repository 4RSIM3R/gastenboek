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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(18, 16, 18, 0),
            child: Text('Event Result', style: AppStyles.text18PxSemiBold),
          ),
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
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.fromLTRB(4, 4, 16, 4),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.red,
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(e['thumbnail'] ?? ''),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
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
                                            color: ColorTheme.primary2,
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
                                  Icon(
                                    CupertinoIcons.exclamationmark_circle,
                                    color: ColorTheme.primary2,
                                  )
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
