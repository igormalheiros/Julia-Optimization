# Julia Optimization Study

# This Repository contains solutions and algorithms for many problems.

Contents
1. [Assignment Problem](#assignment)
2. [Bin Packing Problem](#binpacking)
3. [Connected Components](#connectedcomponents)
4. [Cutting Stock Problem](#cuttingstock)
5. [Knapsack Problem](#knapsack)
6. [Longest Common Subsequence](#LCS)
7. [Minimum Spanning Tree](#MST)
8. [Single Shortest Path](#SSP)
9. [Subset Sum](#subsetsum)
10. [Travelling Salesman Problem](#TSP)


<!-- ######### ASSIGNMENT ######### -->
<a name="assignment"></a>

## Assignment Problem 

<p>Given a set of tasks and a set of agents, given costs for each agent to perform each task.  It is required to perform all tasks by assigning exactly one agent to each task and exactly one task to each agent in such a way that the total cost of the assignment is minimized.<p>

**Solutions**

* Mixed Integer Programming

<h3>Formulation</h3>

<h4>Constants:</h4>

<img src="imgs/assignment/Constants.gif" /> 

<h4>Variables</h4>

<img src="imgs/assignment/Variable.gif" /> 

<h4>Objective:</h4>

<img src="imgs/assignment/Objective.gif" /> 

<h4>s.t.:</h4>

<img src="imgs/assignment/Constraints.gif" /> 


<!-- ######### BIN PACKING PROBLEM ######### -->
<a name="binpacking"></a>

## Bin Packing Problem

<p>Given a set of itens with different weights, assign each item to a bin such that number of total used bins is minimized. It is assumed that all itens have weights smaller than capacity.<p>

**Solutions**

* Mixed Integer Programming

<h3>Formulation</h3>

<h4>Constants:</h4>

<img src="imgs/binpacking/ConstantWeight.gif" /> 
<img src="imgs/binpacking/ConstantCapacity.gif" /> 

<h4>Variables</h4>
<img src="imgs/binpacking/VariableY.gif" /> 
<img src="imgs/binpacking/VariableX.gif" /> 

<h4>Objective:</h4>
<img src="imgs/binpacking/BinPackingObj.gif" /> 

<h4>s.t.:</h4>
<img src="imgs/binpacking/BinPackingConst1.gif" /> 
<img src="imgs/binpacking/BinPackingConst2.gif" /> 
<img src="imgs/binpacking/BinPackingVariableX.gif" />
<img src="imgs/binpacking/BinPackingVariableY.gif" />

<!-- ######### CONNECTED COMPONENTS ######### -->
<a name="connectedcomponents"></a>

## Connected Components

<p>Given an undirected graph, print all connected components.</p>

**Solutions**
* Depth First Search (DFS)
* Breadth First Search (BFS)

<!-- ######### CUTTING STOCK PROBLEM ######### -->
<a name="cuttingstock"></a>

## Cutting Stock Problem
<p>Given a upperbound number of original rods, the number of new smaller rods, the size and the demand for each new rod. Determine the minimum number of original rods must be cutted to generate all demanded new rods.</p>

**Solutions**

* Mixed Integer Programming

<h3>Formulation</h3>

<h4>Constants:</h4>

<img src="imgs/cuttingstock/Constants.gif" /> 

<h4>Variables</h4>

<img src="imgs/cuttingstock/Variables.gif" /> 

<h4>Objective:</h4>

<img src="imgs/cuttingstock/Objective.gif" /> 

<h4>s.t.:</h4>

<img src="imgs/cuttingstock/Constraints.gif" /> 

<!-- ######### KNAPSACK PROBLEM ######### -->
<a name="knapsack"></a>

## Knapsack Problem

<p>Given a set of itens with different values and weights, determine which itens to include in a colection that total weight of itens is less than or equal to a given limit and the total value is higher as possible.</p>

**Solutions**
* Greedy (Not Optimal)
* Dynamic Programming
* Mixed Integer Programming

<h3>Formulation</h3>

<h4>Constants:</h4>

<img src="imgs/knapsack/ConstantValue.gif" /> 
<img src="imgs/knapsack/ConstantWeight.gif" /> 
<img src="imgs/knapsack/ConstantCapacity.gif" /> 

<h4>Variables</h4>
<img src="imgs/knapsack/VariableX.gif" /> 

<h4>Objective:</h4>
<img src="imgs/knapsack/KnapsackObj.gif" /> 

<h4>s.t.:</h4>
<img src="imgs/knapsack/KnpasackConst.gif" /> 
<img src="imgs/knapsack/KnapsackVariable.gif" /> 

<!-- ######### LONGEST COMMON SUBSEQUENCE PROBLEM ######### -->
<a name="LCS"></a>

## Longest Common Subsequence

<p>Given two sequences, find the length of longest subsequence present in both of them. A subsequence is a sequence that appears in the same relative order, but not necessarily contiguous.</p>

**Solutions**
* Brute Force (Recursion)
* Dynamic Programming

<!-- ######### MINIMUM SPANNING TREE PROBLEM ######### -->
<a name="MST"></a>

## Minimum Spanning Tree

<p>A minimum spanning tree (MST) is a subset of the edges of a connected, edge-weighted undirected graph that connects all the vertices together, without any cycles and with the minimum possible total edge weight.</p>

**Solutions**
* Kruskal's Algorithm
* Prim's Algorithm

<!-- ######### SINGLE SHORTEST PATH PROBLEM ######### -->
<a name="SSP"></a>

## Single Shortest Path

<p>Given a graph and a source vertex in the graph, find shortest paths from source to all vertices in the given graph.</p>

**Solutions**
* Bellman-Ford's Algorithm

<!-- ######### SUBSET SUM PROBLEM ######### -->
<a name="subsetsum"></a>

##Subset Sum

<p>Given a set of non-negative integers, and a value, determine if there is a subset of the given set with sum equal to given value.</p>

**Solutions**
* Brute Force (Recursion)
* Dynamic Programming

<!-- ######### TRAVELLING SALESMAN PROBLEM ######### -->
<a name="tsp"></a>

## Travelling Salesman Problem

<p>Given a set of cities and distance between every pair of cities, the problem is to find the shortest possible route that visits every city exactly once and returns to the starting point.</p>

* Mixed Integer Programming

<h3>Formulation</h3>

<h4>Constants:</h4>

<img src="imgs/tsp/Constants.gif" /> 

<h4>Variables</h4>
<img src="imgs/tsp/Variables.gif" /> 

<h4>Objective:</h4>
<img src="imgs/tsp/Objective.gif" /> 

<h4>s.t.:</h4>
<img src="imgs/tsp/Constraints.gif" />