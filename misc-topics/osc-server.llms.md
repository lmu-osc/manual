# OSC Server

Code

A brief overview of the OSC server infrastructure

## Overview

Our primary server is hosted at **lmpp10e-osc.srv.mwn.de**. This is the machine that serves our public-facing websites and services. It runs **Debian** (managed by the LMU IT department) with **Nginx** as the web server.

### Services hosted on the server

- [**Pretix**](https://pretix.eu) — ticketing and registration for OSC events
- **The OSC website** — the main organizational site
- [**Matomo**](https://matomo.org) — web analytics platform
- Potentially others — check with Felix for the current list

### Administration & access

- The server is managed in partnership with the LMU IT department, under a support and maintenance contract.
- Very few team members need direct server access. **Felix** is the first point of contact for any server-related questions, issues, or requests for new user accounts.
- Backups are performed regularly by the LMU IT infrastructure — speak to Felix if you need details on restore procedures.
- Detailed internal documentation on the server setup (configuration files, service-specific setup, etc.) is maintained in our private **LRZ GitLab** repository, accessible to team members with appropriate permissions.
  - https://gitlab.lrz.de/lmu-open-science-center/server-admin-howto

------------------------------------------------------------------------

## Adding a New User

To grant someone SSH access to the server, follow the steps below. These instructions assume you already have `sudo` access on the server yourself.

### 1. Create the user account

Log into the server and create a new user account:

``` bash
sudo adduser <username>
```

You will be prompted to set a password and fill in some optional user information (full name, etc.). The `adduser` command automatically creates the user’s home directory at `/home/<username>`.

If the new user will need to install packages, restart services, or perform other administrative tasks, add them to the `sudo` group:

``` bash
sudo usermod -aG sudo <username>
```

> **Security note:** Only grant `sudo` access to users who genuinely need it for their work. Generally, users who we grant access to the server will probably also have a need for `sudo` access, but it’s good practice to review this on a case-by-case basis.

### 2. Set up the home directory and SSH folder

By default, `adduser` creates the home directory with reasonable permissions. Verify and fix the ownership:

``` bash
sudo chown -R <username>:<username> /home/<username>
```

Create the `.ssh` directory and set the correct permissions:

``` bash
sudo mkdir -p /home/<username>/.ssh
sudo chmod 700 /home/<username>/.ssh
sudo chown <username>:<username> /home/<username>/.ssh
```

### 3. Add the user’s public key

The new user should generate an SSH key pair on their local machine (if they haven’t already):

``` bash
# On the user's local machine:
ssh-keygen -t ed25519 -C "their-email@example.com"
```

Once they send you their **public** key (the `.pub` file, e.g. `id_ed25519.pub`), add it to the server’s `authorized_keys` file:

``` bash
echo "<paste the contents of id_ed25519.pub here>" | sudo tee -a /home/<username>/.ssh/authorized_keys
```

Then secure the file:

``` bash
sudo chmod 600 /home/<username>/.ssh/authorized_keys
sudo chown <username>:<username> /home/<username>/.ssh/authorized_keys
```

### 4. Verify everything is in order

Check that the permissions and ownership look correct:

``` bash
sudo ls -la /home/<username>/
```

You should see something like:

    total 24
    drwxr-xr-x 3 <username> <username> 4096 Mar 10 14:00 .
    drwxr-xr-x 3 root      root      4096 Mar 10 14:00 ..
    -rw-r--r-- 1 <username> <username>  220 Mar 10 14:00 .bash_logout
    -rw-r--r-- 1 <username> <username> 3771 Mar 10 14:00 .bashrc
    drwx------ 2 <username> <username> 4096 Mar 10 14:05 .ssh
    -rw-r--r-- 1 <username> <username>  807 Mar 10 14:00 .profile

And inside `.ssh`:

``` bash
sudo ls -la /home/<username>/.ssh/
```

Should show:

    total 12
    drwx------ 2 <username> <username> 4096 Mar 10 14:05 .
    drwxr-xr-x 3 <username> <username> 4096 Mar 10 14:05 ..
    -rw------- 1 <username> <username>  100 Mar 10 14:05 authorized_keys

The key points: - The home directory is owned by the user. - `.ssh` is `700` (drwx——). - `authorized_keys` is `600` (-rw——-).

### 5. Test the connection

From the new user’s local machine, try connecting:

``` bash
ssh -i ~/.ssh/your_private_key <username>@lmpp10e-osc.srv.mwn.de
```

On the first connection, they will be prompted to verify the server’s host key fingerprint.

> **TIP:**
>
> Note: you can compare the fingerprint shown in the prompt with the one you can retrieve from the server:
>
> ``` bash
> ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub
> ```

If the connection fails, check that:

- The private key path is correct.
- The server’s SSH configuration allows public-key authentication (should be the default on Debian).
- The username and server address are correct.

### 6. (Optional) Add a shortcut via `~/.ssh/config`

To avoid typing the full command each time, the new user can add a block like this to their local `~/.ssh/config`:

    Host osc-server
        HostName lmpp10e-osc.srv.mwn.de
        User <username>
        IdentityFile ~/.ssh/your_private_key

Then they can simply run:

``` bash
ssh osc-server
```

------------------------------------------------------------------------
