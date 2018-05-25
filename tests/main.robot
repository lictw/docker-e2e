*** Settings ***
Documentation   Tests for simple web application
Suite Teardown  Close Browser

Library   Collections
Library   SeleniumLibrary

*** Variables ***
${BROWSER}  Chrome
${SPEED}    0
&{PAIRS}    key=value
...         KEY=VALUE
...         123=45678
...         kV4=vK098

*** Test Cases ***

Open Web Application And Set Pairs

    Open Browser        http://%{APPLICATION_HOST}:%{APPLICATION_PORT}  ${BROWSER}  remote_url=http://%{SELENIUM_HOST}:%{SELENIUM_PORT}/wd/hub
    Set Selenium Speed  ${SPEED}

    ${keys}   Get Dictionary Keys  ${PAIRS}
    :FOR      ${key}    IN  @{keys}
    \         ${value}  Get From Dictionary  ${PAIRS}  ${key}
    \         Set Pair  ${key}  ${value}

Check Pairs

    ${keys}   Get Dictionary Keys  ${PAIRS}
    :FOR      ${key}      IN  @{keys}
    \         ${value}    Get From Dictionary  ${PAIRS}  ${key}
    \         Check Pair  ${key}  ${value}

*** Keywords ***

Set Pair
    [Arguments]  ${key}  ${value}
    Input Text                  key       ${key}
    Input Text                  value     ${value}
    Click Button                set

Check Pair
    [Arguments]  ${key}  ${value}
    Clear Fields
    Input Text                  key       ${key}
    Click Button                get
    Textfield Value Should Be   id=value  ${value}

Clear Fields
    Clear Element Text  key
    Clear Element Text  value
