Md and Holden's Final Project for Mr. Konstantinovich's APCS Class Semester 2

Project Idea: A rendition of the puzzle game Osmos in Processing

Instructions:

-Open one of the .pde files in Processing 3 and run

Features:

- Controllable cell that bounces off walls and accelerates/decelerates

- Player and enemies which can absorb each other

- Sprites from the actual game which update based on gameplay

-Cell propulsion system that follows the rules of physics

Bugs:

- Sometimes very small cells cause bigger cells to shrink when they collide

- If you speed up a lot while small, your size fluctuates getting bigger and smaller, probably caused by absorbing your own expulsion

Development Log:

5/31:

-Started coding, made class files

6/1:

-Learned about PVectors, implemented them as instance variables

6/2-6/4:

-Very busy weekend; no work done

6/5:

-Made a player cell that can move based on user input

-Implemented some physics so the player bounces off walls correctly, and accelerates/decelerates

-Added enemy cells and an absorption mechanism which changes rate based on cell radii

6/6:

-Added sprites for cells from the real game

-Fixed image quality loss issue by reloading the image for each cell every few frames

-Made the level contain randomly generated cells that don't touch the player

-Made enemy cells able to absorb each other

6/7:

-Tweaked absorption feature

6/8:

-Optimized absorption algebra, improved performance by fixing image scaling quality error bug caused by resize()

6/9:

-No updates

6/10:

- Added sprites for bigger/smaller enemies and made them update based on size, optimized most of the code especially the drawing, updated prototype and readme features

6/11:

- Added bigger map, made player stay centered, added cell propulsion system, tweaked movement and display to make everything smooth