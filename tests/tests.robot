*** Settings ***
Resource               ../resources/common.robot
Library                QWeb
Suite Setup            Setup Browser
Suite Teardown         Close All Browsers
Library                String
Library                DateTime

# https://robocorp.com/docs/development-guide/email/sending-emails-with-gmail-smtp
*** Test Cases ***
Send test email based on keyword
    ${SUBJECT}=        Convert To String           Message generated by robot with keyword
    ${BODY}=           Convert To String           This is the body of the email.
    Send email         ${SUBJECT}                  ${BODY}

Check if message excist in inbox
    ${SUBJECT}=        Convert To String           Message generated by robot with keyword
    ${mailSubject}=    Get Messages Where Subject Contains                     ${SUBJECT}
    Should Contain     ${mailSubject}              ${SUBJECT}