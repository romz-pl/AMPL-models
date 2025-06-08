# Sets
set PROD;           # Products: PROD1..PROD7
set MONTH ordered;  # Months: January..June
set MACHINES;       # Machine types

# Parameters
param profit {PROD} >= 0;                     # Profit per unit (£)
param usage {PROD, MACHINES} >= 0 default 0;  # Machine time per unit (hours)
param avail {MONTH, MACHINES} >= 0;           # Machine availability (hours/month)
param demand {MONTH, PROD} >= 0;              # Maximum sales allowed
param hold_cost >= 0;                         # Holding cost per unit per month
param max_store >= 0;                         # Max units that can be stored
param final_stock >= 0;                       # Required stock at end of last month

# Variables
var x {MONTH, PROD} >= 0;   # Production quantity
var y {MONTH, PROD} >= 0;   # Sales quantity
var s {MONTH, PROD} >= 0;   # Inventory at end of month

# Objective
maximize Total_Profit:
    sum {m in MONTH, p in PROD} (profit[p] * y[m,p] - hold_cost * s[m,p]);

# Machine time capacity
subject to MachineTimeLimit {m in MONTH, t in MACHINES}:
    sum {p in PROD} usage[p,t] * x[m,p] <= avail[m,t];

# Inventory balance
subject to InventoryBalance {m in MONTH, p in PROD}:
    (if ord(m) = 1 then 0 else s[prev(m),p]) + x[m,p] = y[m,p] + s[m,p];

# Demand limit
subject to DemandLimit {m in MONTH, p in PROD}:
    y[m,p] <= demand[m,p];

# Storage limit
subject to StorageLimit {m in MONTH, p in PROD}:
    s[m,p] <= max_store;

# Final inventory requirement
subject to FinalInventory {p in PROD}:
    s[last(MONTH),p] = final_stock;
