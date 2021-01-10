*** Setting ***
Library    RequestsLibrary
Library    SeleniumLibrary
Resource    ${CURDIR}/keywords.robot
Variables    ${CURDIR}/testdata.yaml
Suite Setup    Log To Console    Welcome to my automation testing! :D
Suite Teardown    SeleniumLibrary.Close All Browsers

*** Test Cases ***
##Question 3###
Login success
    [Documentation]    To verify that a user can login successfully when they put a correct username and password
    [Tags]    Q3    Q3TC1
    [Setup]    Open herokuspp
    keywords.Login    ${valid_account}[username]    ${valid_account}[password]
    Verify login success header

Login failed - Password incorrect
    [Documentation]    To verify that a user can login unsuccessfully when they put a correct username but wrong password
    [Tags]    Q3    Q3TC2
    [Setup]    Open herokuspp
    keywords.Login    ${valid_account}[username]    ${invalid_account}[password]
    Verify incorrect password header

Login failed - Username not found
    [Documentation]    To verify that a user can login unsuccessfully when they put a username that did not exist
    [Tags]    Q3    Q3TC3
    [Setup]    Open herokuspp
    keywords.Login    ${invalid_account}[username]    ${invalid_account}[password]
    Verify incorrect username header

##Question 4###
Get user profile success
    [Documentation]    To verify get user profile api will return correct data when trying to get profile of existing user
    [Tags]    Q4    Q4TC1
    ${user_profile}=    Get user profile    ${test_id}[valid]
    Verify user profile from API    ${user_information}[id]    ${user_information}[email]    ${user_information}[firstname]
    ...    ${user_information}[lastname]    ${user_information}[avatar]    ${user_profile}

Get user profile but user not found
    [Documentation]    To verify get user profile api will return 404 not found when trying to get exist profile of not existing user
    [Tags]    Q4    Q4TC2
    ${user_profile}=    Get user profile    ${test_id}[invalid]    404
    Verify empty response body    ${user_profile}