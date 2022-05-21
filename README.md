# Julia Optimization Study

**It is a study guide for people who are interested in learning Mixed Integer Programming. The repository contains a set of classical optimization problems, and each problem has it is a mathematical formulation and implementation using Julia language with JuMP framework.**

Contents
1. [Assignment Problem](#assignment)
2. [Bin Packing Problem](#binpacking)
3. [Cutting Stock Problem](#cuttingstock)
4. [Facility Location Problem](#facilitylocation)
5. [Knapsack Problem](#knapsack)
6. [Set Partitioning Problem](#SP)
7. [Travelling Salesman Problem](#TSP)


<!-- ######### ASSIGNMENT ######### -->
<a name="assignment"></a>

## Assignment Problem 

<p>Given a set of tasks, a set of agents, and the costs of each agent to perform each task. The problem consists of assigning agents to tasks such that the total cost is minimized.<p>

<h3>Formulation</h3>


<h4>Data:</h4>

$n$ is the number of agents and tasks
$c_{ij}$ is the cost of agent $i$ perform task $j$

<h4>Decision Variables:</h4>

$x_{ij}$ if task $j$ is assigned to agent $i$

<h4>Objective Function:</h4>

$$ Min( \sum_{i=1}^{n}\sum_{j=1}^{n} c_{ij}x_{ij} ) $$

<h4>s.t.:</h4>

$$ \sum_{i=1}^{n} x_{ij} = 1 \qquad i \: \in \: n $$

$$ \sum_{i=1}^{n} x_{ij} = 1 \qquad j \: \in \: n $$

$$ x_{ij} \, \in \, \{0, 1\} $$

<!-- ######### BIN PACKING PROBLEM ######### -->
<a name="binpacking"></a>

## Bin Packing Problem

<p>The problem is packing a set of items into a minimum number of bins such that the total weight does not exceed the bin's capacities.<p>

<h3>Formulation</h3>

<h4>Data:</h4>

<img src="imgs/binpacking/ConstantWeight.gif" /> 
<img src="imgs/binpacking/ConstantCapacity.gif" /> 

<h4>Decision Variables</h4>
<img src="imgs/binpacking/VariableY.gif" /> 
<img src="imgs/binpacking/VariableX.gif" /> 

<h4>Objective Function:</h4>
<img src="imgs/binpacking/BinPackingObj.gif" /> 

<h4>s.t.:</h4>
<img src="imgs/binpacking/BinPackingConst1.gif" /> 
<img src="imgs/binpacking/BinPackingConst2.gif" /> 
<img src="imgs/binpacking/BinPackingVariableX.gif" />
<img src="imgs/binpacking/BinPackingVariableY.gif" />

<!-- ######### CUTTING STOCK PROBLEM ######### -->
<a name="cuttingstock"></a>

## Cutting Stock Problem
<p>Given a length and number of original rods, and given a set of lengths and demands of new smaller rods. Determine the minimum number of original rods that must be cut to generate all demanded new rods.</p>

<h3>Formulation</h3>

<h4>Data:</h4>

<img src="imgs/cuttingstock/Constants.gif" /> 

<h4>Decision Variables</h4>

<img src="imgs/cuttingstock/Variables.gif" /> 

<h4>Objective Function:</h4>

<img src="imgs/cuttingstock/Objective.gif" /> 

<h4>s.t.:</h4>

<img src="imgs/cuttingstock/Constraints.gif" /> 

<!-- ######### FACILITY LOCATION PROBLEM ######### -->
<a name="facilitylocation"></a>

## Facility Location Problem
<p>Given a set of clients, a set of potential facilities sites, the costs of building each facility, and the costs of assign each client to each possible facility. The problem consists of deciding which places to build facilities to supply the client's demands such that total costs are minimized.</p>

<h3>Formulation</h3>

<h4>Data:</h4>

<img src="imgs/facilitylocation/Constants.gif" /> 

<h4>Decision Variables</h4>

<img src="imgs/facilitylocation/Variables.gif" /> 

<h4>Objective Function:</h4>

<img src="imgs/facilitylocation/Objective.gif" /> 

<h4>s.t.:</h4>

<img src="imgs/facilitylocation/Constraints.gif" /> 

<!-- ######### KNAPSACK PROBLEM ######### -->
<a name="knapsack"></a>

## Knapsack Problem

<p>Given a set of items with different values and weights, determine which items to include in a collection that total weight of items is less than or equal to a given limit, and the total value is higher as possible.</p>

<h3>Formulation</h3>

<h4>Data:</h4>

<img src="imgs/knapsack/ConstantValue.gif" /> 
<img src="imgs/knapsack/ConstantWeight.gif" /> 
<img src="imgs/knapsack/ConstantCapacity.gif" /> 

<h4>Decision Variables</h4>
<img src="imgs/knapsack/VariableX.gif" /> 

<h4>Objective Function:</h4>
<img src="imgs/knapsack/KnapsackObj.gif" /> 

<h4>s.t.:</h4>
<img src="imgs/knapsack/KnpasackConst.gif" /> 
<img src="imgs/knapsack/KnapsackVariable.gif" /> 

<!-- ######### SET PARTITIONING PROBLEM ######### -->
<a name="sp"></a>

## Set Partitioning Problem

<p>Given a collection of subsets derived from an original set, the problem is to find a partition of the initial set. In other words, the aim is to select a new set of subsets such that the intersection of every subset is empty, and the union of all subsets is equal to the original set.</p>

<h3>Formulation</h3>

<h4>Data:</h4>

<img src="imgs/sp/Constants.gif" /> 

<h4>Decision Variables</h4>
<img src="imgs/sp/Variables.gif" /> 

<h4>Objective Function:</h4>
<img src="imgs/sp/Objective.gif" /> 

<h4>s.t.:</h4>
<img src="imgs/sp/Constraints.gif" />

<!-- ######### TRAVELLING SALESMAN PROBLEM ######### -->
<a name="tsp"></a>

## Travelling Salesman Problem

<p>Given a set of cities and the distance between every pair of cities, the problem is to find the shortest possible route that visits every city exactly once and returns to the starting point.</p>

* Mixed Integer Programming - Subtour formulation

<h3>Formulation</h3>

<h4>Data:</h4>

<img src="imgs/tsp/Constants.gif" /> 

<h4>Decision Variables</h4>
<img src="imgs/tsp/Variables.gif" /> 

<h4>Objective Function:</h4>
<img src="imgs/tsp/Objective.gif" /> 

<h4>s.t.:</h4>
<img src="imgs/tsp/Constraints.gif" />

* Mixed Integer Programming - Flow Variable

<h3>Formulation</h3>

<h4>Data:</h4>

<img src="imgs/tsp/ConstantsF.gif" /> 

<h4>Decision Variables</h4>
<img src="imgs/tsp/VariablesF.gif" /> 

<h4>Objective Function:</h4>
<img src="imgs/tsp/Objective.gif" /> 

<h4>s.t.:</h4>
<img src="imgs/tsp/ConstraintsF.gif" />