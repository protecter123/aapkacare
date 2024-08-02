import 'package:aapkacare/screens/Drawer/drawer.dart';
import 'package:aapkacare/screens/appointment/doctorappointment.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final Map<String, dynamic> Data;

  const Calendar({super.key, required this.Data});
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  // ignore: unused_field
  DateTime? _previousSelectedDay;

  @override
  void initState() {
    super.initState();
    print('...............${widget.Data}');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(s.width < 1024 ? 60.0 : 110.0), child: const NavBarBooking()),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Book Your Appointment',
                style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(s.width < 720 ? 0.0 : 10.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x12000000),
                      offset: Offset(0, 7),
                      blurRadius: 24,
                    ),
                  ],
                  border: s.width < 720 ? null : Border.all(),
                ),
                child: Column(
                  children: [
                    // Custom Header
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.8),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(s.width < 720 ? 0.0 : 10)),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.chevron_left, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    // Check if the current month is the same as the focused month
                                    if (_focusedDay.month > DateTime.now().month || _focusedDay.year > DateTime.now().year) {
                                      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
                                    }
                                  });
                                },
                              ),
                              Text(
                                DateFormat('MMMM yyyy').format(_focusedDay), // Format the date
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.chevron_right, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(7, (index) {
                                return Text(
                                  [
                                    'Mon',
                                    'Tue',
                                    'Wed',
                                    'Thu',
                                    'Fri',
                                    'Sat',
                                    'Sun'
                                  ][index],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // TableCalendar
                    Padding(
                      padding: EdgeInsets.only(top: 10.0), // Adjust padding to fit the custom header
                      child: TableCalendar(
                        firstDay: DateTime.utc(2023, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (selectedDay.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
                            setState(() {
                              _showAlert(context, Data: widget.Data, date: '${selectedDay.day}/${selectedDay.month}/${selectedDay.year}');
                              _previousSelectedDay = _selectedDay;
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          }
                        },

                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay;
                          });
                        },
                        calendarStyle: CalendarStyle(
                          markersMaxCount: 20,
                          outsideTextStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                          todayTextStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: const Color(0xff000000),
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.transparent, // Set to transparent to hide default labels
                          ),
                          weekendStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.transparent, // Set to transparent to hide default labels
                          ),
                        ),
                        headerVisible: false, // Hide the default header
                        calendarBuilders: CalendarBuilders(
                          selectedBuilder: (context, date, events) => Container(
                            margin: const EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 18.0,
                              child: Text(
                                date.day.toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          todayBuilder: (context, date, events) => Container(
                            margin: const EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.blue, width: 2)),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18.0,
                              child: Text(
                                date.day.toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlert(BuildContext context, {required String date, required Map<String, dynamic> Data}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: InputBorder.none,
            content: Container(
              height: 600,
              width: 500,
              child: DoctorAppointmentScreen(Data: Data, dateTime: date),
            ));
      },
    );
  }
}















// import 'package:aapkacare/screens/appointment/doctorappointment.dart';
// import 'package:aapkacare/values/screen.dart';
// import 'package:aapkacare/widgets/navbarBooking.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';

// class Calendar extends StatefulWidget {
//   final Map<String, dynamic> Data;

//   const Calendar({super.key, required this.Data});
//   @override
//   _CalendarState createState() => _CalendarState();
// }

// class _CalendarState extends State<Calendar> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   // ignore: unused_field
//   DateTime? _previousSelectedDay;
//   bool _showCard = false;

//   @override
//   Widget build(BuildContext context) {
//     Screen s = Screen(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(s.width < 1024 ? 65.0 : 110.0),
//         child: NavBarBooking(),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 'Book Your Appointment',
//                 style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 30),
//                 width: 500,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(s.width < 720 ? 0.0 : 10.0),
//                   color: const Color(0xffffffff),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0x12000000),
//                       offset: Offset(0, 7),
//                       blurRadius: 24,
//                     ),
//                   ],
//                   border: s.width < 720 ? null : Border.all(),
//                 ),
//                 child: Column(
//                   children: [
//                     // Custom Header
//                     Container(
//                       height: 90,
//                       decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.8),
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(s.width < 720 ? 0.0 : 10)),
//                       ),
//                       alignment: Alignment.center,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.chevron_left, color: Colors.white),
//                                 onPressed: () {
//                                   setState(() {
//                                     // Check if the current month is the same as the focused month
//                                     if (_focusedDay.month > DateTime.now().month || _focusedDay.year > DateTime.now().year) {
//                                       _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
//                                     }
//                                   });
//                                 },
//                               ),
//                               Text(
//                                 DateFormat('MMMM yyyy').format(_focusedDay), // Format the date
//                                 style: GoogleFonts.montserrat(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.chevron_right, color: Colors.white),
//                                 onPressed: () {
//                                   setState(() {
//                                     _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 5),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: List.generate(7, (index) {
//                                 return Text(
//                                   [
//                                     'Mon',
//                                     'Tue',
//                                     'Wed',
//                                     'Thu',
//                                     'Fri',
//                                     'Sat',
//                                     'Sun'
//                                   ][index],
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 );
//                               }),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // TableCalendar
//                     Padding(
//                       padding: EdgeInsets.only(top: 10.0), // Adjust padding to fit the custom header
//                       child: TableCalendar(
//                         firstDay: DateTime.utc(2023, 10, 16),
//                         lastDay: DateTime.utc(2030, 3, 14),
//                         focusedDay: _focusedDay,
//                         calendarFormat: _calendarFormat,
//                         selectedDayPredicate: (day) {
//                           return isSameDay(_selectedDay, day);
//                         },
//                         onDaySelected: (selectedDay, focusedDay) {
//                           if (selectedDay.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
//                             setState(() {
//                               if (_selectedDay == selectedDay) {
//                                 // Toggle card visibility if the same date is selected
//                                 _showCard = !_showCard;
//                               } else {
//                                 // Show card for new date selection
//                                 _showCard = true;
//                               }
//                               // Update selected day
//                               _previousSelectedDay = _selectedDay;
//                               _selectedDay = selectedDay;
//                               _focusedDay = focusedDay;
//                             });
//                           }
//                         },

