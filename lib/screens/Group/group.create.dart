import 'package:flutter/material.dart';

class CreateGroup extends StatelessWidget {
  const CreateGroup({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo nhóm"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Tên nhóm"
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              alignment: Alignment.topLeft,
              child: Text(
                "Thêm ảnh bìa",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                      aspectRatio: 4/3,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/06/tai-hinh-nen-dep-nhat-the-gioi-57.jpg',
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      )
                  ),
                  OutlinedButton(
                    onPressed: () {}, 
                    child: Text("Tải ảnh lên")
                  )
                ],
              )
            ),
            Container(height: 8),
            FilledButton(
              onPressed: () {},
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text("Xong"),
                ),
              )
            )
            
          ],
        ),
      ),
    );
  }

}