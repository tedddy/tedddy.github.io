---
layout: page
title: Sample Post
excerpt: "Just about everything you'll need to style in the theme: headings, paragraphs, blockquotes, tables, code blocks, and more."
modified: 2015-11-24
image:
  feature: banner-1.jpg
  credit: ra2 studio (fotolia)
  creditlink: https://fr.fotolia.com/id/71779546
search_omit: true
sitemap: false
---

Below is just about everything you'll need to style in the theme. Check the source code to see the many embedded elements within paragraphs.

# Heading 1

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6

### Body text

Lorem ipsum dolor sit amet, test link adipiscing elit. **This is strong**. Nullam dignissim convallis est. Quisque aliquam.

![SciViews-K]({{ site.url }}/images/site-logo-144.png)
{: .pull-right}

*This is emphasized*. Donec faucibus. Nunc iaculis suscipit dui. 53 = 125. Water is H<sub>2</sub>O. Nam sit amet sem. Aliquam libero nisi, imperdiet at, tincidunt nec, gravida vehicula, nisl. The New York Times <cite>(That’s a citation)</cite>. <u>Underline</u>. Maecenas ornare tortor. Donec sed tellus eget sapien fringilla nonummy. Mauris a ante. Suspendisse quam sem, consequat at, commodo vitae, feugiat in, nunc. Morbi imperdiet augue quis tellus.

HTML and <abbr title="cascading stylesheets">CSS<abbr> are our tools. Mauris a ante. Suspendisse quam sem, consequat at, commodo vitae, feugiat in, nunc. Morbi imperdiet augue quis tellus. Praesent mattis, massa quis luctus fermentum, turpis mi volutpat justo, eu volutpat enim diam eget metus.

### Blockquotes

> Lorem ipsum dolor sit amet, test link adipiscing elit. Nullam dignissim convallis est. Quisque aliquam.

## List Types

### Ordered Lists

1. Item one
   1. sub item one
   2. sub item two
   3. sub item three
2. Item two

### Unordered Lists

* Item one
* Item two
* Item three

## Tables

| Header1 | Header2 | Header3 |
|:--------|:-------:|--------:|
| cell1   | cell2   | cell3   |
| cell4   | cell5   | cell6   |
|----
| cell1   | cell2   | cell3   |
| cell4   | cell5   | cell6   |
|=====
| Foot1   | Foot2   | Foot3   |
{: .table}

## Code Snippets

Syntax highlighting via Pygments and Rouge

{% highlight css %}
#container {
  float: left;
  margin: 0 -240px 0 0;
  width: 100%;
}
{% endhighlight %}

Non Pygments/Rouge code example

    <div id="awesome">
        <p>This is great isn't it?</p>
    </div>

## Buttons

Make any link standout more when applying the `.btn` class.

<div markdown="0"><a href="http://mademistakes.com" class="btn">This is a button</a></div>

## Equations

