*** Settings ***
Documentation  Resource file for test suites

Library  Collections
Library  SeleniumLibrary

*** Variables ***

${BROWSER}  Chrome
${SPEED}    0

&{PAIRS}    key=value
...         KEY=VALUE
...         123=45678
...         kV4=vK098

${REMOTE}

${NGINX_HOST}         localhost
${NGINX_HTTP_PORT}    8080
${NGINX_HTTPS_PORT}   1337

${INITIAL_URL}        ${NGINX_HTTP_URL}
${NGINX_HTTP_URL}     http://${NGINX_HOST}:${NGINX_HTTP_PORT}
${NGINX_HTTPS_URL}    https://${NGINX_HOST}:${NGINX_HTTPS_PORT}

*** Keywords ***

Open Web Application And Set Pairs

  Open Browser        ${INITIAL_URL}  ${BROWSER}  remote_url=${REMOTE}
  Set Selenium Speed  ${SPEED}

  ${keys}   Get Dictionary Keys  ${PAIRS}
  :FOR      ${key}    IN  @{keys}
  \         ${value}  Get From Dictionary  ${PAIRS}  ${key}
  \         Set Pair  ${key}  ${value}

Check Pairs At

  [Arguments]   ${url}
  Go To         ${url}

  ${keys}   Get Dictionary Keys  ${PAIRS}
  :FOR      ${key}      IN  @{keys}
  \         ${value}    Get From Dictionary  ${PAIRS}  ${key}
  \         Check Pair  ${key}  ${value}

Set Pair
  [Arguments]   ${key}  ${value}
  Input Text    key     ${key}
  Input Text    value   ${value}
  Click Button  set

Check Pair
  [Arguments]                 ${key}    ${value}
  Clear Fields
  Input Text                  key       ${key}
  Click Button                get
  Textfield Value Should Be   id=value  ${value}

Clear Fields
  Clear Element Text  key
  Clear Element Text  value
