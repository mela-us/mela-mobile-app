
import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';

import '../../constants/assets.dart';
import '../../utils/locale/app_localization.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.appBackground,
        elevation: 0,
        title: _buildTitle(context),
      ),
      backgroundColor: Theme.of(context).colorScheme.appBackground,
      body: SingleChildScrollView(
        child: _buildBody(context),
      )
    );
  }

  //Build component:------------------------------------------------------------
  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimens.horizontal_padding),
      child: Row(
        children: [
          _buildHistoryButton(context),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: _buildTextTitle(context)
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBody(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16.0,
          (screenHeight - 610)*0.5,
          16.0,
          0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.waving_hand, color: Colors.blue, size: 48),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                "Xin chào!",
                style: Theme.of(context).textTheme.bigTitle.copyWith(
                  color: Theme.of(context).colorScheme.headTitle
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "Mình là Mela AI, trợ giảng toán của bạn.\nBạn cần mình giúp giải quyết vấn đề gì nào?",
            style: Theme.of(context).textTheme.aiExplainStyle.copyWith(
              color: Theme.of(context).colorScheme.secondary
            )
          ),
          const SizedBox(height: 12),
          TextField(
            style: Theme.of(context).textTheme.questionStyle.copyWith(
              color: Theme.of(context).colorScheme.textInBg1
            ),
            decoration: InputDecoration(
              hintText: "Đặt câu hỏi toán học tại đây...",
              alignLabelWithHint: true,
              hintStyle: Theme.of(context).textTheme.questionStyle.copyWith(
                color: Theme.of(context).colorScheme.secondary
              ),
              suffixIcon: Icon(
                Icons.send,
                size: 14,
                color: Theme
                    .of(context)
                    .colorScheme
                    .sendButton,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 0.1,
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFeatureButton(Icons.functions, "Công thức"),
              _buildFeatureButton(Icons.image_outlined, "Thư viện"),
              _buildFeatureButton(Icons.camera_alt_outlined, "Máy ảnh"),
            ],
          ),
          const SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildListItem("Cách giải phương trình bậc 2 một ẩn"),
              _buildListItem("Hệ thức Vi-et là gì?"),
              _buildListItem("Hướng dẫn mình giải bài toán này"),
              _buildListItem("Nhận xét bài làm của mình"),
            ],
          ),
        ],
      ),
    );
  }

  //Build items:----------------------------------------------------------------
  Widget _buildHistoryButton(BuildContext context){
    return GestureDetector(
      onTap: () => {

      },
      // child: Image.asset(
      //   Assets.arrow_back_longer,
      //   width: 26,
      //   height: 20,
      // ),
      child: SizedBox(
        width: 30,
        height: 30,
        child: Icon(
          Icons.history_rounded,
          size: 30,
          color: Theme.of(context).colorScheme.textInBg1,
        ),
      )
    );
  }

  Widget _buildTextTitle(BuildContext context){
    return Center(
      child: Text(
        "Mela AI",
        style: Theme.of(context)
            .textTheme
            .heading
            .copyWith(color: Theme.of(context).colorScheme.textInBg1),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFeatureButton(IconData icon, String label) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme
              .of(context)
              .colorScheme
              .secondary),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.black, size: 24),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: Theme
                      .of(context)
                      .textTheme
                      .normal
                      .copyWith(
                      color: Colors.black),
                ),
              ],
            ),
            onTap: () {},
          )
        )
    );
  }

  Widget _buildListItem(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Theme
                .of(context)
                .colorScheme
                .secondary,
            width: 0.1,
          ),
          bottom: BorderSide(
            color: Theme
                .of(context)
                .colorScheme
                .secondary,
            width: 0.1,
          ),
        ),
      ),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Bỏ bo góc
        ),
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 0),
        child: ListTile(
          title: Text(
              title,
              style: Theme
                  .of(context)
                  .textTheme
                  .promptTitleStyle.copyWith(
                color: Colors.black
              )),
          trailing: Icon(
              Icons.send,
              size: 14,
              color: Theme
                  .of(context)
                  .colorScheme
                  .sendButton
          ),
          onTap: () {},
        ),
      ),
    );
  }
}



