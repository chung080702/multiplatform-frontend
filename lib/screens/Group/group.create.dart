import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiplatform_app/screens/Group/group.controller.dart';
import 'package:multiplatform_app/screens/Group/group.detail.dart';
import 'package:multiplatform_app/screens/Group/group.list.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupDescController = TextEditingController();
  final _form = GlobalKey<FormState>();
  File? bgImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        bgImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tạo nhóm"),
        centerTitle: true,
      ),
      body: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  controller: groupNameController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter group name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Tên nhóm"),
                ),
                Container(
                  height: 16,
                ),
                TextFormField(
                  controller: groupDescController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter group description";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Thêm mô tả",
                      alignLabelWithHint: true),
                  maxLines: null,
                  minLines: 3,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Thêm ảnh bìa",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: bgImage == null
                                  ? Image.network(
                                      'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/06/tai-hinh-nen-dep-nhat-the-gioi-57.jpg',
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(
                                      bgImage!,
                                      height: double.infinity,
                                      fit: BoxFit.contain,
                                    ),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: const Text("Tải ảnh lên"))
                      ],
                    )),
                Container(height: 8),
                FilledButton(
                    onPressed: () async {
                      if (_form.currentState!.validate() && bgImage != null) {
                        final bool createdGroup = await fetchCreateGroup(
                            groupNameController.text,
                            groupDescController.text,
                            bgImage!);
                        if (createdGroup) {
                        } else {}
                      }
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text("Xong"),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
