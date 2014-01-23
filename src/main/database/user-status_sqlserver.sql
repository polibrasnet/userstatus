CREATE TABLE userStatus (
    username        NVARCHAR(64)         NOT NULL,
    resource        NVARCHAR(64)         NOT NULL,
    online          TINYINT             NOT NULL,
    presence        NVARCHAR(15),
    statusText      NVARCHAR(30),
    lastIpAddress   NVARCHAR(15)            NOT NULL,
    lastLoginDate   NVARCHAR(15)            NOT NULL,
    lastLogoffDate  NVARCHAR(15),
    CONSTRAINT userStatus_pk PRIMARY KEY (username, resource)
);

CREATE TABLE userStatusHistory (
    historyID       BIGINT              NOT NULL,
    username        NVARCHAR(64)         NOT NULL,
    resource        NVARCHAR(64)         NOT NULL,
    lastIpAddress   NVARCHAR(15)            NOT NULL,
    lastLoginDate   NVARCHAR(15)            NOT NULL,
    lastLogoffDate  NVARCHAR(15)            NOT NULL,
    CONSTRAINT userStatusHistory_pk PRIMARY KEY (historyID)
);

INSERT INTO jiveVersion (name, version) VALUES ('user-status', 0);