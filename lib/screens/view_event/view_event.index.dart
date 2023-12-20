import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';
import 'package:multiplatform_app/screens/view_event/brief_event.dart';
import 'package:multiplatform_app/screens/view_event/view_event.controller.dart';
import 'package:multiplatform_app/models/event.model.dart';

class ViewEvent extends StatefulWidget {
  const ViewEvent({super.key});

  @override
  State<ViewEvent> createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  late TextEditingController filterEditingController;
  ViewEventController viewEventController = ViewEventController();
  int page = 1;
  List<Map<String, String>> list = [
    {
      "href":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH__I8kgPXeY9QKSEmFZJUYw4S3ftX0DTx_ZDBVuqYmBFfe89_wbp4pljDQAmZb-VhVUs&usqp=CAU",
      "name": "Giúp đỡ trẻ em vùng cao",
      "desc": "Chúng ta sẽ lên Cao Bằng để giúo đỡ trẻ em nhỏ tuổi",
      "startTime": "9A.M-04/12/2023",
      "endTime": "5P.M-05/12/2023",
      "address": "An Lạc - Hạ Lang - Cao Bằng",
      "content":
          "Thời tiết đang dần chuyển mùa bằng những cơn mưa mang theo hơi lạnh, cũng là lúc quý vị mở ngăn tủ tìm cho con mình những chiếc áo thay mùa. Khi mà các em nhỏ thành phố được diện những chiếc áo len, áo khoác mới ấm áp, thời trang thì đâu đó trên những bản làng miền núi, vùng cao, những em bé vẫn còn phải sống trong điều kiện vô cùng nghèo khó, vất vả. Trong cái rét cắt da, cắt thịt các em vẫn chỉ tới trường với những tấm áo mong manh, không giày tất, khăn, mũ ấm, bởi cơm ăn mỗi ngày còn chưa đủ no. Khi con quý vị được nằm trong chăn êm, nệm ấm, được chăm sóc chu đáo từ bữa ăn, giấc ngủ thì đâu đó, những đứa trẻ vùng khó khăn vẫn phải nhịn đói mỗi sáng đến trường. Những chiếc áo thử lại sau mùa hè của con, cháu quý vị bị chật, bị ngắn nong không vừa, quý vị có thể mở lòng tư bi chia sẻ cùng các con em tại các vùng còn gian khó.Tháng 11 đang đến gần, nhân dịp kỷ niệm Ngày Hiến chương các Nhà giáo, Ban đại diện cha mẹ phụ huynh Trường Mầm non Trần Nguyên Hãn phối hợp với Ban giám hiệu nhà trường mở chiến dịch kêu gọi “Áo ấm cho con”. Chúng tôi mong nhận được sự quan tâm ủng hộ, chia sẻ từ tất cả các nhà hảo tâm, quý thầy cô, quý phụ huynh. Mọi sự đóng góp, ủng hộ quần áo, chăn màn, truyện, đồ chơi và tiền mặt quý vị hãy gửi về Ban đại diện Hội phụ huynh các lớp cùng các cô giáo trực tiếp tại các lớp. Thời gian ủng hộ bắt đầu từ 25/10/2018 và kết thúc đợt cao điểm trước ngày 12/ 11/ 2018.Ban tổ chức chiến dịch rất mong nhận được sự đồng tâm rộng lòng từ tất cả quý vị để chương trình “Áo ấm cho con” được thành công",
    },
    {
      "href":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH__I8kgPXeY9QKSEmFZJUYw4S3ftX0DTx_ZDBVuqYmBFfe89_wbp4pljDQAmZb-VhVUs&usqp=CAU",
      "name": "Giúp đỡ trẻ em vùng cao",
      "desc": "Chúng ta sẽ lên Cao Bằng để giúo đỡ trẻ em nhỏ tuổi",
      "startTime": "9A.M-04/12/2023",
      "endTime": "5P.M-05/12/2023",
      "address": "An Lạc - Hạ Lang - Cao Bằng",
      "content":
          "Thời tiết đang dần chuyển mùa bằng những cơn mưa mang theo hơi lạnh, cũng là lúc quý vị mở ngăn tủ tìm cho con mình những chiếc áo thay mùa. Khi mà các em nhỏ thành phố được diện những chiếc áo len, áo khoác mới ấm áp, thời trang thì đâu đó trên những bản làng miền núi, vùng cao, những em bé vẫn còn phải sống trong điều kiện vô cùng nghèo khó, vất vả. Trong cái rét cắt da, cắt thịt các em vẫn chỉ tới trường với những tấm áo mong manh, không giày tất, khăn, mũ ấm, bởi cơm ăn mỗi ngày còn chưa đủ no. Khi con quý vị được nằm trong chăn êm, nệm ấm, được chăm sóc chu đáo từ bữa ăn, giấc ngủ thì đâu đó, những đứa trẻ vùng khó khăn vẫn phải nhịn đói mỗi sáng đến trường. Những chiếc áo thử lại sau mùa hè của con, cháu quý vị bị chật, bị ngắn nong không vừa, quý vị có thể mở lòng tư bi chia sẻ cùng các con em tại các vùng còn gian khó.Tháng 11 đang đến gần, nhân dịp kỷ niệm Ngày Hiến chương các Nhà giáo, Ban đại diện cha mẹ phụ huynh Trường Mầm non Trần Nguyên Hãn phối hợp với Ban giám hiệu nhà trường mở chiến dịch kêu gọi “Áo ấm cho con”. Chúng tôi mong nhận được sự quan tâm ủng hộ, chia sẻ từ tất cả các nhà hảo tâm, quý thầy cô, quý phụ huynh. Mọi sự đóng góp, ủng hộ quần áo, chăn màn, truyện, đồ chơi và tiền mặt quý vị hãy gửi về Ban đại diện Hội phụ huynh các lớp cùng các cô giáo trực tiếp tại các lớp. Thời gian ủng hộ bắt đầu từ 25/10/2018 và kết thúc đợt cao điểm trước ngày 12/ 11/ 2018.Ban tổ chức chiến dịch rất mong nhận được sự đồng tâm rộng lòng từ tất cả quý vị để chương trình “Áo ấm cho con” được thành công",
    },
    {
      "href":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH__I8kgPXeY9QKSEmFZJUYw4S3ftX0DTx_ZDBVuqYmBFfe89_wbp4pljDQAmZb-VhVUs&usqp=CAU",
      "name": "Giúp đỡ trẻ em vùng cao",
      "desc": "Chúng ta sẽ lên Cao Bằng để giúo đỡ trẻ em nhỏ tuổi",
      "startTime": "9A.M-04/12/2023",
      "endTime": "5P.M-05/12/2023",
      "address": "An Lạc - Hạ Lang - Cao Bằng",
      "content":
          "Thời tiết đang dần chuyển mùa bằng những cơn mưa mang theo hơi lạnh, cũng là lúc quý vị mở ngăn tủ tìm cho con mình những chiếc áo thay mùa. Khi mà các em nhỏ thành phố được diện những chiếc áo len, áo khoác mới ấm áp, thời trang thì đâu đó trên những bản làng miền núi, vùng cao, những em bé vẫn còn phải sống trong điều kiện vô cùng nghèo khó, vất vả. Trong cái rét cắt da, cắt thịt các em vẫn chỉ tới trường với những tấm áo mong manh, không giày tất, khăn, mũ ấm, bởi cơm ăn mỗi ngày còn chưa đủ no. Khi con quý vị được nằm trong chăn êm, nệm ấm, được chăm sóc chu đáo từ bữa ăn, giấc ngủ thì đâu đó, những đứa trẻ vùng khó khăn vẫn phải nhịn đói mỗi sáng đến trường. Những chiếc áo thử lại sau mùa hè của con, cháu quý vị bị chật, bị ngắn nong không vừa, quý vị có thể mở lòng tư bi chia sẻ cùng các con em tại các vùng còn gian khó.Tháng 11 đang đến gần, nhân dịp kỷ niệm Ngày Hiến chương các Nhà giáo, Ban đại diện cha mẹ phụ huynh Trường Mầm non Trần Nguyên Hãn phối hợp với Ban giám hiệu nhà trường mở chiến dịch kêu gọi “Áo ấm cho con”. Chúng tôi mong nhận được sự quan tâm ủng hộ, chia sẻ từ tất cả các nhà hảo tâm, quý thầy cô, quý phụ huynh. Mọi sự đóng góp, ủng hộ quần áo, chăn màn, truyện, đồ chơi và tiền mặt quý vị hãy gửi về Ban đại diện Hội phụ huynh các lớp cùng các cô giáo trực tiếp tại các lớp. Thời gian ủng hộ bắt đầu từ 25/10/2018 và kết thúc đợt cao điểm trước ngày 12/ 11/ 2018.Ban tổ chức chiến dịch rất mong nhận được sự đồng tâm rộng lòng từ tất cả quý vị để chương trình “Áo ấm cho con” được thành công",
    },
    {
      "href":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH__I8kgPXeY9QKSEmFZJUYw4S3ftX0DTx_ZDBVuqYmBFfe89_wbp4pljDQAmZb-VhVUs&usqp=CAU",
      "name": "Giúp đỡ trẻ em vùng cao",
      "desc": "Chúng ta sẽ lên Cao Bằng để giúo đỡ trẻ em nhỏ tuổi",
      "startTime": "9A.M-04/12/2023",
      "endTime": "5P.M-05/12/2023",
      "address": "An Lạc - Hạ Lang - Cao Bằng",
      "content":
          "Thời tiết đang dần chuyển mùa bằng những cơn mưa mang theo hơi lạnh, cũng là lúc quý vị mở ngăn tủ tìm cho con mình những chiếc áo thay mùa. Khi mà các em nhỏ thành phố được diện những chiếc áo len, áo khoác mới ấm áp, thời trang thì đâu đó trên những bản làng miền núi, vùng cao, những em bé vẫn còn phải sống trong điều kiện vô cùng nghèo khó, vất vả. Trong cái rét cắt da, cắt thịt các em vẫn chỉ tới trường với những tấm áo mong manh, không giày tất, khăn, mũ ấm, bởi cơm ăn mỗi ngày còn chưa đủ no. Khi con quý vị được nằm trong chăn êm, nệm ấm, được chăm sóc chu đáo từ bữa ăn, giấc ngủ thì đâu đó, những đứa trẻ vùng khó khăn vẫn phải nhịn đói mỗi sáng đến trường. Những chiếc áo thử lại sau mùa hè của con, cháu quý vị bị chật, bị ngắn nong không vừa, quý vị có thể mở lòng tư bi chia sẻ cùng các con em tại các vùng còn gian khó.Tháng 11 đang đến gần, nhân dịp kỷ niệm Ngày Hiến chương các Nhà giáo, Ban đại diện cha mẹ phụ huynh Trường Mầm non Trần Nguyên Hãn phối hợp với Ban giám hiệu nhà trường mở chiến dịch kêu gọi “Áo ấm cho con”. Chúng tôi mong nhận được sự quan tâm ủng hộ, chia sẻ từ tất cả các nhà hảo tâm, quý thầy cô, quý phụ huynh. Mọi sự đóng góp, ủng hộ quần áo, chăn màn, truyện, đồ chơi và tiền mặt quý vị hãy gửi về Ban đại diện Hội phụ huynh các lớp cùng các cô giáo trực tiếp tại các lớp. Thời gian ủng hộ bắt đầu từ 25/10/2018 và kết thúc đợt cao điểm trước ngày 12/ 11/ 2018.Ban tổ chức chiến dịch rất mong nhận được sự đồng tâm rộng lòng từ tất cả quý vị để chương trình “Áo ấm cho con” được thành công",
    },
    {
      "href":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH__I8kgPXeY9QKSEmFZJUYw4S3ftX0DTx_ZDBVuqYmBFfe89_wbp4pljDQAmZb-VhVUs&usqp=CAU",
      "name": "Giúp đỡ trẻ em vùng cao",
      "desc": "Chúng ta sẽ lên Cao Bằng để giúo đỡ trẻ em nhỏ tuổi",
      "startTime": "9A.M-04/12/2023",
      "endTime": "5P.M-05/12/2023",
      "address": "An Lạc - Hạ Lang - Cao Bằng",
      "content":
          "Thời tiết đang dần chuyển mùa bằng những cơn mưa mang theo hơi lạnh, cũng là lúc quý vị mở ngăn tủ tìm cho con mình những chiếc áo thay mùa. Khi mà các em nhỏ thành phố được diện những chiếc áo len, áo khoác mới ấm áp, thời trang thì đâu đó trên những bản làng miền núi, vùng cao, những em bé vẫn còn phải sống trong điều kiện vô cùng nghèo khó, vất vả. Trong cái rét cắt da, cắt thịt các em vẫn chỉ tới trường với những tấm áo mong manh, không giày tất, khăn, mũ ấm, bởi cơm ăn mỗi ngày còn chưa đủ no. Khi con quý vị được nằm trong chăn êm, nệm ấm, được chăm sóc chu đáo từ bữa ăn, giấc ngủ thì đâu đó, những đứa trẻ vùng khó khăn vẫn phải nhịn đói mỗi sáng đến trường. Những chiếc áo thử lại sau mùa hè của con, cháu quý vị bị chật, bị ngắn nong không vừa, quý vị có thể mở lòng tư bi chia sẻ cùng các con em tại các vùng còn gian khó.Tháng 11 đang đến gần, nhân dịp kỷ niệm Ngày Hiến chương các Nhà giáo, Ban đại diện cha mẹ phụ huynh Trường Mầm non Trần Nguyên Hãn phối hợp với Ban giám hiệu nhà trường mở chiến dịch kêu gọi “Áo ấm cho con”. Chúng tôi mong nhận được sự quan tâm ủng hộ, chia sẻ từ tất cả các nhà hảo tâm, quý thầy cô, quý phụ huynh. Mọi sự đóng góp, ủng hộ quần áo, chăn màn, truyện, đồ chơi và tiền mặt quý vị hãy gửi về Ban đại diện Hội phụ huynh các lớp cùng các cô giáo trực tiếp tại các lớp. Thời gian ủng hộ bắt đầu từ 25/10/2018 và kết thúc đợt cao điểm trước ngày 12/ 11/ 2018.Ban tổ chức chiến dịch rất mong nhận được sự đồng tâm rộng lòng từ tất cả quý vị để chương trình “Áo ấm cho con” được thành công",
    },
    {
      "href":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH__I8kgPXeY9QKSEmFZJUYw4S3ftX0DTx_ZDBVuqYmBFfe89_wbp4pljDQAmZb-VhVUs&usqp=CAU",
      "name": "Giúp đỡ trẻ em vùng cao",
      "desc": "Chúng ta sẽ lên Cao Bằng để giúo đỡ trẻ em nhỏ tuổi",
      "startTime": "9A.M-04/12/2023",
      "endTime": "5P.M-05/12/2023",
      "address": "An Lạc - Hạ Lang - Cao Bằng",
      "content":
          "Thời tiết đang dần chuyển mùa bằng những cơn mưa mang theo hơi lạnh, cũng là lúc quý vị mở ngăn tủ tìm cho con mình những chiếc áo thay mùa. Khi mà các em nhỏ thành phố được diện những chiếc áo len, áo khoác mới ấm áp, thời trang thì đâu đó trên những bản làng miền núi, vùng cao, những em bé vẫn còn phải sống trong điều kiện vô cùng nghèo khó, vất vả. Trong cái rét cắt da, cắt thịt các em vẫn chỉ tới trường với những tấm áo mong manh, không giày tất, khăn, mũ ấm, bởi cơm ăn mỗi ngày còn chưa đủ no. Khi con quý vị được nằm trong chăn êm, nệm ấm, được chăm sóc chu đáo từ bữa ăn, giấc ngủ thì đâu đó, những đứa trẻ vùng khó khăn vẫn phải nhịn đói mỗi sáng đến trường. Những chiếc áo thử lại sau mùa hè của con, cháu quý vị bị chật, bị ngắn nong không vừa, quý vị có thể mở lòng tư bi chia sẻ cùng các con em tại các vùng còn gian khó.Tháng 11 đang đến gần, nhân dịp kỷ niệm Ngày Hiến chương các Nhà giáo, Ban đại diện cha mẹ phụ huynh Trường Mầm non Trần Nguyên Hãn phối hợp với Ban giám hiệu nhà trường mở chiến dịch kêu gọi “Áo ấm cho con”. Chúng tôi mong nhận được sự quan tâm ủng hộ, chia sẻ từ tất cả các nhà hảo tâm, quý thầy cô, quý phụ huynh. Mọi sự đóng góp, ủng hộ quần áo, chăn màn, truyện, đồ chơi và tiền mặt quý vị hãy gửi về Ban đại diện Hội phụ huynh các lớp cùng các cô giáo trực tiếp tại các lớp. Thời gian ủng hộ bắt đầu từ 25/10/2018 và kết thúc đợt cao điểm trước ngày 12/ 11/ 2018.Ban tổ chức chiến dịch rất mong nhận được sự đồng tâm rộng lòng từ tất cả quý vị để chương trình “Áo ấm cho con” được thành công",
    }
  ];

  @override
  void initState() {
    filterEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: const BoxDecoration(color: AppColor.white),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: filterEditingController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search...",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                  style: const TextStyle(
                          color: AppColor.dark,
                          decoration: TextDecoration.none,
                          decorationThickness: 0)
                      .merge(AppTextStyle.textStyle_12_400_18),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColor.buttonGreen,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  child: const Text(
                    "Search",
                    style: AppTextStyle.textStyle_12_600_18,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          FutureBuilder(future: viewEventController.getEvents(page), builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if(snapshot.hasError) {
              return Text("Error ${snapshot.error.toString()}");
            }
            if(snapshot.hasData) {
              final List<Event>? events = snapshot.data;
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: events!.length,
                  itemBuilder: (context, index) {
                    return BriefEvent(
                      hrefs: events[index].imageIds,
                      name: events[index].name,
                      desc: events[index].description,
                      startTime: events[index].start,
                      endTime: events[index].end,
                      address: events[index].address,
                      content: events[index].content,
                    );
                  },
                ),
              );
            }
            return const SizedBox();
          },)
        ]),
      ),
    );
  }
}
