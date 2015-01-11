Notes
=====

Intro
-----

This is the exercise section to the first haskell tutorial.

For every step there is both a git branch with exercise and solution - so you
can dabble around in the exercise branch and if you are stuck `git checkout
step_xx_solution` to find guidance and/or help.

There are 5 steps
-----------------

1. Basic datatypes: I want you to define a datatype that models a **lego** brick
   it should have slots for its **dimensions**, which should exist as an own
   datatype, another attribute of our lego brick would be its **colour**. As we want
   to be able to display this colour afterwards on our console window we stick
   to the colours found in the palette of our favourite terminal emulator.
   According to [wikipedia](https://en.wikipedia.org/wiki/ANSI_escape_code#Colors)
   we have the following colours at our hand: Black, Red, Green, Yellow, Blue,
   Magenta, Cyan, and White. At last I want you to define functions **turn**,
   **setX**, **setY**, and **setColour**. For now the `show` functions can be
   autoderived as well as the `Enum` instance of colour.

   Bonus: Make a nicer show instance for dimension and lego.

   Hint: The keyword `instance` should be helpful.

2. write a prettyprint functions for `Lego`, the output of such a prettyprint
   functions should be as follows:

   ```haskell
   $> pprint (Lego (D 1 1) Black)
    _
   |0|

   $> pprint (Lego (D 1 3) Red)
    _
   |R|
   |R|
   |R|

   $> pprint (Lego (D 3 2) Blue)
    _____
   |B B B|
   |B B B|

   ```

   In short every lego brick should have dimension x many letters representing the
   colour, 0 for Black and the first letter for the other colours, separated by
   spaces, to the left and right hand side of the letters there should be a pipe
   character. In addition the top row should be a line of underscore characters.

   **Bonus**: Use the unicode character "Overline" (Hex 203e), and the box drawing
   character "Vertical Line" (Hex 2502) to create a better pprint picture of our
   lego brick.

3. Make a new datatype for the string representation of our lego brick - STRego
   that represents the top/middle/(bottom) part.

4. Finally colours - let us use ANSI escape sequences (sadly only possible on
   posix terminals) to get more colours in our life.

   Taking a look at Wikipedia we see if we print the string "\x1b[30m" before a
   given string we set the background colour to black until we print the string
   "\x1b[0m" to reset the colour (and all other properties). To set the background
   colour to Red we use "\x1b[31m", Green "\x1b[32m", ... White "\x1b[37m". I
   think you get the hang of it.

   **Hint**: There is a function called `fromEnum` it converts something
   Enumerable to an `Int`.

   Extend the prettyprint function such that instead of letters we have just
   zeroes with background colour defined by the lego brick's colour.

5. Design a new pprint2 function that takes a list of legos and pprints every
   lego in this list next to each other (aligned to top).

   ```haskell
   $> pprint2 [Lego (D 1 4) Blue, Lego (D 2 2) Red, Lego (D 4 1) Yellow, Lego (D 1 4) Magenta]
    _   ___   _______   _
   |B| |R R| |Y Y Y Y| |M|
   |B| |R R|  ‾‾‾‾‾‾‾  |M|
   |B|  ‾‾‾            |M|
   |B|                 |M|
    ‾                   ‾
   ```

6. Rewrite all of the before using lenses instead of record syntax.
