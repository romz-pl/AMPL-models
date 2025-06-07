set T ordered;           # Months
set O;           # All oils
set V within O;  # Vegetable oils
set N within O;  # Non-vegetable oils

param p {O, T};          # Purchase price (£/ton)
param h {O};             # Hardness
param c;                 # Final product selling price
param Rv;                # Max refining capacity for vegetable oils
param Rn;                # Max refining capacity for non-vegetable oils
param Smax;              # Max storage per oil
param Sinit;             # Initial and final storage per oil
param Hmin;              # Min hardness
param Hmax;              # Max hardness
param s_cost;            # Storage cost per ton per month
param BigM;              # Big-M for indicator constraints

var x {O, T} >= 0;        # Purchased tons of oil o in month t
var y {O, T} >= 0;        # Refined tons of oil o in month t
var s {O, T} >= 0, <= Smax; # Storage tons of oil o at end of month t
var z {O, T} binary;      # Indicator: 1 if oil o is used in month t

# Total production per month
var q {T} >= 0;

# Objective: Maximize profit
maximize Profit:
    sum {t in T} (
        c * q[t]
      - sum {o in O} (p[o,t] * x[o,t])
      - s_cost * sum {o in O} s[o,t]
    );

# Mass balance constraints
s.t. Balance {o in O, t in T}:
    s[o,t] = (if ord(t) = 1 then Sinit else s[o,prev(t)]) + x[o,t] - y[o,t];

# Refining capacity
s.t. VegLimit {t in T}:
    sum {o in V} y[o,t] <= Rv;

s.t. NonVegLimit {t in T}:
    sum {o in N} y[o,t] <= Rn;

# Define total product per month
s.t. ProductionTotal {t in T}:
    q[t] = sum {o in O} y[o,t];

# Hardness constraint
s.t. HardnessLower {t in T}:
    sum {o in O} h[o] * y[o,t] >= Hmin * q[t];

s.t. HardnessUpper {t in T}:
    sum {o in O} h[o] * y[o,t] <= Hmax * q[t];

# Usage constraints
s.t. MinUse {o in O, t in T}:
    y[o,t] >= 20 * z[o,t];

s.t. MaxUse {o in O, t in T}:
    y[o,t] <= BigM * z[o,t];

# At most 3 oils per month
s.t. MaxThreeOils {t in T}:
    sum {o in O} z[o,t] <= 3;

# Conditional constraint: if VEG1 or VEG2 is used, then OIL3 must be used
s.t. OilDependency {t in T}:
    z["VEG1",t] + z["VEG2",t] <= 1 + z["OIL3",t];

# Final storage condition
s.t. FinalStock {o in O}:
    s[o,last(T)] = Sinit;


