import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:web_socket_channel/html.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  // WebSocketChannel channel =
  //     HtmlWebSocketChannel.connect("ws://188.120.254.202:1995/?user_id=268");

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController searchController = TextEditingController();

  TextEditingController _chatTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Сообщение',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(children: [
        Container(
          height: 46,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: searchController,
            textAlign: TextAlign.center,
            onChanged: ((value) {
              setState(() {});
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 1)),

              prefixIcon: searchController.text.isEmpty
                  ? Transform.translate(
                      offset: const Offset(85, 0),
                      child: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              hintText: 'Поиск клиентов',
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 0.3, color: Colors.grey)),
              // suffixIcon: IconButton(
              //     onPressed: () {},
              //     icon: SvgPicture.asset('assets/icons/back_menu.svg ',
              //         color: Colors.grey)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // StreamBuilder(
        //     stream: widget.channel.stream,
        //     builder: (context, snapshot) {
        //       print('${snapshot.hasData} ');
        //       return Container(
        //           width: 300,
        //           height: 100,
        //           child: Text(snapshot.hasData ? '${snapshot.data}' : ''));
        //     }),
        const SizedBox(height: 16),
        Container(
          height: 500,
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 100,
                    width: 345,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              const AssetImage('assets/images/kana.png'),
                          radius: 34,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: SvgPicture.asset(
                              'assets/icons/camera.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20.5),
                              width: 224,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Дания',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Сегодня',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20.5),
                              width: 224,
                              child: const Text(
                                'Вы: Заказ стоит на месте',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ]),
    );
  }
}
