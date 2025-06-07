# ---------- Sets ----------
set PRODUCTS;

# ---------- Parameters ----------
param profit {PRODUCTS};             # Profit per unit
param grinding_time {PRODUCTS} >= 0; # Grinding hours per unit
param drilling_time {PRODUCTS} >= 0; # Drilling hours per unit
param assembly_time {PRODUCTS} >= 0; # Assembly hours per unit (given as 20 for all)

param grinding_capacity;             # Total grinding machine hours
param drilling_capacity;             # Total drilling machine hours
param assembly_capacity;             # Total assembly worker hours

# ---------- Decision Variables ----------
var x {p in PRODUCTS} >= 0;          # Units of product p to be produced

# ---------- Objective Function ----------
maximize Total_Profit:
    sum {p in PRODUCTS} profit[p] * x[p];

# ---------- Constraints ----------
subject to Grinding_Constraint:
    sum {p in PRODUCTS} grinding_time[p] * x[p] <= grinding_capacity;

subject to Drilling_Constraint:
    sum {p in PRODUCTS} drilling_time[p] * x[p] <= drilling_capacity;

subject to Assembly_Constraint:
    sum {p in PRODUCTS} assembly_time[p] * x[p] <= assembly_capacity;

