const totalAttemptsToInitiate = 20;
const waitsBetweenInitiateAttempts = 1000;
const replicaSetConfig = {
  _id: "rs1",
  version: 1,
  members: [
    { _id: 0, host: "mongo1:27017", priority: 1 },
    { _id: 1, host: "mongo2:27017", arbiterOnly: true, priority: 0 },
    { _id: 2, host: "mongo3:27017", priority: 0.5 },
  ],
};

function initiateReplicaSet(config) {
  print("initiateReplicaSet");
  res = rs.initiate(config, { force: true });

  if (res.code === 23) {
    // Already initialized
    return;
  }
  if (res.errmsg !== "") {
    printjson(res);
    throw "Replica set failed to initialize";
  }
}

function hasPrimary() {
  set = rs.status();
  seenPrimary = false;
  if (!set.members) {
    return false;
  }
  set.members.forEach(function (member) {
    if (member.stateStr === "PRIMARY") seenPrimary = true;
  });
  return seenPrimary;
}

function waitForPrimary(maxAttempts, string) {
  for (i = 0; i < maxAttempts; ++i) {
    print("Checking for PRIMARY " + i);
    if (hasPrimary()) {
      print(string);
      return;
    }
    sleep(1000);
  }
  throw `No primary found in ${maxAttempts} seconds`;
}

function initializeReplicaSet(config, attempts) {
  for (i = 0; i < attempts; ++i) {
    print("Initiate replica set " + i);
    try {
      initiateReplicaSet(config);
      return;
    } catch (e) {
      printjson(e);
      sleep(waitsBetweenInitiateAttempts);
    }
  }
  throw "Failed to configure a replica set.";
}

initializeReplicaSet(replicaSetConfig, totalAttemptsToInitiate);
waitForPrimary(20, "PRIMARY ready!");
print("Setting profiling level 2");
db.setProfilingLevel(2);
