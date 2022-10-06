var replStatus = rs.status();

if (replStatus && replStatus.ok === 1) {
  print(" ### Replication OK");
  printjson(replStatus);
} else {
  print(" ### Starting replication...");
  printjson(rs.initiate(rs_cluster));
  sleep(5000);
  print(" ");
  print(" ### Replica Set status");
  replStatus = rs.status()
  printjson(replStatus);
}

sleep(5000);

const dbUser = "dbAdmin";
const dbPass = "dbAdminPass";

if (replStatus && replStatus.ok === 1) {
  db = db.getSiblingDB("admin");

  if (!db.auth(dbUser, dbPass)) {
    print(" ### Creating DB Admin user...");

    var adminUser = db.createUser({
      user: dbUser,
      pwd: dbPass,
      roles: [
        { role: "userAdminAnyDatabase", db: "admin" },
        { role: "root", db: "admin" },
      ],
    });

    var dbAdimOk = db.auth(dbUser, dbPass);

    print("DB Admin authentication after create: " + dbAdimOk);
  } else {
    print(" ### Logged with DB Admin user");
  }
} else {
  print(" ### Replication is not running:");
  printjson(replStatus);
}

var sleep = function (milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if (new Date().getTime() - start > milliseconds) {
      break;
    }
  }
};
