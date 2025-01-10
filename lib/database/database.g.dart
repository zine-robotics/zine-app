// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RoomsTableTable extends RoomsTable
    with TableInfo<$RoomsTableTable, Room> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dpUrlMeta = const VerificationMeta('dpUrl');
  @override
  late final GeneratedColumn<String> dpUrl = GeneratedColumn<String>(
      'dp_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
      'timestamp', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _lastMessageTimestampMeta =
      const VerificationMeta('lastMessageTimestamp');
  @override
  late final GeneratedColumn<int> lastMessageTimestamp = GeneratedColumn<int>(
      'last_message_timestamp', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _unreadMessagesMeta =
      const VerificationMeta('unreadMessages');
  @override
  late final GeneratedColumn<int> unreadMessages = GeneratedColumn<int>(
      'unread_messages', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userLastSeenMeta =
      const VerificationMeta('userLastSeen');
  @override
  late final GeneratedColumn<int> userLastSeen = GeneratedColumn<int>(
      'user_last_seen', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        type,
        dpUrl,
        timestamp,
        lastMessageTimestamp,
        unreadMessages,
        userLastSeen,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rooms_table';
  @override
  VerificationContext validateIntegrity(Insertable<Room> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('dp_url')) {
      context.handle(
          _dpUrlMeta, dpUrl.isAcceptableOrUnknown(data['dp_url']!, _dpUrlMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('last_message_timestamp')) {
      context.handle(
          _lastMessageTimestampMeta,
          lastMessageTimestamp.isAcceptableOrUnknown(
              data['last_message_timestamp']!, _lastMessageTimestampMeta));
    }
    if (data.containsKey('unread_messages')) {
      context.handle(
          _unreadMessagesMeta,
          unreadMessages.isAcceptableOrUnknown(
              data['unread_messages']!, _unreadMessagesMeta));
    }
    if (data.containsKey('user_last_seen')) {
      context.handle(
          _userLastSeenMeta,
          userLastSeen.isAcceptableOrUnknown(
              data['user_last_seen']!, _userLastSeenMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Room map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Room(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      dpUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dp_url']),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp']),
      lastMessageTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}last_message_timestamp']),
      unreadMessages: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unread_messages']),
      userLastSeen: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_last_seen']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $RoomsTableTable createAlias(String alias) {
    return $RoomsTableTable(attachedDatabase, alias);
  }
}

class Room extends DataClass implements Insertable<Room> {
  final int id;
  final String? name;
  final String? description;
  final String? type;
  final String? dpUrl;
  final int? timestamp;
  final int? lastMessageTimestamp;
  final int? unreadMessages;
  final int? userLastSeen;
  final bool isSynced;
  const Room(
      {required this.id,
      this.name,
      this.description,
      this.type,
      this.dpUrl,
      this.timestamp,
      this.lastMessageTimestamp,
      this.unreadMessages,
      this.userLastSeen,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || dpUrl != null) {
      map['dp_url'] = Variable<String>(dpUrl);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<int>(timestamp);
    }
    if (!nullToAbsent || lastMessageTimestamp != null) {
      map['last_message_timestamp'] = Variable<int>(lastMessageTimestamp);
    }
    if (!nullToAbsent || unreadMessages != null) {
      map['unread_messages'] = Variable<int>(unreadMessages);
    }
    if (!nullToAbsent || userLastSeen != null) {
      map['user_last_seen'] = Variable<int>(userLastSeen);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  RoomsTableCompanion toCompanion(bool nullToAbsent) {
    return RoomsTableCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      dpUrl:
          dpUrl == null && nullToAbsent ? const Value.absent() : Value(dpUrl),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
      lastMessageTimestamp: lastMessageTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageTimestamp),
      unreadMessages: unreadMessages == null && nullToAbsent
          ? const Value.absent()
          : Value(unreadMessages),
      userLastSeen: userLastSeen == null && nullToAbsent
          ? const Value.absent()
          : Value(userLastSeen),
      isSynced: Value(isSynced),
    );
  }

  factory Room.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Room(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      type: serializer.fromJson<String?>(json['type']),
      dpUrl: serializer.fromJson<String?>(json['dpUrl']),
      timestamp: serializer.fromJson<int?>(json['timestamp']),
      lastMessageTimestamp:
          serializer.fromJson<int?>(json['lastMessageTimestamp']),
      unreadMessages: serializer.fromJson<int?>(json['unreadMessages']),
      userLastSeen: serializer.fromJson<int?>(json['userLastSeen']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<String?>(type),
      'dpUrl': serializer.toJson<String?>(dpUrl),
      'timestamp': serializer.toJson<int?>(timestamp),
      'lastMessageTimestamp': serializer.toJson<int?>(lastMessageTimestamp),
      'unreadMessages': serializer.toJson<int?>(unreadMessages),
      'userLastSeen': serializer.toJson<int?>(userLastSeen),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  Room copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<String?> dpUrl = const Value.absent(),
          Value<int?> timestamp = const Value.absent(),
          Value<int?> lastMessageTimestamp = const Value.absent(),
          Value<int?> unreadMessages = const Value.absent(),
          Value<int?> userLastSeen = const Value.absent(),
          bool? isSynced}) =>
      Room(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        description: description.present ? description.value : this.description,
        type: type.present ? type.value : this.type,
        dpUrl: dpUrl.present ? dpUrl.value : this.dpUrl,
        timestamp: timestamp.present ? timestamp.value : this.timestamp,
        lastMessageTimestamp: lastMessageTimestamp.present
            ? lastMessageTimestamp.value
            : this.lastMessageTimestamp,
        unreadMessages:
            unreadMessages.present ? unreadMessages.value : this.unreadMessages,
        userLastSeen:
            userLastSeen.present ? userLastSeen.value : this.userLastSeen,
        isSynced: isSynced ?? this.isSynced,
      );
  Room copyWithCompanion(RoomsTableCompanion data) {
    return Room(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      type: data.type.present ? data.type.value : this.type,
      dpUrl: data.dpUrl.present ? data.dpUrl.value : this.dpUrl,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      lastMessageTimestamp: data.lastMessageTimestamp.present
          ? data.lastMessageTimestamp.value
          : this.lastMessageTimestamp,
      unreadMessages: data.unreadMessages.present
          ? data.unreadMessages.value
          : this.unreadMessages,
      userLastSeen: data.userLastSeen.present
          ? data.userLastSeen.value
          : this.userLastSeen,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Room(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('dpUrl: $dpUrl, ')
          ..write('timestamp: $timestamp, ')
          ..write('lastMessageTimestamp: $lastMessageTimestamp, ')
          ..write('unreadMessages: $unreadMessages, ')
          ..write('userLastSeen: $userLastSeen, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, type, dpUrl, timestamp,
      lastMessageTimestamp, unreadMessages, userLastSeen, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Room &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.type == this.type &&
          other.dpUrl == this.dpUrl &&
          other.timestamp == this.timestamp &&
          other.lastMessageTimestamp == this.lastMessageTimestamp &&
          other.unreadMessages == this.unreadMessages &&
          other.userLastSeen == this.userLastSeen &&
          other.isSynced == this.isSynced);
}

class RoomsTableCompanion extends UpdateCompanion<Room> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String?> description;
  final Value<String?> type;
  final Value<String?> dpUrl;
  final Value<int?> timestamp;
  final Value<int?> lastMessageTimestamp;
  final Value<int?> unreadMessages;
  final Value<int?> userLastSeen;
  final Value<bool> isSynced;
  const RoomsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.dpUrl = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.lastMessageTimestamp = const Value.absent(),
    this.unreadMessages = const Value.absent(),
    this.userLastSeen = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  RoomsTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.dpUrl = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.lastMessageTimestamp = const Value.absent(),
    this.unreadMessages = const Value.absent(),
    this.userLastSeen = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  static Insertable<Room> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? type,
    Expression<String>? dpUrl,
    Expression<int>? timestamp,
    Expression<int>? lastMessageTimestamp,
    Expression<int>? unreadMessages,
    Expression<int>? userLastSeen,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (dpUrl != null) 'dp_url': dpUrl,
      if (timestamp != null) 'timestamp': timestamp,
      if (lastMessageTimestamp != null)
        'last_message_timestamp': lastMessageTimestamp,
      if (unreadMessages != null) 'unread_messages': unreadMessages,
      if (userLastSeen != null) 'user_last_seen': userLastSeen,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  RoomsTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String?>? description,
      Value<String?>? type,
      Value<String?>? dpUrl,
      Value<int?>? timestamp,
      Value<int?>? lastMessageTimestamp,
      Value<int?>? unreadMessages,
      Value<int?>? userLastSeen,
      Value<bool>? isSynced}) {
    return RoomsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      dpUrl: dpUrl ?? this.dpUrl,
      timestamp: timestamp ?? this.timestamp,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      unreadMessages: unreadMessages ?? this.unreadMessages,
      userLastSeen: userLastSeen ?? this.userLastSeen,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (dpUrl.present) {
      map['dp_url'] = Variable<String>(dpUrl.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (lastMessageTimestamp.present) {
      map['last_message_timestamp'] = Variable<int>(lastMessageTimestamp.value);
    }
    if (unreadMessages.present) {
      map['unread_messages'] = Variable<int>(unreadMessages.value);
    }
    if (userLastSeen.present) {
      map['user_last_seen'] = Variable<int>(userLastSeen.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('dpUrl: $dpUrl, ')
          ..write('timestamp: $timestamp, ')
          ..write('lastMessageTimestamp: $lastMessageTimestamp, ')
          ..write('unreadMessages: $unreadMessages, ')
          ..write('userLastSeen: $userLastSeen, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $FileTableTable extends FileTable
    with TableInfo<$FileTableTable, FileDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, description, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'file_table';
  @override
  VerificationContext validateIntegrity(Insertable<FileDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FileDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $FileTableTable createAlias(String alias) {
    return $FileTableTable(attachedDatabase, alias);
  }
}

class FileDB extends DataClass implements Insertable<FileDB> {
  final int? id;
  final String title;
  final String? description;
  final String name;
  const FileDB(
      {this.id, required this.title, this.description, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['name'] = Variable<String>(name);
    return map;
  }

  FileTableCompanion toCompanion(bool nullToAbsent) {
    return FileTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      name: Value(name),
    );
  }

  factory FileDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileDB(
      id: serializer.fromJson<int?>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'name': serializer.toJson<String>(name),
    };
  }

  FileDB copyWith(
          {Value<int?> id = const Value.absent(),
          String? title,
          Value<String?> description = const Value.absent(),
          String? name}) =>
      FileDB(
        id: id.present ? id.value : this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        name: name ?? this.name,
      );
  FileDB copyWithCompanion(FileTableCompanion data) {
    return FileDB(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FileDB(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileDB &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.name == this.name);
}

class FileTableCompanion extends UpdateCompanion<FileDB> {
  final Value<int?> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> name;
  final Value<int> rowid;
  const FileTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FileTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required String name,
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        name = Value(name);
  static Insertable<FileDB> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FileTableCompanion copyWith(
      {Value<int?>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String>? name,
      Value<int>? rowid}) {
    return FileTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PollTableTable extends PollTable
    with TableInfo<$PollTableTable, PollDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PollTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastVotedMeta =
      const VerificationMeta('lastVoted');
  @override
  late final GeneratedColumn<int> lastVoted = GeneratedColumn<int>(
      'last_voted', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, title, description, lastVoted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'poll_table';
  @override
  VerificationContext validateIntegrity(Insertable<PollDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('last_voted')) {
      context.handle(_lastVotedMeta,
          lastVoted.isAcceptableOrUnknown(data['last_voted']!, _lastVotedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PollDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PollDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      lastVoted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_voted']),
    );
  }

  @override
  $PollTableTable createAlias(String alias) {
    return $PollTableTable(attachedDatabase, alias);
  }
}

class PollDB extends DataClass implements Insertable<PollDB> {
  final int id;
  final String title;
  final String? description;
  final int? lastVoted;
  const PollDB(
      {required this.id,
      required this.title,
      this.description,
      this.lastVoted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || lastVoted != null) {
      map['last_voted'] = Variable<int>(lastVoted);
    }
    return map;
  }

  PollTableCompanion toCompanion(bool nullToAbsent) {
    return PollTableCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      lastVoted: lastVoted == null && nullToAbsent
          ? const Value.absent()
          : Value(lastVoted),
    );
  }

  factory PollDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PollDB(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      lastVoted: serializer.fromJson<int?>(json['lastVoted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'lastVoted': serializer.toJson<int?>(lastVoted),
    };
  }

  PollDB copyWith(
          {int? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<int?> lastVoted = const Value.absent()}) =>
      PollDB(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        lastVoted: lastVoted.present ? lastVoted.value : this.lastVoted,
      );
  PollDB copyWithCompanion(PollTableCompanion data) {
    return PollDB(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      lastVoted: data.lastVoted.present ? data.lastVoted.value : this.lastVoted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PollDB(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lastVoted: $lastVoted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, lastVoted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PollDB &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.lastVoted == this.lastVoted);
}

class PollTableCompanion extends UpdateCompanion<PollDB> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int?> lastVoted;
  const PollTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.lastVoted = const Value.absent(),
  });
  PollTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.lastVoted = const Value.absent(),
  }) : title = Value(title);
  static Insertable<PollDB> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? lastVoted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (lastVoted != null) 'last_voted': lastVoted,
    });
  }

  PollTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<int?>? lastVoted}) {
    return PollTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lastVoted: lastVoted ?? this.lastVoted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lastVoted.present) {
      map['last_voted'] = Variable<int>(lastVoted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PollTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lastVoted: $lastVoted')
          ..write(')'))
        .toString();
  }
}

class $RoomMemberTableTable extends RoomMemberTable
    with TableInfo<$RoomMemberTableTable, RoomMemberDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomMemberTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant('Anonymous'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _registeredMeta =
      const VerificationMeta('registered');
  @override
  late final GeneratedColumn<bool> registered = GeneratedColumn<bool>(
      'registered', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("registered" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _dpUrlMeta = const VerificationMeta('dpUrl');
  @override
  late final GeneratedColumn<String> dpUrl = GeneratedColumn<String>(
      'dp_url', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(''));
  static const VerificationMeta _emailVerifiedMeta =
      const VerificationMeta('emailVerified');
  @override
  late final GeneratedColumn<bool> emailVerified = GeneratedColumn<bool>(
      'email_verified', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("email_verified" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, role, registered, dpUrl, emailVerified];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'room_member_table';
  @override
  VerificationContext validateIntegrity(Insertable<RoomMemberDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('registered')) {
      context.handle(
          _registeredMeta,
          registered.isAcceptableOrUnknown(
              data['registered']!, _registeredMeta));
    }
    if (data.containsKey('dp_url')) {
      context.handle(
          _dpUrlMeta, dpUrl.isAcceptableOrUnknown(data['dp_url']!, _dpUrlMeta));
    }
    if (data.containsKey('email_verified')) {
      context.handle(
          _emailVerifiedMeta,
          emailVerified.isAcceptableOrUnknown(
              data['email_verified']!, _emailVerifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {email};
  @override
  RoomMemberDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoomMemberDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role']),
      registered: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}registered'])!,
      dpUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dp_url'])!,
      emailVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}email_verified']),
    );
  }

  @override
  $RoomMemberTableTable createAlias(String alias) {
    return $RoomMemberTableTable(attachedDatabase, alias);
  }
}

class RoomMemberDB extends DataClass implements Insertable<RoomMemberDB> {
  final int? id;
  final String name;
  final String email;
  final String? role;
  final bool registered;
  final String dpUrl;
  final bool? emailVerified;
  const RoomMemberDB(
      {this.id,
      required this.name,
      required this.email,
      this.role,
      required this.registered,
      required this.dpUrl,
      this.emailVerified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    map['registered'] = Variable<bool>(registered);
    map['dp_url'] = Variable<String>(dpUrl);
    if (!nullToAbsent || emailVerified != null) {
      map['email_verified'] = Variable<bool>(emailVerified);
    }
    return map;
  }

  RoomMemberTableCompanion toCompanion(bool nullToAbsent) {
    return RoomMemberTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      email: Value(email),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      registered: Value(registered),
      dpUrl: Value(dpUrl),
      emailVerified: emailVerified == null && nullToAbsent
          ? const Value.absent()
          : Value(emailVerified),
    );
  }

  factory RoomMemberDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoomMemberDB(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      role: serializer.fromJson<String?>(json['role']),
      registered: serializer.fromJson<bool>(json['registered']),
      dpUrl: serializer.fromJson<String>(json['dpUrl']),
      emailVerified: serializer.fromJson<bool?>(json['emailVerified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'role': serializer.toJson<String?>(role),
      'registered': serializer.toJson<bool>(registered),
      'dpUrl': serializer.toJson<String>(dpUrl),
      'emailVerified': serializer.toJson<bool?>(emailVerified),
    };
  }

  RoomMemberDB copyWith(
          {Value<int?> id = const Value.absent(),
          String? name,
          String? email,
          Value<String?> role = const Value.absent(),
          bool? registered,
          String? dpUrl,
          Value<bool?> emailVerified = const Value.absent()}) =>
      RoomMemberDB(
        id: id.present ? id.value : this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role.present ? role.value : this.role,
        registered: registered ?? this.registered,
        dpUrl: dpUrl ?? this.dpUrl,
        emailVerified:
            emailVerified.present ? emailVerified.value : this.emailVerified,
      );
  RoomMemberDB copyWithCompanion(RoomMemberTableCompanion data) {
    return RoomMemberDB(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      registered:
          data.registered.present ? data.registered.value : this.registered,
      dpUrl: data.dpUrl.present ? data.dpUrl.value : this.dpUrl,
      emailVerified: data.emailVerified.present
          ? data.emailVerified.value
          : this.emailVerified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoomMemberDB(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('registered: $registered, ')
          ..write('dpUrl: $dpUrl, ')
          ..write('emailVerified: $emailVerified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, email, role, registered, dpUrl, emailVerified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoomMemberDB &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.role == this.role &&
          other.registered == this.registered &&
          other.dpUrl == this.dpUrl &&
          other.emailVerified == this.emailVerified);
}

class RoomMemberTableCompanion extends UpdateCompanion<RoomMemberDB> {
  final Value<int?> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String?> role;
  final Value<bool> registered;
  final Value<String> dpUrl;
  final Value<bool?> emailVerified;
  final Value<int> rowid;
  const RoomMemberTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.registered = const Value.absent(),
    this.dpUrl = const Value.absent(),
    this.emailVerified = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoomMemberTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required String email,
    this.role = const Value.absent(),
    this.registered = const Value.absent(),
    this.dpUrl = const Value.absent(),
    this.emailVerified = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : email = Value(email);
  static Insertable<RoomMemberDB> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? role,
    Expression<bool>? registered,
    Expression<String>? dpUrl,
    Expression<bool>? emailVerified,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (registered != null) 'registered': registered,
      if (dpUrl != null) 'dp_url': dpUrl,
      if (emailVerified != null) 'email_verified': emailVerified,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoomMemberTableCompanion copyWith(
      {Value<int?>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String?>? role,
      Value<bool>? registered,
      Value<String>? dpUrl,
      Value<bool?>? emailVerified,
      Value<int>? rowid}) {
    return RoomMemberTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      registered: registered ?? this.registered,
      dpUrl: dpUrl ?? this.dpUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (registered.present) {
      map['registered'] = Variable<bool>(registered.value);
    }
    if (dpUrl.present) {
      map['dp_url'] = Variable<String>(dpUrl.value);
    }
    if (emailVerified.present) {
      map['email_verified'] = Variable<bool>(emailVerified.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomMemberTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('registered: $registered, ')
          ..write('dpUrl: $dpUrl, ')
          ..write('emailVerified: $emailVerified, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTableTable extends MessagesTable
    with TableInfo<$MessagesTableTable, MessageDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _textDataMeta =
      const VerificationMeta('textData');
  @override
  late final GeneratedColumn<String> textData = GeneratedColumn<String>(
      'text_data', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
      'file_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES file_table(id)');
  static const VerificationMeta _pollIdMeta = const VerificationMeta('pollId');
  @override
  late final GeneratedColumn<int> pollId = GeneratedColumn<int>(
      'poll_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES poll_table(id)');
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
      'timestamp', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<int> roomId = GeneratedColumn<int>(
      'room_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES rooms_table(id)');
  static const VerificationMeta _sentFromNameMeta =
      const VerificationMeta('sentFromName');
  @override
  late final GeneratedColumn<String> sentFromName = GeneratedColumn<String>(
      'sent_from_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES room_member_table(name) NOT NULL');
  static const VerificationMeta _replyToIdMeta =
      const VerificationMeta('replyToId');
  @override
  late final GeneratedColumn<int> replyToId = GeneratedColumn<int>(
      'reply_to_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES messages_table(id)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        textData,
        fileId,
        pollId,
        timestamp,
        isSynced,
        roomId,
        sentFromName,
        replyToId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages_table';
  @override
  VerificationContext validateIntegrity(Insertable<MessageDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('text_data')) {
      context.handle(_textDataMeta,
          textData.isAcceptableOrUnknown(data['text_data']!, _textDataMeta));
    }
    if (data.containsKey('file_id')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta));
    }
    if (data.containsKey('poll_id')) {
      context.handle(_pollIdMeta,
          pollId.isAcceptableOrUnknown(data['poll_id']!, _pollIdMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('room_id')) {
      context.handle(_roomIdMeta,
          roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta));
    }
    if (data.containsKey('sent_from_name')) {
      context.handle(
          _sentFromNameMeta,
          sentFromName.isAcceptableOrUnknown(
              data['sent_from_name']!, _sentFromNameMeta));
    } else if (isInserting) {
      context.missing(_sentFromNameMeta);
    }
    if (data.containsKey('reply_to_id')) {
      context.handle(
          _replyToIdMeta,
          replyToId.isAcceptableOrUnknown(
              data['reply_to_id']!, _replyToIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      textData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_data']),
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_id']),
      pollId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}poll_id']),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      roomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}room_id']),
      sentFromName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sent_from_name'])!,
      replyToId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reply_to_id']),
    );
  }

  @override
  $MessagesTableTable createAlias(String alias) {
    return $MessagesTableTable(attachedDatabase, alias);
  }
}

class MessageDB extends DataClass implements Insertable<MessageDB> {
  final int id;
  final String? type;
  final String? textData;
  final int? fileId;
  final int? pollId;
  final int? timestamp;
  final bool isSynced;
  final int? roomId;
  final String sentFromName;
  final int? replyToId;
  const MessageDB(
      {required this.id,
      this.type,
      this.textData,
      this.fileId,
      this.pollId,
      this.timestamp,
      required this.isSynced,
      this.roomId,
      required this.sentFromName,
      this.replyToId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || textData != null) {
      map['text_data'] = Variable<String>(textData);
    }
    if (!nullToAbsent || fileId != null) {
      map['file_id'] = Variable<int>(fileId);
    }
    if (!nullToAbsent || pollId != null) {
      map['poll_id'] = Variable<int>(pollId);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<int>(timestamp);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || roomId != null) {
      map['room_id'] = Variable<int>(roomId);
    }
    map['sent_from_name'] = Variable<String>(sentFromName);
    if (!nullToAbsent || replyToId != null) {
      map['reply_to_id'] = Variable<int>(replyToId);
    }
    return map;
  }

  MessagesTableCompanion toCompanion(bool nullToAbsent) {
    return MessagesTableCompanion(
      id: Value(id),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      textData: textData == null && nullToAbsent
          ? const Value.absent()
          : Value(textData),
      fileId:
          fileId == null && nullToAbsent ? const Value.absent() : Value(fileId),
      pollId:
          pollId == null && nullToAbsent ? const Value.absent() : Value(pollId),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
      isSynced: Value(isSynced),
      roomId:
          roomId == null && nullToAbsent ? const Value.absent() : Value(roomId),
      sentFromName: Value(sentFromName),
      replyToId: replyToId == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToId),
    );
  }

  factory MessageDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageDB(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String?>(json['type']),
      textData: serializer.fromJson<String?>(json['textData']),
      fileId: serializer.fromJson<int?>(json['fileId']),
      pollId: serializer.fromJson<int?>(json['pollId']),
      timestamp: serializer.fromJson<int?>(json['timestamp']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      roomId: serializer.fromJson<int?>(json['roomId']),
      sentFromName: serializer.fromJson<String>(json['sentFromName']),
      replyToId: serializer.fromJson<int?>(json['replyToId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String?>(type),
      'textData': serializer.toJson<String?>(textData),
      'fileId': serializer.toJson<int?>(fileId),
      'pollId': serializer.toJson<int?>(pollId),
      'timestamp': serializer.toJson<int?>(timestamp),
      'isSynced': serializer.toJson<bool>(isSynced),
      'roomId': serializer.toJson<int?>(roomId),
      'sentFromName': serializer.toJson<String>(sentFromName),
      'replyToId': serializer.toJson<int?>(replyToId),
    };
  }

  MessageDB copyWith(
          {int? id,
          Value<String?> type = const Value.absent(),
          Value<String?> textData = const Value.absent(),
          Value<int?> fileId = const Value.absent(),
          Value<int?> pollId = const Value.absent(),
          Value<int?> timestamp = const Value.absent(),
          bool? isSynced,
          Value<int?> roomId = const Value.absent(),
          String? sentFromName,
          Value<int?> replyToId = const Value.absent()}) =>
      MessageDB(
        id: id ?? this.id,
        type: type.present ? type.value : this.type,
        textData: textData.present ? textData.value : this.textData,
        fileId: fileId.present ? fileId.value : this.fileId,
        pollId: pollId.present ? pollId.value : this.pollId,
        timestamp: timestamp.present ? timestamp.value : this.timestamp,
        isSynced: isSynced ?? this.isSynced,
        roomId: roomId.present ? roomId.value : this.roomId,
        sentFromName: sentFromName ?? this.sentFromName,
        replyToId: replyToId.present ? replyToId.value : this.replyToId,
      );
  MessageDB copyWithCompanion(MessagesTableCompanion data) {
    return MessageDB(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      textData: data.textData.present ? data.textData.value : this.textData,
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
      pollId: data.pollId.present ? data.pollId.value : this.pollId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      sentFromName: data.sentFromName.present
          ? data.sentFromName.value
          : this.sentFromName,
      replyToId: data.replyToId.present ? data.replyToId.value : this.replyToId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageDB(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('textData: $textData, ')
          ..write('fileId: $fileId, ')
          ..write('pollId: $pollId, ')
          ..write('timestamp: $timestamp, ')
          ..write('isSynced: $isSynced, ')
          ..write('roomId: $roomId, ')
          ..write('sentFromName: $sentFromName, ')
          ..write('replyToId: $replyToId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, textData, fileId, pollId, timestamp,
      isSynced, roomId, sentFromName, replyToId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageDB &&
          other.id == this.id &&
          other.type == this.type &&
          other.textData == this.textData &&
          other.fileId == this.fileId &&
          other.pollId == this.pollId &&
          other.timestamp == this.timestamp &&
          other.isSynced == this.isSynced &&
          other.roomId == this.roomId &&
          other.sentFromName == this.sentFromName &&
          other.replyToId == this.replyToId);
}

class MessagesTableCompanion extends UpdateCompanion<MessageDB> {
  final Value<int> id;
  final Value<String?> type;
  final Value<String?> textData;
  final Value<int?> fileId;
  final Value<int?> pollId;
  final Value<int?> timestamp;
  final Value<bool> isSynced;
  final Value<int?> roomId;
  final Value<String> sentFromName;
  final Value<int?> replyToId;
  const MessagesTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.textData = const Value.absent(),
    this.fileId = const Value.absent(),
    this.pollId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.roomId = const Value.absent(),
    this.sentFromName = const Value.absent(),
    this.replyToId = const Value.absent(),
  });
  MessagesTableCompanion.insert({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.textData = const Value.absent(),
    this.fileId = const Value.absent(),
    this.pollId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.roomId = const Value.absent(),
    required String sentFromName,
    this.replyToId = const Value.absent(),
  }) : sentFromName = Value(sentFromName);
  static Insertable<MessageDB> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? textData,
    Expression<int>? fileId,
    Expression<int>? pollId,
    Expression<int>? timestamp,
    Expression<bool>? isSynced,
    Expression<int>? roomId,
    Expression<String>? sentFromName,
    Expression<int>? replyToId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (textData != null) 'text_data': textData,
      if (fileId != null) 'file_id': fileId,
      if (pollId != null) 'poll_id': pollId,
      if (timestamp != null) 'timestamp': timestamp,
      if (isSynced != null) 'is_synced': isSynced,
      if (roomId != null) 'room_id': roomId,
      if (sentFromName != null) 'sent_from_name': sentFromName,
      if (replyToId != null) 'reply_to_id': replyToId,
    });
  }

  MessagesTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? type,
      Value<String?>? textData,
      Value<int?>? fileId,
      Value<int?>? pollId,
      Value<int?>? timestamp,
      Value<bool>? isSynced,
      Value<int?>? roomId,
      Value<String>? sentFromName,
      Value<int?>? replyToId}) {
    return MessagesTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      textData: textData ?? this.textData,
      fileId: fileId ?? this.fileId,
      pollId: pollId ?? this.pollId,
      timestamp: timestamp ?? this.timestamp,
      isSynced: isSynced ?? this.isSynced,
      roomId: roomId ?? this.roomId,
      sentFromName: sentFromName ?? this.sentFromName,
      replyToId: replyToId ?? this.replyToId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (textData.present) {
      map['text_data'] = Variable<String>(textData.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<int>(fileId.value);
    }
    if (pollId.present) {
      map['poll_id'] = Variable<int>(pollId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<int>(roomId.value);
    }
    if (sentFromName.present) {
      map['sent_from_name'] = Variable<String>(sentFromName.value);
    }
    if (replyToId.present) {
      map['reply_to_id'] = Variable<int>(replyToId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('textData: $textData, ')
          ..write('fileId: $fileId, ')
          ..write('pollId: $pollId, ')
          ..write('timestamp: $timestamp, ')
          ..write('isSynced: $isSynced, ')
          ..write('roomId: $roomId, ')
          ..write('sentFromName: $sentFromName, ')
          ..write('replyToId: $replyToId')
          ..write(')'))
        .toString();
  }
}

class $UsersTableTable extends UsersTable
    with TableInfo<$UsersTableTable, UserDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant('Anonymous'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pushTokenMeta =
      const VerificationMeta('pushToken');
  @override
  late final GeneratedColumn<String> pushToken = GeneratedColumn<String>(
      'push_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _registeredMeta =
      const VerificationMeta('registered');
  @override
  late final GeneratedColumn<bool> registered = GeneratedColumn<bool>(
      'registered', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("registered" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _dpMeta = const VerificationMeta('dp');
  @override
  late final GeneratedColumn<String> dp = GeneratedColumn<String>(
      'dp', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(''));
  static const VerificationMeta _emailVerifiedMeta =
      const VerificationMeta('emailVerified');
  @override
  late final GeneratedColumn<bool> emailVerified = GeneratedColumn<bool>(
      'email_verified', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("email_verified" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, type, pushToken, registered, dp, emailVerified];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('push_token')) {
      context.handle(_pushTokenMeta,
          pushToken.isAcceptableOrUnknown(data['push_token']!, _pushTokenMeta));
    }
    if (data.containsKey('registered')) {
      context.handle(
          _registeredMeta,
          registered.isAcceptableOrUnknown(
              data['registered']!, _registeredMeta));
    }
    if (data.containsKey('dp')) {
      context.handle(_dpMeta, dp.isAcceptableOrUnknown(data['dp']!, _dpMeta));
    }
    if (data.containsKey('email_verified')) {
      context.handle(
          _emailVerifiedMeta,
          emailVerified.isAcceptableOrUnknown(
              data['email_verified']!, _emailVerifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      pushToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}push_token']),
      registered: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}registered'])!,
      dp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dp'])!,
      emailVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}email_verified']),
    );
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }
}

class UserDB extends DataClass implements Insertable<UserDB> {
  final int id;
  final String name;
  final String? email;
  final String? type;
  final String? pushToken;
  final bool registered;
  final String dp;
  final bool? emailVerified;
  const UserDB(
      {required this.id,
      required this.name,
      this.email,
      this.type,
      this.pushToken,
      required this.registered,
      required this.dp,
      this.emailVerified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || pushToken != null) {
      map['push_token'] = Variable<String>(pushToken);
    }
    map['registered'] = Variable<bool>(registered);
    map['dp'] = Variable<String>(dp);
    if (!nullToAbsent || emailVerified != null) {
      map['email_verified'] = Variable<bool>(emailVerified);
    }
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      id: Value(id),
      name: Value(name),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      pushToken: pushToken == null && nullToAbsent
          ? const Value.absent()
          : Value(pushToken),
      registered: Value(registered),
      dp: Value(dp),
      emailVerified: emailVerified == null && nullToAbsent
          ? const Value.absent()
          : Value(emailVerified),
    );
  }

  factory UserDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserDB(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      type: serializer.fromJson<String?>(json['type']),
      pushToken: serializer.fromJson<String?>(json['pushToken']),
      registered: serializer.fromJson<bool>(json['registered']),
      dp: serializer.fromJson<String>(json['dp']),
      emailVerified: serializer.fromJson<bool?>(json['emailVerified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'type': serializer.toJson<String?>(type),
      'pushToken': serializer.toJson<String?>(pushToken),
      'registered': serializer.toJson<bool>(registered),
      'dp': serializer.toJson<String>(dp),
      'emailVerified': serializer.toJson<bool?>(emailVerified),
    };
  }

  UserDB copyWith(
          {int? id,
          String? name,
          Value<String?> email = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<String?> pushToken = const Value.absent(),
          bool? registered,
          String? dp,
          Value<bool?> emailVerified = const Value.absent()}) =>
      UserDB(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email.present ? email.value : this.email,
        type: type.present ? type.value : this.type,
        pushToken: pushToken.present ? pushToken.value : this.pushToken,
        registered: registered ?? this.registered,
        dp: dp ?? this.dp,
        emailVerified:
            emailVerified.present ? emailVerified.value : this.emailVerified,
      );
  UserDB copyWithCompanion(UsersTableCompanion data) {
    return UserDB(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      type: data.type.present ? data.type.value : this.type,
      pushToken: data.pushToken.present ? data.pushToken.value : this.pushToken,
      registered:
          data.registered.present ? data.registered.value : this.registered,
      dp: data.dp.present ? data.dp.value : this.dp,
      emailVerified: data.emailVerified.present
          ? data.emailVerified.value
          : this.emailVerified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserDB(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('type: $type, ')
          ..write('pushToken: $pushToken, ')
          ..write('registered: $registered, ')
          ..write('dp: $dp, ')
          ..write('emailVerified: $emailVerified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, email, type, pushToken, registered, dp, emailVerified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDB &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.type == this.type &&
          other.pushToken == this.pushToken &&
          other.registered == this.registered &&
          other.dp == this.dp &&
          other.emailVerified == this.emailVerified);
}

class UsersTableCompanion extends UpdateCompanion<UserDB> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> type;
  final Value<String?> pushToken;
  final Value<bool> registered;
  final Value<String> dp;
  final Value<bool?> emailVerified;
  const UsersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.type = const Value.absent(),
    this.pushToken = const Value.absent(),
    this.registered = const Value.absent(),
    this.dp = const Value.absent(),
    this.emailVerified = const Value.absent(),
  });
  UsersTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.type = const Value.absent(),
    this.pushToken = const Value.absent(),
    this.registered = const Value.absent(),
    this.dp = const Value.absent(),
    this.emailVerified = const Value.absent(),
  });
  static Insertable<UserDB> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? type,
    Expression<String>? pushToken,
    Expression<bool>? registered,
    Expression<String>? dp,
    Expression<bool>? emailVerified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (type != null) 'type': type,
      if (pushToken != null) 'push_token': pushToken,
      if (registered != null) 'registered': registered,
      if (dp != null) 'dp': dp,
      if (emailVerified != null) 'email_verified': emailVerified,
    });
  }

  UsersTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? email,
      Value<String?>? type,
      Value<String?>? pushToken,
      Value<bool>? registered,
      Value<String>? dp,
      Value<bool?>? emailVerified}) {
    return UsersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      type: type ?? this.type,
      pushToken: pushToken ?? this.pushToken,
      registered: registered ?? this.registered,
      dp: dp ?? this.dp,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (pushToken.present) {
      map['push_token'] = Variable<String>(pushToken.value);
    }
    if (registered.present) {
      map['registered'] = Variable<bool>(registered.value);
    }
    if (dp.present) {
      map['dp'] = Variable<String>(dp.value);
    }
    if (emailVerified.present) {
      map['email_verified'] = Variable<bool>(emailVerified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('type: $type, ')
          ..write('pushToken: $pushToken, ')
          ..write('registered: $registered, ')
          ..write('dp: $dp, ')
          ..write('emailVerified: $emailVerified')
          ..write(')'))
        .toString();
  }
}

class $PollOptionTableTable extends PollOptionTable
    with TableInfo<$PollOptionTableTable, PollOptionDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PollOptionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pollIdMeta = const VerificationMeta('pollId');
  @override
  late final GeneratedColumn<int> pollId = GeneratedColumn<int>(
      'poll_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES poll_table(id) NOT NULL');
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numVotesMeta =
      const VerificationMeta('numVotes');
  @override
  late final GeneratedColumn<int> numVotes = GeneratedColumn<int>(
      'num_votes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [pollId, id, value, numVotes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'poll_option_table';
  @override
  VerificationContext validateIntegrity(Insertable<PollOptionDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('poll_id')) {
      context.handle(_pollIdMeta,
          pollId.isAcceptableOrUnknown(data['poll_id']!, _pollIdMeta));
    } else if (isInserting) {
      context.missing(_pollIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('num_votes')) {
      context.handle(_numVotesMeta,
          numVotes.isAcceptableOrUnknown(data['num_votes']!, _numVotesMeta));
    } else if (isInserting) {
      context.missing(_numVotesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PollOptionDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PollOptionDB(
      pollId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}poll_id'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      numVotes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}num_votes'])!,
    );
  }

  @override
  $PollOptionTableTable createAlias(String alias) {
    return $PollOptionTableTable(attachedDatabase, alias);
  }
}

class PollOptionDB extends DataClass implements Insertable<PollOptionDB> {
  final int pollId;
  final int? id;
  final String value;
  final int numVotes;
  const PollOptionDB(
      {required this.pollId,
      this.id,
      required this.value,
      required this.numVotes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['poll_id'] = Variable<int>(pollId);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['value'] = Variable<String>(value);
    map['num_votes'] = Variable<int>(numVotes);
    return map;
  }

  PollOptionTableCompanion toCompanion(bool nullToAbsent) {
    return PollOptionTableCompanion(
      pollId: Value(pollId),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      value: Value(value),
      numVotes: Value(numVotes),
    );
  }

  factory PollOptionDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PollOptionDB(
      pollId: serializer.fromJson<int>(json['pollId']),
      id: serializer.fromJson<int?>(json['id']),
      value: serializer.fromJson<String>(json['value']),
      numVotes: serializer.fromJson<int>(json['numVotes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pollId': serializer.toJson<int>(pollId),
      'id': serializer.toJson<int?>(id),
      'value': serializer.toJson<String>(value),
      'numVotes': serializer.toJson<int>(numVotes),
    };
  }

  PollOptionDB copyWith(
          {int? pollId,
          Value<int?> id = const Value.absent(),
          String? value,
          int? numVotes}) =>
      PollOptionDB(
        pollId: pollId ?? this.pollId,
        id: id.present ? id.value : this.id,
        value: value ?? this.value,
        numVotes: numVotes ?? this.numVotes,
      );
  PollOptionDB copyWithCompanion(PollOptionTableCompanion data) {
    return PollOptionDB(
      pollId: data.pollId.present ? data.pollId.value : this.pollId,
      id: data.id.present ? data.id.value : this.id,
      value: data.value.present ? data.value.value : this.value,
      numVotes: data.numVotes.present ? data.numVotes.value : this.numVotes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PollOptionDB(')
          ..write('pollId: $pollId, ')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('numVotes: $numVotes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pollId, id, value, numVotes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PollOptionDB &&
          other.pollId == this.pollId &&
          other.id == this.id &&
          other.value == this.value &&
          other.numVotes == this.numVotes);
}

class PollOptionTableCompanion extends UpdateCompanion<PollOptionDB> {
  final Value<int> pollId;
  final Value<int?> id;
  final Value<String> value;
  final Value<int> numVotes;
  const PollOptionTableCompanion({
    this.pollId = const Value.absent(),
    this.id = const Value.absent(),
    this.value = const Value.absent(),
    this.numVotes = const Value.absent(),
  });
  PollOptionTableCompanion.insert({
    required int pollId,
    this.id = const Value.absent(),
    required String value,
    required int numVotes,
  })  : pollId = Value(pollId),
        value = Value(value),
        numVotes = Value(numVotes);
  static Insertable<PollOptionDB> custom({
    Expression<int>? pollId,
    Expression<int>? id,
    Expression<String>? value,
    Expression<int>? numVotes,
  }) {
    return RawValuesInsertable({
      if (pollId != null) 'poll_id': pollId,
      if (id != null) 'id': id,
      if (value != null) 'value': value,
      if (numVotes != null) 'num_votes': numVotes,
    });
  }

  PollOptionTableCompanion copyWith(
      {Value<int>? pollId,
      Value<int?>? id,
      Value<String>? value,
      Value<int>? numVotes}) {
    return PollOptionTableCompanion(
      pollId: pollId ?? this.pollId,
      id: id ?? this.id,
      value: value ?? this.value,
      numVotes: numVotes ?? this.numVotes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pollId.present) {
      map['poll_id'] = Variable<int>(pollId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (numVotes.present) {
      map['num_votes'] = Variable<int>(numVotes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PollOptionTableCompanion(')
          ..write('pollId: $pollId, ')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('numVotes: $numVotes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $RoomsTableTable roomsTable = $RoomsTableTable(this);
  late final $FileTableTable fileTable = $FileTableTable(this);
  late final $PollTableTable pollTable = $PollTableTable(this);
  late final $RoomMemberTableTable roomMemberTable =
      $RoomMemberTableTable(this);
  late final $MessagesTableTable messagesTable = $MessagesTableTable(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  late final $PollOptionTableTable pollOptionTable =
      $PollOptionTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        roomsTable,
        fileTable,
        pollTable,
        roomMemberTable,
        messagesTable,
        usersTable,
        pollOptionTable
      ];
}

typedef $$RoomsTableTableCreateCompanionBuilder = RoomsTableCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String?> description,
  Value<String?> type,
  Value<String?> dpUrl,
  Value<int?> timestamp,
  Value<int?> lastMessageTimestamp,
  Value<int?> unreadMessages,
  Value<int?> userLastSeen,
  Value<bool> isSynced,
});
typedef $$RoomsTableTableUpdateCompanionBuilder = RoomsTableCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String?> description,
  Value<String?> type,
  Value<String?> dpUrl,
  Value<int?> timestamp,
  Value<int?> lastMessageTimestamp,
  Value<int?> unreadMessages,
  Value<int?> userLastSeen,
  Value<bool> isSynced,
});

final class $$RoomsTableTableReferences
    extends BaseReferences<_$AppDb, $RoomsTableTable, Room> {
  $$RoomsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MessagesTableTable, List<MessageDB>>
      _messagesTableRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
          db.messagesTable,
          aliasName:
              $_aliasNameGenerator(db.roomsTable.id, db.messagesTable.roomId));

  $$MessagesTableTableProcessedTableManager get messagesTableRefs {
    final manager = $$MessagesTableTableTableManager($_db, $_db.messagesTable)
        .filter((f) => f.roomId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_messagesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RoomsTableTableFilterComposer
    extends Composer<_$AppDb, $RoomsTableTable> {
  $$RoomsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dpUrl => $composableBuilder(
      column: $table.dpUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastMessageTimestamp => $composableBuilder(
      column: $table.lastMessageTimestamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unreadMessages => $composableBuilder(
      column: $table.unreadMessages,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userLastSeen => $composableBuilder(
      column: $table.userLastSeen, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  Expression<bool> messagesTableRefs(
      Expression<bool> Function($$MessagesTableTableFilterComposer f) f) {
    final $$MessagesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messagesTable,
        getReferencedColumn: (t) => t.roomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableTableFilterComposer(
              $db: $db,
              $table: $db.messagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoomsTableTableOrderingComposer
    extends Composer<_$AppDb, $RoomsTableTable> {
  $$RoomsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dpUrl => $composableBuilder(
      column: $table.dpUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastMessageTimestamp => $composableBuilder(
      column: $table.lastMessageTimestamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unreadMessages => $composableBuilder(
      column: $table.unreadMessages,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userLastSeen => $composableBuilder(
      column: $table.userLastSeen,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$RoomsTableTableAnnotationComposer
    extends Composer<_$AppDb, $RoomsTableTable> {
  $$RoomsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get dpUrl =>
      $composableBuilder(column: $table.dpUrl, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get lastMessageTimestamp => $composableBuilder(
      column: $table.lastMessageTimestamp, builder: (column) => column);

  GeneratedColumn<int> get unreadMessages => $composableBuilder(
      column: $table.unreadMessages, builder: (column) => column);

  GeneratedColumn<int> get userLastSeen => $composableBuilder(
      column: $table.userLastSeen, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  Expression<T> messagesTableRefs<T extends Object>(
      Expression<T> Function($$MessagesTableTableAnnotationComposer a) f) {
    final $$MessagesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messagesTable,
        getReferencedColumn: (t) => t.roomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.messagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoomsTableTableTableManager extends RootTableManager<
    _$AppDb,
    $RoomsTableTable,
    Room,
    $$RoomsTableTableFilterComposer,
    $$RoomsTableTableOrderingComposer,
    $$RoomsTableTableAnnotationComposer,
    $$RoomsTableTableCreateCompanionBuilder,
    $$RoomsTableTableUpdateCompanionBuilder,
    (Room, $$RoomsTableTableReferences),
    Room,
    PrefetchHooks Function({bool messagesTableRefs})> {
  $$RoomsTableTableTableManager(_$AppDb db, $RoomsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoomsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoomsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoomsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> dpUrl = const Value.absent(),
            Value<int?> timestamp = const Value.absent(),
            Value<int?> lastMessageTimestamp = const Value.absent(),
            Value<int?> unreadMessages = const Value.absent(),
            Value<int?> userLastSeen = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
          }) =>
              RoomsTableCompanion(
            id: id,
            name: name,
            description: description,
            type: type,
            dpUrl: dpUrl,
            timestamp: timestamp,
            lastMessageTimestamp: lastMessageTimestamp,
            unreadMessages: unreadMessages,
            userLastSeen: userLastSeen,
            isSynced: isSynced,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> dpUrl = const Value.absent(),
            Value<int?> timestamp = const Value.absent(),
            Value<int?> lastMessageTimestamp = const Value.absent(),
            Value<int?> unreadMessages = const Value.absent(),
            Value<int?> userLastSeen = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
          }) =>
              RoomsTableCompanion.insert(
            id: id,
            name: name,
            description: description,
            type: type,
            dpUrl: dpUrl,
            timestamp: timestamp,
            lastMessageTimestamp: lastMessageTimestamp,
            unreadMessages: unreadMessages,
            userLastSeen: userLastSeen,
            isSynced: isSynced,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RoomsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({messagesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (messagesTableRefs) db.messagesTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (messagesTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$RoomsTableTableReferences
                            ._messagesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoomsTableTableReferences(db, table, p0)
                                .messagesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.roomId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RoomsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $RoomsTableTable,
    Room,
    $$RoomsTableTableFilterComposer,
    $$RoomsTableTableOrderingComposer,
    $$RoomsTableTableAnnotationComposer,
    $$RoomsTableTableCreateCompanionBuilder,
    $$RoomsTableTableUpdateCompanionBuilder,
    (Room, $$RoomsTableTableReferences),
    Room,
    PrefetchHooks Function({bool messagesTableRefs})>;
typedef $$FileTableTableCreateCompanionBuilder = FileTableCompanion Function({
  Value<int?> id,
  required String title,
  Value<String?> description,
  required String name,
  Value<int> rowid,
});
typedef $$FileTableTableUpdateCompanionBuilder = FileTableCompanion Function({
  Value<int?> id,
  Value<String> title,
  Value<String?> description,
  Value<String> name,
  Value<int> rowid,
});

final class $$FileTableTableReferences
    extends BaseReferences<_$AppDb, $FileTableTable, FileDB> {
  $$FileTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MessagesTableTable, List<MessageDB>>
      _messagesTableRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
          db.messagesTable,
          aliasName:
              $_aliasNameGenerator(db.fileTable.id, db.messagesTable.fileId));

  $$MessagesTableTableProcessedTableManager get messagesTableRefs {
    final manager = $$MessagesTableTableTableManager($_db, $_db.messagesTable)
        .filter((f) => f.fileId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_messagesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FileTableTableFilterComposer
    extends Composer<_$AppDb, $FileTableTable> {
  $$FileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> messagesTableRefs(
      Expression<bool> Function($$MessagesTableTableFilterComposer f) f) {
    final $$MessagesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messagesTable,
        getReferencedColumn: (t) => t.fileId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableTableFilterComposer(
              $db: $db,
              $table: $db.messagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FileTableTableOrderingComposer
    extends Composer<_$AppDb, $FileTableTable> {
  $$FileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$FileTableTableAnnotationComposer
    extends Composer<_$AppDb, $FileTableTable> {
  $$FileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> messagesTableRefs<T extends Object>(
      Expression<T> Function($$MessagesTableTableAnnotationComposer a) f) {
    final $$MessagesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messagesTable,
        getReferencedColumn: (t) => t.fileId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.messagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FileTableTableTableManager extends RootTableManager<
    _$AppDb,
    $FileTableTable,
    FileDB,
    $$FileTableTableFilterComposer,
    $$FileTableTableOrderingComposer,
    $$FileTableTableAnnotationComposer,
    $$FileTableTableCreateCompanionBuilder,
    $$FileTableTableUpdateCompanionBuilder,
    (FileDB, $$FileTableTableReferences),
    FileDB,
    PrefetchHooks Function({bool messagesTableRefs})> {
  $$FileTableTableTableManager(_$AppDb db, $FileTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FileTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FileTableCompanion(
            id: id,
            title: title,
            description: description,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              FileTableCompanion.insert(
            id: id,
            title: title,
            description: description,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FileTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({messagesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (messagesTableRefs) db.messagesTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (messagesTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$FileTableTableReferences
                            ._messagesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FileTableTableReferences(db, table, p0)
                                .messagesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.fileId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FileTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $FileTableTable,
    FileDB,
    $$FileTableTableFilterComposer,
    $$FileTableTableOrderingComposer,
    $$FileTableTableAnnotationComposer,
    $$FileTableTableCreateCompanionBuilder,
    $$FileTableTableUpdateCompanionBuilder,
    (FileDB, $$FileTableTableReferences),
    FileDB,
    PrefetchHooks Function({bool messagesTableRefs})>;
typedef $$PollTableTableCreateCompanionBuilder = PollTableCompanion Function({
  Value<int> id,
  required String title,
  Value<String?> description,
  Value<int?> lastVoted,
});
typedef $$PollTableTableUpdateCompanionBuilder = PollTableCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String?> description,
  Value<int?> lastVoted,
});

final class $$PollTableTableReferences
    extends BaseReferences<_$AppDb, $PollTableTable, PollDB> {
  $$PollTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MessagesTableTable, List<MessageDB>>
      _messagesTableRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
          db.messagesTable,
          aliasName:
              $_aliasNameGenerator(db.pollTable.id, db.messagesTable.pollId));

  $$MessagesTableTableProcessedTableManager get messagesTableRefs {
    final manager = $$MessagesTableTableTableManager($_db, $_db.messagesTable)
        .filter((f) => f.pollId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_messagesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PollOptionTableTable, List<PollOptionDB>>
      _pollOptionTableRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
          db.pollOptionTable,
          aliasName:
              $_aliasNameGenerator(db.pollTable.id, db.pollOptionTable.pollId));

  $$PollOptionTableTableProcessedTableManager get pollOptionTableRefs {
    final manager =
        $$PollOptionTableTableTableManager($_db, $_db.pollOptionTable)
            .filter((f) => f.pollId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_pollOptionTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PollTableTableFilterComposer
    extends Composer<_$AppDb, $PollTableTable> {
  $$PollTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastVoted => $composableBuilder(
      column: $table.lastVoted, builder: (column) => ColumnFilters(column));

  Expression<bool> messagesTableRefs(
      Expression<bool> Function($$MessagesTableTableFilterComposer f) f) {
    final $$MessagesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messagesTable,
        getReferencedColumn: (t) => t.pollId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableTableFilterComposer(
              $db: $db,
              $table: $db.messagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> pollOptionTableRefs(
      Expression<bool> Function($$PollOptionTableTableFilterComposer f) f) {
    final $$PollOptionTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pollOptionTable,
        getReferencedColumn: (t) => t.pollId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PollOptionTableTableFilterComposer(
              $db: $db,
              $table: $db.pollOptionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PollTableTableOrderingComposer
    extends Composer<_$AppDb, $PollTableTable> {
  $$PollTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastVoted => $composableBuilder(
      column: $table.lastVoted, builder: (column) => ColumnOrderings(column));
}

class $$PollTableTableAnnotationComposer
    extends Composer<_$AppDb, $PollTableTable> {
  $$PollTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get lastVoted =>
      $composableBuilder(column: $table.lastVoted, builder: (column) => column);

  Expression<T> messagesTableRefs<T extends Object>(
      Expression<T> Function($$MessagesTableTableAnnotationComposer a) f) {
    final $$MessagesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messagesTable,
        getReferencedColumn: (t) => t.pollId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.messagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> pollOptionTableRefs<T extends Object>(
      Expression<T> Function($$PollOptionTableTableAnnotationComposer a) f) {
    final $$PollOptionTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pollOptionTable,
        getReferencedColumn: (t) => t.pollId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PollOptionTableTableAnnotationComposer(
              $db: $db,
              $table: $db.pollOptionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PollTableTableTableManager extends RootTableManager<
    _$AppDb,
    $PollTableTable,
    PollDB,
    $$PollTableTableFilterComposer,
    $$PollTableTableOrderingComposer,
    $$PollTableTableAnnotationComposer,
    $$PollTableTableCreateCompanionBuilder,
    $$PollTableTableUpdateCompanionBuilder,
    (PollDB, $$PollTableTableReferences),
    PollDB,
    PrefetchHooks Function(
        {bool messagesTableRefs, bool pollOptionTableRefs})> {
  $$PollTableTableTableManager(_$AppDb db, $PollTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PollTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PollTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PollTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int?> lastVoted = const Value.absent(),
          }) =>
              PollTableCompanion(
            id: id,
            title: title,
            description: description,
            lastVoted: lastVoted,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            Value<int?> lastVoted = const Value.absent(),
          }) =>
              PollTableCompanion.insert(
            id: id,
            title: title,
            description: description,
            lastVoted: lastVoted,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PollTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {messagesTableRefs = false, pollOptionTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (messagesTableRefs) db.messagesTable,
                if (pollOptionTableRefs) db.pollOptionTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (messagesTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PollTableTableReferences
                            ._messagesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PollTableTableReferences(db, table, p0)
                                .messagesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.pollId == item.id),
                        typedResults: items),
                  if (pollOptionTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PollTableTableReferences
                            ._pollOptionTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PollTableTableReferences(db, table, p0)
                                .pollOptionTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.pollId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PollTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $PollTableTable,
    PollDB,
    $$PollTableTableFilterComposer,
    $$PollTableTableOrderingComposer,
    $$PollTableTableAnnotationComposer,
    $$PollTableTableCreateCompanionBuilder,
    $$PollTableTableUpdateCompanionBuilder,
    (PollDB, $$PollTableTableReferences),
    PollDB,
    PrefetchHooks Function({bool messagesTableRefs, bool pollOptionTableRefs})>;
typedef $$RoomMemberTableTableCreateCompanionBuilder = RoomMemberTableCompanion
    Function({
  Value<int?> id,
  Value<String> name,
  required String email,
  Value<String?> role,
  Value<bool> registered,
  Value<String> dpUrl,
  Value<bool?> emailVerified,
  Value<int> rowid,
});
typedef $$RoomMemberTableTableUpdateCompanionBuilder = RoomMemberTableCompanion
    Function({
  Value<int?> id,
  Value<String> name,
  Value<String> email,
  Value<String?> role,
  Value<bool> registered,
  Value<String> dpUrl,
  Value<bool?> emailVerified,
  Value<int> rowid,
});

final class $$RoomMemberTableTableReferences
    extends BaseReferences<_$AppDb, $RoomMemberTableTable, RoomMemberDB> {
  $$RoomMemberTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MessagesTableTable, List<MessageDB>>
      _messagesTableRefsTable(_$AppDb db) =>
          MultiTypedResultKey.fromTable(db.messagesTable,
              aliasName: $_aliasNameGenerator(
                  db.roomMemberTable.name, db.messagesTable.sentFromName));

  $$MessagesTableTableProcessedTableManager get messagesTableRefs {
    final manager = $$MessagesTableTableTableManager($_db, $_db.messagesTable)
        .filter((f) => f.sentFromName.name($_item.name));

    final cache = $_typedResult.readTableOrNull(_messagesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RoomMemberTableTableFilterComposer
    extends Composer<_$AppDb, $RoomMemberTableTable> {
  $$RoomMemberTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get registered => $composableBuilder(
      column: $table.registered, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dpUrl => $composableBuilder(
      column: $table.dpUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get emailVerified => $composableBuilder(
      column: $table.emailVerified, builder: (column) => ColumnFilters(column));

  Expression<bool> messagesTableRefs(
      Expression<bool> Function($$MessagesTableTableFilterComposer f) f) {
    final $$MessagesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.name,
        referencedTable: $db.messagesTable,
        getReferencedColumn: (t) => t.sentFromName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableTableFilterComposer(
              $db: $db,
              $table: $db.messagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoomMemberTableTableOrderingComposer
    extends Composer<_$AppDb, $RoomMemberTableTable> {
  $$RoomMemberTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get registered => $composableBuilder(
      column: $table.registered, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dpUrl => $composableBuilder(
      column: $table.dpUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get emailVerified => $composableBuilder(
      column: $table.emailVerified,
      builder: (column) => ColumnOrderings(column));
}

class $$RoomMemberTableTableAnnotationComposer
    extends Composer<_$AppDb, $RoomMemberTableTable> {
  $$RoomMemberTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get registered => $composableBuilder(
      column: $table.registered, builder: (column) => column);

  GeneratedColumn<String> get dpUrl =>
      $composableBuilder(column: $table.dpUrl, builder: (column) => column);

  GeneratedColumn<bool> get emailVerified => $composableBuilder(
      column: $table.emailVerified, builder: (column) => column);

  Expression<T> messagesTableRefs<T extends Object>(
      Expression<T> Function($$MessagesTableTableAnnotationComposer a) f) {
    final $$MessagesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.name,
        referencedTable: $db.messagesTable,
        getReferencedColumn: (t) => t.sentFromName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.messagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoomMemberTableTableTableManager extends RootTableManager<
    _$AppDb,
    $RoomMemberTableTable,
    RoomMemberDB,
    $$RoomMemberTableTableFilterComposer,
    $$RoomMemberTableTableOrderingComposer,
    $$RoomMemberTableTableAnnotationComposer,
    $$RoomMemberTableTableCreateCompanionBuilder,
    $$RoomMemberTableTableUpdateCompanionBuilder,
    (RoomMemberDB, $$RoomMemberTableTableReferences),
    RoomMemberDB,
    PrefetchHooks Function({bool messagesTableRefs})> {
  $$RoomMemberTableTableTableManager(_$AppDb db, $RoomMemberTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoomMemberTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoomMemberTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoomMemberTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<bool> registered = const Value.absent(),
            Value<String> dpUrl = const Value.absent(),
            Value<bool?> emailVerified = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RoomMemberTableCompanion(
            id: id,
            name: name,
            email: email,
            role: role,
            registered: registered,
            dpUrl: dpUrl,
            emailVerified: emailVerified,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            required String email,
            Value<String?> role = const Value.absent(),
            Value<bool> registered = const Value.absent(),
            Value<String> dpUrl = const Value.absent(),
            Value<bool?> emailVerified = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RoomMemberTableCompanion.insert(
            id: id,
            name: name,
            email: email,
            role: role,
            registered: registered,
            dpUrl: dpUrl,
            emailVerified: emailVerified,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RoomMemberTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({messagesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (messagesTableRefs) db.messagesTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (messagesTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$RoomMemberTableTableReferences
                            ._messagesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoomMemberTableTableReferences(db, table, p0)
                                .messagesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sentFromName == item.name),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RoomMemberTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $RoomMemberTableTable,
    RoomMemberDB,
    $$RoomMemberTableTableFilterComposer,
    $$RoomMemberTableTableOrderingComposer,
    $$RoomMemberTableTableAnnotationComposer,
    $$RoomMemberTableTableCreateCompanionBuilder,
    $$RoomMemberTableTableUpdateCompanionBuilder,
    (RoomMemberDB, $$RoomMemberTableTableReferences),
    RoomMemberDB,
    PrefetchHooks Function({bool messagesTableRefs})>;
typedef $$MessagesTableTableCreateCompanionBuilder = MessagesTableCompanion
    Function({
  Value<int> id,
  Value<String?> type,
  Value<String?> textData,
  Value<int?> fileId,
  Value<int?> pollId,
  Value<int?> timestamp,
  Value<bool> isSynced,
  Value<int?> roomId,
  required String sentFromName,
  Value<int?> replyToId,
});
typedef $$MessagesTableTableUpdateCompanionBuilder = MessagesTableCompanion
    Function({
  Value<int> id,
  Value<String?> type,
  Value<String?> textData,
  Value<int?> fileId,
  Value<int?> pollId,
  Value<int?> timestamp,
  Value<bool> isSynced,
  Value<int?> roomId,
  Value<String> sentFromName,
  Value<int?> replyToId,
});

final class $$MessagesTableTableReferences
    extends BaseReferences<_$AppDb, $MessagesTableTable, MessageDB> {
  $$MessagesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FileTableTable _fileIdTable(_$AppDb db) => db.fileTable.createAlias(
      $_aliasNameGenerator(db.messagesTable.fileId, db.fileTable.id));

  $$FileTableTableProcessedTableManager? get fileId {
    if ($_item.fileId == null) return null;
    final manager = $$FileTableTableTableManager($_db, $_db.fileTable)
        .filter((f) => f.id($_item.fileId!));
    final item = $_typedResult.readTableOrNull(_fileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PollTableTable _pollIdTable(_$AppDb db) => db.pollTable.createAlias(
      $_aliasNameGenerator(db.messagesTable.pollId, db.pollTable.id));

  $$PollTableTableProcessedTableManager? get pollId {
    if ($_item.pollId == null) return null;
    final manager = $$PollTableTableTableManager($_db, $_db.pollTable)
        .filter((f) => f.id($_item.pollId!));
    final item = $_typedResult.readTableOrNull(_pollIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RoomsTableTable _roomIdTable(_$AppDb db) => db.roomsTable.createAlias(
      $_aliasNameGenerator(db.messagesTable.roomId, db.roomsTable.id));

  $$RoomsTableTableProcessedTableManager? get roomId {
    if ($_item.roomId == null) return null;
    final manager = $$RoomsTableTableTableManager($_db, $_db.roomsTable)
        .filter((f) => f.id($_item.roomId!));
    final item = $_typedResult.readTableOrNull(_roomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RoomMemberTableTable _sentFromNameTable(_$AppDb db) =>
      db.roomMemberTable.createAlias($_aliasNameGenerator(
          db.messagesTable.sentFromName, db.roomMemberTable.name));

  $$RoomMemberTableTableProcessedTableManager get sentFromName {
    final manager =
        $$RoomMemberTableTableTableManager($_db, $_db.roomMemberTable)
            .filter((f) => f.name($_item.sentFromName));
    final item = $_typedResult.readTableOrNull(_sentFromNameTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MessagesTableTableFilterComposer
    extends Composer<_$AppDb, $MessagesTableTable> {
  $$MessagesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textData => $composableBuilder(
      column: $table.textData, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get replyToId => $composableBuilder(
      column: $table.replyToId, builder: (column) => ColumnFilters(column));

  $$FileTableTableFilterComposer get fileId {
    final $$FileTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fileId,
        referencedTable: $db.fileTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FileTableTableFilterComposer(
              $db: $db,
              $table: $db.fileTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PollTableTableFilterComposer get pollId {
    final $$PollTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pollId,
        referencedTable: $db.pollTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PollTableTableFilterComposer(
              $db: $db,
              $table: $db.pollTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoomsTableTableFilterComposer get roomId {
    final $$RoomsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.roomsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableTableFilterComposer(
              $db: $db,
              $table: $db.roomsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoomMemberTableTableFilterComposer get sentFromName {
    final $$RoomMemberTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sentFromName,
        referencedTable: $db.roomMemberTable,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomMemberTableTableFilterComposer(
              $db: $db,
              $table: $db.roomMemberTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MessagesTableTableOrderingComposer
    extends Composer<_$AppDb, $MessagesTableTable> {
  $$MessagesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textData => $composableBuilder(
      column: $table.textData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get replyToId => $composableBuilder(
      column: $table.replyToId, builder: (column) => ColumnOrderings(column));

  $$FileTableTableOrderingComposer get fileId {
    final $$FileTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fileId,
        referencedTable: $db.fileTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FileTableTableOrderingComposer(
              $db: $db,
              $table: $db.fileTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PollTableTableOrderingComposer get pollId {
    final $$PollTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pollId,
        referencedTable: $db.pollTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PollTableTableOrderingComposer(
              $db: $db,
              $table: $db.pollTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoomsTableTableOrderingComposer get roomId {
    final $$RoomsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.roomsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableTableOrderingComposer(
              $db: $db,
              $table: $db.roomsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoomMemberTableTableOrderingComposer get sentFromName {
    final $$RoomMemberTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sentFromName,
        referencedTable: $db.roomMemberTable,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomMemberTableTableOrderingComposer(
              $db: $db,
              $table: $db.roomMemberTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MessagesTableTableAnnotationComposer
    extends Composer<_$AppDb, $MessagesTableTable> {
  $$MessagesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get textData =>
      $composableBuilder(column: $table.textData, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<int> get replyToId =>
      $composableBuilder(column: $table.replyToId, builder: (column) => column);

  $$FileTableTableAnnotationComposer get fileId {
    final $$FileTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fileId,
        referencedTable: $db.fileTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FileTableTableAnnotationComposer(
              $db: $db,
              $table: $db.fileTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PollTableTableAnnotationComposer get pollId {
    final $$PollTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pollId,
        referencedTable: $db.pollTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PollTableTableAnnotationComposer(
              $db: $db,
              $table: $db.pollTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoomsTableTableAnnotationComposer get roomId {
    final $$RoomsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.roomsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.roomsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoomMemberTableTableAnnotationComposer get sentFromName {
    final $$RoomMemberTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sentFromName,
        referencedTable: $db.roomMemberTable,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomMemberTableTableAnnotationComposer(
              $db: $db,
              $table: $db.roomMemberTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MessagesTableTableTableManager extends RootTableManager<
    _$AppDb,
    $MessagesTableTable,
    MessageDB,
    $$MessagesTableTableFilterComposer,
    $$MessagesTableTableOrderingComposer,
    $$MessagesTableTableAnnotationComposer,
    $$MessagesTableTableCreateCompanionBuilder,
    $$MessagesTableTableUpdateCompanionBuilder,
    (MessageDB, $$MessagesTableTableReferences),
    MessageDB,
    PrefetchHooks Function(
        {bool fileId, bool pollId, bool roomId, bool sentFromName})> {
  $$MessagesTableTableTableManager(_$AppDb db, $MessagesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> textData = const Value.absent(),
            Value<int?> fileId = const Value.absent(),
            Value<int?> pollId = const Value.absent(),
            Value<int?> timestamp = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int?> roomId = const Value.absent(),
            Value<String> sentFromName = const Value.absent(),
            Value<int?> replyToId = const Value.absent(),
          }) =>
              MessagesTableCompanion(
            id: id,
            type: type,
            textData: textData,
            fileId: fileId,
            pollId: pollId,
            timestamp: timestamp,
            isSynced: isSynced,
            roomId: roomId,
            sentFromName: sentFromName,
            replyToId: replyToId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> textData = const Value.absent(),
            Value<int?> fileId = const Value.absent(),
            Value<int?> pollId = const Value.absent(),
            Value<int?> timestamp = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int?> roomId = const Value.absent(),
            required String sentFromName,
            Value<int?> replyToId = const Value.absent(),
          }) =>
              MessagesTableCompanion.insert(
            id: id,
            type: type,
            textData: textData,
            fileId: fileId,
            pollId: pollId,
            timestamp: timestamp,
            isSynced: isSynced,
            roomId: roomId,
            sentFromName: sentFromName,
            replyToId: replyToId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MessagesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {fileId = false,
              pollId = false,
              roomId = false,
              sentFromName = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (fileId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.fileId,
                    referencedTable:
                        $$MessagesTableTableReferences._fileIdTable(db),
                    referencedColumn:
                        $$MessagesTableTableReferences._fileIdTable(db).id,
                  ) as T;
                }
                if (pollId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pollId,
                    referencedTable:
                        $$MessagesTableTableReferences._pollIdTable(db),
                    referencedColumn:
                        $$MessagesTableTableReferences._pollIdTable(db).id,
                  ) as T;
                }
                if (roomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.roomId,
                    referencedTable:
                        $$MessagesTableTableReferences._roomIdTable(db),
                    referencedColumn:
                        $$MessagesTableTableReferences._roomIdTable(db).id,
                  ) as T;
                }
                if (sentFromName) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sentFromName,
                    referencedTable:
                        $$MessagesTableTableReferences._sentFromNameTable(db),
                    referencedColumn: $$MessagesTableTableReferences
                        ._sentFromNameTable(db)
                        .name,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MessagesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $MessagesTableTable,
    MessageDB,
    $$MessagesTableTableFilterComposer,
    $$MessagesTableTableOrderingComposer,
    $$MessagesTableTableAnnotationComposer,
    $$MessagesTableTableCreateCompanionBuilder,
    $$MessagesTableTableUpdateCompanionBuilder,
    (MessageDB, $$MessagesTableTableReferences),
    MessageDB,
    PrefetchHooks Function(
        {bool fileId, bool pollId, bool roomId, bool sentFromName})>;
typedef $$UsersTableTableCreateCompanionBuilder = UsersTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> email,
  Value<String?> type,
  Value<String?> pushToken,
  Value<bool> registered,
  Value<String> dp,
  Value<bool?> emailVerified,
});
typedef $$UsersTableTableUpdateCompanionBuilder = UsersTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> email,
  Value<String?> type,
  Value<String?> pushToken,
  Value<bool> registered,
  Value<String> dp,
  Value<bool?> emailVerified,
});

class $$UsersTableTableFilterComposer
    extends Composer<_$AppDb, $UsersTableTable> {
  $$UsersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pushToken => $composableBuilder(
      column: $table.pushToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get registered => $composableBuilder(
      column: $table.registered, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dp => $composableBuilder(
      column: $table.dp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get emailVerified => $composableBuilder(
      column: $table.emailVerified, builder: (column) => ColumnFilters(column));
}

class $$UsersTableTableOrderingComposer
    extends Composer<_$AppDb, $UsersTableTable> {
  $$UsersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pushToken => $composableBuilder(
      column: $table.pushToken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get registered => $composableBuilder(
      column: $table.registered, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dp => $composableBuilder(
      column: $table.dp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get emailVerified => $composableBuilder(
      column: $table.emailVerified,
      builder: (column) => ColumnOrderings(column));
}

class $$UsersTableTableAnnotationComposer
    extends Composer<_$AppDb, $UsersTableTable> {
  $$UsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get pushToken =>
      $composableBuilder(column: $table.pushToken, builder: (column) => column);

  GeneratedColumn<bool> get registered => $composableBuilder(
      column: $table.registered, builder: (column) => column);

  GeneratedColumn<String> get dp =>
      $composableBuilder(column: $table.dp, builder: (column) => column);

  GeneratedColumn<bool> get emailVerified => $composableBuilder(
      column: $table.emailVerified, builder: (column) => column);
}

class $$UsersTableTableTableManager extends RootTableManager<
    _$AppDb,
    $UsersTableTable,
    UserDB,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableAnnotationComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (UserDB, BaseReferences<_$AppDb, $UsersTableTable, UserDB>),
    UserDB,
    PrefetchHooks Function()> {
  $$UsersTableTableTableManager(_$AppDb db, $UsersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> pushToken = const Value.absent(),
            Value<bool> registered = const Value.absent(),
            Value<String> dp = const Value.absent(),
            Value<bool?> emailVerified = const Value.absent(),
          }) =>
              UsersTableCompanion(
            id: id,
            name: name,
            email: email,
            type: type,
            pushToken: pushToken,
            registered: registered,
            dp: dp,
            emailVerified: emailVerified,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> pushToken = const Value.absent(),
            Value<bool> registered = const Value.absent(),
            Value<String> dp = const Value.absent(),
            Value<bool?> emailVerified = const Value.absent(),
          }) =>
              UsersTableCompanion.insert(
            id: id,
            name: name,
            email: email,
            type: type,
            pushToken: pushToken,
            registered: registered,
            dp: dp,
            emailVerified: emailVerified,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $UsersTableTable,
    UserDB,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableAnnotationComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (UserDB, BaseReferences<_$AppDb, $UsersTableTable, UserDB>),
    UserDB,
    PrefetchHooks Function()>;
typedef $$PollOptionTableTableCreateCompanionBuilder = PollOptionTableCompanion
    Function({
  required int pollId,
  Value<int?> id,
  required String value,
  required int numVotes,
});
typedef $$PollOptionTableTableUpdateCompanionBuilder = PollOptionTableCompanion
    Function({
  Value<int> pollId,
  Value<int?> id,
  Value<String> value,
  Value<int> numVotes,
});

final class $$PollOptionTableTableReferences
    extends BaseReferences<_$AppDb, $PollOptionTableTable, PollOptionDB> {
  $$PollOptionTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PollTableTable _pollIdTable(_$AppDb db) => db.pollTable.createAlias(
      $_aliasNameGenerator(db.pollOptionTable.pollId, db.pollTable.id));

  $$PollTableTableProcessedTableManager get pollId {
    final manager = $$PollTableTableTableManager($_db, $_db.pollTable)
        .filter((f) => f.id($_item.pollId));
    final item = $_typedResult.readTableOrNull(_pollIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PollOptionTableTableFilterComposer
    extends Composer<_$AppDb, $PollOptionTableTable> {
  $$PollOptionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get numVotes => $composableBuilder(
      column: $table.numVotes, builder: (column) => ColumnFilters(column));

  $$PollTableTableFilterComposer get pollId {
    final $$PollTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pollId,
        referencedTable: $db.pollTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PollTableTableFilterComposer(
              $db: $db,
              $table: $db.pollTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PollOptionTableTableOrderingComposer
    extends Composer<_$AppDb, $PollOptionTableTable> {
  $$PollOptionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get numVotes => $composableBuilder(
      column: $table.numVotes, builder: (column) => ColumnOrderings(column));

  $$PollTableTableOrderingComposer get pollId {
    final $$PollTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pollId,
        referencedTable: $db.pollTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PollTableTableOrderingComposer(
              $db: $db,
              $table: $db.pollTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PollOptionTableTableAnnotationComposer
    extends Composer<_$AppDb, $PollOptionTableTable> {
  $$PollOptionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get numVotes =>
      $composableBuilder(column: $table.numVotes, builder: (column) => column);

  $$PollTableTableAnnotationComposer get pollId {
    final $$PollTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pollId,
        referencedTable: $db.pollTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PollTableTableAnnotationComposer(
              $db: $db,
              $table: $db.pollTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PollOptionTableTableTableManager extends RootTableManager<
    _$AppDb,
    $PollOptionTableTable,
    PollOptionDB,
    $$PollOptionTableTableFilterComposer,
    $$PollOptionTableTableOrderingComposer,
    $$PollOptionTableTableAnnotationComposer,
    $$PollOptionTableTableCreateCompanionBuilder,
    $$PollOptionTableTableUpdateCompanionBuilder,
    (PollOptionDB, $$PollOptionTableTableReferences),
    PollOptionDB,
    PrefetchHooks Function({bool pollId})> {
  $$PollOptionTableTableTableManager(_$AppDb db, $PollOptionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PollOptionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PollOptionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PollOptionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> pollId = const Value.absent(),
            Value<int?> id = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> numVotes = const Value.absent(),
          }) =>
              PollOptionTableCompanion(
            pollId: pollId,
            id: id,
            value: value,
            numVotes: numVotes,
          ),
          createCompanionCallback: ({
            required int pollId,
            Value<int?> id = const Value.absent(),
            required String value,
            required int numVotes,
          }) =>
              PollOptionTableCompanion.insert(
            pollId: pollId,
            id: id,
            value: value,
            numVotes: numVotes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PollOptionTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pollId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (pollId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pollId,
                    referencedTable:
                        $$PollOptionTableTableReferences._pollIdTable(db),
                    referencedColumn:
                        $$PollOptionTableTableReferences._pollIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PollOptionTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    $PollOptionTableTable,
    PollOptionDB,
    $$PollOptionTableTableFilterComposer,
    $$PollOptionTableTableOrderingComposer,
    $$PollOptionTableTableAnnotationComposer,
    $$PollOptionTableTableCreateCompanionBuilder,
    $$PollOptionTableTableUpdateCompanionBuilder,
    (PollOptionDB, $$PollOptionTableTableReferences),
    PollOptionDB,
    PrefetchHooks Function({bool pollId})>;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$RoomsTableTableTableManager get roomsTable =>
      $$RoomsTableTableTableManager(_db, _db.roomsTable);
  $$FileTableTableTableManager get fileTable =>
      $$FileTableTableTableManager(_db, _db.fileTable);
  $$PollTableTableTableManager get pollTable =>
      $$PollTableTableTableManager(_db, _db.pollTable);
  $$RoomMemberTableTableTableManager get roomMemberTable =>
      $$RoomMemberTableTableTableManager(_db, _db.roomMemberTable);
  $$MessagesTableTableTableManager get messagesTable =>
      $$MessagesTableTableTableManager(_db, _db.messagesTable);
  $$UsersTableTableTableManager get usersTable =>
      $$UsersTableTableTableManager(_db, _db.usersTable);
  $$PollOptionTableTableTableManager get pollOptionTable =>
      $$PollOptionTableTableTableManager(_db, _db.pollOptionTable);
}
