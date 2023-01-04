*** Settings ***
Library                         QForce
Library                         String
Library                         RPA.Email.ImapSmtp          smtp_server=smtp.gmail.com                              smtp_port=587
Library                         RPA.Robocorp.Vault


*** Variables ***
${BROWSER}                      chrome
${SENDER}                       hidde.visser2@gmail.com
#This needs to be an APP password generated in your gmail account from sender
#stored the value in a suite variable
#${APPPASSGMAIL}
${RECIPIENT}                    hvisser@copado.com


*** Keywords ***
Send Email
    [Arguments]                 ${SUBJECT}                  ${BODY}
    Authorize                   account=${SENDER}           password=${APPPASSGMAIL}
    Send Message                sender=${SENDER}
    ...                         recipients=${RECIPIENT}
    ...                         subject=${SUBJECT}
    ...                         body=${BODY}

Get Messages Where Subject Contains
    [Arguments]                 ${subject}
    Authorize                   account=${SENDER}           password=${APPPASSGMAIL}
    @{emails}=                  List Messages               SUBJECT "${subject}"    SENT
    FOR                         ${email}                    IN                          @{emails}
        Log                     ${email}[Subject]
        Log                     ${email}[From]
        Log                     ${email}[Date]
        Log                     ${email}[Received]
        Log                     ${email}[Has-Attachments]
    END
    RETURN                      @{emails}

Setup Browser
    # Setting search order is not really needed here, but given as an example
    # if you need to use multiple libraries containing keywords with duplicate names
    Set Library Search Order    QForce                      QWeb
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow

End suite
    Close All Browsers