install_if_needed <- function(...) {
    packages <- c(...)
    new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
    print(new.packages)
    if(length(new.packages)) install.packages(new.packages, repos = "http://cran.us.r-project.org")
    for (package in packages) {
        library(package, character.only = TRUE)
    }
}
