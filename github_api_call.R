

# curl -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
# "https://api.github.com/orgs/your-org/repos"


library(httr)
library(jsonlite)

# Replace with your GitHub personal access token
access_token <- Sys.getenv("lmu_osc_access_token")

# Replace with your GitHub organization name
org_name <- "lmu-osc"

# Construct the API URL
url <- paste0("https://api.github.com/orgs/", org_name, "/repos")

# Make the GET request to GitHub API
response <- GET(url,
                add_headers(Authorization = paste("Bearer", access_token)))

# Check if the request was successful (status code 200)
if (status_code(response) == 200) {
  # Parse the response content from JSON to an R data frame
  repos <- fromJSON(content(response, "text"))

  # Print the repositories (or you can process them further)
  print(repos)
} else {
  # Print the error message if the request fails
  print(paste("Error:", status_code(response)))
}


View(tibble(repos))

View(tibble(repos$name, repos$full_name, repos$license))
