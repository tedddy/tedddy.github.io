# Serve this site locally (run this in the R Studio console)
servr::jekyll(input = c('.', './_source/tutorial', './_source/documentation', './_source/recipes', './_source/recipes/gui', './_source/recipes/tcltk', './_source/blog'), output = c('.', './_posts/tutorial', './_posts/documentation', './_posts/recipes', './_posts/recipes/gui', './_posts/recipes/tcltk', './_posts/blog'))


# Convert screenshots to 102dpi usually saved at 72dpi, but then,
# they scale too large in a PDF with default size settings.
# This uses ImageMagick's convert
convert102dpi <- function(images) {
  for (image in images) {
    system(sprintf("convert -units PixelsPerInch %s -density 102 %s", image, image))
  }
}
#setwd("/Users/phgrosjean/Dropbox/Public/jekyll/recipes-tcltk")
#convert102dpi(dir(pattern = "\\.png$"))
