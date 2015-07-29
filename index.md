---
layout: default
---

Todo el código está en el [repositorio del curso](https://github.com/felipegonzalez/aprendizaje_estadistico_2015). Aquí están las ligas a ese material y otros avisos:


<ul class="post-list">
    {% for post in site.posts %}
      <li>  <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }} ~</span> 
          <a class="post-link" href="{{ post.url | prepend: site.baseurl }}"> {{ post.title }}</a>
	{{ post.excerpt }}
      </li>
    {% endfor %}
</ul>

 


