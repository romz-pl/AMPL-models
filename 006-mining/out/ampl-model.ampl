set Mines ordered;          # Set of mines (1..4)
set Years ordered;          # Set of years (1..5)

param R {Mines};            # Royalty cost for each mine
param C {Mines};            # Capacity of each mine (in million tons)
param Q {Mines};            # Ore quality from each mine
param q {Years};            # Required quality in each year
param d {Years};            # Discount factor per year

param p;                    # Selling price per ton

# Decision variables
var x {Mines, Years} >= 0;          # Extraction amount (million tons)
var y {Mines, Years} binary;        # 1 if mine operated in year t
var z {Mines, Years} binary;        # 1 if mine is open in year t

# Objective: Maximize Net Present Value
maximize NPV:
  sum {t in Years} d[t] * (
    p * sum {i in Mines} x[i,t] - sum {i in Mines} R[i] * z[i,t]
  );

# Capacity constraints: no extraction beyond capacity
subject to Capacity_Limit {i in Mines, t in Years}:
  x[i,t] <= C[i] * y[i,t];

# If a mine is operated, it must be open
subject to Operate_Only_If_Open {i in Mines, t in Years}:
  y[i,t] <= z[i,t];

# No more than 3 mines operated per year
subject to Max_3_Mines_Per_Year {t in Years}:
  sum {i in Mines} y[i,t] <= 3;

# Quality constraint: weighted average must match required quality
subject to Quality_Constraint {t in Years}:
  sum {i in Mines} Q[i] * x[i,t] = q[t] * sum {i in Mines} x[i,t];

# Once closed, a mine stays closed
subject to Closure_Constraint {i in Mines, t in Years: ord(t) < card(Years)}:
  z[i,t+1] <= z[i,t];
