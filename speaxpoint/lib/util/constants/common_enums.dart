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

enum ComingSessionsStatus {
  Completed,
  Pending,
  Coming,
}

enum LisrOfRolesPlayers {
  Speaker,
  Ah_Counter,
  Timer,
  Grammarian,
  Topicmaster,
  Speach_Evaluator,
  General_Evaluator,
  Toastmaster,
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

enum AnnouncementStatus {
  Posted,
  NotPosted,
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

enum ApplicantStatus{
  Accepted,
  Pending
}