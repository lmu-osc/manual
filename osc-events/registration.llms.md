# Registration and OSC Event Pages

## Registering Event on Pretix

Pretix is our management system to create registration pages for events (e.g. workshops, discussions, etc.).

### Administration

Malika will add new team members to the Pretix LMU OSC organisation on the OSC server so you can create registration pages for OSC events.

To login on [the server](http://www.pretix.osc.lmu.de/control/), the default login username will be your LMU campus email.

### Using Pretix

The following will take you through the entire set up process of a new event using Pretix, including general rules to follow regarding the settings as we as text examples for Mails.

**Create a new page**  
A suggestion is to clone an event and then change the necessary details.

- Basics: if copied, everything is the same
- Short form will be in URL *(change this)*
- Contact address -\> Malika’s (=content event organiser)
- Imprint URL -\> page on the (=bottom of the ticket page)

**Settings**

- Available language: typically, German/English but change to whatever is specified.
- Customer and attendee info: if copied from another ticket, usually remains unchanged
- Email twice
- No phone number
- Names of the attendees asked by default

**Texts**  
Usually no presale/no voucher/no confirmation

Frontpage Text *needs to be changed* and should include: Instructors, Abstract, Target Audience, Prerequisites, Logistics (ie. Where / online / hybrid)

> **NOTE:**
>
> *Instructors*:  
> *Dr. Katarina Blask*, Leibniz Institute for Psychology (ZPID)
>
> *Abstract*: Transparency and openness in the research process are becoming increasingly important in all scientific fields - including psychology. Accordingly, researchers should not only make research results freely available, for example in the form of scientific articles (open access), but also provide research data, analysis scripts and study materials. However, the reusability of the data made available requires comprehensive research data management (RDM) on the part of the researchers. In particular, research data should be made available in accordance with the FAIR principles, meaning that research data should be Findable, Accessible, and usable (Interoperable and Reusable). In this workshop, you will learn about FAIR data management in psychology by using the data management assistance system DataWiz, which allows you to plan, create and publish FAIR data objects. Specifically, you will 1) get an introduction to FAIR data documentation, 2) create a data management plan, and 3) learn how to organize your data.  
> *Target audience*: PhD students and post-docs from psychology.  
> *Prerequisites*: There is no prior knowledge required on research data management or the implementation of the FAIR principles.  
> To participate in the hands-on sessions, please create an account for DataWiz if you do not already have one.  
> *Logistics*: This event will be held online.

**Shop Design**

- Logo is always the OSC logo
- The colours are already set by Malika (but are changeable in the organisation part)

**Timeline**

- Start: put nothing in here
- End: when the event happens
- Show number of check ins/ Allow modifications -\> *No*

**Display**

- Show everything except the following:
  - Price (as our events are for free)
  - Product variations

Don’t hide sold out products  
Show numbers of tickets left not shown (if number of seats is very large or limited) (?)

**Cart**  
Check the box to go directly to the cart.  
Set the maximum of items people can choose to buy to “1” (if nothing else is specified)

**Waiting list**  
Enable waiting list.

### Payment, Tax Rules, Invoicing

Nothing to change here if we don’t charge for our events.

**Available plugins**  
If copied from another event, usually nothing needs to be changed here.

**Features**  
We have Emails and statistics enabled.

**Payment**  
Not needed if for free

**PDF Ticket**  
PDF Ticket output active (even if we don’t want a pdf in the end, you can keep it active as it could lead to problems if we switch at some point)

**API**  
Not needed as we do all the booking via pretix

### Tickets

Usually nothing needs to be changed here. We’re basically using the System standard.

Only confirmation needed, no PDF.

### E-Mail setting

**General**

- Subject prefix: *change this* depending on the kind of Event (e.g. “OSC workshop”)
- Don’t attach ticket files (as we don’t send PDFs as tickets)
- (If not specified otherwise) Sender name, Signature and Bcc can be left out (as Malika’s Email will still be indicated)

**Calendar Invites**

- Attach calendar files only if the spot and payment is confirmed (i.e. calendar invite goes to all orders, even those that need approving)
  - that’s why the text should say “if you got a confirmation, approval,… you can join here”
- Event description: *Change text* according to event and check if it has the correct zoom link/address in it.

> **NOTE:**
>
> Hello!  
> If your order was approved (automatically, or by the organiser if you are not a member of the LMU), you can join in person in X room in X address.
>
> Best wishes  
> Malika (malika.ihle@lmu.de)

**E-Mail design**  
Simple with logo

**Email content**:

- Add zoom links to the free order. Depends on the kind of event. Check free order + text for approved free order for zoom links.
- Depending on the kind of event you need to *change* other ones (e.g order approval process)

*When do I need to change which emails?*

