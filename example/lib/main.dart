import 'package:flutter/material.dart';
import 'package:smart_image/smart_image.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SmartImageDemo(),
    );
  }
}

class SmartImageDemo extends StatelessWidget {
  const SmartImageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SmartImage Demo")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          runSpacing: 20,
          spacing: 20,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: [
            /// ✅ Network Image + Shimmer
            demoBox(
              "Network Image (Shimmer)",
              SmartImage(
                imageUrl: "https://picsum.photos/200",
                height: 80,
                width: 80,
              ),
            ),

            /// ✅ Network Image with FadeIn
            demoBox(
              "FadeIn Animation",
              SmartImage(
                imageUrl: "https://picsum.photos/210",
                height: 80,
                width: 80,
                loadingAnimation: LoadingAnimation.fadeIn,
              ),
            ),

            /// ✅ SVG Image
            demoBox(
              "Asset SVG",
              SmartImage(
                imageUrl: "assets/flutter_logo.svg",
                height: 80,
                width: 80,
              ),
            ),

            /// ✅ BlurHash Loading
            demoBox(
              "BlurHash Animation",
              SmartImage(
                imageUrl: "https://picsum.photos/220",
                height: 80,
                width: 80,
                blurHash: "LEHV6nWB2yk8pyo0adR*.7kCMdnj",
                loadingAnimation: LoadingAnimation.blurhash,
              ),
            ),

            /// ✅ Tint Color Test
            demoBox(
              "Tint Color",
              SmartImage(
                imageUrl: "assets/icons/person.svg",
                height: 80,
                width: 80,
                fit: BoxFit.fitHeight,
                backgroundColor: Colors.yellow,
                tintColor: Colors.blue,
                padding: EdgeInsets.all(10),
              ),
            ),

            /// ✅ Use Initials Fallback
            demoBox(
              "Initials Fallback (Circle)",
              SmartImage(
                imageUrl: "",
                name: "Ashish Mistry",
                height: 80,
                width: 80,
                useNameAsFallback: true,
                backgroundColor: Colors.purple,
                textColor: Colors.white,
              ),
            ),

            /// ✅ Rounded Avatar
            demoBox(
              "Rounded (2 initials)",
              SmartImage(
                imageUrl: "",
                name: "Smart Image",
                height: 80,
                width: 80,
                initialsShape: AvatarShape.rounded,
                borderRadius: 12,
                useNameAsFallback: true,
                backgroundColor: Colors.orange,
                initialsTextStyle: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),

            /// ✅ Semantics + Tooltip
            demoBox(
              "Tooltip / Accessibility",
              SmartImage(
                imageUrl: "https://picsum.photos/180",
                height: 80,
                width: 80,
                tooltip: "Profile Image",
                semanticLabel: "User Image",
              ),
            ),

            /// ✅ Error Widget Demo
            demoBox(
              "Error Widget",
              SmartImage(
                imageUrl: "https://invalid-url.com/img.png",
                height: 80,
                width: 80,
                backgroundColor: Colors.cyan,
                errorWidget: const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget demoBox(String title, Widget widget) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget,
        const SizedBox(height: 6),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}
