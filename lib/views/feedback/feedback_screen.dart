import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/feature/feedback/bloc/feedback_bloc.dart';
import 'package:mobile/feature/feedback/model/feedback_model.dart';
import 'package:mobile/versions.dart';
import 'package:mobile/widgets/buttons.dart';

class MyFeedbackScreen extends StatefulWidget {
  const MyFeedbackScreen({super.key});

  @override
  State<MyFeedbackScreen> createState() => _MyFeedbackScreenState();
}

class _MyFeedbackScreenState extends State<MyFeedbackScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool showImage = false;
  XFile? image;
  Uint8List? byteImage;
  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      byteImage = await imageTemp.readAsBytes();
      setState(() {
        this.image = imageTemp;

        showImage = true;
      });
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: horizontalPadding16,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalMargin24,
              Text(
                'Title',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              verticalMargin12,
              TextField(
                keyboardType: TextInputType.text,
                maxLength: 200,
                maxLines: 3,
                minLines: 1,
                controller: titleController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9.? ]')),
                ],
                decoration:
                    const InputDecoration.collapsed(hintText: 'Enter Title'),
              ),
              Text(
                'Description',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              verticalMargin12,
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 7,
                controller: descriptionController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enter Description',
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              verticalMargin24,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Build No:\t',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: version,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              verticalMargin16,
              Text(
                'Screen shot',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              verticalMargin16,
              if (!showImage)
                InkWell(
                  onTap: pickImage,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          size: 65,
                          color: Colors.grey,
                        ),
                        Text(
                          'Select Image',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          byteImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            image = null;
                            showImage = false;
                          });
                        },
                        icon: const Icon(
                          Icons.cancel,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              verticalMargin48,
              BlocBuilder<FeedbackBloc, FeedbackState>(
                builder: (context, state) {
                  if (state is FeedbackLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FeedbackError) {
                    return Column(
                      children: [
                        Text(state.message),
                        verticalMargin8,
                        CustomElevatedButton(
                          label: 'Send',
                          onTap: (titleController.text.isNotEmpty &&
                                  descriptionController.text.isNotEmpty)
                              ? () async {
                                  final model = FeedbackModel(
                                    title: titleController.text,
                                    message: descriptionController.text,
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );
                                  context.read<FeedbackBloc>().add(
                                        FeedbackSubmitEvent(
                                          model: model,
                                          image: image,
                                        ),
                                      );

                                  titleController.clear();
                                  descriptionController.clear();
                                  setState(() {
                                    image = null;
                                    byteImage = null;
                                    showImage = false;
                                  });
                                }
                              : null,
                        ),
                      ],
                    );
                  }
                  return CustomElevatedButton(
                    label: 'Send',
                    onTap: (titleController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty)
                        ? () {
                            final model = FeedbackModel(
                              title: titleController.text,
                              message: descriptionController.text,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );
                            context.read<FeedbackBloc>().add(
                                  FeedbackSubmitEvent(
                                    model: model,
                                    image: image,
                                  ),
                                );
                            titleController.clear();
                            descriptionController.clear();
                            setState(() {
                              image = null;
                              byteImage = null;
                              showImage = false;
                            });
                          }
                        : null,
                  );
                },
              ),
              verticalMargin24,
            ],
          ),
        ),
      ),
    );
  }
}
