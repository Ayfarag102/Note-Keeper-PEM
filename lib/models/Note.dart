import 'dart:convert';

import 'package:flutter/material.dart';

class Note {
  int _id;
  String _title;
  String _date;
  int _priority;
  int _reaction;
  String _description;
  Note(this._title, this._date, this._priority,
      [this._reaction, this._description]);

  Note.withId(this._id, this._title, this._date, this._priority,
      [this._reaction, this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  int get priority => _priority;
  int get reaction => _reaction;

  String get date => _date;

  set title(String newTitle) =>
      newTitle.length <= 255 ? this._title = newTitle : this._title = "N/A";

  set description(String newDescr) => newDescr.length <= 255
      ? this._description = newDescr
      : this._description = "N/A";

  set priority(int newPrior) =>
      newPrior == 1 || newPrior == 2 || newPrior == 3 || newPrior == 4
          ? this._priority = newPrior
          : this._priority = 0;
  set reaction(int newReact) => newReact == 1 ||
          newReact == 2 ||
          newReact == 3 ||
          newReact == 4 ||
          newReact == 5 ||
          newReact == 6 ||
          newReact == 7
      ? this._reaction = newReact
      : this._reaction = 0;

  set date(String newDate) => this._date = newDate;

  Note copyWith({
    int id,
    String title,
    String date,
    int priority,
    int reaction,
    String description,
  }) {
    if (id != null) {
      return Note.withId(
        id ?? this.id,
        title ?? this.title,
        date ?? this.date,
        priority ?? this.priority,
        reaction ?? this.reaction,
        description ?? this.description,
      );
    }
    return Note(
      title ?? this.title,
      date ?? this.date,
      priority ?? this.priority,
      reaction ?? this.reaction,
      description ?? this.description,
    );
  }

  Note merge(Note model) {
    return Note(
      model.title ?? this.title,
      model.date ?? this.date,
      model.priority ?? this.priority,
      model.reaction ?? this.reaction,
      model.description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    if (_id != null) {
      return {
        'id': id,
        'title': title,
        'date': date,
        'priority': priority,
        'reaction': reaction,
        'description': description,
      };
    }
    return {
      'title': title,
      'date': date,
      'priority': priority,
      'reaction': reaction,
      'description': description,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    if (map['id'] != null) {
      return Note.withId(
        map['id'],
        map['title'],
        map['date'],
        map['priority'],
        map['reaction'],
        map['description'],
      );
    }
    return Note(
      map['title'],
      map['date'],
      map['priority'],
      map['reaction'],
      map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() {
    if (this._id != null) {
      return 'Note.withId(id: $id, title: $title, date: $date, priority: $priority, reaction: $reaction, description: $description)';
    }
    return 'Note(title: $title, date: $date, priority: $priority, reaction: $reaction, description: $description)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Note &&
        o.id == id &&
        o.title == title &&
        o.date == date &&
        o.priority == priority &&
        o.reaction == reaction &&
        o.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        date.hashCode ^
        priority.hashCode ^
        reaction.hashCode ^
        description.hashCode;
  }
}
