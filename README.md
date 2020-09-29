# Inequality and stereotypes

This will be some code that works with data in inequality and 
stereotypes, and builds some models of the emergence of inequality.

This serves as a prototype/proof-of-concept 
to support my NSF SPRF grant proposal.


## Models, code, and data

This repository contains some of the basic ingredients necessary for
the proposed project. For modeling the coordination required for
men and women to collaborate in the workplace, we use a game theoretic
analysis of the Nash demand game to represent a man and woman both getting
hired and negotiating a salary. Our aim is to connect this to semantic representations
of harmful stereotypes found in culture, quantified using semantic models of
language. Semantic models of language are based on the distributional hypothesis, which
states that the meaning of words can be inferred by their co-occurrence patterns with
other words. I believe these harmful prototypes can be thought of as a cultural norm, which
has evolved over time, both shaped by and shaping strategies taken by men and women 
participating in the labor market, which, again, we model using the Nash demand game.

At this point I am just plotting some relevant data, re-running others' analyses, 
implementing Nash demand ABM for my own benefit, and it may be useful in developing new
hypotheses. I am also prototyping/wireframing a behavioral experiment in which we will
either manipulate or measure semantic relationships held by participants before or after
they play the Nash demand game.

### Nash demand game

The code for this simulation is currently in `model.jl`. 
