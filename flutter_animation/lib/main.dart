import 'package:flutter/material.dart';
import 'package:flutter_animation/s1/animation_tween.dart';
import 'package:flutter_animation/s2/animated_align.dart';
import 'package:flutter_animation/s2/animated_container.dart';
import 'package:flutter_animation/s2/animated_cross_fade.dart';
import 'package:flutter_animation/s2/animated_list.dart';
import 'package:flutter_animation/s2/animated_opacity.dart';
import 'package:flutter_animation/s2/animated_padding.dart';
import 'package:flutter_animation/s2/animated_physical_model.dart';
import 'package:flutter_animation/s2/animated_poisitioned.dart';
import 'package:flutter_animation/s2/animated_positioned_directional.dart';
import 'package:flutter_animation/s2/animated_switcher.dart';
import 'package:flutter_animation/s2/animated_text_style.dart';
import 'package:flutter_animation/s3/animated_builder.dart';
import 'package:flutter_animation/s3/animated_builder2.dart';
import 'package:flutter_animation/s3/default_text_style_transition.dart';
import 'package:flutter_animation/s3/fade_transition.dart';
import 'package:flutter_animation/s3/indexed_stack.dart';
import 'package:flutter_animation/s3/positioned_directional_transition.dart';
import 'package:flutter_animation/s3/positioned_transition.dart';
import 'package:flutter_animation/s3/rotation_transition.dart';
import 'package:flutter_animation/s3/size_transition.dart';
import 'package:flutter_animation/s3/tween_animation_builder.dart';
import 'package:flutter_animation/s4/page_fade_transition.dart';
import 'package:flutter_animation/s4/page_mix_scale_rotation_transition.dart';
import 'package:flutter_animation/s4/page_mix_size_fade_transition.dart';
import 'package:flutter_animation/s4/page_rotation_transition.dart';
import 'package:flutter_animation/s4/page_scale_transition.dart';
import 'package:flutter_animation/s4/page_size_transition.dart';
import 'package:flutter_animation/s4/page_slide_transition.dart';
import 'package:flutter_animation/s4/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animation Flutter"),),
      body: Center(
        child: ListView(
          children: [
            ExpansionTile(
              title: const Text("Tutorial", style: TextStyle(fontSize: 24.0),),
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const TweenScreen(),));
                    },
                    child: const Text("Lecture #0 TweenColor")
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                "Implicit Animation",
                style: TextStyle(fontSize: 24.0),
              ),
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedAlignScreen(),));
                    },
                    child: const Text("Lecture #1 Animated Align")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedContainerScreen(),));
                    },
                    child: const Text("Lecture #2 Animated Container")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedTextStyleScreen(),));
                    },
                    child: const Text("Lecture #3 Animated Text Style")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedOpacityScreen(),));
                    },
                    child: const Text("Lecture #4 Animated Opacity")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedPaddingScreen(),));
                    },
                    child: const Text("Lecture #5 Animated Padding")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedPhysicalModelScreen(),));
                    },
                    child: const Text("Lecture #6 Animated Physical Model")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedPositionedScreen(),));
                    },
                    child: const Text("Lecture #7 Animated Positioned")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedPositionedDirectionalScreen(),));
                    },
                    child: const Text("Lecture #8 Animated Positioned Directional")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedCrossFadeScreen(),));
                    },
                    child: const Text("Lecture #9 Animated Cross Fade")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedSwitcherScreen(),));
                    },
                    child: const Text("Lecture #10 Animated Switcher")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedListScreen(),));
                    },
                    child: const Text("Lecture #11 Animated List")
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                "Explicit Animation",
                style: TextStyle(fontSize: 24.0),
              ),
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const PositionedTransitionScreen(),));
                    },
                    child: const Text("Lecture #1 Positioned Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const SizeTransitionScreen(),));
                    },
                    child: const Text("Lecture #2 Size Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const RotationTransitionScreen(),));
                    },
                    child: const Text("Lecture #3 Rotation Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedBuilderScreen(),));
                    },
                    child: const Text("Lecture #3 Animated Builder")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AnimatedBuilder2Screen(),));
                    },
                    child: const Text("Lecture #3-1 Animated Builder2")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const FadeTransitionScreen(),));
                    },
                    child: const Text("Lecture #4 Fade Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const PositionedDirectionalTransitionScreen(),));
                    },
                    child: const Text("Lecture #5 Positioned Directional Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const TweenAnimationBuilderScreen(),));
                    },
                    child: const Text("Lecture #6 Tween Animation Builder")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const DefaultTextStyleTransitionScreen(),));
                    },
                    child: const Text("Lecture #7 Default Text Style Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const IndexedStackScreen(),));
                    },
                    child: const Text("Lecture #8 Indexed Stack")
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                "Page Transition",
                style: TextStyle(fontSize: 24.0),
              ),
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageFadeTransition(
                          const SecondPageScreen(),
                        )
                      );
                    },
                    child: const Text("Lecture #1 Fade Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageScaleTransition(
                          const SecondPageScreen(),
                        )
                      );
                    },
                    child: const Text("Lecture #2 Scale Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRotationTransition(
                          const SecondPageScreen(),
                        )
                      );
                    },
                    child: const Text("Lecture #3 Rotation Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageSlideTransition(
                          const SecondPageScreen(),
                        )
                      );
                    },
                    child: const Text("Lecture #4 Slide Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageSizeTransition(
                          const SecondPageScreen(),
                        )
                      );
                    },
                    child: const Text("Lecture #5 Size Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageMixSizeFadeTransition(
                          const SecondPageScreen(),
                        )
                      );
                    },
                    child: const Text("Lecture #6 Mix Size Fade Transition")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageMixScaleRotationTransition(
                          const SecondPageScreen(),
                        )
                      );
                    },
                    child: const Text("Lecture #7 Mix Scale Rotation Transition")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}