//                         onFormatChanged: (format) {
//                           if (_calendarFormat != format) {
//                             setState(() {
//                               _calendarFormat = format;
//                             });
//                           }
//                         },
//                         onPageChanged: (focusedDay) {
//                           setState(() {
//                             _focusedDay = focusedDay;
//                           });
//                         },
//                         calendarStyle: CalendarStyle(
//                           markersMaxCount: 20,
//                           outsideTextStyle: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                           todayTextStyle: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: const Color(0xff000000),
//                           ),
//                         ),
//                         daysOfWeekStyle: DaysOfWeekStyle(
//                           weekdayStyle: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: Colors.transparent, // Set to transparent to hide default labels
//                           ),
//                           weekendStyle: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: Colors.transparent, // Set to transparent to hide default labels
//                           ),
//                         ),
//                         headerVisible: false, // Hide the default header
//                         calendarBuilders: CalendarBuilders(
//                           selectedBuilder: (context, date, events) => Container(
//                             margin: const EdgeInsets.all(5.0),
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(shape: BoxShape.circle),
//                             child: CircleAvatar(
//                               backgroundColor: Colors.blue,
//                               radius: 18.0,
//                               child: Text(
//                                 date.day.toString(),
//                                 style: GoogleFonts.poppins(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           todayBuilder: (context, date, events) => Container(
//                             margin: const EdgeInsets.all(5.0),
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.blue, width: 2)),
//                             child: CircleAvatar(
//                               backgroundColor: Colors.white,
//                               radius: 18.0,
//                               child: Text(
//                                 date.day.toString(),
//                                 style: GoogleFonts.poppins(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Conditional Card
//                     // Conditional Card
//                     if (_showCard)
//                       Container(
//                         margin: EdgeInsets.only(top: 20),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.blue[50],
//                           borderRadius: BorderRadius.circular(s.width < 720 ? 0.0 : 10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             children: [
//                               Text(
//                                 'Selected Date: ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               // Time slots list
//                               Column(
//                                 children: List.generate(10, (index) {
//                                   int hour = 9 + index; // Starting from 9:30 am
//                                   String startHour = hour == 12 ? '12' : (hour % 12).toString();
//                                   String endHour = ((hour + 1) % 12).toString();
//                                   String period = hour < 12 ? 'am' : 'pm';
//                                   DateTime now = DateTime.now();
//                                   DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);

