
//true if current speaker is the same speech evaluator, else false
bool checkIfCurrentSpeakerIsTheSameAsSpeechEvaluator({
  required bool isAnAppGuest,
  required bool currentSelectSpeakerIsGuest,
  String? selectedSpeakerToastmasterId,
  String? selectedSpeakerGuestInvitationCode,
  String? loggedUserToastmasterId,
  String? loggedUserGuestInvitationCode,
}) {
  //both are guest app users
  if (isAnAppGuest == true && currentSelectSpeakerIsGuest == true) {
    if (selectedSpeakerGuestInvitationCode == loggedUserGuestInvitationCode) {
      return true;
    } else {
      return false;
    }

    //both are not guest app users
  } else if (isAnAppGuest == false && currentSelectSpeakerIsGuest == false) {
    if (loggedUserToastmasterId == selectedSpeakerToastmasterId) {
      return true;
    } else {
      return false;
    }
  } else {
    //return false because there is no need to do more check
    //as it's enough for us to know that the selected speaker and the current
    //speech evalator are different types of app users
    return false;
  }
}
