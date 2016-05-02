# SciViews web site

This is the SciViews website R Markdown/Knitr/Jekyll generator. Go to [http://www.sciviews.org](http://www.sciviews.org) to reach it.

To compile this site, you should use **knitr** and **servr** R packages from [CRAN](http://cran.r-project.org):

```
install.packages(c("knitr", "servr"))
```

Then, in **R Studio**, open the **SciViews.github.io** project and issue this command in the R console:

```
servr::jekyll(input = c(".", "_source/articles", "_source/blog")
             output = c(".", "_posts/articles", "_posts/blog"))
```

See [Yihui Xie's knitr-jekyll](https://github.com/yihui/knitr-jekyll) Github repository for more information.
