+++
title = "Nicer water and biomes"
date = "2023-09-21"
sorted_by = "date"
[taxonomies]
tags=["programming", "gamedev", "monogame", "contingency"]
contexts=[]
categories=[]
+++

I've played around a bit with how rivers and the sea are drawn, as well as with
the assignment of biomes to tiles based on moisture and temperature. It's
looking quite nice now.

Rivers have flow direction. I pass this to the shader as vertex attribute. I
then sample Perlin noise in the fragment shader offset along this direction to
make the water appear to flow. I also darken the river towards the centre to
give the illusion of deeper water. I find it looks very pleasing.

<iframe width="560" height="315" src="https://www.youtube.com/embed/qcwl4bF31RE?si=ga_1U3t18lSkDjt1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Shader Tweaker

You can also see the little shader parameter tweaker I made to help tune the
ocean rendering. MonoGame exposes shader uniforms, so I can simply query what is
there and if the types match something I know how to edit, I can display an edit
field to tweak them. I have a simple scene graph where the geometry to be
rendered with a shader lives under a node with a reference to that shader, so
the tweaking fields are shown in the scene graph debug viewer.

<iframe width="560" height="315" src="https://www.youtube.com/embed/6tLu0XMCdrc?si=F381518U5HPeXAya" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>