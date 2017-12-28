function Initial_Conditions(Species)

  Species[1,1] = 0.01	;	# 1 A_c
  Species[1,2] = 0.01	;	# 2 B_c
  Species[1,3] = 0.01	;	# 3 E
  Species[1,4] = 0.01	;	# 4 TA
  Species[1,5] = 0.01	;	# 5 TB
  Species[1,6] = 1.0	;	# 6 A_e
  Species[1,7] = 0.0	;	# 7 B_e

    return Species
end
