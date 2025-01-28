


### NOTE!

# CODE NEEDS TO BE UPDATED TO HANDLE >30 MEMBERS--THIS IS WHERE
# PAGINATION BEGINS IN THE GITHUB API


# Set your GitHub organization and personal access token (PAT)
org <- "lmu-osc"  # Replace with your organization name
access_token <- Sys.getenv("lmu_osc_access_token")  # Replace with your GitHub Personal Access Token

# GitHub API URL to get the members of the organization
url <- paste0("https://api.github.com/orgs/", org, "/members")

# Make the GET request with authentication
response <- GET(url, add_headers(Authorization = paste("token", access_token)))

# Check if the request was successful (status code 200)
if (status_code(response) == 200) {
  # Parse the response content as JSON
  members_data <- fromJSON(content(response, "text"))

  # Extract and print the login names of the members
  member_logins <- members_data$login
  print(member_logins)
} else {
  # If the request fails, print an error message
  print(paste("Failed to fetch members. Status code:", status_code(response)))
}
