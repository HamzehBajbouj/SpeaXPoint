import 'allocated_role_player.dart';

class MeetingAgenda {
  String? timeSequence;
  String? agendaTitle;
  //agendaCardOrder will act as well as a unique id since we will have list of agenda
  //each agenda are stored in a different firebase doucment
  int? agendaCardOrder;
  /*
  the idea is like this , first fetch the data from the agenda subcollection and store it listA
  then fetch the data from allocatedRolePlayer subcollection and store it in ListB
  and using the the (roleName and roleOrderPlace) loop listA and for every element that matches the both properties 
  in listA and B get the data from ListB and assign it to this property

  it's many to one listA has many elements attached to ListB relationship.
  */
  AllocatedRolePlayer? allocatedRolePlayerDetails;

  //two two properties will act like unique keys to find the role player details
  // in the allocatedRolePlayerCollections
  String? roleName;
  //the roleOrderPlace is meant to differenitate between if he is first speaks , or second speaker..etc
  int? roleOrderPlace;

  MeetingAgenda({
    this.agendaCardOrder,
    this.roleName,
    this.roleOrderPlace,
    this.timeSequence,
    this.agendaTitle,
  });

  MeetingAgenda.fromJson(Map<String, dynamic> agendaJson)
      : this(
          timeSequence: agendaJson['timeSequence'],
          roleName: agendaJson['roleName'],
          roleOrderPlace: agendaJson['roleOrderPlace'],
          agendaCardOrder: agendaJson['agendaCardOrder'],
          agendaTitle: agendaJson['agendaTitle'],
        );

  Map<String, dynamic> toJson() => {
        'timeSequence': timeSequence,
        'roleName': roleName,
        'roleOrderPlace': roleOrderPlace,
        'agendaCardOrder': agendaCardOrder,
        'agendaTitle': agendaTitle,
      };
}
