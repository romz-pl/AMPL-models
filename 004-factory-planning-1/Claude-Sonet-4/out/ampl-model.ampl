# Factory Production Planning Model
# File: factory.mod

# Sets
set PRODUCTS;
set MONTHS ordered;
set MACHINES;

# Parameters
param profit{PRODUCTS};
param demand{PRODUCTS, MONTHS};
param process_time{PRODUCTS, MACHINES};
param machine_capacity{MACHINES};
param machines_available{MACHINES, MONTHS};
param storage_cost;
param max_storage;
param final_inventory;
param working_hours_per_month;

# Decision Variables
var production{PRODUCTS, MONTHS} >= 0;
var inventory{PRODUCTS, MONTHS} >= 0;
var sales{PRODUCTS, MONTHS} >= 0;

# Objective Function
maximize Total_Profit:
    sum{p in PRODUCTS, m in MONTHS} profit[p] * sales[p,m] - 
    sum{p in PRODUCTS, m in MONTHS} storage_cost * inventory[p,m];

# Machine Capacity Constraints
subject to Machine_Capacity{mc in MACHINES, m in MONTHS}:
    sum{p in PRODUCTS} process_time[p,mc] * production[p,m] <= 
    machines_available[mc,m] * machine_capacity[mc] * working_hours_per_month;

# Marketing Demand Constraints
subject to Marketing_Limit{p in PRODUCTS, m in MONTHS}:
    sales[p,m] <= demand[p,m];

# Inventory Balance Constraints
subject to Inventory_Balance{p in PRODUCTS, m in MONTHS}:
    inventory[p,m] = (if m = first(MONTHS) then 0 else inventory[p,prev(m)]) + 
                     production[p,m] - sales[p,m];

# Storage Capacity Constraints
subject to Storage_Limit{p in PRODUCTS, m in MONTHS}:
    inventory[p,m] <= max_storage;

# Final Inventory Requirements
subject to Final_Stock{p in PRODUCTS}:
    inventory[p,last(MONTHS)] = final_inventory;

# Sales cannot exceed available stock
subject to Sales_Availability{p in PRODUCTS, m in MONTHS}:
    sales[p,m] <= (if m = first(MONTHS) then 0 else inventory[p,prev(m)]) + production[p,m];
