enum IDType { residentId, nationalId }

class AgentRegistrationState {
  String? dob;
  IDType? idType;
  AgentRegistrationState({this.dob, this.idType});

  AgentRegistrationState copyWith({String? dob, IDType? idType}) {
    return AgentRegistrationState(
        dob: dob ?? this.dob, idType: idType ?? this.idType);
  }
}
