import 'package:eshoes_clean_arch/core/constant/images.dart';
import 'package:eshoes_clean_arch/data/models/user/delivery_info_model.dart';
import 'package:eshoes_clean_arch/presentation/blocs/delivery_info/delivery_info_action/delivery_info_action_cubit.dart';
import 'package:eshoes_clean_arch/presentation/blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:eshoes_clean_arch/presentation/widgets/delivery_info_card.dart';
import 'package:eshoes_clean_arch/presentation/widgets/input_form_button.dart';
import 'package:eshoes_clean_arch/presentation/widgets/input_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../domain/entities/user/delivery_info.dart';

class DeliveryInfoView extends StatefulWidget {
  const DeliveryInfoView({Key? key}) : super(key: key);

  @override
  State<DeliveryInfoView> createState() => _DeliveryInfoViewState();
}

class _DeliveryInfoViewState extends State<DeliveryInfoView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryInfoActionCubit, DeliveryInfoActionState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is DeliveryInfoActionLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is DeliveryInfoSelectActionSuccess) {
          context
              .read<DeliveryInfoFetchCubit>()
              .selectDeliveryInfo(state.deliveryInfo);
        } else if (state is DeliveryInfoActionFail) {
          EasyLoading.showError("Error");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Delivery Details"),
        ),
        body: BlocBuilder<DeliveryInfoFetchCubit, DeliveryInfoFetchState>(
          builder: (context, state) {
            if (state is! DeliveryInfoFetchLoading &&
                state.deliveryInformation.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kEmptyDeliveryInfo),
                  const Text("Delviery Information are Empty"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  )
                ],
              );
            }
            return ListView.builder(
              itemCount: (state is! DeliveryInfoFetchLoading &&
                      state.deliveryInformation.isEmpty)
                  ? 5
                  : state.deliveryInformation.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) =>
                  (state is DeliveryInfoFetchLoading &&
                          state.deliveryInformation.isEmpty)
                      ? const DeliveryInfoCard()
                      : DeliveryInfoCard(
                          deliveryInformation: state.deliveryInformation[index],
                          isSelected: state.deliveryInformation[index] ==
                              state.selectedDeliveryInformation,
                        ),
            );
          },
        ),
        floatingActionButton: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  builder: (BuildContext context) {
                    return const DeliveryInfoForm();
                  },
                );
              },
              tooltip: 'Increment',
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeliveryInfoForm extends StatefulWidget {
  const DeliveryInfoForm({
    super.key,
    this.deliveryInfo,
  });
  final DeliveryInfo? deliveryInfo;

  @override
  State<DeliveryInfoForm> createState() => _DeliveryInfoFormState();
}

class _DeliveryInfoFormState extends State<DeliveryInfoForm> {
  String? id;
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController addressLineOne = TextEditingController();
  final TextEditingController addressLineTwo = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController contactNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.deliveryInfo != null) {
      id = widget.deliveryInfo!.id;
      firstName.text = widget.deliveryInfo!.firstName;
      lastName.text = widget.deliveryInfo!.lastName;
      addressLineOne.text = widget.deliveryInfo!.addressLineOne;
      addressLineTwo.text = widget.deliveryInfo!.addressLineTwo;
      city.text = widget.deliveryInfo!.city;
      zipCode.text = widget.deliveryInfo!.zipCode;
      contactNumber.text = widget.deliveryInfo!.contactNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryInfoActionCubit, DeliveryInfoActionState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is DeliveryInfoActionLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is DeliveryInfoAddActionSuccess) {
          Navigator.of(context).pop();
          context
              .read<DeliveryInfoFetchCubit>()
              .addDeliveryInfo(state.deliveryInfo);
          EasyLoading.showSuccess("Delivery info Successfully added !");
        } else if (state is DeliveryInfoEditActionSuccess) {
          Navigator.of(context).pop();
          context
              .read<DeliveryInfoFetchCubit>()
              .editDeliveryInfo(state.deliveryInfo);
          EasyLoading.showSuccess("Delivery Info Successfully Edit !");
        } else if (state is DeliveryInfoActionFail) {
          EasyLoading.showError("Error");
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  const SizedBox(
                    height: 24,
                  ),
                  InputTextFormField(
                    textEditingController: firstName,
                    hint: 'First Name',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field can\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InputTextFormField(
                    textEditingController: lastName,
                    hint: 'Last Name',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field can\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFormField(
                    textEditingController: addressLineOne,
                    hint: 'Address Line One',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field can\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFormField(
                    textEditingController: addressLineTwo,
                    hint: 'Address Line Two',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field can\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFormField(
                    textEditingController: city,
                    hint: 'City',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field can\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFormField(
                    textEditingController: zipCode,
                    hint: 'Zip Code',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field can\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFormField(
                    textEditingController: contactNumber,
                    hint: 'Contact Number',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field can\'t be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  InputFormButton(
                    color: Colors.black87,
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.deliveryInfo == null) {
                          context
                              .read<DeliveryInfoActionCubit>()
                              .addDeliveryInfo(
                                DeliveryInfoModel(
                                  id: '',
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  addressLineOne: addressLineOne.text,
                                  addressLineTwo: addressLineTwo.text,
                                  city: city.text,
                                  zipCode: zipCode.text,
                                  contactNumber: contactNumber.text,
                                ),
                              );
                        } else {
                          context
                              .read<DeliveryInfoActionCubit>()
                              .editDeliveryInfo(
                                DeliveryInfoModel(
                                  id: id!,
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  addressLineOne: addressLineOne.text,
                                  addressLineTwo: addressLineTwo.text,
                                  city: city.text,
                                  zipCode: zipCode.text,
                                  contactNumber: contactNumber.text,
                                ),
                              );
                        }
                      }
                    },
                    titleText: widget.deliveryInfo == null ? 'Save' : 'Update',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InputFormButton(
                    color: Colors.black87,
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    titleText: 'Cancel',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
