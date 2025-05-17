import 'package:drift/drift.dart';
import 'package:drift/native.dart'; // Using SQLite as the database provider
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:zineapp2023/models/newUser.dart';
import 'package:http/http.dart' as http;
import 'package:zineapp2023/utilities/custom_logger.dart';

part 'database.g.dart';

/// Run this in Terminal after deleting the .g file : `dart run build_runner watch` for dev and `dart run build_runner build`
final logger = customLogger();

@DataClassName('Room')
class RoomsTable extends Table {
  IntColumn get id => integer()(); // Setting 'id' as the primary key
  TextColumn get name => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get dpUrl => text().nullable()();
  IntColumn get timestamp => integer().nullable()();
  IntColumn get lastMessageTimestamp => integer().nullable()();
  IntColumn get unreadMessages => integer().nullable()();
  IntColumn get userLastSeen => integer().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UserDB')
class UsersTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().withDefault(const Constant('Anonymous'))();
  TextColumn get email => text().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get pushToken => text().nullable()();
  BoolColumn get registered => boolean().withDefault(const Constant(false))();
  TextColumn get dp => text().withDefault(const Constant(''))();
  BoolColumn get emailVerified => boolean().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RoomMemberDB')
class RoomMemberTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().withDefault(const Constant('Anonymous'))();
  TextColumn get email => text().nullable()();
  TextColumn get role => text().nullable()();
  BoolColumn get registered => boolean().withDefault(const Constant(false))();
  TextColumn get dpUrl => text().withDefault(const Constant(''))();
  BoolColumn get emailVerified => boolean().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RoomMemberMapping')
class RoomMemberMappingTable extends Table {
  IntColumn get roomId =>
      integer().customConstraint('REFERENCES rooms_table(id) NOT NULL')();
  IntColumn get memberId =>
      integer().customConstraint('REFERENCES room_member_table(id) NOT NULL')();

  @override
  Set<Column> get primaryKey => {roomId, memberId};
}

@DataClassName('MessageDB')
class MessagesTable extends Table {
  IntColumn get id => integer()();
  TextColumn get type => text().nullable()();
  TextColumn get textData => text().nullable()();
  IntColumn get fileId =>
      integer().nullable().customConstraint('REFERENCES file_table(id)')();
  IntColumn get pollId =>
      integer().nullable().customConstraint('REFERENCES poll_table(id)')();
  IntColumn get timestamp => integer().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  IntColumn get roomId =>
      integer().nullable().customConstraint('REFERENCES rooms_table(id)')();
  IntColumn get sentFromId =>
      integer().customConstraint('REFERENCES room_member_table(id) NOT NULL')();
  IntColumn get replyToId =>
      integer().nullable().customConstraint('REFERENCES messages_table(id)')();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PollDB')
class PollTable extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get lastVoted => integer().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PollOptionDB')
class PollOptionTable extends Table {
  IntColumn get pollId =>
      integer().customConstraint('REFERENCES poll_table(id) NOT NULL')();
  IntColumn get id => integer()();
  TextColumn get value => text()();
  IntColumn get numVotes => integer()();
  BoolColumn get isVoted => boolean().withDefault(const Constant(false))();
  BoolColumn get voterId => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('FileDB')
class FileTable extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get uri => text()();
  TextColumn get filePath => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get name => text()();
  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  RoomsTable,
  MessagesTable,
  UsersTable,
  FileTable,
  PollTable,
  PollOptionTable,
  RoomMemberTable,
  RoomMemberMappingTable
])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  static Future<void> deleteUserLocalDb(AppDb db) async {
    try {
      await db.batch((batch) {
        batch.deleteAll(db.roomsTable);
        batch.deleteAll(db.messagesTable);
        batch.deleteAll(db.usersTable);
        batch.deleteAll(db.fileTable);
        batch.deleteAll(db.pollTable);
        batch.deleteAll(db.pollOptionTable);
        batch.deleteAll(db.roomMemberTable);
      });
      logger.d("Local DB Cleared");
    } catch (e) {
      logger.e("Error clearing tables: $e");
    }
  }

