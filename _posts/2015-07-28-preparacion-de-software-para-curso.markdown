---
layout: post
title:  "Preparación de software para clase"
date:   2015-07-28 
categories: software R
---

Todos los scripts y notas de clase se preparán a partir de una instalación estándar de R y RStudio. De esta manera todos tenemos la misma corrida de referencia, independiente de la plataforma o la instalación de cada quien. 

Para instalar el software (se requieren al menos 4Gb de memoria):

- Instala [Vagrant](https://www.vagrantup.com) y [Virtualbox](https://www.virtualbox.org)
- Baja el archivo zip (lado derecho) en [el repositorio de la clase](https://github.com/felipegonzalez/aprendizaje_estadistico_2015) y desempaquétalo.
- En una línea de comandos (terminal en Mac, dentro de Accesorios en Windows) corre desde esta nueva carpeta el comando:
```
vagrant up
```
La primera instalación puede tardar hasta una hora.
- En un navegador (Safari o Chrome), abre la liga [http://localhost:8787](http://localhost:8787). Ahora ya estás trabajando en Rstudio.
- Guarda tu trabajo en la carpeta  `clases`. Esta carpeta está dentro de la máquina virtual,
y está sincronizada con la carpeta `clases` desde donde arranacaste vagrant. Puedes utilizar
el comando `vagrant halt` (apagar la máquina virtual) para termines, y `vagrant up` cuando quieres regresar a ella. Puedes utilizar también `vagrant suspend` para pausar la máquina, de forma que cuando la arranques otra
vez este en el mismo lugar que la dejaste.
- Puedes comenzar de nuevo ejecutando `vagrant destroy` y luego vagrant up otra vez. Sin embargo, esto
borra todos los archivos que hayas guardado en la máquina virtual.
