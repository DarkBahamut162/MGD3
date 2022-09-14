# Mungydodance 3
![Mungydodance 3](https://user-images.githubusercontent.com/83576877/176179241-1d9b7c62-8531-48d1-82cd-ea82ccd67bb2.png)

The following project has been in-officially taken over by me (DarkBahamut162).

It's source is being displayed down below.

---

[Mungyodance 3 (StepMania 5)](https://github.com/MadkaT182/MGD3)
---

**Description:** MungyoDance3 Theme port for SM5

**Date:** Nov 20th 2017 - May 25th 2021

---
This time, I've actually forked this project and did my own changes (most of the recent changes there were mine either way...) since my updates to it took way too long to be implemented.

What has been fixed/added by me so far:

* **Two Player Functionality** pretty much everywhere
* Added **Quality of Life** changes
  * Optional changes to ScreenSelectMusic/Course's **Acceleration** selection
    * Added **Inverted Controls**
  * Added **Song Indications** for the following:
    * **Mines** if the song has them
    * Added **TRUE LENGTH** showing actual length of the song being played (start to finish)
      * Changed **LENGTH** to **SONG LENGTH** (shows full length of the song)
    * Changed **BPM** to **DISPLAYBPM** if it has been set and is different to the song's actual bpms
      * Changes color to **RED** if **TRUE BPM** goes beyond current **DISPLAYBPM**
      * Changes color to **ORANGE** if **TRUE BPM** goes beyond current **DISPLAYBPM** but don't last that long
      * Changes color to **GREEN** if **TRUE BPM** goes below current **DISPLAYBPM**
    * Changes color to **YELLOW** if **BPM** does reach max speed but doesn't last that long
    * Shows **HOLDS**, **ROLLS** and/or **LIFTS** depending on availability
    * Shows a **?** in **STEPS** row if song has **FAKES**
  * Added **Difficulty Display Setting** in **Theme Settings** to calculate MGD-like difficulties for all songs/courses *(set as default)*
  * Fixed **Life Setting** in **Theme Settings** to calculate **MGD-like life amount for all songs**
  * **Questions Acceleration** if X-Mods are already used in Courses
  * Forced implementation of **NoteSkin** and selected **Accelerator** in Course/Extra Mode via ApplyGameCommand

Stuff still might need to get fixed and a few more QoL changes need to be implemented, but because of no interest, this project is halted (for now).