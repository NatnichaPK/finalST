*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Base URL
Suite Teardown    Close Browser

*** Variables ***
${BASE URL}       http://localhost:3000
${BROWSER}        Edge

*** Test Cases ***
Test Navbar Home Link
    Verify Navbar Link Is Present    Home    /
    Click Navbar Link    Home
    Page Should Be Open    /

Test Navbar Login Link
    Verify Navbar Link Is Present    Login    /Login/login.html
    Click Navbar Link    Login
    Page Should Be Open    /Login/login.html

Test Navbar Register Link
    Verify Navbar Link Is Present    Register    /Register/register.html
    Click Navbar Link    Register
    Page Should Be Open    /Register/register.html

*** Keywords ***
Open Browser To Base URL
    Open Browser    ${BASE URL}    ${BROWSER}

Verify Navbar Link Is Present
    [Arguments]    ${link_text}    ${expected_url}
    Element Should Be Visible    //li/a[contains(., '${link_text}')]
    Element Text Should Be       //li/a[contains(., '${link_text}')]    ${link_text}

Click Navbar Link
    [Arguments]    ${link_text}
    Click Element    //li/a[contains(., '${link_text}')]

Page Should Be Open
    [Arguments]    ${expected_url}
    Location Should Be    ${BASE URL}${expected_url}
