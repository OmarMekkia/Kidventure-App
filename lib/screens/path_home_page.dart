import 'package:flutter/material.dart';
import 'package:kidventure/constants/app_colors.dart';
import '../widgets/dashed_path_painter.dart';
import '../widgets/path_card.dart';
import 'mind_map_screen.dart';

class PathHomePage extends StatelessWidget {
  const PathHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final cardW = w * 0.5;
          final cardH = h * 0.15;
          final vSpacing = h * 0.25;

          const lockedTitles = [
            'Digestive System',
            'Respiratory System',
            'Cells',
            'Plants',
          ];

          final positions = List<Offset>.generate(5, (i) {
            final y = (h * 0.1) + i * vSpacing;
            final isLeft = i.isOdd;
            final x = isLeft ? (w - cardW) * 0.2 : (w - cardW) * 0.5;
            return Offset(x, y);
          });
          final centers =
              positions
                  .map((pos) => Offset(pos.dx + cardW / 2, pos.dy + cardH / 2))
                  .toList();
          final contentHeight = positions.last.dy + cardH + (h * 0.05);

          return Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  width: w,
                  height: contentHeight,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(w, contentHeight),
                        painter: DashedPathPainter(centers),
                      ),
                      for (int i = 0; i < positions.length; i++)
                        Positioned(
                          left: positions[i].dx,
                          top: positions[i].dy,
                          child: SizedBox(
                            width: cardW,
                            height: cardH,
                            child:
                                i == 0
                                    ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => const MindMapScreen(),
                                          ),
                                        );
                                      },
                                      child: PathCard(
                                        title: 'Body Parts',
                                        locked: false,
                                      ),
                                    )
                                    : PathCard(
                                      title: lockedTitles[i - 1],
                                      locked: true,
                                    ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
