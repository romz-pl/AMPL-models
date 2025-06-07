# Sets
set OILS;

# Parameters
param cost {OILS};         # Cost per ton
param hardness {OILS};     # Hardness
param max_veg;             # Max tons of vegetable oil refining
param max_nonveg;          # Max tons of non-vegetable oil refining
param price;               # Sale price per ton

# Subsets to define oil types
set VEG_OILS within OILS;
set NONVEG_OILS within OILS;

# Decision variables
var x {OILS} >= 0;         # Amount (tons) of each oil used

# Expressions
var total_blend = sum {i in OILS} x[i];
var total_cost = sum {i in OILS} cost[i] * x[i];
var total_hardness = sum {i in OILS} hardness[i] * x[i];
var total_revenue = price * total_blend;
var profit = total_revenue - total_cost;

# Objective
maximize NetProfit: profit;

# Constraints
subject to VegCapacity:
    sum {i in VEG_OILS} x[i] <= max_veg;

subject to NonVegCapacity:
    sum {i in NONVEG_OILS} x[i] <= max_nonveg;

subject to HardnessLower:
    total_hardness >= 3 * total_blend;

subject to HardnessUpper:
    total_hardness <= 6 * total_blend;

