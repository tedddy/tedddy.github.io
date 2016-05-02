---
layout: page
title: Learning SciViews - tutorial
excerpt: "Visual introduction to R and SciViews."
search_omit: true
---

<ul class="post-list">
{% for post in site.categories.tutorial reversed %} 
  <li><article><a href="{{ site.url }}{{ post.url }}"><b>{{ post.title }}</b> <span class="entry-date"><time datetime="{{ post.modified | to_xmlschema }}T00:00:00-00:00">{{ post.modified | date: "%B %d, %Y" }}</time></span>{% if post.excerpt %} <span class="excerpt">{{ post.excerpt }}</span>{% endif %}</a></article></li>
{% endfor %}
</ul>
