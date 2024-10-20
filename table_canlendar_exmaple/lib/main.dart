import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalenderScreen(),
    );
  }
}

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});
  @override
  State createState() => _CalendarState();
}

class _CalendarState extends State<CalenderScreen> {
  final cf = CalendarFormat.month;

  late DateTime _focusedDay;
  DateTime? _selectedDay;
  String _calendarTitle = "";

  DateTime _firstDate = DateTime.now().subtract(const Duration(days: 0));
  DateTime _lastDate = DateTime.now().add(const Duration(days: 2));
  DateTime calendarDate = DateTime.now();

  late PageController _pageController;

  @override

  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
  }

  Widget build(BuildContext context) {
    print(DateTime.april);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.maxFinite,
        height: 402,
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFF4F4F4)
          )
        ),
        child: Column(
          children: [
            TableCalendar(
              // 제스쳐 설정
              availableGestures: AvailableGestures.none,
              // Header - 좌/우 이동 아이콘, Title, 포맷 변경 버튼
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronVisible: false,
                rightChevronVisible: false,
              ),

              // 달력 전체적인 스타일링
              calendarStyle: CalendarStyle(
                isTodayHighlighted: false,
                selectedTextStyle: const TextStyle(color: Colors.black),
                selectedDecoration: ShapeDecoration(
                  color: const Color(0xFFFF7B1C).withOpacity(0.25),
                  shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))
                )),
                cellPadding: EdgeInsets.all(9),
                // cellMargin: EdgeInsets.zero
              ),
              onCalendarCreated: (pageController) {
                _pageController = pageController;
              },
              firstDay: _firstDate,
              lastDay: DateTime.now().add(const Duration(days: 12)), //_lastDate,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                if (_selectedDay == null) return false;
                // return ture 하는 day를 선택 표시
                return isSameDay(_selectedDay, day) &&
                    isSameMonth(_selectedDay!, calendarDate) &&
                    (_selectedDay!.compareTo(_lastDate) < 0) &&
                    (_selectedDay!.compareTo(_firstDate.subtract(const Duration(days: 1))) > 0);
              },
              onDaySelected: (selectedDay, focusedDay) {
                print("selectedDay, focusedDay :: $selectedDay, $_focusedDay");
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) => print(format),
              onPageChanged: (date) {
                print("onPageChanged $date");
                _focusedDay = date;
                setState(() {
                  calendarDate = date;
                });
              },
              pageAnimationDuration: Duration.zero,
              calendarBuilders: CalendarBuilders(
                headerTitleBuilder: (context, day) {
                  print("headerTitleBuilder: $day");
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 24,
                      left: 24,
                      bottom: 12
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(calendarTitle(day)),
                        Expanded(child: Container()),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => _pageController.previousPage(duration: const Duration(milliseconds: 1), curve: Curves.ease), icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFA5A5A5), size: 16,),),
                        const SizedBox(width: 43,),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => _pageController.nextPage(duration: const Duration(milliseconds: 1), curve: Curves.ease), icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFFA5A5A5), size: 16,),),
                      ],
                    ),
                  );
                },
                // 해당 월 이외의 날짜들
                outsideBuilder: (context, day, focusedDay) {
                  return Container();
                },
                // first, last 범위 외의 날짜들
                disabledBuilder: (context, day, focusedDay) {
                  if (isSameMonth(calendarDate, day)) {
                    return null;
                  }
                  return Container();
                },
                dowBuilder: (context, day) => Center(
                  child: Text(
                    dayOfWeek(day.weekday),
                    style: const TextStyle(
                      color: Color(0xFFCCCFD3),
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String calendarTitle(DateTime date) => "${date.year}년 ${date.month}월";

  String dayOfWeek(int weekday) => (weekday == 0)
      ? "S"
      : (weekday == 1)
      ? "M"
      : (weekday == 2)
      ? "T"
      : (weekday == 3)
      ? "W"
      : (weekday == 4)
      ? "T"
      : (weekday == 5)
      ? "F"
      : "S";

  bool isSameMonth(DateTime date1, DateTime date2) =>
     date1.month == date2.month;
}