import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/public_features/functions/pref/save_trip_id.dart';
import 'package:tripto_flutter/features/public_features/widget/empty_screen_widget.dart';
import 'package:tripto_flutter/features/public_features/widget/no_trip_widget.dart';
import 'package:tripto_flutter/features/trips_history_features/widget/app_bar_widget.dart';
import 'package:tripto_flutter/features/public_features/functions/pref/save_user_id.dart';
import 'package:tripto_flutter/features/public_features/widget/error_screen_widget.dart';
import 'package:tripto_flutter/features/public_features/widget/snack_bar_widget.dart';
import 'package:tripto_flutter/features/trips_history_features/logic/trips_history_bloc.dart';
import 'package:tripto_flutter/features/trips_history_features/model/trips_history_model.dart';
import 'package:tripto_flutter/features/trips_history_features/services/trips_api_repository.dart';
import 'package:tripto_flutter/features/trips_history_features/widget/screen_content.dart';

class TripsHistoryScreen extends StatefulWidget {
  const TripsHistoryScreen({super.key});

  static const String screenId = 'trips_history';

  @override
  State<TripsHistoryScreen> createState() => _TripsHistoryScreenState();
}

class _TripsHistoryScreenState extends State<TripsHistoryScreen> {
  late TripsHistoryBloc _tripsHistoryBloc;
  String? _tripId;

  @override
  void initState() {
    super.initState();
    _tripsHistoryBloc = TripsHistoryBloc(TripsApiRepository());
    _loadTripIdAndCallBloc();
  }

  Future<void> _loadTripIdAndCallBloc() async {
    var tripId = await SaveTripId().getTripId();
    if (tripId != null) {
      _tripsHistoryBloc.add(CallTripsHistoryEvent(tripId: tripId));
      setState(() {
        _tripId = tripId; // ذخیره کردن tripId برای استفاده در بخش‌های دیگر
      });
    } else {
      debugPrint('❌ Trip ID not found!');
      setState(() {
        _tripId = null; // tripId را null قرار می‌دهیم که در صفحه نمایش داده شود
      });
    }
  }

  void _retryFetch() {
    if (_tripId != null) {
      _tripsHistoryBloc.add(CallTripsHistoryEvent(tripId: _tripId!));
    } else {
      getSnackBarWidget(context, 'تریپ یافت نشد.',
          Colors.red); // اسنک‌بار فقط برای پیام هشدار
    }
  }
  void _showLocalNotification() {
    final notification = LocalNotification(
      title: "اعلان جدید",
      body: "این یک اعلان محلی است.",
      identifier: "trip_notification", // شناسه یکتا
    );
    notification.show();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TripsHistoryBloc>.value(
      value: _tripsHistoryBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor,
          automaticallyImplyLeading: false,
          actions: [
            AppBarWidget(),
            // ElevatedButton(onPressed: () {
            //   _showLocalNotification();
            // }, child: Text('data'))
          ],
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<TripsHistoryBloc, TripsHistoryState>(
          builder: (context, state) {
            if (_tripId == null) {
              return Center(
                  child: NoTripWidget(
                      title: 'هنوز افتخار سفر با شما نداشته ایم !'));
            } else if (state is TripsHistoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: buttonColor),
              );
            } else if (state is TripsHistoryCompletedState) {
              return ScreenContent(
                tripsHistoryModel: state.tripsHistoryModel,
              );
            } else if (state is TripsHistoryErrorState) {
              return ErrorScreenWidget(
                errorMsg: state.error.errorMsg ?? 'خطایی رخ داده است',
                function: _retryFetch,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
