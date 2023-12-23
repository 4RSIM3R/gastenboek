import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_starter/common/extensions/context_extension.dart';
import 'package:next_starter/injection.dart';
import 'package:next_starter/presentation/pages/scan/cubit/scan_cubit.dart';
import 'package:next_starter/presentation/routes/app_router.dart';
import 'package:next_starter/presentation/theme/app_assets.dart';
import 'package:next_starter/presentation/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

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

  File? image;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();

    // Pick an image.
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    setState(() {});
  }

  Future getImageFiles() async {
    FilePickerResult? result;
    String? fileName;
    PlatformFile? pickedfile;
    bool isLoading = false;
    File? fileToDisplay;

    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        fileName = result.files.first.name;
        pickedfile = result.files.first;
        fileToDisplay = File(pickedfile.path.toString());

        print('File name $fileName');
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
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
                        height: 200,
                        width: 320,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3.0),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 32),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: FloatingActionButton(
                              backgroundColor: ColorTheme.primary2,
                              onPressed: () async {
                                await getImage();
                              },
                              child: ImageIcon(
                                AssetImage(AppAssets.icon_gallery),
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 32),
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: FloatingActionButton(
                              backgroundColor: ColorTheme.primary2,
                              onPressed: () {
                                _takePicture();
                              },
                              child: ImageIcon(
                                AssetImage(AppAssets.icon_scan),
                                size: 32,
                              ),
                            ),
                          ),
                          SizedBox(width: 32),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: FloatingActionButton(
                              backgroundColor: ColorTheme.primary2,
                              onPressed: () async {
                                getImageFiles();
                              },
                              child: ImageIcon(
                                AssetImage(AppAssets.icon_files),
                                size: 20,
                              ),
                            ),
                          ),
                        ],
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

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.height,
    required this.width,
    this.onPressed,
    required this.icon,
    this.iconSize,
  });
  final double height;
  final double width;
  final Future? onPressed;
  final String icon;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FloatingActionButton(
        backgroundColor: ColorTheme.primary2,
        onPressed: () {},
        child: ImageIcon(
          AssetImage(icon),
          size: iconSize,
        ),
      ),
    );
  }
}