  static LazyDatabase _openConnection() {
    logger.d("Initializing LazyDatabase connection...");
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'app.db'));
      if (await file.exists()) {
        logger.i("Old database present.");
      }
      return NativeDatabase(file);
    });
  }

  Future<void> initializeIsSyncedColumn() async {
    try {
      await customStatement('UPDATE rooms_table SET isSynced = FALSE');
      logger.d("All rooms updated to unsynced (isSynced = FALSE).");
    } catch (e) {
      logger.e("Error initializing isSynced column: $e");
    }
  }

  Future<int> insertRoomToDB(RoomsTableCompanion room) async {
    try {
      final existingRoom = await (select(roomsTable)
            ..where((t) => t.id.equals(room.id.value)))
          .getSingleOrNull();
      int insertedId;
      if (existingRoom != null) {
        insertedId = await into(roomsTable).insert(room,
            mode: InsertMode.replace);
        logger.d('Room updated successfully with ID: $insertedId');
      } else {
        insertedId = -1;
        await into(roomsTable)
            .insert(room, mode: InsertMode.insert);
        logger.d('Room inserted successfully with ID: ${room.id}');
      }
      return insertedId;
    } catch (e) {
      logger.e('Error inserting room');
      return -1;
    }
  }

  Future<List<Room>> getAllRoomsDB() async {
    try {
      final rooms = await select(roomsTable).get();
      if (rooms.isNotEmpty) {
        logger.d('Successfully fetched ${rooms.length} rooms');
      } else {
        logger.d('No rooms found in the database');
      }
      return rooms;
    } catch (e) {
      logger.e('Error fetching rooms: $e');
      return [];
    }
  }

  Future<List<Room>> getAllProjectsDB() async {
    try {
      final rooms = await select(roomsTable).get();
      final projects =
          rooms.where((room) => room.type != 'announcement').toList();

      if (projects.isNotEmpty) {
        logger.d('Successfully fetched ${projects.length} projects');
      } else {
        logger.d('No projects found in the database');
      }

      return projects;
    } catch (e) {
      logger.e('Error fetching projects: $e');
      return [];
    }
  }

  Future<List<Room>> getAllAnnouncementsDB() async {
    try {
      final rooms = await select(roomsTable).get();
      final announcements =
          rooms.where((room) => room.type == 'announcement').toList();
      logger.d("Number of announcements is ${announcements.length}");
      if (announcements.isNotEmpty) {
        logger.d('Successfully fetched ${announcements.length} announcements');
      } else {
        logger.d('No announcements found in the database');
      }

      return announcements;
    } catch (e) {
      logger.e('Error fetching announcements: $e');
      return [];
    }
  }

  Future<int> deleteUnsyncedRooms() async {
    try {
      final unsyncedRooms = await (select(roomsTable)
            ..where((t) => t.isSynced.equals(false)))
          .get();
      if (unsyncedRooms.isNotEmpty) {
        for (var room in unsyncedRooms) {
          logger.d("Deleting unsynced room with ID: ${room.id}");
        }
        await (delete(roomsTable)..where((t) => t.isSynced.equals(false))).go();
        logger.d("Successfully deleted unsynced rooms");
        return -1;
      } else {
        logger.d("No unsynced rooms found to delete.");
        return 0;
      }
    } catch (e) {
      logger.e("Error in deleting unsynced rooms: $e");
      return 0;
    }
  }

  Future<String> createUserImagePath(NewUserModel userData) async {
    try {
      final sanitizedUrl = Uri.encodeFull(userData.dp!.trim());

      final response = await http.get(Uri.parse(sanitizedUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to load image from URL');
      }
      final imageBytes = response.bodyBytes;
      final directory = await getApplicationDocumentsDirectory();
      final userDirectoryPath =
          '${directory.path}/${userData.name}/${userData.id}';
      final userDirectory = Directory(userDirectoryPath);
      if (!await userDirectory.exists()) {
        await userDirectory.create(recursive: true);
      }
      final filePath = '${userDirectory.path}/dp.png';
      final file = File(filePath);
      userData.dp != null ? await file.writeAsBytes(imageBytes) : '';
      return filePath;
    } catch (e) {
      logger.e("Error in creating userDp path: $e");
      return '';
    }
  }

  Future<int> upsertUserDB(NewUserModel userData) async {
    String filePath =
        userData.dp != null ? await createUserImagePath(userData) : "";
    final userCompanion = UsersTableCompanion(
      id: Value(userData.id!),
      name: Value(userData.name!),
      email: Value(userData.email),
      type: Value(userData.type),
      dp: Value(filePath),
      registered:
          Value(userData.registered != null ? userData.registered! : false),
      emailVerified: Value(userData.registered),
      pushToken: Value(
          userData.pushToken),
    );
    try {
      final insertedId = await into(usersTable)
          .insert(userCompanion, mode: InsertMode.replace);
      logger.d('User upserted successfully with ID: ${userCompanion.id.value}');
      return insertedId;
    } catch (e) {
      logger.e('Error in upserting user: $e');
      return -1;
    }
  }

  Future<UserDB?> getUserDetailsFromLocalDB(String emailId) async {
    try {
      final user = await (select(usersTable)
            ..where((t) => t.email.equals(emailId)))
          .getSingleOrNull();
      if (user != null) {
        logger.d("User found: ${user.name}");
      } else {
        logger.d("User not found");
      }
      return user;
    } catch (e) {
      logger.e("Error: getUserDetailsFromLocalDb: $e");
      return null;
    }
  }

  Future<RoomMemberDB?> fetchRoomMemberById(int memberId) async {
    return (select(roomMemberTable)..where((tbl) => tbl.id.equals(memberId)))
        .getSingleOrNull();
  }

  Future<void> saveRoomMemberMapping(int roomId, List<int> memberIds) async {
    try {
      await batch((batch) {
        for (final memberId in memberIds) {
          batch.insert(
            roomMemberMappingTable,
            RoomMemberMappingTableCompanion.insert(
              roomId: roomId,
              memberId: memberId,
            ),
            mode: InsertMode.insertOrIgnore,
          );
        }
      });
      logger.d("Room member mappings saved successfully for room ID: $roomId");
    } catch (e) {
      logger.e("Error saving room member mappings: $e");
    }
  }

  Future<Map<String, RoomMemberModel>> getRoomMembersByRoomId(
      int roomId) async {
    try {
      final query = select(roomMemberTable).join([
        innerJoin(
          roomMemberMappingTable,
          roomMemberMappingTable.memberId.equalsExp(roomMemberTable.id),
        )
      ])
        ..where(roomMemberMappingTable.roomId.equals(roomId));

      final results = await query.get();

      final roomMembersMap = {
        for (var row in results)
          row.readTable(roomMemberTable).id.toString(): RoomMemberModel(
            id: row.readTable(roomMemberTable).id,
            name: row.readTable(roomMemberTable).name,
            email: row.readTable(roomMemberTable).email,
            role: row.readTable(roomMemberTable).role,
            dpUrl: row.readTable(roomMemberTable).dpUrl,
          )
      };

      return roomMembersMap;
    } catch (e) {
      logger.e("Error fetching room members by room ID: $e");
      return {};
    }
  }

  //=========================POLLS============================================
}
