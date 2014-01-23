CREATE TABLE IF NOT EXISTS userStatus (
    username VARCHAR(64) NOT NULL,
    resource VARCHAR(64) NOT NULL,
    online INTEGER NOT NULL,
    presence CHAR(15),
    statusText TEXT,
    lastIpAddress CHAR(15) NOT NULL,
    lastLoginDate CHAR(15) NOT NULL,
    lastLogoffDate CHAR(15),
    constraint pk_userStatus PRIMARY KEY  (username, resource)
);

CREATE TABLE IF NOT EXISTS userStatusHistory (
    historyID BIGINT NOT NULL,
    username VARCHAR(64) NOT NULL,
    resource VARCHAR(64) NOT NULL,
    lastIpAddress CHAR(15) NOT NULL,
    lastLoginDate CHAR(15) NOT NULL,
    lastLogoffDate CHAR(15) NOT NULL,
    constraint pk_userStatusHistory PRIMARY KEY (historyID)
);

INSERT INTO jiveVersion (name, version) VALUES ('user-status', 0);