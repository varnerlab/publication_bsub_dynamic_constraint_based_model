include("Include.jl")
include("Bounds.jl")
include("Initial_Conditions.jl")

# load the data dictionary -
data_dictionary = DataDictionary(0,0,0)

number_of_fluxes = length(data_dictionary["default_flux_bounds_array"][:,1])
number_of_species = length(data_dictionary["species_bounds_array"][:,1])
data_dictionary["objective_coefficient_array"][7] = -1;
MIN_MAX_FLAG = -1;


tEND = 2500
dt = 300
time_index = 1
E_max = 1.0
Flux = zeros(tEND,number_of_fluxes)
Species = zeros(tEND,number_of_species)
Species = Initial_Conditions(Species)
Km = 0.13
kcat = 8.2
while time_index < tEND
  #Set Species Bounds
  data_dictionary["r1"] = 9*Species[time_index,17]/E_max*Species[time_index,18]/(0.0038+Species[time_index,18]) #r1 GLC -> G6P (eiiGlc)
  data_dictionary["r2"] = kcat*Species[time_index,6]  #r2 G6P -> []
  data_dictionary["r3"] = kcat*Species[time_index,16]/E_max*Species[time_index,19]/(Km+Species[time_index,19])  #r3 Xylosides_e -> Xylosides (XynP)
  data_dictionary["r4"] = kcat*Species[time_index,15]/E_max*Species[time_index,8]/(Km+Species[time_index,8]) #r4 Xylosides -> xylose (XynB)
  data_dictionary["r5"] = kcat*Species[time_index,11]/E_max*Species[time_index,7]/(Km+Species[time_index,7]) #r5 xylose -> Xylulose (XylA)
  data_dictionary["r6"] = kcat*Species[time_index,12]/E_max*Species[time_index,9]/(Km+Species[time_index,9]) #r6 M_xylulose --> M_xylulose_5P (XylB)
  data_dictionary["r7"] = kcat*Species[time_index,10] #r7  Xylulose5P -> []
  data_dictionary["r8"] = 0.5 #r8 [] -> Hpr
  data_dictionary["r9"] = 10*Species[time_index,1]/E_max * Species[time_index,5]/(0.13+Species[time_index,5]) * Species[time_index,6]/(0.13+Species[time_index,6]) #r9  Hpr -> HprSerP (HprK,G6P)
  data_dictionary["r10"] = 2*Species[time_index,4] #r10 HprSerP -> []
  data_dictionary["r11"] = 0.5 #r11 [] -> CcpA
  data_dictionary["r12"] = 10*Species[time_index,3]/(1+Species[time_index,3]) * Species[time_index,4]/(0.1+Species[time_index,4]) #r12 CcpA + HprSerP -> CcpAHpr
  data_dictionary["r13"] = 2*Species[time_index,2] #r13 CcpAHprP -> []
  data_dictionary["r14"] = 10*Species[time_index,13]/(0.001+Species[time_index,13])*Species[time_index,7]/(0.1+Species[time_index,7])*(1-Species[time_index,6]/(0.01+Species[time_index,6]))  #r14 XylR -> XylR_deactive
  data_dictionary["r15"] = 2*Species[time_index,14] #r15 XylR_deactive -> []
  data_dictionary["r16"] = 0.00 + 1*Species[time_index,18]/(0.01+Species[time_index,18])#r16 [] -> eiiGlc
  data_dictionary["XyloseMetabolismGenes"] = 1.25*(1-Species[time_index,13]/(0.01+Species[time_index,13]))*(1-Species[time_index,2]/(0.001+Species[time_index,2])) #[] -> XylGenes
  data_dictionary["r19"] = 0.5 #r19 [] -> XylR
  data_dictionary["r22"] = 0.5 #r22 [] -> HprK
  data_dictionary["r23"] = 2*Species[time_index,17] #r23 eiiGlc -> []
  data_dictionary["r24"] = 2*Species[time_index,13] #r24 XylR -> []
  data_dictionary["r25"] = 2*Species[time_index,11] #r25 XylA -> []
  data_dictionary["r26"] = 2*Species[time_index,12] #r26 XylB -> []
  data_dictionary["r27"] = 2*Species[time_index,16] #r27 XynP -> []
  data_dictionary["r28"] = 2*Species[time_index,15] #r28 XynB -> []
  data_dictionary["r29"] = 2*Species[time_index,1] #r29 HprK -> []


  data_dictionary = Bounds(data_dictionary);
  (objective_value, flux_array, dual_array, uptake_array, exit_flag) = FluxDriver(data_dictionary)
  #(FLOW, UPTAKE) = FluxDriver_MV(MIN_MAX_FLAG,data_dictionary)


  Species[time_index+1,:] = max(0,Species[time_index,:] + uptake_array./dt)

  time_index = time_index + 1
end

using PyPlot
t_vec = collect(0.0:1:tEND-1)./dt
figure(1)
plot(t_vec,Species[:,18],color="black")
plot(t_vec,Species[:,6],"k--")
plot(t_vec,Species[:,17],color="darkgrey")
axis([0,8,0,2])

figure(2)
plot(t_vec,Species[:,19],color="black")
plot(t_vec,Species[:,16],"k--")
plot(t_vec,Species[:,13],color="darkgrey")
plot(t_vec,Species[:,2],color="darkgrey","*")
axis([0,8,0,2])

figure(3)
plot(t_vec,Species[:,18],color="black")
plot(t_vec,Species[:,19],color="darkgrey")
axis([0,8,0,2]);
a = find(maximum(Species[:,6]).==Species[:,6])
println("Xyl Activity = ",Species[a,16], "0.00245 +/- 0.00105")
