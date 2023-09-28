import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/presentation/components/button/primary_button.dart';
import 'package:next_starter/presentation/components/input/text_input.dart';
import 'package:nik_validator/nik_validator.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class GuestFormPage extends StatefulWidget {
  const GuestFormPage({super.key, this.model});

  final NIKModel? model;

  @override
  State<GuestFormPage> createState() => _GuestFormPageState();
}

class _GuestFormPageState extends State<GuestFormPage> {
  final formGroup = fb.group({
    'nik': ['', Validators.required],
    'name': ['', Validators.required],
    'address': ['', Validators.required],
  });

  @override
  void initState() {
    super.initState();

    if (widget.model != null) {
      formGroup.controls['nik']!.updateValue(widget.model?.nik);
      formGroup.controls['address']!.updateValue(
        '${widget.model?.subdistrict} ${widget.model?.city} ${widget.model?.province}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Buku Tamu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ReactiveFormBuilder(
          form: () => formGroup,
          builder: (context, formGroup, child) {
            return Column(
              children: [
                const TextInput(
                  title: 'NIK',
                  formControlName: 'nik',
                  hint: 'Masukkan NIK Anda',
                  textInputType: TextInputType.number,
                ),
                const TextInput(
                  title: 'Nama',
                  formControlName: 'name',
                  hint: 'Masukkan Nama Anda',
                  textInputType: TextInputType.text,
                ),
                const TextInput(
                  title: 'Alamat',
                  formControlName: 'address',
                  hint: 'Masukkan Alamat Anda',
                  textInputType: TextInputType.number,
                ),
                ReactiveFormConsumer(
                  builder: (context, formGroup, child) {
                    return PrimaryButton(
                      isEnable: formGroup.valid,
                      title: 'Submit',
                      onTap: () {},
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
