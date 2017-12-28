using JuMP
using GLPKMathProgInterface

function FluxDriver_MV(MIN_MAX_FLAG,data_dictionary)

#MODEL CONSTRUCTION
myModel = Model(solver=GLPKSolverLP())

#INPUT DATA
stoichiometric_matrix = data_dictionary["stoichiometric_matrix"]
flux_bounds_array = data_dictionary["default_flux_bounds_array"]
SPECIES_BOUND = data_dictionary["species_bounds_array"]
f = data_dictionary["objective_coefficient_array"];


STM = stoichiometric_matrix;
(NM,NRATES) = size(STM);

# Formulate objective vector (default is to minimize fluxes)
OBJVECTOR = f;
# Get bounds from the DF -
vb = flux_bounds_array;
LB = vb[:,1];
UB = vb[:,2];

#VARIABLES @defVar(name of model object, variable name & bound, variable type)
#@defVar(myModel, LB[i] <= x[i=1:NRATES] <= UB[i])
@variable(myModel, LB[i] <= x[i=1:NRATES] <= UB[i])

#Setup constraints on b vector
SBA=SPECIES_BOUND;
if (~isempty(SBA))

	#Setup
  CM = [STM ; STM ; ];

  N=size(SBA,1);
  bV = zeros(N+N);
  # UPPER BOUND
  for species_index=1:N
    bV[species_index,1]=SBA[species_index,2];
    @addConstraint(myModel, sum{CM[species_index,j]*x[j] , j=1:NRATES} <= bV[species_index])
  end
  # LOWER BOUND
  for species_index=1:N
    bV[species_index+N,1]=SBA[species_index,1];
    @addConstraint(myModel, sum{CM[species_index+N,j]*x[j] , j=1:NRATES} >= bV[species_index+N])
  end
end

#OBJECTIVE (set objective to be min or max)
@setObjective(myModel, Min, sum{OBJVECTOR[j]*x[j], j=1:NRATES})

#print(myModel)
#@time begin
status = solve(myModel) #Solves the model
#end

#println("Objective value: ", getObjectiveValue(myModel))
FLOW = getValue(x);
FLOW[find(FLOW.<=0.00001)] = 0.0
UPTAKE = STM*FLOW;
UPTAKE[find(-0.0001.<=UPTAKE.<=0.00001)] = 0.0

return FLOW, UPTAKE
end
