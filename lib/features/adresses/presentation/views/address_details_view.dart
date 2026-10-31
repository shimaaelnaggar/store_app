import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_text_styles.dart';
import 'package:store/core/helper/show_message.dart';
import 'package:store/core/widgets/app_top_bar.dart';
import 'package:store/core/widgets/custom_text_field.dart';

import '../../domain/entites/addresses.dart';
import '../bloc/addresses_bloc.dart';
import '../bloc/addresses_event.dart';
import '../bloc/addresses_state.dart';

class AddressDetailsView extends StatefulWidget {
  final LatLng selectedLocation;

  const AddressDetailsView({
    Key? key,
    required this.selectedLocation,
  }) : super(key: key);

  @override
  State<AddressDetailsView> createState() => _AddressDetailsViewState();
}

class _AddressDetailsViewState extends State<AddressDetailsView> {
  final _formKey = GlobalKey<FormState>();

  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  String _addressType = 'Home';

  @override
  void dispose() {
    _stateController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _apartmentController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressesBloc, AddressesState>(
      listener: (context, state) {
        if (state is AddressesSuccessState && state.addressesList.isNotEmpty) {
          showMessage(
            context: context,
            message: 'Address added successfully',
            backgroundColor: AppColors.successColor,
          );

          context.pop(state.addressesList.first);
        } else if (state is AddressesFailureState) {
          showMessage(
              context: context,
              message: state.errorMessage,
              backgroundColor: AppColors.errorColor);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              const AppTopBar(title: 'Address Details'),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLocationCard(),
                        SizedBox(height: 24.h),
                        _buildSectionTitle('Address Label'),
                        SizedBox(height: 12.h),
                        _buildAddressTypeSelector(),
                        SizedBox(height: 24.h),
                        _buildSectionTitle('Address Information'),
                        SizedBox(height: 12.h),
                        _buildField(
                          label: 'Governorate',
                          hint: 'Enter governorate',
                          controller: _stateController,
                          validator: _requiredValidator,
                        ),
                        _buildField(
                          label: 'City / Area',
                          hint: 'Enter city or area',
                          controller: _cityController,
                          validator: _requiredValidator,
                        ),
                        _buildField(
                          label: 'Street',
                          hint: 'Street name',
                          controller: _streetController,
                          validator: _requiredValidator,
                        ),
                        _buildField(
                          label: 'Building / Apartment',
                          hint: 'Building or apartment details',
                          controller: _apartmentController,
                          validator: _requiredValidator,
                        ),
                        _buildField(
                          label: 'Phone Number',
                          hint: 'Enter phone number',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            final requiredError = _requiredValidator(value);
                            if (requiredError != null) return requiredError;

                            if (value!.trim().length < 7) {
                              return 'Enter a valid phone number';
                            }

                            return null;
                          },
                        ),
                        _buildField(
                          label: 'Delivery Notes (Optional)',
                          hint: 'Nearby landmark or delivery instructions',
                          controller: _notesController,
                          maxLines: 3,
                          isOptional: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.inputBorderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withAlpha(100),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: AppColors.primaryColor,
              size: 24.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location Selected',
                  style: AppTextStyles.bodyLarge,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${widget.selectedLocation.latitude.toStringAsFixed(5)}, '
                  '${widget.selectedLocation.longitude.toStringAsFixed(5)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Change',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.bodyLarge.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildAddressTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildAddressTypeChip(
            label: 'Home',
            icon: Icons.home_outlined,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _buildAddressTypeChip(
            label: 'Work',
            icon: Icons.work_outline,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _buildAddressTypeChip(
            label: 'Other',
            icon: Icons.location_on_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressTypeChip({
    required String label,
    required IconData icon,
  }) {
    final isSelected = _addressType == label;

    return InkWell(
      onTap: () {
        setState(() {
          _addressType = label;
        });
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withAlpha(100)
              : AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.inputBorderColor,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 22.r,
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.textSecondaryColor,
            ),
            SizedBox(height: 5.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.textPrimaryColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool isOptional = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              isOptional ? label : '$label *',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CustomTextField(
            controller: controller,
            hintText: hint,
            inputType: keyboardType,
            validator: isOptional ? null : validator,
            textInputAction: TextInputAction.next,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 14.h,
            ),
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Builder(
      builder: (buttonContext) {
        return Container(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
          decoration: const BoxDecoration(
            color: AppColors.surfaceColor,
            border: Border(
              top: BorderSide(
                color: AppColors.inputBorderColor,
              ),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton.icon(
              onPressed: () {
                FocusScope.of(buttonContext).unfocus();

                if (!_formKey.currentState!.validate()) return;

                final address = Addresses(
                  state: _stateController.text.trim(),
                  city: _cityController.text.trim(),
                  street: _streetController.text.trim(),
                  apartment: _apartmentController.text.trim(),
                  phoneNumber: _phoneController.text.trim(),
                  notes: _notesController.text.trim(),
                );

                buttonContext.read<AddressesBloc>().add(
                      AddAddressesEvent(address: address),
                    );
              },
              icon: const Icon(Icons.check_circle_outline),
              label: Text(
                'Save Address',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
