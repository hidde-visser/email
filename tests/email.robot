*** Settings ***
Library                     QForce
Library                     String
Library                     Collections
Library                     ../libraries/gmail.py
Test Setup                  Open Browser  about:blank  chrome
Test Teardown               Close All Browsers
# imap.gmail.com:993

*** Variables ***
${app_password}    your google app password here  # https://support.google.com/mail/answer/185833?hl=en
${email}           your gmail address here        # firstname.lastname@gmail.com etc.
${subject}         your gmail subject line here   # Arriving Email subject line

*** Test Cases ***
Email Verification
    [Documentation]    Sample test to read links from email message in Gmail
    @{links}=   Get Email Links    email=${email}   pwd=${app_password}   subject=${subject}

    FOR  ${link}  IN  @{links}
        Log To Console   located a link: ${link}
        GoTo  ${link}
        # add steps here..
    END
