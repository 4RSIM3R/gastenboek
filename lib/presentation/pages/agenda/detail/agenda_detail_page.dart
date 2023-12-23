import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:next_starter/data/models/agenda/agenda_model.dart';
import 'package:next_starter/presentation/pages/guest/guest_list.dart';
import 'package:next_starter/presentation/theme/theme.dart';
import 'package:next_starter/utils/opener.dart';

@RoutePage()
class AgendaDetailPage extends StatelessWidget {
  const AgendaDetailPage({super.key, required this.model});

  final AgendaModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${model.name}'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(model.thumbnail!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  DateFormat('dd MMMM yyyy').format(model.date!),
                  style: AppStyles.text12PxMedium.copyWith(color: Colors.grey),
                ),
                Text(
                  model.name ?? 'Wisuda Angkatan 2023 - JTI Polinema',
                  style: AppStyles.text18Px,
                ),
                const SizedBox(height: 12),
                Text(
                  '${model.description}',
                  style: AppStyles.text12Px.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('${model.location}', style: AppStyles.text12Px),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        MapUtils.openMap(model.lat!, model.lng!);
                      },
                      icon: const Icon(CupertinoIcons.map_fill, size: 16),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Divider(
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(model.lat!, model.lng!),
                      initialZoom: 16,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
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
                  MaterialPageRoute(builder: (context) => const GuestList()),
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
