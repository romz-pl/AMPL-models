# 1. Sets and Parameters
set T ordered;    # Months
set V;    # Vegetable oils
set N;    # Non-vegetable oils
set O := V union N;

param p {O, T};       # Purchase price per oil/month
param h {O};          # Hardness
param r;              # Selling price per ton
param s;              # Storage cost per ton per month
param Cv;             # Veg oil refining capacity
param Cn;             # Non-veg oil refining capacity
param Smax;           # Max storage per oil
param S0;             # Initial and final required stock
param hmin;           # Min hardness
param hmax;           # Max hardness


# 2. Variables
var x {O, T} >= 0;    # Purchased tons
var y {O, T} >= 0;    # Used in production
var z {O, T} >= 0;    # Stored at end of month



# 3. Objective Function
maximize Profit:
    sum {t in T} (
        r * sum {o in O} y[o,t]
        - sum {o in O} (p[o,t] * x[o,t] + s * z[o,t])
    );


# 4. Constraints
subject to Initial_Inventory {o in O}:
    S0 + x[o,first(T)] = y[o,first(T)] + z[o,first(T)];

subject to Inventory_Balance {o in O, t in T: t != first(T)}:
    z[o,prev(t)] + x[o,t] = y[o,t] + z[o,t];

subject to Storage_Limit {o in O, t in T}:
    z[o,t] <= Smax;

subject to Veg_Capacity {t in T}:
    sum {o in V} y[o,t] <= Cv;

subject to NonVeg_Capacity {t in T}:
    sum {o in N} y[o,t] <= Cn;
    
subject to Hardness_Min {t in T}:
    sum {o in O} h[o] * y[o,t] >= hmin * sum {o in O} y[o,t];

subject to Hardness_Max {t in T}:
    sum {o in O} h[o] * y[o,t] <= hmax * sum {o in O} y[o,t];

subject to Final_Inventory {o in O}:
    z[o,last(T)] = S0;


