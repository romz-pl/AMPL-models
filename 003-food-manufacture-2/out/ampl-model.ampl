# =============================
# AMPL Model: blending.mod
# =============================

set T ordered;              # Months
set V;                      # Vegetable oils
set N;                      # Non-vegetable oils
set O := V union N;         # All oils

param p {O, T} >= 0;        # Purchase price (£/ton)
param h {O} >= 0;           # Hardness
param s_cost >= 0;          # Storage cost per ton
param init_stock {O} >= 0;  # Initial stock
param final_stock {O} >= 0; # Required stock at end
param M >= 0;               # Large number for linking binary
param sell_price >= 0;      # Final product sale price

param refine_limit_v >= 0;  # Max veg oil refine per month
param refine_limit_n >= 0;  # Max non-veg oil refine per month

# Decision variables
var buy {O, T} >= 0;         # Purchase amount
var use {O, T} >= 0;         # Refined/used in production
var stock {O, T} >= 0;       # Inventory level
var y {O, T} binary;         # 1 if oil is used

# Objective: Maximize profit
maximize Profit:
    sum {t in T} (
        sell_price * sum {o in O} use[o,t]
      - sum {o in O} (p[o,t] * buy[o,t] + s_cost * stock[o,t])
    );

# Inventory balance
subject to Inventory_Balance {o in O, t in T: ord(t) = 1}:
    stock[o,t] = init_stock[o] + buy[o,t] - use[o,t];

subject to Inventory_Balance2 {o in O, t in T: ord(t) > 1}:
    stock[o,t] = stock[o,prev(t)] + buy[o,t] - use[o,t];

# Refining capacity constraints
subject to Veg_Refine_Limit {t in T}:
    sum {o in V} use[o,t] <= refine_limit_v;

subject to NonVeg_Refine_Limit {t in T}:
    sum {o in N} use[o,t] <= refine_limit_n;

# Hardness constraints
subject to Hardness_Min {t in T}:
    sum {o in O} h[o] * use[o,t] >= 3 * sum {o in O} use[o,t];

subject to Hardness_Max {t in T}:
    sum {o in O} h[o] * use[o,t] <= 6 * sum {o in O} use[o,t];

# Storage capacity
subject to Storage_Limit {o in O, t in T}:
    stock[o,t] <= 1000;

# Binary linking: use > 0 if y = 1
subject to Use_If_Binary {o in O, t in T}:
    use[o,t] <= M * y[o,t];

subject to Min_Use_If_Used {o in O, t in T}:
    use[o,t] >= 20 * y[o,t];

# At most 3 oils per month
subject to Max_Oils_Per_Month {t in T}:
    sum {o in O} y[o,t] <= 3;

# Conditional usage: if VEG1 or VEG2 used => OIL3 used
subject to OIL3_if_VEG1_Used {t in T}:
    y["OIL3",t] >= y["VEG1",t];

subject to OIL3_if_VEG2_Used {t in T}:
    y["OIL3",t] >= y["VEG2",t];

# Final stock requirement
subject to Final_Stock {o in O}:
    stock[o,last(T)] = final_stock[o];


