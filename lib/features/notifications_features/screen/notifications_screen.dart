import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/notifications_features/logic/notifications_bloc.dart';
import 'package:tripto_flutter/features/notifications_features/model/notifications_model.dart';
import 'package:tripto_flutter/features/notifications_features/services/notifications_api_repository.dart';
import 'package:tripto_flutter/features/notifications_features/widget/notifications_type_chip_widget.dart';
import 'package:tripto_flutter/features/public_features/widget/empty_screen_widget.dart';
import 'package:tripto_flutter/features/public_features/widget/error_screen_widget.dart';

import '../widget/screen_content_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  static const String screenId = 'notifications_screen';

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsBloc(
        NotificationsApiRepository(),
      )..add(
          CallNotificationsEvent(),
        ),
      child: Center(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocBuilder<NotificationsBloc, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: buttonColor,
                    ),
                  );
                }
                if (state is NotificationsCompletedState) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<NotificationsBloc>(context)
                          .add(CallNotificationsEvent());
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.sp,
                        ),
                        NotificationsTypeChipWidget(),
                        ScreenContent(
                          notificationsModel: state.notificationsModel,
                        ),
                      ],
                    ),
                  );
                }
                if (state is NotificationsErrorState) {
                  return ErrorScreenWidget(
                      errorMsg: state.error.errorMsg!,
                      function: () {
                        BlocProvider.of<NotificationsBloc>(context)
                            .add(CallNotificationsEvent());
                      });
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
