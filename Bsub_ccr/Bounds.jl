function Bounds(DF)

  FB = DF["default_flux_bounds_array"]
  #PTS Uptake
  FB[1,1] = DF["r1"]
  FB[2,1] = DF["r2"]
  FB[3,1] = DF["r3"]
  FB[4,1] = DF["r4"]
  FB[5,1] = DF["r5"]
  FB[6,1] = DF["r6"]
  FB[7,1:2] = DF["r7"]
  FB[8,1] = DF["r8"]
  FB[9,1] = DF["r9"]
  FB[10,1] = DF["r10"]
  FB[11,1] = DF["r11"]
  FB[12,1] = DF["r12"]
  FB[13,1] = DF["r13"]
  FB[14,1] = DF["r14"]
  FB[15,2] = DF["r15"]
  FB[16,1] = DF["r16"]
  FB[17,1] = DF["XyloseMetabolismGenes"]
  FB[18,1] = DF["XyloseMetabolismGenes"]
  FB[19,1] = DF["r19"]
  FB[20,1] = DF["XyloseMetabolismGenes"]
  FB[21,1] = DF["XyloseMetabolismGenes"]
  FB[22,1] = DF["r22"]
  FB[23,1] = DF["r23"]
  FB[24,1] = DF["r24"]
  FB[25,1] = DF["r25"]
  FB[26,1] = DF["r26"]
  FB[27,1] = DF["r27"]
  FB[28,1] = DF["r28"]
  FB[29,1] = DF["r29"]
  DF["default_flux_bounds_array"] = FB

  SBA = DF["species_bounds_array"]
  SBA[:,1] = -100.0
  SBA[1:17,2] = 10
  DF["species_bounds_array"] = SBA

  return DF
end
