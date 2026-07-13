# Adding a New Website to Matomo

Code

This chapter describes how to add a new website to Matomo and how to set up the tracking code on your website so that you can begin collecting data.

## Adding a New Website

Start by logging into your Matomo account. On the landing page, click the “Add a New Website” button. You will then be prompted to choose the type of website you would like to track. Select **“Website”** rather than “Intranet Website”—we will likely never use the Intranet Website option, which is intended for tracking internal traffic on a private network.

Next, fill in the form with the appropriate information about your website, including the name and URL of the website. There are a few settings you should configure at this stage:

- Add `127.0.0.1` to the **Excluded IPs** list.
- Add `localhost` to the **Excluded referrers** list.
- Under **“Tracking data anonymization settings”**, make sure that the “Use System settings” option is selected. This should already be the default, but it is worth confirming.

Once you have filled in the form, click the **Save** button.

## Obtaining and Installing the Tracking Code

After saving the new website, you will be taken to a page that displays the tracking code for your website. This code is what enables Matomo to collect data about your website visitors and their interactions with your site. Copy this tracking code and add it to the HTML of your website.

The convention we have adopted for our websites is to place the tracking code in a file named `matomo-analytics.html` in the root directory of the website. This file is then included in the HTML of every page by configuring `_quarto.yml` as follows:

``` yaml
format:
  html:
    include-in-header: matomo-analytics.html
```

## Preventing Local Tracking during Development

It is important to ensure that the tracking code only runs on the live, production version of your website and not on local development instances. This prevents you from collecting data about your own visits while developing and testing the site locally. To achieve this, wrap the tracking code in a conditional statement that checks the hostname of the page. The tracking code should only execute if the hostname is neither `localhost` nor `127.0.0.1`. Here is an example:

``` html
<script>
if (location.hostname !== 'localhost' && location.hostname !== '127.0.0.1') {
    // the tracking code goes here
    ...
    ...
}
</script>
```

## Additional Notes on Implementation

You can look at any of our existing website repositories to see how this is implemented in practice. For example, the `matomo-analytics.html` file in the root directory of the `lmu-osc.github.io` repository, together with its corresponding `_quarto.yml`, provides a working reference. The main difference between repositories is the `site_id` variable in the tracking code (e.g. `_paq.push(['setSiteId', '3']);`), because each website has a unique site ID in Matomo. The rest of the code should remain the same across all of our websites.

Note that the OSC website is a partial exception: it sends data to both our OSC Matomo instance and the LMU Matomo instance. As a result, the tracking code on the OSC website contains two sets of tracking instructions instead of one. The principle is the same, however—you are simply repeating the pattern for a second Matomo instance.
