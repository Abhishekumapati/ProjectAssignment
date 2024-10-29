*** Settings ***
#Library     Browser
Library     SeleniumLibrary
Library     OperatingSystem
Library     JSONLibrary

*** Variables ***
${Browser}      chrome



*** Test Cases ***
Test1
     #Open the url
     Open Browser       https://testpages.herokuapp.com/styled/tag/dynamic-table.html       ${Browser}
     Maximize Browser Window
     #Verify that Dyanmic HTML Table Tag page is visible or not
     Wait Until Element Is Visible    //h1[text()='Dynamic HTML TABLE Tag']     1m
     Capture Page Screenshot
     #Click on Table Data element
     Wait Until Keyword Succeeds    1m  1s   Click Element    //summary[text()='Table Data']
     Get Data from Json file
     Wait Until Keyword Succeeds    1min  1s   Click Button      Refresh Table
     Verify that data should be populated in Dynamic table
     Capture Page Screenshot
     Sleep    10s
     Close Browser

*** Keywords ***
Get Data from Json file
    Press Keys    id:jsondata    CONTROL+A
    Sleep    10s
    ${file}=    Load Json From File    ${CURDIR}${/}TestData.json
    #Get data from the json file
    Sleep    10s
    Wait Until Keyword Succeeds    1m  1s   Input Text    id:jsondata    ${file}
    Sleep    20s
   
Verify that data should be populated in Dynamic table
    ${name_list}=    Create List    Bob      George      Sara       Conor       Jennifer
    FOR    ${itr}    IN    @{name_list}
    ${name}=    Get Text    //td[text()='${itr}']
    ${status}=    Run Keyword and Return Status    Log To Console    ${itr}    1min
    Run Keyword If    '${status}' == 'True'    Log    name is populated
    ...    ELSE    FAIL    names is not populated.
    END
    ${age_list}=    Create List     20      42      42      40      42
    FOR    ${itr}    IN    @{age_list}
    ${age}=     Get Text    //td[text()='${itr}']
    ${status}=    Run Keyword and Return Status    Log To Console    ${itr}    1min
    Run Keyword If    '${status}' == 'True'    Log    age is populated
    ...    ELSE    FAIL    age is not populated.
    END
    ${gender_list}=    Create List      male    male   female     male      female
    FOR    ${itr}    IN    @{gender_list}
    ${gender}=  Get Text    //td[text()='${itr}']
    ${status}=    Run Keyword and Return Status    Log To Console    ${itr}    1min
    Run Keyword If    '${status}' == 'True'    Log    genders is populated
    ...    ELSE    FAIL    gender is not populated.
    END




