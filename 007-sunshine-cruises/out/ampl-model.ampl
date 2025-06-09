set BOAT_TYPES;

param revenue {BOAT_TYPES};     # Revenue per boat per week
param maintenance {BOAT_TYPES};# Maintenance hours per boat per week
param max_total_boats;         # Max total boats allowed
param max_premier_boats;       # Max Premier boats
param max_maintenance;         # Max maintenance hours available

var Boats {BOAT_TYPES} >= 0, integer;

maximize Total_Revenue:
    sum {b in BOAT_TYPES} revenue[b] * Boats[b];

subject to Total_Boats_Limit:
    sum {b in BOAT_TYPES} Boats[b] <= max_total_boats;

subject to Premier_Limit:
    Boats["Premier"] <= max_premier_boats;

subject to Premier_Not_Less_Than_Standard:
    Boats["Premier"] >= Boats["Standard"];

subject to Maintenance_Limit:
    sum {b in BOAT_TYPES} maintenance[b] * Boats[b] <= max_maintenance;
