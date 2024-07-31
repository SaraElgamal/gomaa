import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gomaa/core/colors/colors.dart';
import 'package:gomaa/core/constant/const/const.dart';
import 'package:gomaa/core/styles/styles.dart';
import 'package:gomaa/core/utils/toast.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/states.dart';
import 'package:gomaa/features/login/admin/admin_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant/components/components.dart';
import '../../../core/location_handler/location_handler.dart';
import 'home_employee.dart';

class DetailedScreen extends StatefulWidget {
  bool admin ;
  int index ;
  int id ;
   DetailedScreen( {required this.admin,required this.index, required this.id});

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  String? _currentAddress;
  String? address;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      // Handle case when permission is not granted
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission is required to access the current location')),
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng(_currentPosition!);
    } catch (e) {
      // Handle errors when getting the current position
      print('Error getting current position: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get the current location')),
      );
    }
  }

  List<File> _selectedImages = [];
  TextEditingController _imageController2 = TextEditingController();




  Future<void> _pickImage() async {
    final pickedFile;

    pickedFile = await ImagePicker.platform.getImageFromSource(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
        _imageController2.text = pickedFile.name;
      });
    }
  }


  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.name}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.country}';

      });
      print(_currentAddress.toString());
      showToast(text: _currentAddress.toString(), state: ToastStates.success);
      if(_currentAddress != null) {
        Navigator.pop(context);

        showDialog(context: context, builder: (context)
        => Dialog(
          child:   Container(
            height: 350.h,
            width: 366.w,
            child: Column(

              children: [
                SizedBox(height: 30.h,),
                Lottie.asset('assets/animation/Animation - 1706443737173.json'),
                SizedBox(height: 20.h,),
                OutlinedButton(
                    onPressed: ()
                {
                  TasksCubit.get(context)
                      .updateTasksForOneUser(
                      full_address: _currentAddress.toString(),
                      idTask:
                  TasksCubit.get(context).tasksForUser![widget.index].id.toString() , status: 2


                  );
                  TasksCubit.get(context).uploadTaskImages
                    (
                      taskId: TasksCubit.get(context).tasksForUser![widget.index].id!.toInt() ,

                       imageFiles:  _selectedImages
                  );

                  print(TasksCubit.get(context).tasksForUser![widget.index].id.toString());

                  navigateFinish(context, TasksScreen());
                },

                    child:  Text('تم بنجاح ! الذهاب للرئيسية',
                      style: GoogleFonts.cairo(color: Colors.black,
                      ),) ),
              ],
            ),
          ),
        ));
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  // widget.admin ?   getPlace(lat: TasksCubit.get(context).adminTaskForOneUser![widget.index].latitude.toString(),long: TasksCubit.get(context).adminTaskForOneUser![widget.index].longitude.toString()) :
  //   getPlace(lat: TasksCubit.get(context).tasksForUser![widget.index].latitude.toString(),long: TasksCubit.get(context).tasksForUser![widget.index].longitude.toString());
   // TasksCubit.get(context).getAdminUsersTasks(id: widget.id.toString());
  }
  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);

    return BlocConsumer<TasksCubit,TasksStates>(
      listener: (context, state) {

      },
      builder: (context, state) =>  Scaffold(
        appBar: appBarDefaultTheme(
            context: context, isReverse: true, title: 'كافة التفاصيل'),

        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child:   SingleChildScrollView(
            child: Column(

              children: [
                SizedBox(height : 20.h),
                Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.person,color: primaryColorText,),
                            SizedBox(width : 10.w),
                            Text('اسم الموظف :-', style: Styles.style14Bold,)
                          ],
                        ),
                        SizedBox(height : 10.h),
                        Text(widget.admin ? cubit.users![widget.id].name.toString() : cubit.tasksForUser![widget.index].salse!.name.toString(), style: Styles.style14whiteSemiBold,)

                      ],
                    ),
                    Lottie.asset('assets/animation/Animation - 1713441740534.json',height: 100.h, width: 100.w),


                  ],
                ),
                    Divider(),


                    SizedBox(height : 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.drive_file_rename_outline,color: primaryColorText,),
                    SizedBox(width : 10.w),
                    Text('اسم المهمة : ', style: Styles.style14Bold,),
                    Text(widget.admin ? cubit.adminTaskForOneUser![widget.index].task_name!.toString() : cubit.tasksForUser![widget.index].task_name!.toString(), style: Styles.style14whiteSemiBold,)


                  ],
                ),
                SizedBox(height : 8.h),
                Divider(),
                SizedBox(height : 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.place,color: primaryColorText,),
                    SizedBox(width : 10.w),
                    Text('المكان : ', style: Styles.style14Bold,),
                    Flexible(child: Text(widget.admin ? cubit.adminTaskForOneUser![widget.index].full_address!.toString()  : cubit.tasksForUser![widget.index].full_address!.toString(), style: Styles.style14whiteSemiBold,maxLines: 2,overflow: TextOverflow.ellipsis,))

                  ],
                ),
                SizedBox(height : 8.h),
                Divider(),
                SizedBox(height : 10.h),
                (widget.admin && cubit.adminTaskForOneUser![widget.index].url
                    == null) || (!widget.admin && cubit.tasksForUser![widget.index].url
                    == null ) ? Container() :  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.streetview,color: primaryColorText,),
                    SizedBox(width : 10.w),
                    Text('العنوان : ', style: Styles.style14Bold,),
                    Flexible(child:
                    InkWell(
                        onTap: ()
                        {
                          final Uri url =  widget.admin  ?
                          Uri.parse(cubit.adminTaskForOneUser![widget.index].url!.toString())
                              :      Uri.parse(cubit.tasksForUser![widget.index].url!.toString());

                         launchUrl(url);


                        },
                        child: Text(widget.admin ? cubit.adminTaskForOneUser![widget.index].url!.toString()  : cubit.tasksForUser![widget.index].url!.toString(), style: Styles.style14whiteSemiBold,maxLines: 3,overflow: TextOverflow.ellipsis,)))

                  ],
                ) ,
                SizedBox(height : 8.h),
                (widget.admin && cubit.adminTaskForOneUser![widget.index].url
                    == null) || (!widget.admin && cubit.tasksForUser![widget.index].url
                    == null ) ? Container() :  Divider(),
                SizedBox(height : 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.phone,color: primaryColorText,),
                    SizedBox(width : 10.w),
                    Text('رقم موبايل العميل  : ', style: Styles.style14Bold,),
                    (widget.admin && cubit.adminTaskForOneUser![widget.index].client_phone
                        == null) || (!widget.admin && cubit.tasksForUser![widget.index].client_phone
                        == null ) ?

                    Text('لا يوجد', style: Styles.style14whiteSemiBold,) :

                    Text(widget.admin ?
                    cubit.adminTaskForOneUser![widget.index].client_phone!.toString()
                        :  cubit.tasksForUser![widget.index].client_phone!.toString(),
                      style: Styles.style14whiteSemiBold,),



                  ],
                ),
                SizedBox(height : 8.h),
                Divider(),

                SizedBox(height : 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.hourglass_top,color: primaryColorText,),
                    SizedBox(width : 10.w),
                    Text('تاريخ انتهاء المهمة  : ', style: Styles.style14Bold,),
                    (widget.admin && cubit.adminTaskForOneUser![widget.index].deadline
                        == null) || (!widget.admin && cubit.tasksForUser![widget.index].deadline
                        == null ) ?

                    Text('لا يوجد', style: Styles.style14whiteSemiBold,) :

                    Text(widget.admin ?
                    cubit.adminTaskForOneUser![widget.index].deadline!.toString()
                        :  cubit.tasksForUser![widget.index].deadline!.toString(),
                      style: Styles.style14whiteSemiBold,),



                  ],
                ),
                SizedBox(height : 8.h),
                Divider(),
                SizedBox(height : 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.details,color: primaryColorText,),
                    SizedBox(width : 10.w),
                    Text('تفاصيل  : ', style: Styles.style14Bold,),
                    Text(widget.admin ? cubit.adminTaskForOneUser![widget.index].description!.toString()  :  cubit.tasksForUser![widget.index].description!.toString(), style: Styles.style14whiteSemiBold,)

                  ],
                ),
                SizedBox(height : 80.h),
             widget.admin  || cubit.tasksForUser![widget.index].status!.toString() == 0  || cubit.tasksForUser![widget.index].status!.toString() == "0"  ? Container() :   defaultButton(context: context,
                    text: 'اتمام المهمة', width: 300.w, height: 45.h,
                    textSize: 14.sp, toPage: ()
                    {

                      showDialog(context: context, builder: (context)
                      => Dialog(
                        child: Container(
height: _selectedImages.isEmpty ? 220.h : 800.h,
                          width: 366.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 40.h,),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                                child: Center(child: Text('قم برفع صورة',style: Styles.style16SemiBold,)),
                              ),
                              SizedBox(height: 30.h,),
                              IconButton(onPressed: ()
                        {
                          _pickImage().then((value){
                           Navigator.pop(context);
                           showDialog(context: context, builder: (context)
                           => Dialog(
                             child: Container(
                               height:  800.h,
                               width: 366.w,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   SizedBox(height: 40.h,),
                                   Padding(
                                     padding:  EdgeInsets.symmetric(horizontal: 30.w),
                                     child: Center(child: Text('قم برفع صورة',style: Styles.style16SemiBold,)),
                                   ),
                                   SizedBox(height: 30.h,),
                                   IconButton(onPressed: ()
                                   {
                                    // selectImages();
                                     _pickImage();
                                   }, icon: Icon(Icons.file_upload_outlined,color: primaryColor,)) ,

                                   // selectedImage1   != null ?  Padding(
                                   //   padding: const EdgeInsets.all(10.0),
                                   //   child: Text( selectedImage1!.path.toString()  ,style: Styles.style14whiteSemiBold,maxLines: 3,overflow: TextOverflow.ellipsis,),
                                   // ) : Container(),
                                   _selectedImages.isNotEmpty
                                       ? Expanded(
                                     child: GridView.builder(
                                       padding: EdgeInsets.all(10.h),
                                       gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                                         crossAxisCount: 2, // Number of columns
                                         crossAxisSpacing: 4.0, // Horizontal spacing between grid items
                                         mainAxisSpacing: 3.0, // Vertical spacing between grid items
                                       ),
                                       itemCount: _selectedImages.length,
                                       itemBuilder: (context, index) {
                                         return Column(
                                           children: [
                                             Expanded(
                                               child: Image.file(
                                                 _selectedImages[index],
                                                 fit: BoxFit.cover,
                                                 width: double.infinity,
                                               ),
                                             ),
                                           ],
                                         );
                                       },
                                     ),
                                   )
                                       : Container(),
                                   SizedBox(height: 50.h,),
                                   _selectedImages.isNotEmpty ?  Padding(
                                     padding:  EdgeInsets.symmetric(horizontal: 14.0.w,vertical: 10.h),
                                     child: ElevatedButton(onPressed: () async
                                     {

                                       showDialog(context: context, builder: (context)
                                       => Dialog(
                                         child: Container(
                                           height: 230.h,
                                           width: 366.w,
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [
                                               SizedBox(height: 40.h,),
                                               Padding(
                                                 padding:  EdgeInsets.symmetric(horizontal: 30.w),
                                                 child: Center(child: Text('لتأكيد إتمام المهمة اضغط للتعرف على موقعك الحالي',style: Styles.style16SemiBold,)),
                                               ),
                                               SizedBox(height: 30.h,),

                                               Padding(
                                                 padding:  EdgeInsets.symmetric(horizontal: 14.0.w),
                                                 child: ElevatedButton(onPressed: () async
                                                 {
                                                   await _getCurrentPosition();
                                                   log('abdo');
                                                   if (_currentPosition != null) {
                                                     log('sara');
                                                     log(_currentPosition.toString());

                                                     _getAddressFromLatLng(_currentPosition!); // Get the address for the current position
                                                   } else {
                                                     // Handle case when current position is null
                                                     ScaffoldMessenger.of(context).showSnackBar(
                                                       const SnackBar(content: Text('Failed to get current location')),
                                                     );
                                                   }

                                                 },
                                                     style: OutlinedButton.styleFrom(
                                                       backgroundColor: Colors.green,
                                                       minimumSize: Size(180.w, 50.h),
                                                       maximumSize: Size(180.w, 50.h),
                                                       fixedSize: Size(180.w, 50.h),

                                                     ),
                                                     child: Text('معرفة موقعي الحالي',
                                                       style: GoogleFonts.cairo(color: Colors.white,
                                                       ),)),
                                               ),

                                             ],
                                           ),
                                         ),
                                       ),);
                                     },
                                         style: OutlinedButton.styleFrom(
                                           backgroundColor: Colors.green,
                                           minimumSize: Size(180.w, 50.h),
                                           maximumSize: Size(180.w, 50.h),
                                           fixedSize: Size(180.w, 50.h),

                                         ),
                                         child: Text('تم',
                                           style: GoogleFonts.cairo(color: Colors.white,
                                           ),)),
                                   ) : Container(),

                                 ],
                               ),
                             ),
                           ),);
                          });
                        }, icon: Icon(Icons.file_upload_outlined,color: primaryColor,)) ,
                            // _selectedImages   != null ?  Padding(
                            //     padding: const EdgeInsets.all(10.0),
                            //     child: Text( selectedImage1!.path.toString()  ,style: Styles.style14whiteSemiBold,maxLines: 3,overflow: TextOverflow.ellipsis,),
                            //   ) : Container(),
                              _selectedImages.isNotEmpty
                                  ? Expanded(
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // Number of columns
                                    crossAxisSpacing: 4.0, // Horizontal spacing between grid items
                                    mainAxisSpacing: 4.0, // Vertical spacing between grid items
                                  ),
                                  itemCount: _selectedImages.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: Image.file(
                                            _selectedImages[index],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                                  : Container(),
                              SizedBox(height: 50.h,),
                              _selectedImages.isNotEmpty  ?  Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 14.0.w),
                                child: ElevatedButton(onPressed: () async
                                {

                                  showDialog(context: context, builder: (context)
                                  => Dialog(
                                    child: Container(
                                      height: 230.h,
                                      width: 366.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 40.h,),
                                          Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: 30.w),
                                            child: Center(child: Text('لتأكيد إتمام المهمة اضغط للتعرف على موقعك الحالي',style: Styles.style16SemiBold,)),
                                          ),
                                          SizedBox(height: 30.h,),

                                          Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: 14.0.w),
                                            child: ElevatedButton(onPressed: () async
                                            {
                                              await _getCurrentPosition();
                                              log('abdo');
                                              if (_currentPosition != null) {
                                                log('sara');
                                                log(_currentPosition.toString());

                                                _getAddressFromLatLng(_currentPosition!); // Get the address for the current position
                                              } else {
                                                // Handle case when current position is null
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Failed to get current location')),
                                                );
                                              }

                                            },
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  minimumSize: Size(180.w, 50.h),
                                                  maximumSize: Size(180.w, 50.h),
                                                  fixedSize: Size(180.w, 50.h),

                                                ),
                                                child: Text('معرفة موقعي الحالي',
                                                  style: GoogleFonts.cairo(color: Colors.white,
                                                  ),)),
                                          ),
                                          //    _currentAddress != null ? Text(_currentAddress.toString(),style: Styles.style14whiteSemiBold,)
                                          // :   SizedBox(height: 70.h,),
                                          //    Padding(
                                          //      padding:  EdgeInsets.symmetric(horizontal: 14.0.w),
                                          //      child: ElevatedButton(onPressed: () async
                                          //      {
                                          //
                                          //
                                          //
                                          //      },
                                          //          style: OutlinedButton.styleFrom(
                                          //            backgroundColor: _currentAddress != null ? primaryColor : Colors.grey[400],
                                          //            minimumSize: Size(180.w, 50.h),
                                          //            maximumSize: Size(180.w, 50.h),
                                          //            fixedSize: Size(180.w, 50.h),
                                          //
                                          //          ),
                                          //          child: Text('تأكيد',
                                          //            style: GoogleFonts.cairo(color: Colors.white,
                                          //            ),)),
                                          //    ),
                                        ],
                                      ),
                                    ),
                                  ),);
                                },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      minimumSize: Size(180.w, 50.h),
                                      maximumSize: Size(180.w, 50.h),
                                      fixedSize: Size(180.w, 50.h),

                                    ),
                                    child: Text('تم',
                                      style: GoogleFonts.cairo(color: Colors.white,
                                      ),)),
                              ) : Container(),


                            ],
                          ),
                        ),
                      ),);



                    }),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
