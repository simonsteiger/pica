This shiny app demonstrates how to store tabular data persistently on cloud services, such as Google Drive^[It is also possible to use services like Dropbox or MySQL, see [this article](https://shiny.posit.co/r/articles/build/persistent-data-storage/) for more information.].

# Installation

Feel free to base your own work off of this repository by forking it and then cloning it onto your machine. 
If you have not done this before, see [this tutorial](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo).

# Authorizing a Google account

Upload data from your shiny app to Google Drive requires your account to be authorized.
Since Google requires the user to authenticate in each session, we need to find a way to automatically authenticate the user of the shiny app.
My solution is based on [this](https://stackoverflow.com/questions/61375368/is-there-a-way-to-auto-authenticate-access-to-googlesheets-upon-r-shiny-app-load) post.

The relevant lines of code are contained in `main.R`, and `.Rprofile`.

```r
# in app / view / main.R, lines 20-22

# Authenticate Google sheets
drive_auth(cache = ".secrets", email = Sys.getenv("EMAIL"))
gs4_auth(token = drive_token(), email = Sys.getenv("EMAIL"))

# in .Rprofile, lines 9-12
options(
  # ...
  gargle_oauth_cache = ".secrets"
)
```

As you can see in the code from `main.R`, I am also using a `.env` file to store my email (you can read more about `.env` files and how to work with them in R [here](https://github.com/gaborcsardi/dotenv)).
In short, they store information that you think would better not be shared publicly, such as passwords, API keys, etc.
This file, alongside the `.secrets` folder containing your authentication key, should be added to the `.gitignore` file.

# Misc

While I am very curious about the kinds of CSV files you would like to share with me, the live app **does not upload** to the authorized Google Drive account.
To change this in your project, uncomment line 65 in `app/view/upload.R`.
