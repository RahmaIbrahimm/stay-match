import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:stay_match/Features/payment/data/models/booking_details_response.dart';
import 'package:stay_match/Features/payment/data/repos/payment_repo_impl.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../manager/payment_cubit.dart';

class PayCreditView extends StatelessWidget {
  final int bookingId;

  const PayCreditView({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaymentCubit(paymentRepo: getIt.get<PaymentRepoImpl>())
            ..fetchBookingDetails(bookingId: bookingId),
      child: _PayCreditContent(bookingId: bookingId),
    );
  }
}

// ── Main scaffold ─────────────────────────────────────────────────────────────

class _PayCreditContent extends StatelessWidget {
  final int bookingId;

  const _PayCreditContent({required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is BookingDetailsSuccess &&
            state.redirectStatus == RedirectLinkStatus.success &&
            state.redirectUrl != null) {
          _handleRedirect(context, state.redirectUrl!);
        }

        if (state is BookingDetailsSuccess &&
            state.redirectStatus == RedirectLinkStatus.failure &&
            state.redirectError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.redirectError!,
                style: AppStyles.regular14poppins.copyWith(
                  color: AppColors.textColorWhite,
                ),
              ),
              backgroundColor: AppColors.textColorError,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.secondaryScaffBg,
        appBar: AppBar(
          backgroundColor: AppColors.secondaryScaffBg,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textColorPrimary,
              size: 24.r,
            ),
            onPressed: () {
              if (context.canPop()) context.pop();
            },
          ),
          title: Text(
            'Pay Credit',
            style: AppStyles.bold18poppins.copyWith(color: AppColors.primary),
          ),
          centerTitle: true,
        ),
        endDrawer: MainAppDrawer(),
        body: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state is BookingDetailsLoading || state is PaymentInitial) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is BookingDetailsFailure) {
              return _ErrorView(
                message: state.errMessage,
                onRetry: () => context.read<PaymentCubit>().fetchBookingDetails(
                  bookingId: bookingId,
                ),
              );
            }

            if (state is BookingDetailsSuccess) {
              final data = state.booking.data;

              if (data == null) {
                return const _ErrorView(message: 'No booking data found.');
              }

              final isPaying =
                  state.redirectStatus == RedirectLinkStatus.loading;

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _BookingSummaryCard(data: data),
                          SizedBox(height: 24.h),
                          _PayNowButton(
                            totalPrice: data.totalPrice?.toDouble(),
                            isLoading: isPaying,
                            onPressed: () => context
                                .read<PaymentCubit>()
                                .getRedirectLink(bookingId: bookingId),
                          ),
                          SizedBox(height: 16.h),

                          SizedBox(
                            width: double.infinity,
                            height: 54.h,
                            child: CustomElevatedButton(
                              text: "Chat with Host",
                              onPressed: () {
                                context.pushNamed(
                                  AppRouting.messagesName,
                                  pathParameters: {
                                    'id': ?data.host?.id?.toString(),
                                  },
                                );
                              },
                              backgroundColor: AppColors.secondary,
                              textColor: AppColors.textColorPrimary,
                              textStyle: AppStyles.bold16poppins,
                              borderRadius: 14,
                            ),
                          ),

                          SizedBox(height: 24.h),
                          const _SecureReservationNotice(),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _handleRedirect(BuildContext context, String redirectUrl) {
    // ── Option A: In-app WebView ────────────────────────────────────────────
    // TODO: replace successUrlPattern with the real success_url configured
    // on the backend for the Stripe Checkout Session.
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) => _PaymentWebViewScreen(
    //       redirectUrl: redirectUrl,
    //       successUrlPattern: 'https://yourapp.com/payment/success', // TODO
    //       onSuccess: () {
    //         // TODO: navigate to your payment-success placeholder screen
    //         // Navigator.of(context).pushReplacementNamed('paymentSuccess');
    //       },
    //     ),
    //   ),
    // );

    // ── Option B: External browser via url_launcher ─────────────────────────
    // TODO: uncomment and add url_launcher to pubspec.yaml
    // launchUrl(Uri.parse(redirectUrl), mode: LaunchMode.externalApplication);

    // Temporary fallback so the link is visible during testing:
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Redirect link ready (WebView/url_launcher not wired yet):\n$redirectUrl',
          style: AppStyles.regular12poppins.copyWith(
            color: AppColors.textColorWhite,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}

// ── Booking summary card ────────────────────────────────────────────────────────

class _BookingSummaryCard extends StatelessWidget {
  final BookingDetailsResponseData data;

  const _BookingSummaryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final property = data.property;
    final coverImage = property?.images
        ?.firstWhere(
          (img) => img.isCover == true,
          orElse: () => property.images!.first,
        )
        .imageUrl;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Booking Summary',
            style: AppStyles.bold18poppins.copyWith(color: AppColors.primary),
          ),
          SizedBox(height: 16.h),

          // Property row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: coverImage != null && coverImage.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: coverImage,
                        width: 96.r,
                        height: 96.r,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => _ImagePlaceholder(),
                        errorWidget: (_, __, ___) => _ImagePlaceholder(),
                      )
                    : _ImagePlaceholder(),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property?.name ?? 'Unknown Property',
                      style: AppStyles.semiBold16poppins.copyWith(
                        color: AppColors.textColorPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.r,
                          color: AppColors.textColorSecondary,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            [property?.city, property?.government]
                                .where((e) => e != null && e.isNotEmpty)
                                .join(', '),
                            style: AppStyles.regular14poppins.copyWith(
                              color: AppColors.textColorSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(height: 1, color: AppColors.stroke),
          SizedBox(height: 16.h),

          // Check-in / Check-out
          Row(
            children: [
              Expanded(
                child: _DateBox(label: 'CHECK-IN', date: data.startDate),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _DateBox(label: 'CHECK-OUT', date: data.endDate),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Cost breakdown
          _CostRow(
            label: 'Monthly Rent',
            value: data.monthlyPrice != null ? '${data.monthlyPrice} EGP' : '—',
          ),
          SizedBox(height: 10.h),
          // TODO: Security Deposit isn't in BookingDetailsResponse yet — placeholder.
          _CostRow(label: 'Security Deposit', value: '— EGP'),
          SizedBox(height: 10.h),
          // TODO: Service Fee isn't in BookingDetailsResponse yet — placeholder.
          _CostRow(label: 'Service Fee', value: '— EGP'),
          SizedBox(height: 16.h),
          Divider(height: 1, color: AppColors.stroke),
          SizedBox(height: 16.h),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppStyles.bold16poppins.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Text(
                data.totalPrice != null ? '${data.totalPrice} EGP' : '—',
                style: AppStyles.bold18poppins.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Date box ──────────────────────────────────────────────────────────────────

class _DateBox extends StatelessWidget {
  final String label;
  final String? date;

  const _DateBox({required this.label, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyles.bold10poppins.copyWith(
              color: AppColors.textColorSecondary,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            _formatDate(date),
            style: AppStyles.bold14poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? isoDate) {
    if (isoDate == null) return '—';
    try {
      final d = DateTime.parse(isoDate);
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[d.month - 1]} ${d.day.toString().padLeft(2, '0')}, ${d.year}';
    } catch (_) {
      return '—';
    }
  }
}

// ── Cost row ──────────────────────────────────────────────────────────────────

class _CostRow extends StatelessWidget {
  final String label;
  final String value;

  const _CostRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.regular14poppins.copyWith(
            color: AppColors.textColorSecondary,
          ),
        ),
        Text(
          value,
          style: AppStyles.semiBold14poppins.copyWith(
            color: AppColors.textColorPrimary,
          ),
        ),
      ],
    );
  }
}

// ── Pay now button ───────────────────────────────────────────────────────────────

class _PayNowButton extends StatelessWidget {
  final double? totalPrice;
  final bool isLoading;
  final VoidCallback onPressed;

  const _PayNowButton({
    required this.totalPrice,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final priceLabel = totalPrice != null ? '$totalPrice EGP' : '';

    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: CustomElevatedButton(
        text: 'Pay $priceLabel Now',
        isLoading: isLoading,
        onPressed: isLoading ? null : onPressed,
        backgroundColor: AppColors.primary,
        textColor: AppColors.textColorWhite,
        textStyle: AppStyles.bold16poppins,
        borderRadius: 14,
        suffixIcon: isLoading
            ? null
            : Icon(
                Icons.lock_outline,
                size: 18.r,
                color: AppColors.textColorWhite,
              ),
      ),
    );
  }
}

// ── Secure reservation notice ───────────────────────────────────────────────────

class _SecureReservationNotice extends StatelessWidget {
  const _SecureReservationNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.blueGrey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, size: 20.r, color: AppColors.primary),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Reservation',
                  style: AppStyles.semiBold14poppins.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Your funds are held securely and only released to the owner upon successful check-in.',
                  style: AppStyles.regular12poppins.copyWith(
                    color: AppColors.textColorSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Image placeholder ─────────────────────────────────────────────────────────────

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.r,
      height: 72.r,
      color: AppColors.bgGrey,
      child: Icon(
        Icons.apartment_rounded,
        size: 28.r,
        color: AppColors.textColorSecondary,
      ),
    );
  }
}

// ── Error view ────────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _ErrorView({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.r,
              color: AppColors.textColorError,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyles.regular14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
              TextButton(
                onPressed: onRetry,
                child: Text(
                  'Try again',
                  style: AppStyles.semiBold14poppins.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── WebView screen (commented out — uncomment when ready) ───────────────────────────

// TODO: add `webview_flutter` to pubspec.yaml, then uncomment this class
// and the import at the top of this file, and wire it up in _handleRedirect.
//
class _PaymentWebViewScreen extends StatefulWidget {
  final String redirectUrl;
  final String successUrlPattern;
  final VoidCallback onSuccess;

  const _PaymentWebViewScreen({
    required this.redirectUrl,
    required this.successUrlPattern,
    required this.onSuccess,
  });

  @override
  State<_PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<_PaymentWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.startsWith(widget.successUrlPattern)) {
              widget.onSuccess();
              Navigator.of(context).pop();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.redirectUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment')),
      body: WebViewWidget(controller: _controller),
    );
  }
}