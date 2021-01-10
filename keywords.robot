*** Variables ***
&{herokuspp}    txt_username=id=username
...    txt_password=id=password
...    btn_login=css=button[type='submit']
...    lbl_login_header=xpath=//div[@id='flash'][contains(string(),'{message}')]

***Keywords***
###Question 3###
Format Text
    [Documentation]    use str.format()
    [Arguments]    ${format_string}    &{key_value_pairs}
    ${result_text}    Evaluate    str($format_string).format(**$key_value_pairs)
    [Return]    ${result_text}

Open herokuspp
    SeleniumLibrary.Open Browser    ${TEST_URL}    browser=${BROWSER}

Input username and password
    [Arguments]    ${username}    ${password}
    SeleniumLibrary.Input Text    ${herokuspp}[txt_username]    ${username}
    SeleniumLibrary.Input Password    ${herokuspp}[txt_password]    ${password}

Click login button
    SeleniumLibrary.Click Element    ${herokuspp}[btn_login]

Login
    [Arguments]    ${username}    ${password}
    Input username and password    ${username}    ${password}
    Click login button

Verify login success header
    ${locator}=    keywords.Format Text    ${herokuspp}[lbl_login_header]    message=${login_header}[success]
    SeleniumLibrary.Element Should Be Visible    ${locator}

Verify incorrect username header
    ${locator}=    keywords.Format Text    ${herokuspp}[lbl_login_header]    message=${login_header}[incorrect_username]
    SeleniumLibrary.Element Should Be Visible    ${locator}

Verify incorrect password header
    ${locator}=    keywords.Format Text    ${herokuspp}[lbl_login_header]    message=${login_header}[incorrect_password]
    SeleniumLibrary.Element Should Be Visible    ${locator}

###Question 4###
Get user profile
    [Arguments]    ${user_id}    ${expected_status}=200
    RequestsLibrary.Create Session    get_profile    ${TEST_API}
    ${response}=    RequestsLibrary.GET On Session    get_profile    /${user_id}    expected_status=${expected_status}
    [Return]    ${response}

Verify user profile from API
    [Arguments]    ${id}    ${email}    ${firstname}    ${lastname}    ${avatar}    ${response}
    ${profile_data}=    Create List
    Append To List    ${profile_data}    ${id}    ${email}    ${firstname}    ${lastname}    ${avatar}
    FOR    ${index}   IN   @{profile_data}
        Should Contain    ${response.text}    ${index}
    END

Verify empty response body
    [Arguments]    ${response}
    Should Contain    ${response.text}    {${EMPTY}}