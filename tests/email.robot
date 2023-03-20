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
    @{links}=   Get Email Links    email=hidde.copado@gmail.com   pwd=o j g x q l k q s s p u m x b f   subject="Fwd: Document for your Signature"
    Log To Console                 ${links}[0]
    Goto  ${links}[0]

