

# Replace with your GitHub personal access token
access_token <- Sys.getenv("lmu_osc_access_token")

# Replace with your GitHub organization name
org_name <- "lmu-osc"

# Construct the API URL for fetching all repositories
url <- paste0("https://api.github.com/orgs/", org_name, "/repos")


# Make the GET request to GitHub API to get repository data
response <- GET(url,
                add_headers(Authorization = paste("Bearer", access_token)))

# Check if the request was successful (status code 200)
temp_fxn <- function() {
  if (status_code(response) == 200) {

  # Parse the response content from JSON to an R data frame
  repos <- fromJSON(content(response, "text"))

  # Initialize an empty list to store license info
  license_info <- list()

  # Loop through all repositories and get the license info
  for (repo in repos$name) {

    # Construct the URL for the individual repository license endpoint
    repo_url <- paste0("https://api.github.com/repos/", org_name, "/", repo, "/license")

    # Make the GET request to fetch the primary license info for this repository
    repo_license <- GET(repo_url,
                        add_headers(Authorization = paste("Bearer", access_token)))

    # Initialize a list to store all licenses for the repository
    repo_licenses <- list()

    # If the request for the license info is successful
    if (status_code(repo_license) == 200) {
      # Parse the license info
      license_data <- fromJSON(content(repo_license, "text"))

      # Add the primary license to the list
      repo_licenses[["primary_license"]] <- license_data$name
    } else {
      # If no primary license is available, note that
      repo_licenses[["primary_license"]] <- "No primary license information available"
    }

    # Now, let's check for multiple license files in the repository
    # Fetch the repository contents
    repo_contents_url <- paste0("https://api.github.com/repos/", org_name, "/", repo, "/contents")
    repo_contents <- GET(repo_contents_url,
                         add_headers(Authorization = paste("Bearer", access_token)))

    # If the request for repository contents is successful
    if (status_code(repo_contents) == 200) {
      contents <- fromJSON(content(repo_contents, "text"))


      # Filter out files that look like license files (LICENSE, LICENSE.md, LICENSES, etc.)
      license_files <- grep("LICENSE", contents$name, value = TRUE)

      # If there are additional license files
      if (length(license_files) > 1) {
        # Fetch each license file and add its content to repo_licenses
        for (file_name in license_files) {
          # Get the content of each license file
          file_url <- paste0("https://api.github.com/repos/", org_name, "/", repo, "/contents/", file_name)
          file_info <- GET(file_url,
                           add_headers(Authorization = paste("Bearer", access_token)))

          if (status_code(file_info) == 200) {
            file_content <- fromJSON(content(file_info, "text"))

            # Decode the base64-encoded content of the license file
            file_text <- rawToChar(base64enc::base64decode(file_content$content))

            # Add the license file content to the repo_licenses list
            repo_licenses[[file_name]] <- file_text
          }
        }
      }
    }

    # Store the full license information for this repository
    license_info[[repo]] <- repo_licenses
  }

  # Print the collected license information for all repositories
  print(license_info)

} else {
  # Print the error message if the request fails
  print(paste("Error fetching repositories:", status_code(response)))
}

}


# debug(temp_fxn)

results <- temp_fxn()
