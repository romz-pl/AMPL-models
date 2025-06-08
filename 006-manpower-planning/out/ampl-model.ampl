# Sets
set T ordered;  # Years
set S;          # Skill levels: U, S, K

# Parameters
param R_required {T, S};     # Required manpower
param W_init {S};            # Initial workforce
param rec_max {S};           # Max recruitment per year
param alpha {S};             # Wastage rate for <1 year service
param beta {S};              # Wastage rate for >1 year service
param retrain_cost {S, S};   # Retraining cost
param retrain_limit_U_S;     # Max number retrain from U to S
param retrain_frac_S_K;      # Fraction limit of skilled workforce for retraining
param redundancy_cost {S};   # Redundancy payment per worker
param overmanning_cost {S};  # Overmanning cost per worker
param shorttime_cost {S};    # Short-time cost per worker
param shorttime_contrib;     # Short-time worker productivity
param shorttime_limit;       # Max short-time workers per category
param overmanning_limit;     # Total overmanning allowed

# Variables
var W {T, S} >= 0;                         # Workforce at end of year
var Rec {T, s in S} >= 0, <= rec_max[s];   # Recruitment
var Red {T, S} >= 0;                       # Redundancy
var ST {T, S} >= 0, <= shorttime_limit;    # Short-time working
var RT_U_S {T} >= 0, <= retrain_limit_U_S; # Retraining U → S
var RT_S_K {T} >= 0;                       # Retraining S → K

# Objective: Minimize total redundancy costs
minimize TotalRedundancy:
    sum {t in T, s in S} Red[t,s] * redundancy_cost[s];

# Workforce transition constraints
subject to Workforce_Unskilled {t in T: ord(t) > 1}:
    W[t,'U'] =
        (1 - beta['U']) * (W[prev(t),'U'] - RT_U_S[prev(t)] - Red[prev(t),'U']) +
        (1 - alpha['U']) * Rec[prev(t),'U'];

subject to Workforce_Semiskilled {t in T: ord(t) > 1}:
    W[t,'S'] =
        (1 - beta['S']) * (W[prev(t),'S'] - RT_S_K[prev(t)] - Red[prev(t),'S']) +
        (1 - alpha['S']) * Rec[prev(t),'S'] +
        RT_U_S[prev(t)];

subject to Workforce_Skilled {t in T: ord(t) > 1}:
    W[t,'K'] =
        (1 - beta['K']) * (W[prev(t),'K'] - Red[prev(t),'K']) +
        (1 - alpha['K']) * Rec[prev(t),'K'] +
        RT_S_K[prev(t)];

# Initial condition
subject to Initial_Workforce {s in S}:
    W[first(T), s] = W_init[s];

# Demand satisfaction (with short-time working)
subject to Demand_Constraint {t in T, s in S}:
    W[t,s] + shorttime_contrib * ST[t,s] - Red[t,s] >= R_required[t,s];

# Retraining limits
subject to Retrain_Limit_SK {t in T: ord(t) > 1}:
    RT_S_K[t] <= retrain_frac_S_K * W[prev(t),'K'];

# Overmanning constraint
subject to Overmanning_Constraint {t in T}:
    sum {s in S} (W[t,s] + shorttime_contrib * ST[t,s] - R_required[t,s]) <= overmanning_limit;
