# ----------------------------------------------------------------------------------- #
# Copyright (c) 2017 Varnerlab
# Robert Frederick Smith School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #
#
# ----------------------------------------------------------------------------------- #
# Function: DataDictionary
# Description: Holds simulation and model parameters as key => value pairs in a Julia Dict()
# Generated on: 2017-12-07T16:44:47.455
#
# Input arguments:
# time_start::Float64 => Simulation start time value (scalar)
# time_stop::Float64 => Simulation stop time value (scalar)
# time_step::Float64 => Simulation time step (scalar)
#
# Output arguments:
# data_dictionary::Dict{AbstractString,Any} => Dictionary holding model and simulation parameters as key => value pairs
# ----------------------------------------------------------------------------------- #
function DataDictionary(time_start,time_stop,time_step)

	# Load the stoichiometric network from disk -
	stoichiometric_matrix = readdlm("Network.dat");

	# Setup default flux bounds array -
	default_bounds_array = [
		0	100.0	;	# 1 A_e --> A_c
		0	100.0	;	# 2 B_c --> B_e
		0	100.0	;	# 3 A_c --> B_c
		0	100.0	;	# 4 [] --> TA
		0	100.0	;	# 5 TA --> []
		0	100.0	;	# 6 [] --> E
		0	100.0	;	# 7 E --> []
		0	100.0	;	# 8 [] --> TB
		0	100.0	;	# 9 TB --> []
	];

	# Setup default species bounds array -
	species_bounds_array = [
		-10.0	10.0	;	# 1 A_c
		-10.0	10.0	;	# 2 B_c
		-10.0	10.0	;	# 3 E
		-10.0	10.0	;	# 4 TA
		-10.0	10.0	;	# 5 TB
		-10.0	0.0	;	# 6 A_e
		0.0	10.0	;	# 7 B_e
	];

	# Setup the objective coefficient array -
	objective_coefficient_array = [
		0.0	;	# 1 T_A::A_e --> A_c
		0.0	;	# 2 T_B::B_c --> B_e
		0.0	;	# 3 r_A::A_c --> B_c
		0.0	;	# 4 TA_synthesis::[] --> TA
		0.0	;	# 5 TA_degradation::TA --> []
		0.0	;	# 6 E_synthesis::[] --> E
		0.0	;	# 7 E_degradation::E --> []
		0.0	;	# 8 TB_synthesis::[] --> TB
		0.0	;	# 9 TB_degradation::TB --> []
	];

	# Min/Max flag - default is minimum -
	is_minimum_flag = true

	# List of reation strings - used to write flux report
	list_of_reaction_strings = [
		"T_A::A_e --> A_c"
		"T_B::B_c --> B_e"
		"r_A::A_c --> B_c"
		"TA_synthesis::[] --> TA"
		"TA_degradation::TA --> []"
		"E_synthesis::[] --> E"
		"E_degradation::E --> []"
		"TB_synthesis::[] --> TB"
		"TB_degradation::TB --> []"
	];

	# List of metabolite strings - used to write flux report
	list_of_metabolite_symbols = [
		"A_c"
		"B_c"
		"E"
		"TA"
		"TB"
		"A_e"
		"B_e"
	];

	# =============================== DO NOT EDIT BELOW THIS LINE ============================== #
	data_dictionary = Dict{AbstractString,Any}()
	data_dictionary["stoichiometric_matrix"] = stoichiometric_matrix
	data_dictionary["objective_coefficient_array"] = objective_coefficient_array
	data_dictionary["default_flux_bounds_array"] = default_bounds_array;
	data_dictionary["species_bounds_array"] = species_bounds_array
	data_dictionary["list_of_reaction_strings"] = list_of_reaction_strings
	data_dictionary["list_of_metabolite_symbols"] = list_of_metabolite_symbols
	data_dictionary["is_minimum_flag"] = is_minimum_flag
	# =============================== DO NOT EDIT ABOVE THIS LINE ============================== #
	return data_dictionary
end
