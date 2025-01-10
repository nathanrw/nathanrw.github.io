+++
title = "What did I do in 2024?"
date = "2025-01-09"
sorted_by = "date"
template = "post.html"
[taxonomies]
tags=[]
contexts=[]
categories=[]
+++

I realised that in 2024 I made no updates to this website! There are
a number of reasons for this:
  - I didn't get round to it
  - I felt compelled to say something about Israel's genocide in Gaza before
    talking about other things, but couldn't find the words.

## Contents

<!-- toc -->

## October 2023

### Murder Mystery
Much of September and early October I spent working on a [murder mystery party
game.](../20231125-the-curse-of-the-blood-eagle/)

### Gaza
Then began the still-ongoing genocide in Gaza. I've felt obligated to say
something about it on here ever since, but what words would be adequate, given
what is being done with the full-throated support (and material and military
aid!) of ones own country? So I ended up not posting anything at all.

{{ imglink(src="./images/protest.jpg", alt="An image of a protest march in London") }}

Aside from going to one of the protests in London (perversely labelled 'Hate
Marches' in our execrable and complicit press by the cartoon-villain
then-home-secretary Suella Braverman), one thing I did was to learn more about
the recent political history of the Middle East. An invaluable resource for this
was the [excellent _Thawra_ podcast](https://thedigradio.com/podcast/introducing-thawra/):

> a miniseries on 20th century Arab politics. Over the coming 16 episodes, host
> Daniel Denvir and historian Abdel Razzaq Takriti delve into the history of the
> diverse political radicalisms and revolts that have swept across Arab lands in
> the past century. Denvir and Takriti demystify the fundamental coloniality of
> the modern Middle East—including of Israel, the Zionist settler colony
> launched by the British.

The website links an MP3 file, but you can also find it on Spotify etc.

#### The BDS Campaign

It is important to support the [BDS Campaign.](https://bdsmovement.net/Act-Now-Against-These-Companies-Profiting-From-Genocide)

BDS stands for 'Boycott, Divestment and Sanctions'. It is led by the Palestinian
BDS National Committee. It is a campaign of _targetted_ boycotts of goods and
services.

> The BDS movement uses the historically successful method of targeted boycotts
> inspired by the South African anti-apartheid movement, the US Civil Rights
> movement, the Indian anti-colonial struggle, among others worldwide. 
>
> <br>
>
> We must strategically focus on a relatively smaller number of carefully
> selected companies and products for maximum impact. We need to target
> companies that play a clear and direct role in Israel’s crimes and where there
> is real potential for winning, as was the case with, among others, G4S,
> Veolia, Orange, Ben & Jerry’s and Pillsbury. Compelling large, complicit
> companies, through strategic and context-sensitive boycott and divestment
> campaigns, to end their complicity in Israeli apartheid and war crimes against
> Palestinians sends a very powerful message to hundreds of other complicit
> companies that “your time will come, so get out before it’s too late!”

The point is _not_ simply to avoid feeling as an individual that one is
complicit. As a UK citizen, a certain degree of complicity in the genocide is
unavoidable -- our government is supporting, arming and participating in it, and
aside from a few independent candidates it has not been possible to vote against
it. It is therefore not a problem that the list of companies and products to
boycott is 'arbitrary' or 'incomplete' -- it has to be, in order to stand the
chance of having an effect.

Similarly, a common objection to calls for solidarity with Palestine is: why
oppose regime X and not regime Y? What about Xinjiang, the Congo, Sudan, ...?
There are a few fairly obvious answers to this:
  - Our government is not directly backing those atrocities. Nobody in our press
    is argueing that the treatment of the Uyghurs is Good Actually. Our
    government isn't selling F-35 parts to Congolese militias or providing them
    with access to airbases. (There are other forms of complicity in various
    atrocities, but the point is that it isn't nearly so direct!)
  - Any campaign is by definition not another campaign. If you're doing one
    thing you are not doing another thing. If we never did anything because 'why
    not do the other thing' then nothing would ever happen at all. And quite
    often this is precisely the aim when this point gets made by the ghouls that
    write in newspapers.

#### Medical Aid for Palestinians

- [medical aid for palestinians](https://www.map.org.uk/)

## Projects in 2024

In terms of personal project work, 2024 was a period of dabbling in various
different things.

### Contingency

{{ imglink(src="./images/contingency.jpg", alt="An image of Contigency in its current state") }}

To the great surprise of nobody I'm sure, progress on my magnum opus economic
simulation has stalled. This is because I went down a few ultimately
unproductive rabbit holes, and because I spent a lot of time dabbling in other
areas.

#### Quantities Optimization

The first tarpit was optimization of my `Quantities` type. I found that
calculating land use for the entire world every frame was taking a lot of time,
due to lots of arithmetic operations involving `Quantities`. I'll probably do a
post about this because the problem itself and the solutions I tried are fairly
interesting (to me). I didn't find a completely satisfactory solution but the
one I did find _was_ much faster than what I started with.

#### IMGUI Experiments

Second, I experimented with making a simple UI system as an alternative to Dear
ImGUI for game UI. The motivation for this is that Dear ImGUI is designed to be
used for tools, and you only have limited control over how it looks.

{{ imglink(src="./images/imgui.jpg", alt="An image of my a UI example") }}

This might be worth taking further at some point, but really it took up a fair
bit of work for not a lot of reward. For now, I think the best approach is to
just use Dear ImGUI for everything and accept things looking like Dear ImGUI as
the price of its ease of use.

#### Stalled Progress

{{ imglink(src="./images/contingency2.jpg", alt="An image of Contigency in its current state") }}

This project is now on hold whilst I aim to fully complete a less ambitious
project first. I'm actually quite happy with how the project is looking at the
moment, but it's too big to be able to declare it finished in any reasonable
length of time -- and the aforementioned distractions sapped my enthusiasm
somewhat.

### Workbench

The Workbench is probably the most useful thing I made this year.

Often, I want to implemented a technique or debug an algorithm. In the context
of a running game this can be too clumsy -- you really just want to be executing
the code you are interested in and nothing more, and you don't want to have to
do a bunch of work to set up your test case.

It's possible to make a separate MonoGame project for each case like this, but
there is a lot of boilerplate involved and switching between cases is slow.

The Workbench gives me a way of quickly adding new self-contained graphical
applications without as much work as creating a new project, and allowing me to
re-use all assets, and in a way that allows me to quickly switch between test
cases.

All I now have to do is derive a class from the following, and it is automatically
picked up via reflection as a bench that I can select:

```C#
    public abstract class Bench
    {
        public WorkbenchGame Game;

        public void Initialise(WorkbenchGame game)
        {
            Game = game;
            Initialised();
        }

        public virtual void Initialised()
        {

        }

        public virtual void BeginFrame(GameTime gameTime)
        {

        }

        public virtual void GUI(GameTime gameTime)
        {

        }

        public virtual void Update(GameTime time)
        {

        }

        public virtual void Input(GameTime time)
        {

        }

        public virtual void Draw(GameTime time)
        {

        }

        public virtual void EndFrame(GameTime gameTime)
        {

        }

        /// <summary>
        /// Should return 'true' unless the bench wants to host the workbench UI
        /// itself via Game.DoMainGUI().
        /// </summary>
        public virtual bool WantDefaultMainUI => true;
    }
```

A Bench can easily do custom drawing, input and make Dear ImGUI calls.

Here's a Bench for debugging the Delaunator library:

{{ imglink(src="./images/workbench_delaunator.jpg", alt="An image of the workbench debugging Delaunator") }}

And here's a more complex Bench for prototyping 4x game rules on a sphere:

{{ imglink(src="./images/workbench_4x.jpg", alt="An image of the workbench debugging a 4x map") }}

The other win here is my decision to keep all of my game projects within a
single solution in a single repository. They all share a lot of code with one
another, and they don't 'rot' over time. Despite me having not touched
Contingency in a while, I can still easily fire it up and work on it.

### OMMERUM

Two things are fascinating to me:
  1. Tunnels
  2. [The 100% perfect combat system of Baldurs Gate: Dark Alliance](https://youtu.be/D1T-s8jaksM?feature=shared&t=28)

<a data-flickr-embed="true" href="https://www.flickr.com/photos/198065566@N05/albums/72177720323079805" title="Tunnels"><img src="https://live.staticflickr.com/65535/54257800678_9154c84bf8_z.jpg" width="640" height="480" alt="Tunnels"/></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>

So I experimented with making an isometric ARPG in a precedurally-generated tunnel system.

<iframe width="560" height="315" src="https://www.youtube.com/embed/dDZk8IuE0io?si=floguFQwrrdoigNA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

<iframe width="560" height="315" src="https://www.youtube.com/embed/g7ctxJih0Q0?si=GGzxsGPRHHz4zmrP" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

#### Skeletal Animation

This project stalled when I got side-tracked into writing a tool for skeletal
animation. I was dismayed by the complexity involved in making animations in
tools like Blender, and in importing them into MonoGame. I looked at the GLTF
format and was quite intimidated by it! Surely I could come up with something
simpler myself?

{{ imglink(src="./images/skeleton.jpg", alt="An image of the skeleton editor") }}

As you might expect, making even a simple tool for this is going to take more
work than learning to do it the normal way and import the result. So I need to
do that (learn blender) before I continue with this! Otherwise it will be a game
about a cube with a floating sword, and I'm not too inspired by that!

It did help me flesh out my Workbench tool though!

### Get Annihilated

I've been working on a 'hex and counter' style wargame on the surface of a
sphere, which I am provisionally calling 'Get Annihilated' as a reference to
[_Total Annihilation_](https://en.wikipedia.org/wiki/Total_Annihilation) and
[_The World's End_](https://en.wikipedia.org/wiki/The_World%27s_End_(film)).

{{ imglink(src="./images/getannihilated_menu.jpg", alt="An image of a wargame main menu") }}
{{ imglink(src="./images/getannihilated.jpg", alt="A screenshot from a _Get Annihilated_ prototype") }}

I love hex grid maps and I've been wanting to make a game around one for ages.
One thing I always wanted from Civilization 5 was for the map to be on a true
sphere, not a 2D grid projected onto a cylinder. Now, it's mathematically
impossible to tesselate a hex grid onto a sphere, but there are compromises that
allow you to do it: include a few pentagons, or have arbitrary polgons instead
of true hexes. That's what I've gone for here: lay out points on the surface of
a sphere using the fibonacci spiral, perturb them a bit, then compute the convex
hull. On a sphere, the convex hull is the same as the delauney triangulation,
which is itself the same as the voronoi diagram. So instead of hexes, we have
voronoi cells on the sphere surface. If you don't perturb the points, you get
'mostly hexes' in a very recognizable pattern. If you perturb the points a bit,
you get more irregular shapes in a less obvious pattern.

The inspirations here are a cocktail of miniature wargames like _Epic
Armageddon_ and _Legions Imperialis_, and videogames such as _Shadow Empire_,
_Supreme Commander_ and _Dominions_.

I took a deliberately slapdash approach to the initial implementation, which I
think has paid off. I even made the very first prototype wholly within the
Workbench. The current version is fully playable with hot-seat and play-by-email
(PBEM) multiplayer.

Subsequently, I have been experimenting with different combat systems for it in
the Workbench -- the current version is highly abstracted, whereas what I want
is something like Dominions where hundreds of little blokes duke it out:

<iframe width="560" height="315" src="https://www.youtube.com/embed/r0EGNVkrd14?si=Xhz5AW8xVxfsZypz" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

Art assets here are from various assets packs I bought.

I'm currently working on a more sophisticated economic model with unit design,
where units are composed from devices that have to be built in factories. It's a
big step-up in complexity which I'm trying to manage by working on small parts
at a time in the Workbench. I'd like soon to be able to make another full game
prototype integrating my economic model and combat system.

I have all sorts of ideas for this including different factions, events and
weapons of mass destruction. I'm hoping that because the scope of this game is
deliberately limited -- it's a pure wargame which you win or lose, not an
open-ended simulation -- I can get a lot of this stuff implemented and actually
sell copies of it...

## Miniatures

<a data-flickr-embed="true" href="https://www.flickr.com/photos/198065566@N05/albums/72177720323098703" title="Minis"><img src="https://live.staticflickr.com/65535/54256692192_caa318aebb_z.jpg" width="640" height="480" alt="Minis"/></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>

I got back into miniature wargaming with friends. I'd been wanting to get into
epic-scale warhammer since finding the _Epic Armageddon_ rulebook in a charity
shop a few years ago. With the release of _Legions Imperialis_ a few of us got
into it and now I have lots of tiny plastic men. My aim has been to collect
miniatures I can use in either system, so I actually don't have all that many
official LI miniatures -- mostly old _Epic_ stuff or third party miniatures. But
now I have the bug I'll probably be getting some more...

The LI rules are a bit of a mixed bag. It's a fun game that looks great, but the
rules themselves are somewhat inelegant, and released in a dribble of overpriced
rulebooks. I'll probably write a post about them at some point.

## Driving

I got my driving license in late 2023, so much of 2024 was spent driving to the
countryside.

<a data-flickr-embed="true" href="https://www.flickr.com/photos/198065566@N05/albums/72177720323084111" title="Outside"><img src="https://live.staticflickr.com/65535/54257692551_a521403f90.jpg" width="640" height="480" alt="Outside"/></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>