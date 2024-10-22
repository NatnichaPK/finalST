*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Base URL
Suite Teardown    Close Browser

*** Variables ***
${BASE URL}       http://localhost:3000
${BROWSER}        Edge

*** Test Cases ***
Test Footer Display
    Verify Footer Is Present
    Verify Footer Contact Information Is Correct

*** Keywords ***
Open Browser To Base URL
    Open Browser    ${BASE URL}    ${BROWSER}
    Log    Opened browser at ${BASE URL}

Verify Footer Is Present
    Log    Verifying footer is present
    Element Should Be Visible    id=contact

Verify Footer Contact Information Is Correct
    Log    Checking footer contact information
    ${footer_text}=    Get Text    id=contact
    Should Contain    ${footer_text}    Email: contact@petcare.com
    Should Contain    ${footer_text}    Phone: +123 456 7890
    Should Contain    ${footer_text}    © 2024 PetCare. All Rights Reserved.
