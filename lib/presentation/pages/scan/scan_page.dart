import 'package:auto_route/annotations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_starter/common/extensions/context_extension.dart';
import 'package:next_starter/injection.dart';
import 'package:next_starter/presentation/pages/scan/cubit/scan_cubit.dart';
import 'package:next_starter/presentation/routes/app_router.dart';

@RoutePage()
class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  final bloc = locator<ScanCubit>();

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.veryHigh,
    );

    _initializeControllerFuture = _controller!.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) {
      return;
    }

    try {
      final XFile image = await _controller!.takePicture();
      bloc.parseData(image.path);
    } catch (e) {
      context.showSnackbar(title: "Error", message: e.toString(), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => bloc),
      ],
      child: BlocListener<ScanCubit, ScanState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loading: () => context.showLoadingIndicator(),
            failure: (msg) {
              context.hideLoading();
              context.showSnackbar(title: "Error", message: msg, error: true);
            },
            success: (model) {
              context.hideLoading();
              context.route.replace(GuestFormRoute(model: model));
            },
          );
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(elevation: 0, toolbarHeight: 0),
          body: FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      child: CameraPreview(
                        _controller!,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 320,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: FloatingActionButton(
                          backgroundColor: Colors.blue,
                          onPressed: () {
                            _takePicture();
                          },
                          child: const Icon(CupertinoIcons.camera),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
