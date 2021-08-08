import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:link_preview_builder/link_preview_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

enum status { loading, success }

class AppController {
  final state = ValueNotifier<status>(status.success);
  final index = ValueNotifier<int>(-1);
  final urls = ValueNotifier<List<String>>([
    'https://www.uol.com.br/esporte/olimpiadas/reportagens-especiais/thiago-braz-prova-que-um-raio-cai-duas-vezes-no-mesmo-lugar-e-e-bronze/',
    'https://g1.globo.com/mundo/noticia/2021/08/02/quais-sao-as-regras-para-a-entrada-de-brasileiros-na-europa.ghtml',
  ]);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController(
      text:
          'https://olhardigital.com.br/2021/08/02/pro/ti-vagas-desenvolvimento-ux-design/');
  final _controller = AppController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              ValueListenableBuilder<status>(
                  valueListenable: _controller.state,
                  builder: (_, __, child) =>
                      BuildCustomLinkPreview(controller: _textController)),
              TextField(controller: _textController),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      _controller.state.value = status.loading;
                      _controller.urls.value.add(_textController.text);
                      _controller.state.value = status.success;
                    },
                    child: const Text("get"),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      _controller.state.value = status.loading;
                      _controller.index.value++;
                      if (_controller.index.value >=
                          _controller.urls.value.length)
                        _controller.index.value = 0;
                      _textController.text =
                          _controller.urls.value[_controller.index.value];
                      _controller.state.value = status.success;
                    },
                    child: const Text("next"),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _textController.clear,
                    child: const Text("clear"),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildCustomLinkPreview extends StatelessWidget {
  // ignore: diagnostic_describe_all_properties
  final TextEditingController controller;
  const BuildCustomLinkPreview({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinkPreviewBuilder(
      url: controller.value.text,
      builder: (preview) {
        if (preview == null) const SizedBox();
        if (preview is MediaPreview)
          CachedNetworkImage(
            imageUrl: preview.image ?? '',
            fit: BoxFit.contain,
          );
        final DataPreview dataPreview = preview as DataPreview;
        if (dataPreview.title == null) const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: dataPreview.icon ?? "",
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      fit: BoxFit.contain,
                      width: 30,
                      height: 30,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.link);
                      },
                    );
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    dataPreview.title ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (dataPreview.description != null) ...[
              const SizedBox(height: 8),
              Text(
                dataPreview.description ?? '',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (dataPreview.image != null) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: CachedNetworkImage(
                  imageUrl: dataPreview.image ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ]
          ],
        );
      },
    );
  }
}
