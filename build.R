local({
  # fall back on '/' if baseurl is not specified
  baseurl = servr:::jekyll_config('.', 'baseurl', '/')
  knitr::opts_knit$set(base.url = baseurl)
  # fall back on 'kramdown' if markdown engine is not specified
  markdown = servr:::jekyll_config('.', 'markdown', 'kramdown')
  # see if we need to use the Jekyll render in knitr
  if (markdown == 'kramdown') {  
    myrender_jekyll <- function (highlight = c("pygments", "prettify", "none"),
    extra = "") {
      hi = match.arg(highlight)
      knitr::render_markdown(TRUE)
      if (hi == "none") 
        return()
      switch(hi,
        pygments = {
          hook.r = function(x, options) {
            paste("\n\n{% highlight ", tolower(options$engine), 
              if (extra != "") " ", extra, " %}\n", x, "\n{% endhighlight %}\n\n", 
              sep = "")
          }
          #hook.t = function(x, options) paste("\n\n{% highlight text %}\n", 
          #  x, "{% endhighlight %}\n\n", sep = "")
          hook.t = function(x, options) paste("\n\n<div class=\"highlight-output\"><pre><code>", 
            knitr:::escape_html(x), "</code></pre></div>\n\n", sep = "")
        },
        prettify = {
          hook.r = function(x, options) {
            paste("\n\n<pre><code class=\"prettyprint ", extra, 
              "\">", knitr:::escape_html(x), "</code></pre>\n\n", sep = "")
          }
          hook.t = function(x, options) paste("\n\n<pre><code>", 
            knitr:::escape_html(x), "</code></pre>\n\n", sep = "")
        }
      )
      knitr::knit_hooks$set(source = function(x, options) {
        x = paste(knitr:::hilight_source(x, "markdown", options), collapse = "\n")
        hook.r(x, options)
      }, output = hook.t, warning = hook.t, error = hook.t, message = hook.t)
    }
    #knitr::render_jekyll()
    myrender_jekyll()
  } else knitr::render_markdown()

  # input/output filenames are passed as two additional arguments to Rscript
  a = commandArgs(TRUE)
  d = gsub('^_|[.][a-zA-Z]+$', '', a[1])
  knitr::opts_chunk$set(
    fig.path   = sprintf('figure/%s/', d),
    cache.path = sprintf('cache/%s/', d)
  )
  # set where you want to host the figures (I store them in my Dropbox Public
  # folder, and you might prefer putting them in GIT)
  if (Sys.getenv('USER') == 'phgrosjean') {
    # these settings are only for myself, and they will not apply to you, but
    # you may want to adapt them to your own website
    knitr::opts_chunk$set(fig.path = sprintf('%s/', gsub('^.+/', '', d)))
    knitr::opts_knit$set(
      base.dir = '~/Dropbox/Public/jekyll/',
      base.url = 'https://dl.dropboxusercontent.com/u/19371999/jekyll/'
    )
  }
  knitr::opts_knit$set(width = 80)
  knitr::knit(a[1], a[2], quiet = TRUE, encoding = 'UTF-8', envir = .GlobalEnv)
})
