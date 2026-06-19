import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

import '../../data/models/get_questions_response.dart';
import '../manager/questions_cubit.dart';
import '../manager/questions_state.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  final PageController _pageController = PageController();

  Widget _buildPremiumErrorState({
    required String errorMessage,
    required bool isSubmissionError,
  }) {
    // Map raw backend strings to friendly user-facing language
    String _getCustomUserMessage(String apiError) {
      final error = apiError.toLowerCase();
      if (error.contains('timeout') || error.contains('connection')) {
        return "Connection timed out. We couldn't establish a reliable link to StayMatch. Please verify your connection strength.";
      }
      if (error.contains('network') || error.contains('socket')) {
        return "It looks like you're offline. Check your Wi-Fi or cellular data status and try again.";
      }
      if (error.contains('401') || error.contains('unauthorized')) {
        return "Your access session has timed out. Please re-authenticate your account profile to secure your connection.";
      }
      if (error.contains('500') || error.contains('server')) {
        return "We're experiencing heavy traffic or temporary server adjustments. Our backend engineering team is on it!";
      }
      return isSubmissionError
          ? "We couldn't securely save your application preferences. Let's try sending them once more."
          : "We encountered an unexpected hurdle setting up your match parameters. Let's give it another shot.";
    }

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 40.h),
        margin: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.r),
          // Ultra-rounded clean card corners
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E3A8A).withOpacity(0.06),
              blurRadius: 30.r,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🚀 Big Premium Layered Badge with Soft Neon Glow Rings
            Container(
              width: 110.r,
              height: 110.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [const Color(0xFFFFF1F2), const Color(0xFFFFE4E6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Container(
                  width: 76.r,
                  height: 76.r,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFECDD3),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 50.r,
                      height: 50.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF43F5E),
                        // Vivid rose/red focal element
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isSubmissionError
                            ? Icons.cloud_upload_outlined
                            : Icons.wifi_off_rounded,
                        color: Colors.white,
                        size: 26.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Core Header Message
            Text(
              isSubmissionError
                  ? 'Submission Failed'
                  : 'Sync Issue Encountered',
              style: AppStyles.bold24poppins.copyWith(
                fontSize: 22.sp,
                color: AppColors.textColorPrimary,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),

            // Highly readable body paragraph with soft text tracking
            Text(
              _getCustomUserMessage(errorMessage),
              style: AppStyles.regular14poppins.copyWith(
                color: const Color(0xFF64748B),
                fontSize: 14.5.sp,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 36.h),

            // Big Modern Premium Action Button
            SizedBox(
              height: 54.h,
              width: double.infinity,
              // Fully spans the container card canvas cleanly
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shadowColor: AppColors.primary.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16.r,
                    ), // Matches the card accent style
                  ),
                ),
                onPressed: () {
                  if (isSubmissionError) {
                    // 🎯 Retry logic if they were trying to submit answers at the final step
                    context.read<QuestionsCubit>().submitAnswers();
                  } else {
                    // 🎯 Retry logic if initial loading failed
                    context.read<QuestionsCubit>().fetchQuestions();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isSubmissionError
                          ? Icons.backup_outlined
                          : Icons.refresh_rounded,
                      color: Colors.white,
                      size: 20.r,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      isSubmissionError ? 'Retry Upload' : 'Reconnect Now',
                      style: AppStyles.medium16poppins.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textColorPrimary,
            size: 24.r,
          ),
          onPressed: () {
            final cubit = context.read<QuestionsCubit>();
            if (cubit.state is QuestionsSuccess &&
                (cubit.state as QuestionsSuccess).currentStep > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              cubit.previousStep();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'StayMatch',
          style: AppStyles.bold24poppins.copyWith(
            color: const Color(0xFF1E3A8A),
          ),
        ),
        centerTitle: true,

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.h),
          child: BlocBuilder<QuestionsCubit, QuestionsState>(
            builder: (context, state) {
              if (state is QuestionsSuccess && state.categories.isNotEmpty) {
                double progress =
                    (state.currentStep + 1) / state.categories.length;
                return LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFFE2E8F0),
                  color: AppColors.primary,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      body: BlocBuilder<QuestionsCubit, QuestionsState>(
        builder: (context, state) {
          if (state is QuestionsInitial || state is QuestionsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is QuestionsFailure) {
            bool isSubmissionError =
                context.read<QuestionsCubit>().state is QuestionsSuccess ||
                _pageController.hasClients && _pageController.page! > 0;

            return _buildPremiumErrorState(
              errorMessage: state.errorMessage,
              isSubmissionError: isSubmissionError,
            );
          } else if (state is QuestionsSuccess) {
            if (state.categories.isEmpty) {
              return const Center(child: Text("No questions available."));
            }
            return PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryStep(
                  context,
                  state.categories[index],
                  state,
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildCategoryStep(
    BuildContext context,
    QuestionCategory categoryData,
    QuestionsSuccess state,
  ) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'STEP ${state.currentStep + 1} OF ${state.categories.length}',
                          style: AppStyles.medium14poppins.copyWith(
                            color: const Color(0xFF52B788),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          state.currentStep == 0
                              ? 'Tell us about yourself'
                              : (categoryData.category?.nameEn ?? ''),
                          style: AppStyles.bold24poppins.copyWith(
                            color: AppColors.textColorPrimary,
                            fontSize: 26.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "We use this information to find you the most compatible housemates.",
                          style: AppStyles.regular14poppins.copyWith(
                            color: const Color(0xFF64748B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, qIndex) {
                    final question = categoryData.questions![qIndex];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.questionEn ?? '',
                            style: AppStyles.medium16poppins.copyWith(
                              color: AppColors.textColorPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          _buildDynamicOptions(context, question, state),
                        ],
                      ),
                    );
                  }, childCount: categoryData.questions?.length ?? 0),
                ),
              ],
            ),
          ),
          _buildBottomNavigationBar(context, state),
        ],
      ),
    );
  }

  Widget _buildDynamicOptions(
    BuildContext context,
    Question question,
    QuestionsSuccess state,
  ) {
    final options = question.options ?? {};
    final selectedKey = state.selectedAnswers[question.key];
    final screenWidth = MediaQuery.of(context).size.width;

    // 1. Wrap Pill Chips Layout ("study_or_work_field")
    if (question.key == 'study_or_work_field') {
      return Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: options.entries.map((entry) {
          bool isSelected = selectedKey == entry.key;
          return InkWell(
            onTap: () => context.read<QuestionsCubit>().selectOption(
              question.key!,
              entry.key,
            ),
            customBorder: const StadiumBorder(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFFE2E8F0),
                  width: isSelected ? 2.r : 1.r,
                ),
              ),
              child: Text(
                entry.value.en ?? '',
                style: AppStyles.medium16poppins.copyWith(
                  color: AppColors.textColorPrimary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      );
    }

    // 2. Dynamic Row Grid Layout ("busiest_time") - 3 items first row, 2 items second row
    // 2. Dynamic Row Grid Layout ("busiest_time")
    if (question.key == 'busiest_time') {
      final listEntries = options.entries.toList();
      return Column(
        children: [
          // Row 1: Morning, Noon, Afternoon (Each takes exactly 1/3 of row space)
          if (listEntries.length >= 3)
            Row(
              children: listEntries.sublist(0, 3).map((entry) {
                bool isSelected = selectedKey == entry.key;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: _buildBaseContainer(
                      onTap: () => context.read<QuestionsCubit>().selectOption(
                        question.key!,
                        entry.key,
                      ),
                      isSelected: isSelected,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Text(
                            entry.value.en ?? '',
                            style: _getOptionStyle(isSelected),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          SizedBox(height: 10.h),
          // Row 2: Evening, Night (Each fully extends to take exactly 1/2 of row space)
          if (listEntries.length > 3)
            Row(
              children: listEntries.sublist(3).map((entry) {
                bool isSelected = selectedKey == entry.key;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: _buildBaseContainer(
                      onTap: () => context.read<QuestionsCubit>().selectOption(
                        question.key!,
                        entry.key,
                      ),
                      isSelected: isSelected,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Text(
                            entry.value.en ?? '',
                            style: _getOptionStyle(isSelected),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      );
    }
    // 3. Trailing Icon List Items ("sleep_time")
    if (question.key == 'sleep_time') {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          String key = options.keys.elementAt(index);
          String text = options[key]!.en ?? '';
          bool isSelected = selectedKey == key;

          IconData trailingIcon = Icons.access_time;
          if (text.toLowerCase().contains('before 10'))
            trailingIcon = Icons.nightlight_round_outlined;
          else if (text.toLowerCase().contains('12 am'))
            trailingIcon = Icons.access_time;
          else if (text.toLowerCase().contains('after 2'))
            trailingIcon = Icons.dark_mode_outlined;

          return _buildBaseContainer(
            onTap: () =>
                context.read<QuestionsCubit>().selectOption(question.key!, key),
            isSelected: isSelected,
            child: Row(
              children: [
                Expanded(child: Text(text, style: _getOptionStyle(isSelected))),
                Icon(trailingIcon, color: const Color(0xFF64748B), size: 22.r),
              ],
            ),
          );
        },
      );
    }

    // 4. Radio List Layout with Subtitles ("study_environment")
    if (question.key == 'study_environment') {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          String key = options.keys.elementAt(index);
          String text = options[key]!.en ?? '';
          bool isSelected = selectedKey == key;

          // Hardcoded matching subtitles for this specific layout structure
          String subtitle = '';
          if (text.toLowerCase().contains('complete silence'))
            subtitle = 'Best for high focus and deep work';
          else if (text.toLowerCase().contains('mostly quiet'))
            subtitle = 'Occasional light background noise is fine';
          else if (text.toLowerCase().contains('some noise'))
            subtitle = 'Ambient chatter or music helps you stay productive';
          else if (text.toLowerCase().contains('no preference'))
            subtitle = 'You can adapt to any environment easily';

          return _buildBaseContainer(
            onTap: () =>
                context.read<QuestionsCubit>().selectOption(question.key!, key),
            isSelected: isSelected,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 22.r,
                  height: 22.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : const Color(0xFFCBD5E1),
                      width: 2.r,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 10.r,
                            height: 10.r,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: _getOptionStyle(
                          isSelected,
                        ).copyWith(fontSize: 15.sp),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          subtitle,
                          style: AppStyles.regular14poppins.copyWith(
                            color: const Color(0xFF64748B),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    // 5. Standard Clean Vertical Stack List ("mess_tolerance", "flexibility_level", "smoking_preference")
    bool isSimpleVerticalList =
        question.key == 'mess_tolerance' ||
        question.key == 'flexibility_level' ||
        question.key == 'smoking_preference';

    if (isSimpleVerticalList) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          String key = options.keys.elementAt(index);
          String text = options[key]!.en ?? '';
          bool isSelected = selectedKey == key;

          return _buildBaseContainer(
            onTap: () =>
                context.read<QuestionsCubit>().selectOption(question.key!, key),
            isSelected: isSelected,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Text(
                text,
                style: _getOptionStyle(
                  isSelected,
                ).copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),
          );
        },
      );
    }

    // 6. Vertical List Rows with Left Badges ("occupation_status")
    if (question.key == 'occupation_status') {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          String key = options.keys.elementAt(index);
          String text = options[key]!.en ?? '';
          bool isSelected = selectedKey == key;

          IconData leadingIcon = Icons.work_outline;
          if (text.toLowerCase().contains('student and employee'))
            leadingIcon = Icons.badge_outlined;
          else if (text.toLowerCase().contains('student'))
            leadingIcon = Icons.school_outlined;
          else if (text.toLowerCase().contains('freelancer'))
            leadingIcon = Icons.laptop_mac_outlined;

          return _buildBaseContainer(
            onTap: () =>
                context.read<QuestionsCubit>().selectOption(question.key!, key),
            isSelected: isSelected,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFF6FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    leadingIcon,
                    color: const Color(0xFF1E3A8A),
                    size: 22.r,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(child: Text(text, style: _getOptionStyle(isSelected))),
              ],
            ),
          );
        },
      );
    }

    // 7. Wrap-Based 2x2 Square Feature Blocks ("free_day_style", "biggest_shared_living_issue", "first_activity_home")
    bool isFeatureBlockGrid =
        question.key == 'free_day_style' ||
        question.key == 'biggest_shared_living_issue' ||
        question.key == 'first_activity_home';

    if (isFeatureBlockGrid) {
      final double blockItemWidth = (screenWidth - 48.w - 12.w) / 2;
      return Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        children: options.entries.map((entry) {
          String key = entry.key;
          String text = entry.value.en ?? '';
          bool isSelected = selectedKey == key;

          IconData gridIcon = Icons.help_outline;
          if (text.toLowerCase() == 'at home')
            gridIcon = Icons.home_outlined;
          else if (text.toLowerCase() == 'with friends')
            gridIcon = Icons.people_outline;
          else if (text.toLowerCase() == 'going out often')
            gridIcon = Icons.celebration_outlined;
          else if (text.toLowerCase() == 'depends')
            gridIcon = Icons.unfold_more_outlined;
          else if (text.toLowerCase() == 'noise')
            gridIcon = Icons.volume_up_outlined;
          else if (text.toLowerCase() == 'messiness')
            gridIcon = Icons.cleaning_services_outlined;
          else if (text.toLowerCase() == 'smoking')
            gridIcon = Icons.smoking_rooms_outlined;
          else if (text.toLowerCase() == 'lack of privacy')
            gridIcon = Icons.visibility_off_outlined;
          else if (text.toLowerCase() == 'rest')
            gridIcon = Icons.weekend_outlined;
          else if (text.toLowerCase() == 'study or work')
            gridIcon = Icons.menu_book_outlined;
          else if (text.toLowerCase() == 'eat')
            gridIcon = Icons.restaurant_outlined;
          else if (text.toLowerCase() == 'socialize')
            gridIcon = Icons.groups_outlined;

          return SizedBox(
            width: blockItemWidth,
            child: _buildBaseContainer(
              onTap: () => context.read<QuestionsCubit>().selectOption(
                question.key!,
                key,
              ),
              isSelected: isSelected,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF6FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        gridIcon,
                        color: const Color(0xFF1E3A8A),
                        size: 24.r,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      text,
                      style: _getOptionStyle(
                        isSelected,
                      ).copyWith(fontSize: 15.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      );
    }
    // 8. Default Fallback Simple Grid Layout (e.g., "age_group")
    final double standardItemWidth = (screenWidth - 48.w - 12.w) / 2;
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: options.entries.map((entry) {
        String key = entry.key;
        String text = entry.value.en ?? '';
        bool isSelected = selectedKey == key;

        return SizedBox(
          width: standardItemWidth,
          child: _buildBaseContainer(
            onTap: () =>
                context.read<QuestionsCubit>().selectOption(question.key!, key),
            isSelected: isSelected,
            child: Container(
              height: 50.h,
              alignment: Alignment.center,
              child: Text(
                text,
                style: _getOptionStyle(isSelected),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBaseContainer({
    required VoidCallback onTap,
    required bool isSelected,
    required Widget child,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
            width: isSelected ? 2.r : 1.r,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: child,
      ),
    );
  }

  TextStyle _getOptionStyle(bool isSelected) {
    return AppStyles.medium14poppins.copyWith(
      color: AppColors.textColorPrimary,
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    QuestionsSuccess state,
  ) {
    bool isLastStep = state.currentStep == state.categories.length - 1;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (state.currentStep > 0) ...[
                Expanded(
                  child: SizedBox(
                    height: 52.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        context.read<QuestionsCubit>().previousStep();
                      },
                      child: Text(
                        'Back',
                        style: AppStyles.medium16poppins.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
              ],
              // Expanded(
              //   child: SizedBox(
              //     height: 52.h,
              //     child: CustomElevatedButton(
              //       text: isLastStep ? 'Done' : 'Continue',
              //       backgroundColor: AppColors.primary,
              //       textColor: Colors.white,
              //       borderRadius: 12.r,
              //       onPressed: () {
              //         if (isLastStep) {
              //           // Submit logic here
              //           context.read<QuestionsCubit>().submitAnswers();
              //         } else {
              //           _pageController.nextPage(
              //             duration: const Duration(milliseconds: 300),
              //             curve: Curves.easeInOut,
              //           );
              //           context.read<QuestionsCubit>().nextStep();
              //         }
              //       },
              //     ),
              //   ),
              // ),
              Expanded(
                child: SizedBox(
                  height: 52.h,
                  child: CustomElevatedButton(
                    text: isLastStep ? 'Done' : 'Continue',
                    backgroundColor: AppColors.primary,
                    textColor: Colors.white,
                    borderRadius: 12,
                    onPressed: () {
                      final cubit = context.read<QuestionsCubit>();

                      // 🛑 VALIDATION CHECK: Prevent moving forward if any question is missing an answer
                      if (!cubit.isCurrentStepValid()) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.error_outline_rounded, color: Colors.white, size: 20.r),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    'Please answer all questions on this page to continue.',
                                    style: AppStyles.medium16poppins.copyWith(color: Colors.white, fontSize: 14.sp),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: const Color(0xFFEF4444), // Crimson error accent red
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            margin: EdgeInsets.all(16.r),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        return; // Stop execution here!
                      }

                      // If valid, proceed normally
                      if (isLastStep) {
                        cubit.submitAnswers();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        cubit.nextStep();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Save as Draft',
              style: AppStyles.medium16poppins.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}