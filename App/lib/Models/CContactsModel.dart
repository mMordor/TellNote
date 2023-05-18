class ContactsModel {
  List<Contacts>? contacts;

  ContactsModel({this.contacts});

  ContactsModel.fromJson(Map<String, dynamic> json) {
    if (json['Contacts'] != null) {
      contacts = <Contacts>[];
      json['Contacts'].forEach((v) {
        contacts!.add(Contacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contacts != null) {
      data['Contacts'] = contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
  int? contactID;
  String? name;
  String? lastName;
  String? number;
  String? relation;

  Contacts(
      {this.contactID, this.name, this.lastName, this.number, this.relation});

  Contacts.fromJson(Map<String, dynamic> json) {
    contactID = json['ContactID'];
    name = json['Name'];
    if(json['LastName'] == "NULL"){
      lastName = "";
    }else{
      lastName = json['LastName'];
    }    
    number = json['Number'];
    relation = json['Relation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ContactID'] = this.contactID;
    data['Name'] = this.name;
    data['LastName'] = this.lastName;
    data['Number'] = this.number;
    data['Relation'] = this.relation;
    return data;
  }
}