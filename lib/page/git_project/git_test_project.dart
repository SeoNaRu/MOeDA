import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../generated/assets.dart';

class AttendanceCheckScreen extends StatefulWidget {
  const AttendanceCheckScreen({super.key});

  @override
  State<AttendanceCheckScreen> createState() => _AttendanceCheckScreenState();
}

class _AttendanceCheckScreenState extends State<AttendanceCheckScreen> {
  final List<Map<String, dynamic>> commitData = [
    {"commit_day": "2024. 2. 20.", "commit_count": 1},
    {"commit_day": "2024. 2. 19.", "commit_count": 1},
    {"commit_day": "2024. 2. 18.", "commit_count": 1},
    {"commit_day": "2024. 2. 17.", "commit_count": 2},
    {"commit_day": "2024. 2. 16.", "commit_count": 3},
    {"commit_day": "2024. 2. 15.", "commit_count": 4},
    {"commit_day": "2024. 2. 14.", "commit_count": 5},
    {"commit_day": "2024. 2. 13.", "commit_count": 6},
    {"commit_day": "2024. 2. 12.", "commit_count": 1},
    {"commit_day": "2024. 2. 11.", "commit_count": 1},
    {"commit_day": "2024. 2. 10.", "commit_count": 1},
    {"commit_day": "2024. 2. 9.", "commit_count": 1},
    {"commit_day": "2024. 2. 8.", "commit_count": 1},
    {"commit_day": "2024. 2. 7.", "commit_count": 1},

  ];
  List<List<Map<String, dynamic>>> streaks = [];

  List<int> commit = [3, 7, 14, 21, 42, 66];
  List<int> point = [4, 8, 12, 16, 20, 36];

  final List<Map<String, int>> AdditionalCompensation = [
    {"day": 3 , "point": 4},
    {"day": 7 , "point": 8},
    {"day": 14 , "point": 12},
    {"day": 21 , "point": 16},
    {"day": 42 , "point": 20},
    {"day": 66 , "point": 36},
  ];

  List<int> beforeCommits = [2, 3, 5, 4, 2];
  // int toDayCommit = streaks[0]?.length;

  final ScrollController _scrollController = ScrollController();
  int currentScroll = 3;

  @override
  void initState() {
    super.initState();
    if (commitData.isNotEmpty) {
      streaks = calculateStreaks();
      WidgetsBinding.instance
          .addPostFrameCallback((_) => scrollToCurrentStreak());
    }
  }

  void scrollToCurrentStreak() {
    if (streaks.isNotEmpty && _scrollController.hasClients) {
      int indexToScroll = streaks[0].length - 1;
      double positionToScroll = indexToScroll * 70;
      _scrollController.animateTo(
        positionToScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  List<List<Map<String, dynamic>>> calculateStreaks() {
    if (commitData.isEmpty) {
      return [];
    }
    List<List<Map<String, dynamic>>> result = [];
    List<Map<String, dynamic>> currentStreak = [commitData[0]];

    for (int i = 1; i < commitData.length; i++) {
      DateTime currentDate = DateFormat("yyyy. M. d.").parse(commitData[i]['commit_day'].trim());
      DateTime previousDate = DateFormat("yyyy. M. d.").parse(commitData[i - 1]['commit_day'].trim());

      if (previousDate.difference(currentDate).inDays == 1) {
        currentStreak.add(commitData[i]);
      } else {
        result.add(currentStreak);
        currentStreak = [commitData[i]];
      }
    }

    if (currentStreak.isNotEmpty) {
      result.add(currentStreak);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF24252F),
        ),
        child:

        Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFF24252F),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x7F000000),
                    blurRadius: 20,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 27, right: 28, bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70,
                      height: 38,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1D1D27),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'START',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF5498FF),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.28,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 38,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1D1D27),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '추가 보상',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.28,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            commitData.isEmpty
                ? Container():
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  int currentStreakLength = streaks[0].length;
                  int startIndex = index + 1;
                  Map<String, int>? compensation = commit.contains(startIndex)
                      ? AdditionalCompensation.firstWhere(
                          (comp) => comp['day'] == startIndex, orElse: () => <String, int>{})
                      : null;
                  return Padding(
                    padding: const EdgeInsets.only(left: 42, right: 28),
                    child:

                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF24252F),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1.50,
                                          color: currentStreakLength > startIndex- 1
                                              ? const Color(0xFF5498FF)
                                              : Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$startIndex',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: currentStreakLength > startIndex - 1
                                            ? const Color(0xFF5498FF)
                                            : Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                ),
                                currentStreakLength  < startIndex
                                    ? const SizedBox(
                                        height: 24,
                                      )
                                    : Container(
                                        width: 2,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFF5498FF)),
                                      )
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 110,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1.50,
                                              color: currentStreakLength > startIndex - 1
                                                  ? const Color(0xFF5498FF)
                                                  : Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(10, 8, 17, 8),
                                        child: currentStreakLength > startIndex - 1
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SvgPicture.asset(
                                                      Assets.iconsBeforeSmile),
                                                  const Text(
                                                    '4 Point',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFF5498FF),
                                                      fontSize: 14,
                                                      fontFamily: 'Pretendard',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0,
                                                      letterSpacing: -0.28,
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SvgPicture.asset(
                                                      Assets.iconsSmile),
                                                  const Text(
                                                    '4 Point',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily: 'Pretendard',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0,
                                                      letterSpacing: -0.28,
                                                    ),
                                                  )
                                                ],
                                              ),
                                      ),
                                    ),
                                    commit.contains(startIndex)
                                        ?
                                    currentStreakLength > startIndex  - 1? SvgPicture.asset(Assets.iconsBluePlus):
                                    SvgPicture.asset(Assets.iconsPlus)
                                        : const SizedBox.shrink(),
                                    commit.contains(startIndex)
                                        ? Container(
                                      width: 110,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1.50,
                                              color: currentStreakLength > startIndex - 1
                                                  ? const Color(0xFF5498FF)
                                                  : Colors.white),
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(10, 8, 17, 8),
                                        child: currentStreakLength > startIndex - 1
                                            ? Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                                Assets.iconsBeforeSmile),
                                             Text(
                                              '${compensation?['point']} Point',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color(0xFF5498FF),
                                                fontSize: 14,
                                                fontFamily: 'Pretendard',
                                                fontWeight:
                                                FontWeight.w600,
                                                height: 0,
                                                letterSpacing: -0.28,
                                              ),
                                            )
                                          ],
                                        )
                                            : Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                                Assets.iconsSmile),
                                            const Text(
                                              '4 Point',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: 'Pretendard',
                                                fontWeight:
                                                FontWeight.w600,
                                                height: 0,
                                                letterSpacing: -0.28,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
