include("Include.jl")
include("Bounds.jl")
include("Initial_Conditions.jl")

# load the data dictionary -
data_dictionary = DataDictionary(0,0,0)

number_of_fluxes = length(data_dictionary["default_flux_bounds_array"][:,1])
number_of_species = length(data_dictionary["species_bounds_array"][:,1])
data_dictionary["objective_coefficient_array"][2] = -1;
#data_dictionary["objective_coefficient_array"][4] = -1;
#data_dictionary["objective_coefficient_array"][6] = -1;
#data_dictionary["objective_coefficient_array"][8] = -1;

E_max = 1
Status = Float64[]
tEND = 300
dt = 60
time_index = 1
Flux = zeros(tEND,number_of_fluxes)
Species = zeros(tEND,number_of_species)
Species = Initial_Conditions(Species)
VmaxGlc = 10.0
while time_index < tEND
  #Set Species Bounds
  data_dictionary["r1"] = 10*Species[time_index,4]/E_max*Species[time_index,6]/(1+Species[time_index,6]) #r1 A_e -> A_c
  data_dictionary["r2"] = 10*Species[time_index,5]/E_max*Species[time_index,2]/(1+Species[time_index,2])  #r2 B_c -> B_e
  data_dictionary["r3"] = 10*Species[time_index,3]/E_max*Species[time_index,1]/(1+Species[time_index,1])  #r3 A -> B
  data_dictionary["r4"] = 0.01 + Species[time_index,1]/(0.1+Species[time_index,1])  # r4 [] -> TA
  data_dictionary["r5"] = 2*Species[time_index,4] #r5 TA -> []
  data_dictionary["r6"] = 0.01 + Species[time_index,1]/(0.1+Species[time_index,1])  #r6 [] -> E
  data_dictionary["r7"] = 2*Species[time_index,3] #r7 E -> []
  data_dictionary["r8"] = 0.01 + Species[time_index,2]/(0.1+Species[time_index,2]) #r6 [] -> TB
  data_dictionary["r9"] = 2*Species[time_index,5] #r8 TB -> []

  data_dictionary = Bounds(data_dictionary);
  (objective_value, flux_array, dual_array, uptake_array, exit_flag) = FluxDriver(data_dictionary)
  #(FLOW, UPTAKE) = FluxDriver_MV(MIN_MAX_FLAG,data_dictionary)

  Species[time_index+1,:] = max(0.0,Species[time_index,:] + uptake_array./dt)
  Flux[time_index+1,:] = flux_array
  push!(Status,exit_flag)
  time_index = time_index + 1
end

using PyPlot
t_vec = collect(0.0:1:tEND-1)./dt
figure(1)
plot(t_vec,Species[:,6],color="black")
plot(t_vec,Species[:,7],color="darkgrey")
plot(t_vec,Species[:,1],"k--")
plot(t_vec,Species[:,2],color="darkgrey","--")
axis([0, 5, 0, 1.2])

figure(2)
plot(t_vec,Species[:,3],color="black")
plot(t_vec,Species[:,4],color="darkgrey",">")
plot(t_vec,Species[:,5],color="red")
axis([0, 5, 0, 1])
