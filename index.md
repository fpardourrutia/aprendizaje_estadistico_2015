---
layout: default
---


### Resumen 
La variedad, magnitud y complejidad de muchos problemas estadísticos actuales han llevado al desarrollo rápido de áreas como la minería de datos y machine learning. Todos estos desarrollos están enfocados en aprender de conjuntos de datos: cómo extraer significado, qué patrones interesantes se pueden descubrir, y cómo predecir y estimar cantidades importantes. Este curso es una introducción a los métodos de aprendizaje desde el punto de vista estadístico. Se estudiarán tanto los fundamentos teóricos como aspectos prácticos de su aplicación.

### Prerrequisitos 
  Estadística Matemática o Estadística Aplicada I.

### Temario 
- Introducción al aprendizaje estadístico.
- Métodos lineales para problemas de regresión, regularización.
- Métodos lineales para problemas de clasificación, regularización.
- Extensiones de modelos lineales.
- Modelos aditivos y árboles
- Redes neuronales
- Evaluación y selección de modelos
- Métodos de ensemble: bagging, bosques aleatorios, boosting
- Máquinas de soporte vectorial
- Reducción de dimensionalidad, clustering
- Sistemas de recomendación

### Libro de texto 
  [The Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/)

### Evaluación
  Dos examenes parciales, cada uno con una componente teórica (para resolver en clase) y una práctica (para resolver en casa).

### Referencias y ligas útiles 

- [The Elements of Statistical Learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/) Nuestro libro de texto.
- [An Introduction to Statistical Learning with applications in R ](http://www-bcf.usc.edu/~gareth/ISL/) Una versión más básica de nuestro libro de texto
- [Applied Predictive Modelling (Kuhn)](http://www.springer.com/statistics/life+sciences,+medicine+%26+health/book/978-1-4614-6848-6) Enfoque más aplicado, orientado a R. Usa el paquete caret para selección de modelos.
- [Curso de Machine Learning de Andrew Ng](https://www.coursera.org/course/ml) Un curso muy accesible, enfocado más a los aspectos prácticos.
- [Pattern Recognition and Machine Learning (Bishop)](http://research.microsoft.com/en-us/um/people/cmbishop/prml/) Algunos temas más avanzados.


### Software: R y RStudio


- [R](http://cran.r-project.org/) Sitio de R (CRAN)
- [Rstudio](http://www.rstudio.com/) Interfaz gráfica para trabajar en R.
- [Google Developers R Programming](http://www.youtube.com/watch?v=iffR3fWv4xw&list=PLOU2XLYxmsIK9qQfztXeybpHvru-TrqAP) Introducción a los fundamentos de programación en R.
- Para hacer reportes: [R Markdown — Dynamic Documents for R](http://rmarkdown.rstudio.com)  Cómo hacer reportes simples desde Rstudio.


  <h1 class="page-heading">Clases</h1>

<ul class="post-list">
    {% for post in site.posts %}
      <li>  <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
          <a class="post-link" href="{{ post.url | prepend: site.baseurl }}"> {{ post.title }}</a>
	  <p>{{ post.excerpt }}</p>       
      </li>
    {% endfor %}
</ul>

 

</div>
