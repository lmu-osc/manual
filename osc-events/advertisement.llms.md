# Advertisement

Code

## Channels

Advertise the event through relevant channels, e.g.:

Graduate Center –\> generic email

Infodienst –\> weblink

OSC channels –\> maling lists

BlueSky/Mastodon/LinkedIn –\> see social media page

UB University of Munich – Central Library –\> Martin Spenger

Departmental communication officers mailing list –\> where to find?

Follow-up list of communication officers –\> ?

All the mailing lists we have access to / are subscribed to related to OS -\> lists?

Send notification to Karabulut Seyhan <Seyhan.Karabulut@Verwaltung.Uni-Muenchen.DE> working for Riesche Barbara <Barbara.Riesche@Verwaltung.Uni-Muenchen.DE> if relevant for post doc across several disciplines to get on Excellerate website

## Matomo campaigns

Level of granularity to create campaigns, how to automtically create link, and insert automatically in relevant communication.

## Mass personalized emails

### Using Mail Merge in Microsoft Office

To perform a mail merge from Excel to Word to Outlook, ensure your Outlook and Word desktop apps are open. Open your clean Excel file, verify all columns have headers (e.g., “Email”, “Name”), and close it.

Follow these steps in Microsoft Word to complete the merge:

- Start Merge: Open a blank Word document, go to the Mailings tab, click Start Mail Merge, and select Email Messages.
- Link Data: Click Select Recipients \> Use Existing List, and choose your Excel file. Select the correct worksheet and ensure “First row of data contains column headers” is checked.
- Draft Email: Type your email. Use the Insert Merge Field button to add personalized placeholders (e.g., «First_Name») into your message.
- Preview & Send: Click Preview Results to check how the emails look. Here you can edit single emails further. Then select Finish & Merge \> Send Email Messages.
- Finalize: In the prompt box, select the column that contains your email addresses, enter a subject line, and click OK. Word will automatically push the emails to Outlook to be sent.

### Using R, LMU VPN, LRZ credentials

Connect to the LMU VPN if not on site. Edit and run the following R script. Note that to personalize the email you can create objects called in the body of your email. To personalize further with specific conditions, you can create e.g. loops.

``` r
library(mailR)
sender <- "YOUR-EMAIL@psy.lmu.de"
recipients <- c("YOUR-RECIPIENT-S-EMAIL@xx.xx")
send.mail(from = sender,
         to = recipients,
         subject = "Test",
         body = "<html><b>Hello</b> World!</html>",
         html = TRUE,
       smtp = list(host.name = "mailout.lrz.de", port = 587, 
                        user.name = "YOUR-EMAIL@psy.lmu.de",            
                        passwd = "YOUR_LRZ_PWD", ssl = TRUE),
            authenticate = TRUE,
         send = TRUE)
```

Back to top
