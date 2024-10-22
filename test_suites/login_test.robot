*** Settings ***
Documentation     A simple test suite for the login functionality.
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}      http://localhost:3000/Login/login.html
${BROWSER}        Edge

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Input Username    Cateater2333@gmail.com
    Input Password    soyjob
    Submit Credentials
    Welcome Page Should Be Open
    [Teardown]    Close Browser

inValid Login
    Open Browser To Login Page
    Input Username    incorrectuser@google.com
    Input Password    wrongPW
    Submit Credentials
    Error Page Should Be Open
    [Teardown]    Close Browser

Valid Logout
    Open Browser To Login Page
    Input Username    Cateater2333@gmail.com
    Input Password    soyjob
    Submit Credentials
    Welcome Page Should Be Open
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Login

Input Username
    [Arguments]    ${username}
    Input Text    email    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit Credentials
    Click Button    Login-btn

Welcome Page Should Be Open
    Title Should Be    Pet Care Home

Error Page Should Be Open
    Location Should Be    http://localhost:3000/Login/login.html?error=user_not_found

Log Out
    Click Link    id=Log_Out
    Title Should Be    Pet Care Home
