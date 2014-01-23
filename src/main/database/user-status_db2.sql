CREATE TABLE userStatus (
    username        VARCHAR(64)         NOT NULL,
    resource        VARCHAR(64)         NOT NULL,
    online INT NOT NULL,
    presence CHAR(15),
    statusText CHAR(30),
    lastIpAddress   CHAR(15)            NOT NULL,
    lastLoginDate   CHAR(15)            NOT NULL,
    lastLogoffDate CHAR(15),
    PRIMARY KEY(username, resource)
);

CREATE TABLE userStatusHistory (
    historyID       BIGINT              NOT NULL,
    username VARCHAR(64) NOT NULL,
    resource VARCHAR(64) NOT NULL,
    lastIpAddress CHAR(15) NOT NULL,
    lastLoginDate CHAR(15) NOT NULL,
    lastLogoffDate  CHAR(15)            NOT NULL,
    PRIMARY KEY(historyID)
);

INSERT INTO jiveVersion (name, version) VALUES ('user-status', 0);
