*** Settings ***
Documentation   Locally testing of a simple web application
Resource        resource.robot
Suite Teardown  Close Browser

*** Test Cases ***
Open Web Application And Set Pairs
  Open Web Application And Set Pairs

Check Pairs At HTTP Front End
  Check Pairs At  ${NGINX_HTTP_URL}

Check Pairs At HTTPS Front End
  Check Pairs At  ${NGINX_HTTPS_URL}
