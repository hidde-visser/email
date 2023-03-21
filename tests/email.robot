*** Settings ***
Library                     QForce
Library                     String
Library                     Collections
Library                     ../libraries/gmail.py
Test Setup                  Open Browser  about:blank  chrome
# imap.gmail.com:993

*** Variables ***
${app_password}    your google app password here  # https://support.google.com/mail/answer/185833?hl=en
${email}           your gmail address here        # firstname.lastname@gmail.com etc.
${subject}         your gmail subject line here   # Arriving Email subject line

*** Test Cases ***
Email Verification
    [Documentation]    Sample test to read links from email message in Gmail
    @{links}=   Get Email Links    email=${email}   pwd=${app_pass}   subject="Fwd: Document for your Signature"    #"EmailStart"
    Log To Console                 ${links}[0]
    # Goto  ${links}[0]
     FOR  ${link}  IN  @{links}
        IF  "EmailStart" in "${link}"
            GoTo  ${link}
            BREAK
        END 
    END

check new email
    [Documentation]
    [Tags]
    ${subject}=  Poll For Update    email=${email}    pwd=${app_pass}
    Log To Console                ${subject}   
    # @{links}=   Get Email Links    email=${email}   pwd=${app_pass}   subject=${subject}    #"EmailStart"

    Get Messages    email=${email}    pwd=${app_pass}    subject=Test Hidde