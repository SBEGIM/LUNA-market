import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:haji_market/src/feature/home/data/repository/popular_shops_repository.dart';
import 'package:share_plus/share_plus.dart';

class MetasPage extends StatefulWidget {
  final String? title;
  final String? body;

  const MetasPage({this.title, this.body, super.key});

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  String htmlText = r"""<h1>AppFlowyEditor</h1>
<h2>👋 <strong>Welcome to</strong> <strong><em><a href="appflowy.io">AppFlowy Editor</a></em></strong></h2>
  <p>AppFlowy Editor is a <strong>highly customizable</strong> <em>rich-text editor</em></p>
<hr />
<p><u>Here</u> is an example <del>your</del> you can give a try</p>
<br>
<span style="font-weight: bold;background-color: #cccccc;font-style: italic;">Span element</span>
<span style="font-weight: medium;text-decoration: underline;">Span element two</span>
</br>
<span style="font-weight: 900;text-decoration: line-through;">Span element three</span>
<a href="https://appflowy.io">This is an anchor tag!</a>
<img src="https://images.squarespace-cdn.com/content/v1/617f6f16b877c06711e87373/c3f23723-37f4-44d7-9c5d-6e2a53064ae7/Asset+10.png?format=1500w" />
<h3>Features!</h3>
<ul>
  <li>[x] Customizable</li>
  <li>[x] Test-covered</li>
  <li>[ ] more to come!</li>
</ul>
<ol>
  <li>First item</li>
  <li>Second item</li>
</ol>
<li>List element</li>
<blockquote>
  <p>This is a quote!</p>
</blockquote>
<code>
  Code block
</code>
<em>Italic one</em> <i>Italic two</i>
<b>Bold tag</b>
<img src="http://appflowy.io" alt="AppFlowy">
<p>You can also use <strong><em>AppFlowy Editor</em></strong> as a component to build your own app.</p>
<h3>Awesome features</h3>

<p>If you have questions or feedback, please submit an issue on Github or join the community along with 1000+ builders!</p>
  <h3>Checked Boxes</h3>
 <input type="checkbox" id="option2" checked> 
  <label for="option2">Option 2</label>
  <input type="checkbox" id="option3"> 
  <label for="option3">Option 3</label>
  """;

  bool load = false;

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг',
  ];
  String type = '';

  @override
  void initState() {
    super.initState();
    switch (widget.title) {
      case 'Пользовательское соглашение':
        type = 'terms_of_use';
        break;
      case 'Оферта для продавцов':
        type = 'privacy_policy';
        break;
      case 'Политика конфиденциальности':
        type = 'contract_offer';
        break;

      case 'Типовой договор купли-продажи':
        type = 'shipping_payment';
        break;

      case 'Типовой договор на оказание рекламных услуг':
        type = 'TTH';
        break;

      default:
        type = 'pdf';
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title ?? 'Рассрочка', style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.share),
            onPressed: () async {
              setState(() {});

              await Share.share("$baseUrl/pdf/$type");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(child: Html(data: widget.body)),
    );
  }
}
