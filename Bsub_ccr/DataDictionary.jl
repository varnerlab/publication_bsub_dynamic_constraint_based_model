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
# Generated on: 2017-12-11T13:03:00.91
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
		0	100.0	;	# 1 M_glc_e --> M_g6p_c
		0	100.0	;	# 2 M_g6p_c --> []
		0	100.0	;	# 3 M_xylosides_e --> M_xylosides
		0	100.0	;	# 4 M_xylosides --> M_xylose
		0	100.0	;	# 5 M_xylose --> M_xylulose
		0	100.0	;	# 6 M_xylulose --> M_xylulose_5P
		0	100.0	;	# 7 M_xylulose_5P --> []
		0	100.0	;	# 8 [] --> M_Hpr_c
		0	100.0	;	# 9 M_Hpr_c --> M_HprSerP_c
		0	100.0	;	# 10 M_HprSerP_c --> []
		0	100.0	;	# 11 [] --> M_CcpA_c
		0	100.0	;	# 12 M_CcpA_c+M_HprSerP_c --> M_CcpAHpr_c
		0	100.0	;	# 13 M_CcpAHpr_c --> []
		0	100.0	;	# 14 XylR --> XylR_deactive
		0	100.0	;	# 15 XylR_deactive --> []
		0	100.0	;	# 16 [] --> eiiGlc
		0	100.0	;	# 17 [] --> XynP
		0	100.0	;	# 18 [] --> XynB
		0	100.0	;	# 19 [] --> XylR
		0	100.0	;	# 20 [] --> XylA
		0	100.0	;	# 21 [] --> XylB
		0	100.0	;	# 22 [] --> HprK
		0	100.0	;	# 23 eiiGlc --> []
		0	100.0	;	# 24 XylR --> []
		0	100.0	;	# 25 XylA --> []
		0	100.0	;	# 26 XylB --> []
		0	100.0	;	# 27 XynP --> []
		0	100.0	;	# 28 XynB --> []
		0	100.0	;	# 29 HprK --> []
	];

	# Setup default species bounds array -
	species_bounds_array = [
		0.0	0.0	;	# 1 HprK
		0.0	0.0	;	# 2 M_CcpAHpr_c
		0.0	0.0	;	# 3 M_CcpA_c
		0.0	0.0	;	# 4 M_HprSerP_c
		0.0	0.0	;	# 5 M_Hpr_c
		0.0	0.0	;	# 6 M_g6p_c
		0.0	0.0	;	# 7 M_xylose
		0.0	0.0	;	# 8 M_xylosides
		0.0	0.0	;	# 9 M_xylulose
		0.0	0.0	;	# 10 M_xylulose_5P
		0.0	0.0	;	# 11 XylA
		0.0	0.0	;	# 12 XylB
		0.0	0.0	;	# 13 XylR
		0.0	0.0	;	# 14 XylR_deactive
		0.0	0.0	;	# 15 XynB
		0.0	0.0	;	# 16 XynP
		0.0	0.0	;	# 17 eiiGlc
		-10.0	0.0	;	# 18 M_glc_e
		-10.0	0.0	;	# 19 M_xylosides_e
	];

	# Setup the objective coefficient array -
	objective_coefficient_array = [
		0.0	;	# 1 M_glc_uptake::M_glc_e --> M_g6p_c
		0.0	;	# 2 M_g6p_sink::M_g6p_c --> []
		0.0	;	# 3 M_xylosides_uptake::M_xylosides_e --> M_xylosides
		0.0	;	# 4 generation_of_xylose::M_xylosides --> M_xylose
		0.0	;	# 5 generation_of_xylulose::M_xylose --> M_xylulose
		0.0	;	# 6 generation_of_xylulose_5P::M_xylulose --> M_xylulose_5P
		0.0	;	# 7 transfer_of_xylulose_5P::M_xylulose_5P --> []
		0.0	;	# 8 generation_of_hpr::[] --> M_Hpr_c
		0.0	;	# 9 activation_of_hpr::M_Hpr_c --> M_HprSerP_c
		0.0	;	# 10 degrdation_HprSerP_active::M_HprSerP_c --> []
		0.0	;	# 11 generation_of_CcpA::[] --> M_CcpA_c
		0.0	;	# 12 activation_of_CcpA::M_CcpA_c+M_HprSerP_c --> M_CcpAHpr_c
		0.0	;	# 13 degrdation_CcpA_active::M_CcpAHpr_c --> []
		0.0	;	# 14 generation_of_XylR_deactive::XylR --> XylR_deactive
		0.0	;	# 15 degradation_XylR_deactive::XylR_deactive --> []
		0.0	;	# 16 M_eiiGlc_synthesis::[] --> eiiGlc
		0.0	;	# 17 M_xynP_synthesis::[] --> XynP
		0.0	;	# 18 M_xynB_synthesis::[] --> XynB
		0.0	;	# 19 M_xylR_synthesis::[] --> XylR
		0.0	;	# 20 M_xylA_synthesis::[] --> XylA
		0.0	;	# 21 M_xylB_synthesis::[] --> XylB
		0.0	;	# 22 M_HprK_synthesis::[] --> HprK
		0.0	;	# 23 degradation_eiiGlc::eiiGlc --> []
		0.0	;	# 24 degradation_XylR::XylR --> []
		0.0	;	# 25 degradation_XylA::XylA --> []
		0.0	;	# 26 degradation_XylB::XylB --> []
		0.0	;	# 27 degradation_XynP::XynP --> []
		0.0	;	# 28 degradation_XynB::XynB --> []
		0.0	;	# 29 degradation_HprK::HprK --> []
	];

	# Min/Max flag - default is minimum -
	is_minimum_flag = true

	# List of reation strings - used to write flux report
	list_of_reaction_strings = [
		"M_glc_uptake::M_glc_e --> M_g6p_c"
		"M_g6p_sink::M_g6p_c --> []"
		"M_xylosides_uptake::M_xylosides_e --> M_xylosides"
		"generation_of_xylose::M_xylosides --> M_xylose"
		"generation_of_xylulose::M_xylose --> M_xylulose"
		"generation_of_xylulose_5P::M_xylulose --> M_xylulose_5P"
		"transfer_of_xylulose_5P::M_xylulose_5P --> []"
		"generation_of_hpr::[] --> M_Hpr_c"
		"activation_of_hpr::M_Hpr_c --> M_HprSerP_c"
		"degrdation_HprSerP_active::M_HprSerP_c --> []"
		"generation_of_CcpA::[] --> M_CcpA_c"
		"activation_of_CcpA::M_CcpA_c+M_HprSerP_c --> M_CcpAHpr_c"
		"degrdation_CcpA_active::M_CcpAHpr_c --> []"
		"generation_of_XylR_deactive::XylR --> XylR_deactive"
		"degradation_XylR_deactive::XylR_deactive --> []"
		"M_eiiGlc_synthesis::[] --> eiiGlc"
		"M_xynP_synthesis::[] --> XynP"
		"M_xynB_synthesis::[] --> XynB"
		"M_xylR_synthesis::[] --> XylR"
		"M_xylA_synthesis::[] --> XylA"
		"M_xylB_synthesis::[] --> XylB"
		"M_HprK_synthesis::[] --> HprK"
		"degradation_eiiGlc::eiiGlc --> []"
		"degradation_XylR::XylR --> []"
		"degradation_XylA::XylA --> []"
		"degradation_XylB::XylB --> []"
		"degradation_XynP::XynP --> []"
		"degradation_XynB::XynB --> []"
		"degradation_HprK::HprK --> []"
	];

	# List of metabolite strings - used to write flux report
	list_of_metabolite_symbols = [
		"HprK"
		"M_CcpAHpr_c"
		"M_CcpA_c"
		"M_HprSerP_c"
		"M_Hpr_c"
		"M_g6p_c"
		"M_xylose"
		"M_xylosides"
		"M_xylulose"
		"M_xylulose_5P"
		"XylA"
		"XylB"
		"XylR"
		"XylR_deactive"
		"XynB"
		"XynP"
		"eiiGlc"
		"M_glc_e"
		"M_xylosides_e"
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
