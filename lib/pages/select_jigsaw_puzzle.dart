import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:culture_popularization_app/data/puzzle_id.dart';
import 'package:culture_popularization_app/data/puzzle_vm.dart';
import 'package:culture_popularization_app/pages/jigsaw_puzzle.dart';
import 'package:culture_popularization_app/route/routes.dart';

/// 选择拼图页面
class SelectJigsawPuzzle extends StatefulWidget {
  const SelectJigsawPuzzle({super.key});

  @override
  State<StatefulWidget> createState() => _SelectJigsawPuzzleState();
}

class _SelectJigsawPuzzleState extends State<SelectJigsawPuzzle> {
  PuzzleViewModel puzzleViewModel = PuzzleViewModel();
  List<Offset> flowerPositions = List.generate(4, (index) => Offset.zero);
  int? uId;

  @override
  void initState() {
    super.initState();
    puzzleViewModel.getPuzzle();
    _loadUserId().then((_) {
      _loadFlowerPositions();
    });
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getInt('uid_f');
  }

  Future<void> _loadFlowerPositions() async {
    if (uId == null) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < 4; i++) {
        double dx = prefs.getDouble('${uId}_flower_${i}_dx') ?? 0;
        double dy = prefs.getDouble('${uId}_flower_${i}_dy') ?? 0;
        flowerPositions[i] = Offset(dx, dy);
      }
    });
  }

  Future<void> _saveFlowerPositions() async {
    if (uId == null) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < 4; i++) {
      prefs.setDouble('${uId}_flower_${i}_dx', flowerPositions[i].dx);
      prefs.setDouble('${uId}_flower_${i}_dy', flowerPositions[i].dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final r = size.width / 370;
    return ChangeNotifierProvider<PuzzleViewModel>(
      create: (context) {
        return puzzleViewModel;
      },
      child: Scaffold(
        body: Consumer<PuzzleViewModel>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/背景.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/背景.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  _buildFlower(
                    context,
                    index: 0,
                    initialOffset: Offset(0.1 * size.width, 0.35 * size.height),
                    id: PuzzleId.puzzle1,
                    completed: value.puzzleList?[PuzzleId.puzzle1 - 1]?.completed ?? false,
                    name: value.puzzleList?[PuzzleId.puzzle1 - 1]?.name ?? '',
                  ),
                  _buildFlower(
                    context,
                    index: 1,
                    initialOffset: Offset(0.15 * size.width, 0.65 * size.height),
                    id: PuzzleId.puzzle2,
                    completed: value.puzzleList?[PuzzleId.puzzle2 - 1]?.completed ?? false,
                    name: value.puzzleList?[PuzzleId.puzzle2 - 1]?.name ?? '',
                  ),
                  _buildFlower(
                    context,
                    index: 2,
                    initialOffset: Offset(0.65 * size.width, 0.45 * size.height),
                    id: PuzzleId.puzzle3,
                    completed: value.puzzleList?[PuzzleId.puzzle3 - 1]?.completed ?? false,
                    name: value.puzzleList?[PuzzleId.puzzle3 - 1]?.name ?? '',
                  ),
                  _buildFlower(
                    context,
                    index: 3,
                    initialOffset: Offset(0.67 * size.width, 0.75 * size.height),
                    id: PuzzleId.puzzle4,
                    completed: value.puzzleList?[PuzzleId.puzzle4 - 1]?.completed ?? false,
                    name: value.puzzleList?[PuzzleId.puzzle4 - 1]?.name ?? '',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFlower(BuildContext context, {
    required int index,
    required Offset initialOffset,
    required int id,
    required bool completed,
    required String name,
  }) {
    final size = MediaQuery.of(context).size;
    final r = size.width / 370;
    Offset offset = flowerPositions[index] == Offset.zero ? initialOffset : flowerPositions[index];
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Draggable(
        data: index,
        feedback: Opacity(
          opacity: 0.8,
          child: Stack(
            children: [
              Image.asset(
                completed
                    ? 'assets/images/花开${id > 2 ? 1 : 2}.png'
                    : 'assets/images/花闭${id > 2 ? 2 : 1}.png',
                width: 0.3 * size.width,
                height: 0.3 * size.width,
                fit: BoxFit.contain,
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 8,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 13 * r),
                  ),
                ),
              ),
            ],
          ),
        ),
        childWhenDragging: Container(),
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          setState(() {
            flowerPositions[index] = offset;
            _saveFlowerPositions();
          });
        },
        child: GestureDetector(
          onTap: () {
            Routes.push(context, JigsawPuzzle(id: id));
          },
          child: Stack(
            children: [
              Image.asset(
                completed
                    ? 'assets/images/花开${id > 2 ? 1 : 2}.png'
                    : 'assets/images/花闭${id > 2 ? 2 : 1}.png',
                width: 0.3 * size.width,
                height: 0.3 * size.width,
                fit: BoxFit.contain,
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 8,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 13 * r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}