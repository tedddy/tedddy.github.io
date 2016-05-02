---
layout: post
title:  "Introducing a SciViews Jekyll Template for knitr and servr"
excerpt: "This site is powered by Jekyll/Github-Pages combined with Knitr/R Markdown. The template allows to combine articles, books and blogs."
modified: 2015-11-24
categories: blog
tags: [Knitr, R Markdown, Jekyll, web site, blog]
image:
  feature: banner-web.jpg
  credit: Julien Eichinger (fotolia)
  creditlink: https://fr.fotolia.com/id/43052923
  teaser: banner-web.jpg
comments: true
share: true
output: 
  html_document: 
    fig_caption: yes
---

Imagine you can write books, articles, or blogs freely with simple markup formattings, and with the statistical analyses, tables and plots automatically created by [R](http://www.r-project.org). All the gory details to shape your web site or your book, ... or both simultaneously, are handled transparently in the background. Just write - save, write - save, ... and enjoy the almost real-time display of the final result everytime you save your work. It would be nice, isn't it? Brilliant minds, like Yihui Xie and Hadley Wickham did the same dream and they wrote code to make it come true. We bring these tools just a little bit further in the direction of a versatile and easy to use authoring tools for data scientists.

![R Studio servicing this web site]({{ site.images }}/2015-11-17-The-SciViews-Jekyll-Template/RStudioServr.png)
Figure: This blog edited in R Studio (top left) while this web site is build on every save (at right) by R (bottom left).

The new [SciViews web site](http://www.sciviews.org) (as of 2015-11-17) is build on [Github](https://github.com) using [Github-Pages](https://pages.github.com) and [Jekyll](https://jekyllrb.com), but also [R Markdown](http://rmarkdown.rstudio.com) and [Knitr](http://yihui.name/knitr/). Yihui Xie's idea is to write posts in R Markdown (.Rmd files), and to rebuild the whole web site everytime a .Rmd page is saved. Of course, Knitr only recompiles the page that you modified, while Jekyll rebuilds the whole site according to such changes. The R package [**servr**](https://github.com/yihui/servr) makes the horse work.

The [SciViews Jekyll template](https://github.com/SciViews/SciViews.github.io) is based on the excellent [So Simple Jekyll theme](https://github.com/mmistakes/so-simple-theme), by Michael Rose, largely modified to fit with the **servr** approach, and to allow different categories that look either like structured documents (similar to Hadley Wickham's book sites, like [Advanced R](http://adv-r.had.co.nz)), or as a collection of pages just sorted by dates (blog).

----

Once the required tools are installed (see [here](http://www.r-bloggers.com/blogging-with-rmarkdown-knitr-and-jekyll/)), authoring is very simple. In [R Studio](https://www.rstudio.com), just make the root directory of your web site the active directory in R and issue `servr::jekyll()`. From this moment on, R monitors all your .Rmd files, and triggers rebuild of the web site on every change. Open your .Rmd files, edit them, save them. That's all. Once you are happy with the result, push your data to Github. Done!

## R code chunks

Of course, as your R markdown pages embed R chunks, you include computation and statistical analyses right inside your pages, like this:


{% highlight r %}
cat("Hi from R and R markdown!\n")
{% endhighlight %}



<div class="highlight-output"><pre><code>## Hi from R and R markdown!
</code></pre></div>



{% highlight r %}
# Random numbers
(x <- rnorm(10))
{% endhighlight %}



<div class="highlight-output"><pre><code>##  [1] -0.3818247 -1.7136016  1.5182213  0.6889598 -1.9501875 -0.5586070
##  [7] -0.2265847 -0.5291636 -0.5930932  0.9457798
</code></pre></div>



{% highlight r %}
# Hex numbers
(y <- strtoi(c("0xff", "123")))
{% endhighlight %}



<div class="highlight-output"><pre><code>## [1] 255 123
</code></pre></div>



{% highlight r %}
# A function
cube <- function(x) {
  if (!is.numeric(x))
    stop("'x' must be numeric")
  x ^ 3
}
cube(1:10)
{% endhighlight %}



<div class="highlight-output"><pre><code>##  [1]    1    8   27   64  125  216  343  512  729 1000
</code></pre></div>

Generate a well-formatted table with `pander::pander()`:


{% highlight r %}
# You need to indicate style = "markdown" with Jekyll's kramdown
pander::pander(head(iris), caption = "Head of the `iris` dataset.",
  style = "rmarkdown", split.tables = Inf)
{% endhighlight %}



|  Sepal.Length  |  Sepal.Width  |  Petal.Length  |  Petal.Width  |  Species  |
|:--------------:|:-------------:|:--------------:|:-------------:|:---------:|
|      5.1       |      3.5      |      1.4       |      0.2      |  setosa   |
|      4.9       |       3       |      1.4       |      0.2      |  setosa   |
|      4.7       |      3.2      |      1.3       |      0.2      |  setosa   |
|      4.6       |      3.1      |      1.5       |      0.2      |  setosa   |
|       5        |      3.6      |      1.4       |      0.2      |  setosa   |
|      5.4       |      3.9      |      1.7       |      0.4      |  setosa   |

Table: Head of the `iris` dataset.

Now, a plot:


{% highlight r %}
plot(iris$Sepal.Length, iris$Petal.Width)
{% endhighlight %}

![A scatterplot of the `iris` dataset](https://dl.dropboxusercontent.com/u/19371999/jekyll/2015-11-17-The-SciViews-Jekyll-Template/iris_plot-1.png) 
Figure: A scatterplot of the `iris` dataset.

Of course, you can also embed R code in the text. For instance, we use R version 3.2.2 (2015-08-14) and 1 + 1 makes 2.

This is a math display:

$$
\begin{align}
\mbox{Union: } & A\cup B = \{x\mid x\in A \mbox{ or } x\in B\} \\
\mbox{Concatenation: } & A\circ B  = \{xy\mid x\in A \mbox{ and } y\in B\} \\
\mbox{Star: } & A^\star  = \{x_1x_2\ldots x_k \mid  k\geq 0 \mbox{ and each } x_i\in A\} \\
\end{align}
$$

... and some inline math $$x^2 + \alpha_2$$ (note that, in R Studio, you must use `$ ...$` for inline math, on the contrary to kramdown that also uses `$$ ... $$`, as for display math blocks).


## The central function: `servr::jekyll()`

Here is the `servr::jekyll()` function:


{% highlight r %}
jekyll(dir = ".", input = c(".", "_source", "_posts"), output = c(".", "_posts", 
    "_posts"), script = c("Makefile", "build.R"), serve = TRUE, command = "jekyll build", 
    ...)
{% endhighlight %}

Place your .Rmd files in `_source` subdirectory, and **servr** will compile them into markdown files in the `_posts` subdirectory. Due to a [bug in Jekyll (< v2.5.3)](https://github.com/jekyll/jekyll/pull/3147), it is not a good idea to place both .Rmd and .md files in the same directory. From there, Jekyll just sees a usual series of .md files in `_posts`, and it uses them to compile the web site. The SciViews template does the rest to ensure a modern and clear organization of your material[^1].

[^1]: Pandoc-style citations are not usable yet with Github-Pages. We still have to find a workaround. We also need to implement the code to compile PDF, ePub and MOBI version of books. Finally, it would be also nice to think about how to implement electronic lab notebooks with similar tools.

The central elements are the `build.R` script and `_source/Makefile` that specify how .Rmd page should be compiled (see `?servr::jekyll` for more details). **Knitr** options can also be specified in the `build.R` script.

There is also a built-in mechanism to save plots in a specific directory and to serve them from a specific address (e.g., by using your public dropbox folder). That way, you can keep these binary files out of your Git/Github repository, which is always a good idea.

## Further reading

[Yihui Xie's post](http://yihui.name/knitr-jekyll/2014/09/jekyll-with-knitr.html) explains how to set up a web site with default Jekyll template to use `servr::jekyll()`. A good starting point to understand how it works in fine details.

The original files that come with the So Simple theme (slightly edited) are also useful: [installation instructions](../../theme-setup/), and an [example of formattings](../../theme-setup/sample.html).
