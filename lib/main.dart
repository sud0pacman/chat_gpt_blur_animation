import 'package:chat_gpt_blur_animation/widgets/animation_gradient_text.dart';
import 'package:chat_gpt_blur_animation/widgets/blurry_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Animation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ChatGPT Image Creation Animation in Flutter",
                  style: TextStyle(
                    color: Color(0xE3FFFFFF),
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 16,),

                Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedGradientText(
                    text: "Image creating"
                  ),
                ),

                SizedBox(height: 8,),

                BlurryWidget(
                  imgAsset: "assets/image.jpg",
                  initialHeight: MediaQuery.of(context).size.width + 100,
                  initialWidth: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}