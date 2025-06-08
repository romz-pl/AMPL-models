# Production Planning and Maintenance Scheduling Model

set PROD ordered;           # Products
set MONTHS ordered;         # Months
set MACHINES;               # Machine types

# Parameters
param c {PROD} >= 0;        # Contribution per product (£/unit)
param a {PROD, MONTHS} >= 0;# Monthly market demand
param t {PROD, MACHINES} >= 0 default 0; # Time required per product per machine (hours)
param H >= 0;               # Monthly available hours per machine
param M {MACHINES} >= 0;    # Number of machines per type
param h >= 0;               # Holding cost per unit per month
param S >= 0;               # Max stock per product
param s_final {PROD} >= 0;  # Final required stock per product

# Variables
var x {PROD, MONTHS} >= 0;  # Production units
var y {PROD, MONTHS} >= 0;  # Units sold
var s {PROD, MONTHS} >= 0;  # Inventory at end of month
var d {MACHINES, MONTHS} binary; # 1 if machine is down in month

# Objective: Maximize total profit (revenue - holding costs)
maximize Total_Profit:
    sum {i in PROD, m in MONTHS} (c[i] * y[i,m]) - sum {i in PROD, m in MONTHS} (h * s[i,m]);

# Demand constraints
subject to Demand_Limit {i in PROD, m in MONTHS}:
    y[i,m] <= a[i,m];

# Inventory balance constraints
subject to Initial_Stock {i in PROD}:
    s[i,first(MONTHS)] = x[i,first(MONTHS)] - y[i,first(MONTHS)];

subject to Inventory_Balance {i in PROD, m in MONTHS: m != first(MONTHS)}:
    s[i,m] = s[i,prev(m)] + x[i,m] - y[i,m];

subject to Final_Stock {i in PROD}:
    s[i,last(MONTHS)] = s_final[i];

subject to Max_Stock {i in PROD, m in MONTHS}:
    s[i,m] <= S;

# Machine time constraints
subject to Machine_Capacity {k in MACHINES, m in MONTHS}:
    sum {i in PROD} (t[i,k] * x[i,m]) <= H * (M[k] - d[k,m]);

# Maintenance scheduling
# For non-grinding machines, exactly one month down
subject to One_Maintenance {k in MACHINES: k != "Grinding"}:
    sum {m in MONTHS} d[k,m] = 1;

# For Grinding, exactly 2 of the 4 machines down over 6 months
subject to Grinding_Maintenance:
    sum {m in MONTHS} d["Grinding",m] = 2;
