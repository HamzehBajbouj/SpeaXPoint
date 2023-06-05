enum Gender { male, female, noCurrentInput }

enum ToastmasterRoles {
  Presidnet,
  Member,
  Vice_President_Education,
  Vice_President_Membership,
  Vice_President_Public_Relations,
  Treasurer,
  Secretary,
  Sergeant_At_Arms,
}

enum AppRoles {
  Toastmaster,
  ClubPresident,
  Guest,
}

enum ComingSessionsStatus { Completed, Pending, Coming, Ongoing }

enum LisrOfRolesPlayers {
  Speaker,
  Ah_Counter,
  Timer,
  Grammarian,
  // Topicmaster,
  Speach_Evaluator,
  General_Evaluator,
  //is the Toastmaster of the evening he will be directed to the waiting screen, since managing the role players is the
  //VPE responsibility
  Toastmaster_OTE,
  MeetingVisitor,
}

enum AllocatedRolePlayerType {
  ClubMember,
  Guest,
  OtherClubMember,
  Volunteer,
}

enum AnnouncementType {
  ChapterMeetingAnnouncement,
  VolunteersAnnouncement,
}

enum AnnouncementLevel {
  Public,
  Private,
}

//these are used for slots status in the firestore
enum VolunteerSlotStatus {
  NoApplication,
  PendingApplication,
  AcceptedApplication,
}

enum AppVolunteerSlotStatus {
  Announced,
  UnAnnounced,
}

enum ApplicantStatus { Accepted, Pending }

enum OnlineSessionSpeakerTurn{
  CurrentlySelected,
  WasSelected,
  NotSelected,
}

enum  TypesOfTimeFillers{
  LongPauses,
  RepeatedWords,
  OutOfContext,
  FilledPauses,
}