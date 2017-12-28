*** Settings ***
Library  Collections
Library  RequestsLibrary


*** Settings ***
Test Setup  Create Session  SERVER  http://127.0.0.1:8002
Test Teardown  Delete All Sessions


*** Test Cases ***
Client Gets Request Without Message
    Client Sends Message  ${NONE}
    Should Be Equal  ${RESPONSE.status_code}  ${400}

Client Sends Valid Messages
    [Template]  Client Sends ${message} And Gets Accepted
                aa
                aBcD9_0
                AA
                1234
                __
                abCD0123__
                _______
                00
                _123456789_
                abcdEFGH


Client Sends Invalid Messages
    [Template]  Client Sends ${message} And Gets Not Accepted
                ${EMPTY}
                _
                a
                _0123456789_
                ___abcdegh123123
                abcd(0_
                $$
                !@#$
                """
                ----


*** Keywords ***
Client Sends ${message} And Gets Accepted
    Client Sends Message  ${message}
    Should Be Equal  ${RESPONSE.status_code}  ${200}
    Server Should Accept Message

Client Sends ${message} And Gets Not Accepted
    Client Sends Message  ${message}
    Should Be Equal  ${RESPONSE.status_code}  ${200}
    Server Should Not Accept Message

Client Sends Message
    [Documentation]  Client gets request with ${message} in header 'iws', check status code 200 and set the value of response's header 'Accepted' in the test variable.
    [Arguments]  ${message}
    &{header}  Create Dictionary  iws=${message}
    ${RESPONSE}  Get Request     SERVER  /  headers=${header}
    Set Test Variable     ${RESPONSE}

Server Should Accept Message
    Should Be Equal  ${RESPONSE.headers['Accepted']}  true

Server Should Not Accept Message
    Should Be Equal  ${RESPONSE.headers['Accepted']}  false