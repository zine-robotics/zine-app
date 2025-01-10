import 'package:drift/drift.dart';
import 'package:drift/native.dart'; // Using SQLite as the database provider
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/models/newUser.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

part 'database.g.dart';

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
  BoolColumn get isSynced => boolean().withDefault(Constant(false))();
  Set<Column> get primaryKey => {id};
}

@DataClassName('UserDB')
class UsersTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().withDefault(Constant('Anonymous'))();
  TextColumn get email => text().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get pushToken => text().nullable()();
  BoolColumn get registered => boolean().withDefault(Constant(false))();
  TextColumn get dp => text().withDefault(Constant(''))();
  BoolColumn get emailVerified => boolean().nullable()();
  Set<Column> get primaryKey => {id};
}

@DataClassName('RoomMemberDB')
class RoomMemberTable extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get name => text().withDefault(Constant('Anonymous'))();
  TextColumn get email => text()();
  TextColumn get role => text().nullable()();
  BoolColumn get registered => boolean().withDefault(Constant(false))();
  TextColumn get dpUrl => text().withDefault(Constant(''))();
  BoolColumn get emailVerified => boolean().nullable()();
  @override
  Set<Column> get primaryKey => {email};
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
  BoolColumn get isSynced => boolean().withDefault(Constant(false))();
  IntColumn get roomId =>
      integer().nullable().customConstraint('REFERENCES rooms_table(id)')();
  TextColumn get sentFromName =>
      text().customConstraint('REFERENCES room_member_table(name) NOT NULL')();
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
  IntColumn get id => integer().nullable()();
  TextColumn get value => text()();
  IntColumn get numVotes => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('FileDB')
class FileTable extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get name => text()();
}

@DriftDatabase(tables: [
  RoomsTable,
  MessagesTable,
  UsersTable,
  FileTable,
  PollTable,
  PollOptionTable,
  RoomMemberTable
])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    print("Initializing LazyDatabase connection...");
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      // print("Database folder path: ${dbFolder.path}");
      final file = File(p.join(dbFolder.path, 'app.db'));
      if (await file.exists()) {
        await file.delete();
        print("Old database Deleted.");
      }
      return NativeDatabase(file);
    });
  }

  Future<void> initializeIsSyncedColumn() async {
    try {
      await customStatement('UPDATE rooms_table SET isSynced = FALSE');
      // print("All rooms updated to unsynced (isSynced = FALSE).");
    } catch (e) {
      print("Error initializing isSynced column: $e");
    }
  }

// Insert function for adding a room
  Future<int> insertRoomToDB(RoomsTableCompanion room) async {
    try {
      final existingRoom = await (select(roomsTable)
            ..where((t) => t.id.equals(room.id.value)))
          .getSingleOrNull();
      int insertedId;
      if (existingRoom != null) {
        // Room exists, it's being updated
        insertedId = await into(roomsTable).insert(room,
            mode: InsertMode.replace); // Replace existing room data
        // print('Room updated successfully with ID: $insertedId');
      } else {
        // Room doesn't exist, it's being inserted
        insertedId = -1;
        await into(roomsTable)
            .insert(room, mode: InsertMode.insert); // Insert new room
        // print('Room inserted successfully with ID: ${room.id}');
      }
      return insertedId;
    } catch (e) {
      print('Error inserting room: $e');
      return -1; // Return failure code if insertion fails
    }
  }

  // Function to get all rooms from the database
  Future<List<Room>> getAllRoomsDB() async {
    try {
      final rooms = await select(roomsTable).get();
      if (rooms.isNotEmpty) {
        // print('Successfully fetched ${rooms.length} rooms');
      } else {
        // print('No rooms found in the database');
      }
      return rooms; // Returning the list of rooms
    } catch (e) {
      // print('Error fetching rooms: $e');
      return []; // Return an empty list in case of error
    }
  }

  Future<List<Room>> getAllProjectsDB() async {
    try {
      final rooms = await select(roomsTable).get();
      // Filter rooms based on the type being 'project'
      final projects =
          rooms.where((room) => room.type != 'announcement').toList();

      if (projects.isNotEmpty) {
        // print('Successfully fetched ${projects.length} projects');
      } else {
        // print('No projects found in the database');
      }

      return projects; // Returning the filtered list of projects
    } catch (e) {
      // print('Error fetching projects: $e');
      return []; // Return an empty list in case of error
    }
  }

  Future<List<Room>> getAllAnnouncementsDB() async {
    try {
      final rooms = await select(roomsTable).get();
      // Filter rooms based on the type being 'announcement'
      final announcements =
          rooms.where((room) => room.type == 'announcement').toList();

      if (announcements.isNotEmpty) {
        // print('Successfully fetched ${announcements.length} announcements');
      } else {
        // print('No announcements found in the database');
      }

      return announcements;
    } catch (e) {
      // print('Error fetching announcements: $e');
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
          // print("Deleting unsynced room with ID: ${room.id}");
        }
        await (delete(roomsTable)..where((t) => t.isSynced.equals(false))).go();
        // print("Successfully deleted unsynced rooms");
        return -1;
      } else {
        // print("No unsynced rooms found to delete.");
        return 0; // No rows were deleted
      }
    } catch (e) {
      print("Error in deleting unsynced rooms: $e");
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
      print("error in creating userDp path:$e");
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
      emailVerified: Value(userData.registered), // Adjust based on your data
      pushToken: Value(
          userData.pushToken != null ? userData.pushToken! : null), // Example
    );
    try {
      final insertedId = await into(usersTable)
          .insert(userCompanion, mode: InsertMode.replace);
      // print('User upserted successfully with ID: ${userCompanion.id.value}');
      return insertedId;
    } catch (e) {
      print('Error in upserting user: $e');
      return -1;
    }
  }

  Future<UserDB?> getUserDetailsFromLocalDB(String emailId) async {
    try {
      final user = await (select(usersTable)
            ..where((t) => t.email.equals(emailId)))
          .getSingleOrNull();
      if (user != null) {
        print("user found :${user.name}");
      } else {
        print("user not found");
      }
      return user;
    } catch (e) {
      print("ERROR:getUserDetailsFromLocalDb :${e}");
      return null;
    }
  }

  //=========================POLLS============================================
}
