# Julia Optimization Study

**It is a study guide for people who are interested in learning Mixed Integer Programming. The repository contains a set of classical optimization problems, and each problem has it is a mathematical formulation and implementation using Julia language with JuMP framework.**

Contents
- [Julia Optimization Study](#julia-optimization-study)
  - [Assignment Problem](#assignment-problem)
  - [Bin Packing Problem](#bin-packing-problem)
  - [Cutting Stock Problem](#cutting-stock-problem)
  - [Facility Location Problem](#facility-location-problem)
  - [Knapsack Problem](#knapsack-problem)
  - [Set Partitioning Problem](#set-partitioning-problem)
  - [Travelling Salesman Problem](#travelling-salesman-problem)
  - [Dial-a-Ride Problem](#dial-a-ride-problem)


<!-- ######### ASSIGNMENT ######### -->
<a name="assignment"></a>

## Assignment Problem 

<p>Given a set of tasks, a set of agents, and the costs of each agent to perform each task. The problem consists of assigning agents to tasks such that the total cost is minimized.<p>

<h3>Formulation</h3>

<h4>Data:</h4>

$n$ is the number of agents and tasks</br>
$c_{ij}$ is the cost of agent $i$ perform task $j$

<h4>Decision Variables:</h4>

$x_{ij}$ assumes value $1$ if task $j$ is assigned to agent $i$, $0$ otherwise

<h4>Objective Function:</h4>

$$ \min \left( \sum_{i=1}^{n}\sum_{j=1}^{n} c_{ij}x_{ij} \right) $$

<h4>s.t.:</h4>

$$ \sum_{i=1}^{n} x_{ij} \\, = \\,1 \qquad i \\, \in \\, n $$

$$ \sum_{i=1}^{n} x_{ij} \\, = \\, 1 \qquad j \\,\in \\, n $$

$$ x_{ij} \\, \in \\, \\{ 0, 1 \\} $$

<!-- ######### BIN PACKING PROBLEM ######### -->
<a name="binpacking"></a>

## Bin Packing Problem

<p>The problem is packing a set of items into a minimum number of bins such that the total weight does not exceed the bin's capacities.<p>

<h3>Formulation</h3>

<h4>Data:</h4>

$n$ is the number of items</br>
$W$ is the capacity of the bins</br>
$w_{j}$ is the weight of item $j$

<h4>Decision Variables</h4>

$y_{i}$ assumes value $1$ if the bin $i$ is used, $0$ otherwise</br>
$x_{ij}$ assumes value $1$ if the item $j$ is assigned to bin $i$, $0$ otherwise

<h4>Objective Function:</h4>

$$ \min \left( \sum_{i=1}^{n}y_{i} \right) $$

<h4>s.t.:</h4>

$$ \sum_{i=1}^{n} x_{ij} \\, = \\, 1 \qquad i \\, \in \\, n $$

$$ \sum_{j=1}^{n} w_{j} x_{ij} \\, \leq \\, W y_{i} \qquad i \\, \in \\, n $$

$$ x_{ij} \\,\in \\, \\{ 0, 1 \\} $$

$$ y_{i} \\,\in \\, \\{ 0, 1 \\} $$

<!-- ######### CUTTING STOCK PROBLEM ######### -->
<a name="cuttingstock"></a>

## Cutting Stock Problem
<p>Given a length and number of original rods, and given a set of lengths and demands of new smaller rods. Determine the minimum number of original rods that must be cut to generate all demanded new rods.</p>

<h3>Formulation</h3>

<h4>Data:</h4>

$L$ is the size of each original bar</br>
$n$ is the upper bound of original rods</br>
$m$ is the number of new smaller rods</br>
$l_{i}$ is the size of each new smaller rod $l_{1}$, $l_{2}$, ..., $l_{m}$</br>
$b_{i}$ is the demand of each new smaller rod $b_{1}$, $b_{2}$, ..., $b_{m}$

<h4>Decision Variables</h4>

$y_{i}$ assumes value $1$ if the original rod $i$ is used, $0$ otherwise</br>
$x_{ij}$ assumes the number of times that a new rod $j$ is cut in the original rod $i$

<h4>Objective Function:</h4>

$$ \min \left( \sum_{i=1}^{n}y_{i} \right) $$

<h4>s.t.:</h4>

$$ \sum_{i=1}^{n} x_{ij} \\, \geq \\, b_{j} \qquad j \\, \in \\, m $$

$$ \sum_{j=1}^{m} l_{j} x_{ij} \\, \leq \\, Ly_{i} \qquad i \\, \in \\, n $$

$$ x_{ij} \\, \in \\, \mathbb{Z} $$

$$ y_{i} \\,\in \\, \\{ 0, 1 \\} $$

<!-- ######### FACILITY LOCATION PROBLEM ######### -->
<a name="facilitylocation"></a>

## Facility Location Problem
<p>Given a set of clients, a set of potential facilities sites, the costs of building each facility, and the costs of assign each client to each possible facility. The problem consists of deciding which places to build facilities to supply the client's demands such that total costs are minimized.</p>

<h3>Formulation</h3>

<h4>Data:</h4>

$I$ is the number of potential facilities</br>
$J$ is the number of clients</br>
$f_{i}$ is the fixed cost of open facility $i$</br>
$c_{ij}$ is the fixed cost of assign client $j$ to facilty $i$</br>
$q_{j}$ is the themand of client $j$</br>
$Q_{i}$ is the capacity of facility $i$</br>

<h4>Decision Variables</h4>

$y_{i}$ assumes value $1$ if facility $i$ is opened, $0$ otherwise</br>
$x_{ij}$ assumes value $1$ if client $j$ is assigned to facility $i$, $0$ otherwise

<h4>Objective Function:</h4>

$$ \min \left( \sum_{i=1}^{I}f_{i}y_{i} + \sum_{i=1}^{I}\sum_{j=1}^{J}c_{ij}x_{ij}\right) $$

<h4>s.t.:</h4>

$$ \sum_{i=1}^{I} x_{ij} \\, = \\, 1 \qquad j \\, \in \\, J $$

$$ \sum_{j=1}^{J} q_{j}x_{ij} \\, \leq\\,  Q_{i}y_{i} \qquad i \\, \in \\, I $$

$$ y_{i} \\, \in \\, \\{ 0, 1 \\} $$

$$ x_{ij} \\, \in \\, \\{ 0, 1 \\} $$

<!-- ######### KNAPSACK PROBLEM ######### -->
<a name="knapsack"></a>

## Knapsack Problem

<p>Given a set of items with different values and weights, determine which items to include in a collection that total weight of items is less than or equal to a given limit, and the total value is higher as possible.</p>

<h3>Formulation</h3>

<h4>Data:</h4>

$n$ is the number of items</br>
$v_{i}$ is the value of item $i$</br>
$w_{i}$ is the weight of item $i$</br>
$W$ is the capacity of the knapsack</br>

<h4>Decision Variables</h4>

$x_{i}$ assumes value $1$ if the item $i$ is in knapsack, $0$ otherwise

<h4>Objective Function:</h4>

$$ \max \left( \sum_{i=1}^{n}v_{i}x_{i} \right) $$

<h4>s.t.:</h4>

$$ \sum_{i=1}^{n} w_{i}x_{i} \\, \leq \\, W $$

$$ x_{i} \\, \in \\, \\{ 0, 1 \\} $$


<!-- ######### SET PARTITIONING PROBLEM ######### -->
<a name="sp"></a>

## Set Partitioning Problem

<p>Given a collection of subsets derived from an original set, the problem is to find a partition of the initial set. In other words, the aim is to select a new set of subsets such that the intersection of every subset is empty, and the union of all subsets is equal to the original set.</p>

<h3>Formulation</h3>

<h4>Data:</h4>

$S$ is the original set</br>
$n$  is the number of subsets</br>
$R_{i}$ is a subset of $S$ that has element $i$

<h4>Decision Variables</h4>

$y_{j}$ assumes value $1$ if the subset $j$ is part of partitioning, $0$ otherwise

<h4>Objective Function:</h4>

$$ \min \left( \sum_{j=1}^{n}y_{j} \right) $$

<h4>s.t.:</h4>

$$ \sum_{j \\, \in \\, R_{i}} y_{j} \\, = \\, 1 \\qquad i \\, \in \\, S $$

$$ y_{i} \\, \in \\, \\{ 0, 1 \\} $$

<!-- ######### TRAVELLING SALESMAN PROBLEM ######### -->
<a name="tsp"></a>

## Travelling Salesman Problem

<p>Given a set of cities and the distance between every pair of cities, the problem is to find the shortest possible route that visits every city exactly once and returns to the starting point.</p>

* Mixed Integer Programming - Subtour formulation

<h3>Formulation</h3>

<h4>Data:</h4>

$n$ is the number of vertices</br>
$N$ is the set of vertices</br>
$S$ is a subtour</br>
$c_{ij}$ is the cost of travel from vertex $i$ to vertex $j$

<h4>Decision Variables</h4>

$x_{ij}$ assumes value $1$ if arc from $i$ to $j$ is used, $0$ otherwise

<h4>Objective Function:</h4>

$$ \min \left( \sum_{i=1}^{n} \sum_{\substack{j=1 \\\ i \neq j}}^{n} c_{ij}x_{ij} \right) $$

<h4>s.t.:</h4>

$$ \sum_{i=1}^{n} x_{ij} \\, = \\, 1 \\qquad j \\, \in \\, n \\, , \\, j \\, \neq \\, i $$

$$ \sum_{j=1}^{n} x_{ij} \\, = \\, 1 \\qquad i \\, \in \\, n \\, , \\, i \\, \neq \\, j $$

$$ \sum_{i \\, \in \\, S}\sum_{j \\, \in \\, S} x_{ij} \\, \leq \\, |S| - 1 \\qquad S \\, \subset \\, N \\, , \\, 2 \\, \leq \\,|S| - 1| \\, \leq \\, \left \lfloor \frac{n}{2}  \right \rfloor$$

$$ x_{ij} \\, \in \\, \\{ 0, 1 \\} $$

* Mixed Integer Programming - Flow Variable

<h3>Formulation</h3>

<h4>Data:</h4>

$n$ is the number of vertices</br>
$c_{ij}$ is the cost of travel from vertex $i$ to vertex $j$

<h4>Decision Variables</h4>

$x_{ij}$ assumes value $1$ if arc from $i$ to $j$ is used, $0$ otherwise</br>
$f_{ij}$ assumes the amount of flow from vertex $i$ to $j$

<h4>Objective Function:</h4>

$$ \min \left( \sum_{i=1}^{n} \sum_{\substack{j=1 \\\ i \neq j}}^{n} c_{ij}x_{ij} \right) $$

<h4>s.t.:</h4>

$$ \sum_{i=1}^{n} x_{ij} \\, = \\, 1 \\qquad j \\, \in \\, n \\, , \\, j \\, \neq \\, i $$

$$ \sum_{j=1}^{n} x_{ij} \\, = \\, 1 \\qquad i \\, \in \\, n \\, , \\, i \\, \neq \\, j $$

$$ \sum_{\substack{j=1 \\\ i \neq j}}^{n} f_{ji} - \sum_{\substack{j=1 \\\ i \neq j}}^{n} f_{ij} \\, = \\, 1 \\qquad i \\, \in \\, n \\, \\backslash \\{1\\} $$

$$f_{ij} \\, \leq \\, (n - 1)x_{ij} \\qquad i \\, \in \\, n \\, , \\, j \\, \in \\, n $$

$$ x_{ij} \\, \in \\\, \\{ 0, 1 \\} $$

$$ f_{ij} \\, \in \\, \mathbb{N} $$

<!-- ######### DIAL-A-RIDE PROBLEM ######### -->
<a name="darp"></a>

## Dial-a-Ride Problem

<p>This problem consists of designing least-cost routes to serve pickup-and-delivery requests, while meeting capacity, time window, maximum route duration, and maximum ride time constraints.</p>

* Mixed Integer Programming

<h3>Formulation</h3>

<h4>Data:</h4>

$n$ is the number of requests</br>
$v$ is the number of vehicles</br>
$P = \{1, \ldots, n\}$ is the set of pickup nodes</br>
$D = \{n+1, \ldots, 2n\}$ is the set of delivery nodes</br>
$m_{o} = 2n + 1$ is the initial depot node</br>
$m_{e} = 2n + 2$ is the ending depot node</br>
$V = P \cup D \cup \\{m_{o}\\} \cup \\{m_{e}\\}$ is the set of all nodes in the network</br>
$K = \{1, \ldots, v\}$ is the set of vehicles</br>
$C \in \mathbb{N_+}$ is the maximum capacity of the vehicles</br>
$L \in \mathbb{R_{+}}$ is the maximum ride of the request</br>
$q_{i} \in \mathbb{N}$ is the demand of node $i \in V$</br>
$e_{i} \in \mathbb{R_{+}}$ is the earliest time to visit the node $i \in V$</br>
$l_{i} \in \mathbb{R_{+}}$ is the latest time to visit the node $i \in V$</br>
$s_{i} \in \mathbb{R_{+}}$ is the service time to visit the node $i \in V$</br>
$t_{ij} \in \mathbb{R_{+}}$ is the travel time to go from $i \in V$ to $j \in V$</br>
$c_{ij} \in \mathbb{R_{+}}$ is the travel cost to go from $i \in V$ to $j \in V$

<h4>Decision Variables</h4>

$x_{ij}^{k} \in \\{0, 1\\}$ assumes value $1$ if arc from $i$ to $j$ is used by vehicle $k$, $0$ otherwise</br>
$B_{i}^{k} \in \mathbb{R_{+}}$ is the visit time of node $i$ by vehicle $k$</br>
$Q_{i}^{k} \in \mathbb{R_{+}}$ is the accumulalted demand up to node $i$ on the vehicle $k$

<h4>Objective Function:</h4>

$$ \min  \sum_{k \in K} \sum_{i \in V} \sum_{j \in V} c_{ij}x^{k}_{ij} $$

<h4>s.t.:</h4>

$$ \sum_{k \in K} \sum_{j \in V} x_{ij}^{k} \\, = \\, 1 \\qquad i \\, \in \\,P $$

$$ \sum_{j \in V} x_{ij}^{k} \\, - \\,  \sum_{j \in V} x_{n+i,j}^{k} \\, = \\, 0 \\qquad i \\, \in \\,P, k \\, \in \\, K $$

$$ \sum_{j \in V} x_{m_o, j}^{k} \\, = \\, 1 \\qquad k \\, \in \\,K $$

$$ \sum_{j \in V} x_{i, m_e}^{k} \\, = \\, 1 \\qquad k \\, \in \\,K $$

$$ \sum_{j \in V} x_{ji}^{k} \\, - \\,  \sum_{j \in V} x_{ij}^{k} \\, = \\, 0 \\qquad i \\, \in \\,P \\, \cup \\, D, k \\, \in \\, K $$

$$B_{j}^{k} \geq (B_{i}^{k} + s_{i} + t_{ij}) - M(1 - x_{ij}^{k}) \\qquad i \\, \in \\, V, j \\, \in \\, V, \\, k \\, \in \\, K$$

$$e_i \leq B_{i}^{k} \leq l_i \\qquad i \\, \in \\, V, \\, k \\, \in \\, K$$

$$B_{i+n}^{k} \geq B_{i}^{k} \\qquad i \\, \in \\, P, \\, k \\, \in \\, K$$

$$B_{i+n}^{k} \\, - \\, (B_{i}^{k} \\, + \\, s_{i}) \leq L \\qquad i \\, \in \\, P, \\, k \\, \in \\, K$$

$$Q_{j}^{k} \geq (Q_{i}^{k} + q_{j}) - M'(1 - x_{ij}^{k}) \\qquad i \\, \in \\, V, j \\, \in \\, V, \\, k \\, \in \\, K$$

$$Q_{i}^{k} \leq C \\qquad i \\, \in \\, V, \\, k \\, \in \\, K$$

$$ x_{ij}^{k} \\, \in \\, \\{ 0, 1 \\} \\qquad i \\, \in \\, V, j \\, \in \\, V, \\, k \\, \in \\, K $$

$$ Q_{i}^{k} \\, \geq \\, 0 \\qquad i \\, \in \\, V, j \\, \in \\, V, \\, k \\, \in \\, K $$

$$ B_{i}^{k} \\, \geq \\, 0 \\qquad i \\, \in \\, V, j \\, \in \\, V, \\, k \\, \in \\, K $$