import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/notifications_features/logic/notifications_bloc.dart';
import 'package:tripto_flutter/features/notifications_features/widget/notifications_type_chip_widget.dart';
import 'package:tripto_flutter/features/public_features/logic/token_checker/token_check_cubit.dart';
import 'package:tripto_flutter/features/public_features/widget/error_screen_widget.dart';
import 'package:tripto_flutter/features/public_features/widget/not_login_widget.dart';
import '../widget/screen_content_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  static const String screenId = 'notifications_screen';

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsBloc>().add(CallNotificationsEvent());
    context.read<TokenCheckCubit>().tokenChecker();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: buttonColor),
              );
            }

            if (state is NotificationsErrorState) {
              return ErrorScreenWidget(
                errorMsg: state.error.errorMsg!,
                function: () {
                  context.read<NotificationsBloc>().add(CallNotificationsEvent());
                },
              );
            }

            if (state is NotificationsCompletedState) {
              return BlocBuilder<TokenCheckCubit, TokenCheckState>(
                builder: (context, tokenState) {
                  if (tokenState is TokenNotLoggedState) {
                    return const NotLoginWidget();
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<NotificationsBloc>().add(CallNotificationsEvent());
                    },
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.sp,
                        horizontal: 12.sp,
                      ),
                      children: [
                        NotificationsTypeChipWidget(),
                        SizedBox(height: 12.h),
                        NotificationsScreenContent(
                          notificationsModel: state.notificationsModel,
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
