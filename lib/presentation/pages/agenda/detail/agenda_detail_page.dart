import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/data/models/agenda/agenda_model.dart';

@RoutePage()
class AgendaDetailPage extends StatelessWidget {
  const AgendaDetailPage({super.key, required this.model});

  final AgendaModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text(model.name ?? 'Unknown'),
        ),
      ),
    );
  }
}