//                                   // Combine selected date with the slot time
//                                   DateTime slotStartTime = DateTime(
//                                     _selectedDay!.year,
//                                     _selectedDay!.month,
//                                     _selectedDay!.day,
//                                     hour,
//                                     30,
//                                   );

//                                   // Check if the slot is in the past
//                                   bool isSlotInThePast = slotStartTime.isBefore(currentTime);

//                                   return Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.access_time_filled,
//                                                 size: s.width < 720 ? 16 : 20,
//                                               ),
//                                               SizedBox(width: 5),
//                                               Text(
//                                                 '${startHour.padLeft(2, '0')}:30 $period - ${endHour.padLeft(2, '0')}:30 $period',
//                                                 style: GoogleFonts.poppins(fontSize: s.width < 720 ? 12.0 : 16, fontWeight: FontWeight.w500),
//                                               ),
//                                             ],
//                                           ),
//                                           if (!isSlotInThePast)
//                                             InkWell(
//                                               onTap: () {
//                                                 Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorAppointmentScreen(Data: widget.Data, dateTime: '${startHour.padLeft(2, '0')}:30 $period - ${endHour.padLeft(2, '0')}:30 $period      ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}')));
//                                               },
//                                               // onTap: () => _showAlert(context, date: '${startHour.padLeft(2, '0')}:30 $period - ${endHour.padLeft(2, '0')}:30 $period      ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}'),
//                                               child: Container(
//                                                 decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
//                                                 padding: EdgeInsets.all(8),
//                                                 child: Text(
//                                                   'Book Appointment',
//                                                   style: GoogleFonts.lato(color: Colors.white, fontSize: s.width < 720 ? 12.0 : 14, fontWeight: FontWeight.w500),
//                                                 ),
//                                               ),
//                                             ),
//                                           if (isSlotInThePast)
//                                             Container(
//                                               padding: EdgeInsets.all(8),
//                                               // decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
//                                               child: Text(
//                                                 'Unavailable',
//                                                 style: GoogleFonts.lato(color: Colors.red, fontSize: s.width < 720 ? 12.0 : 14, fontWeight: FontWeight.w500),
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 10),
//                                     ],
//                                   );
//                                 }),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // void _showAlert(BuildContext context, {required String date}) {
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         contentPadding: EdgeInsets.zero,
//   //         shape: InputBorder.none,
//   //         content: Container(
//   //           height: MediaQuery.of(context).size.height / 1.2,
//   //           width: 500,
//   //           decoration: BoxDecoration(
//   //             borderRadius: BorderRadius.zero,
//   //           ),
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Container(
//   //                 padding: EdgeInsets.all(10),
//   //                 decoration: BoxDecoration(color: Colors.blue, border: Border.all(color: Colors.grey.shade300, width: .5)),
//   //                 child: Row(
//   //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                   children: [
//   //                     Text(
//   //                       "REQUEST AN APPOINTMENT",
//   //                       style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
//   //                     ),
//   //                     IconButton(
//   //                         onPressed: () {
//   //                           Navigator.pop(context);
//   //                         },
//   //                         icon: Icon(
//   //                           Icons.cancel,
//   //                           color: Colors.white,
//   //                         )),
//   //                   ],
//   //                 ),
//   //               ),
//   //               Expanded(
//   //                 child: SingleChildScrollView(
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       SizedBox(height: 10),
//   //                       Text(
//   //                         "Please confirm that you would like to request the following appointment:",
//   //                         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//   //                       ),
//   //                       SizedBox(height: 10),
//   //                       Container(
//   //                         padding: EdgeInsets.all(10),
//   //                         decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300, width: .5)),
//   //                         child: Row(
//   //                           children: [
//   //                             Icon(Icons.calendar_month),
//   //                             SizedBox(width: 8),
//   //                             Text(
//   //                               date,
//   //                               style: GoogleFonts.poppins(fontSize: 15),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       ),
//   //                       SizedBox(height: 10),
//   //                       Text(
//   //                         "Registration:",
//   //                         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
//   //                       ),
//   //                       SizedBox(height: 10),
//   //                       Text(
//   //                         "Please enter your name, your email address and choose a password to get started.",
//   //                         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//   //                       ),
//   //                       SizedBox(height: 10),
//   //                       _buildSearchInput('Enter Name'),
//   //                       SizedBox(height: 10),
//   //                       _buildSearchInput('Email'),
//   //                       SizedBox(height: 10),
//   //                       _buildSearchInput('Password'),
//   //                       SizedBox(height: 10),
//   //                       Text(
//   //                         "Phone Number:",
//   //                         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
//   //                       ),
//   //                       SizedBox(height: 10),
//   //                       _buildSearchInput('Number'),
//   //                       SizedBox(height: 10),
//   //                       Text(
//   //                         "Message ",
//   //                         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
//   //                       ),
//   //                       SizedBox(height: 10),
//   //                       TextField(
//   //                         maxLines: 4,
//   //                         cursorColor: Colors.black,
//   //                         decoration: InputDecoration(
//   //                           filled: true,
//   //                           fillColor: Colors.white,
//   //                           enabledBorder: OutlineInputBorder(
//   //                             borderSide: BorderSide(
//   //                               color: Colors.grey.shade600,
//   //                               width: 0.4,
//   //                             ),
//   //                             borderRadius: BorderRadius.circular(2),
//   //                           ),
//   //                           focusedBorder: OutlineInputBorder(
//   //                             borderSide: BorderSide(
//   //                               color: Colors.black,
//   //                               width: 1.2,
//   //                             ),
//   //                             borderRadius: BorderRadius.circular(2),
//   //                           ),
//   //                           labelText: '',
//   //                           contentPadding: EdgeInsets.all(12),
//   //                         ),
//   //                       ),
//   //                       SizedBox(height: 10),
//   //                       Row(
//   //                         children: [
//   //                           InkWell(
//   //                             onTap: () {},
//   //                             child: Container(
//   //                               padding: EdgeInsets.all(10),
//   //                               decoration: BoxDecoration(
//   //                                 color: Colors.blue,
//   //                                 border: Border.all(color: Colors.grey.shade300, width: .5),
//   //                                 borderRadius: BorderRadius.circular(5),
//   //                               ),
//   //                               child: Text(
//   //                                 "Request Appointment",
//   //                                 style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
//   //                               ),
//   //                             ),
//   //                           ),
//   //                           SizedBox(
//   //                             width: 10,
//   //                           ),
//   //                           InkWell(
//   //                             onTap: () {
//   //                               Navigator.pop(context);
//   //                             },
//   //                             child: Container(
//   //                               padding: EdgeInsets.all(10),
//   //                               decoration: BoxDecoration(
//   //                                 color: Colors.white,
//   //                                 border: Border.all(color: Colors.black45),
//   //                                 borderRadius: BorderRadius.circular(5),
//   //                               ),
//   //                               child: Text(
//   //                                 "Cancel",
//   //                                 style: GoogleFonts.poppins(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
//   //                               ),
//   //                             ),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                       SizedBox(height: 10),
//   //                     ],
//   //                   ).px12(),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   // Widget _buildSearchInput(String hintText) {
//   //   return Container(
//   //     decoration: BoxDecoration(
//   //       color: Colors.white,
//   //       borderRadius: BorderRadius.circular(2),
//   //       border: Border.all(color: Colors.grey.shade600, width: .4),
//   //     ),
//   //     child: Padding(
//   //       padding: EdgeInsets.only(left: 10),
//   //       child: TextField(
//   //         cursorColor: Colors.black,
//   //         showCursor: true,
//   //         decoration: InputDecoration.collapsed(
//   //           fillColor: Colors.black,
//   //           focusColor: Colors.black,
//   //           hintText: hintText,
//   //           hintStyle: GoogleFonts.poppins(
//   //             color: Colors.black45,
//   //             fontWeight: FontWeight.w400,
//   //             fontSize: 15.0,
//   //             height: 3,
//   //           ),
//   //         ),
//   //         style: GoogleFonts.poppins(
//   //           color: Colors.black,
//   //           fontSize: 16.0,
//   //           fontWeight: FontWeight.w600,
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
