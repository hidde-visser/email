from imap_tools import MailBox
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