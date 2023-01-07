import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supamemo/pages/home_page.dart';
import 'package:supamemo/repositories/post_repository.dart';

class AddPostPage extends ConsumerWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(PostRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('スパイク追加ページ'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 150 * 2,
                height: 110 * 2,
                color: const Color.fromARGB(255, 216, 211, 211),
                child: InkWell(
                  child: viewModel.imageFile == null
                      ? Stack(
                          children: [
                            const Center(
                              child: Icon(
                                Icons.camera_enhance,
                                size: 50,
                              ),
                            ),
                            if (viewModel.isLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        )
                      : Image.file(
                          viewModel.imageFile!,
                          fit: BoxFit.cover,
                        ),
                  onTap: () => viewModel.pickImage(),
                ),
              ),
              const Text(
                'スパイクの写真（必須）',
                style: TextStyle(color: Color.fromARGB(255, 116, 106, 106)),
              ),
              if (viewModel.errorTextForUploadImage.isNotEmpty)
                const Text(
                  '画像アップロードに失敗しました。ページをリロードして、再度アップロード操作を行ってください',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  controller: viewModel.nameController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    labelText: 'スパイクの名前（必須）',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (text) => viewModel.inputPostName(text),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  controller: viewModel.contentController,
                  keyboardType: TextInputType.multiline,
                  minLines: 7,
                  maxLines: 7,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    labelText: 'スパイクとの思い出（必須）',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (text) => viewModel.inputPostContent(text),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                child: const Text('追加'),
                onPressed: viewModel.newPost.name.isNotEmpty &&
                        viewModel.newPost.content.isNotEmpty &&
                        viewModel.imageFile != null
                    ? () async {
                        await viewModel.addPostData();
                        viewModel.nameController.clear();
                        viewModel.contentController.clear();
                        viewModel.imageUrlController.clear();
                        // ignore: use_build_context_synchronously
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content:
                                Text('${viewModel.newPost.name}の登録が完了しました'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (_) => false,
                                ),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (_) => false,
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
