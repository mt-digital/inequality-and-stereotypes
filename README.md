# Inequality and stereotypes

This will be some code that works with data in inequality and 
stereotypes, and builds some models of the emergence of inequality.

This serves as a prototype/proof-of-concept 
to support my NSF SPRF grant proposal.

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

## Behavioral experiment using Dallinger

Follow [installation steps in the Dallinger documentation](
https://dallinger.readthedocs.io/en/latest/installing_dallinger_for_users.html)
to install Dallinger, which will run the online behavioral experiment.

## The model

We want to understand more about how much average and cumulative payoffs 
increase for women as harmful stereotype prevalence decreases. As harmful
stereotypes change, the 


# References

- Bruner, J., & Connor, C. O. (2016). Power, bargaining, and collaboration. 
  In T. Boyer-Kassem, C. Mayo-Wilson, & M. Weisberg (Eds.), Scientific 
  Collaboration and Collective Knowledge. Oxford: Oxford University Press.
- Garg, N., Schiebinger, L., Jurafsky, D., & Zou, J. (2018). 
  Word embeddings quantify 100 years of gender and ethnic stereotypes. 
  Proceedings of the National Academy of Sciences, 115(16), E3635–E3644. 
  doi: 10.1073/pnas.1720347115
- Griffiths, T. L., Steyvers, M., & Tenenbaum, J. B. (2007). 
  Topics in semantic representation. Psychological Review, 114(2), 211–244. 
  doi: 10.1037/0033-295X.114.2.211
- O’Connor, C. (2019). The Origins of Unfairness. Oxford: Oxford University Press.
- OECD (2017), Gender wage gap (indicator). doi: 10.1787/7cee77aa-en
- Vahdati, A. (2019). Agents.jl: agent-based modeling framework in Julia. 
  Journal of Open Source Software, 4(42), 1611. doi: 10.21105/joss.01611
