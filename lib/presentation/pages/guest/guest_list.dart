import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnc_identifier_ocr/mnc_identifier_ocr.dart';
import 'package:mnc_identifier_ocr/model/ocr_result_model.dart';
import 'package:next_starter/presentation/theme/theme.dart';

class GuestList extends StatefulWidget {
  const GuestList({super.key});

  @override
  State<GuestList> createState() => _GuestListState();
}

class _GuestListState extends State<GuestList> {
  Future<void> scanKtp() async {
    try {
      OcrResultModel res = await MncIdentifierOcr.startCaptureKtp(withFlash: false, cameraOnly: false);
      debugPrint('NIK: ${res.ktp?.nik}');
    } catch (e) {
      debugPrint('something goes wrong $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Guest Lists'),
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
              leading: const Icon(CupertinoIcons.person_alt),
              title: Text(
                'Elang Putra Adam',
                style: AppStyles.text12PxMedium,
              ),
              subtitle: const Text('3520253735242'),
              trailing: const Text('Status'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorTheme.primary2,
        onPressed: () {
          scanKtp();
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
