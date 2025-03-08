import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key, required this.onOpeningConversation});
  final VoidCallback onOpeningConversation;
  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  final Map<String, bool> isExpanded = {
    "Hôm nay": false,
    "Hôm qua": true,
    "Thứ Sáu, 28/02": true,
  };

  final List<String> historyItems = [
    "Chu vi hình tròn",
    "Tìm quy luật dãy số",
    "Phép cộng số có hai chữ số có nhớ trying to make this line overflow",
    "Quy luật hình học",
    "Tính chất chia hết cho 7"
  ];
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.75, // Điều chỉnh chiều rộng của sidebar
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.appBackground,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: _buildAppBarTitle(context),
              automaticallyImplyLeading: false,
            ),
            // const SizedBox(height: 30),
            _buildSearchBar(context), // Tìm kiếm
            const SizedBox(height: 30),
            _buildHistoryList(context),
          ],
        ),
      ),
    );
  }
  //build items-----------------------------------------------------------------
  Widget _buildAppBarTitle(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Text(
          "Lịch sử",
          style: Theme.of(context).textTheme.heading.copyWith(
            color: Theme.of(context).colorScheme.textInBg1,
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        style: Theme.of(context).textTheme.aiExplainStyle.copyWith(
          color: Theme.of(context).colorScheme.textInBg1,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search, size: 20),
          hintText: "Tìm đoạn chat . . .",
          hintStyle: Theme.of(context).textTheme.aiExplainStyle.copyWith(
            color: Theme.of(context).colorScheme.inputHintText,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),

        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          children: isExpanded.keys.map((title) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiêu đề lịch sử & icon mở rộng
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded[title] = !isExpanded[title]!;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.contentBold.copyWith(
                          color: Theme.of(context).colorScheme.timelineTitle,
                        ),
                      ),
                      Icon(
                        isExpanded[title]!
                            ? Icons.indeterminate_check_box_outlined
                            : Icons.add_box_outlined,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Nội dung lịch sử nếu mở rộng
                if (isExpanded[title]!)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: historyItems
                        .map((item) => _buildChatHistory(item))
                        .toList(),
                  ),
                isExpanded[title]! ?
                  const SizedBox(height: 0) : const SizedBox(height: 5),
                const Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildChatHistory(String item) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: GestureDetector(
          onTap: () {
            widget.onOpeningConversation();
            Navigator.of(context).pop();
          },
          child: Text(
            item,
            style: Theme.of(context).textTheme.contentBold.copyWith(
              fontWeight: FontWeight.w500,
              color: const Color(0XFF303030),
            ),
          ),
        )
    );
  }
}
