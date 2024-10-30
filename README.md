Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Nicholas Liu
  * [Linkedin](https://www.linkedin.com/in/liunicholas6/)
* Tested on: Linux Mint 22 Wilma, AMD Ryzen 7 5800X @ 2.512GHz, 32GB RAM, GeForce GTX 1660 Ti

## Project Overview

This Vulkan project implements grass rendering techniques outlined in the paper [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)

Each blade of grass is represented as a cubic bezier: one at the base of the grass blade, that lies at some point above the grass blade, and one at the tip of the grass blade. The grass moves according to forces applied to the tip of the grass, namely gravity, a restorative force that tries to pull the grass to a vertical position, and a wind function. The grass control points are controlled using a compute shader.

The control points of each grass blade are transformed into quads with the tesselation pipeline. These quads are then distorted into a triangle shape that are bent along the bezier, thus producing the grass shape!

## Culling Methods

For maximum performance, several different criteria for culling blades were implemented

- Orientation culling: if a blade of grass is tangent to the camera's view vector, it has zero width and should not actually fill in any pixels, and can thus be discarded. Shown is an agressive cull that culls at `theta` where `cos(theta) < 10`

- Frustum culling: Any blades that are not within the view frustum should not be rendered and are culled at the compute stage. Shown is culling with a frustum that is just slightly too tight, hence blades of grass disappearing at the sides.

- Distance culling: In order to reduce the number of blades rendered, we don't render blades that are beyond a further distance. In order to lessen the effect of the aribtrary cutoff, we have each blade probabilistically have a higher change to disappear as they approach the maximum cutoff distance.


| <img src="img/orientationcull.gif" width=350> | <img src="img/frustumcull.gif" width=350> | <img src="img/distancecull.gif" width=350> |
|:--:|:--:|:--:|
| *Orientation Culling* | *View Frustum Culling* | *Distance Culling* |