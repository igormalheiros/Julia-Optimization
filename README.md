# Julia Optimisation Study

# This Repository contains solutions and algorithms for many problems.

<h2> Knapsack Problem </h2>

Given a set of itens with different values and weights, determine which itens to include in a colection that total weight of itens is less than or equal to a given limit and the total value is higher as possible.

**Solutions**
* Greedy (Not Optimal)
* Dynamic Programming
* Mixed Integer Programming

<h3>Formulation</h3>
<h4>Objective:</h4>
<img src="imgs/knapsack/KnapsackObj.gif" /> 

<h4>s.t.:</h4>
- <img src="imgs/knapsack/KnpasackConst.gif" /> 
- <img src="imgs/knapsack/KnapsackVariable.gif" /> 

<h2> Bin Packing Problem </h2>

Given a set of itens with different weights, assign each item to a bin such that number of total used bins is minimized. It is assumed that all itens have weights smaller than capacity.

**Solutions**

* Mixed Integer Programming
