*** Settings ***
Library                   QWeb
Library                   String 
Library                   Collections

*** Variables ***
${BROWSER}                chrome
@{users}                  Create List       Guest   Sales  Admin  Father   Mother    Child   Daughter   Son   Cousin   Uncle   Aunt

*** Keywords ***

Setup Browser
    Set Library Search Order    QWeb
    Open Browser          about:blank       ${BROWSER}
    SetConfig             LineBreak         ${EMPTY}      #\ue000
    SetConfig             DefaultTimeout    20s           #sometimes salesforce is slow

End suite
    Close All Browsers