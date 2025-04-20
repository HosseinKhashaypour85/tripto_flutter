import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/border_radius.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/notifications_features/widget/app_bar_widget.dart';
import 'package:tripto_flutter/features/public_features/functions/number_to_three/number_to_three.dart';
import 'package:tripto_flutter/features/public_features/widget/empty_screen_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    void callBloc() {
      BlocProvider.of<TripsHistoryBloc>(context).add(CallTripsHistoryEvent());
    }

    return BlocProvider(
      create: (context) => TripsHistoryBloc(
        TripsApiRepository(),
      )..add(
          CallTripsHistoryEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor,
          automaticallyImplyLeading: false,
          actions: [
            AppBarWidget(),
          ],
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<TripsHistoryBloc, TripsHistoryState>(
          builder: (context, state) {
            if (state is TripsHistoryLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: buttonColor,
                ),
              );
            }
            if (state is TripsHistoryCompletedState) {
              return ScreenContent(tripsHistoryModel: state.tripsHistoryModel , );
            }
            if (state is TripsHistoryErrorState) {
              return ErrorScreenWidget(
                errorMsg: state.error.errorMsg!,
                function: () => callBloc(),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
