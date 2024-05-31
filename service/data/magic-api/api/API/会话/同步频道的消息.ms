{
  "properties" : { },
  "id" : "d1918bd63d5344208b8c8ff447ff9916",
  "script" : null,
  "groupId" : "1fae9227d89a49fc943a45c59e803338",
  "name" : "同步频道的消息",
  "createTime" : 1717060652941,
  "updateTime" : 1716877305867,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/messagesync",
  "method" : "POST",
  "parameters" : [ ],
  "options" : [ ],
  "requestBody" : "{\n    \"login_uid\": \"6\",\n    \"channel_id\": \"71bb0f6c1d9b4e89982cd9c3c3210144\",\n    \"channel_type\": 2,\n    \"start_message_seq\": 0,\n    \"end_message_seq\": 0,\n    \"pull_mode\": 0,\n    \"limit\": 50\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"start_message_seq\": 0,\n        \"end_message_seq\": 0,\n        \"more\": 0,\n        \"messages\": [\n            {\n                \"header\": {\n                    \"no_persist\": 0,\n                    \"red_dot\": 1,\n                    \"sync_once\": 0\n                },\n                \"setting\": 0,\n                \"message_id\": 1768461830608388000,\n                \"message_idstr\": \"1768461830608388096\",\n                \"client_msg_no\": \"ae4deb932a3685431aaab73ddf8330923\",\n                \"message_seq\": 1,\n                \"from_uid\": \"6\",\n                \"channel_id\": \"71bb0f6c1d9b4e89982cd9c3c3210144\",\n                \"channel_type\": 2,\n                \"expire\": 0,\n                \"timestamp\": 1710469131,\n                \"payload\": \"eyJjb250ZW50IjoiPHA+MTIzMTIzPC9wPiIsInR5cGUiOjF9\"\n            },\n            {\n                \"header\": {\n                    \"no_persist\": 0,\n                    \"red_dot\": 1,\n                    \"sync_once\": 0\n                },\n                \"setting\": 0,\n                \"message_id\": 1768463741122248700,\n                \"message_idstr\": \"1768463741122248704\",\n                \"client_msg_no\": \"a512e163b7f87ffb2ba05de151a6d90b3\",\n                \"message_seq\": 2,\n                \"from_uid\": \"6\",\n                \"channel_id\": \"71bb0f6c1d9b4e89982cd9c3c3210144\",\n                \"channel_type\": 2,\n                \"expire\": 0,\n                \"timestamp\": 1710469587,\n                \"payload\": \"eyJjb250ZW50IjoiPHA+MTIzMTMxPC9wPiIsInR5cGUiOjF9\"\n            },\n            {\n                \"header\": {\n                    \"no_persist\": 0,\n                    \"red_dot\": 1,\n                    \"sync_once\": 0\n                },\n                \"setting\": 0,\n                \"message_id\": 1768473429670887400,\n                \"message_idstr\": \"1768473429670887424\",\n                \"client_msg_no\": \"5a2948deed2617c6423c8177f8d4e6ad3\",\n                \"message_seq\": 3,\n                \"from_uid\": \"6\",\n                \"channel_id\": \"71bb0f6c1d9b4e89982cd9c3c3210144\",\n                \"channel_type\": 2,\n                \"expire\": 0,\n                \"timestamp\": 1710471896,\n                \"payload\": \"eyJjb250ZW50IjoiPHA+MTIzMTMxMzwvcD4iLCJ0eXBlIjoxfQ==\"\n            },\n            {\n                \"header\": {\n                    \"no_persist\": 0,\n                    \"red_dot\": 1,\n                    \"sync_once\": 0\n                },\n                \"setting\": 0,\n                \"message_id\": 1768480476172910600,\n                \"message_idstr\": \"1768480476172910592\",\n                \"client_msg_no\": \"b0f92a9600619207d74eb45edca39a013\",\n                \"message_seq\": 4,\n                \"from_uid\": \"6\",\n                \"channel_id\": \"71bb0f6c1d9b4e89982cd9c3c3210144\",\n                \"channel_type\": 2,\n                \"expire\": 0,\n                \"timestamp\": 1710473576,\n                \"payload\": \"eyJjb250ZW50IjoiPHA+MTIzMTIzPC9wPiIsInR5cGUiOjF9\"\n            },\n            {\n                \"header\": {\n                    \"no_persist\": 0,\n                    \"red_dot\": 1,\n                    \"sync_once\": 0\n                },\n                \"setting\": 0,\n                \"message_id\": 1768480892868624400,\n                \"message_idstr\": \"1768480892868624384\",\n                \"client_msg_no\": \"f2a2ac242ae7d6fd28e7624c868258e43\",\n                \"message_seq\": 5,\n                \"from_uid\": \"6\",\n                \"channel_id\": \"71bb0f6c1d9b4e89982cd9c3c3210144\",\n                \"channel_type\": 2,\n                \"expire\": 0,\n                \"timestamp\": 1710473676,\n                \"payload\": \"eyJjb250ZW50IjoiPHA+MjMxMjMxMzwvcD4iLCJ0eXBlIjoxfQ==\"\n            },\n            {\n                \"header\": {\n                    \"no_persist\": 0,\n                    \"red_dot\": 1,\n                    \"sync_once\": 0\n                },\n                \"setting\": 0,\n                \"message_id\": 1768481070447067100,\n                \"message_idstr\": \"1768481070447067136\",\n                \"client_msg_no\": \"daa678cf639a4b3d99cc2364707b0b0b3\",\n                \"message_seq\": 6,\n                \"from_uid\": \"6\",\n                \"channel_id\": \"71bb0f6c1d9b4e89982cd9c3c3210144\",\n                \"channel_type\": 2,\n                \"expire\": 0,\n                \"timestamp\": 1710473718,\n                \"payload\": \"eyJjb250ZW50IjoiPHA+MTM0MTQxNDwvcD4iLCJ0eXBlIjoxfQ==\"\n            }\n        ]\n    },\n    \"timestamp\": 1710492660729,\n    \"executeTime\": 5\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : {
    "name" : "",
    "value" : "",
    "description" : "",
    "required" : false,
    "dataType" : "Object",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : [ {
      "name" : "code",
      "value" : "200",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "message",
      "value" : "success",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "data",
      "value" : "Hello magic-api",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "timestamp",
      "value" : "1710492628024",
      "description" : "",
      "required" : false,
      "dataType" : "Long",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "executeTime",
      "value" : "8",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    } ]
  }
}
================================
import log
import http
import env
var wukongIMUrl = env.get("wukongim.endpoint")
log.info("wukongIMUrl" + wukongIMUrl);

var responseEntity = http.connect(wukongIMUrl+'/channel/messagesync').contentType('application/json').body({
    login_uid: body.login_uid,
    channel_id: body.channel_id,
    channel_type: 2, //TODO 2代表群组,本期只考虑群组的
    start_message_seq: 0,
    end_message_seq: 0,
    pull_mode: 1,
    limit: 50
}).post().getBody();
log.info("执行消息同步" + responseEntity)

return responseEntity