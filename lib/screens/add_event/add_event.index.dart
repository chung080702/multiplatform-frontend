import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/general/widgets/input_default.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/screens/add_event/add_event.controller.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late TextEditingController eventNameController;
  late TextEditingController eventDescController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController addressController;
  late TextEditingController contentController;
  AddEventController addEventController = AddEventController();
  final _formKey = GlobalKey<FormState>();
  List<File> images = [];
  List<Request> requestEvents = [];
  Request? selectedRequest;
  int page = 1;
  bool isSupportRequest = true;

  @override
  void initState() {
    eventNameController = TextEditingController();
    eventDescController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    addressController = TextEditingController();
    contentController = TextEditingController();
    addEventController.getRequests(page).then((value) {
      setState(() {
        requestEvents = value;
      });
    });
    super.initState();
  }

  void removePicker(File image) {
    setState(() {
      images.removeWhere((item) => item == image);
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        images = [...images, File(image.path)];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm sự kiện"),
        backgroundColor: AppColor.greySoft,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(color: AppColor.greySoft),
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDefault(
                        editingController: eventNameController,
                        labelText: "Tên sự kiện",
                        hintText: "Nhập tên sự kiện",
                        obscureText: false,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "vui lòng nhập tên sự kiện";
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        readOnly: false,
                      ),
                      InputDefault(
                        editingController: eventDescController,
                        labelText: "Miêu tả sự kiện",
                        hintText: "Nhập miêu tả sự kiện",
                        obscureText: false,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập miêu tả";
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        readOnly: false,
                      ),
                      InputDefault(
                        editingController: startTimeController,
                        labelText: "Thời gian diễn ra",
                        hintText: "Nhập thời gian diễn ra",
                        obscureText: false,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập thời gian bắt đầu";
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        readOnly: true,
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          if (pickedDate != null && mounted) {
                            final TimeOfDay? pickedTimeOfDay =
                                await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay.fromDateTime(pickedDate));
                            if (pickedTimeOfDay != null) {
                              setState(() {
                                startTimeController.text = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        pickedTimeOfDay.hour,
                                        pickedTimeOfDay.minute)
                                    .toString();
                              });
                            }
                          }
                        },
                      ),
                      InputDefault(
                        editingController: endTimeController,
                        labelText: "Thời gian kết thúc",
                        hintText: "Nhập thời gian kết thúc",
                        obscureText: false,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập thời gian kết ";
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        readOnly: true,
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          if (pickedDate != null && mounted) {
                            final TimeOfDay? pickedTimeOfDay =
                                await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay.fromDateTime(pickedDate));
                            if (pickedTimeOfDay != null) {
                              setState(() {
                                endTimeController.text = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        pickedTimeOfDay.hour,
                                        pickedTimeOfDay.minute)
                                    .toString();
                              });
                            }
                          }
                        },
                      ),
                      InputDefault(
                        editingController: addressController,
                        labelText: "Địa chỉ",
                        hintText: "Nhập địa chỉ",
                        obscureText: false,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập địa chỉ";
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        readOnly: false,
                      ),
                      InputDefault(
                        editingController: contentController,
                        labelText: "Nội dung",
                        hintText: "Nhập nội dung",
                        obscureText: false,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập nội dung";
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        readOnly: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Yêu cầu trợ giúp",
                                  style: AppTextStyle.textStyle_14_600_20.merge(
                                      const TextStyle(color: AppColor.dark)),
                                ),
                                Checkbox(
                                  value: isSupportRequest,
                                  onChanged: (value) {
                                    setState(() {
                                      isSupportRequest =
                                          value ?? isSupportRequest;
                                    });
                                  },
                                )
                              ],
                            ),
                            IgnorePointer(
                              ignoring: !isSupportRequest,
                              child: Opacity(
                                opacity: isSupportRequest ? 1 : 0.5,
                                child: DropdownButtonFormField2<Request>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // Add more decoration..
                                  ),
                                  hint: Text(
                                    'Chọn yêu cầu trợ giúp',
                                    style: AppTextStyle.textStyle_14_400_20
                                        .merge(const TextStyle(
                                            color: AppColor.grey)),
                                  ),
                                  items: requestEvents
                                      .map((item) => DropdownMenuItem<Request>(
                                            value: item,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  item.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyle
                                                      .textStyle_14_400_20
                                                      .merge(const TextStyle(
                                                          color:
                                                              AppColor.grey)),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  "telephone: ${item.phone}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyle
                                                      .textStyle_14_400_20
                                                      .merge(const TextStyle(
                                                          color:
                                                              AppColor.grey)),
                                                ))
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    selectedRequest = value;
                                  },
                                  onSaved: (value) {},
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.only(right: 8),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Ảnh sự kiện",
                              style: AppTextStyle.textStyle_14_600_20
                                  .merge(const TextStyle(color: AppColor.dark)),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 300,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColor.grey300),
                            ),
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColor.grey300)),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...images.map((image) => Stack(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            height: double.infinity,
                                            width: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(image,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Positioned(
                                              right: 0,
                                              top: -10,
                                              child: IconButton(
                                                onPressed: () {
                                                  removePicker(image);
                                                },
                                                icon: const Icon(
                                                  Icons.delete_outlined,
                                                  color: AppColor.red,
                                                ),
                                              ))
                                        ],
                                      )),
                                  InkWell(
                                    onTap: () {
                                      pickImage();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      height: double.infinity,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1, color: AppColor.grey300),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool result = await addEventController.createEvent(
                          "657ebd5d9afe4c1007dff9af",
                          eventNameController.text,
                          eventDescController.text,
                          startTimeController.text,
                          endTimeController.text,
                          addressController.text,
                          contentController.text,
                          selectedRequest?.id,
                          images);
                      if (result) {
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("addition failed")));
                      }
                    }
                  },
                  child: const Text("Thêm sự kiện"))
            ],
          ),
        ),
      ),
    );
  }
}
