# Matomo Overview and Our Server Setup

## What is Matomo?

Web analytics is an essential part of managing any modern website. By understanding how visitors find, navigate, and interact with a site, you can make informed decisions about content, layout, and outreach. Matomo (formerly known as Piwik) is a free and open-source web analytics platform designed to provide exactly this kind of insight. Originally created as a privacy-respecting alternative to proprietary tools like Google Analytics, Matomo has grown into a mature, full-featured platform that gives website operators complete ownership and control over their analytics data.

Matomo offers a comprehensive suite of features for tracking and understanding website traffic. These include real-time visitor monitoring, customizable dashboards, detailed visitor profiles, goal and conversion tracking, heatmaps and session recordings, and a wide range of pre-built and custom reports. Because it is open-source, Matomo can be extended with plugins, integrated with other systems, and tailored to fit specific institutional needs. Its strong emphasis on data privacy – including full compliance with the General Data Protection Regulation (GDPR) by default – makes it particularly well suited for academic and research organizations such as ours.

At the Open Science Center, we use Matomo to track visitor interactions across our websites. This helps us understand who our audience is, which content resonates with them, and how we can continuously improve the user experience. Our Matomo instance is hosted on our own dedicated server, which means that we retain full control over all analytics data and can ensure that our tracking practices remain in line with our privacy commitments and with applicable regulations.

## Our Matomo Server Setup

Our Matomo instance is hosted on a dedicated server that we manage ourselves. This self-hosted approach gives us complete control over the analytics data and allows us to customize tracking and reporting features to suit our specific needs without relying on a third-party service. It also means that no data ever leaves our infrastructure, which is an important factor in our overall data protection strategy.

The specific details of our server configuration – including access credentials, network setup, and deployment procedures – are kept within our LRZ GitLab instance and are not publicly available. If you are involved in the maintenance of our Matomo instance and need access to these details, or if you have questions about our setup, please reach out to us directly.

That said, the core of our deployment follows a fairly standard pattern. We use Docker Compose to run Matomo alongside a MariaDB (MySQL-compatible) database. This containerized setup makes it straightforward to deploy, update, and maintain the application while keeping its dependencies isolated. The relevant `docker-compose.yml` file looks like this:

``` yaml
version: "3"

services:
  db:
    image: mariadb
    command: --max-allowed-packet=64MB
    restart: always
    environment:
      - MARIADB_DATABASE=matomo
      - MARIADB_USER
      - MARIADB_PASSWORD
      - MARIADB_ROOT_PASSWORD
    volumes:
      - ./db:/var/lib/mysql

  app:
    image: matomo
    restart: always
    volumes:
      - ./matomo:/var/www/html
    ports:
      - 127.0.0.1:8080:80
```

The `db` service uses the official MariaDB image to store all analytics data persistently, while the `app` service runs the Matomo application itself. The application is bound to `127.0.0.1:8080` on the host, meaning it is only accessible locally – a reverse proxy (configured separately) handles public-facing traffic and TLS termination.

## Privacy and Data Protection

Data privacy is at the heart of how we use Matomo. Our setup is configured to comply fully with LMU’s own data protection policies. We do not collect personally identifiable information (PII) without explicit consent, and we provide website visitors with the option to opt out of tracking entirely.

A key part of our privacy-conscious configuration is IP address anonymization. All IP addresses collected by our Matomo instance are truncated to 2 bytes (for example, `192.168.xxx.xxx`), which means that individual visitors cannot be identified by their IP address alone. In addition, we have enabled Matomo’s “Force tracking without cookies” option. This setting has two important effects: first, the tracking code (`matomo.js`) is updated so that no cookies are set in the visitor’s browser; second, Matomo’s server-side logic ignores any tracking cookies it receives, even if consent methods are used on the front end. The official Matomo documentation describes this option as follows:

> Enabling this option will automatically update matomo.js, so it contains some additional code to ensure all trackers won’t use cookies. Additionally Matomo will ignore all tracking cookies on server side.
>
> Cookies will be disabled even when using the consent methods in Matomo tracker and calling for example the cookie consent methods won’t enable cookies.

Because we do not use cookies and we anonymize IP addresses, we do not track individual users across sessions, nor do we collect any information that could be used to identify specific individuals. It is worth noting that IP anonymization does have a modest impact on geolocation accuracy. As Matomo notes:

> Note: Geolocation will have approximately the same results with 1 byte anonymized. With 2 bytes or more, Geolocation will be inaccurate.

We have judged this trade-off to be acceptable, as our primary interest is in aggregate trends rather than precise geographic data. This approach is also in line with LMU’s official privacy policy, which you can read at <https://www.lmu.de/de/footer/datenschutz/>.

## Updating Matomo

Keeping Matomo up to date is important for accessing the latest features and, more crucially, for receiving security patches. For routine updates – those that involve only the Matomo application code – the process is straightforward: you can update directly from the Matomo dashboard by navigating to the administration area and clicking the “Update Matomo” button when a new version is announced.

However, it is important to understand that dashboard-based updates only update the Matomo application code. If a new version of Matomo also requires an updated version of the database schema (for example, because the new release introduces changes to how data is stored or indexed), the dashboard update alone will not handle that. In such cases, a more involved update process is needed, and you should test the update thoroughly in a staging environment before applying it to production.

Our general policy is to keep our Matomo instance on the latest stable release. When a database-level update is required, the process involves updating both Docker images. From the server where Matomo is deployed, you would run:

``` bash
cd /path/to/matomo # see GitLab documentation for details on where this is located
docker-compose pull
docker-compose up -d
```

The `docker-compose pull` command fetches the latest versions of both the Matomo application image and the MariaDB image. The `docker-compose up -d` command then recreates and restarts the containers with these updated images. As with any infrastructure change, it is advisable to review the release notes for the new Matomo version beforehand and to verify that everything is working correctly after the update.

Back to top
