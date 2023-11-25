+++
title = "Better hydrology"
date = "2023-09-21"
sorted_by = "date"
[taxonomies]
tags=["programming", "gamedev", "monogame", "contingency"]
contexts=[]
categories=[]
+++

Thinking about improvements to hydrology.

Rainfall per-tile should be measured in mm.

Multiply by area to get volume of water. Measure this in m<sup>3</sup>.

This is river flow at that tile, unless tile is a water tile.

How much moisture evaporates from an ocean tile? How much atmospheric moisture falls as rain?

Quite hard to find data for this.

A couple of approachs at redblob. One just uses distance from water to determine
moisture. The other simulates the water cycle.

Approach 1:

- https://simblob.blogspot.com/2010/09/polygon-map-generation-part-2.html

Approach 2:

- https://simblob.blogspot.com/2018/09/mapgen4-rainfall.html

My approach was based on approach 2. But I don't do any sorting, I traverse the
board following the wind direction. I didn't really follow the precipitation
rules to the letter either. Simply making my approach line up more with the
approach given there would probably improve my results a bit.

To be honest though what I have right now looks OK. The main worry is about
physical units, and about how i'm conflating rainfall and river flow in terms of
moisture at a tile.

In terms of physical units, I can probably stick with some variation of the
current approach, but convert to physical units where appropriate.