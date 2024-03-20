import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/helpers/date_helper/date_helper.dart';
import 'package:laundryday/screens/more/help/agent_registration/notfiers/agent_registration_state.dart';

class AgentRegistrationNotifier extends StateNotifier<AgentRegistrationState> {
  AgentRegistrationNotifier() : super(AgentRegistrationState());
  final dobController = TextEditingController();

  pickDob({DateTime? dateTime}) {
    if (dateTime == null) {
      state = state.copyWith(dob: null);
    } else {
      state = state.copyWith(dob: DateHelper.formatDate(dateTime.toString()));
    }
  }

  setDob({required TextEditingController dobController}) {
    
    if(state.dob!=null)
    {
    dobController.text = state.dob!;}
  }



  void setIDType(IDType type) {
    state = state.copyWith(idType: type);
  }



 
}
