import 'dart:io';
import 'dart:ui';
import 'package:celebrare_assignment/bloc/image_bloc/image_bloc.dart';
import 'package:celebrare_assignment/models/frame_types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:celebrare_assignment/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void closeAppUsingSystemPop() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void initState() {
    _width;
    super.initState();
  }

  double _width = 400;

  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottomOpacity: 1,
          shadowColor: Color.fromARGB(250, 171, 171, 171),
          leading: IconButton(
              onPressed: () {
                closeAppUsingSystemPop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: Center(
              child: Text(
            "Add Image / Icon",
            style: TextStyle(color: MyTheme.black, fontSize: 23),
          ))),
      body: Theme(
        data: Theme.of(context)
            .copyWith(colorScheme: ColorScheme.light(primary: MyTheme.green)),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(top: 23),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(250, 171, 171, 171)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Upload Image",
                        style: TextStyle(color: MyTheme.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _selectImage();
                          },
                          child: const Text("Choose from device"))
                    ],
                  ),
                ),
              ).p(10).h(120),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  SizedBox(
                    child: (_image != null)
                        ? BlocConsumer<ImageBloc, ImageState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is ImageLoaded) {
                                if (state.filter == null) {
                                  return SizedBox(
                                    width: 500,
                                    height: 500,
                                    child: Image.file(
                                      _image!,
                                      fit: BoxFit.contain,
                                    ),
                                  );
                                }
                                return ClipPath(
                                  clipper: state.filter,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: SizedBox(
                                      width: 400,
                                      height: 300,
                                      child: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return SizedBox(
                                width: 500,
                                height: 500,
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          )
                        : null,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectImage() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file == null) {
      return;
    }
    File? img = File(file.path);
    img = await _cropImage(imageFile: img);
    setState(() {
      _image = img;
    });
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) {
      return null;
    }
    return _dialogBox(img: File(croppedImage.path));
  }

  _dialogBox({required File img}) {
    var imageBloc = BlocProvider.of<ImageBloc>(context);

    showDialog(
        context: context,
        builder: (context) => Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary: MyTheme.green)),
              child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                scrollable: false,
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Icon(
                                  CupertinoIcons.clear_circled_solid)),
                        ],
                      ),
                      const Text(
                        "Uploaded Image",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 210,
                        width: _width,
                        child: BlocConsumer<ImageBloc, ImageState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is ImageLoaded) {
                              if (state.filter == null) {
                                return SizedBox(
                                  width: 400,
                                  height: 300,
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              }

                              return ClipPath(
                                clipper: state.filter,
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                      width: 400,
                                      height: 300,
                                      child: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              );
                            }

                            return Image.file(
                              img,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              imageBloc.add(
                                  LoadImageWithFilter(filter: Frame.original));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        250, 171, 171, 171)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text("Original"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              imageBloc.add(
                                  LoadImageWithFilter(filter: Frame.heart));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        250, 171, 171, 171)),
                              ),
                              child: Image.asset(
                                "assets/images/user_image_frame_1.png",
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              imageBloc.add(
                                  LoadImageWithFilter(filter: Frame.square));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        250, 171, 171, 171)),
                              ),
                              child: Image.asset(
                                "assets/images/user_image_frame_2.png",
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              imageBloc.add(
                                  LoadImageWithFilter(filter: Frame.circle));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        250, 171, 171, 171)),
                              ),
                              child: Image.asset(
                                "assets/images/user_image_frame_3.png",
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              imageBloc.add(
                                  LoadImageWithFilter(filter: Frame.rectangle));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color.fromARGB(250, 171, 171, 171)),
                              ),
                              child: Image.asset(
                                "assets/images/user_image_frame_4.png",
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          img = img;
                          Navigator.pop(context);
                        },
                        child: Text("Use this image")),
                  )
                ],
              ),
            ));
    return File(img.path);
  }
}