[MathJax](http://www.mathjax.org/) is a simple way of including Tex/LaTex/MathML based mathematics in HTML webpages. To get up and running you need to include the MathJax script in the header of your github pages page, and then write some maths. For LaTex, there are two delimiters you need to know about, one for block or displayed mathematics `\[ ... \]`, and the other for inline mathematics `\( ... \)`. But you can also simply use double dollars for both `$$ ... $$`.

To enable MathJax support be sure Kramdown is your Markdown flavor of choice and MathJax is set to true in your `_config.yml` file.

~~~
markdown: kramdown
mathjax: true
~~~

~~~
Here is an example MathJax inline rendering $$ 1/x^{2} $$, and here is a block rendering: 
$$ \frac{1}{n^{2}} $$
~~~

Here is an example MathJax inline rendering $$ 1/x^{2} $$, and here is a block rendering: 
$$ \frac{1}{n^{2}} $$

Think about the escaping of the backslash when using markdown, so the delimiters become `\\[ ... \\]` and `\\( ... \\)` for inline and block maths respectively.


## Code snippets

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

{% highlight html %}
{% raw %}
<nav class="pagination" role="navigation">
    {% if page.previous %}
        <a href="{{ site.url }}{{ page.previous.url }}" class="btn" title="{{ page.previous.title }}">Previous article</a>
    {% endif %}
    {% if page.next %}
        <a href="{{ site.url }}{{ page.next.url }}" class="btn" title="{{ page.next.title }}">Next article</a>
    {% endif %}
</nav><!-- /.pagination -->
{% endraw %}
{% endhighlight %}

### Standard Code Block

    {% raw %}
    <nav class="pagination" role="navigation">
        {% if page.previous %}
            <a href="{{ site.url }}{{ page.previous.url }}" class="btn" title="{{ page.previous.title }}">Previous article</a>
        {% endif %}
        {% if page.next %}
            <a href="{{ site.url }}{{ page.next.url }}" class="btn" title="{{ page.next.title }}">Next article</a>
        {% endif %}
    </nav><!-- /.pagination -->
    {% endraw %}


### Fenced Code Blocks

To modify styling and highlight colors edit `/_sass/_coderay.scss`. Line numbers and a few other things can be modified in `_config.yml`. Consult [Jekyll's documentation](http://jekyllrb.com/docs/configuration/) for more information.

Note that with the GFM option, you can also use R Markdown style for fences. Apparently, the language is not considered here?!

~~~ css
#container {
    float: left;
    margin: 0 -240px 0 0;
    width: 100%;
}
~~~

~~~ html
{% raw %}<nav class="pagination" role="navigation">
    {% if page.previous %}
        <a href="{{ site.url }}{{ page.previous.url }}" class="btn" title="{{ page.previous.title }}">Previous article</a>
    {% endif %}
    {% if page.next %}
        <a href="{{ site.url }}{{ page.next.url }}" class="btn" title="{{ page.next.title }}">Next article</a>
    {% endif %}
</nav><!-- /.pagination -->{% endraw %}
~~~

~~~ ruby
module Jekyll
  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
      self.data['tag'] = tag
      tag_title_prefix = site.config['tag_title_prefix'] || 'Tagged: '
      tag_title_suffix = site.config['tag_title_suffix'] || '&#8211;'
      self.data['title'] = "#{tag_title_prefix}#{tag}"
      self.data['description'] = "An archive of posts tagged #{tag}."
    end
  end
end
~~~

## Link posts

So Simple Theme now supports **link posts**, made famous by John Gruber. To activate just add `link: http://url-you-want-linked` to the post's YAML front matter and you're done.

~~~
---
layout: post
title: "Sample Link Post"
excerpt: "Example and code for using link posts."
categories: recipes
tags: [sample-post, link-post]
link: http://www.r-project.org  
---
~~~

## Videos

<iframe width="560" height="315" src="//www.youtube.com/embed/pdSp4Y4GOQs" frameborder="0"> </iframe>

Video embeds are responsive and scale with the width of the main content block with the help of [FitVids](http://fitvidsjs.com/).

Not sure if this only effects Kramdown or if it's an issue with Markdown in general. But adding YouTube video embeds causes errors when building your Jekyll site. To fix add a space between the `<iframe>` tags and remove `allowfullscreen`. Example below:

{% highlight html %}
<iframe width="560" height="315" src="http://www.youtube.com/embed/PWf4WUoMXwg" frameborder="0"> </iframe>
{% endhighlight %}

And here's a Vimeo embed for testing purposes.

<iframe src="//player.vimeo.com/video/98146708?title=0&amp;byline=0" width="500" height="281" frameborder="0"> </iframe>

## Images

Here are some examples of what a post with images might look like. If you want to display two or three images next to each other responsively use `figure` with the appropriate `class`. Each instance of `figure` is auto-numbered and displayed in the caption.

## Figures (for images or video)

### One Up

<figure>
	<a href="http://farm9.staticflickr.com/8426/7758832526_cc8f681e48_b.jpg"><img src="http://farm9.staticflickr.com/8426/7758832526_cc8f681e48_c.jpg" alt="image"></a>
	<figcaption><a href="http://www.flickr.com/photos/80901381@N04/7758832526/" title="Morning Fog Emerging From Trees by A Guy Taking Pictures, on Flickr">Morning Fog Emerging From Trees by A Guy Taking Pictures, on Flickr</a>.</figcaption>
</figure>

### Two Up

Apply the `half` class like so to display two images side by side that share the same caption.

{% highlight html %}
<figure class="half">
	<img src="/images/image-filename-1.jpg" alt="image">
	<img src="/images/image-filename-2.jpg" alt="image">
	<figcaption>Caption describing these two images.</figcaption>
</figure>
{% endhighlight %}

And you'll get something that looks like this:

<figure class="half">
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<img src="http://placehold.it/600x300.jpg" alt="image">
	<img src="http://placehold.it/600x300.jpg" alt="image">
	<figcaption>Two images.</figcaption>
</figure>

### Three Up

Apply the `third` class like so to display three images side by side that share the same caption.

{% highlight html %}
<figure class="third">
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<figcaption>Caption describing these three images.</figcaption>
</figure>
{% endhighlight %}

And you'll get something that looks like this:

<figure class="third">
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<a href="http://placehold.it/1200x600.jpg"><img src="http://placehold.it/600x300.jpg" alt="image"></a>
	<figcaption>Three images.</figcaption>
</figure>
