*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Base URL
Suite Teardown    Close Browser

*** Variables ***
${BASE URL}       http://localhost:3000
${BROWSER}        Edge
${DUPLICATE_EMAIL}    Cateater2333@gmail.com

*** Test Cases ***
Register New User
    [Documentation]    Test case to register a new user
    Go To Register Page
    Fill Registration Form    NewUser    newuser@example.com    newpassword
    Submit Registration
    Verify Registration Success

Register Duplicated User
    [Documentation]    Test case to register a user with a duplicate email
    Go To Register Page
    Fill Registration Form    NewUser    ${DUPLICATE_EMAIL}    newpassword
    Submit Registration
    Verify Registration Failure    Email already exists!

*** Keywords ***
Open Browser To Base URL
    Open Browser    ${BASE URL}    ${BROWSER}
    Log    Opened browser at ${BASE URL}

Go To Register Page
    Go To    ${BASE URL}/Register/register.html
    Log    Navigated to registration page

Fill Registration Form
    [Arguments]    ${username}    ${email}    ${password}
    Input Text    id=username    ${username}
    Input Text    id=email    ${email}
    Input Text    id=password    ${password}
    Input Text    id=confirmpassword    ${password}

Submit Registration
    Click Button    id=register_button
    Log    Submitted registration form

Verify Registration Success
    Title Should Be    Login

Verify Registration Failure
    [Arguments]    ${expected_error}
    Log    Verifying registration failure
    Element Should Be Visible    id=error-message
    ${error_message}=    Get Text    id=error-message
    Should Contain    ${error_message}    ${expected_error}