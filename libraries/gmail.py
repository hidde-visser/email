from imap_tools import MailBox, A
from imap_tools import AND
from bs4 import BeautifulSoup
import re

def get_email_links(email, pwd, subject, folder='INBOX'):
    # get list of email bodies from INBOX folder
    with MailBox(host='imap.gmail.com', port=993).login(email, pwd, folder) as mailbox:
        bodies = [msg.html for msg in mailbox.fetch(AND(subject=subject), reverse = True)]

    soup = BeautifulSoup(str(bodies))
    links = []
    for link in soup.findAll('a', attrs={'href': re.compile("^https://")}):
        links.append(link.get('href'))

    return links

# def get_email_link(email, pwd, subject, folder='INBOX', linkText):
#     # get list of email bodies from INBOX folder
#     with MailBox(host='imap.gmail.com', port=993).login(email, pwd, folder) as mailbox:
#         bodies = [msg.html for msg in mailbox.fetch(AND(subject=subject), reverse = True)]

#     soup = BeautifulSoup(str(bodies))
#     links = []
#     for link in soup.findAll('a', attrs={'href': re.compile("^https://")}):
#         if linkText in link:
#             return link.get('href')

def poll_for_update(email, pwd, urlSearchText, folder='INBOX'):
# waiting for updates 60 sec, print unseen immediately if any update
    with MailBox('imap.gmail.com').login(email, pwd, folder) as mailbox:
        responses = mailbox.idle.wait(timeout=300)
        if responses:
            for msg in mailbox.fetch(A(seen=False)):
                #return (msg.subject)
                bodies = [msg.html for msg in mailbox.fetch(AND(subject=msg.subject), reverse = True)]

                soup = BeautifulSoup(str(bodies))
                links = []
                for link in soup.findAll('a', attrs={'href': re.compile("^https://")}):
                    links.append(link.get('href'))
                
                for url in links:
                    if urlSearchText in url:
                        return    url
                return ('Url Not Found...')
        else:
            return ('no updates in 60 sec')        

def get_messages(email, pwd, subject, folder='INBOX'):
    # Get date, subject and body len of all emails from INBOX folder
    with MailBox('imap.gmail.com').login(email, pwd) as mailbox:
        for msg in mailbox.fetch():
            print('Message subject: ', msg.subject)
            print('Searching for subject: ', subject)
            if  subject in msg.subject:
                # print(msg.date, msg.subject, len(msg.text or msg.html))
                    return (msg.date, msg.subject, len(msg.text or msg.html))
        return ('nothing found')