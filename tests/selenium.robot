*** Settings ***
Documentation   Fully testing of a simple web application via selenium
Resource        resource.robot
Suite Teardown  Close Browser

*** Variables ***

${SPEED}    0
${REMOTE}   http://%{SELENIUM_HOST}:%{SELENIUM_PORT}/wd/hub

${NGINX_HOST}         %{NGINX_HOST}
${NGINX_HTTP_PORT}    %{NGINX_HTTP_PORT}
${NGINX_HTTPS_PORT}   %{NGINX_HTTPS_PORT}

${INITIAL_URL}        ${APPLICATION_URL}
${APPLICATION_URL}    http://%{APPLICATION_HOST}:%{APPLICATION_PORT}

*** Test Cases ***
Open Web Application And Set Pairs
  Open Web Application And Set Pairs

Check Pairs At Back End
  Check Pairs At  ${APPLICATION_URL}

Check Pairs At HTTP Front End
  Check Pairs At  ${NGINX_HTTP_URL}

Check Pairs At HTTPS Front End
  Check Pairs At  ${NGINX_HTTPS_URL}
