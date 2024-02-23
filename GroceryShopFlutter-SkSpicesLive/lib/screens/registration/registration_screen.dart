import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart'
    as geolocator; // or whatever name you want
import 'package:grocery_app/bloc/base/base_bloc.dart';
import 'package:grocery_app/bloc/others/firstscreen/first_screen_bloc.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/models/api_request/Customer/customer_registration_request.dart';
import 'package:grocery_app/models/api_response/company_details_response.dart';
import 'package:grocery_app/models/common/all_name_id.dart';
import 'package:grocery_app/screens/base/base_screen.dart';
import 'package:grocery_app/screens/login/login_screen.dart';
import 'package:grocery_app/ui/color_resource.dart';
import 'package:grocery_app/ui/dimen_resource.dart';
import 'package:grocery_app/ui/image_resource.dart';
import 'package:grocery_app/utils/general_utils.dart';
import 'package:grocery_app/utils/rounded_progress_bar.dart';
import 'package:grocery_app/utils/shared_pref_helper.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:location/location.dart'as loc;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:permission_handler/permission_handler.dart';


class RegistrationScreen extends BaseStatefulWidget {
  static const routeName = '/RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends BaseState<RegistrationScreen>
    with BasicScreen, WidgetsBindingObserver {
  FToast fToast;

  double DEFAULT_SCREEN_LEFT_RIGHT_MARGIN = 30.0;

  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fetchaddresswithlocation = TextEditingController();
  TextEditingController _userContactController = TextEditingController();

  String InvalidUserMessage = "";
  bool _isObscure = true;
  String SiteUrl = "";
  ThemeData baseTheme;

  String Address = 'search';
  String Latitude;
  String Longitude;
  Position _currentPosition;
  loc.Location location = new loc.Location();

  final Geolocator geolocator123 = Geolocator();
  bool isLoading = false;
  ProgressBarHandler _handler;
  FirstScreenBloc _categoryScreenBloc;

  CompanyDetailsResponse _offlineCompanydetails;
  String CustomerID = "";
  String LoginUserID = "";
  String CompanyID = "";
  String MapAPIKey = "";

  bool is_LocationService_Permission;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _offlineCompanydetails = SharedPrefHelper.instance.getCompanyData();
    getLocationLivePermission();


    CompanyID = _offlineCompanydetails.details[0].pkId.toString();
    MapAPIKey = _offlineCompanydetails.details[0].MapApiKey;

    fToast = FToast();
    fToast.init(context);
    _categoryScreenBloc = FirstScreenBloc(baseBloc);

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _categoryScreenBloc,
      child: BlocConsumer<FirstScreenBloc, FirstScreenStates>(
        builder: (BuildContext context, FirstScreenStates state) {
          /*if(state is ProductCartResponseState)
            {


              _onCartListResponse(state,context);
            }*/
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          /*   if(currentState is InquiryProductSaveResponseState ||
              currentState is CartDeleteResponseState

          )
          {
            return true;

          }*/
          return false;
        },
        listener: (BuildContext context, FirstScreenStates state) {
          if (state is CustomerRegistrationResponseState) {
            _onRegistrationSucess(state, context);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is CustomerRegistrationResponseState) {
            return true;
          }
          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    //var theme =ThemeData(colorScheme: ColorScheme(secondary:Getirblue ),);

    baseTheme = /*Theme.of(context).copyWith(
        primaryColor: Colors.lightGreen,
        colorScheme: ThemeData.light().colorScheme.copyWith(
          secondary: Getirblue,
        ),
    );*/
        ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.red, // Your accent color
    ));
    // ColorScheme.fromSwatch().copyWith(primary: Getirblue,secondary: Getirblue));

    var progressBar = ModalRoundedProgressBar(
      //getting the handler
      handleCallback: (handler) {
        _handler = handler;
      },
    );

    var scaffold = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            navigateTo(context, LoginScreen.routeName, clearAllStack: true);
          },
          child: Container(
              padding: EdgeInsets.only(left: 25),
              child: Icon(
                Icons.arrow_back,
                size: 35,
                color: Getirblue,
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN,
              right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN,
              top: 50,
              bottom: 50),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopView(),
                    SizedBox(height: 50),
                    _buildLoginForm(context)
                  ],
                ),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Stack(
        children: <Widget>[
          scaffold,
          progressBar,
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, LoginScreen.routeName, clearAllStack: true);
  }

  Widget _buildTopView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* Image.network("https://thumbs.dreamstime.com/b/avatar-supermarket-worker-cash-register-customer-car-full-groceries-colorful-design-vector-illustration-163995684.jpg",
          width: MediaQuery.of(context).size.width / 1.5,
          fit: BoxFit.fitWidth,),*/
        SizedBox(
          height: 5,
        ),
        /* Text(
          "Login",
          style: baseTheme.textTheme.headline1,
        ),*/
        Text(
          "Registration",
          style: TextStyle(
            color: Getirblue,
            fontSize: 48,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Register a new account",
          style: TextStyle(
            color: Getirblue,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        logoutButton(context),
        SizedBox(
          height: 25,
        ),
        getCommonTextFormField(context, baseTheme,
            title: "Username",
            hint: "enter username",
            keyboardType: TextInputType.emailAddress,
            suffixIcon: Icon(Icons.person),
            controller: _userNameController),
        SizedBox(
          height: 25,
        ),
        getCommonTextFormField(context, baseTheme,
            title: "Email",
            hint: "enter email address",
            keyboardType: TextInputType.emailAddress,
            suffixIcon: Icon(Icons.email_outlined),
            controller: _userEmailController),
        SizedBox(
          height: 25,
        ),
        getCommonTextFormField(context, baseTheme,
            title: "Contact No.",
            maxLength: 16,
            hint: "enter contact number",
            keyboardType: TextInputType.phone,
            suffixIcon: Icon(Icons.phone_android),
            controller: _userContactController),
        SizedBox(
          height: 25,
        ),
        getCommonTextFormField(context, baseTheme,
            title: "Password",
            hint: "enter password",
            obscureText: _isObscure,
            textInputAction: TextInputAction.done,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
            controller: _passwordController),
        SizedBox(
          height: 35,
        ),
        Container(
          // margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Address",
              style: TextStyle(
                  color: colorPrimary,
                  fontSize:
                      18) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

              ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0, right: 0, top: 0),
          child: TextFormField(
            controller: _fetchaddresswithlocation,
            minLines: 5,
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: 'Enter Details',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: new BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Getirblue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Getirblue),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Getirblue),
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: Getirblue)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: Getirblue)),
            ),
          ),
        ),
        /*getCommonTextFormField(context, baseTheme,
            title: "Re-Enter Password",
            hint: "enter password",
            obscureText: _isObscure,
            textInputAction: TextInputAction.done,
            suffixIcon:
            IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
            controller: _re_enter_passwordController
        ),
        SizedBox(
          height: 35,
        ),*/
        SizedBox(
          height: 20,
        ),
        getButton(context),
        SizedBox(
          height: 20,
        ),
        _buildGoogleButtonView(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget getButton(BuildContext context) {
    return AppButton(
      label: "Register",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () {
        /* TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fetchaddresswithlocation = TextEditingController();*/
        if (_userEmailController.text != "") {
          if (_userNameController.text != "") {
            if (_passwordController.text != "") {
              if (_userContactController.text != "") {
                if (_fetchaddresswithlocation.text != "") {
                  /* SignUpDetails signupDetails = new SignUpDetails();
                  signupDetails.Email = _userEmailController.text;
                  signupDetails.UserName = _userNameController.text;

                  signupDetails.Password = _passwordController.text;
                  signupDetails.Address = _fetchaddresswithlocation.text;
                 // SharedPrefHelper.instance.setSignUpData(signupDetails);
                  SharedPrefHelper.instance.putString(SharedPrefHelper.IS_REGISTERED,"is_registered");*/

                  String CustomerName = _userNameController.text.toString();
                  String Address = _fetchaddresswithlocation.text.toString();
                  String EmailAddress = _userEmailController.text.toString();
                  String ContactNo = _userContactController.text.toString();
                  String LoginUserID =
                      _userNameController.text.toString().trim();
                  String BlockCustomer = "1";
                  String ProfileImage = "";
                  String Password = _passwordController.text.toString();
                  String CompanyId = CompanyID;

                  _categoryScreenBloc.add(CustomerRegistrationRequestCallEvent(
                      0,
                      CustomerRegistrationRequest(
                          CustomerName: CustomerName,
                          Address: Address,
                          EmailAddress: EmailAddress,
                          ContactNo: ContactNo,
                          LoginUserID: LoginUserID,
                          BlockCustomer: BlockCustomer,
                          ProfileImage: ProfileImage,
                          Password: Password,
                          CompanyId: CompanyId,
                          CustomerType: "customer")));
                } else {
                  showCommonDialogWithSingleOption(
                      context, "Address is required!",
                      positiveButtonTitle: "OK", onTapOfPositiveButton: () {
                    Navigator.of(context).pop();
                  });
                }
              } else {
                showCommonDialogWithSingleOption(
                    context, "Contact No. is required!",
                    positiveButtonTitle: "OK", onTapOfPositiveButton: () {
                  Navigator.of(context).pop();
                });
              }
            } else {
              showCommonDialogWithSingleOption(context, "Password is required!",
                  positiveButtonTitle: "OK", onTapOfPositiveButton: () {
                Navigator.of(context).pop();
              });
            }
          } else {
            showCommonDialogWithSingleOption(context, "UserName is required!",
                positiveButtonTitle: "OK", onTapOfPositiveButton: () {
              Navigator.of(context).pop();
            });
          }
        } else {
          showCommonDialogWithSingleOption(
              context, "Email address is required!", positiveButtonTitle: "OK",
              onTapOfPositiveButton: () {
            Navigator.of(context).pop();
          });
        }
      },
    );
  }

  Widget _buildGoogleButtonView() {
    return Visibility(
      visible: false,
      child: Container(
        width: double.maxFinite,
        height: COMMON_BUTTON_HEIGHT,
        // ignore: deprecated_member_use
        child: ElevatedButton(
          onPressed: () {
            //_onTapOfSignInWithGoogle();
          },
          /*color: colorRedLight,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(COMMON_BUTTON_RADIUS)),
          ),
          elevation: 0.0,*/
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                IC_GOOGLE,
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Sign in with Google",
                textAlign: TextAlign.center,
                style: baseTheme.textTheme.button,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return InkWell(
      onTap: () {


        if(is_LocationService_Permission==false)
        {
          getLocationLivePermission();
        }
        else
        {
          getLiveAddressLatLong();

        }


      },
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton(
          /*visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          color: Getirblue,
          textColor: Colors.white,
          elevation: 0.0,
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),*/
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Icon(
                  Icons.my_location,
                  color: colorWhite,
                ),
                width: 10,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Current Location",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          onPressed: () async {
           // _getCurrentLocation();


            if(is_LocationService_Permission==false)
            {
              getLocationLivePermission();
            }
            else
            {
              getLiveAddressLatLong();

            }


          },
        ),
      ),
    );
  }

  _getCurrentLocation() async {

    /*Position position = await Geolocator.getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.best);
    _currentPosition = position;
    Longitude = position.longitude.toString();
    Latitude = position.latitude.toString();
    Address = "";

    Address = await getAddressFromLatLng(
        Latitude, Longitude, "AIzaSyC8I7M35BI9V0wVOGXpLIaR7SlArdi3fso");
    _handler.dismiss();

    _fetchaddresswithlocation.text = Address;*/


    location.onLocationChanged.listen((LocationData currentLocation) async {
      print("OnLocationChange" +
          " Location : " +
          currentLocation.latitude.toString());

      Latitude = currentLocation.latitude.toString();
      Longitude = currentLocation.longitude.toString();
      try {
        List<geo.Placemark> placemark = [];
        placemark = await placemarkFromCoordinates(currentLocation.latitude,currentLocation.longitude);


       Address = "${placemark[0].name}, ${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}, ${placemark[0].administrativeArea}, ${placemark[0].country},";
        //placemark[0].name.toString() + placemark[0].street.toString() + ","+ placemark[0].locality.toString() +","+placemark[0].country.toString();

        print("Addressdddd" +
            " Address : " +
            Address);



      }
      catch (e){
        showCommonDialogWithSingleOption(
            context, "You Map API Key Is Not Register.",
            positiveButtonTitle: "OK", onTapOfPositiveButton: (){
          navigateTo(context, LoginScreen.routeName, clearAllStack: true);

        });
      }
    });
  }



  void _onRegistrationSucess(
      CustomerRegistrationResponseState state, BuildContext context) {
    print("Response Customer" +
        " Response : " +
        state.customerRegistrationResponse.details[0].column2.toString());

    if (state.customerRegistrationResponse.details[0].column2 ==
        "Information Added Successfully") {
      showCommonDialogWithSingleOption(
          context, state.customerRegistrationResponse.details[0].column2,
          positiveButtonTitle: "OK", onTapOfPositiveButton: () {
        navigateTo(context, LoginScreen.routeName, clearAllStack: true);
      });
    } else {
      showCommonDialogWithSingleOption(
          context, state.customerRegistrationResponse.details[0].column2,
          positiveButtonTitle: "OK");
    }
    /* fToast.showToast(
       child: showCustomToast(Title: "registered successful"),
       gravity: ToastGravity.BOTTOM,
       toastDuration: Duration(seconds: 2),
     );*/
  }


  void getLiveAddressLatLong() async {





    baseBloc.emit(ShowProgressIndicatorState(true));
    // loc.LocationData locationData = await  loc.Location.instance.getLocation();
    List<geo.Placemark> placemark = [];


    //Latitude = locationData.latitude.toString();
    // Longitude = locationData.longitude.toString();

    Latitude = _currentPosition.latitude.toString();
    Longitude = _currentPosition.longitude.toString();


    placemark = await geo.placemarkFromCoordinates(_currentPosition.latitude,_currentPosition.longitude);
    Address = "${placemark[0].name}, ${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}, ${placemark[0].administrativeArea}, ${placemark[0].country},";


    baseBloc.emit(ShowProgressIndicatorState(false));



    setState(() {
      _fetchaddresswithlocation.text = Address;

    });
  }
  void getLocationLivePermission() async {
    bool serviceEnabled;
    geolocator.LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      checkPermissionStatus();
      return Future.error('Location services are disabled.');
    }

    permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied) {
      //permission = await Geolocator.requestPermission();
      if (permission == geolocator.LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        print("A12215534" +
            "Location permissions are  denied, we cannot request permissions.");

        permission = await geolocator.Geolocator.requestPermission();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == geolocator.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      print("A12215534" +
          "Location permissions are permanently denied, we cannot request permissions.");

      permission = await geolocator.Geolocator.requestPermission();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == geolocator.LocationPermission.whileInUse) {
      geolocator.Position position = await geolocator.Geolocator.getCurrentPosition();
      _currentPosition = position;
      print("CurrentLatLong" +
          position.latitude.toString() +
          " , " +
          position.longitude.toString());


      geolocator.Geolocator
          .getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.best, forceAndroidLocationManager: true)
          .then((geolocator.Position position) {
        setState(() {
          _currentPosition = position;
          getLiveAddressLatLong();
        });
      }).catchError((e) {
        print(e);
      });



      /* location.onLocationChanged.listen((LocationData currentLocation) {
        // Use current location

        SharedPrefHelper.instance.setLatitude(currentLocation.latitude.toString());
        SharedPrefHelper.instance.setLongitude(currentLocation.longitude.toString());
      });*/
    }

  }
  void checkPermissionStatus() async {
    if (!await location.serviceEnabled()) {
      // location.requestService();

      if (Platform.isAndroid) {
        location.requestService();
        /*showCommonDialogWithSingleOption(Globals.context,
            "Can't get current location, Please make sure you enable GPS and try again !",
            positiveButtonTitle: "OK", onTapOfPositiveButton: () {
          AppSettings.openLocationSettings();
          Navigator.pop(context);
        });*/
      }
    }
    bool granted = await Permission.location.isGranted;
    bool Denied = await Permission.location.isDenied;
    bool PermanentlyDenied = await Permission.location.isPermanentlyDenied;

    print("PermissionStatus" +
        "Granted : " +
        granted.toString() +
        " Denied : " +
        Denied.toString() +
        " PermanentlyDenied : " +
        PermanentlyDenied.toString());

    if (Denied == true) {
      // openAppSettings();
      is_LocationService_Permission = false;
      await Permission.location.request();
    }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      openAppSettings();
    }
    if (PermanentlyDenied == true) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      is_LocationService_Permission = false;
      openAppSettings();
    }

    if (granted == true) {
      // The OS restricts access, for example because of parental controls.
      is_LocationService_Permission = true;


    }
  }



}
