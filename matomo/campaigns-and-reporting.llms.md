# Campaigns and Reporting Analytics

This chapter discusses how to use the campaign tracking features of Matomo, and how to use the data from Matomo to understand your audience and improve your website.

## What Are Campaigns?

Campaigns are a way to track the effectiveness of specific marketing efforts, such as email campaigns, social media posts, or paid advertising. By creating a campaign in Matomo and including the appropriate tracking parameters in your URLs, you can see how many visitors are coming to your website from each campaign, and how they are interacting with your site once they arrive.

For example, if you are running a social media campaign to promote a new blog post, you could create a campaign in Matomo called “Social Media Campaign” and include the appropriate tracking parameters in the URLs that you share on social media. This would allow you to see how many visitors are coming to your website from that campaign, and how they are engaging with your content.

In short, a campaign is a way to track the effectiveness of specific marketing efforts by using personalized URLs with tracking parameters. These tracking parameters are added to the end of a URL, and they typically include information about the campaign, such as the source, medium, and name of the campaign. For example, a URL with tracking parameters might look like this:

`https://www.example.com/?utm_source=social&utm_medium=post&utm_campaign=social_media_campaign`

where the `utm_source`, `utm_medium`, and `utm_campaign` parameters are used to track the source, medium, and name of the campaign, respectively. This is a general example, and Matomo uses its own specific tracking parameters, but the concept is the same: you add tracking parameters to your URLs to track the effectiveness of your campaigns in Matomo. For example, a Matomo URL with tracking parameters might look like this:

`https://example.org/?mtm_campaign=name&mtm_kwd=campaign-keyword&mtm_medium=medium`

where `mtm_campaign` is the campaign name, `mtm_kwd` is the campaign keyword, and `mtm_medium` is the campaign medium. By including these tracking parameters in your URLs, you can track the effectiveness of your campaigns in Matomo and see how many visitors are coming to your website from each campaign, and how they are engaging with your content.

Note that these tracking parameters (UTM parameters) are not what is actually used in Matomo, but they are a common example of how tracking parameters work in general. Matomo uses its own specific tracking parameters, several of which will be discussed in the next section.

## How and When to Create Campaigns

Strictly speaking, you can “create” a campaign in Matomo by simply including the appropriate tracking parameters in your URLs. There is no need to create a campaign in the Matomo dashboard before you start tracking, as Matomo will automatically recognize the tracking parameters and attribute the traffic to the appropriate campaign.

However, it is often helpful to use the “Campaign URL Builder” found in the Matomo dashboard of a website, which can help you generate the appropriate tracking parameters for your URLs. This feature allows you to easily create URLs with the correct tracking parameters by inputting the base URL and any of the following parameters:

- **Campaign Name (required)**: The name of the campaign you want to track. This is the most important parameter, as it will be used to identify the campaign in your Matomo reports.
- **Campaign Keyword**: The keyword associated with the campaign, which can be useful for tracking specific keywords in paid search campaigns.
- **Campaign Source**: The source of the traffic, such as “social media”, “email”, or “paid advertising”. This parameter helps you understand where your traffic is coming from.
- **Campaign Medium**: The medium through which the traffic is coming, such as “post”, “newsletter”, or “cpc”. This parameter helps you understand how your traffic is being delivered.
- **Campaign Content**: Additional information about the campaign, such as the specific ad or link that was clicked. This can help you differentiate between different versions of a campaign.
- **Campaign ID**: A unique identifier for the campaign, which can be useful for tracking campaigns across different platforms or tools.
- **Campaign Group**: Identifies a specific group or audience.
- **Campaign Placement**: Used to describe the advertising placement or position, for example an entire website, specific pages from a website, an individual ad unit positioned on a single page, a video, a mobile phone app, and more.

The bolded parameters above are the ones that we typically use for our campaigns, but you can use any combination of these parameters to track your campaigns in Matomo. **The important thing is to be consistent in how you use these parameters across your campaigns, so that you can easily compare and analyze the data in your Matomo reports for a website.** Think of your parameter choices as being like the columns in an Excel Pivot Table or a Table 1 in a paper—you want to establish clear, reusable, descriptive categories that allow you to look at cross-sections of data.

## Campaign Examples

### A Bad, But Original, Example of a Campaign

At the launch of our new OSC website in 2026, we ran a campaign to promote the new website and encourage people to visit and explore the new content. We created a campaign in Matomo and included the following tracking parameters in the URLs that we shared on social media and in our email newsletters:

- Campaign Name: `launch`
- Campaign Keywords: `email`, `linkedin`, `bsky`, `mastodon`

This was our first use of the campaign tracking features of Matomo, and it allowed us to see how many visitors were coming to our website from each of our promotional efforts, and how they were engaging with our content as a result.

**However, this was ultimately not the best use of the campaign tracking features of Matomo.** We should have considered using the **Campaign Source** parameter to differentiate between the different platforms (e.g., email, LinkedIn, Bluesky, Mastodon) instead of using the **Campaign Keywords** parameter. The **Campaign Source** parameter is specifically designed to track the source of traffic, and it is how we collect data going forward. By using **Campaign Keywords** instead, we introduced an inconsistency in how the parameters are used across our campaigns. This is a good example of why it is important to be consistent in how you use the tracking parameters across campaigns, so that you can easily compare and analyze the data in your Matomo reports. Ultimately, the data from this campaign was still useful, but it would have been more straightforward to analyze if we had used the **Campaign Source** parameter to differentiate between the different platforms.

### A Better Example of a Campaign

Now let us look at how a well-structured campaign should be set up. Suppose the OSC is organising a workshop on research data management (RDM) and wants to promote it via email to our mailing list, as well as on LinkedIn, Bluesky, and Mastodon. A properly configured campaign would assign each parameter to the dimension it is meant to describe, like this:

- **Campaign Name**: `rdm-workshop-2026`
- **Campaign Source**: `email`, `linkedin`, `bsky`, `mastodon`
- **Campaign Medium**: `newsletter`, `social-post`

In this setup, the **Campaign Name** groups all traffic under a single campaign (`rdm-workshop-2026`), making it easy to see the total impact of the workshop promotion. The **Campaign Source** parameter cleanly separates traffic by platform, so you can compare which channel drove the most visitors. The **Campaign Medium** distinguishes the delivery method (a newsletter versus a social media post). Finally, **Campaign Group** captures which audience segment each link targeted (our mailing list versus a general audience on social media), which can be useful for understanding how different groups respond to your promotions.

With this structure, your Matomo reports will immediately show you meaningful breakdowns without any manual cleanup. For example, you could quickly answer questions like: “How many visitors came from the LinkedIn post vs. the email newsletter?” or “Did the email newsletter drive more engagement per visitor than the social media posts?” By keeping each parameter focused on a single dimension, you ensure that your data remains clean, consistent, and easy to analyse across all future campaigns.

Back to top
