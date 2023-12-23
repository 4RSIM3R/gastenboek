import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:next_starter/injection.dart';
import 'package:next_starter/presentation/pages/guest/list/cubit/guest_list_cubit.dart';
import 'package:next_starter/presentation/theme/theme.dart';
import 'package:next_starter/utils/constant.dart';

class GuestList extends StatefulWidget {
  const GuestList({super.key, required this.agendaId});

  final int agendaId;

  @override
  State<GuestList> createState() => _GuestListState();
}

class _GuestListState extends State<GuestList> {
  final bloc = locator<GuestListCubit>();

  @override
  void initState() {
    super.initState();
    bloc.fetch(widget.agendaId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => bloc),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Guest Lists'),
        ),
        body: BlocBuilder<GuestListCubit, GuestListState>(
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const Center(child: CircularProgressIndicator.adaptive()),
              failure: (failure) => Center(child: Text(failure.mesage)),
              success: (success) => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: (success.payload ?? [])
                      .map(
                        (e) => Container(
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
                              '${e.name}',
                              style: AppStyles.text12PxMedium,
                              maxLines: 1,
                            ),
                            subtitle: Text('${e.address}', style: CustomTextTheme.footer, maxLines: 1),
                            trailing: Text(DateFormat('dd/MM/yyyy').format(e.createdAt!)),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          },
        ),
        floatingActionButton: BlocBuilder<GuestListCubit, GuestListState>(
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const SizedBox.shrink(),
              success: (success) => !success.payload.map((e) => e.userId).toList().contains(supabase.auth.currentUser?.id)
                  ? FloatingActionButton(
                      backgroundColor: ColorTheme.primary2,
                      onPressed: () {
                        bloc.insert(widget.agendaId);
                      },
                      child: const Icon(CupertinoIcons.add),
                    )
                  : FloatingActionButton(
                      backgroundColor: ColorTheme.primary2,
                      onPressed: () {},
                      child: const Icon(Icons.monetization_on_outlined),
                    ),
            );
          },
        ),
      ),
    );
  }
}
