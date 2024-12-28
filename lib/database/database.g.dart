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
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentUrlMeta =
      const VerificationMeta('contentUrl');
  @override
  late final GeneratedColumn<String> contentUrl = GeneratedColumn<String>(
      'content_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _sentFromIdMeta =
      const VerificationMeta('sentFromId');
  @override
  late final GeneratedColumn<int> sentFromId = GeneratedColumn<int>(
      'sent_from_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES users_table(id)');
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
        content,
        contentUrl,
        timestamp,
        isSynced,
        roomId,
        sentFromId,
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
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('content_url')) {
      context.handle(
          _contentUrlMeta,
          contentUrl.isAcceptableOrUnknown(
              data['content_url']!, _contentUrlMeta));
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
    if (data.containsKey('sent_from_id')) {
      context.handle(
          _sentFromIdMeta,
          sentFromId.isAcceptableOrUnknown(
              data['sent_from_id']!, _sentFromIdMeta));
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
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      contentUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_url']),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      roomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}room_id']),
      sentFromId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sent_from_id']),
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
  final String? content;
  final String? contentUrl;
  final int? timestamp;
  final bool isSynced;
  final int? roomId;
  final int? sentFromId;
  final int? replyToId;
  const MessageDB(
      {required this.id,
      this.type,
      this.content,
      this.contentUrl,
      this.timestamp,
      required this.isSynced,
      this.roomId,
      this.sentFromId,
      this.replyToId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || contentUrl != null) {
      map['content_url'] = Variable<String>(contentUrl);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<int>(timestamp);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || roomId != null) {
      map['room_id'] = Variable<int>(roomId);
    }
    if (!nullToAbsent || sentFromId != null) {
      map['sent_from_id'] = Variable<int>(sentFromId);
    }
    if (!nullToAbsent || replyToId != null) {
      map['reply_to_id'] = Variable<int>(replyToId);
    }
    return map;
  }

  MessagesTableCompanion toCompanion(bool nullToAbsent) {
    return MessagesTableCompanion(
      id: Value(id),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      contentUrl: contentUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(contentUrl),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
      isSynced: Value(isSynced),
      roomId:
          roomId == null && nullToAbsent ? const Value.absent() : Value(roomId),
      sentFromId: sentFromId == null && nullToAbsent
          ? const Value.absent()
          : Value(sentFromId),
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
      content: serializer.fromJson<String?>(json['content']),
      contentUrl: serializer.fromJson<String?>(json['contentUrl']),
      timestamp: serializer.fromJson<int?>(json['timestamp']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      roomId: serializer.fromJson<int?>(json['roomId']),
      sentFromId: serializer.fromJson<int?>(json['sentFromId']),
      replyToId: serializer.fromJson<int?>(json['replyToId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String?>(type),
      'content': serializer.toJson<String?>(content),
      'contentUrl': serializer.toJson<String?>(contentUrl),
      'timestamp': serializer.toJson<int?>(timestamp),
      'isSynced': serializer.toJson<bool>(isSynced),
      'roomId': serializer.toJson<int?>(roomId),
      'sentFromId': serializer.toJson<int?>(sentFromId),
      'replyToId': serializer.toJson<int?>(replyToId),
    };
  }

  MessageDB copyWith(
          {int? id,
          Value<String?> type = const Value.absent(),
          Value<String?> content = const Value.absent(),
          Value<String?> contentUrl = const Value.absent(),
          Value<int?> timestamp = const Value.absent(),
          bool? isSynced,
          Value<int?> roomId = const Value.absent(),
          Value<int?> sentFromId = const Value.absent(),
          Value<int?> replyToId = const Value.absent()}) =>
      MessageDB(
        id: id ?? this.id,
        type: type.present ? type.value : this.type,
        content: content.present ? content.value : this.content,
        contentUrl: contentUrl.present ? contentUrl.value : this.contentUrl,
        timestamp: timestamp.present ? timestamp.value : this.timestamp,
        isSynced: isSynced ?? this.isSynced,
        roomId: roomId.present ? roomId.value : this.roomId,
        sentFromId: sentFromId.present ? sentFromId.value : this.sentFromId,
        replyToId: replyToId.present ? replyToId.value : this.replyToId,
      );
  MessageDB copyWithCompanion(MessagesTableCompanion data) {
    return MessageDB(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      contentUrl:
          data.contentUrl.present ? data.contentUrl.value : this.contentUrl,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      sentFromId:
          data.sentFromId.present ? data.sentFromId.value : this.sentFromId,
      replyToId: data.replyToId.present ? data.replyToId.value : this.replyToId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageDB(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('contentUrl: $contentUrl, ')
          ..write('timestamp: $timestamp, ')
          ..write('isSynced: $isSynced, ')
          ..write('roomId: $roomId, ')
          ..write('sentFromId: $sentFromId, ')
          ..write('replyToId: $replyToId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, content, contentUrl, timestamp,
      isSynced, roomId, sentFromId, replyToId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageDB &&
          other.id == this.id &&
          other.type == this.type &&
          other.content == this.content &&
          other.contentUrl == this.contentUrl &&
          other.timestamp == this.timestamp &&
          other.isSynced == this.isSynced &&
          other.roomId == this.roomId &&
          other.sentFromId == this.sentFromId &&
          other.replyToId == this.replyToId);
}

class MessagesTableCompanion extends UpdateCompanion<MessageDB> {
  final Value<int> id;
  final Value<String?> type;
  final Value<String?> content;
  final Value<String?> contentUrl;
  final Value<int?> timestamp;
  final Value<bool> isSynced;
  final Value<int?> roomId;
  final Value<int?> sentFromId;
  final Value<int?> replyToId;
  const MessagesTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.contentUrl = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.roomId = const Value.absent(),
    this.sentFromId = const Value.absent(),
    this.replyToId = const Value.absent(),
  });
  MessagesTableCompanion.insert({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.contentUrl = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.roomId = const Value.absent(),
    this.sentFromId = const Value.absent(),
    this.replyToId = const Value.absent(),
  });
  static Insertable<MessageDB> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? content,
    Expression<String>? contentUrl,
    Expression<int>? timestamp,
    Expression<bool>? isSynced,
    Expression<int>? roomId,
    Expression<int>? sentFromId,
    Expression<int>? replyToId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (contentUrl != null) 'content_url': contentUrl,
      if (timestamp != null) 'timestamp': timestamp,
      if (isSynced != null) 'is_synced': isSynced,
      if (roomId != null) 'room_id': roomId,
      if (sentFromId != null) 'sent_from_id': sentFromId,
      if (replyToId != null) 'reply_to_id': replyToId,
    });
  }

  MessagesTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? type,
      Value<String?>? content,
      Value<String?>? contentUrl,
      Value<int?>? timestamp,
      Value<bool>? isSynced,
      Value<int?>? roomId,
      Value<int?>? sentFromId,
      Value<int?>? replyToId}) {
    return MessagesTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      contentUrl: contentUrl ?? this.contentUrl,
      timestamp: timestamp ?? this.timestamp,
      isSynced: isSynced ?? this.isSynced,
      roomId: roomId ?? this.roomId,
      sentFromId: sentFromId ?? this.sentFromId,
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
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (contentUrl.present) {
      map['content_url'] = Variable<String>(contentUrl.value);
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
    if (sentFromId.present) {
      map['sent_from_id'] = Variable<int>(sentFromId.value);
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
          ..write('content: $content, ')
          ..write('contentUrl: $contentUrl, ')
          ..write('timestamp: $timestamp, ')
          ..write('isSynced: $isSynced, ')
          ..write('roomId: $roomId, ')
          ..write('sentFromId: $sentFromId, ')
          ..write('replyToId: $replyToId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $RoomsTableTable roomsTable = $RoomsTableTable(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  late final $MessagesTableTable messagesTable = $MessagesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [roomsTable, usersTable, messagesTable];
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

final class $$UsersTableTableReferences
    extends BaseReferences<_$AppDb, $UsersTableTable, UserDB> {
  $$UsersTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MessagesTableTable, List<MessageDB>>
      _messagesTableRefsTable(_$AppDb db) =>
          MultiTypedResultKey.fromTable(db.messagesTable,
              aliasName: $_aliasNameGenerator(
                  db.usersTable.id, db.messagesTable.sentFromId));

  $$MessagesTableTableProcessedTableManager get messagesTableRefs {
    final manager = $$MessagesTableTableTableManager($_db, $_db.messagesTable)
        .filter((f) => f.sentFromId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_messagesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

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

  Expression<bool> messagesTableRefs(
      Expression<bool> Function($$MessagesTableTableFilterComposer f) f) {
    final $$MessagesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messagesTable,
        getReferencedColumn: (t) => t.sentFromId,
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

  Expression<T> messagesTableRefs<T extends Object>(
      Expression<T> Function($$MessagesTableTableAnnotationComposer a) f) {
    final $$MessagesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messagesTable,
        getReferencedColumn: (t) => t.sentFromId,
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

class $$UsersTableTableTableManager extends RootTableManager<
    _$AppDb,
    $UsersTableTable,
    UserDB,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableAnnotationComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (UserDB, $$UsersTableTableReferences),
    UserDB,
    PrefetchHooks Function({bool messagesTableRefs})> {
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
              .map((e) => (
                    e.readTable(table),
                    $$UsersTableTableReferences(db, table, e)
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
                        referencedTable: $$UsersTableTableReferences
                            ._messagesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableTableReferences(db, table, p0)
                                .messagesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sentFromId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
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
    (UserDB, $$UsersTableTableReferences),
    UserDB,
    PrefetchHooks Function({bool messagesTableRefs})>;
typedef $$MessagesTableTableCreateCompanionBuilder = MessagesTableCompanion
    Function({
  Value<int> id,
  Value<String?> type,
  Value<String?> content,
  Value<String?> contentUrl,
  Value<int?> timestamp,
  Value<bool> isSynced,
  Value<int?> roomId,
  Value<int?> sentFromId,
  Value<int?> replyToId,
});
typedef $$MessagesTableTableUpdateCompanionBuilder = MessagesTableCompanion
    Function({
  Value<int> id,
  Value<String?> type,
  Value<String?> content,
  Value<String?> contentUrl,
  Value<int?> timestamp,
  Value<bool> isSynced,
  Value<int?> roomId,
  Value<int?> sentFromId,
  Value<int?> replyToId,
});

final class $$MessagesTableTableReferences
    extends BaseReferences<_$AppDb, $MessagesTableTable, MessageDB> {
  $$MessagesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

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

  static $UsersTableTable _sentFromIdTable(_$AppDb db) =>
      db.usersTable.createAlias(
          $_aliasNameGenerator(db.messagesTable.sentFromId, db.usersTable.id));

  $$UsersTableTableProcessedTableManager? get sentFromId {
    if ($_item.sentFromId == null) return null;
    final manager = $$UsersTableTableTableManager($_db, $_db.usersTable)
        .filter((f) => f.id($_item.sentFromId!));
    final item = $_typedResult.readTableOrNull(_sentFromIdTable($_db));
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

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentUrl => $composableBuilder(
      column: $table.contentUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get replyToId => $composableBuilder(
      column: $table.replyToId, builder: (column) => ColumnFilters(column));

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

  $$UsersTableTableFilterComposer get sentFromId {
    final $$UsersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sentFromId,
        referencedTable: $db.usersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableTableFilterComposer(
              $db: $db,
              $table: $db.usersTable,
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

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentUrl => $composableBuilder(
      column: $table.contentUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get replyToId => $composableBuilder(
      column: $table.replyToId, builder: (column) => ColumnOrderings(column));

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

  $$UsersTableTableOrderingComposer get sentFromId {
    final $$UsersTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sentFromId,
        referencedTable: $db.usersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableTableOrderingComposer(
              $db: $db,
              $table: $db.usersTable,
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

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get contentUrl => $composableBuilder(
      column: $table.contentUrl, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<int> get replyToId =>
      $composableBuilder(column: $table.replyToId, builder: (column) => column);

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

  $$UsersTableTableAnnotationComposer get sentFromId {
    final $$UsersTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sentFromId,
        referencedTable: $db.usersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableTableAnnotationComposer(
              $db: $db,
              $table: $db.usersTable,
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
    PrefetchHooks Function({bool roomId, bool sentFromId})> {
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
            Value<String?> content = const Value.absent(),
            Value<String?> contentUrl = const Value.absent(),
            Value<int?> timestamp = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int?> roomId = const Value.absent(),
            Value<int?> sentFromId = const Value.absent(),
            Value<int?> replyToId = const Value.absent(),
          }) =>
              MessagesTableCompanion(
            id: id,
            type: type,
            content: content,
            contentUrl: contentUrl,
            timestamp: timestamp,
            isSynced: isSynced,
            roomId: roomId,
            sentFromId: sentFromId,
            replyToId: replyToId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> content = const Value.absent(),
            Value<String?> contentUrl = const Value.absent(),
            Value<int?> timestamp = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int?> roomId = const Value.absent(),
            Value<int?> sentFromId = const Value.absent(),
            Value<int?> replyToId = const Value.absent(),
          }) =>
              MessagesTableCompanion.insert(
            id: id,
            type: type,
            content: content,
            contentUrl: contentUrl,
            timestamp: timestamp,
            isSynced: isSynced,
            roomId: roomId,
            sentFromId: sentFromId,
            replyToId: replyToId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MessagesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({roomId = false, sentFromId = false}) {
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
                if (sentFromId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sentFromId,
                    referencedTable:
                        $$MessagesTableTableReferences._sentFromIdTable(db),
                    referencedColumn:
                        $$MessagesTableTableReferences._sentFromIdTable(db).id,
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
    PrefetchHooks Function({bool roomId, bool sentFromId})>;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$RoomsTableTableTableManager get roomsTable =>
      $$RoomsTableTableTableManager(_db, _db.roomsTable);
  $$UsersTableTableTableManager get usersTable =>
      $$UsersTableTableTableManager(_db, _db.usersTable);
  $$MessagesTableTableTableManager get messagesTable =>
      $$MessagesTableTableTableManager(_db, _db.messagesTable);
}
