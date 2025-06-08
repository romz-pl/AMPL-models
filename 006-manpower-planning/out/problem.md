To model this workforce optimization problem mathematically, we'll define variables, constraints, and an objective function that represent the company's workforce management over three years, with the goal of **minimizing redundancy**.

---

## 🧮 **Mathematical Model**

### 1. **Index Sets**

Let:

* $t \in \{1, 2, 3\}$ be the year (time index).
* $s \in \{U, S, K\}$ be the skill category:
  $U$ = Unskilled, $S$ = Semi-skilled, $K$ = Skilled.

---

### 2. **Parameters**

#### Initial workforce:

* $W_{0,U} = 2000$, $W_{0,S} = 1500$, $W_{0,K} = 1000$

#### Required workforce by year:

* $R_{1,U} = 1000$, $R_{1,S} = 1400$, $R_{1,K} = 1000$
* $R_{2,U} = 500$, $R_{2,S} = 2000$, $R_{2,K} = 1500$
* $R_{3,U} = 0$, $R_{3,S} = 2500$, $R_{3,K} = 2000$

#### Recruitment limits:

* $R^{\max}_U = 500$, $R^{\max}_S = 800$, $R^{\max}_K = 500$

#### Natural wastage rates:

* Less than 1 year: $\alpha_U = 0.25$, $\alpha_S = 0.20$, $\alpha_K = 0.10$
* More than 1 year: $\beta_U = 0.10$, $\beta_S = 0.05$, $\beta_K = 0.05$

#### Retraining limits:

* Up to 200 unskilled to semi-skilled per year.
* Semi-skilled to skilled: up to 25% of current skilled workforce.

#### Costs:

* **Retraining:**
  Unskilled → Semi-skilled: £400
  Semi-skilled → Skilled: £500

* **Redundancy payments:**
  Unskilled: £200
  Semi-skilled/Skilled: £500

* **Overmanning cost per worker per year:**
  U: £1500, S: £2000, K: £3000 (only up to 150 total overmanned workers per year)

* **Short-time working cost per worker per year:**
  U: £500, S: £400, K: £400 (up to 50 per skill category)

---

### 3. **Decision Variables**

Let the following be the decision variables for each year $t$:

#### Workforce states

* $W_{t,s}$: Number of workers in skill group $s$ at end of year $t$

#### Recruitment

* $\text{Rec}_{t,s}$: Number of new recruits in skill group $s$

#### Retraining

* $\text{RT}_{t,U \rightarrow S}$: Unskilled retrained to semi-skilled
* $\text{RT}_{t,S \rightarrow K}$: Semi-skilled retrained to skilled

#### Redundancy

* $\text{Red}_{t,s}$: Redundancies in skill group $s$

#### Short-time working

* $\text{ST}_{t,s}$: Workers on short-time in group $s$

#### Overmanning

* $OM_t$: Total number of workers employed above required number in year $t$

---

### 4. **Objective Function**

Minimize total redundancy:

$$
\min \sum_{t=1}^{3} \left[ 200 \cdot \text{Red}_{t,U} + 500 \cdot (\text{Red}_{t,S} + \text{Red}_{t,K}) \right]
$$

---

### 5. **Constraints**

#### 5.1. Workforce Transition Equations

For $t = 1, 2, 3$, each skill category $s$:

Let $\gamma_s = \alpha_s$ for new recruits, and $\delta_s = \beta_s$ for old employees.

* For unskilled:

$$
W_{t,U} = (1 - \delta_U)(W_{t-1,U} - \text{RT}_{t,U \rightarrow S} - \text{Red}_{t,U}) + (1 - \alpha_U) \cdot \text{Rec}_{t,U}
$$

* For semi-skilled:

$$
W_{t,S} = (1 - \delta_S)(W_{t-1,S} - \text{RT}_{t,S \rightarrow K} - \text{Red}_{t,S}) + (1 - \alpha_S) \cdot \text{Rec}_{t,S} + \text{RT}_{t,U \rightarrow S}
$$

* For skilled:

$$
W_{t,K} = (1 - \delta_K)(W_{t-1,K} - \text{Red}_{t,K}) + (1 - \alpha_K) \cdot \text{Rec}_{t,K} + \text{RT}_{t,S \rightarrow K}
$$

#### 5.2. Demand Satisfaction Constraint

Short-time workers contribute 0.5:

$$
W_{t,s} + 0.5 \cdot \text{ST}_{t,s} - \text{Red}_{t,s} \ge R_{t,s}, \quad \forall t, s
$$

#### 5.3. Recruitment Constraints

$$
\text{Rec}_{t,s} \le R^{\max}_s
$$

#### 5.4. Retraining Constraints

$$
\text{RT}_{t,U \rightarrow S} \le 200
$$

$$
\text{RT}_{t,S \rightarrow K} \le 0.25 \cdot W_{t-1,K}
$$

#### 5.5. Short-Time Constraints

$$
\text{ST}_{t,s} \le 50
$$

#### 5.6. Overmanning Constraint

$$
\sum_{s} (W_{t,s} + 0.5 \cdot \text{ST}_{t,s} - R_{t,s}) \le 150
$$

#### 5.7. Non-Negativity and Integer Constraints

$$
\text{All variables} \ge 0, \quad \text{and integer where appropriate}
$$

---

## ✳️ Remarks:

* This is a **mixed-integer linear programming (MILP)** problem.
* You could extend the model to include **cost minimization** more broadly (e.g., overmanning costs, retraining costs, short-time costs) by adding terms to the objective.
* If redundancy is the *only* priority, current formulation is optimal.

Would you like the model implemented in code (e.g., using Python and PuLP or Pyomo), or would you prefer a broader cost minimization model instead of redundancy-focused?
