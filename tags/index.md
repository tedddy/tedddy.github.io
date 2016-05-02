---
layout: page
title: Tag Index
excerpt: "An archive of posts sorted by tag."
search_omit: true
---

{% capture site_tags %}{% for tag in site.tags %}{{ tag | first }}{% unless forloop.last %},{% endunless %}{% endfor %}{% endcapture %}
{% assign tags_list = site_tags | split:',' | sort %}

<ul class="tag-box inline">
  {% for item in (0..site.tags.size) %}{% unless forloop.last %}
    {% capture this_word %}{{ tags_list[item] | strip_newlines }}{% endcapture %}
    <li><a href="#{{ this_word }}">{{ this_word }} <span>{{ site.tags[this_word].size }}</span></a></li>
  {% endunless %}{% endfor %}
</ul>

{% for item in (0..site.tags.size) %}{% unless forloop.last %}
  {% capture this_word %}{{ tags_list[item] | strip_newlines }}{% endcapture %}
  <h2 id="{{ this_word }}">{{ this_word }}</h2>
  <ul class="post-list">
  {% for post in site.tags[this_word] %}{% if post.title != null %}
    {% assign year = post.date | date: "%Y" | plus: 0 %}
    <li><a href="{{ site.url }}{{ post.url }}">{{ post.title }}{% if year > 2000 %}<span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span>{% else %}<span class="entry-date"><time datetime="{{ post.modified }}">{{ post.modified | date: "%B %d, %Y" }}</time></span>{% endif %}</a></li>
  {% endif %}{% endfor %}
  </ul>
{% endunless %}{% endfor %}