#lang scribble/manual

@title{Data}

This chapter will be dealing exclusively with
number cards (A-10), and Jokers.

@section{Card Sequences}

A datum is made up of a sequence of cards.
Data in decks is separated by face-down cards,
unless the data is R, in which case separation
is optional.

@section{Leading Suits}

The leading suit of a card sequence is the suit of the
top card of the datum. Most data types that
use suit only use the leading suit of the datum.

When a card sequence is in the stack, the leading suit
is the bottom card of that sequence, since the stack
reverse all data that goes into it.

@section{Interpretation Types}

Royal cards will specify how each of the arguments they
require are interpreted. Below are the possible interpretations.

@subsection{Cards}

No interpretation is made. The data is taken literally
as the cards in the sequence.

@subsection{Name}

Interprets the card sequence as the name of a deck space
on the table. The sequence R represents the stack.
Name interpretations are either stack inclusive and
will accept R, others are not stack exclusive and
will not accept R.

@verbatim{
As > the 1 of spades deck
2c 0c 3c > the 203 of clubs deck
R > the stack
          }

A card sequence that has more than one suit type in
it is invalid for a name. A card sequence that starts
with a Ten card is invalid for a name.

@verbatim{
0s As > error
2c 0s 3s > error
          }

@subsection{Forced Integer}

Interprets the card sequence as a positive whole number,
unless the leading suit is clubs, in which case the
number is a negative whole number.

@verbatim{
3s > 3
3c > -3
3h > 3
3d > 3
0s 4c > 4
0c 4s > -4
          }

R is invalid for forced integers.

@verbatim{
R > error
          }

@subsection{Forced Number}

Interprets the card sequence as a positive whole number,
unless the leading suit is spades or clubs, and the suit
of a card in the sequence is diamonds. In that case,
the first diamonds card represents the decimal point
(and not a digit), and all cards after the first diamonds
card are the fractional part of the number.
If the leading suit of a forced number is clubs, the
number is negative.

@verbatim{
3s > 3
3s 0d > 3
3s 0d 0s > 3
3s 0d 1s 4s 1s 5s 9s > 3.14159
3c 0d 1c 4c 1c 5c 9c > -3.14159
3h 0d 1h 4h 1h 5h 9h > 3,014,159
3d 0d 1d 4d 1d 5d 9d > 3,014,159
0s 0d 1c             > 0.1
0s 0d 0d 1c          > 0.01
0d 0d 1c             > 1
          }

R is invalid for forced numbers.

@verbatim{
R > error
          }

@subsection{Boolean}

All card sequences evaluate as #t, except for
0d, and any number of repeating zeros that have a
leading suit of diamonds, which evaluates as #f.
R evaluates as null.

@verbatim{
0s > #t
0c > #t
0h > #t
0d > #f
0d 0s 0h 0c > #f
0d 0s 0h 1c > #t
1d > #t
R  > null
}

@subsection{Print}

Interprets each datum differently based on its leading suit.
This data type is used to turn RifL data into human readable
information, and vice versa.

Interprets data with leading suit spades or clubs as a forced number.

@verbatim{
3s > 3
3s 0d > 3
3s 0d 0s > 3
3s 0d 1h 4h 1h 5h 9h > 3.14159
3c 0d 1c 4c 1c 5c 9c > -3.14159
0s 0d 1c             > 0.1
0s 0d 0d 1c          > 0.01
0d 0d 1c             > 1
          }

Interprets data with leading suit hearts as an ascii character.
RifL will throw an error if the ascii number it to large.
@verbatim{

          }

Interprets data with a leading suit of diamonds as a boolean.
@verbatim{
0d > #f
0d 0s 0h 0c > #f
0d 0s 0h 1c > #t
1d > #t
          }

Inteprets R as no character.
@verbatim{
R > ""
          }


