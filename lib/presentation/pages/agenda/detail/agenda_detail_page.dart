import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:next_starter/data/models/agenda/agenda_model.dart';
import 'package:next_starter/presentation/pages/guest/list/guest_list.dart';
import 'package:next_starter/presentation/theme/theme.dart';

@RoutePage()
class AgendaDetailPage extends StatelessWidget {
  const AgendaDetailPage({super.key, required this.model});

  final AgendaModel model;
  final bool counterRotate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Event'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                        'https://images.unsplash.com/photo-1607013407627-6ee814329547?q=80&w=2764&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'March 21, 2023',
                  style: AppStyles.text12PxMedium.copyWith(color: Colors.grey),
                ),
                Text(
                  model.name ?? 'Wisuda Angkatan 2023 - JTI Polinema',
                  style: AppStyles.text18Px,
                ),
                SizedBox(height: 12),
                Text(
                  'ini nanti ada deskripsi eventnya',
                  style: AppStyles.text12Px.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      CupertinoIcons.location,
                      size: 16,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Gedung Serba Guna Polinema',
                      style: AppStyles.text12Px,
                    )
                  ],
                ),
                SizedBox(height: 12),
                Divider(
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 12),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(-7.946639, 112.615876),
                        initialZoom: 18,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(rotate: counterRotate, markers: const [
                          Marker(
                            point: LatLng(-7.946639, 112.615876),
                            width: 64,
                            height: 64,
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              CupertinoIcons.location_solid,
                              color: Colors.red,
                            ),
                          ),
                        ]),
                      ]),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GuestList(agendaId: model.id!)),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorTheme.primary2,
                ),
                child: Center(
                  child: Text(
                    'Check Attendance',
                    style: AppStyles.text14PxSemiBold
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
