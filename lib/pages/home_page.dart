import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.74,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                //要素を戻り値で返す
                return Container(
                  color: index.isEven ? Colors.blue : Colors.yellow,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class HomePage extends ConsumerWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final postRepository = ref.watch(PostRepositoryProvider);
//     // ダミー画像一覧
//     final List<String> imageList = [
//       'https://placehold.jp/400x300.png?text=0',
//       'https://placehold.jp/400x300.png?text=1',
//       'https://placehold.jp/400x300.png?text=2',
//       'https://placehold.jp/400x300.png?text=3',
//       'https://placehold.jp/400x300.png?text=4',
//       'https://placehold.jp/400x300.png?text=5',
//       'https://placehold.jp/400x300.png?text=0',
//       'https://placehold.jp/400x300.png?text=1',
//       'https://placehold.jp/400x300.png?text=2',
//       'https://placehold.jp/400x300.png?text=3',
//       'https://placehold.jp/400x300.png?text=4',
//       'https://placehold.jp/400x300.png?text=5',
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ホーム'),
//       ),
//       body: GridView.count(
//         // 1行あたりに表示するWidgetの数
//         crossAxisCount: 2,
//         // Widget間のスペース（上下）
//         mainAxisSpacing: 4,
//         // Widget間のスペース（左右）
//         crossAxisSpacing: 4,
//         // 全体の余白
//         padding: const EdgeInsets.all(8),
//         children: imageList.map((String imageURL) {
//           return SizedBox(
//             width: double.infinity,
//             height: double.infinity,
//             child: InkWell(
//               onTap: () => {},
//               child: Image.network(
//                 imageURL,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
