import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/general/widgets/inpu_default.dart';

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
  late TextEditingController addressTimeController;
  late TextEditingController contentTimeController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    eventNameController = TextEditingController();
    eventDescController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    addressTimeController = TextEditingController();
    contentTimeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(color: AppColor.greySoft),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Thêm sự kiện",
                    style: AppTextStyle.textStyle_24_600_36
                        .merge(const TextStyle(color: AppColor.dark)),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
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
                              return "vui lòng nhập miêu tả";
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
                              return "vui lòng nhập thời gian bắt đầu";
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
                              return "vui lòng nhập thời gian kết ";
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
                          editingController: addressTimeController,
                          labelText: "Địa chỉ",
                          hintText: "Nhập địa chỉ",
                          obscureText: false,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "vui lòng nhập địa chỉ";
                            }
                            return null;
                          },
                          textInputType: TextInputType.text,
                          readOnly: false,
                        ),
                        InputDefault(
                          editingController: addressTimeController,
                          labelText: "Nội dung",
                          hintText: "Nhập nội dung",
                          obscureText: false,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "vui lòng nhập nội dung";
                            }
                            return null;
                          },
                          textInputType: TextInputType.text,
                          readOnly: false,
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: Text("Thêm sự kiện"))
              ],
            ),
          ),
        ));
  }
}
