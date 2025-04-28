# Travel-Agent
## A* Algorithm
It is difficult to plan a travel from one city to another city when you are required to use more than
one flight, you have to select and arrange the departure and arrival time for every flight in order to
minimize the time between each flight and the next so that the total travel time is minimum. The
project aims to solve this problem by creating a useful tool to solve the flights search problem, using
A* search algorithms.
In other words, you are required to write a program that finds the best flights to reach one city from
another city. Given a start city, end city and travel day the system will determine the best way to go
from one city to another that minimizes the time. The result will be the travel plan that is a
complete list of flights that a user must use between a series of cities to get from a starting city
to a destination city.

## How Your Prolog Implementation Works
Your Prolog implementation involves the following main steps:

## 1. Define Flight Data (Timetable):
You provide flight schedules and availability in Prolog facts such as:

## 2. Heuristic Estimation (Distance Calculation):
You provide a heuristic estimation for each pair of cities, calculated as Euclidean distances based on predefined coordinates:

area(cairo, 50, 30).
area(dahab, 150, 90).

estimation(City1, City2, Estimate):- 
    area(City1, X1, Y1),
    area(City2, X2, Y2),
    DX is X1 - X2,
    DY is Y1 - Y2,
    Estimate is sqrt(DX*DX + DY*DY).
## 3. A Search Implementation:*
Your implementation selects the next flight based on both the actual duration traveled and the estimated remaining duration. It recursively searches until it finds the most optimal path.

Example of your A* predicate:

astar(Start, Goal, _, TotalCost, Path):- 
    estimation(Start, Goal, E),
    astar_recursive([(E, E, 0, [Start])], Goal, _, TotalCost, Path).

## 4. Generating a Complete Flight Plan:
Once the optimal path is found, the system outputs the flight plan with detailed flights, times, and sequence, enabling users to have a clear, actionable travel itinerary.

