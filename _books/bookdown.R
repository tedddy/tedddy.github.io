# Convert a SciViews directory of .Rmd files prepared for Jekyll into
# something suitable for bookdown. For this, I need to:
# 1) Load _config.yml,
# 2) Create a separate directory where I will put all the .Rmd files
# 3) Eliminate the Jekyll inclusions
# 4) Interpret Jekyll variables
# 5) Reformat bookdown tags correctly
# 6) Get title and section from YAML section of each .Rmd file, strip the YAML section and put adequate titles in the .Rmd files
# 7) Compile a _book.Rmd file

prepare_book <- function(dir = ".", name = "book", first_section = "Introduction", first_title = NULL, encoding = "UTF-8") {
  if (!dir.exists(dir))
    stop("Directory ", dir, " is not found")
  odir <- setwd(dir)
  on.exit(setwd(odir))

  # Load _config.xml data
  library(yaml)
  # Search for _config.xml descending the directory hierarchy
  active_dir <- getwd()
  root_dir <- active_dir
  config_file <- "_config.yml"
  while (!file.exists(file.path(root_dir, config_file))) {
    # Is there an additional level?
    if (dirname(root_dir) == root_dir) {
      root_dir <- NULL
      break
    }
    # Move to parent directory
    root_dir <- dirname(root_dir)
  }
  if (is.null(root_dir))
    stop(config_file,  " not found! It this really a Jekyll site?")

  site <- yaml.load_file(file.path(root_dir, config_file))
  # If 'localimages' is defined, replace 'images' with it
  if (!is.null(site$localimages))
    site$images <- path.expand(site$localimages)

  # Create a special directory for our book on root_dir
  books_dir <- file.path(root_dir, "_books")
  dir.create(books_dir, showWarnings = FALSE)
  book_path <- file.path(books_dir, name)
  dir.create(book_path, showWarnings = FALSE)

  # Get a list of all files we need to put in our book
  rmd_files <- list.files(pattern = "^[^_].+.[Rr][Mm][Dd]$")
  if (!length(rmd_files))
    stop("No .Rmd files (not starting with _) found in the active directory")

  # Process each file in turn
  section <- NULL
  for (file in rmd_files) {
    dat <- readLines(file, encoding = encoding)
    # If the file is empty, move to next file
    if (!length(dat)) break
    # Extract and interpret the YAML header if there is one
    yaml_tags <- grep("^\\-{3}", dat)
    if (length(yaml_tags) >= 2 && yaml_tags[1] == 1) {
      # Get page configuration
      page <- yaml.load(paste(dat[2:(yaml_tags[2] - 1)], collapse = "\n"))
      # Strip YAML header out of our data
      dat <- dat[-(1:(yaml_tags[2] + 1))]
      # Add section as new h1 title, if it is new, and title as h2
      head <- ""
      if (!is.null(page$section)) {
        if (is.null(section)) {
          # First encountered section and title are not used!
          # They are replaced by first_section and first_subsection
          if (!is.null(first_section))
            head <- c(paste("#", first_section), "")
          section <- page$section
          # Replace page$title by first_title
          page$title <- first_title
        } else if (page$section != section) {
          section <- page$section
          head <- c(paste("#", section), "")
        }
      }
      # Do we add a title ?
      if (!is.null(page$title)) {
        head <- c(head, paste("##", page$title), "")
      }
      dat <- c(head, dat)
    }
    # Clean up Jekyll tags
    # Strip out any {% ... %}
    dat <- gsub("\\{%.+%\\}", "", dat)

    # Replace known site and page Jekyll variables
    site_vars <- gregexpr("\\{\\{ *[site\\.|page\\.][^}]+ *\\}\\}", dat)
    for (i in 1:length(site_vars)) {
      vars <- site_vars[[i]]
      dat_line <- dat[i]
      l <- nchar(dat_line)
      if (vars[1] > -1) { # There is something to deal with
        for (j in 1:length(vars)) {
          start <- vars[j] + 2
          end <- start + attr(vars, "match.length")[j] - 5
          var <- substring(dat_line, start, end)
          # Try interpretting var after replacing all . by $
          res <- try(eval(parse(text = gsub("\\.", "$", var))), silent = TRUE)
          if (inherits(res, "try-error")) {
            warning("Found unknown Jekyll variable ", var, " in ", file)
            res <- ""
          }
          dat_line <- paste0(substring(dat_line, 0, start - 3), res,
            substring(dat_line, end + 3, l))
        }
        dat[i] <- dat_line
      }
    }
    # Replace all other Jekyll variables by nothing
    dat <- gsub("\\{\\{[^}]+\\}\\}", "", dat)
    Encoding(dat) <- encoding

    # Write this file into our book directory
    #writeLines(dat, file.path(book_path, file))
    writeLines(enc2utf8(dat), file.path(book_path, file), useBytes = TRUE)
  }

  # Now, use bookdown to finalize the PDF
  setwd(book_path)
  bookdown::render_book(input = NULL, bookdown::pdf_book())

  res <- list(init_dir = dir, root_dir = root_dir, book_dir = book_path,
    book = name, book_encoding = encoding, rmd_files = rmd_files,
    site = site, page = page)
  invisible(res)
}

setwd("/Users/phgrosjean/Documents/Pgm/Github/SciViews.github.io/_source/recipes/tcltk")
#setwd("/Users/phgrosjean/Documents/Pgm/Github/SciViews.github.io")
book_name <- "Rtcltk"
book_encoding <- "UTF-8"
res <- prepare_book(name = book_name, encoding = book_encoding)