- If event is free: free order, resend link, order changed, waiting list notification, order canceled, order approval

> **NOTE:**
>
> Hello,  
> your order for X (event) was successful.  
> You can join in person in room FIXME in FIXME or on Zoom: FIXME  
> Meeting ID: FIXME  
> Passcode: FIXME  
>
> Best wishes,  
> Malika
>
> PS: You can change your order details at {url}

> **NOTE:**
>
> Hello,  
> we approved your order for X (event) and will be happy to welcome you at our event.  
> You can join in person in room FIXME in FIXME Munich or on Zoom: https://lmu-munich.zoom-x.de/j/FIXME  
> Meeting ID: FIXME  
> Passcode: FIXME  
>
> Best wishes,  
> Malika
>
> PS: You can change your order details and view the status of your order at {url}

### Cancellation Settings

**Unpaid or Free Orders**  
You can always cancel (as all our current events are free of charge the other settings don’t matter)

### Products

Here you select which types of ticket exist. These usually are:

- Online ticket - member of a LMU Unit sponsoring the Open Science Center (Psychology, Business Administration, Biology)
- Online ticket - LMU member
- Online ticket - non-LMU member
- In-person ticket - member of a LMU Unit sponsoring the Open Science Center (Psychology, Business Administration, Biology)
- In-person ticket - LMU member
- In-person ticket - non-LMU member

**General**

- Active
- Give it a concise name (as in the examples above)
- Always an *Admission* product for all groups

**Price**  
Price = zero

**Availability**

- Most of the dates can just be taken from:
  - Waiting list depending on event
  - Sale channel: online shop
- Allow product to be cancelled or changed is ticked here (this seems similar to the one in general settings. Even if the first one is not, this still works)
- Show waiting list for this ticket = yes

**Add ons**  
Not needed for our events

**Additional Settings**  
Show the number of tickets left depending on event; Default setting is that it’s not shown but this is manually adjusted by Mailka when the event is online.

> **TIP:**
>
> If a lot of tickets left: don’t show, if only a few left: click show (The manual approval process of Tickets also plays into this)

Generally not a lot needs to be done here. For more complex events such as the Summer School, we use *FormR*.

**Quota**  
How many tickets of which kind are up for sale?

- Add kind of tickets (in person/ online)
- Add the number of tickets
- When to hide tickets and when not to add Info (e.g. for non LMU members)

At first, it’s only a ‘to be approved ticket’ for non LMU, with its own quota (unlimited) then Malika starts to accept some (e.g. TUM, or Munich based) and changes the LMU quota manually. Then two-three days before the event, she merges the quotas of both LMU and non LMU tickets.

**Categories**  
Only use it if it is a large event with a complex ticket structure. Franka is the only person to have used this yet.

**Questions**  
Copy general ones from the last event.

These are:

- Attendee name (system \<- as ask for attendee name is ticked in general settings)
- What organization are you from? (list)
- What faculty are you from? (list)
- Please specify: (text)

*Everyone should receive these questions*.

> **IMPORTANT:**
>
> If requested by the presenter, add those specific questions here too.

Which questions are mandatory depends on the event. Generally only the first few questions are required.

**Adding conditional subquestions**  
Add new question \> then go to “Advanced” settings \> click on “Question dependency” \> choose from the previous question the answer

### Orders

**All Orders**  
If tickets need to be approved they are here

**Export**  
Order data: download the sheet to do something With it (Malika uses this to send mails from her personal email)

*DELETE DATA IF EVEN ALLOWED TO DOWNLOAD IT*

**Check in**  
Not needed.

**Send out emails**  
If personalised emails are supposed to be sent, Malika usually does that manually.

### Going Online with the Event

Please also test the design and send some of the Mails to yourself by following this: *Dashboard-\> “your ticket shop is \[status\]” - “click here to change” \> enable test mode*

**For Test Mode**:

- Go to “Go to Shop” (right at the beginning of the page)
- Try out all possible tickets
- Then go to back to the Dashboard (View backend) \> “Test mode” \> click “Disable test mode”

In dashboard, you see ‘your ticket shop is’ then email test mode, then fake all the possible kind of orders check the emails you receive (text in email, calendar invite).  
When all is good, disable test mode and delete all fake tickets (a tick box in the page to disable test mode) and check with Malika that you didn’t forget anything important. She will test again, give feedback or go online.

To test mails go to Arrow top left (account and organisation -\> settings) user settings: *turn on/off notifications* (New order placed -\> receive emails during testing)

You can find new projects are in the Dashboard/shop status and you can test them or set them on and offline once everything else is done.

**Other resources**  
[Click here for information on how the mails work](https://docs.pretix.eu/en/latest/user/events/email.html#e-mail-content)

## FormR

Back to top
