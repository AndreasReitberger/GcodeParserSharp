; HEADER_BLOCK_START
; BambuStudio 01.06.02.04
; model printing time: 15m 17s; total estimated time: 21m 5s
; total layer number: 100
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; additional_cooling_fan_speed = 70
; auxiliary_fan = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 0x0,18x0,18x28,0x28
; bed_temperature_difference = 10
; before_layer_change_gcode = 
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; change_filament_gcode = M620 S[next_extruder]A\nM204 S9000\n{if toolchange_count > 1 && (z_hop_types[current_extruder] == 0 || z_hop_types[current_extruder] == 3)}\nG17\nG2 Z{z_after_toolchange + 0.4} I0.86 J0.86 P1 F10000 ; spiral lift a little from second lift\n{endif}\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}M104 S[old_filament_temp]{endif}\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\n\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F[old_filament_e_feedrate] T{nozzle_temperature_range_high[previous_extruder]}\nT[next_extruder]\nM620.1 E F[new_filament_e_feedrate] T{nozzle_temperature_range_high[next_extruder]}\n\n{if next_extruder < 255}\nM400\n\nG92 E0\n{if flush_length_1 > 1}\n; FLUSH_START\n; always use highest temperature to flush\nM400\nM109 S[nozzle_temperature_range_high]\n{if flush_length_1 > 23.7}\nG1 E23.7 F{old_filament_e_feedrate} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\n{else}\nG1 E{flush_length_1} F{old_filament_e_feedrate}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\nG1 X80 F15000\nG1 X60 F15000\nG1 X80 F15000\nG1 X60 F15000; shake to put down garbage\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A
; close_fan_the_first_x_layers = 1
; cool_plate_temp = 35
; cool_plate_temp_initial_layer = 35
; curr_bed_type = Cool Plate
; default_acceleration = 10000
; default_filament_colour = ""
; default_filament_profile = "Bambu PLA Basic @BBL X1"
; default_print_profile = 0.20mm Standard @BBL P1P
; deretraction_speed = 30
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; draft_shield = disabled
; elefant_foot_compensation = 0.15
; enable_arc_fitting = 1
; enable_overhang_bridge_fan = 1
; enable_overhang_speed = 1
; enable_prime_tower = 0
; enable_support = 0
; enforce_support_layers = 0
; eng_plate_temp = 0
; eng_plate_temp_initial_layer = 0
; ensure_vertical_shell_thickness = 1
; extruder_clearance_height_to_lid = 90
; extruder_clearance_height_to_rod = 36
; extruder_clearance_max_radius = 56
; extruder_clearance_radius = 57
; extruder_colour = #018001
; extruder_offset = 0x2
; fan_cooling_layer_time = 80
; fan_max_speed = 100
; fan_min_speed = 50
; filament_colour = #00AE42
; filament_cost = 24.99
; filament_density = 1.26
; filament_diameter = 1.75
; filament_end_gcode = "; filament end gcode \nM106 P3 S0\n"
; filament_flow_ratio = 0.98
; filament_ids = GFA00
; filament_is_support = 0
; filament_max_volumetric_speed = 21
; filament_minimal_purge_on_wipe_tower = 15
; filament_settings_id = "Bambu PLA Basic @BBL P1P"
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n{if  (bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S255\n{elsif(bed_temperature[current_extruder] >35)||(bed_temperature_initial_layer[current_extruder] >35)}M106 P3 S180\n{endif}"
; filament_type = PLA
; filament_vendor = "Bambu Lab"
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_volumes_matrix = 0
; flush_volumes_vector = 140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; host_type = octoprint
; hot_plate_temp = 65
; hot_plate_temp_initial_layer = 65
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_wall_overlap = 15%
; initial_layer_acceleration = 500
; initial_layer_infill_speed = 105
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; inner_wall_line_width = 0.45
; inner_wall_speed = 300
; interface_shells = 0
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_speed = 250
; ironing_flow = 10%
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 E-[retraction_length] F1800\nG17\nG2 Z{layer_z + 0.4} I0.86 J0.86 P1 F20000 ; spiral lift a little\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400 P300\nM971 S11 C11 O0\nG92 E0\nG1 E[retraction_length] F300\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.2
; line_width = 0.42
; machine_end_gcode = ;===== date: 20230118 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos \nG1 Y265 F3000\nM991 S0 P-1 ;end smooth timelapse at safe pos\nM400 S2 ;wait for last picture to be taken\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nG90\nG1 X128 Y250 F3600\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\n\n
; machine_load_filament_time = 29
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,200
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,200
; machine_max_speed_y = 500,200
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = M400 U1
; machine_start_gcode = ;===== machine: P1P ========================\n;===== date: 20230425 =====================\n;===== turn on the HB fan =================\nM104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle\n;===== reset machine status =================\nG91\nM17 Z0.4 ; lower the z-motor current\nG0 Z12 F300 ; lower the hotbed , to prevent the nozzle is below the hotbed\nG0 Z-6;\nG90\nM17 X1.2 Y1.2 Z0.75 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 5\nM221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem\nG29.1 Z{+0.0} ; clear z-trim value first\n\n;===== heatbed preheat ====================\nM1002 gcode_claim_action : 2\nM140 S[bed_temperature_initial_layer_single] ;set bed temp\nM190 S[bed_temperature_initial_layer_single] ;wait for bed temp\n\n\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_extruder]=="PLA"}\n    {if (bed_temperature[initial_extruder] >45)||(bed_temperature_initial_layer[initial_extruder] >45)}\n    M106 P3 S180\n    {elsif (bed_temperature[initial_extruder] >50)||(bed_temperature_initial_layer[initial_extruder] >50)}\n    M106 P3 S255\n    {endif};Prevent PLA from jamming\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n;===== prepare print temperature and material ==========\nM104 S[nozzle_temperature_initial_layer] ;set extruder temp\nG91\nG0 Z10 F1200\nG90\nG28 X\nM975 S1 ; turn on\nG1 X60 F12000\nG1 Y245\nG1 Y265 F3000\nM620 M\nM620 S[initial_extruder]A   ; switch material if AMS exist\n    M109 S[nozzle_temperature_initial_layer]\n    G1 X120 F12000\n\n    G1 X20 Y50 F12000\n    G1 Y-3\n    T[initial_extruder]\n    G1 X54 F12000\n    G1 Y265\n    M400\nM621 S[initial_extruder]A\nM620.1 E F{filament_max_volumetric_speed[initial_extruder]/2.4053*60} T{nozzle_temperature_range_high[initial_extruder]}\n\n\nM412 S1 ; ===turn on filament runout detection===\n\nM109 S250 ;set nozzle to common flush temp\nM106 P1 S0\nG92 E0\nG1 E50 F200\nM400\nM104 S[nozzle_temperature_initial_layer]\nG92 E0\nG1 E50 F200\nM400\nM106 P1 S255\nG92 E0\nG1 E5 F300\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-20} ; drop nozzle temp, make filament shink a bit\nG92 E0\nG1 E-0.5 F300\n\nG1 X70 F9000\nG1 X76 F15000\nG1 X65 F15000\nG1 X76 F15000\nG1 X65 F15000; shake to put down garbage\nG1 X80 F6000\nG1 X95 F15000\nG1 X80 F15000\nG1 X165 F15000; wipe and shake\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\nM106 S255\nG1 X65 Y230 F18000\nG1 Y264 F6000\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-20}\nG1 X100 F18000 ; first wipe mouth\n\nG0 X135 Y253 F20000  ; move to exposed steel surface edge\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nG0 Z5 F20000\n\nG1 X60 Y265\nG92 E0\nG1 E-0.5 F300 ; retrack more\nG1 X100 F5000; second wipe mouth\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X90 F5000\nG0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle\nM104 S140 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\n\nM221 S; push soft endstop status\nM221 Z0 ;turn off Z axis endstop\nG0 Z0.5 F20000\nG0 X125 Y259.5 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 X128\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\n\nM109 S140 ; wait nozzle temp down to heatbed acceptable\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\n\nM221 R; pop softend status\nG1 Z10 F1200\nM400\nG1 Z10\nG1 F30000\nG1 X230 Y15\nG29.2 S1 ; turn on ABL\n;G28 ; home again after hard wipe mouth\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n\n;===== bed leveling ==================================\nM1002 judge_flag g29_before_print_flag\nM622 J1\n\n    M1002 gcode_claim_action : 1\n    G29 A X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\n\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28\n\nM623\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_extruder]=="PLA"}\n    {if (bed_temperature[initial_extruder] >45)||(bed_temperature_initial_layer[initial_extruder] >45)}\n    M106 P3 S180\n    {elsif (bed_temperature[initial_extruder] >50)||(bed_temperature_initial_layer[initial_extruder] >50)}\n    M106 P3 S255\n    {endif};Prevent PLA from jamming\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n\nM104 S{nozzle_temperature_initial_layer[initial_extruder]} ; set extrude temp earlier, to reduce wait time\n\n;===== mech mode fast check============================\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q1 A7 B30 C80  H15 K0\nM974 Q1 S2 P0\n\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q0 A7 B30 C90 Q0 H15 K0\nM974 Q0 S2 P0\n\nM975 S1\nG1 F30000\nG1 X230 Y15\nG28 X ; re-home XY\n;===== fmech mode fast check============================\n\n\n;===== noozle load line ===============================\nM975 S1\nG90\nM83\nT1000\nG1 X18.0 Y1.0 Z0.8 F18000;Move to start position\nM109 S{nozzle_temperature_initial_layer[initial_extruder]}\nG1 Z0.2\nG0 E2 F300\nG0 X240 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 Y11 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\nG0 X239.5\nG0 E0.2\nG0 Y1.5 E0.700\nG0 X18 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM400\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type=="Textured PEI Plate"}\nG29.1 Z{-0.04} ; for Textured PEI Plate\n{endif}\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression
; machine_unload_filament_time = 28
; max_bridge_length = 10
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; nozzle_diameter = 0.4
; nozzle_hrc = 20
; nozzle_temperature = 220
; nozzle_temperature_initial_layer = 220
; nozzle_temperature_range_high = 240
; nozzle_temperature_range_low = 190
; nozzle_type = stainless_steel
; nozzle_volume = 107
; only_one_wall_top = 1
; ooze_prevention = 0
; outer_wall_acceleration = 5000
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 100
; overhang_fan_threshold = 50%
; post_process = 
; prime_tower_brim_width = 3
; prime_tower_width = 35
; prime_volume = 45
; print_compatible_printers = "Bambu Lab P1P 0.4 nozzle"
; print_host = 
; print_sequence = by layer
; print_settings_id = 0.20mm Standard @BBL P1P
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; printer_model = Bambu Lab P1P
; printer_settings_id = Bambu Lab P1P 0.4 nozzle
; printer_technology = FFF
; printer_variant = 0.4
; printhost_apikey = 
; printhost_authorization_type = key
; printhost_cafile = 
; printhost_password = 
; printhost_port = 
; printhost_ssl_ignore_revoke = 0
; printhost_user = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = 2
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction = 1
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; scan_first_layer = 0
; seam_position = aligned
; silent_mode = 0
; single_extruder_multi_material = 1
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 8
; slow_down_min_speed = 20
; solid_infill_filament = 1
; sparse_infill_density = 15%
; sparse_infill_filament = 1
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = grid
; sparse_infill_speed = 270
; spiral_mode = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_critical_regions_only = 0
; support_expansion = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_line_width = 0.42
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_speed = 150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = normal(auto)
; temperature_vitrification = 55
; template_custom_gcode = 
; textured_plate_temp = 65
; textured_plate_temp_initial_layer = 65
; thick_bridges = 0
; timelapse_type = 0
; top_shell_layers = 3
; top_shell_thickness = 0.6
; top_surface_acceleration = 2000
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; travel_speed = 500
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_distance = 5
; tree_support_wall_count = 1
; upward_compatible_machine = "Bambu Lab X1 0.4 nozzle";"Bambu Lab X1 Carbon 0.4 nozzle"
; wall_distribution_count = 1
; wall_filament = 1
; wall_generator = classic
; wall_infill_order = inner wall/outer wall/infill
; wall_loops = 2
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 155
; wipe_tower_y = 220
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_hop = 0.4
; z_hop_types = Spiral Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R21
M201 X20000 Y20000 Z500 E5000
M203 X500 Y500 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: P1P ========================
;===== date: 20230425 =====================
;===== turn on the HB fan =================
M104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle
;===== reset machine status =================
G91
M17 Z0.4 ; lower the z-motor current
G0 Z12 F300 ; lower the hotbed , to prevent the nozzle is below the hotbed
G0 Z-6;
G90
M17 X1.2 Y1.2 Z0.75 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 5
M221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem
G29.1 Z0 ; clear z-trim value first

;===== heatbed preheat ====================
M1002 gcode_claim_action : 2
M140 S35 ;set bed temp
M190 S35 ;wait for bed temp



;=============turn on fans to prevent PLA jamming=================

    ;Prevent PLA from jamming

M106 P2 S100 ; turn on big fan ,to cool down toolhead

;===== prepare print temperature and material ==========
M104 S220 ;set extruder temp
G91
G0 Z10 F1200
G90
G28 X
M975 S1 ; turn on
G1 X60 F12000
M73 P20 R16
G1 Y245
G1 Y265 F3000
M620 M
M620 S0A   ; switch material if AMS exist
    M109 S220
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T0
    G1 X54 F12000
M73 P21 R16
    G1 Y265
    M400
M621 S0A
M620.1 E F523.843 T240


M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
G1 E50 F200
M400
M104 S220
G92 E0
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
G1 E-0.5 F300

G1 X70 F9000
M73 P22 R16
G1 X76 F15000
M73 P23 R16
G1 X65 F15000
G1 X76 F15000
G1 X65 F15000; shake to put down garbage
G1 X80 F6000
G1 X95 F15000
G1 X80 F15000
G1 X165 F15000; wipe and shake
M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1
M106 S255
G1 X65 Y230 F18000
G1 Y264 F6000
M109 S200
G1 X100 F18000 ; first wipe mouth

G0 X135 Y253 F20000  ; move to exposed steel surface edge
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
G0 Z5 F20000

G1 X60 Y265
G92 E0
G1 E-0.5 F300 ; retrack more
G1 X100 F5000; second wipe mouth
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
M73 P24 R16
G1 X70 F15000
G1 X90 F5000
G0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle
M104 S140 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)

M221 S; push soft endstop status
M221 Z0 ;turn off Z axis endstop
G0 Z0.5 F20000
G0 X125 Y259.5 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 X128
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300

M109 S140 ; wait nozzle temp down to heatbed acceptable
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000

M221 R; pop softend status
M73 P24 R15
G1 Z10 F1200
M400
G1 Z10
G1 F30000
G1 X230 Y15
G29.2 S1 ; turn on ABL
;G28 ; home again after hard wipe mouth
M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================


;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag
M622 J1

    M1002 gcode_claim_action : 1
    G29 A X120 Y120 I20 J20
    M400
    M500 ; save cali data

M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28

M623
;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression


;=============turn on fans to prevent PLA jamming=================

    ;Prevent PLA from jamming

M106 P2 S100 ; turn on big fan ,to cool down toolhead


M104 S220 ; set extrude temp earlier, to reduce wait time

;===== mech mode fast check============================
G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q1 A7 B30 C80  H15 K0
M974 Q1 S2 P0

G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q0 A7 B30 C90 Q0 H15 K0
M974 Q0 S2 P0

M975 S1
G1 F30000
G1 X230 Y15
G28 X ; re-home XY
;===== fmech mode fast check============================


;===== noozle load line ===============================
M975 S1
G90
M83
T1000
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S220
G1 Z0.2
G0 E2 F300
G0 X240 E15 F6033.27
G0 Y11 E0.700 F1508.32
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X18 E15 F6033.27
M400

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Cool Plate

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
G90
G21
M83 ; only support relative e
; filament start gcode
M981 S1 P20000 ;open spaghetti detector
M106 S0
M106 P2 S0
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M204 S500
G1 X139.143 Y137.143 F30000
G1 Z.4
G1 Z.2
M73 P25 R15
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
G1 X120.857 Y137.143 E.68108
G1 X120.857 Y118.857 E.68108
G1 X139.143 Y118.857 E.68108
G1 X139.143 Y137.083 E.67884
G1 X139.6 Y137.6 F30000
; FEATURE: Outer wall
G1 F3000
G1 X120.4 Y137.6 E.71513
G1 X120.4 Y118.4 E.71513
G1 X139.6 Y118.4 E.71513
G1 X139.6 Y137.54 E.71289
; WIPE_START
G1 F24000
G1 X137.6 Y137.546 E-.76
; WIPE_END
G1 E-.04 F1800
G17
M73 P26 R15
G3 Z.6 I1.217 J.028 P1  F30000
G1 X138.026 Y119.04 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.504876
G1 F6300
G1 X138.754 Y119.769 E.03879
G1 X138.754 Y120.422 E.02459
G1 X137.578 Y119.246 E.06262
G1 X136.925 Y119.246 E.02459
G1 X138.754 Y121.075 E.0974
G1 X138.754 Y121.728 E.02459
G1 X136.272 Y119.246 E.13218
G1 X135.618 Y119.246 E.02459
G1 X138.754 Y122.382 E.16696
G1 X138.754 Y123.035 E.02459
G1 X134.965 Y119.246 E.20174
G1 X134.312 Y119.246 E.02459
G1 X138.754 Y123.688 E.23652
G1 X138.754 Y124.342 E.02459
G1 X133.658 Y119.246 E.2713
G1 X133.005 Y119.246 E.02459
G1 X138.754 Y124.995 E.30607
G1 X138.754 Y125.648 E.02459
G1 X132.352 Y119.246 E.34085
G1 X131.698 Y119.246 E.02459
G1 X138.754 Y126.302 E.37563
G1 X138.754 Y126.955 E.02459
M73 P27 R15
G1 X131.045 Y119.246 E.41041
G1 X130.392 Y119.246 E.02459
G1 X138.754 Y127.608 E.44519
G1 X138.754 Y128.261 E.02459
G1 X129.739 Y119.246 E.47997
G1 X129.085 Y119.246 E.02459
G1 X138.754 Y128.915 E.51475
G1 X138.754 Y129.568 E.02459
G1 X128.432 Y119.246 E.54953
G1 X127.779 Y119.246 E.02459
G1 X138.754 Y130.221 E.58431
G1 X138.754 Y130.875 E.02459
G1 X127.125 Y119.246 E.61909
G1 X126.472 Y119.246 E.02459
G1 X138.754 Y131.528 E.65387
G1 X138.754 Y132.181 E.02459
G1 X125.819 Y119.246 E.68865
G1 X125.165 Y119.246 E.02459
G1 X138.754 Y132.835 E.72343
G1 X138.754 Y133.488 E.02459
G1 X124.512 Y119.246 E.75821
G1 X123.859 Y119.246 E.02459
G1 X138.754 Y134.141 E.79299
G1 X138.754 Y134.795 E.02459
G1 X123.205 Y119.246 E.82776
G1 X122.552 Y119.246 E.02459
G1 X138.754 Y135.448 E.86254
G1 X138.754 Y136.101 E.02459
G1 X121.899 Y119.246 E.89732
G1 X121.246 Y119.246 E.02459
G1 X138.754 Y136.754 E.9321
G1 X138.101 Y136.754 E.02459
G1 X121.246 Y119.899 E.89732
G1 X121.246 Y120.552 E.02459
G1 X137.448 Y136.754 E.86254
G1 X136.794 Y136.754 E.02459
G1 X121.246 Y121.206 E.82776
G1 X121.246 Y121.859 E.02459
G1 X136.141 Y136.754 E.79298
G1 X135.488 Y136.754 E.02459
G1 X121.246 Y122.512 E.7582
G1 X121.246 Y123.165 E.02459
G1 X134.835 Y136.754 E.72342
G1 X134.181 Y136.754 E.02459
G1 X121.246 Y123.819 E.68864
G1 X121.246 Y124.472 E.02459
M73 P28 R15
G1 X133.528 Y136.754 E.65386
G1 X132.875 Y136.754 E.02459
G1 X121.246 Y125.125 E.61908
G1 X121.246 Y125.779 E.02459
G1 X132.221 Y136.754 E.58431
G1 X131.568 Y136.754 E.02459
G1 X121.246 Y126.432 E.54953
G1 X121.246 Y127.085 E.02459
G1 X130.915 Y136.754 E.51475
G1 X130.261 Y136.754 E.02459
G1 X121.246 Y127.739 E.47997
G1 X121.246 Y128.392 E.02459
G1 X129.608 Y136.754 E.44519
G1 X128.955 Y136.754 E.02459
G1 X121.246 Y129.045 E.41041
G1 X121.246 Y129.698 E.02459
G1 X128.302 Y136.754 E.37563
G1 X127.648 Y136.754 E.02459
G1 X121.246 Y130.352 E.34085
G1 X121.246 Y131.005 E.02459
G1 X126.995 Y136.754 E.30607
G1 X126.342 Y136.754 E.02459
G1 X121.246 Y131.658 E.27129
G1 X121.246 Y132.312 E.02459
G1 X125.688 Y136.754 E.23651
G1 X125.035 Y136.754 E.02459
G1 X121.246 Y132.965 E.20173
G1 X121.246 Y133.618 E.02459
G1 X124.382 Y136.754 E.16695
G1 X123.728 Y136.754 E.02459
G1 X121.246 Y134.272 E.13217
G1 X121.246 Y134.925 E.02459
G1 X123.075 Y136.754 E.09739
G1 X122.422 Y136.754 E.02459
G1 X121.246 Y135.578 E.06262
G1 X121.246 Y136.232 E.02459
G1 X121.974 Y136.96 E.03879
M106 S252.45
M106 P2 S178
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.246 Y136.232 E-.39153
G1 X121.246 Y135.578 E-.24826
G1 X121.469 Y135.802 E-.12021
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
M204 S10000
G17
G3 Z.6 I-.108 J1.212 P1  F30000
G1 X139.398 Y137.398 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8068
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8068
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z.8 I.724 J.978 P1  F30000
G1 X138.467 Y137.234 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.422224
G1 F8068
M73 P28 R14
G1 X139.065 Y136.637 E.02611
G1 X139.065 Y136.101 E.01658
G1 X138.101 Y137.065 E.04214
G1 X137.564 Y137.065 E.01658
G1 X139.065 Y135.564 E.06559
M73 P29 R14
G1 X139.065 Y135.028 E.01658
G1 X137.028 Y137.065 E.08903
G1 X136.491 Y137.065 E.01658
G1 X139.065 Y134.491 E.11248
G1 X139.065 Y133.955 E.01658
G1 X135.955 Y137.065 E.13593
G1 X135.419 Y137.065 E.01658
G1 X139.065 Y133.419 E.15938
G1 X139.065 Y132.882 E.01658
G1 X134.882 Y137.065 E.18282
G1 X134.346 Y137.065 E.01658
G1 X139.065 Y132.346 E.20627
G1 X139.065 Y131.809 E.01658
G1 X133.809 Y137.065 E.22972
G1 X133.273 Y137.065 E.01658
G1 X139.065 Y131.273 E.25317
G1 X139.065 Y130.736 E.01658
G1 X132.736 Y137.065 E.27661
G1 X132.2 Y137.065 E.01658
G1 X139.065 Y130.2 E.30006
G1 X139.065 Y129.664 E.01658
G1 X131.664 Y137.065 E.32351
G1 X131.127 Y137.065 E.01658
G1 X139.065 Y129.127 E.34696
G1 X139.065 Y128.591 E.01658
G1 X130.591 Y137.065 E.3704
G1 X130.054 Y137.065 E.01658
G1 X139.065 Y128.054 E.39385
G1 X139.065 Y127.518 E.01658
G1 X129.518 Y137.065 E.4173
G1 X128.982 Y137.065 E.01658
G1 X139.065 Y126.982 E.44075
G1 X139.065 Y126.445 E.01658
G1 X128.445 Y137.065 E.46419
G1 X127.909 Y137.065 E.01658
G1 X139.065 Y125.909 E.48764
G1 X139.065 Y125.372 E.01658
G1 X127.372 Y137.065 E.51109
G1 X126.836 Y137.065 E.01658
G1 X139.065 Y124.836 E.53453
G1 X139.065 Y124.299 E.01658
G1 X126.299 Y137.065 E.55798
G1 X125.763 Y137.065 E.01658
G1 X139.065 Y123.763 E.58143
G1 X139.065 Y123.227 E.01658
G1 X125.227 Y137.065 E.60488
G1 X124.69 Y137.065 E.01658
G1 X139.065 Y122.69 E.62832
G1 X139.065 Y122.154 E.01658
G1 X124.154 Y137.065 E.65177
G1 X123.617 Y137.065 E.01658
G1 X139.065 Y121.617 E.67522
G1 X139.065 Y121.081 E.01658
G1 X123.081 Y137.065 E.69867
G1 X122.545 Y137.065 E.01658
G1 X139.065 Y120.545 E.72211
G1 X139.065 Y120.008 E.01658
G1 X122.008 Y137.065 E.74556
G1 X121.472 Y137.065 E.01658
G1 X139.065 Y119.472 E.76901
G1 X139.065 Y118.935 E.01658
G1 X120.935 Y137.065 E.79245
G1 X120.935 Y136.528 E.01658
G1 X138.528 Y118.935 E.769
G1 X137.992 Y118.935 E.01658
G1 X120.935 Y135.992 E.74556
G1 X120.935 Y135.455 E.01658
G1 X137.455 Y118.935 E.72211
G1 X136.919 Y118.935 E.01658
G1 X120.935 Y134.919 E.69866
G1 X120.935 Y134.383 E.01658
G1 X136.383 Y118.935 E.67521
G1 X135.846 Y118.935 E.01658
G1 X120.935 Y133.846 E.65177
G1 X120.935 Y133.31 E.01658
G1 X135.31 Y118.935 E.62832
G1 X134.773 Y118.935 E.01658
G1 X120.935 Y132.773 E.60487
G1 X120.935 Y132.237 E.01658
G1 X134.237 Y118.935 E.58142
G1 X133.7 Y118.935 E.01658
G1 X120.935 Y131.7 E.55798
G1 X120.935 Y131.164 E.01658
G1 X133.164 Y118.935 E.53453
G1 X132.628 Y118.935 E.01658
G1 X120.935 Y130.628 E.51108
G1 X120.935 Y130.091 E.01658
G1 X132.091 Y118.935 E.48763
G1 X131.555 Y118.935 E.01658
G1 X120.935 Y129.555 E.46419
G1 X120.935 Y129.018 E.01658
G1 X131.018 Y118.935 E.44074
G1 X130.482 Y118.935 E.01658
G1 X120.935 Y128.482 E.41729
G1 X120.935 Y127.946 E.01658
G1 X129.946 Y118.935 E.39384
G1 X129.409 Y118.935 E.01658
G1 X120.935 Y127.409 E.3704
G1 X120.935 Y126.873 E.01658
G1 X128.873 Y118.935 E.34695
G1 X128.336 Y118.935 E.01658
G1 X120.935 Y126.336 E.3235
G1 X120.935 Y125.8 E.01658
G1 X127.8 Y118.935 E.30006
G1 X127.263 Y118.935 E.01658
G1 X120.935 Y125.263 E.27661
G1 X120.935 Y124.727 E.01658
G1 X126.727 Y118.935 E.25316
G1 X126.191 Y118.935 E.01658
G1 X120.935 Y124.191 E.22971
G1 X120.935 Y123.654 E.01658
G1 X125.654 Y118.935 E.20627
G1 X125.118 Y118.935 E.01658
G1 X120.935 Y123.118 E.18282
G1 X120.935 Y122.581 E.01658
G1 X124.581 Y118.935 E.15937
G1 X124.045 Y118.935 E.01658
G1 X120.935 Y122.045 E.13592
G1 X120.935 Y121.509 E.01658
G1 X123.509 Y118.935 E.11248
G1 X122.972 Y118.935 E.01658
G1 X120.935 Y120.972 E.08903
G1 X120.935 Y120.436 E.01658
G1 X122.436 Y118.935 E.06558
G1 X121.899 Y118.935 E.01658
G1 X120.935 Y119.899 E.04213
G1 X120.935 Y119.363 E.01658
G1 X121.533 Y118.766 E.0261
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X120.935 Y119.363 E-.32093
G1 X120.935 Y119.899 E-.20384
G1 X121.373 Y119.462 E-.23523
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
G17
G3 Z.8 I-.858 J.863 P1  F30000
G1 X139.398 Y137.398 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8119
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8119
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1 I1.213 J.096 P1  F30000
G1 X139.234 Y119.533 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.422224
G1 F8119
G1 X138.637 Y118.935 E.02611
G1 X138.101 Y118.935 E.01658
G1 X139.065 Y119.899 E.04214
G1 X139.065 Y120.436 E.01658
G1 X137.564 Y118.935 E.06559
G1 X137.028 Y118.935 E.01658
G1 X139.065 Y120.972 E.08903
G1 X139.065 Y121.509 E.01658
G1 X136.491 Y118.935 E.11248
G1 X135.955 Y118.935 E.01658
G1 X139.065 Y122.045 E.13593
G1 X139.065 Y122.581 E.01658
G1 X135.419 Y118.935 E.15938
G1 X134.882 Y118.935 E.01658
G1 X139.065 Y123.118 E.18282
G1 X139.065 Y123.654 E.01658
G1 X134.346 Y118.935 E.20627
G1 X133.809 Y118.935 E.01658
G1 X139.065 Y124.191 E.22972
G1 X139.065 Y124.727 E.01658
G1 X133.273 Y118.935 E.25317
G1 X132.736 Y118.935 E.01658
G1 X139.065 Y125.264 E.27661
G1 X139.065 Y125.8 E.01658
G1 X132.2 Y118.935 E.30006
G1 X131.664 Y118.935 E.01658
G1 X139.065 Y126.336 E.32351
G1 X139.065 Y126.873 E.01658
G1 X131.127 Y118.935 E.34696
G1 X130.591 Y118.935 E.01658
G1 X139.065 Y127.409 E.3704
G1 X139.065 Y127.946 E.01658
G1 X130.054 Y118.935 E.39385
G1 X129.518 Y118.935 E.01658
G1 X139.065 Y128.482 E.4173
G1 X139.065 Y129.018 E.01658
G1 X128.982 Y118.935 E.44075
G1 X128.445 Y118.935 E.01658
M73 P30 R14
G1 X139.065 Y129.555 E.46419
G1 X139.065 Y130.091 E.01658
G1 X127.909 Y118.935 E.48764
G1 X127.372 Y118.935 E.01658
G1 X139.065 Y130.628 E.51109
G1 X139.065 Y131.164 E.01658
G1 X126.836 Y118.935 E.53453
G1 X126.299 Y118.935 E.01658
G1 X139.065 Y131.701 E.55798
G1 X139.065 Y132.237 E.01658
G1 X125.763 Y118.935 E.58143
G1 X125.227 Y118.935 E.01658
G1 X139.065 Y132.773 E.60488
G1 X139.065 Y133.31 E.01658
G1 X124.69 Y118.935 E.62832
G1 X124.154 Y118.935 E.01658
G1 X139.065 Y133.846 E.65177
G1 X139.065 Y134.383 E.01658
G1 X123.617 Y118.935 E.67522
G1 X123.081 Y118.935 E.01658
G1 X139.065 Y134.919 E.69867
G1 X139.065 Y135.455 E.01658
G1 X122.545 Y118.935 E.72211
G1 X122.008 Y118.935 E.01658
G1 X139.065 Y135.992 E.74556
G1 X139.065 Y136.528 E.01658
G1 X121.472 Y118.935 E.76901
G1 X120.935 Y118.935 E.01658
G1 X139.065 Y137.065 E.79245
G1 X138.528 Y137.065 E.01658
G1 X120.935 Y119.472 E.769
G1 X120.935 Y120.008 E.01658
G1 X137.992 Y137.065 E.74556
G1 X137.455 Y137.065 E.01658
G1 X120.935 Y120.545 E.72211
G1 X120.935 Y121.081 E.01658
G1 X136.919 Y137.065 E.69866
G1 X136.383 Y137.065 E.01658
G1 X120.935 Y121.617 E.67521
G1 X120.935 Y122.154 E.01658
G1 X135.846 Y137.065 E.65177
G1 X135.31 Y137.065 E.01658
G1 X120.935 Y122.69 E.62832
G1 X120.935 Y123.227 E.01658
G1 X134.773 Y137.065 E.60487
G1 X134.237 Y137.065 E.01658
G1 X120.935 Y123.763 E.58142
G1 X120.935 Y124.3 E.01658
G1 X133.7 Y137.065 E.55798
G1 X133.164 Y137.065 E.01658
G1 X120.935 Y124.836 E.53453
G1 X120.935 Y125.372 E.01658
G1 X132.628 Y137.065 E.51108
G1 X132.091 Y137.065 E.01658
G1 X120.935 Y125.909 E.48763
G1 X120.935 Y126.445 E.01658
G1 X131.555 Y137.065 E.46419
G1 X131.018 Y137.065 E.01658
G1 X120.935 Y126.982 E.44074
G1 X120.935 Y127.518 E.01658
G1 X130.482 Y137.065 E.41729
G1 X129.946 Y137.065 E.01658
G1 X120.935 Y128.054 E.39385
G1 X120.935 Y128.591 E.01658
G1 X129.409 Y137.065 E.3704
G1 X128.873 Y137.065 E.01658
G1 X120.935 Y129.127 E.34695
G1 X120.935 Y129.664 E.01658
G1 X128.336 Y137.065 E.3235
G1 X127.8 Y137.065 E.01658
G1 X120.935 Y130.2 E.30006
G1 X120.935 Y130.737 E.01658
G1 X127.263 Y137.065 E.27661
G1 X126.727 Y137.065 E.01658
G1 X120.935 Y131.273 E.25316
G1 X120.935 Y131.809 E.01658
G1 X126.191 Y137.065 E.22971
G1 X125.654 Y137.065 E.01658
G1 X120.935 Y132.346 E.20627
G1 X120.935 Y132.882 E.01658
G1 X125.118 Y137.065 E.18282
G1 X124.581 Y137.065 E.01658
G1 X120.935 Y133.419 E.15937
G1 X120.935 Y133.955 E.01658
G1 X124.045 Y137.065 E.13592
G1 X123.509 Y137.065 E.01658
G1 X120.935 Y134.491 E.11248
G1 X120.935 Y135.028 E.01658
G1 X122.972 Y137.065 E.08903
G1 X122.436 Y137.065 E.01658
G1 X120.935 Y135.564 E.06558
G1 X120.935 Y136.101 E.01658
G1 X121.899 Y137.065 E.04213
G1 X121.363 Y137.065 E.01658
G1 X120.766 Y136.467 E.0261
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X121.363 Y137.065 E-.32093
G1 X121.899 Y137.065 E-.20384
G1 X121.462 Y136.627 E-.23523
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
G17
G3 Z1 I-.052 J1.216 P1  F30000
G1 X139.398 Y137.398 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2402
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2402
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.2 I1.201 J-.199 P1  F30000
G1 X134.674 Y118.95 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2402
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y129.374 E.09114
G1 X128.626 Y118.95 E.48898
G1 X131.374 Y118.95 E.09114
G1 X120.95 Y129.374 E.48898
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X125.326 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y118.95 E-.61876
G1 X123.435 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
G17
G3 Z1.2 I-.915 J.803 P1  F30000
G1 X139.398 Y137.398 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2406
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2406
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.4 I1.201 J-.199 P1  F30000
M73 P31 R14
G1 X134.674 Y118.95 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2406
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y129.374 E.09114
G1 X128.626 Y118.95 E.48898
G1 X131.374 Y118.95 E.09114
G1 X120.95 Y129.374 E.48898
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X125.326 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y118.95 E-.61876
G1 X123.435 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
G17
G3 Z1.4 I-.915 J.803 P1  F30000
G1 X139.398 Y137.398 Z1.4
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2406
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2406
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I1.201 J-.199 P1  F30000
G1 X134.674 Y118.95 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2406
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y129.374 E.09114
G1 X128.626 Y118.95 E.48898
G1 X131.374 Y118.95 E.09114
G1 X120.95 Y129.374 E.48898
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X125.326 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
M73 P32 R14
G1 X123.698 Y118.95 E-.61876
G1 X123.435 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
G17
G3 Z1.6 I-.915 J.803 P1  F30000
G1 X139.398 Y137.398 Z1.6
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2406
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2406
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I1.201 J-.199 P1  F30000
G1 X134.674 Y118.95 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2406
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y129.374 E.09114
G1 X128.626 Y118.95 E.48898
G1 X131.374 Y118.95 E.09114
G1 X120.95 Y129.374 E.48898
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X125.326 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y118.95 E-.61876
G1 X123.435 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
G17
G3 Z1.8 I-.915 J.803 P1  F30000
G1 X139.398 Y137.398 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2406
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2406
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2 I1.201 J-.199 P1  F30000
M73 P33 R14
G1 X134.674 Y118.95 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2406
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y129.374 E.09114
G1 X128.626 Y118.95 E.48898
G1 X131.374 Y118.95 E.09114
G1 X120.95 Y129.374 E.48898
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X125.326 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y118.95 E-.61876
G1 X123.435 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
G17
G3 Z2 I-.915 J.803 P1  F30000
G1 X139.398 Y137.398 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2406
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2406
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.2 I1.201 J-.199 P1  F30000
M73 P33 R13
G1 X134.674 Y118.95 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2406
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y129.374 E.09114
G1 X128.626 Y118.95 E.48898
G1 X131.374 Y118.95 E.09114
G1 X120.95 Y129.374 E.48898
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X125.326 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y118.95 E-.61876
M73 P34 R13
G1 X123.435 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
G17
G3 Z2.2 I-.915 J.803 P1  F30000
G1 X139.398 Y137.398 Z2.2
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2406
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2406
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.4 I1.201 J-.199 P1  F30000
G1 X134.674 Y118.95 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2406
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y129.374 E.09114
G1 X128.626 Y118.95 E.48898
G1 X131.374 Y118.95 E.09114
G1 X120.95 Y129.374 E.48898
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X125.326 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y118.95 E-.61876
G1 X123.435 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 11/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
G17
G3 Z2.4 I-.915 J.803 P1  F30000
G1 X139.398 Y137.398 Z2.4
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2406
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2406
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.6 I1.201 J-.199 P1  F30000
M73 P35 R13
G1 X134.674 Y118.95 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2406
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y129.374 E.09114
G1 X128.626 Y118.95 E.48898
G1 X131.374 Y118.95 E.09114
G1 X120.95 Y129.374 E.48898
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X125.326 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y118.95 E-.61876
G1 X123.435 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 12/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
G17
G3 Z2.6 I-.915 J.803 P1  F30000
G1 X139.398 Y137.398 Z2.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2687
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2687
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.8 I.262 J-1.188 P1  F30000
G1 X134.674 Y137.05 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2687
G1 X136.302 Y137.05 E.05401
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X125.61 Y123.61 E.6305
G1 X126.714 Y123.61 E.03665
G1 X120.95 Y129.374 E.2704
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y129.374 E.09114
G1 X133.286 Y123.61 E.27041
G1 X134.39 Y123.61 E.03665
G1 X120.95 Y137.05 E.6305
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X120.95 Y123.326 F30000
G1 F2687
G1 X120.95 Y121.698 E.05401
G1 X121.334 Y121.314 E.01801
G1 X121.333 Y119.333 E.0657
G1 X120.95 Y118.95 E.01797
G1 X120.95 Y120.579 E.05401
G1 X124.919 Y119.357 F30000
M73 P36 R13
G1 F2687
G1 X123.291 Y119.357 E.05401
G1 X122.148 Y120.5 E.0536
G1 X122.148 Y120.148 E.01168
G1 X124.795 Y122.795 E.1242
G1 X127.529 Y122.795 E.09066
G1 X130.967 Y119.357 E.16128
G1 X129.033 Y119.357 E.06413
G1 X132.471 Y122.795 E.16128
G1 X135.205 Y122.795 E.09066
G1 X137.207 Y120.793 E.09395
G1 X137.208 Y119.856 E.03108
G1 X136.709 Y119.357 E.02338
G1 X135.081 Y119.357 E.05401
G1 X137.614 Y121.24 F30000
G1 F2687
G1 X135.65 Y123.203 E.0921
G1 X131.175 Y123.203 E.14846
G1 X129.594 Y121.645 E.07362
G1 X128.013 Y123.203 E.07362
G1 X123.705 Y123.203 E.14289
G1 X121.759 Y121.281 E.09073
G1 X121.74 Y118.95 E.07732
G1 X137.615 Y118.95 E.5266
G1 X137.614 Y121.18 E.07395
G1 X139.05 Y120.579 F30000
G1 F2687
G1 X139.05 Y118.95 E.05401
G1 X138.022 Y119.978 E.04822
G1 X138.021 Y120.67 E.02293
G1 X139.05 Y121.698 E.04823
G1 X139.05 Y123.326 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X139.05 Y121.698 E-.61876
G1 X138.787 Y121.435 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 13/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
G17
G3 Z2.8 I-1.216 J.047 P1  F30000
G1 X139.398 Y137.398 Z2.8
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2903
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2903
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3 I.262 J-1.188 P1  F30000
G1 X134.674 Y137.05 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2903
G1 X136.302 Y137.05 E.05401
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X125.61 Y123.61 E.6305
G1 X126.714 Y123.61 E.03665
G1 X120.95 Y129.374 E.2704
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X134.982 Y130.694 E.29816
G1 X134.414 Y130.126 E.02665
G1 X134.335 Y129.934 E.00686
G1 X134.337 Y125.397 E.1505
G3 X134.649 Y124.973 I.668 J.165 E.01792
G1 X133.286 Y123.61 E.06398
G1 X134.39 Y123.61 E.03665
G1 X120.95 Y137.05 E.6305
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X136.709 Y131.27 F30000
G1 F2903
G1 X135.558 Y130.118 E.05401
G1 X138.643 Y127.033 E.14471
G1 X138.643 Y128.967 E.06413
G1 X135.225 Y125.549 E.16032
G1 X136.377 Y124.398 E.05401
G1 X139.05 Y123.516 F30000
G1 F2903
G1 X139.05 Y131.819 E.27543
G1 X136.705 Y131.818 E.07776
G1 X134.742 Y129.854 E.09214
G1 X134.744 Y125.478 E.14513
G1 X136.668 Y123.532 E.09076
G1 X138.99 Y123.516 E.07703
G1 X138.833 Y123.109 F30000
G1 F2903
G1 X139.05 Y123.109 E.00719
G1 X139.05 Y121.698 E.04682
G1 X138.021 Y120.67 E.04823
G1 X138.022 Y119.978 E.02293
G1 X139.05 Y118.95 E.04822
G1 X139.05 Y120.579 E.05401
G1 X137.614 Y121.18 F30000
G1 F2903
G1 X137.615 Y118.95 E.07395
G1 X121.74 Y118.95 E.5266
G1 X121.759 Y121.281 E.07732
G1 X123.705 Y123.203 E.09073
G1 X128.013 Y123.203 E.14289
G1 X129.594 Y121.645 E.07362
G1 X131.175 Y123.203 E.07362
G1 X135.65 Y123.203 E.14846
G1 X137.614 Y121.24 E.0921
G1 X135.081 Y119.357 F30000
G1 F2903
M73 P37 R13
G1 X136.709 Y119.357 E.05401
G1 X137.208 Y119.856 E.02338
G1 X137.207 Y120.793 E.03108
G1 X135.205 Y122.795 E.09395
G1 X132.471 Y122.795 E.09066
G1 X129.033 Y119.357 E.16128
G1 X130.967 Y119.357 E.06413
G1 X127.529 Y122.795 E.16128
G1 X124.795 Y122.795 E.09066
G1 X122.148 Y120.148 E.1242
G1 X122.148 Y120.5 E.01168
G1 X123.291 Y119.357 E.0536
G1 X124.919 Y119.357 E.05401
G1 X120.95 Y120.579 F30000
G1 F2903
G1 X120.95 Y118.95 E.05401
G1 X121.333 Y119.333 E.01797
G1 X121.334 Y121.314 E.0657
G1 X120.95 Y121.698 E.01801
G1 X120.95 Y123.326 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X120.95 Y121.698 E-.61876
G1 X121.213 Y121.435 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 14/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
G17
G3 Z3 I-.803 J.915 P1  F30000
G1 X139.398 Y137.398 Z3
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2909
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2909
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.2 I.262 J-1.188 P1  F30000
G1 X134.674 Y137.05 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2909
G1 X136.302 Y137.05 E.05401
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X125.61 Y123.61 E.6305
G1 X126.714 Y123.61 E.03665
G1 X120.95 Y129.374 E.2704
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X134.982 Y130.694 E.29816
G1 X134.414 Y130.126 E.02665
G1 X134.335 Y129.934 E.00686
G1 X134.337 Y125.397 E.1505
G3 X134.649 Y124.973 I.668 J.165 E.01792
G1 X133.286 Y123.61 E.06398
G1 X134.39 Y123.61 E.03665
G1 X120.95 Y137.05 E.6305
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X136.709 Y131.27 F30000
G1 F2909
G1 X135.558 Y130.118 E.05401
G1 X138.643 Y127.033 E.14471
G1 X138.643 Y128.967 E.06413
G1 X135.225 Y125.549 E.16032
G1 X136.377 Y124.398 E.05401
G1 X139.05 Y123.516 F30000
G1 F2909
G1 X139.05 Y131.819 E.27543
G1 X136.705 Y131.818 E.07776
G1 X134.742 Y129.854 E.09214
G1 X134.744 Y125.478 E.14513
G1 X136.668 Y123.532 E.09076
G1 X138.99 Y123.516 E.07703
G1 X138.833 Y123.109 F30000
G1 F2909
G1 X139.05 Y123.109 E.00719
G1 X139.05 Y121.698 E.04682
G1 X138.021 Y120.67 E.04823
G1 X138.022 Y119.978 E.02293
G1 X139.05 Y118.95 E.04822
G1 X139.05 Y120.579 E.05401
G1 X137.614 Y121.18 F30000
G1 F2909
G1 X137.615 Y118.95 E.07395
G1 X121.74 Y118.95 E.5266
G1 X121.759 Y121.281 E.07732
G1 X123.705 Y123.203 E.09073
G1 X128.013 Y123.203 E.14289
G1 X129.594 Y121.645 E.07362
G1 X131.175 Y123.203 E.07362
G1 X135.65 Y123.203 E.14846
G1 X137.614 Y121.24 E.0921
G1 X135.081 Y119.357 F30000
G1 F2909
G1 X136.709 Y119.357 E.05401
G1 X137.208 Y119.856 E.02338
G1 X137.207 Y120.793 E.03108
G1 X135.205 Y122.795 E.09395
G1 X132.471 Y122.795 E.09066
G1 X129.033 Y119.357 E.16128
G1 X130.967 Y119.357 E.06413
G1 X127.529 Y122.795 E.16128
G1 X124.795 Y122.795 E.09066
G1 X122.148 Y120.148 E.1242
G1 X122.148 Y120.5 E.01168
G1 X123.291 Y119.357 E.0536
G1 X124.919 Y119.357 E.05401
G1 X120.95 Y120.579 F30000
G1 F2909
G1 X120.95 Y118.95 E.05401
G1 X121.333 Y119.333 E.01797
G1 X121.334 Y121.314 E.0657
G1 X120.95 Y121.698 E.01801
G1 X120.95 Y123.326 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X120.95 Y121.698 E-.61876
G1 X121.213 Y121.435 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 15/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
G17
G3 Z3.2 I-.803 J.915 P1  F30000
G1 X139.398 Y137.398 Z3.2
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2909
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2909
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.4 I.262 J-1.188 P1  F30000
G1 X134.674 Y137.05 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2909
G1 X136.302 Y137.05 E.05401
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X125.61 Y123.61 E.6305
G1 X126.714 Y123.61 E.03665
G1 X120.95 Y129.374 E.2704
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X134.982 Y130.694 E.29816
G1 X134.414 Y130.126 E.02665
M73 P38 R13
G1 X134.335 Y129.934 E.00686
G1 X134.337 Y125.397 E.1505
G3 X134.649 Y124.973 I.668 J.165 E.01792
G1 X133.286 Y123.61 E.06398
G1 X134.39 Y123.61 E.03665
G1 X120.95 Y137.05 E.6305
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X136.709 Y131.27 F30000
G1 F2909
G1 X135.558 Y130.118 E.05401
G1 X138.643 Y127.033 E.14471
G1 X138.643 Y128.967 E.06413
G1 X135.225 Y125.549 E.16032
G1 X136.377 Y124.398 E.05401
G1 X139.05 Y123.516 F30000
G1 F2909
G1 X139.05 Y131.819 E.27543
G1 X136.705 Y131.818 E.07776
G1 X134.742 Y129.854 E.09214
G1 X134.744 Y125.478 E.14513
G1 X136.668 Y123.532 E.09076
G1 X138.99 Y123.516 E.07703
G1 X138.833 Y123.109 F30000
G1 F2909
G1 X139.05 Y123.109 E.00719
G1 X139.05 Y121.698 E.04682
G1 X138.021 Y120.67 E.04823
G1 X138.022 Y119.978 E.02293
G1 X139.05 Y118.95 E.04822
G1 X139.05 Y120.579 E.05401
G1 X137.614 Y121.18 F30000
G1 F2909
G1 X137.615 Y118.95 E.07395
G1 X121.74 Y118.95 E.5266
G1 X121.759 Y121.281 E.07732
G1 X123.705 Y123.203 E.09073
G1 X128.013 Y123.203 E.14289
G1 X129.594 Y121.645 E.07362
G1 X131.175 Y123.203 E.07362
G1 X135.65 Y123.203 E.14846
G1 X137.614 Y121.24 E.0921
G1 X135.081 Y119.357 F30000
G1 F2909
G1 X136.709 Y119.357 E.05401
G1 X137.208 Y119.856 E.02338
G1 X137.207 Y120.793 E.03108
G1 X135.205 Y122.795 E.09395
M73 P38 R12
G1 X132.471 Y122.795 E.09066
G1 X129.033 Y119.357 E.16128
G1 X130.967 Y119.357 E.06413
G1 X127.529 Y122.795 E.16128
G1 X124.795 Y122.795 E.09066
G1 X122.148 Y120.148 E.1242
G1 X122.148 Y120.5 E.01168
G1 X123.291 Y119.357 E.0536
G1 X124.919 Y119.357 E.05401
G1 X120.95 Y120.579 F30000
G1 F2909
G1 X120.95 Y118.95 E.05401
G1 X121.333 Y119.333 E.01797
G1 X121.334 Y121.314 E.0657
G1 X120.95 Y121.698 E.01801
G1 X120.95 Y123.326 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X120.95 Y121.698 E-.61876
G1 X121.213 Y121.435 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 16/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
G17
G3 Z3.4 I-.803 J.915 P1  F30000
G1 X139.398 Y137.398 Z3.4
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3880
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3880
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.6 I.262 J-1.188 P1  F30000
G1 X134.674 Y137.05 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3880
G1 X136.302 Y137.05 E.05401
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X125.61 Y123.61 E.6305
G1 X126.714 Y123.61 E.03665
G1 X120.95 Y129.374 E.2704
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X134.982 Y130.694 E.29816
G1 X134.414 Y130.126 E.02665
G1 X134.335 Y129.934 E.00686
G1 X134.337 Y125.397 E.1505
G3 X134.649 Y124.973 I.668 J.165 E.01792
G1 X133.286 Y123.61 E.06398
G1 X134.39 Y123.61 E.03665
G1 X120.95 Y137.05 E.6305
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X136.709 Y131.27 F30000
G1 F3880
G1 X135.558 Y130.118 E.05401
G1 X138.643 Y127.033 E.14471
G1 X138.643 Y128.967 E.06413
G1 X135.225 Y125.549 E.16032
G1 X136.377 Y124.398 E.05401
G1 X136.892 Y122.241 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.415926
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X130.22 Y122.241 E.36937
G1 X130.686 Y122.707 E.03647
G1 X136.14 Y122.707 E.30192
G1 X135.665 Y123.173 E.03682
G1 X130.865 Y123.173 E.26572
M106 S252.45
G1 X128.322 Y123.173 F30000
M106 S255
G1 F3000
G1 X123.69 Y123.173 E.25643
G1 X123.216 Y122.707 E.03682
G1 X128.502 Y122.707 E.29263
G1 X128.967 Y122.241 E.03647
G1 X122.749 Y122.241 E.34422
G1 X122.283 Y121.775 E.03648
G1 X137.072 Y121.775 E.81869
G1 X137.538 Y121.309 E.03649
G1 X121.817 Y121.309 E.8703
G3 X121.763 Y121.235 I.062 J-.103 E.00522
G1 X121.763 Y120.844 E.02169
G1 X137.593 Y120.844 E.87634
G1 X137.593 Y120.378 E.02579
G1 X121.762 Y120.378 E.87636
G1 X121.762 Y119.912 E.02579
G1 X137.593 Y119.912 E.87639
G1 X137.594 Y119.446 E.02579
G1 X121.762 Y119.446 E.87641
G1 X121.762 Y118.98 E.02579
G1 X137.796 Y118.98 E.88765
M106 S252.45
G1 X139.05 Y120.579 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.2
G1 F3880
M73 P39 R12
G1 X139.05 Y118.95 E.05401
G1 X138.022 Y119.978 E.04822
G1 X138.021 Y120.67 E.02294
G1 X139.05 Y121.698 E.04823
G1 X139.05 Y123.109 E.04682
G1 X138.833 Y123.109 E.00719
G1 X138.99 Y123.516 F30000
G1 F3880
G1 X136.668 Y123.532 E.07703
G1 X134.744 Y125.478 E.09076
G1 X134.742 Y129.854 E.14513
G1 X136.705 Y131.818 E.09214
G1 X139.05 Y131.819 E.07776
G1 X139.05 Y123.516 E.27543
G1 X120.95 Y123.326 F30000
G1 F3880
G1 X120.95 Y121.698 E.05401
G1 X121.334 Y121.314 E.01801
G1 X121.333 Y119.333 E.0657
G1 X120.95 Y118.95 E.01797
G1 X120.95 Y120.579 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X120.95 Y118.95 E-.61876
G1 X121.213 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 17/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
G17
G3 Z3.6 I-.861 J.861 P1  F30000
G1 X139.398 Y137.398 Z3.6
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4399
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4399
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.8 I.262 J-1.188 P1  F30000
G1 X134.674 Y137.05 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4399
G1 X136.302 Y137.05 E.05401
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X125.61 Y123.61 E.6305
G1 X126.714 Y123.61 E.03665
G1 X120.95 Y129.374 E.2704
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X134.982 Y130.694 E.29816
G1 X134.414 Y130.126 E.02665
G1 X134.335 Y129.934 E.00686
G1 X134.337 Y125.397 E.1505
G3 X134.649 Y124.973 I.668 J.165 E.01792
G1 X133.286 Y123.61 E.06398
G1 X134.39 Y123.61 E.03665
G1 X120.95 Y137.05 E.6305
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X136.401 Y131.794 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.408488
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X139.028 Y131.794 E.1403
G1 X139.028 Y131.335 E.02448
G1 X136.229 Y131.335 E.14948
G1 X135.771 Y130.877 E.03461
G1 X139.028 Y130.877 E.17394
G1 X139.028 Y130.418 E.02448
G1 X135.313 Y130.418 E.1984
G1 X134.855 Y129.96 E.03461
G1 X139.028 Y129.96 E.22286
G1 X139.028 Y129.501 E.02448
G1 X134.764 Y129.501 E.22769
G1 X134.764 Y129.043 E.02448
G1 X139.028 Y129.043 E.22768
G1 X139.028 Y128.584 E.02448
G1 X134.764 Y128.584 E.22767
G1 X134.765 Y128.126 E.02448
G1 X139.028 Y128.126 E.22766
G1 X139.028 Y127.667 E.02448
G1 X134.765 Y127.667 E.22765
G1 X134.765 Y127.209 E.02448
G1 X139.028 Y127.209 E.22764
G1 X139.028 Y126.75 E.02448
G1 X134.765 Y126.75 E.22763
G1 X134.765 Y126.292 E.02448
G1 X139.028 Y126.292 E.22762
G1 X139.028 Y125.833 E.02448
G1 X134.766 Y125.833 E.22761
G1 X134.766 Y125.483 E.01873
G3 X134.854 Y125.375 I.174 J.052 E.00762
G1 X139.028 Y125.375 E.2229
G1 X139.028 Y124.916 E.02448
G1 X135.313 Y124.916 E.19839
G1 X135.772 Y124.458 E.03464
G1 X139.028 Y124.458 E.17389
G1 X139.028 Y123.999 E.02448
G1 X136.23 Y123.999 E.14939
G1 X136.703 Y123.541 E.03516
G1 X139.231 Y123.541 E.13497
M106 S252.45
G1 X138.833 Y123.109 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.2
G1 F4399
G1 X139.05 Y123.109 E.00719
G1 X139.05 Y121.698 E.04682
G1 X138.021 Y120.67 E.04823
G1 X138.022 Y119.978 E.02294
G1 X139.05 Y118.95 E.04822
G1 X139.05 Y120.579 E.05401
G1 X127.254 Y121.313 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.457756
G1 F4399
G1 X127.669 Y120.898 E.01983
G1 X124.048 Y120.898 E.1224
G1 X124.463 Y121.313 E.01984
G1 X127.194 Y121.313 E.09232
G1 X127.418 Y121.709 F30000
; LINE_WIDTH: 0.419999
G1 F4399
G1 X128.394 Y120.733 E.04239
G1 X128.788 Y120.502 E.01403
G1 X123.234 Y120.502 E.17064
G1 X123.264 Y120.674 E.00536
G1 X124.299 Y121.709 E.04498
G1 X127.358 Y121.709 E.094
G1 X131.125 Y123.198 F30000
G1 F4399
G1 X132.019 Y123.218 E.02749
G1 X135.653 Y123.218 E.11166
G2 X137.61 Y121.29 I-43.19 J-45.787 E.0844
G2 X137.63 Y118.994 I-40.338 J-1.512 E.07055
G1 X121.725 Y118.994 E.48872
G1 X121.726 Y121.243 E.06909
G2 X123.655 Y123.198 I35.334 J-32.922 E.08441
G1 X124.549 Y123.218 E.02747
G1 X128.016 Y123.218 E.10652
G2 X129.46 Y121.8 I-31.744 J-33.792 E.06221
G1 X129.626 Y121.747 E.00535
G1 X129.727 Y121.8 E.00349
G1 X131.082 Y123.156 E.05891
G1 X131.301 Y122.84 F30000
G1 F4399
G1 X135.525 Y122.84 E.1298
G1 X137.252 Y121.114 E.07504
G1 X137.253 Y119.371 E.05355
G1 X122.103 Y119.371 E.46553
G1 X122.103 Y121.114 E.05355
G1 X123.831 Y122.84 E.07505
G1 X127.887 Y122.84 E.12464
G1 X129.194 Y121.533 E.0568
G1 X129.496 Y121.376 E.01047
G1 X129.747 Y121.388 E.00772
G1 X129.994 Y121.533 E.00879
G1 X131.258 Y122.798 E.05495
G1 X131.457 Y122.463 F30000
G1 F4399
G1 X135.369 Y122.463 E.1202
G1 X136.875 Y120.958 E.06545
G1 X136.876 Y119.748 E.03716
G1 X122.48 Y119.748 E.44235
G1 X122.48 Y120.958 E.03716
G1 X123.987 Y122.463 E.06545
G1 X127.731 Y122.463 E.11504
G1 X128.927 Y121.267 E.052
G1 X129.431 Y121.004 E.01745
G1 X129.757 Y121.004 E.01001
G1 X130.261 Y121.267 E.01745
G1 X131.414 Y122.421 E.05015
G1 X131.613 Y122.086 F30000
G1 F4399
G1 X135.212 Y122.086 E.1106
G1 X136.498 Y120.801 E.05585
G1 X136.498 Y120.125 E.02077
G1 X130.89 Y120.125 E.17234
G1 X130.026 Y120.145 E.02655
; LINE_WIDTH: 0.476188
G3 X128.298 Y120.125 I-.671 J-16.615 E.06103
; LINE_WIDTH: 0.419999
G1 X122.857 Y120.125 E.16719
G1 X122.857 Y120.801 E.02077
G1 X124.143 Y122.086 E.05585
G1 X127.575 Y122.086 E.10544
G1 X128.66 Y121 E.0472
G1 X129.231 Y120.643 E.02067
; LINE_WIDTH: 0.467767
G1 X129.594 Y120.585 E.01273
G1 X129.957 Y120.643 E.01273
; LINE_WIDTH: 0.432581
G1 X130.527 Y121 E.02136
G1 X131.571 Y122.044 E.04686
G1 X131.769 Y121.709 F30000
; LINE_WIDTH: 0.419999
G1 F4399
G1 X135.056 Y121.709 E.101
G1 X136.121 Y120.645 E.04626
G1 X136.121 Y120.502 E.00438
G1 X130.4 Y120.502 E.1758
G1 X130.794 Y120.733 E.01403
G1 X131.727 Y121.667 E.04055
G1 X131.933 Y121.313 F30000
; LINE_WIDTH: 0.457756
G1 F4399
G1 X134.892 Y121.313 E.10002
G1 X135.307 Y120.898 E.01984
M73 P40 R12
G1 X131.519 Y120.898 E.12807
G1 X131.891 Y121.271 E.0178
G1 X120.95 Y120.579 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4399
G1 X120.95 Y118.95 E.05401
G1 X121.333 Y119.333 E.01797
G1 X121.334 Y121.314 E.0657
G1 X120.95 Y121.698 E.01801
G1 X120.95 Y123.326 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X120.95 Y121.698 E-.61876
G1 X121.213 Y121.435 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 18/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
G17
G3 Z3.8 I-.803 J.915 P1  F30000
G1 X139.398 Y137.398 Z3.8
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4351
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X123.973 Y118.602 E.11184
G1 X123.975 Y120.969 E.07852
G1 X127.743 Y120.969 E.12502
G1 X127.742 Y118.602 E.07852
G1 X131.445 Y118.602 E.12284
G1 X131.444 Y120.969 E.07852
G1 X135.381 Y120.969 E.13058
G1 X135.382 Y118.602 E.07852
G1 X139.398 Y118.602 E.13321
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4351
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4 I.262 J-1.188 P1  F30000
G1 X134.674 Y137.05 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4351
G1 X136.302 Y137.05 E.05401
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X125.095 Y123.095 E.65465
G1 X127.229 Y123.095 E.0708
G1 X120.95 Y129.374 E.29455
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X134.982 Y130.694 E.29816
G1 X134.414 Y130.126 E.02665
G1 X134.335 Y129.934 E.00687
G1 X134.337 Y125.397 E.1505
G3 X134.649 Y124.973 I.668 J.165 E.01792
G1 X132.771 Y123.095 E.08812
G1 X134.905 Y123.095 E.0708
G1 X120.95 Y137.05 E.65465
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X134.729 Y126.334 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F4351
G1 X134.727 Y129.856 E.10825
G2 X136.655 Y131.814 I46.365 J-43.743 E.08443
G2 X139.006 Y131.834 I1.544 J-42.256 E.07223
G1 X139.006 Y123.501 E.25605
G1 X136.706 Y123.5 E.07066
G2 X134.749 Y125.428 I33.659 J36.128 E.08443
G1 X134.73 Y126.274 E.02598
G1 X136.646 Y128.999 F30000
; LINE_WIDTH: 0.484851
G1 F4351
G1 X136.646 Y129.09 E.0033
G1 X137.088 Y129.533 E.02253
G1 X137.088 Y125.802 E.13437
G1 X136.647 Y126.243 E.02248
G1 X136.646 Y128.939 E.09708
G1 X136.236 Y129.26 F30000
; LINE_WIDTH: 0.419999
G1 F4351
G1 X137.3 Y130.325 E.04627
G1 X137.498 Y130.325 E.00606
G1 X137.498 Y125.009 E.16336
G1 X137.303 Y125.009 E.00599
G1 X136.237 Y126.073 E.04627
G1 X136.236 Y129.2 E.09608
G1 X135.859 Y129.416 F30000
G1 F4351
G1 X137.144 Y130.702 E.05587
G1 X137.875 Y130.703 E.02245
G1 X137.875 Y124.632 E.18653
G1 X137.147 Y124.632 E.02237
G1 X135.86 Y125.917 E.05587
G1 X135.859 Y129.356 E.10567
G1 X135.482 Y129.572 F30000
G1 F4351
G1 X136.988 Y131.079 E.06547
G1 X138.252 Y131.08 E.03884
G1 X138.252 Y124.255 E.20971
G1 X136.991 Y124.255 E.03875
G1 X135.483 Y125.761 E.06547
G1 X135.482 Y129.512 E.11527
G1 X135.104 Y129.728 F30000
G1 F4351
G1 X136.831 Y131.456 E.07507
G1 X138.629 Y131.457 E.05523
G1 X138.629 Y123.878 E.23288
G1 X136.835 Y123.877 E.05513
G1 X135.106 Y125.604 E.07507
G1 X135.104 Y129.668 E.12487
G1 X138.833 Y123.109 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4351
G1 X139.05 Y123.109 E.00719
G1 X139.05 Y121.698 E.04682
G1 X137.507 Y120.155 E.07237
G1 X137.507 Y120.493 E.01121
G1 X139.05 Y118.95 E.07238
G1 X139.05 Y120.579 E.05401
G1 X137.284 Y120.449 F30000
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F4351
G1 X134.861 Y122.873 E.10532
G1 X134.328 Y122.873
G1 X137.285 Y119.915 E.12851
G1 X137.285 Y119.382
G1 X135.603 Y121.064 E.07308
G1 X135.603 Y120.53
G1 X137.285 Y118.848 E.07308
G1 X136.776 Y118.824
G1 X135.604 Y119.996 E.05093
G1 X135.604 Y119.463
G1 X136.242 Y118.824 E.02774
M204 S10000
G1 X135.475 Y121.192 F30000
M204 S2000
G1 F4351
G1 X133.794 Y122.873 E.07305
G1 X133.261 Y122.873
G1 X134.942 Y121.192 E.07305
G1 X134.409 Y121.192
G1 X132.728 Y122.873 E.07305
G1 X132.194 Y122.873
G1 X133.875 Y121.192 E.07305
G1 X133.342 Y121.192
G1 X131.661 Y122.873 E.07305
G1 X131.208 Y122.793
G1 X132.809 Y121.192 E.06958
G1 X132.276 Y121.192
G1 X130.941 Y122.526 E.05799
G1 X130.675 Y122.259
G1 X131.742 Y121.192 E.0464
G1 X131.222 Y121.179
G1 X130.408 Y121.993 E.03536
G1 X130.141 Y121.726
G1 X131.222 Y120.645 E.04696
G1 X131.222 Y120.112
G1 X129.875 Y121.459 E.05856
G1 X129.608 Y121.193
G1 X131.223 Y119.578 E.07015
G1 X131.223 Y119.045
G1 X127.395 Y122.873 E.16634
G1 X126.862 Y122.873
G1 X130.91 Y118.824 E.17591
G1 X130.377 Y118.824
G1 X126.328 Y122.873 E.17591
G1 X125.795 Y122.873
G1 X127.476 Y121.192 E.07305
G1 X126.943 Y121.192
G1 X125.262 Y122.873 E.07305
G1 X124.729 Y122.873
G1 X126.41 Y121.192 E.07305
G1 X125.876 Y121.192
G1 X124.195 Y122.873 E.07305
G1 X123.74 Y122.795
G1 X125.343 Y121.192 E.06967
G1 X124.81 Y121.192
G1 X123.473 Y122.528 E.05809
G1 X123.206 Y122.262
G1 X124.277 Y121.192 E.0465
G1 X123.752 Y121.183
G1 X122.94 Y121.995 E.03531
G1 X122.673 Y121.729
G1 X123.752 Y120.65 E.04689
G1 X123.752 Y120.116
G1 X122.406 Y121.462 E.05847
G1 X122.14 Y121.195
G1 X123.752 Y119.583 E.07005
G1 X123.751 Y119.05
G1 X122.071 Y120.731 E.07301
G1 X122.071 Y120.198
G1 X123.444 Y118.824 E.05967
G1 X122.911 Y118.824
G1 X122.071 Y119.665 E.03651
M204 S10000
G1 X127.966 Y120.702 F30000
M204 S2000
G1 F4351
G1 X129.843 Y118.824 E.08159
G1 X129.31 Y118.824
G1 X127.965 Y120.169 E.05843
G1 X127.965 Y119.636
G1 X128.777 Y118.824 E.03527
M204 S10000
; WIPE_START
G1 F24000
G1 X127.965 Y119.636 E-.43613
G1 X127.965 Y120.169 E-.20254
G1 X128.191 Y119.943 E-.12132
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4 I-.129 J1.21 P1  F30000
G1 X137.303 Y120.916 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.352724
G1 F4351
G1 X135.327 Y122.891 E.07053
G1 X135.605 Y121.065 F30000
; LINE_WIDTH: 0.162812
G1 F4351
G1 X135.645 Y121.197 E.00134
G1 X135.609 Y121.233 E.0005
G1 X135.477 Y121.193 E.00134
G1 X131.241 Y120.987 F30000
; LINE_WIDTH: 0.0959582
G1 F4351
G1 X131.211 Y120.965 E.00016
G1 X131.124 Y121.081 E.00063
G1 X123.771 Y120.99 F30000
; LINE_WIDTH: 0.0959811
G1 F4351
G1 X123.742 Y120.968 E.00016
G1 X123.653 Y121.083 E.00063
G1 X129.541 Y121.125 F30000
; LINE_WIDTH: 0.229972
G1 F4351
G1 X127.775 Y122.891 E.03806
G1 X127.521 Y120.081 F30000
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F4351
G1 X126.854 Y120.747 E.02895
G1 X126.321 Y120.747
G1 X127.52 Y119.548 E.05211
G1 X127.52 Y119.015
G1 X125.788 Y120.747 E.07527
G1 X125.255 Y120.747
G1 X127.52 Y118.482 E.09843
G1 X127.051 Y118.417
G1 X124.721 Y120.747 E.10122
G1 X124.197 Y120.738
G1 X126.517 Y118.417 E.10084
G1 X125.984 Y118.417
G1 X124.197 Y120.205 E.07768
G1 X124.196 Y119.672
G1 X125.451 Y118.417 E.05451
G1 X124.918 Y118.417
G1 X124.196 Y119.139 E.03135
M204 S10000
G1 X120.95 Y120.579 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4351
G1 X120.95 Y118.95 E.05401
G1 X121.848 Y119.848 E.04212
G1 X121.849 Y120.799 E.03155
G1 X120.95 Y121.698 E.04215
G1 X120.95 Y123.326 E.05401
G1 X134.32 Y120.747 F30000
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F4351
G1 X135.159 Y119.908 E.03645
G1 X135.159 Y119.374
G1 X133.787 Y120.747 E.05964
G1 X133.254 Y120.747
G1 X135.16 Y118.841 E.08282
G1 X135.05 Y118.417
G1 X132.72 Y120.747 E.10122
G1 X132.187 Y120.747
G1 X134.516 Y118.417 E.10122
G1 X133.983 Y118.417
G1 X131.667 Y120.734 E.10066
G1 X131.667 Y120.2
G1 X133.45 Y118.417 E.07747
G1 X132.917 Y118.417
G1 X131.667 Y119.667 E.05429
G1 X131.668 Y119.133
G1 X132.383 Y118.417 E.0311
M204 S10000
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X131.668 Y119.133 E-.38467
G1 X131.667 Y119.667 E-.20275
G1 X131.988 Y119.346 E-.17258
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 19/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
G17
G3 Z4 I-.121 J-1.211 P1  F30000
G1 X124.45 Y120.101 Z4
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3169
G1 X124.45 Y120.493 E.01301
G1 X127.267 Y120.493 E.09346
G1 X127.267 Y118.602 E.06274
G1 X131.921 Y118.602 E.1544
G1 X131.92 Y120.493 E.06274
G1 X134.905 Y120.493 E.09902
G1 X134.906 Y118.602 E.06274
G1 X139.398 Y118.602 E.14899
G1 X139.398 Y125.75 E.2371
G1 X136.978 Y125.749 E.08029
G1 X136.976 Y129.585 E.12726
G1 X139.398 Y129.586 E.08035
G1 X139.398 Y137.398 E.25913
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X124.449 Y118.602 E.12762
G1 X124.45 Y120.041 E.04774
G1 X124.842 Y120.101 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3169
G1 X126.875 Y120.101 E.06248
G1 X126.874 Y118.21 E.05812
G1 X132.313 Y118.21 E.16713
G1 X132.312 Y120.101 E.05812
G1 X134.514 Y120.101 E.06763
M73 P41 R12
G1 X134.515 Y118.21 E.05812
G1 X139.79 Y118.21 E.1621
G1 X139.79 Y137.79 E.60164
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X124.841 Y118.21 E.1423
G1 X124.842 Y120.041 E.05627
M204 S10000
G1 X124.102 Y120.175 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3169
G1 X124.101 Y118.95 E.04063
G1 X123.698 Y118.95 E.01338
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X136.497 Y131.482 F30000
G1 F3169
G1 X135.346 Y130.33 E.05401
G1 X128.626 Y137.05 E.31524
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X130.978 Y119.346 E.47042
G1 X130.978 Y118.95 E.01312
G1 X128.626 Y118.95 E.07802
G1 X135.013 Y125.337 E.29963
G1 X136.165 Y124.186 E.05401
G1 X138.378 Y123.846 F30000
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3169
G1 X139.176 Y124.644 E.03467
G1 X139.176 Y125.177
G1 X137.844 Y123.846 E.05785
G1 X137.311 Y123.846
G1 X138.992 Y125.527 E.07308
G1 X138.459 Y125.527
G1 X136.799 Y123.867 E.07212
G1 X136.533 Y124.134
G1 X137.925 Y125.527 E.06053
G1 X137.392 Y125.527
G1 X136.266 Y124.4 E.04894
G1 X135.999 Y124.667
G1 X136.858 Y125.526 E.03735
G1 X136.755 Y125.956
G1 X135.732 Y124.933 E.04444
G1 X135.466 Y125.2
G1 X136.755 Y126.489 E.05602
G1 X136.755 Y127.022
G1 X135.199 Y125.466 E.06761
G1 X135.074 Y125.875
G1 X136.754 Y127.555 E.07301
G1 X136.754 Y128.088
G1 X135.074 Y126.408 E.07301
G1 X135.074 Y126.941
G1 X136.754 Y128.621 E.07301
G1 X136.754 Y129.154
G1 X135.073 Y127.474 E.07301
G1 X135.073 Y128.007
G1 X136.753 Y129.687 E.07301
M204 S10000
G1 X138.474 Y129.808 F30000
M204 S2000
G1 F3169
G1 X139.176 Y130.51 E.03049
G1 X139.176 Y131.043
G1 X137.94 Y129.808 E.05367
G1 X137.407 Y129.808
G1 X139.089 Y131.489 E.07308
G1 X138.555 Y131.489
G1 X136.873 Y129.807 E.07308
M204 S10000
G1 X138.022 Y131.489 F30000
M204 S2000
G1 F3169
G1 X135.073 Y128.54 E.12814
G1 X135.073 Y129.073
G1 X137.488 Y131.489 E.10496
M204 S10000
; WIPE_START
G1 F24000
G1 X136.074 Y130.074 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.2 I1.006 J.684 P1  F30000
G1 X139.154 Y125.546 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.123293
G1 F3169
G1 X139.154 Y125.198 E.00228
; WIPE_START
G1 F24000
G1 X139.154 Y125.546 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.2 I-1.053 J-.611 P1  F30000
G1 X136.748 Y129.693 Z4.2
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.16113
G1 F3169
G1 X136.714 Y129.821 E.00127
G1 X136.74 Y129.847 E.00036
G1 X136.868 Y129.813 E.00127
G1 X137.025 Y131.507 F30000
; LINE_WIDTH: 0.346876
G1 F3169
G1 X135.054 Y129.535 E.06907
G1 X138.904 Y125.972 F30000
M204 S2000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3169
G1 X139.583 Y126.651 E.02949
G1 X139.583 Y127.184
G1 X138.37 Y125.972 E.05267
G1 X137.837 Y125.972
G1 X139.583 Y127.717 E.07586
G1 X139.583 Y128.25
G1 X137.303 Y125.971 E.09904
G1 X137.2 Y126.401
G1 X139.583 Y128.784 E.10355
G1 X139.583 Y129.317
G1 X137.199 Y126.934 E.10356
G1 X137.199 Y127.467
G1 X139.096 Y129.364 E.08243
G1 X138.562 Y129.363
G1 X137.199 Y128 E.05925
G1 X137.199 Y128.533
G1 X138.029 Y129.363 E.03608
M204 S10000
G1 X135.254 Y119.531 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3169
G1 X135.254 Y118.95 E.01926
G1 X136.302 Y118.95 E.03476
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X127.739 Y120.483 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.578618
G1 F3169
G1 X127.738 Y119.133 E.05889
G1 X131.449 Y120.483 F30000
G1 F3169
G1 X131.45 Y119.137 E.05872
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X131.449 Y120.483 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 20/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
G17
G3 Z4.2 I-.002 J-1.217 P1  F30000
G1 X124.561 Y120.494 Z4.2
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2480
G1 X127.386 Y120.494 E.09371
G1 X127.385 Y118.602 E.06275
G1 X131.799 Y118.602 E.14643
G1 X131.798 Y120.494 E.06275
G1 X134.779 Y120.494 E.09887
G1 X134.78 Y118.602 E.06275
G1 X139.398 Y118.602 E.15319
G1 X139.398 Y126.225 E.25288
G1 X137.453 Y126.225 E.06452
G1 X137.452 Y129.11 E.0957
G1 X139.398 Y129.11 E.06456
G1 X139.398 Y137.398 E.27491
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X124.56 Y118.602 E.1313
G1 X124.561 Y120.434 E.06076
G1 X124.953 Y120.102 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2480
G1 X126.994 Y120.102 E.06271
G1 X126.993 Y118.21 E.05812
G1 X132.192 Y118.21 E.15975
G1 X132.191 Y120.102 E.05812
G1 X134.387 Y120.102 E.06749
G1 X134.387 Y119.978 E.00378
G1 X134.392 Y118.21 E.05434
G1 X134.474 Y118.21 E.00252
G1 X139.79 Y118.21 E.16336
G1 X139.79 Y126.618 E.25835
G1 X137.845 Y126.617 E.05977
G1 X137.844 Y128.718 E.06455
G1 X139.79 Y128.719 E.0598
G1 X139.79 Y137.79 E.27874
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X124.882 Y118.21 E.14356
G1 X124.952 Y118.21 E.00215
G1 X124.953 Y120.042 E.05628
M204 S10000
G1 X124.213 Y120.064 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2480
G1 X124.212 Y118.95 E.03695
G1 X123.698 Y118.95 E.01706
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X131.374 Y118.95 E.48898
G1 X128.626 Y118.95 E.09114
G1 X137.104 Y127.428 E.39772
G1 X137.104 Y128.572 E.03795
G1 X128.626 Y137.05 E.39769
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X135.128 Y118.95 E.03895
G1 X135.128 Y119.404 E.01506
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X135.128 Y118.95 E-.17255
G1 X136.302 Y118.95 E-.44621
G1 X136.565 Y119.213 E-.14124
; WIPE_END
M73 P42 R12
G1 E-.04 F1800
; layer num/total_layer_count: 21/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
G17
G3 Z4.4 I-.13 J-1.21 P1  F30000
G1 X124.672 Y120.494 Z4.4
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2573
G1 X127.504 Y120.494 E.09395
G1 X127.504 Y118.602 E.06275
G1 X131.678 Y118.602 E.13846
G1 X131.677 Y120.494 E.06275
G1 X134.653 Y120.494 E.09872
G1 X134.653 Y118.602 E.06275
G1 X139.398 Y118.602 E.15738
G1 X139.398 Y126.223 E.25281
G1 X137.453 Y126.222 E.06451
G1 X137.452 Y129.107 E.0957
G1 X139.398 Y129.108 E.06455
G1 X139.398 Y137.398 E.27498
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X124.671 Y118.602 E.13498
G1 X124.672 Y120.434 E.06076
G1 X125.064 Y120.102 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2573
G1 X127.112 Y120.102 E.06293
G1 X127.111 Y118.21 E.05813
G1 X132.07 Y118.21 E.15236
G1 X132.069 Y120.102 E.05813
G1 X134.261 Y120.102 E.06735
G1 X134.261 Y119.979 E.00378
G1 X134.265 Y118.21 E.05434
G1 X134.347 Y118.21 E.00252
G1 X139.79 Y118.21 E.16725
G1 X139.79 Y126.616 E.25828
G1 X137.845 Y126.615 E.05976
G1 X137.844 Y128.716 E.06455
G1 X139.79 Y128.716 E.05979
G1 X139.79 Y137.79 E.27881
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X124.993 Y118.21 E.14697
G1 X125.063 Y118.21 E.00215
G1 X125.064 Y120.042 E.05628
M204 S10000
; WIPE_START
G1 F24000
G1 X127.063 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.6 I-1.211 J-.124 P1  F30000
G1 X125.326 Y137.05 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2573
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X135.002 Y118.95 E.04315
G1 X135.001 Y120.842 E.06275
G1 X131.328 Y120.842 E.12182
G1 X131.329 Y118.995 E.06127
G1 X120.95 Y129.374 E.48689
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X137.104 Y128.572 E.39771
G1 X137.105 Y127.429 E.03793
G1 X128.626 Y118.95 E.39773
G1 X127.852 Y118.95 E.02569
G1 X127.853 Y120.842 E.06275
G1 X124.324 Y120.842 E.11706
G1 X124.323 Y118.95 E.06275
G1 X123.698 Y118.95 E.02075
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y137.05 E-.61876
G1 X136.565 Y136.787 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 22/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
G17
G3 Z4.6 I.986 J-.713 P1  F30000
G1 X124.783 Y120.494 Z4.6
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2577
G1 X127.623 Y120.494 E.0942
G1 X127.622 Y118.602 E.06276
G1 X131.556 Y118.602 E.13049
G1 X131.555 Y120.494 E.06276
G1 X134.526 Y120.494 E.09856
G1 X134.527 Y118.602 E.06276
G1 X139.398 Y118.602 E.16158
G1 X139.398 Y126.221 E.25274
G1 X137.454 Y126.22 E.0645
G1 X137.452 Y129.105 E.0957
G1 X139.398 Y129.106 E.06454
G1 X139.398 Y137.398 E.27505
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X124.782 Y118.602 E.13866
G1 X124.783 Y120.434 E.06077
G1 X125.175 Y120.102 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2577
G1 X127.231 Y120.102 E.06316
G1 X127.23 Y118.21 E.05813
G1 X131.948 Y118.21 E.14498
G1 X131.947 Y120.102 E.05813
G1 X134.134 Y120.102 E.06721
G1 X134.134 Y119.979 E.00378
G1 X134.139 Y118.21 E.05435
G1 X134.221 Y118.21 E.00252
G1 X139.79 Y118.21 E.17113
G1 X139.79 Y126.613 E.25821
M73 P43 R12
G1 X137.846 Y126.613 E.05975
G1 X137.845 Y128.713 E.06455
G1 X139.79 Y128.714 E.05978
G1 X139.79 Y137.79 E.27887
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.104 Y118.21 E.15038
G1 X125.174 Y118.21 E.00215
G1 X125.175 Y120.042 E.05629
M204 S10000
; WIPE_START
G1 F24000
G1 X127.174 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I-1.21 J-.132 P1  F30000
G1 X125.326 Y137.05 Z4.8
M73 P43 R11
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2577
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.875 Y118.95 E.04734
G1 X134.874 Y120.842 E.06276
G1 X131.206 Y120.842 E.12167
G1 X131.207 Y119.117 E.05723
G1 X120.95 Y129.374 E.48117
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X137.104 Y128.572 E.39772
G1 X137.105 Y127.429 E.03791
G1 X128.626 Y118.95 E.39774
G1 X127.97 Y118.95 E.02176
G1 X127.971 Y120.842 E.06276
G1 X124.435 Y120.842 E.11731
G1 X124.434 Y118.95 E.06276
G1 X123.698 Y118.95 E.02443
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y137.05 E-.61876
G1 X136.565 Y136.787 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 23/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
G17
G3 Z4.8 I.989 J-.709 P1  F30000
G1 X124.894 Y120.494 Z4.8
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2575
G1 X127.741 Y120.494 E.09445
G1 X127.74 Y118.602 E.06276
G1 X131.434 Y118.602 E.12252
G1 X131.433 Y120.494 E.06276
G1 X134.4 Y120.494 E.09841
G1 X134.401 Y118.602 E.06276
G1 X139.398 Y118.602 E.16577
G1 X139.398 Y126.219 E.25267
G1 X137.454 Y126.218 E.06449
G1 X137.453 Y129.103 E.0957
G1 X139.398 Y129.104 E.06453
G1 X139.398 Y137.398 E.27513
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X124.893 Y118.602 E.14235
G1 X124.894 Y120.434 E.06077
G1 X125.286 Y120.102 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2575
G1 X127.349 Y120.102 E.06339
G1 X127.348 Y118.21 E.05814
G1 X131.826 Y118.21 E.13759
G1 X131.825 Y120.102 E.05814
G1 X134.008 Y120.102 E.06706
G1 X134.008 Y119.979 E.00378
G1 X134.012 Y118.21 E.05435
G1 X134.094 Y118.21 E.00252
G1 X139.79 Y118.21 E.17502
G1 X139.79 Y126.611 E.25815
G1 X137.846 Y126.61 E.05974
G1 X137.845 Y128.711 E.06455
G1 X139.79 Y128.712 E.05977
G1 X139.79 Y137.79 E.27894
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.215 Y118.21 E.15379
G1 X125.285 Y118.21 E.00215
G1 X125.286 Y120.042 E.05629
M204 S10000
; WIPE_START
G1 F24000
G1 X127.285 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5 I-1.209 J-.14 P1  F30000
G1 X125.326 Y137.05 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2575
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.749 Y118.95 E.05154
G1 X134.748 Y120.842 E.06276
G1 X131.084 Y120.842 E.12152
G1 X131.085 Y119.239 E.05319
G1 X120.95 Y129.374 E.47545
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X137.105 Y128.571 E.39774
G1 X137.105 Y127.429 E.03789
G1 X128.626 Y118.95 E.39776
G1 X128.089 Y118.95 E.01783
G1 X128.09 Y120.842 E.06276
G1 X124.546 Y120.842 E.11756
G1 X124.545 Y118.95 E.06276
M73 P44 R11
G1 X123.698 Y118.95 E.02811
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 4.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y137.05 E-.61876
G1 X136.565 Y136.787 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 24/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
G17
G3 Z5 I.993 J-.704 P1  F30000
G1 X125.005 Y120.494 Z5
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2529
G1 X127.86 Y120.494 E.0947
G1 X127.859 Y118.602 E.06277
G1 X131.312 Y118.602 E.11454
G1 X131.311 Y120.494 E.06277
G1 X134.273 Y120.494 E.09826
G1 X134.274 Y118.602 E.06277
G1 X139.398 Y118.602 E.16997
G1 X139.398 Y126.217 E.2526
G1 X137.454 Y126.216 E.06448
G1 X137.453 Y129.101 E.0957
G1 X139.398 Y129.102 E.06452
G1 X139.398 Y137.398 E.2752
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.004 Y118.602 E.14603
G1 X125.005 Y120.434 E.06078
G1 X125.397 Y120.102 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2529
G1 X127.468 Y120.102 E.06362
G1 X127.467 Y118.21 E.05814
G1 X131.704 Y118.21 E.13021
G1 X131.703 Y120.102 E.05814
G1 X133.881 Y120.102 E.06692
G1 X133.881 Y119.979 E.00378
G1 X133.886 Y118.21 E.05436
G1 X133.968 Y118.21 E.00252
G1 X139.79 Y118.21 E.1789
G1 X139.79 Y126.609 E.25808
G1 X137.846 Y126.608 E.05973
G1 X137.845 Y128.709 E.06455
G1 X139.79 Y128.71 E.05976
G1 X139.79 Y137.79 E.27901
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.326 Y118.21 E.15721
G1 X125.396 Y118.21 E.00215
G1 X125.397 Y120.042 E.0563
M204 S10000
; WIPE_START
G1 F24000
G1 X127.396 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.2 I.535 J1.093 P1  F30000
G1 X129.746 Y118.95 Z5.2
G1 Z4.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2529
G1 X130.964 Y118.95 E.0404
G1 X130.963 Y119.361 E.01361
G1 X120.95 Y129.374 E.46973
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X137.105 Y128.571 E.39775
G1 X137.105 Y127.429 E.03787
G1 X128.626 Y118.95 E.39777
G1 X128.207 Y118.95 E.0139
G1 X128.208 Y120.843 E.06277
G1 X124.657 Y120.843 E.1178
G1 X124.656 Y118.95 E.06277
G1 X123.698 Y118.95 E.03179
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2529
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 25/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
G17
G3 Z5.2 I-.135 J-1.209 P1  F30000
G1 X125.116 Y120.494 Z5.2
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2523
G1 X127.978 Y120.494 E.09495
G1 X127.977 Y118.602 E.06277
G1 X131.19 Y118.602 E.10657
G1 X131.189 Y120.494 E.06277
G1 X134.147 Y120.494 E.09811
G1 X134.148 Y118.602 E.06277
G1 X139.398 Y118.602 E.17416
G1 X139.398 Y126.215 E.25252
G1 X137.455 Y126.214 E.06447
G1 X137.453 Y129.099 E.0957
G1 X139.398 Y129.1 E.06451
G1 X139.398 Y137.398 E.27527
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.115 Y118.602 E.14971
G1 X125.116 Y120.434 E.06078
G1 X125.508 Y120.102 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2523
G1 X127.586 Y120.102 E.06385
G1 X127.585 Y118.21 E.05815
G1 X131.582 Y118.21 E.12282
G1 X131.581 Y120.102 E.05815
G1 X133.755 Y120.102 E.06678
G1 X133.755 Y119.979 E.00378
G1 X133.759 Y118.21 E.05436
M73 P45 R11
G1 X133.841 Y118.21 E.00252
G1 X139.79 Y118.21 E.18279
G1 X139.79 Y126.607 E.25801
G1 X137.846 Y126.606 E.05972
G1 X137.846 Y128.707 E.06455
G1 X139.79 Y128.708 E.05975
G1 X139.79 Y137.79 E.27907
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.437 Y118.21 E.16062
G1 X125.507 Y118.21 E.00215
G1 X125.508 Y120.042 E.0563
M204 S10000
; WIPE_START
G1 F24000
G1 X127.507 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.4 I.556 J1.083 P1  F30000
G1 X129.746 Y118.95 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2523
G1 X130.842 Y118.95 E.03636
G1 X130.841 Y119.483 E.01766
G1 X120.95 Y129.374 E.46401
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X137.105 Y128.571 E.39776
G1 X137.106 Y127.43 E.03785
G1 X128.626 Y118.95 E.39779
G1 X128.326 Y118.95 E.00997
G1 X128.327 Y120.843 E.06277
G1 X124.768 Y120.843 E.11805
G1 X124.767 Y118.95 E.06277
G1 X123.698 Y118.95 E.03548
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2523
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 5.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 26/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
G17
G3 Z5.4 I-.137 J-1.209 P1  F30000
G1 X125.227 Y120.495 Z5.4
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2521
G1 X128.097 Y120.495 E.09519
G1 X128.096 Y118.602 E.06278
G1 X131.068 Y118.602 E.0986
G1 X131.067 Y120.495 E.06278
G1 X134.02 Y120.495 E.09795
G1 X134.021 Y118.602 E.06278
G1 X139.398 Y118.602 E.17835
G1 X139.398 Y126.213 E.25245
G1 X137.455 Y126.212 E.06445
G1 X137.454 Y129.097 E.0957
G1 X139.398 Y129.097 E.0645
G1 X139.398 Y137.398 E.27534
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.226 Y118.602 E.15339
G1 X125.227 Y120.435 E.06079
G1 X125.619 Y120.103 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2521
G1 X127.705 Y120.103 E.06408
G1 X127.704 Y118.21 E.05815
G1 X131.461 Y118.21 E.11544
G1 X131.46 Y120.103 E.05815
G1 X133.628 Y120.103 E.06664
G1 X133.628 Y119.979 E.00378
G1 X133.633 Y118.21 E.05437
G1 X133.715 Y118.21 E.00252
G1 X139.79 Y118.21 E.18667
G1 X139.79 Y126.605 E.25795
G1 X137.847 Y126.604 E.05971
G1 X137.846 Y128.705 E.06455
G1 X139.79 Y128.706 E.05974
G1 X139.79 Y137.79 E.27914
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.548 Y118.21 E.16403
G1 X125.618 Y118.21 E.00215
G1 X125.619 Y120.043 E.05631
M204 S10000
; WIPE_START
G1 F24000
G1 X127.618 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.6 I.579 J1.071 P1  F30000
G1 X129.746 Y118.95 Z5.6
G1 Z5.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2521
G1 X130.72 Y118.95 E.03232
G1 X130.72 Y119.604 E.0217
G1 X120.95 Y129.374 E.45829
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X137.106 Y128.57 E.39778
G1 X137.106 Y127.43 E.03783
G1 X128.626 Y118.95 E.3978
G1 X128.444 Y118.95 E.00603
G1 X128.445 Y120.843 E.06278
G1 X124.879 Y120.843 E.1183
G1 X124.878 Y118.95 E.06278
G1 X123.698 Y118.95 E.03916
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
M73 P46 R11
G1 F2521
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 5.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 27/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
G17
G3 Z5.6 I-.138 J-1.209 P1  F30000
G1 X125.338 Y120.495 Z5.6
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2520
G1 X128.215 Y120.495 E.09544
G1 X128.214 Y118.602 E.06278
G1 X130.946 Y118.602 E.09063
G1 X130.946 Y120.495 E.06278
G1 X133.894 Y120.495 E.0978
G1 X133.895 Y118.602 E.06278
G1 X139.398 Y118.602 E.18255
G1 X139.398 Y126.21 E.25238
G1 X137.455 Y126.21 E.06444
G1 X137.454 Y129.094 E.0957
G1 X139.398 Y129.095 E.06449
G1 X139.398 Y137.398 E.27541
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.337 Y118.602 E.15708
G1 X125.338 Y120.435 E.06079
G1 X125.73 Y120.103 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2520
G1 X127.823 Y120.103 E.06431
G1 X127.822 Y118.21 E.05816
G1 X131.339 Y118.21 E.10806
G1 X131.338 Y120.103 E.05816
G1 X133.502 Y120.103 E.0665
G1 X133.502 Y119.98 E.00378
G1 X133.506 Y118.21 E.05437
G1 X133.588 Y118.21 E.00252
G1 X139.79 Y118.21 E.19056
G1 X139.79 Y126.603 E.25788
G1 X137.847 Y126.602 E.0597
G1 X137.846 Y128.703 E.06455
G1 X139.79 Y128.703 E.05973
G1 X139.79 Y137.79 E.27921
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.659 Y118.21 E.16744
G1 X125.729 Y118.21 E.00215
G1 X125.73 Y120.043 E.05631
M204 S10000
; WIPE_START
G1 F24000
G1 X127.729 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.8 I.603 J1.057 P1  F30000
G1 X129.746 Y118.95 Z5.8
G1 Z5.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2520
G1 X130.598 Y118.95 E.02827
G1 X130.598 Y119.726 E.02574
G1 X120.95 Y129.374 E.45258
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X137.106 Y128.57 E.39779
G1 X137.106 Y127.43 E.03781
G1 X128.626 Y118.95 E.39782
G1 X128.563 Y118.95 E.0021
G1 X128.564 Y120.843 E.06278
G1 X124.99 Y120.843 E.11855
G1 X124.989 Y118.95 E.06278
G1 X123.698 Y118.95 E.04284
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2520
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 28/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
G17
G3 Z5.8 I-.139 J-1.209 P1  F30000
G1 X125.449 Y120.495 Z5.8
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2518
G1 X128.334 Y120.495 E.09569
G1 X128.333 Y118.602 E.06279
G1 X130.825 Y118.602 E.08266
G1 X130.824 Y120.495 E.06279
G1 X133.767 Y120.495 E.09765
G1 X133.768 Y118.602 E.06279
G1 X139.398 Y118.602 E.18674
G1 X139.398 Y126.208 E.25231
G1 X137.455 Y126.207 E.06443
G1 X137.454 Y129.092 E.0957
G1 X139.398 Y129.093 E.06448
G1 X139.398 Y137.398 E.27549
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.448 Y118.602 E.16076
G1 X125.449 Y120.435 E.0608
G1 X125.841 Y120.103 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2518
G1 X127.942 Y120.103 E.06454
G1 X127.941 Y118.21 E.05816
G1 X131.217 Y118.21 E.10067
G1 X131.216 Y120.103 E.05816
G1 X133.375 Y120.103 E.06635
M73 P47 R11
G1 X133.376 Y119.98 E.00378
G1 X133.38 Y118.21 E.05438
G1 X133.462 Y118.21 E.00252
G1 X139.79 Y118.21 E.19444
G1 X139.79 Y126.6 E.25781
G1 X137.847 Y126.6 E.05969
G1 X137.846 Y128.7 E.06455
G1 X139.79 Y128.701 E.05972
G1 X139.79 Y137.79 E.27927
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.77 Y118.21 E.17085
G1 X125.84 Y118.21 E.00215
G1 X125.841 Y120.043 E.05632
M204 S10000
; WIPE_START
G1 F24000
G1 X127.84 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6 I.629 J1.042 P1  F30000
G1 X129.746 Y118.95 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2518
G1 X130.476 Y118.95 E.02423
G1 X130.476 Y119.848 E.02979
G1 X120.95 Y129.374 E.44686
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X137.106 Y128.57 E.39781
G1 X137.107 Y127.431 E.03779
G1 X128.681 Y119.005 E.39525
G1 X128.682 Y120.843 E.06096
G1 X125.101 Y120.843 E.11879
G1 X125.1 Y118.95 E.06279
G1 X123.698 Y118.95 E.04652
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2518
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 29/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
G17
G3 Z6 I-.141 J-1.209 P1  F30000
G1 X125.56 Y120.495 Z6
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2516
G1 X128.452 Y120.495 E.09594
G1 X128.451 Y118.602 E.0628
G1 X130.703 Y118.602 E.07468
G1 X130.702 Y120.495 E.0628
G1 X133.641 Y120.495 E.09749
G1 X133.642 Y118.602 E.0628
G1 X139.398 Y118.602 E.19094
G1 X139.398 Y126.206 E.25224
G1 X137.456 Y126.205 E.06442
G1 X137.455 Y129.09 E.0957
G1 X139.398 Y129.091 E.06447
G1 X139.398 Y137.398 E.27556
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.559 Y118.602 E.16444
G1 X125.56 Y120.435 E.06081
G1 X125.952 Y120.103 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2516
G1 X128.06 Y120.103 E.06477
G1 X128.059 Y118.21 E.05817
G1 X131.095 Y118.21 E.09329
G1 X131.094 Y120.103 E.05817
G1 X133.249 Y120.103 E.06621
G1 X133.249 Y119.98 E.00378
G1 X133.253 Y118.21 E.05438
G1 X133.335 Y118.21 E.00252
G1 X139.79 Y118.21 E.19833
G1 X139.79 Y126.598 E.25775
G1 X137.848 Y126.597 E.05968
G1 X137.847 Y128.698 E.06455
G1 X139.79 Y128.699 E.05971
G1 X139.79 Y137.79 E.27934
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.881 Y118.21 E.17426
G1 X125.951 Y118.21 E.00215
G1 X125.952 Y120.043 E.05632
M204 S10000
; WIPE_START
G1 F24000
G1 X127.951 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.2 I.656 J1.025 P1  F30000
G1 X129.746 Y118.95 Z6.2
G1 Z5.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2516
G1 X130.354 Y118.95 E.02018
G1 X130.354 Y119.97 E.03383
G1 X120.95 Y129.374 E.44114
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X137.106 Y128.569 E.39782
G1 X137.107 Y127.431 E.03777
G1 X130.519 Y120.843 E.30904
G1 X130.353 Y120.843 E.0055
M73 P47 R10
G1 X130.354 Y120.678 E.0055
G1 X128.8 Y119.124 E.07288
G1 X128.801 Y120.843 E.05704
G1 X125.212 Y120.843 E.11904
G1 X125.211 Y118.95 E.0628
G1 X123.698 Y118.95 E.05021
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
M73 P48 R10
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2516
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 30/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
G17
G3 Z6.2 I-.142 J-1.209 P1  F30000
G1 X125.671 Y120.495 Z6.2
G1 Z6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2550
G1 X128.571 Y120.495 E.09618
G1 X128.57 Y118.602 E.0628
G1 X130.581 Y118.602 E.06671
G1 X130.58 Y120.495 E.0628
G1 X133.514 Y120.495 E.09734
G1 X133.515 Y118.602 E.0628
G1 X139.398 Y118.602 E.19513
G1 X139.398 Y126.204 E.25216
G1 X137.456 Y126.203 E.06441
G1 X137.455 Y129.088 E.0957
G1 X139.398 Y129.089 E.06446
G1 X139.398 Y137.398 E.27563
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.67 Y118.602 E.16813
G1 X125.671 Y120.435 E.06081
G1 X126.063 Y120.103 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2550
G1 X128.179 Y120.103 E.065
G1 X128.178 Y118.21 E.05817
G1 X130.973 Y118.21 E.0859
G1 X130.972 Y120.103 E.05817
G1 X133.123 Y120.103 E.06607
G1 X133.123 Y119.98 E.00378
G1 X133.127 Y118.21 E.05439
G1 X133.209 Y118.21 E.00252
G1 X139.79 Y118.21 E.20222
G1 X139.79 Y126.596 E.25768
G1 X137.848 Y126.595 E.05967
G1 X137.847 Y128.696 E.06455
G1 X139.79 Y128.697 E.0597
G1 X139.79 Y137.79 E.27941
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.992 Y118.21 E.17767
G1 X126.062 Y118.21 E.00215
G1 X126.063 Y120.043 E.05633
M204 S10000
; WIPE_START
G1 F24000
G1 X128.062 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.4 I-1.201 J-.194 P1  F30000
G1 X125.326 Y137.05 Z6.4
G1 Z6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2550
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X133.863 Y118.95 E.0809
G1 X133.862 Y120.844 E.0628
G1 X130.52 Y120.844 E.11089
G1 X137.107 Y127.431 E.30905
G1 X137.107 Y128.569 E.03775
G1 X128.626 Y137.05 E.39784
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X130.232 Y120.092 E.43542
G1 X130.232 Y120.556 E.01538
G1 X128.919 Y119.243 E.06161
G1 X128.919 Y120.844 E.05311
G1 X125.323 Y120.844 E.11929
G1 X125.322 Y118.95 E.0628
G1 X123.698 Y118.95 E.05389
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y137.05 E-.61876
G1 X136.565 Y136.787 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 31/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
G17
G3 Z6.4 I1.015 J-.672 P1  F30000
G1 X125.782 Y120.495 Z6.4
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2505
G1 X128.689 Y120.495 E.09643
G1 X128.688 Y118.602 E.06281
G1 X130.459 Y118.602 E.05874
G1 X130.458 Y120.495 E.06281
G1 X133.388 Y120.495 E.09719
G1 X133.389 Y118.602 E.06281
G1 X139.398 Y118.602 E.19933
G1 X139.398 Y126.202 E.25209
G1 X137.456 Y126.201 E.0644
G1 X137.455 Y129.086 E.0957
G1 X139.398 Y129.087 E.06445
G1 X139.398 Y137.398 E.2757
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.781 Y118.602 E.17181
G1 X125.782 Y120.435 E.06082
G1 X126.174 Y120.103 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2505
G1 X128.297 Y120.103 E.06523
G1 X128.296 Y118.21 E.05818
G1 X130.851 Y118.21 E.07852
G1 X130.85 Y120.103 E.05818
G1 X132.996 Y120.103 E.06593
G1 X132.996 Y119.98 E.00378
M73 P49 R10
G1 X133.001 Y118.21 E.05439
G1 X133.083 Y118.21 E.00252
G1 X139.79 Y118.21 E.2061
G1 X139.79 Y126.594 E.25761
G1 X137.848 Y126.593 E.05966
G1 X137.847 Y128.694 E.06455
G1 X139.79 Y128.695 E.05969
G1 X139.79 Y137.79 E.27947
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.103 Y118.21 E.18108
G1 X126.173 Y118.21 E.00215
G1 X126.174 Y120.043 E.05633
M204 S10000
; WIPE_START
G1 F24000
G1 X128.173 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.6 I.456 J-1.128 P1  F30000
G1 X125.326 Y118.95 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2505
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2505
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X133.737 Y118.95 E.08509
G1 X133.736 Y120.844 E.06281
G1 X130.52 Y120.844 E.10669
G1 X137.108 Y127.432 E.30905
G1 X137.107 Y128.569 E.03772
G1 X128.626 Y137.05 E.39785
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X130.11 Y120.214 E.4297
G1 X130.11 Y120.434 E.0073
G1 X129.037 Y119.361 E.05033
G1 X129.037 Y118.95 E.01362
G1 X130.111 Y118.95 E.03562
G1 X130.111 Y119.094 E.00477
; CHANGE_LAYER
; Z_HEIGHT: 6.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X130.111 Y118.95 E-.05461
G1 X129.037 Y118.95 E-.40807
G1 X129.037 Y119.361 E-.15608
G1 X129.3 Y119.624 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 32/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
G17
G3 Z6.6 I-.302 J-1.179 P1  F30000
G1 X125.893 Y120.496 Z6.6
G1 Z6.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2520
G1 X128.808 Y120.496 E.09668
G1 X128.807 Y118.602 E.06281
G1 X130.337 Y118.602 E.05077
G1 X130.336 Y120.496 E.06281
G1 X133.262 Y120.496 E.09703
G1 X133.262 Y118.602 E.06281
G1 X139.398 Y118.602 E.20352
G1 X139.398 Y126.2 E.25202
G1 X137.457 Y126.199 E.06439
G1 X137.455 Y129.084 E.0957
G1 X139.398 Y129.084 E.06444
G1 X139.398 Y137.398 E.27577
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.892 Y118.602 E.17549
G1 X125.893 Y118.778 E.00585
G1 X125.893 Y120.436 E.05498
G1 X126.285 Y120.104 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2520
G1 X128.416 Y120.104 E.06546
G1 X128.415 Y118.21 E.05818
G1 X130.73 Y118.21 E.07113
G1 X130.729 Y120.104 E.05818
G1 X132.87 Y120.104 E.06579
G1 X132.87 Y119.98 E.00378
G1 X132.874 Y118.21 E.0544
G1 X132.956 Y118.21 E.00252
G1 X139.79 Y118.21 E.20999
G1 X139.79 Y126.592 E.25755
G1 X137.849 Y126.591 E.05965
G1 X137.848 Y128.692 E.06455
G1 X139.79 Y128.693 E.05968
G1 X139.79 Y137.79 E.27954
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.214 Y118.21 E.1845
G1 X126.284 Y118.21 E.00215
G1 X126.285 Y120.044 E.05634
M204 S10000
; WIPE_START
G1 F24000
G1 X128.284 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.8 I.441 J-1.134 P1  F30000
G1 X125.326 Y118.95 Z6.8
G1 Z6.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2520
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.158 Y121.167 E.38502
G1 X130.074 Y121.167 E.03039
G1 X130.378 Y120.844 E.01472
G1 X130.52 Y120.844 E.00469
G1 X137.108 Y127.432 E.30906
G1 X137.107 Y128.569 E.0377
G1 X128.626 Y137.05 E.39787
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
M73 P50 R10
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.8 I-.278 J-1.185 P1  F30000
G1 X129.911 Y120.774 Z6.8
G1 Z6.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419999
G1 F2520
G1 X129.944 Y120.699 E.00253
G1 X129.945 Y118.994 E.05239
G1 X129.199 Y118.994 E.02292
G1 X129.2 Y120.699 E.05239
G1 X129.226 Y120.774 E.00245
G1 X129.851 Y120.774 E.0192
G1 X129.572 Y119.367 F30000
; LINE_WIDTH: 0.411342
G1 F2520
G1 X129.572 Y120.342 E.02928
; CHANGE_LAYER
; Z_HEIGHT: 6.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X129.572 Y119.367 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 33/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
G17
G3 Z6.8 I-.367 J-1.16 P1  F30000
G1 X126.004 Y120.496 Z6.8
G1 Z6.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2506
G1 X128.926 Y120.496 E.09693
G1 X128.925 Y118.602 E.06282
G1 X130.215 Y118.602 E.04279
G1 X130.215 Y120.496 E.06282
G1 X133.135 Y120.496 E.09688
G1 X133.136 Y118.602 E.06282
G1 X139.398 Y118.602 E.20772
G1 X139.398 Y126.197 E.25195
G1 X137.457 Y126.197 E.06438
G1 X137.456 Y129.081 E.0957
G1 X139.398 Y129.082 E.06443
G1 X139.398 Y137.398 E.27584
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.003 Y118.602 E.17917
G1 X126.004 Y118.838 E.00782
G1 X126.004 Y120.436 E.05301
G1 X126.396 Y120.104 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2506
G1 X128.534 Y120.104 E.06569
G1 X128.533 Y118.21 E.05819
G1 X130.608 Y118.21 E.06375
G1 X130.607 Y120.104 E.05819
G1 X132.743 Y120.104 E.06564
G1 X132.743 Y119.981 E.00378
G1 X132.748 Y118.21 E.0544
G1 X132.83 Y118.21 E.00252
G1 X139.79 Y118.21 E.21387
G1 X139.79 Y126.59 E.25748
G1 X137.849 Y126.589 E.05964
G1 X137.848 Y128.69 E.06455
G1 X139.79 Y128.69 E.05967
G1 X139.79 Y137.79 E.27961
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.325 Y118.21 E.18791
G1 X126.395 Y118.21 E.00215
G1 X126.396 Y120.044 E.05634
M204 S10000
; WIPE_START
G1 F24000
G1 X128.395 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7 I.427 J-1.14 P1  F30000
G1 X125.326 Y118.95 Z7
G1 Z6.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2506
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.157 Y121.167 E.38501
G1 X130.074 Y121.166 E.0304
G1 X130.378 Y120.845 E.0147
G1 X130.521 Y120.845 E.00472
G1 X137.108 Y127.432 E.30903
G1 X137.108 Y128.568 E.03768
G1 X128.626 Y137.05 E.39788
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7 I-.269 J-1.187 P1  F30000
G1 X129.814 Y120.743 Z7
G1 Z6.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.483789
G1 F2506
G1 X129.791 Y120.523 E.00795
G1 X129.791 Y119.026 E.05376
G1 X129.35 Y119.026 E.01586
G1 X129.35 Y120.523 E.05376
G1 X129.326 Y120.743 E.00796
G1 X129.754 Y120.743 E.01535
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X129.326 Y120.743 E-.16231
G1 X129.35 Y120.523 E-.08417
G1 X129.35 Y119.171 E-.51352
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 34/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
G17
G3 Z7 I-.461 J-1.126 P1  F30000
G1 X126.115 Y120.496 Z7
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2489
G1 X129.045 Y120.496 E.09718
G1 X129.044 Y118.602 E.06282
G1 X130.094 Y118.602 E.03482
G1 X130.093 Y120.496 E.06282
G1 X133.009 Y120.496 E.09673
G1 X133.01 Y118.602 E.06282
G1 X139.398 Y118.602 E.21191
G1 X139.398 Y126.195 E.25188
M73 P51 R10
G1 X137.457 Y126.194 E.06437
G1 X137.456 Y129.079 E.0957
G1 X139.398 Y129.08 E.06442
G1 X139.398 Y137.398 E.27592
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.114 Y118.602 E.18286
G1 X126.115 Y118.897 E.00979
G1 X126.115 Y120.436 E.05105
G1 X126.507 Y120.104 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2489
G1 X128.653 Y120.104 E.06592
G1 X128.652 Y118.21 E.05819
G1 X130.486 Y118.21 E.05636
G1 X130.485 Y120.104 E.05819
G1 X132.617 Y120.104 E.0655
G1 X132.617 Y119.981 E.00378
G1 X132.621 Y118.21 E.05441
G1 X132.703 Y118.21 E.00252
G1 X139.79 Y118.21 E.21776
G1 X139.79 Y126.587 E.25741
G1 X137.849 Y126.587 E.05963
G1 X137.848 Y128.687 E.06455
G1 X139.79 Y128.688 E.05966
G1 X139.79 Y137.79 E.27967
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.436 Y118.21 E.19132
G1 X126.506 Y118.21 E.00215
G1 X126.507 Y120.044 E.05635
M204 S10000
; WIPE_START
G1 F24000
G1 X128.506 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.2 I.414 J-1.145 P1  F30000
G1 X125.326 Y118.95 Z7.2
G1 Z6.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2489
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.276 Y121.048 E.39059
G1 X130.26 Y121.048 E.03262
G1 X130.26 Y120.844 E.00675
G1 X130.52 Y120.844 E.00864
G1 X137.109 Y127.433 E.30907
G1 X137.108 Y128.568 E.03766
G1 X128.626 Y137.05 E.39789
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.2 I.071 J-1.215 P1  F30000
G1 X129.569 Y118.806 Z7.2
G1 Z6.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.68509
G1 F2489
G1 X129.569 Y120.699 E.0991
; CHANGE_LAYER
; Z_HEIGHT: 7
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X129.569 Y118.806 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 35/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
G17
G3 Z7.2 I-.549 J-1.086 P1  F30000
G1 X126.226 Y120.496 Z7.2
G1 Z7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2489
G1 X129.163 Y120.496 E.09742
G1 X129.162 Y118.602 E.06283
G1 X129.972 Y118.602 E.02685
G1 X129.971 Y120.496 E.06283
G1 X132.882 Y120.496 E.09657
G1 X132.883 Y118.602 E.06283
G1 X139.398 Y118.602 E.21611
G1 X139.398 Y126.193 E.25181
G1 X137.458 Y126.192 E.06436
G1 X137.456 Y129.077 E.0957
G1 X139.398 Y129.078 E.06441
G1 X139.398 Y137.398 E.27599
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.226 Y118.602 E.18654
G1 X126.226 Y118.957 E.01176
G1 X126.226 Y120.436 E.04908
G1 X126.618 Y120.104 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2489
G1 X128.771 Y120.104 E.06615
G1 X128.77 Y118.21 E.0582
G1 X130.364 Y118.21 E.04898
G1 X130.363 Y120.104 E.0582
G1 X132.49 Y120.104 E.06536
G1 X132.49 Y119.981 E.00378
G1 X132.495 Y118.21 E.05441
G1 X132.577 Y118.21 E.00252
G1 X139.79 Y118.21 E.22164
G1 X139.79 Y126.585 E.25735
G1 X137.85 Y126.584 E.05962
G1 X137.849 Y128.685 E.06455
G1 X139.79 Y128.686 E.05965
G1 X139.79 Y137.79 E.27974
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.547 Y118.21 E.19473
G1 X126.617 Y118.21 E.00215
G1 X126.618 Y120.044 E.05635
M204 S10000
; WIPE_START
G1 F24000
G1 X128.617 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.4 I.401 J-1.149 P1  F30000
G1 X125.326 Y118.95 Z7.4
G1 Z7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2489
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.276 Y121.048 E.39058
G1 X130.138 Y121.048 E.02858
G1 X130.138 Y120.844 E.00675
G1 X130.52 Y120.844 E.01269
G1 X137.109 Y127.433 E.30908
G1 X137.108 Y128.568 E.03764
G1 X128.626 Y137.05 E.39791
G1 X123.698 Y137.05 E.16349
M73 P52 R10
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.4 I.071 J-1.215 P1  F30000
G1 X129.567 Y118.806 Z7.4
G1 Z7
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.444884
G1 F2489
G1 X129.567 Y120.7 E.06204
; CHANGE_LAYER
; Z_HEIGHT: 7.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X129.567 Y118.806 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 36/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
G17
G3 Z7.4 I-.564 J-1.078 P1  F30000
G1 X126.337 Y120.496 Z7.4
G1 Z7.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2489
G1 X129.282 Y120.496 E.09767
G1 X129.281 Y118.602 E.06283
G1 X129.85 Y118.602 E.01888
G1 X129.849 Y120.496 E.06283
G1 X132.756 Y120.496 E.09642
G1 X132.757 Y118.602 E.06283
G1 X139.398 Y118.602 E.2203
G1 X139.398 Y126.191 E.25173
G1 X137.458 Y126.19 E.06435
G1 X137.457 Y129.075 E.0957
G1 X139.398 Y129.076 E.06439
G1 X139.398 Y137.398 E.27606
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.337 Y118.602 E.19022
G1 X126.337 Y119.016 E.01373
G1 X126.337 Y120.436 E.04712
G1 X126.729 Y120.104 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2489
G1 X128.89 Y120.104 E.06638
G1 X128.889 Y118.21 E.0582
G1 X130.242 Y118.21 E.04159
G1 X130.241 Y120.104 E.0582
G1 X132.364 Y120.104 E.06522
G1 X132.364 Y119.981 E.00378
G1 X132.368 Y118.21 E.05442
G1 X132.45 Y118.21 E.00252
G1 X139.79 Y118.21 E.22553
G1 X139.79 Y126.583 E.25728
G1 X137.85 Y126.582 E.05962
G1 X137.849 Y128.683 E.06455
G1 X139.79 Y128.684 E.05964
G1 X139.79 Y137.79 E.27981
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.658 Y118.21 E.19814
G1 X126.728 Y118.21 E.00215
G1 X126.729 Y120.044 E.05636
M204 S10000
; WIPE_START
G1 F24000
G1 X128.729 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.6 I.389 J-1.153 P1  F30000
G1 X125.326 Y118.95 Z7.6
G1 Z7.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2489
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.276 Y121.048 E.39057
G1 X130.016 Y121.048 E.02455
G1 X130.016 Y120.845 E.00675
M73 P52 R9
G1 X130.521 Y120.845 E.01673
G1 X137.109 Y127.433 E.30909
G1 X137.109 Y128.567 E.03762
G1 X128.626 Y137.05 E.39792
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.6 I.071 J-1.215 P1  F30000
G1 X129.565 Y118.806 Z7.6
G1 Z7.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.20468
G1 F2489
G1 X129.565 Y120.7 E.02497
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X129.565 Y118.806 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 37/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
G17
G3 Z7.6 I-.58 J-1.07 P1  F30000
G1 X126.448 Y120.496 Z7.6
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2448
G1 X129.4 Y120.496 E.09792
G1 X129.399 Y118.602 E.06284
G1 X129.728 Y118.602 E.01091
G1 X129.727 Y120.496 E.06284
G1 X132.629 Y120.496 E.09627
G1 X132.63 Y118.602 E.06284
G1 X139.398 Y118.602 E.2245
G1 X139.398 Y126.189 E.25166
G1 X137.458 Y126.188 E.06434
G1 X137.457 Y129.073 E.0957
G1 X139.398 Y129.074 E.06438
G1 X139.398 Y137.398 E.27613
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.448 Y118.602 E.19391
M73 P53 R9
G1 X126.448 Y119.075 E.0157
G1 X126.448 Y120.436 E.04515
G1 X126.84 Y120.104 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2448
G1 X129.008 Y120.104 E.06661
G1 X129.007 Y118.21 E.05821
G1 X130.12 Y118.21 E.03421
G1 X130.119 Y120.104 E.05821
G1 X132.237 Y120.104 E.06508
G1 X132.237 Y119.981 E.00378
G1 X132.242 Y118.21 E.05442
G1 X132.324 Y118.21 E.00252
G1 X139.79 Y118.21 E.22942
G1 X139.79 Y126.581 E.25722
G1 X137.85 Y126.58 E.05961
G1 X137.849 Y128.681 E.06455
G1 X139.79 Y128.682 E.05963
G1 X139.79 Y137.79 E.27987
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.769 Y118.21 E.20155
G1 X126.839 Y118.21 E.00215
G1 X126.84 Y120.044 E.05636
M204 S10000
; WIPE_START
G1 F24000
G1 X128.84 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.8 I.378 J-1.157 P1  F30000
G1 X125.326 Y118.95 Z7.8
G1 Z7.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2448
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.479 Y120.845 E.40011
G1 X130.521 Y120.845 E.03454
G1 X137.109 Y127.433 E.30909
G1 X137.109 Y128.567 E.0376
G1 X128.626 Y137.05 E.39794
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 7.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 38/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
G17
G3 Z7.8 I-.155 J-1.207 P1  F30000
G1 X126.559 Y120.497 Z7.8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2464
G1 X132.503 Y120.497 E.19715
G1 X132.504 Y118.602 E.06285
G1 X139.398 Y118.602 E.22869
G1 X139.398 Y126.187 E.25159
G1 X137.459 Y126.186 E.06433
G1 X137.457 Y129.071 E.0957
G1 X139.398 Y129.071 E.06437
G1 X139.398 Y137.398 E.2762
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.559 Y118.602 E.19759
G1 X126.559 Y119.135 E.01767
G1 X126.559 Y120.437 E.04319
G1 X126.951 Y120.105 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2464
G1 X129.127 Y120.105 E.06684
G1 X129.126 Y118.21 E.05821
G1 X129.999 Y118.21 E.02683
G1 X129.998 Y120.105 E.05821
G1 X132.111 Y120.105 E.06493
G1 X132.111 Y119.981 E.00378
G1 X132.115 Y118.21 E.05443
G1 X132.197 Y118.21 E.00252
G1 X139.79 Y118.21 E.2333
G1 X139.79 Y126.579 E.25715
G1 X137.85 Y126.578 E.0596
G1 X137.85 Y128.679 E.06455
G1 X139.79 Y128.68 E.05962
G1 X139.79 Y137.79 E.27994
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.88 Y118.21 E.20496
G1 X126.95 Y118.21 E.00215
G1 X126.951 Y120.045 E.05637
M204 S10000
; WIPE_START
G1 F24000
G1 X128.951 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8 I.368 J-1.16 P1  F30000
G1 X125.326 Y118.95 Z8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2464
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.479 Y120.845 E.4001
G1 X130.521 Y120.845 E.03455
G1 X137.11 Y127.434 E.3091
G1 X137.109 Y128.567 E.03758
G1 X128.626 Y137.05 E.39795
M73 P54 R9
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8 I.139 J-1.209 P1  F30000
G1 X129.562 Y118.406 Z8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.523427
G1 F2464
G1 X129.562 Y120.301 E.07418
; CHANGE_LAYER
; Z_HEIGHT: 7.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X129.562 Y118.406 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 39/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
G17
G3 Z8 I-.713 J-.986 P1  F30000
G1 X126.67 Y120.497 Z8
G1 Z7.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2460
G1 X132.376 Y120.497 E.18927
G1 X132.377 Y118.602 E.06285
G1 X139.398 Y118.602 E.23289
G1 X139.398 Y126.184 E.25152
G1 X137.459 Y126.184 E.06432
G1 X137.458 Y129.068 E.0957
G1 X139.398 Y129.069 E.06436
G1 X139.398 Y137.398 E.27628
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.67 Y118.602 E.20127
G1 X126.67 Y119.194 E.01964
G1 X126.67 Y120.437 E.04122
G1 X127.062 Y120.105 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2460
G1 X129.245 Y120.105 E.06707
G1 X129.244 Y118.21 E.05822
G1 X129.877 Y118.21 E.01944
G1 X129.876 Y120.105 E.05822
G1 X131.984 Y120.105 E.06479
G1 X131.985 Y119.982 E.00378
G1 X131.989 Y118.21 E.05443
G1 X132.071 Y118.21 E.00252
G1 X139.79 Y118.21 E.23719
G1 X139.79 Y126.577 E.25708
G1 X137.851 Y126.576 E.05959
G1 X137.85 Y128.677 E.06455
G1 X139.79 Y128.677 E.05962
G1 X139.79 Y137.79 E.28001
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.991 Y118.21 E.20838
G1 X127.061 Y118.21 E.00215
G1 X127.062 Y120.045 E.05638
M204 S10000
; WIPE_START
G1 F24000
G1 X129.062 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.2 I.358 J-1.163 P1  F30000
G1 X125.326 Y118.95 Z8.2
G1 Z7.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2460
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.479 Y120.845 E.4001
G1 X130.521 Y120.845 E.03457
G1 X137.11 Y127.434 E.30911
G1 X137.11 Y128.566 E.03756
G1 X128.626 Y137.05 E.39797
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.2 I.139 J-1.209 P1  F30000
G1 X129.56 Y118.406 Z8.2
G1 Z7.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.283222
G1 F2460
G1 X129.56 Y120.301 E.0371
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X129.56 Y118.406 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 40/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
G17
G3 Z8.2 I-.732 J-.972 P1  F30000
G1 X126.781 Y120.497 Z8.2
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2419
G1 X132.25 Y120.497 E.1814
G1 X132.251 Y118.602 E.06286
G1 X139.398 Y118.602 E.23708
G1 X139.398 Y126.182 E.25145
G1 X137.459 Y126.181 E.06431
G1 X137.458 Y129.066 E.0957
G1 X139.398 Y129.067 E.06435
G1 X139.398 Y137.398 E.27635
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.781 Y118.602 E.20495
G1 X126.781 Y119.254 E.02161
G1 X126.781 Y120.437 E.03925
G1 X127.173 Y120.105 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2419
M73 P55 R9
G1 X129.363 Y120.105 E.0673
G1 X129.363 Y118.21 E.05822
G1 X129.755 Y118.21 E.01206
G1 X129.754 Y120.105 E.05822
G1 X131.858 Y120.105 E.06465
G1 X131.858 Y119.982 E.00378
G1 X131.862 Y118.21 E.05444
G1 X131.944 Y118.21 E.00252
G1 X139.79 Y118.21 E.24107
G1 X139.79 Y126.574 E.25702
G1 X137.851 Y126.574 E.05958
G1 X137.85 Y128.674 E.06455
G1 X139.79 Y128.675 E.05961
G1 X139.79 Y137.79 E.28007
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.102 Y118.21 E.21179
G1 X127.173 Y118.21 E.00215
G1 X127.173 Y120.045 E.05638
M204 S10000
; WIPE_START
G1 F24000
G1 X129.173 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.4 I.348 J-1.166 P1  F30000
G1 X125.326 Y118.95 Z8.4
G1 Z8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2419
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.479 Y120.845 E.40009
G1 X130.521 Y120.845 E.03458
G1 X137.11 Y127.434 E.30911
G1 X137.11 Y128.566 E.03754
G1 X128.626 Y137.05 E.39798
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 8.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 41/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
G17
G3 Z8.4 I-.16 J-1.206 P1  F30000
G1 X126.893 Y120.497 Z8.4
G1 Z8.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2423
G1 X132.123 Y120.497 E.17352
G1 X132.124 Y118.602 E.06286
G1 X139.398 Y118.602 E.24128
G1 X139.398 Y126.18 E.25137
G1 X137.459 Y126.179 E.0643
G1 X137.458 Y129.064 E.0957
G1 X139.398 Y129.065 E.06434
G1 X139.398 Y137.398 E.27642
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.892 Y118.602 E.20864
G1 X126.892 Y119.313 E.02358
G1 X126.892 Y120.437 E.03729
G1 X127.284 Y120.105 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2423
G1 X129.482 Y120.105 E.06753
G1 X129.481 Y118.21 E.05823
G1 X129.633 Y118.21 E.00467
G1 X129.632 Y120.105 E.05823
G1 X131.732 Y120.105 E.06451
G1 X131.732 Y119.982 E.00378
G1 X131.736 Y118.21 E.05444
G1 X131.818 Y118.21 E.00252
G1 X139.79 Y118.21 E.24496
G1 X139.79 Y126.572 E.25695
G1 X137.851 Y126.571 E.05957
G1 X137.85 Y128.672 E.06455
G1 X139.79 Y128.673 E.0596
G1 X139.79 Y137.79 E.28014
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.214 Y118.21 E.2152
G1 X127.284 Y118.21 E.00215
G1 X127.284 Y120.045 E.05639
M204 S10000
; WIPE_START
G1 F24000
G1 X129.284 Y120.1 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.6 I.339 J-1.169 P1  F30000
G1 X125.326 Y118.95 Z8.6
G1 Z8.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2423
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.479 Y120.845 E.40008
G1 X130.521 Y120.845 E.03459
G1 X137.111 Y127.435 E.30912
G1 X137.11 Y128.566 E.03752
M73 P56 R9
G1 X128.626 Y137.05 E.398
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 8.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 42/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
G17
G3 Z8.6 I-.162 J-1.206 P1  F30000
G1 X127.004 Y120.497 Z8.6
G1 Z8.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2394
G1 X131.997 Y120.497 E.16564
G1 X131.998 Y118.602 E.06287
G1 X139.398 Y118.602 E.24547
G1 X139.398 Y126.178 E.2513
G1 X137.46 Y126.177 E.06429
G1 X137.459 Y129.062 E.0957
G1 X139.398 Y129.063 E.06433
G1 X139.398 Y137.398 E.27649
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.003 Y118.602 E.21232
G1 X127.003 Y119.372 E.02555
G1 X127.004 Y120.437 E.03532
G1 X127.395 Y120.105 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2394
G1 X131.605 Y120.105 E.12935
G1 X131.605 Y119.982 E.00378
G1 X131.61 Y118.21 E.05445
G1 X131.692 Y118.21 E.00252
G1 X139.79 Y118.21 E.24884
G1 X139.79 Y126.57 E.25688
G1 X137.852 Y126.569 E.05956
G1 X137.851 Y128.67 E.06455
G1 X139.79 Y128.671 E.05959
G1 X139.79 Y137.79 E.2802
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.325 Y118.21 E.21861
G1 X127.395 Y118.21 E.00215
G1 X127.395 Y120.045 E.05639
M204 S10000
; WIPE_START
G1 F24000
G1 X129.395 Y120.074 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.8 I.324 J-1.173 P1  F30000
G1 X125.326 Y118.95 Z8.8
G1 Z8.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2394
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.478 Y120.846 E.40007
G1 X130.522 Y120.846 E.0346
G1 X137.111 Y127.435 E.30913
G1 X137.11 Y128.565 E.0375
G1 X128.626 Y137.05 E.39801
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 43/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
G17
G3 Z8.8 I-.164 J-1.206 P1  F30000
G1 X127.115 Y120.497 Z8.8
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2394
G1 X131.871 Y120.497 E.15776
G1 X131.871 Y118.602 E.06287
G1 X139.398 Y118.602 E.24967
G1 X139.398 Y126.176 E.25123
G1 X137.46 Y126.175 E.06428
G1 X137.459 Y129.06 E.0957
G1 X139.398 Y129.061 E.06432
G1 X139.398 Y137.398 E.27656
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.114 Y118.602 E.216
G1 X127.114 Y119.432 E.02752
G1 X127.115 Y120.437 E.03336
G1 X127.506 Y120.105 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2394
G1 X131.479 Y120.105 E.12205
G1 X131.479 Y119.982 E.00378
G1 X131.483 Y118.21 E.05445
G1 X131.565 Y118.21 E.00252
M73 P57 R9
G1 X139.79 Y118.21 E.25273
G1 X139.79 Y126.568 E.25682
G1 X137.852 Y126.567 E.05955
G1 X137.851 Y128.668 E.06455
G1 X139.79 Y128.669 E.05958
G1 X139.79 Y137.79 E.28027
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.436 Y118.21 E.22202
G1 X127.506 Y118.21 E.00215
G1 X127.506 Y120.045 E.0564
M204 S10000
; WIPE_START
G1 F24000
G1 X129.506 Y120.076 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9 I.316 J-1.175 P1  F30000
G1 X125.326 Y118.95 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2394
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.478 Y120.846 E.40007
G1 X130.522 Y120.846 E.03461
G1 X137.111 Y127.435 E.30913
G1 X137.111 Y128.565 E.03748
G1 X128.626 Y137.05 E.39802
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 8.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
M73 P57 R8
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 44/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
G17
G3 Z9 I-.166 J-1.206 P1  F30000
G1 X127.226 Y120.498 Z9
G1 Z8.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2394
G1 X131.744 Y120.498 E.14989
G1 X131.745 Y118.602 E.06288
G1 X139.398 Y118.602 E.25386
G1 X139.398 Y126.174 E.25116
G1 X137.46 Y126.173 E.06427
G1 X137.459 Y129.058 E.0957
G1 X139.398 Y129.058 E.06431
G1 X139.398 Y137.398 E.27663
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.225 Y118.602 E.21968
G1 X127.225 Y119.491 E.02949
G1 X127.226 Y120.438 E.03139
G1 X127.617 Y120.106 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2394
G1 X131.352 Y120.106 E.11476
G1 X131.352 Y119.982 E.00378
G1 X131.357 Y118.21 E.05446
G1 X131.439 Y118.21 E.00252
G1 X139.79 Y118.21 E.25661
G1 X139.79 Y126.566 E.25675
G1 X137.852 Y126.565 E.05954
G1 X137.851 Y128.666 E.06455
G1 X139.79 Y128.667 E.05957
G1 X139.79 Y137.79 E.28034
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.547 Y118.21 E.22543
G1 X127.617 Y118.21 E.00215
G1 X127.617 Y120.046 E.0564
M204 S10000
; WIPE_START
G1 F24000
G1 X129.617 Y120.078 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.2 I.309 J-1.177 P1  F30000
G1 X125.326 Y118.95 Z9.2
G1 Z8.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2394
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.478 Y120.846 E.40006
G1 X130.522 Y120.846 E.03462
G1 X137.112 Y127.436 E.30914
G1 X137.111 Y128.565 E.03746
G1 X128.626 Y137.05 E.39804
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
M73 P58 R8
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 45/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
G17
G3 Z9.2 I-.168 J-1.205 P1  F30000
G1 X127.337 Y120.498 Z9.2
G1 Z9
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2394
G1 X131.618 Y120.498 E.14201
G1 X131.619 Y118.602 E.06288
G1 X139.398 Y118.602 E.25805
G1 X139.398 Y126.171 E.25109
G1 X137.461 Y126.171 E.06426
G1 X137.459 Y129.055 E.0957
G1 X139.398 Y129.056 E.0643
G1 X139.398 Y137.398 E.27671
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.336 Y118.602 E.22337
G1 X127.336 Y119.551 E.03146
G1 X127.337 Y120.438 E.02943
G1 X127.728 Y120.106 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2394
G1 X131.226 Y120.106 E.10746
G1 X131.226 Y119.983 E.00378
G1 X131.23 Y118.21 E.05447
G1 X131.312 Y118.21 E.00252
G1 X139.79 Y118.21 E.2605
G1 X139.79 Y126.564 E.25668
G1 X137.853 Y126.563 E.05953
G1 X137.852 Y128.664 E.06455
G1 X139.79 Y128.664 E.05956
G1 X139.79 Y137.79 E.2804
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.658 Y118.21 E.22884
G1 X127.728 Y118.21 E.00215
G1 X127.728 Y120.046 E.05641
M204 S10000
; WIPE_START
G1 F24000
G1 X129.728 Y120.08 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.4 I.302 J-1.179 P1  F30000
G1 X125.326 Y118.95 Z9.4
G1 Z9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2394
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.478 Y120.846 E.40005
G1 X130.522 Y120.846 E.03463
G1 X137.112 Y127.436 E.30915
G1 X137.111 Y128.565 E.03744
G1 X128.626 Y137.05 E.39805
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 9.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 46/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
G17
G3 Z9.4 I-.17 J-1.205 P1  F30000
G1 X127.448 Y120.498 Z9.4
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2394
G1 X131.491 Y120.498 E.13413
G1 X131.492 Y118.602 E.06289
G1 X139.398 Y118.602 E.26225
G1 X139.398 Y126.169 E.25102
G1 X137.461 Y126.168 E.06425
G1 X137.46 Y129.053 E.0957
G1 X139.398 Y129.054 E.06429
G1 X139.398 Y137.398 E.27678
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.447 Y118.602 E.22705
G1 X127.447 Y119.61 E.03344
G1 X127.448 Y120.438 E.02746
G1 X127.84 Y120.106 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2394
G1 X131.099 Y120.106 E.10016
G1 X131.099 Y119.983 E.00378
G1 X131.104 Y118.21 E.05447
G1 X131.186 Y118.21 E.00252
G1 X139.79 Y118.21 E.26439
G1 X139.79 Y126.561 E.25662
M73 P59 R8
G1 X137.853 Y126.561 E.05952
G1 X137.852 Y128.661 E.06455
G1 X139.79 Y128.662 E.05955
G1 X139.79 Y137.79 E.28047
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.769 Y118.21 E.23226
G1 X127.839 Y118.21 E.00215
G1 X127.839 Y120.046 E.05641
M204 S10000
; WIPE_START
G1 F24000
G1 X129.839 Y120.083 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.6 I.296 J-1.18 P1  F30000
G1 X125.326 Y118.95 Z9.6
G1 Z9.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2394
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.478 Y120.846 E.40004
G1 X130.522 Y120.846 E.03464
G1 X137.112 Y127.436 E.30915
G1 X137.112 Y128.564 E.03742
G1 X128.626 Y137.05 E.39807
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 9.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 47/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
G17
G3 Z9.6 I-.172 J-1.205 P1  F30000
G1 X127.559 Y120.498 Z9.6
G1 Z9.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2394
G1 X131.365 Y120.498 E.12625
G1 X131.366 Y118.602 E.06289
G1 X139.398 Y118.602 E.26644
G1 X139.398 Y126.116 E.24924
G1 X137.461 Y126.117 E.06424
G1 X137.46 Y129.089 E.09861
G1 X139.398 Y129.092 E.06428
G1 X139.398 Y137.398 E.27552
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.558 Y118.602 E.23073
G1 X127.558 Y119.669 E.03541
G1 X127.559 Y120.438 E.0255
G1 X127.951 Y120.106 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2394
G1 X130.973 Y120.106 E.09287
G1 X130.973 Y119.983 E.00378
G1 X130.977 Y118.21 E.05448
G1 X131.059 Y118.21 E.00252
G1 X139.79 Y118.21 E.26827
G1 X139.79 Y126.508 E.25496
G1 X137.853 Y126.508 E.05951
G1 X137.852 Y128.698 E.06727
G1 X139.79 Y128.7 E.05954
G1 X139.79 Y137.79 E.2793
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.88 Y118.21 E.23567
G1 X127.95 Y118.21 E.00215
G1 X127.951 Y120.046 E.05642
M204 S10000
; WIPE_START
G1 F24000
G1 X129.95 Y120.086 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.8 I.29 J-1.182 P1  F30000
G1 X125.326 Y118.95 Z9.8
G1 Z9.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2394
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.478 Y120.846 E.40003
G1 X130.522 Y120.846 E.03465
G1 X137.113 Y127.437 E.30916
G1 X137.112 Y128.564 E.0374
G1 X128.626 Y137.05 E.39808
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
M73 P60 R8
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 9.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 48/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
G17
G3 Z9.8 I-.174 J-1.204 P1  F30000
G1 X127.67 Y120.498 Z9.8
G1 Z9.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2394
G1 X131.238 Y120.498 E.11838
G1 X131.239 Y118.602 E.0629
G1 X139.398 Y118.602 E.27064
G1 X139.398 Y125.996 E.24527
G1 X137.462 Y125.997 E.06423
G1 X137.46 Y129.203 E.10634
G1 X139.398 Y129.205 E.06427
G1 X139.398 Y137.398 E.27176
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.669 Y118.602 E.23442
G1 X127.669 Y119.729 E.03738
G1 X127.67 Y120.438 E.02353
G1 X128.062 Y120.106 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2394
G1 X130.846 Y120.106 E.08557
G1 X130.846 Y119.983 E.00378
G1 X130.851 Y118.21 E.05448
G1 X130.933 Y118.21 E.00252
G1 X139.79 Y118.21 E.27216
G1 X139.79 Y126.388 E.25129
G1 X137.854 Y126.389 E.0595
G1 X137.853 Y128.811 E.07443
G1 X139.79 Y128.814 E.05953
G1 X139.79 Y137.79 E.27582
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.991 Y118.21 E.23908
G1 X128.061 Y118.21 E.00215
G1 X128.062 Y120.046 E.05642
M204 S10000
; WIPE_START
G1 F24000
G1 X130.061 Y120.089 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10 I.285 J-1.183 P1  F30000
G1 X125.326 Y118.95 Z10
G1 Z9.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2394
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.477 Y120.847 E.40003
G1 X130.523 Y120.847 E.03466
G1 X137.113 Y127.437 E.30917
G1 X137.112 Y128.564 E.03738
G1 X128.626 Y137.05 E.3981
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 9.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 49/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
G17
G3 Z10 I-.176 J-1.204 P1  F30000
G1 X127.781 Y120.498 Z10
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2394
G1 X131.112 Y120.498 E.1105
G1 X131.113 Y118.602 E.06291
G1 X139.398 Y118.602 E.27483
G1 X139.398 Y125.876 E.2413
G1 X137.462 Y125.877 E.06422
G1 X137.461 Y129.316 E.11407
G1 X139.398 Y129.319 E.06427
G1 X139.398 Y137.398 E.26801
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.78 Y118.602 E.2381
G1 X127.78 Y119.788 E.03935
G1 X127.781 Y120.438 E.02157
G1 X128.173 Y120.106 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2394
G1 X130.72 Y120.106 E.07827
G1 X130.72 Y119.983 E.00378
G1 X130.724 Y118.21 E.05449
G1 X130.806 Y118.21 E.00252
G1 X139.79 Y118.21 E.27604
G1 X139.79 Y126.268 E.24761
G1 X137.854 Y126.269 E.05949
G1 X137.853 Y128.924 E.08159
G1 X139.79 Y128.927 E.05952
M73 P61 R8
G1 X139.79 Y137.79 E.27233
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X128.102 Y118.21 E.24249
G1 X128.172 Y118.21 E.00215
G1 X128.173 Y120.046 E.05643
M204 S10000
; WIPE_START
G1 F24000
G1 X130.172 Y120.093 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.2 I.279 J-1.184 P1  F30000
G1 X125.326 Y118.95 Z10.2
G1 Z9.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2394
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.477 Y120.847 E.40002
G1 X130.523 Y120.847 E.03468
G1 X137.113 Y127.437 E.30917
G1 X137.113 Y128.563 E.03736
G1 X128.626 Y137.05 E.39811
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 10
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 50/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
G17
G3 Z10.2 I-.178 J-1.204 P1  F30000
G1 X127.892 Y120.498 Z10.2
G1 Z10
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2430
G1 X130.985 Y120.499 E.10262
G1 X130.986 Y118.602 E.06291
G1 X139.398 Y118.602 E.27903
G1 X139.398 Y125.757 E.23734
G1 X137.462 Y125.758 E.0642
G1 X137.461 Y129.429 E.12179
G1 X139.398 Y129.432 E.06426
G1 X139.398 Y137.398 E.26425
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.891 Y118.602 E.24178
G1 X127.892 Y120.438 E.06091
G1 X128.284 Y120.106 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2430
G1 X130.593 Y120.107 E.07098
G1 X130.594 Y119.983 E.00379
G1 X130.598 Y118.21 E.05449
G1 X130.68 Y118.21 E.00252
G1 X139.79 Y118.21 E.27993
G1 X139.79 Y126.149 E.24394
G1 X137.854 Y126.15 E.05948
G1 X137.853 Y129.038 E.08874
G1 X139.79 Y129.04 E.05952
G1 X139.79 Y137.79 E.26885
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X128.213 Y118.21 E.2459
G1 X128.283 Y118.21 E.00215
G1 X128.284 Y120.046 E.05643
M204 S10000
; WIPE_START
G1 F24000
G1 X130.283 Y120.098 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.4 I-.539 J1.091 P1  F30000
G1 X131.334 Y120.618 Z10.4
G1 Z10
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2430
G1 X131.374 Y118.95 E.05533
G1 X136.302 Y118.95 E.16349
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X137.113 Y128.563 E.39813
G1 X137.113 Y127.437 E.03734
G1 X130.523 Y120.847 E.30918
G1 X129.477 Y120.847 E.03469
G1 X120.95 Y129.374 E.40001
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
M73 P62 R8
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X125.326 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 10.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y118.95 E-.61876
G1 X123.435 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 51/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
G17
M73 P62 R7
G3 Z10.4 I-.332 J1.171 P1  F30000
G1 X127.964 Y120.499 Z10.4
G1 Z10.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2428
G1 X130.961 Y120.499 E.09941
G1 X130.96 Y118.602 E.06292
G1 X139.398 Y118.602 E.27991
G1 X139.398 Y125.637 E.23337
G1 X137.463 Y125.638 E.06419
G1 X137.461 Y129.543 E.12952
G1 X139.398 Y129.545 E.06425
G1 X139.398 Y137.398 E.26049
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.965 Y118.602 E.24424
G1 X127.964 Y120.439 E.06093
G1 X128.356 Y120.107 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2428
G1 X130.569 Y120.107 E.06798
G1 X130.568 Y118.21 E.05828
G1 X139.79 Y118.21 E.28338
G1 X139.79 Y126.029 E.24026
G1 X137.855 Y126.03 E.05947
G1 X137.853 Y129.151 E.0959
G1 X139.79 Y129.154 E.05951
G1 X139.79 Y137.79 E.26537
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X128.324 Y118.21 E.24931
G1 X128.357 Y118.21 E.00103
G1 X128.356 Y120.047 E.05644
M204 S10000
; WIPE_START
G1 F24000
G1 X130.356 Y120.101 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.6 I-.602 J1.057 P1  F30000
G1 X131.309 Y120.644 Z10.6
G1 Z10.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2428
G1 X131.308 Y119.016 E.05401
G1 X131.374 Y118.95 E.00307
G1 X136.302 Y118.95 E.16349
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X137.113 Y128.563 E.39814
G1 X137.114 Y127.438 E.03732
G1 X130.523 Y120.847 E.30919
G1 X129.477 Y120.847 E.0347
G1 X120.95 Y129.374 E.4
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X125.326 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 10.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y118.95 E-.61876
G1 X123.435 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 52/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
G17
G3 Z10.6 I-.314 J1.176 P1  F30000
G1 X128.244 Y120.499 Z10.6
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2390
G1 X131.089 Y120.499 E.09437
G1 X131.088 Y118.602 E.06292
G1 X139.398 Y118.602 E.27567
G1 X139.398 Y125.518 E.2294
G1 X137.463 Y125.519 E.06418
G1 X137.461 Y129.656 E.13725
G1 X139.398 Y129.659 E.06424
G1 X139.398 Y137.398 E.25673
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.852 Y118.602 E.24051
G1 X127.852 Y120.499 E.06292
G1 X128.184 Y120.499 E.01102
G1 X128.244 Y120.107 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2390
G1 X130.696 Y120.107 E.07536
G1 X130.695 Y118.21 E.05829
G1 X139.79 Y118.21 E.27945
G1 X139.79 Y125.91 E.23659
G1 X137.855 Y125.91 E.05945
G1 X137.854 Y129.264 E.10306
G1 X139.79 Y129.267 E.0595
G1 X139.79 Y137.79 E.26189
G1 X120.21 Y137.79 E.60164
M73 P63 R7
G1 X120.21 Y118.21 E.60164
G1 X128.245 Y118.21 E.24689
G1 X128.244 Y120.047 E.05644
M204 S10000
; WIPE_START
G1 F24000
G1 X130.243 Y120.096 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.8 I.276 J-1.185 P1  F30000
G1 X125.326 Y118.95 Z10.8
G1 Z10.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2390
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.477 Y120.847 E.4
G1 X130.523 Y120.847 E.03471
G1 X137.114 Y127.438 E.30919
G1 X137.114 Y128.562 E.0373
G1 X128.626 Y137.05 E.39815
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 10.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 53/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
G17
G3 Z10.8 I-.183 J-1.203 P1  F30000
G1 X128.131 Y120.499 Z10.8
G1 Z10.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2392
G1 X131.217 Y120.499 E.10234
G1 X131.215 Y118.602 E.06293
G1 X139.398 Y118.602 E.27143
G1 X139.398 Y125.398 E.22543
G1 X137.464 Y125.399 E.06417
G1 X137.462 Y129.769 E.14497
G1 X139.398 Y129.772 E.06423
G1 X139.398 Y137.398 E.25297
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.74 Y118.602 E.23678
G1 X127.739 Y120.499 E.06293
G1 X128.071 Y120.499 E.01102
G1 X128.131 Y120.107 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2392
G1 X130.824 Y120.107 E.08274
G1 X130.823 Y118.21 E.05829
G1 X139.79 Y118.21 E.27552
G1 X139.79 Y125.79 E.23291
G1 X137.855 Y125.791 E.05944
G1 X137.854 Y129.378 E.11022
G1 X139.79 Y129.38 E.05949
G1 X139.79 Y137.79 E.25841
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X128.132 Y118.21 E.24343
G1 X128.131 Y120.047 E.05645
M204 S10000
; WIPE_START
G1 F24000
G1 X130.131 Y120.092 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11 I.281 J-1.184 P1  F30000
G1 X125.326 Y118.95 Z11
G1 Z10.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2392
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.477 Y120.847 E.39999
G1 X130.523 Y120.847 E.03472
G1 X137.114 Y127.438 E.3092
G1 X137.114 Y128.562 E.03728
G1 X128.626 Y137.05 E.39817
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 10.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
M73 P64 R7
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 54/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
G17
G3 Z11 I-.181 J-1.203 P1  F30000
G1 X128.019 Y120.499 Z11
G1 Z10.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2392
G1 X131.344 Y120.499 E.11032
G1 X131.343 Y118.602 E.06293
G1 X139.398 Y118.602 E.26719
G1 X139.398 Y125.278 E.22147
G1 X137.464 Y125.279 E.06416
G1 X137.462 Y129.883 E.1527
G1 X139.398 Y129.885 E.06422
G1 X139.398 Y137.398 E.24921
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.628 Y118.602 E.23305
G1 X127.627 Y120.499 E.06293
G1 X127.959 Y120.499 E.01102
G1 X128.019 Y120.107 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2392
G1 X130.952 Y120.107 E.09013
G1 X130.951 Y118.21 E.0583
G1 X139.79 Y118.21 E.2716
G1 X139.79 Y125.67 E.22923
G1 X137.856 Y125.671 E.05943
G1 X137.854 Y129.491 E.11737
G1 X139.79 Y129.494 E.05948
G1 X139.79 Y137.79 E.25492
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X128.02 Y118.21 E.23997
G1 X128.019 Y120.047 E.05645
M204 S10000
; WIPE_START
G1 F24000
G1 X130.019 Y120.088 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.2 I.287 J-1.183 P1  F30000
G1 X125.326 Y118.95 Z11.2
G1 Z10.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2392
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.476 Y120.848 E.39998
G1 X130.524 Y120.848 E.03473
G1 X137.115 Y127.439 E.30921
G1 X137.114 Y128.562 E.03725
G1 X128.626 Y137.05 E.39818
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 11
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 55/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
G17
G3 Z11.2 I-.171 J-1.205 P1  F30000
G1 X127.514 Y120.499 Z11.2
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2392
G1 X131.472 Y120.499 E.13129
G1 X131.471 Y118.602 E.06294
G1 X139.398 Y118.602 E.26295
G1 X139.398 Y125.159 E.2175
G1 X137.464 Y125.16 E.06414
G1 X137.462 Y129.996 E.16043
G1 X139.398 Y129.998 E.06421
G1 X139.398 Y137.398 E.24545
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.515 Y118.602 E.22932
G1 X127.514 Y120.439 E.06095
G1 X127.906 Y120.107 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2392
G1 X131.08 Y120.107 E.09751
G1 X131.079 Y118.21 E.0583
G1 X139.79 Y118.21 E.26767
G1 X139.79 Y125.551 E.22556
G1 X137.856 Y125.552 E.05942
G1 X137.854 Y129.604 E.12453
G1 X139.79 Y129.607 E.05948
G1 X139.79 Y137.79 E.25144
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.907 Y118.21 E.23652
G1 X127.907 Y118.267 E.00177
M73 P65 R7
G1 X127.906 Y120.047 E.05469
M204 S10000
; WIPE_START
G1 F24000
G1 X129.906 Y120.085 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.4 I.293 J-1.181 P1  F30000
G1 X125.326 Y118.95 Z11.4
G1 Z11
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2392
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.476 Y120.848 E.39997
G1 X130.524 Y120.848 E.03474
G1 X137.115 Y127.439 E.30921
G1 X137.114 Y128.561 E.03723
G1 X128.626 Y137.05 E.3982
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 11.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 56/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
G17
G3 Z11.4 I-.169 J-1.205 P1  F30000
G1 X127.402 Y120.5 Z11.4
G1 Z11.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2422
G1 X131.6 Y120.5 E.13926
G1 X131.599 Y118.602 E.06294
G1 X139.398 Y118.602 E.2587
G1 X139.398 Y125.039 E.21353
G1 X137.465 Y125.04 E.06413
G1 X137.462 Y130.109 E.16815
G1 X139.398 Y130.112 E.06421
G1 X139.398 Y137.398 E.24169
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.403 Y118.602 E.22559
G1 X127.402 Y120.44 E.06095
G1 X127.794 Y120.108 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2422
G1 X131.208 Y120.108 E.10489
G1 X131.207 Y118.21 E.05831
G1 X139.79 Y118.21 E.26374
G1 X139.79 Y125.431 E.22188
G1 X137.857 Y125.432 E.05941
G1 X137.856 Y127.529 E.06444
G1 X137.896 Y127.529 E.00125
G1 X139.79 Y127.528 E.05819
G1 X139.79 Y127.632 E.00318
G1 X137.896 Y127.629 E.05819
G1 X137.856 Y127.629 E.00125
G1 X137.855 Y129.718 E.06417
G1 X139.79 Y129.72 E.05947
G1 X139.79 Y137.79 E.24796
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.795 Y118.21 E.23306
G1 X127.794 Y120.048 E.05646
M204 S10000
; WIPE_START
G1 F24000
G1 X129.794 Y120.083 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.6 I.299 J-1.18 P1  F30000
G1 X125.326 Y118.95 Z11.6
G1 Z11.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2422
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.476 Y120.848 E.39996
G1 X130.524 Y120.848 E.03475
G1 X137.115 Y127.439 E.30922
G1 X137.115 Y128.561 E.03721
G1 X128.626 Y137.05 E.39821
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
M73 P66 R7
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 11.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 57/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
G17
G3 Z11.6 I-.167 J-1.205 P1  F30000
G1 X127.289 Y120.5 Z11.6
G1 Z11.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2422
G1 X131.728 Y120.5 E.14724
G1 X131.727 Y118.602 E.06295
G1 X139.398 Y118.602 E.25446
G1 X139.398 Y124.92 E.20956
G1 X137.465 Y124.921 E.06412
G1 X137.463 Y130.223 E.17588
G1 X139.398 Y130.225 E.0642
G1 X139.398 Y137.398 E.23793
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.29 Y118.602 E.22186
G1 X127.289 Y120.44 E.06096
G1 X127.682 Y120.108 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2422
G1 X131.336 Y120.108 E.11228
G1 X131.335 Y118.21 E.05831
G1 X139.79 Y118.21 E.25981
G1 X139.79 Y125.311 E.21821
G1 X137.857 Y125.312 E.0594
G1 X137.856 Y127.412 E.06452
G1 X137.897 Y127.412 E.00125
G1 X139.79 Y127.411 E.05818
G1 X139.79 Y127.487 E.00233
G1 X139.79 Y127.673 E.0057
G1 X139.79 Y127.743 E.00216
G1 X137.897 Y127.741 E.05818
G1 X137.856 Y127.741 E.00125
G1 X137.855 Y129.831 E.06423
G1 X139.79 Y129.834 E.05946
G1 X139.79 Y137.79 E.24448
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.682 Y118.21 E.22961
G1 X127.682 Y120.048 E.05647
M204 S10000
; WIPE_START
G1 F24000
G1 X129.681 Y120.081 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.8 I.306 J-1.178 P1  F30000
G1 X125.326 Y118.95 Z11.8
G1 Z11.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2422
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.476 Y120.848 E.39996
G1 X130.524 Y120.848 E.03476
G1 X137.116 Y127.44 E.30923
G1 X137.115 Y128.561 E.03719
G1 X128.626 Y137.05 E.39823
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 11.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 58/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L58
M991 S0 P57 ;notify layer change
G17
G3 Z11.8 I-.165 J-1.206 P1  F30000
G1 X127.177 Y120.5 Z11.8
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2443
G1 X131.856 Y120.5 E.15521
G1 X131.855 Y118.602 E.06296
G1 X139.398 Y118.602 E.25022
G1 X139.398 Y124.8 E.2056
G1 X137.465 Y124.801 E.06411
G1 X137.463 Y130.336 E.18361
G1 X139.398 Y130.338 E.06419
G1 X139.398 Y137.398 E.23418
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
M73 P66 R6
G1 X127.178 Y118.602 E.21813
G1 X127.177 Y120.44 E.06097
G1 X127.569 Y120.108 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2443
G1 X129.43 Y120.108 E.05717
G1 X131.463 Y120.108 E.06249
G1 X131.462 Y118.21 E.05832
G1 X139.79 Y118.21 E.25588
G1 X139.79 Y125.192 E.21453
G1 X137.857 Y125.193 E.05939
G1 X137.856 Y127.295 E.06461
G1 X137.897 Y127.295 E.00125
G1 X139.79 Y127.294 E.05817
G1 X139.79 Y127.37 E.00233
G1 X139.79 Y127.784 E.01271
M73 P67 R6
G1 X139.79 Y127.854 E.00216
G1 X137.897 Y127.852 E.05817
G1 X137.856 Y127.852 E.00125
G1 X137.855 Y129.944 E.0643
G1 X139.79 Y129.947 E.05945
G1 X139.79 Y137.79 E.241
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.57 Y118.21 E.22615
G1 X127.569 Y120.048 E.05647
M204 S10000
; WIPE_START
G1 F24000
G1 X129.43 Y120.108 E-.70734
G1 X129.568 Y120.108 E-.05266
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12 I.32 J-1.174 P1  F30000
G1 X125.326 Y118.95 Z12
G1 Z11.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2443
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.476 Y120.848 E.39995
G1 X130.524 Y120.848 E.03478
G1 X137.116 Y127.44 E.30923
G1 X137.115 Y128.561 E.03717
G1 X128.626 Y137.05 E.39824
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
G1 X137.66 Y127.574 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.210247
G1 F2443
G1 X139.594 Y127.574 E.02637
; CHANGE_LAYER
; Z_HEIGHT: 11.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X137.66 Y127.574 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 59/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L59
M991 S0 P58 ;notify layer change
G17
G3 Z12 I.676 J-1.012 P1  F30000
G1 X127.064 Y120.5 Z12
G1 Z11.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2475
G1 X131.984 Y120.5 E.16318
G1 X131.983 Y118.602 E.06296
G1 X139.398 Y118.602 E.24598
G1 X139.398 Y124.68 E.20163
G1 X137.466 Y124.681 E.0641
G1 X137.463 Y130.449 E.19133
G1 X139.398 Y130.452 E.06418
G1 X139.398 Y137.398 E.23042
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X127.065 Y118.602 E.21439
G1 X127.064 Y120.44 E.06097
G1 X127.457 Y120.108 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
G1 X129.539 Y120.108 E.06398
G1 X129.539 Y120.067 E.00126
G1 X129.552 Y118.21 E.05706
G1 X129.556 Y119.985 E.05454
G1 X129.556 Y120.108 E.00378
G1 X131.591 Y120.108 E.06254
G1 X131.59 Y118.21 E.05832
G1 X139.79 Y118.21 E.25196
G1 X139.79 Y125.072 E.21086
G1 X137.858 Y125.073 E.05938
G1 X137.857 Y127.178 E.06469
G1 X137.897 Y127.178 E.00125
G1 X139.79 Y127.178 E.05816
G1 X139.79 Y127.253 E.00233
G1 X139.79 Y127.895 E.01972
G1 X139.79 Y127.966 E.00216
G1 X137.897 Y127.963 E.05817
G1 X137.856 Y127.963 E.00125
G1 X137.855 Y130.058 E.06436
G1 X139.79 Y130.06 E.05945
G1 X139.79 Y137.79 E.23752
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.457 Y118.21 E.2227
G1 X127.457 Y120.048 E.05648
M204 S10000
; WIPE_START
G1 F24000
G1 X129.456 Y120.106 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.2 I.328 J-1.172 P1  F30000
G1 X125.326 Y118.95 Z12.2
G1 Z11.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.476 Y120.848 E.39994
M73 P68 R6
G1 X130.524 Y120.848 E.03479
G1 X137.116 Y127.44 E.30924
G1 X137.116 Y128.56 E.03715
G1 X128.626 Y137.05 E.39826
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
G1 X137.66 Y127.571 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.438204
G1 F2475
G1 X139.594 Y127.571 E.06228
; CHANGE_LAYER
; Z_HEIGHT: 12
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X137.66 Y127.571 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 60/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L60
M991 S0 P59 ;notify layer change
G17
G3 Z12.2 I.671 J-1.016 P1  F30000
G1 X126.952 Y120.5 Z12.2
G1 Z12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2475
G1 X132.111 Y120.5 E.17115
G1 X132.11 Y118.602 E.06297
G1 X139.398 Y118.602 E.24174
G1 X139.398 Y124.561 E.19766
G1 X137.466 Y124.562 E.06408
G1 X137.463 Y130.563 E.19906
G1 X139.398 Y130.565 E.06417
G1 X139.398 Y137.398 E.22666
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.953 Y118.602 E.21066
G1 X126.952 Y120.44 E.06098
G1 X127.344 Y120.108 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
G1 X129.426 Y120.108 E.06396
G1 X129.426 Y120.067 E.00126
G1 X129.427 Y118.21 E.05706
G1 X129.499 Y118.21 E.00221
G1 X129.678 Y118.21 E.0055
G1 X129.682 Y119.985 E.05454
G1 X129.682 Y120.108 E.00378
G1 X131.719 Y120.108 E.06259
G1 X131.718 Y118.21 E.05833
G1 X139.79 Y118.21 E.24803
G1 X139.79 Y124.953 E.20718
G1 X137.858 Y124.954 E.05937
G1 X137.857 Y127.061 E.06477
G1 X137.898 Y127.061 E.00125
G1 X139.79 Y127.061 E.05814
G1 X139.79 Y127.137 E.00233
G1 X139.79 Y128.007 E.02673
G1 X139.79 Y128.077 E.00216
G1 X137.897 Y128.074 E.05816
G1 X137.857 Y128.074 E.00125
G1 X137.856 Y130.171 E.06442
G1 X139.79 Y130.174 E.05944
G1 X139.79 Y137.79 E.23403
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.345 Y118.21 E.21924
G1 X127.344 Y120.048 E.05648
M204 S10000
; WIPE_START
G1 F24000
G1 X129.343 Y120.106 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.4 I.336 J-1.17 P1  F30000
G1 X125.326 Y118.95 Z12.4
G1 Z12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.475 Y120.849 E.39993
G1 X130.525 Y120.849 E.0348
G1 X137.117 Y127.441 E.30925
G1 X137.116 Y128.56 E.03713
G1 X128.626 Y137.05 E.39827
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
G1 X137.661 Y127.568 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.666164
G1 F2475
G1 X139.594 Y127.569 E.09818
; CHANGE_LAYER
; Z_HEIGHT: 12.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X137.661 Y127.568 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 61/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L61
M991 S0 P60 ;notify layer change
G17
G3 Z12.4 I.665 J-1.019 P1  F30000
G1 X126.839 Y120.5 Z12.4
G1 Z12.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2524
G1 X132.239 Y120.5 E.17912
G1 X132.238 Y118.602 E.06297
G1 X139.398 Y118.602 E.2375
G1 X139.398 Y124.441 E.19369
G1 X137.466 Y124.442 E.06407
G1 X137.465 Y127.337 E.09602
G1 X139.398 Y127.336 E.06411
G1 X139.398 Y127.795 E.01524
G1 X137.465 Y127.793 E.06412
G1 X137.464 Y130.676 E.09563
G1 X139.398 Y130.678 E.06416
G1 X139.398 Y137.398 E.2229
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.84 Y118.602 E.20693
G1 X126.839 Y120.44 E.06098
G1 X127.232 Y120.108 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2524
G1 X129.313 Y120.108 E.06395
G1 X129.313 Y120.067 E.00126
G1 X129.314 Y118.21 E.05707
G1 X129.386 Y118.21 E.00221
M73 P69 R6
G1 X129.804 Y118.21 E.01286
G1 X129.808 Y119.985 E.05455
G1 X129.808 Y120.108 E.00378
G1 X131.847 Y120.108 E.06264
G1 X131.846 Y118.21 E.05833
G1 X139.79 Y118.21 E.2441
G1 X139.79 Y124.833 E.20351
G1 X137.858 Y124.834 E.05935
G1 X137.857 Y126.945 E.06485
G1 X137.898 Y126.945 E.00125
G1 X139.79 Y126.944 E.05813
G1 X139.79 Y127.02 E.00233
G1 X139.79 Y128.118 E.03375
G1 X139.79 Y128.188 E.00216
G1 X137.898 Y128.186 E.05815
G1 X137.857 Y128.186 E.00125
G1 X137.856 Y130.284 E.06449
G1 X139.79 Y130.287 E.05943
G1 X139.79 Y137.79 E.23055
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.233 Y118.21 E.21578
G1 X127.232 Y120.048 E.05649
M204 S10000
; WIPE_START
G1 F24000
G1 X129.231 Y120.106 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.6 I.345 J-1.167 P1  F30000
G1 X125.326 Y118.95 Z12.6
G1 Z12.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2524
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.475 Y120.849 E.39992
G1 X130.525 Y120.849 E.03481
G1 X137.117 Y127.441 E.30925
G1 X137.116 Y128.56 E.03711
G1 X128.626 Y137.05 E.39828
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.6 I.139 J-1.209 P1  F30000
G1 X129.56 Y118.406 Z12.6
G1 Z12.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.1465
G1 F2524
G1 X129.561 Y120.304 E.01602
; CHANGE_LAYER
; Z_HEIGHT: 12.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X129.56 Y118.406 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 62/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L62
M991 S0 P61 ;notify layer change
G17
G3 Z12.6 I-.723 J-.979 P1  F30000
G1 X126.727 Y120.501 Z12.6
G1 Z12.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2541
G1 X132.367 Y120.501 E.18709
G1 X132.366 Y118.602 E.06298
G1 X139.398 Y118.602 E.23326
G1 X139.398 Y124.322 E.18973
G1 X137.467 Y124.322 E.06406
G1 X137.466 Y127.22 E.09611
G1 X139.398 Y127.219 E.0641
G1 X139.398 Y127.907 E.02281
G1 X137.465 Y127.904 E.06411
G1 X137.464 Y130.789 E.0957
G1 X139.398 Y130.792 E.06415
G1 X139.398 Y137.398 E.21914
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.728 Y118.602 E.2032
G1 X126.727 Y120.441 E.06099
G1 X127.119 Y120.109 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2541
G1 X129.2 Y120.109 E.06393
G1 X129.2 Y120.067 E.00126
G1 X129.201 Y118.21 E.05707
G1 X129.273 Y118.21 E.00221
G1 X129.93 Y118.21 E.02021
G1 X129.934 Y119.985 E.05455
G1 X129.935 Y120.109 E.00378
G1 X131.975 Y120.109 E.06269
G1 X131.974 Y118.21 E.05834
G1 X139.79 Y118.21 E.24017
G1 X139.79 Y124.713 E.19983
G1 X137.859 Y124.714 E.05934
G1 X137.858 Y126.828 E.06493
G1 X137.898 Y126.828 E.00125
G1 X139.79 Y126.827 E.05812
G1 X139.79 Y126.903 E.00233
G1 X139.79 Y128.229 E.04076
G1 X139.79 Y128.299 E.00216
G1 X137.898 Y128.297 E.05814
G1 X137.857 Y128.297 E.00125
G1 X137.856 Y130.398 E.06455
G1 X139.79 Y130.4 E.05942
G1 X139.79 Y137.79 E.22707
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.12 Y118.21 E.21233
G1 X127.119 Y120.049 E.05649
M204 S10000
; WIPE_START
G1 F24000
G1 X129.118 Y120.106 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.8 I.355 J-1.164 P1  F30000
G1 X125.326 Y118.95 Z12.8
G1 Z12.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2541
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
M73 P70 R6
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.475 Y120.849 E.39992
G1 X130.525 Y120.849 E.03482
G1 X136.914 Y127.238 E.29971
G1 X136.913 Y128.071 E.02766
G1 X137.117 Y128.072 E.00675
G1 X137.117 Y128.559 E.01618
G1 X128.626 Y137.05 E.3983
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.8 I.139 J-1.209 P1  F30000
G1 X129.567 Y118.406 Z12.8
G1 Z12.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.385624
G1 F2541
G1 X129.567 Y120.305 E.05302
G1 X137.262 Y127.562 F30000
; LINE_WIDTH: 0.322928
G1 F2541
G1 X139.194 Y127.563 E.0441
; CHANGE_LAYER
; Z_HEIGHT: 12.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X137.262 Y127.562 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 63/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L63
M991 S0 P62 ;notify layer change
G17
G3 Z12.8 I.673 J-1.014 P1  F30000
G1 X126.614 Y120.501 Z12.8
G1 Z12.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2548
G1 X132.495 Y120.501 E.19506
G1 X132.494 Y118.602 E.06298
G1 X139.398 Y118.602 E.22902
G1 X139.398 Y124.202 E.18576
G1 X137.467 Y124.203 E.06405
G1 X137.466 Y127.103 E.0962
G1 X139.398 Y127.102 E.06409
G1 X139.398 Y128.018 E.03038
G1 X137.465 Y128.015 E.0641
G1 X137.464 Y130.902 E.09577
G1 X139.398 Y130.905 E.06415
G1 X139.398 Y137.398 E.21538
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.615 Y118.602 E.19947
G1 X126.615 Y118.782 E.00595
G1 X126.615 Y120.441 E.05504
G1 X127.007 Y120.109 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2548
G1 X129.087 Y120.109 E.06391
G1 X129.087 Y120.068 E.00126
G1 X129.088 Y118.21 E.05708
G1 X129.16 Y118.21 E.00221
G1 X130.057 Y118.21 E.02756
G1 X130.061 Y119.986 E.05456
G1 X130.061 Y120.109 E.00378
G1 X132.103 Y120.109 E.06274
G1 X132.102 Y118.21 E.05834
G1 X139.79 Y118.21 E.23624
G1 X139.79 Y124.594 E.19616
G1 X137.859 Y124.595 E.05933
G1 X137.858 Y126.711 E.06501
G1 X137.899 Y126.711 E.00125
G1 X139.79 Y126.71 E.05811
G1 X139.79 Y126.786 E.00233
G1 X139.79 Y128.34 E.04777
G1 X139.79 Y128.41 E.00216
G1 X137.898 Y128.408 E.05813
G1 X137.857 Y128.408 E.00125
G1 X137.856 Y130.511 E.06462
G1 X139.79 Y130.513 E.05941
G1 X139.79 Y137.79 E.22359
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X127.008 Y118.21 E.20887
G1 X127.007 Y120.049 E.0565
M204 S10000
; WIPE_START
G1 F24000
G1 X129.006 Y120.106 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13 I.365 J-1.161 P1  F30000
G1 X125.326 Y118.95 Z13
G1 Z12.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2548
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.475 Y120.849 E.39991
G1 X130.525 Y120.849 E.03483
G1 X136.914 Y127.238 E.29972
G1 X136.914 Y128.183 E.03133
G1 X137.117 Y128.183 E.00675
G1 X137.117 Y128.559 E.01248
G1 X128.626 Y137.05 E.39831
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13 I.14 J-1.209 P1  F30000
G1 X129.574 Y118.406 Z13
G1 Z12.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.624749
G1 F2548
G1 X129.574 Y120.305 E.09002
G1 X137.262 Y127.559 F30000
; LINE_WIDTH: 0.550888
G1 F2548
G1 X139.194 Y127.56 E.07998
; CHANGE_LAYER
; Z_HEIGHT: 12.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X137.262 Y127.559 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 64/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L64
M991 S0 P63 ;notify layer change
G17
G3 Z13 I.667 J-1.018 P1  F30000
G1 X126.502 Y120.501 Z13
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P71 R6
G1 F2553
G1 X129.366 Y120.501 E.09499
G1 X129.367 Y118.602 E.06299
G1 X129.794 Y118.602 E.01418
G1 X129.795 Y120.501 E.06299
G1 X132.623 Y120.501 E.09379
G1 X132.622 Y118.602 E.06299
G1 X139.398 Y118.602 E.22478
G1 X139.398 Y124.082 E.18179
G1 X137.468 Y124.083 E.06404
G1 X137.466 Y126.986 E.09629
G1 X139.398 Y126.985 E.06408
G1 X139.398 Y128.129 E.03795
G1 X137.466 Y128.127 E.06409
G1 X137.464 Y131.016 E.09584
G1 X139.398 Y131.018 E.06414
G1 X139.398 Y137.398 E.21162
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.503 Y118.602 E.19574
G1 X126.503 Y118.846 E.00808
G1 X126.502 Y120.441 E.05291
G1 X126.894 Y120.109 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2553
G1 X128.974 Y120.109 E.0639
G1 X128.974 Y120.068 E.00126
G1 X128.975 Y118.21 E.05708
G1 X129.047 Y118.21 E.00221
G1 X130.183 Y118.21 E.03491
G1 X130.187 Y119.986 E.05456
G1 X130.187 Y120.109 E.00378
G1 X132.23 Y120.109 E.06279
G1 X132.229 Y118.21 E.05835
G1 X139.79 Y118.21 E.23232
G1 X139.79 Y124.474 E.19248
G1 X137.859 Y124.475 E.05932
G1 X137.858 Y126.594 E.0651
G1 X137.899 Y126.594 E.00125
G1 X139.79 Y126.593 E.0581
G1 X139.79 Y126.669 E.00233
G1 X139.79 Y128.451 E.05478
G1 X139.79 Y128.522 E.00216
G1 X137.898 Y128.519 E.05813
G1 X137.858 Y128.519 E.00125
G1 X137.857 Y130.624 E.06468
G1 X139.79 Y130.627 E.05941
G1 X139.79 Y137.79 E.22011
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.895 Y118.21 E.20542
G1 X126.894 Y120.049 E.0565
M204 S10000
; WIPE_START
G1 F24000
G1 X128.893 Y120.107 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.2 I.375 J-1.158 P1  F30000
G1 X125.326 Y118.95 Z13.2
G1 Z12.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2553
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.475 Y120.849 E.3999
G1 X130.525 Y120.849 E.03484
G1 X136.796 Y127.12 E.29418
G1 X136.795 Y127.997 E.02908
G1 X137.117 Y128.301 E.01472
G1 X137.117 Y128.559 E.00853
G1 X128.626 Y137.05 E.39833
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
G1 X137.182 Y127.787 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.410235
G1 F2553
G3 X137.365 Y127.74 I.132 J.132 E.00593
G3 X139.01 Y127.741 I-.888 J1882.072 E.04925
G1 X139.01 Y127.373 E.01102
G3 X137.365 Y127.373 I-.946 J-1850.03 E.04925
G1 X137.182 Y127.328 E.00565
G1 X137.182 Y127.727 E.01194
; CHANGE_LAYER
; Z_HEIGHT: 13
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X137.182 Y127.328 E-.15156
G1 X137.365 Y127.373 E-.07171
G1 X138.778 Y127.373 E-.53673
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 65/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L65
M991 S0 P64 ;notify layer change
G17
G3 Z13.2 I.59 J-1.064 P1  F30000
G1 X126.39 Y120.501 Z13.2
M73 P71 R5
G1 Z13
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2596
G1 X129.253 Y120.501 E.09498
G1 X129.254 Y118.602 E.06299
G1 X129.92 Y118.602 E.02212
G1 X129.921 Y120.501 E.06299
G1 X132.751 Y120.501 E.09385
G1 X132.75 Y118.602 E.06299
G1 X139.398 Y118.602 E.22054
G1 X139.398 Y123.963 E.17782
G1 X137.468 Y123.964 E.06402
G1 X137.467 Y126.869 E.09637
G1 X139.398 Y126.868 E.06407
G1 X139.398 Y128.24 E.04552
G1 X137.466 Y128.238 E.06409
G1 X137.465 Y131.129 E.09591
G1 X139.398 Y131.132 E.06413
G1 X139.398 Y137.398 E.20786
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.39 Y118.602 E.19201
G1 X126.39 Y118.91 E.01022
G1 X126.39 Y120.441 E.05079
G1 X126.782 Y120.109 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2596
G1 X128.861 Y120.109 E.06388
G1 X128.861 Y120.068 E.00126
G1 X128.862 Y118.21 E.05709
G1 X128.934 Y118.21 E.00221
G1 X130.309 Y118.21 E.04226
G1 X130.313 Y119.986 E.05457
G1 X130.313 Y120.109 E.00378
G1 X132.358 Y120.109 E.06284
G1 X132.357 Y118.21 E.05835
G1 X139.79 Y118.21 E.22839
G1 X139.79 Y124.355 E.18881
G1 X137.86 Y124.356 E.05931
G1 X137.859 Y126.477 E.06518
G1 X137.9 Y126.477 E.00125
G1 X139.79 Y126.476 E.05809
M73 P72 R5
G1 X139.79 Y126.552 E.00233
G1 X139.79 Y128.563 E.06179
G1 X139.79 Y128.633 E.00216
G1 X137.899 Y128.63 E.05812
G1 X137.858 Y128.63 E.00125
G1 X137.857 Y130.738 E.06475
G1 X139.79 Y130.74 E.0594
G1 X139.79 Y137.79 E.21662
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.783 Y118.21 E.20196
G1 X126.782 Y120.049 E.05651
M204 S10000
; WIPE_START
G1 F24000
G1 X128.781 Y120.107 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.4 I.386 J-1.154 P1  F30000
G1 X125.326 Y118.95 Z13.4
G1 Z13
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2596
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.271 Y121.053 E.39035
G1 X130.088 Y121.053 E.02709
G1 X130.088 Y120.849 E.00675
G1 X130.525 Y120.849 E.01452
G1 X136.796 Y127.12 E.29418
G1 X136.795 Y127.997 E.02907
G1 X137.118 Y128.301 E.01473
G1 X137.118 Y128.558 E.00852
G1 X128.626 Y137.05 E.39834
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
; WIPE_START
G1 F24000
G1 X136.302 Y118.95 E-.61876
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.4 I.071 J-1.215 P1  F30000
G1 X129.587 Y118.806 Z13.4
G1 Z13
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.304632
G1 F2596
G1 X129.587 Y120.705 E.0405
G1 X137.263 Y127.794 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.524333
G1 F2596
G2 X138.712 Y127.795 I2.255 J-1652.688 E.05685
G1 X138.953 Y127.795 E.00947
G1 X138.953 Y127.313 E.01892
G3 X137.239 Y127.311 I-.489 J-424.487 E.06725
G1 X137.26 Y127.734 E.01659
; CHANGE_LAYER
; Z_HEIGHT: 13.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X137.239 Y127.311 E-.16066
G1 X138.816 Y127.313 E-.59934
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 66/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L66
M991 S0 P65 ;notify layer change
G17
G3 Z13.4 I.581 J-1.069 P1  F30000
G1 X126.277 Y120.501 Z13.4
G1 Z13.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2570
G1 X129.14 Y120.501 E.09496
G1 X129.141 Y118.602 E.063
G1 X130.047 Y118.602 E.03006
G1 X130.048 Y120.501 E.063
G1 X132.878 Y120.501 E.0939
G1 X132.877 Y118.602 E.063
G1 X139.398 Y118.602 E.2163
G1 X139.398 Y123.843 E.17386
G1 X137.468 Y123.844 E.06401
G1 X137.467 Y126.752 E.09646
G1 X139.398 Y126.751 E.06405
G1 X139.398 Y128.351 E.05309
G1 X137.466 Y128.349 E.06408
G1 X137.465 Y131.242 E.09598
G1 X139.398 Y131.245 E.06412
G1 X139.398 Y137.398 E.20411
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.278 Y118.602 E.18828
G1 X126.278 Y118.974 E.01235
G1 X126.277 Y120.441 E.04866
G1 X126.669 Y120.109 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2570
G1 X128.748 Y120.109 E.06386
G1 X128.748 Y120.068 E.00126
G1 X128.749 Y118.21 E.05709
G1 X128.821 Y118.21 E.00221
G1 X130.435 Y118.21 E.04961
G1 X130.439 Y119.986 E.05457
G1 X130.44 Y120.109 E.00378
G1 X132.486 Y120.109 E.06288
G1 X132.485 Y118.21 E.05836
G1 X139.79 Y118.21 E.22446
G1 X139.79 Y124.235 E.18513
G1 X137.86 Y124.236 E.0593
G1 X137.859 Y126.36 E.06526
G1 X137.9 Y126.36 E.00125
G1 X139.79 Y126.359 E.05808
G1 X139.79 Y126.435 E.00233
G1 X139.79 Y128.674 E.0688
G1 X139.79 Y128.744 E.00216
G1 X137.899 Y128.742 E.05811
G1 X137.858 Y128.742 E.00125
G1 X137.857 Y130.851 E.06481
G1 X139.79 Y130.853 E.05939
G1 X139.79 Y137.79 E.21314
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.67 Y118.21 E.19851
G1 X126.669 Y120.049 E.05651
M204 S10000
; WIPE_START
G1 F24000
G1 X128.669 Y120.107 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.6 I.398 J-1.15 P1  F30000
G1 X125.326 Y118.95 Z13.6
G1 Z13.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2570
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X137.117 Y130.186 F30000
G1 F2570
G1 X137.118 Y128.558 E.05401
G1 X128.626 Y137.05 E.39836
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.271 Y121.053 E.39034
G1 X130.214 Y121.053 E.03128
G1 X130.214 Y120.85 E.00675
G1 X130.526 Y120.85 E.01034
G1 X137.675 Y128.001 E.33544
G1 X138.576 Y127.1 E.04228
G1 X139.05 Y127.1 E.01571
G1 X139.05 Y128.003 E.02996
G1 X138.798 Y128.002 E.00835
G1 X129.594 Y120.705 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.543757
G1 F2570
G1 X129.594 Y118.806 E.07751
; WIPE_START
G1 F24000
G1 X129.594 Y120.705 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.6 I.397 J1.15 P1  F30000
G1 X134.674 Y118.95 Z13.6
G1 Z13.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2570
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 13.4
; LAYER_HEIGHT: 0.2
; WIPE_START
M73 P73 R5
G1 F24000
G1 X123.698 Y137.05 E-.61876
G1 X123.435 Y136.787 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 67/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L67
M991 S0 P66 ;notify layer change
G17
G3 Z13.6 I1.2 J.201 P1  F30000
G1 X126.165 Y120.501 Z13.6
G1 Z13.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2579
G1 X129.027 Y120.501 E.09494
G1 X129.028 Y118.602 E.06301
G1 X130.173 Y118.602 E.03799
G1 X130.174 Y120.501 E.06301
G1 X133.006 Y120.501 E.09395
G1 X133.005 Y118.602 E.06301
G1 X139.398 Y118.602 E.21206
G1 X139.398 Y123.724 E.16989
G1 X137.469 Y123.724 E.064
G1 X137.467 Y126.635 E.09655
G1 X139.398 Y126.634 E.06404
G1 X139.398 Y128.463 E.06065
G1 X137.466 Y128.46 E.06407
G1 X137.465 Y131.356 E.09605
G1 X139.398 Y131.358 E.06411
G1 X139.398 Y137.398 E.20035
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.166 Y118.602 E.18455
G1 X126.165 Y119.039 E.01448
G1 X126.165 Y120.441 E.04653
G1 X126.557 Y120.109 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2579
G1 X128.635 Y120.109 E.06385
G1 X128.635 Y120.068 E.00126
G1 X128.636 Y118.21 E.0571
G1 X128.708 Y118.21 E.00221
G1 X130.562 Y118.21 E.05696
G1 X130.566 Y119.986 E.05458
G1 X130.566 Y120.109 E.00378
G1 X132.614 Y120.109 E.06293
G1 X132.613 Y118.21 E.05836
G1 X139.79 Y118.21 E.22053
G1 X139.79 Y124.115 E.18146
G1 X137.86 Y124.116 E.05929
G1 X137.86 Y126.243 E.06534
G1 X137.9 Y126.243 E.00125
G1 X139.79 Y126.242 E.05807
G1 X139.79 Y126.318 E.00233
G1 X139.79 Y128.785 E.07581
G1 X139.79 Y128.855 E.00216
G1 X137.899 Y128.853 E.0581
G1 X137.858 Y128.853 E.00125
G1 X137.857 Y130.964 E.06488
G1 X139.79 Y130.967 E.05938
G1 X139.79 Y137.79 E.20966
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.558 Y118.21 E.19505
G1 X126.557 Y120.049 E.05652
M204 S10000
; WIPE_START
G1 F24000
G1 X128.556 Y120.107 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.8 I.41 J-1.146 P1  F30000
G1 X125.326 Y118.95 Z13.8
G1 Z13.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2579
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X137.117 Y130.186 F30000
G1 F2579
G1 X137.118 Y128.558 E.05401
G1 X128.626 Y137.05 E.39837
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.156 Y121.168 E.38494
G1 X130.028 Y121.172 E.02893
G1 X130.333 Y120.85 E.01471
G1 X130.526 Y120.85 E.0064
G1 X137.788 Y128.112 E.3407
G1 X137.564 Y128.112 E.00744
G1 X138.693 Y126.983 E.05298
G1 X139.05 Y126.983 E.01182
G1 X139.05 Y128.114 E.03753
G1 X138.909 Y128.114 E.00466
G1 X134.674 Y118.95 F30000
G1 F2579
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X129.825 Y120.783 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.412681
G1 F2579
G1 X129.785 Y120.598 E.0057
G1 X129.785 Y118.99 E.04844
G1 X129.416 Y118.99 E.01112
G1 X129.415 Y120.598 E.04844
G1 X129.371 Y120.783 E.00574
G1 X129.765 Y120.783 E.01187
; CHANGE_LAYER
; Z_HEIGHT: 13.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X129.371 Y120.783 E-.1497
G1 X129.415 Y120.598 E-.07237
G1 X129.416 Y119.183 E-.53793
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 68/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L68
M991 S0 P67 ;notify layer change
G17
G3 Z13.8 I-.444 J-1.133 P1  F30000
G1 X126.052 Y120.502 Z13.8
G1 Z13.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2575
G1 X128.914 Y120.502 E.09492
G1 X128.915 Y118.602 E.06301
G1 X130.299 Y118.602 E.04593
G1 X130.3 Y120.502 E.06301
G1 X133.134 Y120.502 E.094
G1 X133.133 Y118.602 E.06301
G1 X139.398 Y118.602 E.20782
G1 X139.398 Y123.604 E.16592
G1 X137.469 Y123.605 E.06399
G1 X137.468 Y126.518 E.09664
G1 X139.398 Y126.517 E.06403
G1 X139.398 Y128.574 E.06822
G1 X137.467 Y128.571 E.06406
G1 X137.465 Y131.469 E.09612
G1 X139.398 Y131.472 E.0641
G1 X139.398 Y137.398 E.19659
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X126.053 Y118.602 E.18082
G1 X126.053 Y119.103 E.01661
G1 X126.052 Y120.442 E.04441
G1 X126.444 Y120.11 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2575
G1 X128.522 Y120.11 E.06383
G1 X128.522 Y120.068 E.00126
G1 X128.523 Y118.21 E.0571
G1 X128.595 Y118.21 E.00221
G1 X130.688 Y118.21 E.06431
G1 X130.692 Y119.986 E.05458
G1 X130.692 Y120.11 E.00378
G1 X132.742 Y120.11 E.06298
M73 P74 R5
G1 X132.741 Y118.21 E.05837
G1 X139.79 Y118.21 E.2166
G1 X139.79 Y123.996 E.17778
G1 X137.861 Y123.997 E.05928
G1 X137.86 Y126.126 E.06542
G1 X137.901 Y126.126 E.00125
G1 X139.79 Y126.125 E.05806
G1 X139.79 Y126.201 E.00233
G1 X139.79 Y128.896 E.08282
G1 X139.79 Y128.966 E.00216
G1 X137.899 Y128.964 E.05809
G1 X137.859 Y128.964 E.00125
G1 X137.858 Y131.077 E.06494
G1 X139.79 Y131.08 E.05937
G1 X139.79 Y137.79 E.20618
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.445 Y118.21 E.19159
G1 X126.444 Y120.05 E.05652
M204 S10000
; WIPE_START
G1 F24000
G1 X128.444 Y120.107 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14 I.423 J-1.141 P1  F30000
G1 X125.326 Y118.95 Z14
G1 Z13.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2575
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X137.118 Y130.186 F30000
G1 F2575
G1 X137.118 Y128.557 E.05401
G1 X128.626 Y137.05 E.39839
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X129.156 Y121.168 E.38494
G1 X130.028 Y121.172 E.02893
G1 X130.333 Y120.85 E.01471
G1 X130.526 Y120.85 E.00641
G1 X137.9 Y128.224 E.34592
G1 X137.453 Y128.223 E.01482
G1 X138.81 Y126.866 E.06367
G1 X137.182 Y126.867 E.05401
G1 X134.674 Y118.95 F30000
G1 F2575
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X129.855 Y120.711 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.532293
G1 F2575
G3 X129.851 Y119.05 I228.608 J-1.322 E.06622
G1 X129.362 Y119.05 E.01949
G1 X129.362 Y120.479 E.05696
G1 X129.38 Y120.723 E.0098
G1 X129.795 Y120.712 E.01654
; CHANGE_LAYER
; Z_HEIGHT: 13.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X129.38 Y120.723 E-.15764
G1 X129.362 Y120.479 E-.09334
G1 X129.362 Y119.139 E-.50902
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 69/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L69
M991 S0 P68 ;notify layer change
G17
G3 Z14 I-.45 J-1.131 P1  F30000
G1 X125.94 Y120.502 Z14
G1 Z13.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2594
G1 X128.801 Y120.502 E.09491
G1 X128.802 Y118.602 E.06302
G1 X130.425 Y118.602 E.05386
G1 X130.426 Y120.502 E.06302
G1 X133.262 Y120.502 E.09406
G1 X133.261 Y118.602 E.06302
G1 X139.398 Y118.602 E.20358
G1 X139.398 Y123.484 E.16195
G1 X137.469 Y123.485 E.06398
G1 X137.468 Y126.401 E.09673
G1 X139.398 Y126.4 E.06402
G1 X139.398 Y128.685 E.07579
G1 X137.467 Y128.683 E.06405
G1 X137.466 Y131.582 E.09619
G1 X139.398 Y131.585 E.06409
G1 X139.398 Y137.398 E.19283
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.941 Y118.602 E.17709
G1 X125.94 Y119.167 E.01875
G1 X125.94 Y120.442 E.04228
G1 X126.332 Y120.11 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2594
G1 X128.409 Y120.11 E.06382
G1 X128.409 Y120.069 E.00126
G1 X128.41 Y118.21 E.05711
G1 X128.482 Y118.21 E.00221
G1 X130.814 Y118.21 E.07167
G1 X130.818 Y119.987 E.05459
G1 X130.818 Y120.11 E.00378
G1 X132.87 Y120.11 E.06303
G1 X132.869 Y118.21 E.05837
G1 X139.79 Y118.21 E.21268
G1 X139.79 Y123.876 E.17411
G1 X137.861 Y123.877 E.05927
G1 X137.86 Y126.009 E.0655
G1 X137.901 Y126.009 E.00125
G1 X139.79 Y126.008 E.05804
G1 X139.79 Y126.084 E.00233
G1 X139.79 Y129.007 E.08983
G1 X139.79 Y129.078 E.00216
G1 X137.9 Y129.075 E.05809
G1 X137.859 Y129.075 E.00125
G1 X137.858 Y131.191 E.06501
G1 X139.79 Y131.193 E.05937
G1 X139.79 Y137.79 E.2027
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.333 Y118.21 E.18814
G1 X126.332 Y120.05 E.05653
M204 S10000
; WIPE_START
G1 F24000
G1 X128.331 Y120.107 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.2 I.437 J-1.136 P1  F30000
G1 X125.326 Y118.95 Z14.2
G1 Z13.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2594
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2594
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X133.609 Y118.95 E.08933
G1 X133.61 Y120.85 E.06302
G1 X130.526 Y120.85 E.10231
G1 X138.011 Y128.335 E.35114
G1 X139.05 Y128.336 E.03445
G1 X139.05 Y126.749 E.05267
G1 X138.927 Y126.749 E.00406
G1 X137.342 Y128.334 E.07437
G1 X137.119 Y128.334 E.00739
G1 X137.119 Y128.557 E.00741
G1 X128.626 Y137.05 E.3984
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X130.078 Y120.246 E.4282
G1 X130.078 Y120.402 E.00518
G1 X129.149 Y119.473 E.04356
G1 X129.15 Y118.95 E.01735
G1 X130.077 Y118.95 E.03077
M73 P75 R5
G1 X130.077 Y119.128 E.00589
; CHANGE_LAYER
; Z_HEIGHT: 14
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X130.077 Y118.95 E-.06747
G1 X129.15 Y118.95 E-.35249
G1 X129.149 Y119.473 E-.1988
G1 X129.412 Y119.736 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 70/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L70
M991 S0 P69 ;notify layer change
G17
G3 Z14.2 I-.254 J-1.19 P1  F30000
G1 X125.827 Y120.502 Z14.2
G1 Z14
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2602
G1 X128.688 Y120.502 E.09489
G1 X128.689 Y118.602 E.06302
G1 X130.552 Y118.602 E.0618
G1 X130.553 Y120.502 E.06302
G1 X133.39 Y120.502 E.09411
G1 X133.389 Y118.602 E.06302
G1 X139.398 Y118.602 E.19934
G1 X139.398 Y123.365 E.15799
G1 X137.47 Y123.366 E.06396
G1 X137.468 Y126.284 E.09682
G1 X139.398 Y126.283 E.06401
G1 X139.398 Y128.796 E.08336
G1 X137.467 Y128.794 E.06404
G1 X137.466 Y131.696 E.09626
G1 X139.398 Y131.698 E.06409
G1 X139.398 Y137.398 E.18907
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.828 Y118.602 E.17336
G1 X125.828 Y119.231 E.02088
G1 X125.827 Y120.442 E.04015
G1 X126.219 Y120.11 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2602
G1 X128.296 Y120.11 E.0638
G1 X128.296 Y120.069 E.00126
G1 X128.297 Y118.21 E.05711
G1 X128.369 Y118.21 E.00221
G1 X130.94 Y118.21 E.07902
G1 X130.944 Y119.987 E.05459
G1 X130.945 Y120.11 E.00378
G1 X132.997 Y120.11 E.06308
G1 X132.996 Y118.21 E.05838
G1 X139.79 Y118.21 E.20875
G1 X139.79 Y123.757 E.17043
G1 X137.862 Y123.758 E.05926
G1 X137.861 Y125.892 E.06559
G1 X137.901 Y125.892 E.00125
G1 X139.79 Y125.891 E.05803
G1 X139.79 Y125.967 E.00233
G1 X139.79 Y129.119 E.09684
G1 X139.79 Y129.189 E.00216
G1 X137.9 Y129.186 E.05808
G1 X137.859 Y129.186 E.00125
G1 X137.858 Y131.304 E.06507
G1 X139.79 Y131.307 E.05936
G1 X139.79 Y137.79 E.19922
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.22 Y118.21 E.18468
G1 X126.22 Y120.05 E.05653
M204 S10000
; WIPE_START
G1 F24000
G1 X128.219 Y120.108 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.4 I.452 J-1.13 P1  F30000
G1 X125.326 Y118.95 Z14.4
G1 Z14
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2602
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2602
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X133.737 Y118.95 E.08509
G1 X133.738 Y120.85 E.06302
G1 X130.526 Y120.85 E.10655
G1 X138.122 Y128.446 E.35635
G1 X139.05 Y128.448 E.03076
G1 X139.044 Y126.632 E.06023
G1 X137.231 Y128.445 E.08507
G1 X137.119 Y128.445 E.0037
G1 X137.119 Y128.557 E.00371
G1 X128.626 Y137.05 E.39841
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X130.204 Y120.12 E.43412
G1 X130.204 Y120.528 E.01355
G1 X129.037 Y119.361 E.05479
G1 X129.037 Y118.95 E.01361
G1 X130.204 Y118.95 E.03871
G1 X130.204 Y119.002 E.0017
; CHANGE_LAYER
; Z_HEIGHT: 14.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X130.204 Y118.95 E-.01948
G1 X129.037 Y118.95 E-.44341
G1 X129.037 Y119.361 E-.15588
G1 X129.299 Y119.623 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 71/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L71
M991 S0 P70 ;notify layer change
G17
G3 Z14.4 I-.29 J-1.182 P1  F30000
G1 X125.715 Y120.502 Z14.4
G1 Z14.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2579
G1 X128.575 Y120.502 E.09487
G1 X128.576 Y118.602 E.06303
G1 X130.678 Y118.602 E.06974
G1 X130.679 Y120.502 E.06303
G1 X133.518 Y120.502 E.09416
G1 X133.517 Y118.602 E.06303
G1 X139.398 Y118.602 E.1951
G1 X139.398 Y123.245 E.15402
G1 X137.47 Y123.246 E.06395
G1 X137.469 Y126.167 E.0969
G1 X139.398 Y126.166 E.06399
G1 X139.398 Y128.908 E.09093
G1 X137.468 Y128.905 E.06403
G1 X137.466 Y131.809 E.09633
G1 X139.398 Y131.812 E.06408
G1 X139.398 Y137.398 E.18531
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.716 Y118.602 E.16963
G1 X125.715 Y119.296 E.02301
G1 X125.715 Y120.442 E.03803
G1 X126.107 Y120.11 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2579
G1 X128.183 Y120.11 E.06378
G1 X128.183 Y120.069 E.00126
G1 X128.184 Y118.21 E.05712
G1 X128.256 Y118.21 E.00221
G1 X131.067 Y118.21 E.08637
M73 P76 R5
G1 X131.071 Y119.987 E.0546
G1 X131.071 Y120.11 E.00378
G1 X133.125 Y120.11 E.06313
G1 X133.124 Y118.21 E.05838
G1 X139.79 Y118.21 E.20482
G1 X139.79 Y123.637 E.16676
G1 X137.862 Y123.638 E.05924
G1 X137.861 Y125.775 E.06567
G1 X137.902 Y125.775 E.00125
G1 X139.79 Y125.774 E.05802
G1 X139.79 Y125.85 E.00233
G1 X139.79 Y129.23 E.10385
G1 X139.79 Y129.3 E.00216
G1 X137.9 Y129.298 E.05807
G1 X137.859 Y129.298 E.00125
G1 X137.858 Y131.417 E.06514
G1 X139.79 Y131.42 E.05935
G1 X139.79 Y137.79 E.19573
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X126.108 Y118.21 E.18123
G1 X126.107 Y120.05 E.05654
M204 S10000
; WIPE_START
G1 F24000
G1 X128.106 Y120.108 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.6 I.468 J-1.123 P1  F30000
G1 X125.326 Y118.95 Z14.6
G1 Z14.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2579
G1 X123.698 Y118.95 E.05401
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2579
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
G1 X137.533 Y126.516 F30000
G1 F2579
G1 X139.05 Y126.515 E.05032
G1 X139.05 Y126.626 E.0037
G1 X128.626 Y137.05 E.48898
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X130.33 Y119.994 E.44004
G1 X130.33 Y118.95 E.03461
G1 X128.924 Y118.95 E.04664
G1 X128.924 Y119.248 E.00986
G1 X130.331 Y120.655 E.06601
M73 P76 R4
G1 X130.331 Y120.85 E.00649
G1 X130.526 Y120.85 E.00649
G1 X138.234 Y128.558 E.36157
G1 X139.05 Y128.559 E.02707
G1 X139.05 Y127.746 E.02695
; CHANGE_LAYER
; Z_HEIGHT: 14.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X139.05 Y128.559 E-.3087
G1 X138.234 Y128.558 E-.31006
G1 X137.971 Y128.295 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 72/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L72
M991 S0 P71 ;notify layer change
G17
G3 Z14.6 I.649 J-1.03 P1  F30000
G1 X125.602 Y120.502 Z14.6
G1 Z14.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2589
G1 X128.462 Y120.502 E.09485
G1 X128.463 Y118.602 E.06303
G1 X130.804 Y118.602 E.07767
G1 X130.805 Y120.502 E.06303
G1 X133.645 Y120.502 E.09422
G1 X133.644 Y118.602 E.06303
G1 X139.398 Y118.602 E.19086
G1 X139.398 Y123.125 E.15005
G1 X137.47 Y123.126 E.06394
G1 X137.469 Y126.05 E.09699
G1 X139.398 Y126.049 E.06398
G1 X139.398 Y129.019 E.0985
G1 X137.468 Y129.016 E.06403
G1 X137.466 Y131.922 E.0964
G1 X139.398 Y131.925 E.06407
G1 X139.398 Y137.398 E.18155
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.603 Y118.602 E.1659
G1 X125.603 Y119.36 E.02514
G1 X125.602 Y120.442 E.0359
G1 X125.995 Y120.11 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2589
G1 X128.07 Y120.11 E.06377
G1 X128.07 Y120.069 E.00126
G1 X128.071 Y118.21 E.05712
G1 X128.143 Y118.21 E.00221
G1 X131.193 Y118.21 E.09372
G1 X131.197 Y119.987 E.0546
G1 X131.197 Y120.11 E.00378
G1 X133.253 Y120.11 E.06318
G1 X133.252 Y118.21 E.05839
G1 X139.79 Y118.21 E.20089
G1 X139.79 Y123.517 E.16308
G1 X137.862 Y123.518 E.05923
G1 X137.861 Y125.658 E.06575
G1 X137.902 Y125.658 E.00125
G1 X139.79 Y125.657 E.05801
G1 X139.79 Y125.733 E.00233
G1 X139.79 Y129.341 E.11086
G1 X139.79 Y129.411 E.00216
G1 X137.9 Y129.409 E.05806
G1 X137.86 Y129.409 E.00125
G1 X137.859 Y131.531 E.0652
G1 X139.79 Y131.533 E.05934
G1 X139.79 Y137.79 E.19225
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.995 Y118.21 E.17777
G1 X125.995 Y120.05 E.05654
M204 S10000
; WIPE_START
G1 F24000
G1 X127.994 Y120.108 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.8 I.449 J-1.131 P1  F30000
G1 X125.255 Y119.022 Z14.8
G1 Z14.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2589
G1 X125.255 Y118.95 E.00236
G1 X123.698 Y118.95 E.05165
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2589
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
G1 X137.65 Y126.399 F30000
G1 F2589
G1 X139.05 Y126.398 E.04644
G1 X139.05 Y126.626 E.00758
G1 X128.626 Y137.05 E.48898
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X130.457 Y119.867 E.44596
G1 X130.456 Y118.95 E.03042
M73 P77 R4
G1 X128.811 Y118.95 E.05458
G1 X128.811 Y119.135 E.00611
G1 X130.457 Y120.781 E.07724
G1 X130.457 Y120.851 E.0023
G1 X130.526 Y120.851 E.0023
G1 X138.345 Y128.669 E.36679
G1 X139.05 Y128.67 E.02337
G1 X139.05 Y127.746 E.03064
; CHANGE_LAYER
; Z_HEIGHT: 14.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X139.05 Y128.67 E-.35102
G1 X138.345 Y128.669 E-.26774
G1 X138.082 Y128.406 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 73/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L73
M991 S0 P72 ;notify layer change
G17
G3 Z14.8 I.647 J-1.031 P1  F30000
G1 X125.49 Y120.502 Z14.8
G1 Z14.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2593
G1 X128.349 Y120.502 E.09483
G1 X128.35 Y118.602 E.06304
G1 X130.93 Y118.602 E.08561
G1 X130.931 Y120.502 E.06304
G1 X133.773 Y120.502 E.09427
G1 X133.772 Y118.602 E.06304
G1 X139.398 Y118.602 E.18662
G1 X139.398 Y123.006 E.14608
G1 X137.471 Y123.007 E.06393
G1 X137.469 Y125.933 E.09708
G1 X139.398 Y125.933 E.06397
G1 X139.398 Y129.13 E.10607
G1 X137.468 Y129.127 E.06402
G1 X137.467 Y132.036 E.09647
G1 X139.398 Y132.038 E.06406
G1 X139.398 Y137.398 E.17779
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.491 Y118.602 E.16217
G1 X125.49 Y119.424 E.02728
G1 X125.49 Y120.442 E.03377
G1 X125.882 Y120.11 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2593
G1 X127.957 Y120.11 E.06375
G1 X127.957 Y120.069 E.00126
G1 X127.958 Y118.21 E.05713
G1 X128.03 Y118.21 E.00221
G1 X131.319 Y118.21 E.10107
G1 X131.323 Y119.987 E.05461
G1 X131.323 Y120.11 E.00378
G1 X133.381 Y120.11 E.06323
G1 X133.38 Y118.21 E.05839
G1 X139.79 Y118.21 E.19696
G1 X139.79 Y123.398 E.15941
G1 X137.863 Y123.399 E.05922
G1 X137.862 Y125.541 E.06583
G1 X137.902 Y125.541 E.00125
G1 X139.79 Y125.54 E.058
G1 X139.79 Y125.616 E.00233
G1 X139.79 Y129.452 E.11787
G1 X139.79 Y129.523 E.00216
G1 X137.901 Y129.52 E.05805
G1 X137.86 Y129.52 E.00125
G1 X137.859 Y131.644 E.06527
G1 X139.79 Y131.647 E.05933
G1 X139.79 Y137.79 E.18877
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.883 Y118.21 E.17432
G1 X125.882 Y120.05 E.05655
M204 S10000
; WIPE_START
G1 F24000
G1 X127.881 Y120.108 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15 I.408 J-1.147 P1  F30000
G1 X125.142 Y119.134 Z15
G1 Z14.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2593
G1 X125.142 Y118.95 E.0061
G1 X123.698 Y118.95 E.04792
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2593
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
G1 X137.767 Y126.282 F30000
G1 F2593
G1 X139.05 Y126.281 E.04256
G1 X139.05 Y126.626 E.01146
G1 X128.626 Y137.05 E.48898
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X130.583 Y119.741 E.45187
G1 X130.582 Y118.95 E.02624
G1 X128.698 Y118.95 E.06252
G1 X128.698 Y119.022 E.00237
G1 X138.456 Y128.78 E.4578
G1 X139.05 Y128.781 E.01968
G1 X139.05 Y127.746 E.03434
; CHANGE_LAYER
; Z_HEIGHT: 14.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X139.05 Y128.781 E-.39333
G1 X138.456 Y128.78 E-.22543
G1 X138.194 Y128.518 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 74/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L74
M991 S0 P73 ;notify layer change
G17
G3 Z15 I.645 J-1.032 P1  F30000
G1 X125.377 Y120.503 Z15
G1 Z14.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2596
G1 X128.236 Y120.503 E.09482
G1 X128.237 Y118.602 E.06304
G1 X131.057 Y118.602 E.09355
G1 X131.058 Y120.503 E.06304
G1 X133.901 Y120.503 E.09432
G1 X133.9 Y118.602 E.06304
G1 X139.398 Y118.602 E.18238
G1 X139.398 Y122.886 E.14211
G1 X137.471 Y122.887 E.06392
G1 X137.47 Y125.816 E.09717
G1 X139.398 Y125.816 E.06396
G1 X139.398 Y129.241 E.11363
G1 X137.468 Y129.239 E.06401
G1 X137.467 Y132.149 E.09654
G1 X139.398 Y132.151 E.06405
G1 X139.398 Y137.398 E.17403
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.378 Y118.602 E.15843
G1 X125.378 Y119.489 E.02941
G1 X125.377 Y120.443 E.03165
G1 X125.77 Y120.111 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2596
G1 X127.844 Y120.111 E.06373
G1 X127.844 Y120.069 E.00126
G1 X127.845 Y118.21 E.05713
M73 P78 R4
G1 X127.917 Y118.21 E.00221
G1 X131.445 Y118.21 E.10842
G1 X131.449 Y119.987 E.05461
G1 X131.45 Y120.111 E.00378
G1 X133.509 Y120.111 E.06327
G1 X133.508 Y118.21 E.0584
G1 X139.79 Y118.21 E.19304
G1 X139.79 Y123.278 E.15573
G1 X137.863 Y123.279 E.05921
G1 X137.862 Y125.424 E.06591
G1 X137.903 Y125.424 E.00125
G1 X139.79 Y125.423 E.05799
G1 X139.79 Y125.499 E.00233
G1 X139.79 Y129.564 E.12488
G1 X139.79 Y129.634 E.00216
G1 X137.901 Y129.631 E.05805
G1 X137.86 Y129.631 E.00125
G1 X137.859 Y131.757 E.06533
G1 X139.79 Y131.76 E.05933
G1 X139.79 Y137.79 E.18529
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.771 Y118.21 E.17086
G1 X125.77 Y120.051 E.05655
M204 S10000
; WIPE_START
G1 F24000
G1 X127.769 Y120.108 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15.2 I.365 J-1.161 P1  F30000
G1 X125.03 Y119.247 Z15.2
G1 Z14.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2596
G1 X125.03 Y118.95 E.00983
G1 X123.698 Y118.95 E.04419
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2596
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
G1 X137.884 Y126.165 F30000
G1 F2596
G1 X139.05 Y126.164 E.03868
G1 X139.05 Y126.626 E.01534
G1 X128.626 Y137.05 E.48898
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X130.709 Y119.615 E.45779
G1 X130.709 Y118.95 E.02205
G1 X128.626 Y118.95 E.06907
G1 X138.568 Y128.892 E.46638
G1 X139.05 Y128.892 E.01598
G1 X139.05 Y127.746 E.03803
; CHANGE_LAYER
; Z_HEIGHT: 15
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X139.05 Y128.892 E-.43565
G1 X138.568 Y128.892 E-.18311
G1 X138.305 Y128.629 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 75/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L75
M991 S0 P74 ;notify layer change
G17
G3 Z15.2 I.644 J-1.033 P1  F30000
G1 X125.265 Y120.503 Z15.2
G1 Z15
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2599
G1 X128.123 Y120.503 E.0948
G1 X128.124 Y118.602 E.06305
G1 X131.183 Y118.602 E.10148
G1 X131.184 Y120.503 E.06305
G1 X134.029 Y120.503 E.09437
G1 X134.028 Y118.602 E.06305
G1 X139.398 Y118.602 E.17814
G1 X139.398 Y122.767 E.13815
G1 X137.471 Y122.768 E.0639
G1 X137.47 Y125.699 E.09726
G1 X139.398 Y125.699 E.06395
G1 X139.398 Y129.352 E.1212
G1 X137.469 Y129.35 E.064
G1 X137.467 Y132.262 E.09661
G1 X139.398 Y132.265 E.06404
G1 X139.398 Y137.398 E.17028
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.266 Y118.602 E.1547
G1 X125.265 Y119.553 E.03154
G1 X125.265 Y120.443 E.02952
G1 X125.657 Y120.111 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2599
G1 X127.731 Y120.111 E.06372
G1 X127.731 Y120.07 E.00126
G1 X127.732 Y118.21 E.05714
G1 X127.804 Y118.21 E.00221
G1 X131.572 Y118.21 E.11577
G1 X131.576 Y119.988 E.05462
G1 X131.576 Y120.111 E.00378
G1 X133.637 Y120.111 E.06332
G1 X133.636 Y118.21 E.0584
G1 X139.79 Y118.21 E.18911
G1 X139.79 Y123.159 E.15206
G1 X137.863 Y123.159 E.0592
G1 X137.862 Y125.307 E.06599
G1 X137.903 Y125.307 E.00125
G1 X139.79 Y125.306 E.05798
G1 X139.79 Y125.382 E.00233
G1 X139.79 Y129.675 E.1319
G1 X139.79 Y129.745 E.00216
G1 X137.901 Y129.743 E.05804
G1 X137.86 Y129.742 E.00125
G1 X137.86 Y131.871 E.06539
G1 X139.79 Y131.873 E.05932
G1 X139.79 Y137.79 E.18181
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.658 Y118.21 E.1674
G1 X125.657 Y120.051 E.05656
M204 S10000
; WIPE_START
G1 F24000
G1 X127.656 Y120.109 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15.4 I.321 J-1.174 P1  F30000
G1 X124.917 Y119.359 Z15.4
G1 Z15
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2599
G1 X124.917 Y118.95 E.01356
G1 X123.698 Y118.95 E.04046
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X125.326 Y137.05 F30000
G1 F2599
G1 X123.698 Y137.05 E.05401
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
M73 P79 R4
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.674 Y118.95 E.05401
G1 X138.001 Y126.048 F30000
G1 F2599
G1 X139.05 Y126.047 E.0348
G1 X139.05 Y126.626 E.01922
G1 X128.626 Y137.05 E.48898
G1 X131.374 Y137.05 E.09114
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X130.835 Y119.489 E.46371
G1 X130.835 Y118.95 E.01787
G1 X128.626 Y118.95 E.07326
G1 X138.679 Y129.003 E.4716
G1 X139.05 Y129.004 E.01229
G1 X139.05 Y127.746 E.04172
; CHANGE_LAYER
; Z_HEIGHT: 15.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X139.05 Y129.004 E-.47796
G1 X138.679 Y129.003 E-.1408
G1 X138.416 Y128.74 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 76/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L76
M991 S0 P75 ;notify layer change
G17
G3 Z15.4 I.642 J-1.034 P1  F30000
G1 X125.152 Y120.503 Z15.4
G1 Z15.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2578
G1 X128.01 Y120.503 E.09478
G1 X128.011 Y118.602 E.06305
G1 X131.309 Y118.602 E.10942
G1 X131.31 Y120.503 E.06305
G1 X134.157 Y120.503 E.09443
G1 X134.156 Y118.602 E.06305
G1 X139.398 Y118.602 E.17389
G1 X139.398 Y122.647 E.13418
G1 X137.472 Y122.648 E.06389
G1 X137.471 Y125.583 E.09734
G1 X139.398 Y125.582 E.06393
G1 X139.398 Y129.464 E.12877
G1 X137.469 Y129.461 E.06399
G1 X137.468 Y132.376 E.09668
G1 X139.398 Y132.378 E.06403
G1 X139.398 Y137.398 E.16652
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.153 Y118.602 E.15097
G1 X125.153 Y119.617 E.03367
G1 X125.152 Y120.443 E.02739
G1 X125.545 Y120.111 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2578
G1 X127.618 Y120.111 E.0637
G1 X127.618 Y120.07 E.00126
G1 X127.619 Y118.21 E.05714
G1 X127.691 Y118.21 E.00221
G1 X131.698 Y118.21 E.12312
G1 X131.702 Y119.988 E.05462
G1 X131.702 Y120.111 E.00378
G1 X133.764 Y120.111 E.06337
G1 X133.763 Y118.21 E.05841
G1 X139.79 Y118.21 E.18518
G1 X139.79 Y123.039 E.14838
G1 X137.864 Y123.04 E.05919
G1 X137.863 Y125.19 E.06608
G1 X137.903 Y125.19 E.00125
G1 X139.79 Y125.189 E.05797
G1 X139.79 Y125.265 E.00233
G1 X139.79 Y129.786 E.13891
G1 X139.79 Y129.856 E.00216
G1 X137.901 Y129.854 E.05803
G1 X137.861 Y129.854 E.00125
G1 X137.86 Y131.984 E.06546
G1 X139.79 Y131.987 E.05931
G1 X139.79 Y137.79 E.17832
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.546 Y118.21 E.16395
G1 X125.545 Y120.051 E.05656
M204 S10000
G1 X124.805 Y119.471 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2578
G1 X124.805 Y118.95 E.01729
G1 X123.698 Y118.95 E.03673
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X137.162 Y129.112 F30000
G1 F2578
G1 X138.79 Y129.115 E.05401
G1 X128.626 Y118.95 E.47682
G1 X130.961 Y118.95 E.07745
G1 X130.961 Y119.363 E.01368
G1 X120.95 Y129.374 E.46963
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y125.93 E.0231
G1 X138.118 Y125.931 E.03092
G1 X134.674 Y118.95 F30000
G1 F2578
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 15.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y137.05 E-.61876
G1 X123.435 Y136.787 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 77/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L77
M991 S0 P76 ;notify layer change
G17
G3 Z15.6 I1.211 J.119 P1  F30000
G1 X125.04 Y120.503 Z15.6
G1 Z15.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2581
G1 X127.897 Y120.503 E.09476
G1 X127.898 Y118.602 E.06306
G1 X131.435 Y118.602 E.11735
G1 X131.436 Y120.503 E.06306
G1 X134.285 Y120.503 E.09448
G1 X134.284 Y118.602 E.06306
G1 X139.398 Y118.602 E.16965
G1 X139.398 Y122.527 E.13021
G1 X137.472 Y122.528 E.06388
G1 X137.471 Y125.466 E.09743
G1 X139.398 Y125.465 E.06392
G1 X139.398 Y129.575 E.13634
G1 X137.469 Y129.572 E.06398
G1 X137.468 Y132.489 E.09675
G1 X139.398 Y132.491 E.06403
G1 X139.398 Y137.398 E.16276
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.041 Y118.602 E.14724
G1 X125.04 Y119.681 E.0358
G1 X125.04 Y120.443 E.02527
G1 X125.432 Y120.111 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2581
G1 X127.505 Y120.111 E.06369
G1 X127.505 Y120.07 E.00126
G1 X127.506 Y118.21 E.05715
G1 X127.578 Y118.21 E.00221
G1 X131.824 Y118.21 E.13048
M73 P80 R4
G1 X131.828 Y119.988 E.05463
G1 X131.828 Y120.111 E.00378
G1 X133.892 Y120.111 E.06342
G1 X133.891 Y118.21 E.05841
G1 X139.79 Y118.21 E.18125
G1 X139.79 Y122.919 E.14471
G1 X137.864 Y122.92 E.05918
G1 X137.863 Y125.073 E.06616
G1 X137.904 Y125.073 E.00125
G1 X139.79 Y125.072 E.05796
G1 X139.79 Y125.148 E.00233
G1 X139.79 Y129.897 E.14592
G1 X139.79 Y129.967 E.00216
G1 X137.902 Y129.965 E.05802
G1 X137.861 Y129.965 E.00125
G1 X137.86 Y132.097 E.06552
G1 X139.79 Y132.1 E.0593
G1 X139.79 Y137.79 E.17484
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.433 Y118.21 E.16049
G1 X125.432 Y120.051 E.05657
M204 S10000
G1 X124.692 Y119.584 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2581
G1 X124.692 Y118.95 E.02102
G1 X123.698 Y118.95 E.033
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X137.274 Y129.224 F30000
G1 F2581
G1 X138.902 Y129.226 E.05401
G1 X128.626 Y118.95 E.48205
G1 X131.087 Y118.95 E.08164
G1 X131.087 Y119.237 E.0095
G1 X120.95 Y129.374 E.47555
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y125.813 E.02697
G1 X138.235 Y125.814 E.02704
G1 X134.674 Y118.95 F30000
G1 F2581
G1 X136.302 Y118.95 E.05401
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 15.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X123.698 Y137.05 E-.61876
G1 X123.435 Y136.787 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 78/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L78
M991 S0 P77 ;notify layer change
G17
G3 Z15.8 I1.212 J.111 P1  F30000
G1 X124.928 Y120.503 Z15.8
G1 Z15.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2583
G1 X127.784 Y120.503 E.09475
G1 X127.785 Y118.602 E.06307
G1 X131.562 Y118.602 E.12529
G1 X131.563 Y120.503 E.06307
G1 X134.412 Y120.503 E.09453
G1 X134.411 Y118.602 E.06307
G1 X139.398 Y118.602 E.16541
G1 X139.398 Y122.408 E.12624
G1 X137.473 Y122.409 E.06387
G1 X137.471 Y125.349 E.09752
G1 X139.398 Y125.348 E.06391
G1 X139.398 Y129.686 E.14391
G1 X137.469 Y129.683 E.06397
G1 X137.468 Y132.602 E.09682
G1 X139.398 Y132.605 E.06402
G1 X139.398 Y137.398 E.159
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X124.928 Y118.602 E.14351
G1 X124.928 Y119.746 E.03794
G1 X124.928 Y120.443 E.02314
G1 X125.32 Y120.111 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2583
G1 X127.392 Y120.111 E.06367
G1 X127.392 Y120.07 E.00126
G1 X127.393 Y118.21 E.05715
G1 X127.465 Y118.21 E.00221
G1 X131.95 Y118.21 E.13783
G1 X131.954 Y119.988 E.05463
G1 X131.954 Y120.111 E.00378
G1 X134.02 Y120.111 E.06347
G1 X134.019 Y118.21 E.05842
G1 X139.79 Y118.21 E.17732
G1 X139.79 Y122.8 E.14103
G1 X137.864 Y122.801 E.05917
G1 X137.864 Y124.956 E.06624
G1 X137.904 Y124.956 E.00125
G1 X139.79 Y124.955 E.05795
G1 X139.79 Y125.031 E.00233
G1 X139.79 Y130.008 E.15293
G1 X139.79 Y130.079 E.00216
G1 X137.902 Y130.076 E.05802
G1 X137.861 Y130.076 E.00125
G1 X137.86 Y132.211 E.06559
G1 X139.79 Y132.213 E.05929
G1 X139.79 Y137.79 E.17136
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.321 Y118.21 E.15704
G1 X125.32 Y120.051 E.05657
M204 S10000
G1 X124.58 Y119.696 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2583
G1 X124.58 Y118.95 E.02475
G1 X123.698 Y118.95 E.02927
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X134.674 Y137.05 E.05401
G1 X137.385 Y129.335 F30000
G1 F2583
G1 X139.013 Y129.337 E.05401
G1 X128.626 Y118.95 E.48727
G1 X131.214 Y118.95 E.08582
G1 X131.214 Y119.11 E.00531
G1 X120.95 Y129.374 E.48147
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
M73 P81 R4
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y125.696 E.03085
G1 X138.351 Y125.697 E.02316
G1 X134.76 Y119.036 F30000
G1 F2583
G1 X134.76 Y118.95 E.00285
G1 X136.302 Y118.95 E.05117
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 15.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X123.698 Y137.05 E-.61876
G1 X123.435 Y136.787 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 79/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L79
M991 S0 P78 ;notify layer change
G17
G3 Z16 I1.213 J.103 P1  F30000
M73 P81 R3
G1 X124.815 Y120.503 Z16
G1 Z15.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2600
G1 X127.671 Y120.503 E.09473
G1 X127.672 Y118.602 E.06307
G1 X131.688 Y118.602 E.13323
G1 X131.689 Y120.503 E.06307
G1 X134.54 Y120.503 E.09458
G1 X134.539 Y118.602 E.06307
G1 X139.398 Y118.602 E.16117
G1 X139.398 Y122.288 E.12228
G1 X137.473 Y122.289 E.06386
G1 X137.472 Y125.232 E.09761
G1 X139.398 Y125.231 E.0639
G1 X139.398 Y129.797 E.15148
G1 X137.47 Y129.795 E.06397
G1 X137.468 Y132.716 E.09689
G1 X139.398 Y132.718 E.06401
G1 X139.398 Y137.398 E.15524
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X124.816 Y118.602 E.13978
G1 X124.815 Y119.81 E.04007
G1 X124.815 Y120.443 E.02101
G1 X125.207 Y120.111 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2600
G1 X127.279 Y120.111 E.06365
G1 X127.279 Y120.07 E.00126
G1 X127.28 Y118.21 E.05716
G1 X127.352 Y118.21 E.00221
G1 X132.076 Y118.21 E.14518
G1 X132.081 Y119.988 E.05464
G1 X132.081 Y120.111 E.00378
G1 X134.148 Y120.111 E.06352
G1 X134.147 Y118.21 E.05842
G1 X139.79 Y118.21 E.1734
G1 X139.79 Y122.68 E.13735
G1 X137.865 Y122.681 E.05916
G1 X137.864 Y124.839 E.06632
G1 X137.905 Y124.839 E.00125
G1 X139.79 Y124.839 E.05793
G1 X139.79 Y124.914 E.00233
G1 X139.79 Y130.12 E.15994
G1 X139.79 Y130.19 E.00216
G1 X137.902 Y130.187 E.05801
G1 X137.861 Y130.187 E.00125
G1 X137.861 Y132.324 E.06565
G1 X139.79 Y132.326 E.05929
G1 X139.79 Y137.79 E.16788
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.208 Y118.21 E.15358
G1 X125.207 Y120.051 E.05658
M204 S10000
G1 X124.467 Y119.809 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2600
G1 X124.468 Y118.95 E.02848
G1 X123.698 Y118.95 E.02554
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X131.34 Y118.95 E.48819
G1 X128.626 Y118.95 E.09001
G1 X139.05 Y129.374 E.48898
G1 X139.05 Y126.626 E.09114
G1 X128.626 Y137.05 E.48898
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X134.888 Y118.95 E.04693
G1 X134.888 Y119.164 E.00709
; CHANGE_LAYER
; Z_HEIGHT: 16
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F24000
G1 X134.888 Y118.95 E-.0812
G1 X136.302 Y118.95 E-.53756
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 80/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L80
M991 S0 P79 ;notify layer change
G17
G3 Z16.2 I-.132 J-1.21 P1  F30000
G1 X124.703 Y120.504 Z16.2
G1 Z16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2597
G1 X127.558 Y120.504 E.09471
G1 X127.559 Y118.602 E.06308
G1 X131.814 Y118.602 E.14116
G1 X131.815 Y120.504 E.06308
G1 X134.668 Y120.504 E.09464
G1 X134.667 Y118.602 E.06308
G1 X139.398 Y118.602 E.15693
G1 X139.398 Y122.169 E.11831
G1 X137.473 Y122.17 E.06384
G1 X137.472 Y125.115 E.0977
G1 X139.398 Y125.114 E.06389
G1 X139.398 Y129.908 E.15904
G1 X137.47 Y129.906 E.06396
G1 X137.469 Y132.829 E.09696
G1 X139.398 Y132.831 E.064
G1 X139.398 Y137.398 E.15148
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X124.703 Y118.602 E.13605
G1 X124.703 Y120.444 E.06109
G1 X125.095 Y120.112 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2597
G1 X127.166 Y120.112 E.06364
G1 X127.166 Y120.07 E.00126
G1 X127.167 Y118.21 E.05716
G1 X127.239 Y118.21 E.00221
G1 X132.203 Y118.21 E.15253
G1 X132.207 Y119.988 E.05464
G1 X132.207 Y120.112 E.00378
G1 X134.276 Y120.112 E.06357
M73 P82 R3
G1 X134.275 Y118.21 E.05843
G1 X139.79 Y118.21 E.16947
G1 X139.79 Y122.561 E.13368
G1 X137.865 Y122.561 E.05914
G1 X137.864 Y124.722 E.0664
G1 X137.905 Y124.722 E.00125
G1 X139.79 Y124.722 E.05792
G1 X139.79 Y124.798 E.00233
G1 X139.79 Y130.231 E.16695
G1 X139.79 Y130.301 E.00216
G1 X137.902 Y130.299 E.058
G1 X137.862 Y130.299 E.00125
G1 X137.861 Y132.437 E.06572
G1 X139.79 Y132.44 E.05928
G1 X139.79 Y137.79 E.1644
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.096 Y118.21 E.15013
G1 X125.095 Y120.052 E.05658
M204 S10000
G1 X124.355 Y119.921 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2597
G1 X124.355 Y118.95 E.03221
G1 X123.698 Y118.95 E.0218
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X139.05 Y137.05 E.84908
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X120.95 Y126.626 E.48898
G1 X120.95 Y129.374 E.09114
G1 X131.374 Y118.95 E.48898
G1 X128.626 Y118.95 E.09114
G1 X139.05 Y129.374 E.48898
G1 X139.05 Y126.626 E.09114
G1 X128.626 Y137.05 E.48898
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X139.05 Y118.95 E.84908
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X135.015 Y118.95 E.04269
G1 X135.016 Y119.292 E.01133
; CHANGE_LAYER
; Z_HEIGHT: 16.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X135.015 Y118.95 E-.12977
G1 X136.302 Y118.95 E-.48899
G1 X136.565 Y119.213 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 81/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L81
M991 S0 P80 ;notify layer change
G17
G3 Z16.4 I-1.202 J.187 P1  F30000
G1 X139.398 Y137.398 Z16.4
G1 Z16.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2911
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X125.506 Y118.602 E.16266
M204 S5000
; FEATURE: Overhang wall
M106 S255
G1 F3000
G1 X126.757 Y118.602 E.0415
M106 S252.45
M204 S10000
; FEATURE: Inner wall
G1 F2911
G1 X132.616 Y118.602 E.19437
M204 S5000
; FEATURE: Overhang wall
M106 S255
G1 F3000
G1 X133.865 Y118.602 E.04142
M106 S252.45
M204 S10000
; FEATURE: Inner wall
G1 F2911
G1 X139.398 Y118.602 E.18354
G1 X139.398 Y122.971 E.14492
M204 S5000
; FEATURE: Overhang wall
M106 S255
G1 F3000
G1 X139.398 Y124.312 E.04449
M106 S252.45
M204 S10000
; FEATURE: Inner wall
G1 F2911
G1 X139.398 Y130.711 E.21226
M204 S5000
; FEATURE: Overhang wall
M106 S255
G1 F3000
G1 X139.398 Y132.029 E.04375
M106 S252.45
M204 S10000
; FEATURE: Inner wall
G1 F2911
G1 X139.398 Y132.412 E.01269
G1 X139.398 Y137.338 E.16341
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2911
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X125.506 Y118.21 E.16272
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
M106 S255
G1 F3000
G1 X126.757 Y118.21 E.0415
M106 S252.45
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2911
G1 X132.616 Y118.21 E.18004
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
M106 S255
G1 F3000
G1 X133.865 Y118.21 E.04142
M106 S252.45
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2911
G1 X139.79 Y118.21 E.18207
G1 X139.79 Y122.971 E.14628
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
M106 S255
G1 F3000
G1 X139.79 Y124.312 E.04449
M106 S252.45
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2911
G1 X139.79 Y130.711 E.19664
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
M106 S255
G1 F3000
G1 X139.79 Y132.03 E.04375
M106 S252.45
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2911
G1 X139.79 Y132.399 E.01134
G1 X139.79 Y137.73 E.16381
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.6 I1.174 J.321 P1  F30000
G1 X139.039 Y133.17 Z16.6
G1 Z16.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.471417
M106 S255
G1 F3000
G1 X139.039 Y129.739 E.11981
G1 X138.61 Y129.738 E.01496
G1 X138.61 Y133 E.11389
G1 X138.182 Y132.999 E.01496
G1 X138.182 Y129.737 E.11389
G1 X137.776 Y129.737 E.01416
G1 X137.753 Y129.76 E.00113
G1 X137.753 Y132.978 E.11237
G1 X137.325 Y132.549 E.02118
G1 X137.325 Y129.948 E.09082
M106 S252.45
G1 X137.458 Y129.5 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2911
G1 X137.614 Y129.345 E.00731
G1 X139.022 Y129.346 E.04671
G1 X128.626 Y118.95 E.4877
G1 X131.253 Y118.95 E.08713
G1 X131.253 Y119.071 E.00401
G1 X120.95 Y129.374 E.48331
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y125.675 E.03154
G1 X138.372 Y125.676 E.02247
M73 P83 R3
G1 X139.039 Y125.453 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.470733
M106 S255
G1 F3000
G1 X139.039 Y121.999 E.1204
G1 X138.611 Y122 E.01491
G1 X138.611 Y125.284 E.11448
G1 X138.184 Y125.284 E.01491
G1 X138.184 Y122 E.11448
G1 X137.779 Y122 E.01411
G1 X137.756 Y122.023 E.00113
G1 X137.756 Y125.261 E.1129
G1 X137.328 Y124.834 E.02109
G1 X137.328 Y122.211 E.09143
M106 S252.45
G1 X134.674 Y137.05 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2911
G1 X136.302 Y137.05 E.05401
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X124.142 Y118.95 E.01473
G1 X124.141 Y120.135 E.03928
G1 X124.746 Y120.65 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.465865
M106 S255
G1 F3000
G1 X127.275 Y120.65 E.08716
G1 X127.698 Y120.227 E.02062
G1 X124.563 Y120.227 E.10804
G1 X124.533 Y120.197 E.00145
G1 X124.534 Y119.804 E.01355
G1 X127.727 Y119.804 E.11008
G1 X127.728 Y119.381 E.01458
G1 X124.534 Y119.381 E.11008
G1 X124.534 Y118.958 E.01458
G1 X127.898 Y118.958 E.11593
M106 S252.45
G1 X131.858 Y120.65 F30000
M106 S255
G1 F3000
G1 X134.385 Y120.65 E.08708
G1 X134.807 Y120.227 E.02061
G1 X131.675 Y120.227 E.10797
G1 X131.646 Y120.198 E.00142
G1 X131.645 Y119.804 E.01357
G1 X134.837 Y119.804 E.11
G1 X134.837 Y119.381 E.01458
G1 X131.645 Y119.381 E.11
G1 X131.645 Y118.958 E.01458
G1 X135.006 Y118.958 E.11585
M106 S252.45
G1 X135.229 Y119.505 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2911
G1 X135.229 Y118.95 E.0184
G1 X136.302 Y118.95 E.03561
G1 X138.959 Y121.607 E.12465
G1 X139.05 Y121.607 E.003
G1 X139.05 Y118.95 E.08814
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 16.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X123.698 Y137.05 E-.61876
G1 X123.435 Y136.787 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 82/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L82
M991 S0 P81 ;notify layer change
G17
G3 Z16.6 I-.047 J1.216 P1  F30000
G1 X139.398 Y137.398 Z16.6
G1 Z16.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3275
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3275
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.8 I.262 J-1.188 P1  F30000
G1 X134.674 Y137.05 Z16.8
G1 Z16.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3275
G1 X136.302 Y137.05 E.05401
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.627 Y119.021 E.12557
G1 X123.626 Y120.461 E.04776
G1 X123.699 Y120.635 E.00626
G1 X125.25 Y120.091 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.351086
G1 F3275
G1 X126.951 Y120.091 E.04272
G1 X127.153 Y120.434 F30000
; LINE_WIDTH: 0.419999
G1 F3275
G1 X127.488 Y120.099 E.01456
G1 X127.488 Y119.748 E.01076
G1 X124.773 Y119.748 E.08343
G1 X124.773 Y120.098 E.01075
G1 X125.108 Y120.434 E.01457
G1 X127.093 Y120.434 E.06099
G1 X127.309 Y120.811 F30000
G1 F3275
G1 X127.865 Y120.255 E.02415
G1 X127.865 Y119.371 E.02715
G1 X124.396 Y119.371 E.1066
G1 X124.396 Y120.254 E.02714
G1 X124.952 Y120.811 E.02417
G1 X127.249 Y120.811 E.07059
G1 X127.438 Y121.188 F30000
G1 F3275
G2 X128.242 Y120.384 I-5.123 J-5.93 E.03498
G1 X128.243 Y118.994 E.0427
G1 X124.019 Y118.994 E.12977
G1 X124.019 Y120.383 E.04267
G2 X124.823 Y121.188 I6.094 J-5.287 E.035
G1 X127.378 Y121.188 E.07849
G1 X132.362 Y120.091 F30000
; LINE_WIDTH: 0.351084
G1 F3275
G1 X134.061 Y120.091 E.04266
G1 X132.22 Y120.434 F30000
; LINE_WIDTH: 0.419999
G1 F3275
G1 X134.263 Y120.434 E.06276
G1 X134.598 Y120.098 E.01457
G1 X134.598 Y119.748 E.01075
G1 X131.885 Y119.748 E.08336
G1 X131.885 Y120.099 E.01077
G1 X132.178 Y120.391 E.01271
G1 X132.064 Y120.811 F30000
G1 F3275
G1 X134.419 Y120.811 E.07236
G1 X134.975 Y120.254 E.02417
G1 X134.974 Y119.371 E.02713
G1 X131.507 Y119.371 E.10653
G1 X131.508 Y120.255 E.02716
G1 X132.021 Y120.768 E.02231
G1 X131.935 Y121.188 F30000
G1 F3275
G1 X134.548 Y121.188 E.08026
G2 X135.352 Y120.383 I-5.126 J-5.928 E.035
G1 X135.351 Y118.994 E.04267
G1 X131.13 Y118.994 E.1297
G1 X131.131 Y120.384 E.0427
G2 X131.891 Y121.147 I5.781 J-4.997 E.03313
G1 X135.744 Y120.02 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3275
G1 X135.743 Y118.95 E.03547
G1 X136.302 Y118.95 E.01854
G1 X138.445 Y121.093 E.10051
G1 X139.05 Y121.093 E.02006
G1 X139.05 Y118.95 E.07106
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X137.895 Y132.277 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.378682
G1 F3275
G1 X137.896 Y130.519 E.04809
G1 X137.54 Y130.312 F30000
; LINE_WIDTH: 0.419999
G1 F3275
G1 X137.539 Y132.424 E.06492
G1 X137.873 Y132.759 E.01455
G1 X138.252 Y132.76 E.01162
G1 X138.252 Y129.977 E.08551
G1 X137.875 Y129.976 E.01157
G1 X137.582 Y130.269 E.01273
G1 X137.163 Y130.155 F30000
G1 F3275
G1 X137.162 Y132.58 E.07451
G1 X137.717 Y133.136 E.02415
G1 X138.629 Y133.137 E.02802
G1 X138.629 Y129.6 E.10868
G1 X137.72 Y129.599 E.02794
G1 X137.205 Y130.113 E.02233
G1 X136.786 Y130.026 F30000
G1 F3275
G1 X136.784 Y132.708 E.08242
G2 X137.588 Y133.513 I5.971 J-5.157 E.03497
G1 X139.006 Y133.515 E.04357
G1 X139.006 Y129.224 E.13186
G1 X137.591 Y129.222 E.04346
G2 X136.826 Y129.982 I5.009 J5.806 E.03316
G1 X137.02 Y129.211 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3275
G3 X137.514 Y128.83 I.707 J.406 E.02125
G1 X138.507 Y128.831 E.03295
G1 X128.635 Y118.959 E.46313
G1 X130.738 Y118.95 E.06978
G1 X130.738 Y119.586 E.02107
G1 X120.95 Y129.374 E.45918
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y126.19 E.01447
G1 X137.857 Y126.191 E.03955
G1 X137.897 Y124.562 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37526
G1 F3275
G1 X137.897 Y122.781 E.04824
G1 X137.542 Y124.709 F30000
; LINE_WIDTH: 0.419999
G1 F3275
G1 X137.878 Y125.045 E.01457
G1 X138.252 Y125.044 E.0115
G1 X138.252 Y122.239 E.08619
G1 X137.878 Y122.239 E.01148
G1 X137.543 Y122.574 E.01455
M73 P84 R3
G1 X137.542 Y124.649 E.06376
G1 X137.165 Y124.865 F30000
G1 F3275
G1 X137.721 Y125.422 E.02418
G1 X138.629 Y125.421 E.02788
G1 X138.629 Y121.862 E.10937
G1 X137.722 Y121.862 E.02787
G1 X137.166 Y122.418 E.02414
G1 X137.165 Y124.805 E.07335
G1 X136.788 Y124.994 F30000
G1 F3275
G2 X137.593 Y125.799 I5.963 J-5.158 E.03501
G1 X139.006 Y125.798 E.04342
G1 X139.006 Y121.485 E.13254
G1 X137.593 Y121.485 E.04341
G2 X136.789 Y122.289 I5.303 J6.107 E.03497
G1 X136.788 Y124.934 E.08126
; CHANGE_LAYER
; Z_HEIGHT: 16.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X136.789 Y122.934 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 83/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L83
M991 S0 P82 ;notify layer change
G17
G3 Z16.8 I-1.198 J.216 P1  F30000
G1 X139.398 Y137.398 Z16.8
G1 Z16.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3274
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3274
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17 I.262 J-1.188 P1  F30000
G1 X134.674 Y137.05 Z17
G1 Z16.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3274
G1 X136.302 Y137.05 E.05401
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X120.95 Y118.95 E.84908
G1 X120.95 Y121.698 E.09114
G1 X123.627 Y119.021 E.12557
G1 X123.626 Y120.461 E.04776
G1 X123.699 Y120.635 E.00626
G1 X125.25 Y120.091 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.351086
G1 F3274
G1 X126.951 Y120.091 E.04272
G1 X127.153 Y120.434 F30000
; LINE_WIDTH: 0.419999
G1 F3274
G1 X127.488 Y120.099 E.01456
G1 X127.488 Y119.748 E.01076
G1 X124.773 Y119.748 E.08343
G1 X124.773 Y120.098 E.01075
G1 X125.108 Y120.434 E.01457
G1 X127.093 Y120.434 E.06099
G1 X127.309 Y120.811 F30000
G1 F3274
G1 X127.865 Y120.255 E.02415
G1 X127.865 Y119.371 E.02715
G1 X124.396 Y119.371 E.1066
G1 X124.396 Y120.254 E.02714
G1 X124.952 Y120.811 E.02417
G1 X127.249 Y120.811 E.07059
G1 X127.438 Y121.188 F30000
G1 F3274
G2 X128.242 Y120.384 I-5.123 J-5.93 E.03498
G1 X128.243 Y118.994 E.0427
G1 X124.019 Y118.994 E.12977
G1 X124.019 Y120.383 E.04267
G2 X124.823 Y121.188 I6.094 J-5.287 E.035
G1 X127.378 Y121.188 E.07849
G1 X132.362 Y120.091 F30000
; LINE_WIDTH: 0.351086
G1 F3274
G1 X134.061 Y120.091 E.04266
G1 X132.22 Y120.434 F30000
; LINE_WIDTH: 0.419999
G1 F3274
G1 X134.263 Y120.434 E.06276
G1 X134.598 Y120.098 E.01457
G1 X134.598 Y119.748 E.01075
G1 X131.885 Y119.748 E.08336
G1 X131.885 Y120.099 E.01077
G1 X132.178 Y120.391 E.01271
G1 X132.064 Y120.811 F30000
G1 F3274
G1 X134.419 Y120.811 E.07236
G1 X134.975 Y120.254 E.02417
G1 X134.974 Y119.371 E.02713
G1 X131.507 Y119.371 E.10653
G1 X131.508 Y120.255 E.02716
G1 X132.021 Y120.768 E.02231
G1 X131.935 Y121.188 F30000
G1 F3274
G1 X134.548 Y121.188 E.08026
G2 X135.352 Y120.383 I-5.126 J-5.928 E.035
G1 X135.351 Y118.994 E.04267
G1 X131.13 Y118.994 E.1297
G1 X131.131 Y120.384 E.0427
G2 X131.891 Y121.147 I5.781 J-4.997 E.03313
G1 X135.744 Y120.02 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3274
G1 X135.743 Y118.95 E.03547
G1 X136.302 Y118.95 E.01854
G1 X138.445 Y121.093 E.10051
G1 X139.05 Y121.093 E.02006
G1 X139.05 Y118.95 E.07106
G1 X120.95 Y137.05 E.84908
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X125.326 Y137.05 E.05401
G1 X137.895 Y132.277 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.378682
G1 F3274
G1 X137.896 Y130.519 E.04809
G1 X137.54 Y130.312 F30000
; LINE_WIDTH: 0.419999
G1 F3274
G1 X137.539 Y132.424 E.06492
G1 X137.873 Y132.759 E.01455
G1 X138.252 Y132.76 E.01162
G1 X138.252 Y129.977 E.08551
G1 X137.875 Y129.976 E.01157
G1 X137.582 Y130.269 E.01273
G1 X137.163 Y130.155 F30000
G1 F3274
G1 X137.162 Y132.58 E.07451
G1 X137.717 Y133.136 E.02415
G1 X138.629 Y133.137 E.02802
G1 X138.629 Y129.6 E.10868
G1 X137.72 Y129.599 E.02794
G1 X137.205 Y130.113 E.02233
G1 X136.786 Y130.026 F30000
G1 F3274
G1 X136.784 Y132.708 E.08242
G2 X137.588 Y133.513 I5.971 J-5.157 E.03497
G1 X139.006 Y133.515 E.04357
G1 X139.006 Y129.224 E.13186
G1 X137.591 Y129.222 E.04346
G2 X136.826 Y129.982 I5.009 J5.806 E.03316
G1 X137.02 Y129.211 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3274
G3 X137.514 Y128.83 I.707 J.406 E.02125
G1 X138.507 Y128.831 E.03295
G1 X128.635 Y118.959 E.46313
G1 X130.738 Y118.95 E.06978
G1 X130.738 Y119.586 E.02107
G1 X120.95 Y129.374 E.45918
G1 X120.95 Y126.626 E.09114
G1 X131.374 Y137.05 E.48898
G1 X128.626 Y137.05 E.09114
G1 X139.05 Y126.626 E.48898
G1 X139.05 Y126.19 E.01447
G1 X137.857 Y126.191 E.03955
G1 X137.897 Y124.562 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37526
G1 F3274
G1 X137.897 Y122.781 E.04824
G1 X137.542 Y124.709 F30000
; LINE_WIDTH: 0.419999
G1 F3274
G1 X137.878 Y125.045 E.01457
G1 X138.252 Y125.044 E.0115
G1 X138.252 Y122.239 E.08619
G1 X137.878 Y122.239 E.01148
G1 X137.543 Y122.574 E.01455
G1 X137.542 Y124.649 E.06376
G1 X137.165 Y124.865 F30000
G1 F3274
G1 X137.721 Y125.422 E.02418
G1 X138.629 Y125.421 E.02788
G1 X138.629 Y121.862 E.10937
G1 X137.722 Y121.862 E.02787
G1 X137.166 Y122.418 E.02414
G1 X137.165 Y124.805 E.07335
G1 X136.788 Y124.994 F30000
G1 F3274
G2 X137.593 Y125.799 I5.963 J-5.158 E.03501
G1 X139.006 Y125.798 E.04342
G1 X139.006 Y121.485 E.13254
G1 X137.593 Y121.485 E.04341
G2 X136.789 Y122.289 I5.303 J6.107 E.03497
G1 X136.788 Y124.934 E.08126
; CHANGE_LAYER
; Z_HEIGHT: 16.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X136.789 Y122.934 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 84/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L84
M991 S0 P83 ;notify layer change
G17
G3 Z17 I-1.198 J.216 P1  F30000
G1 X139.398 Y137.398 Z17
G1 Z16.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2925
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2925
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.2 I1.081 J-.558 P1  F30000
G1 X132.57 Y127.621 Z17.2
G1 Z16.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2925
G1 X131.828 Y126.172 E.05401
G1 X132.829 Y125.171 E.04694
G1 X134.827 Y125.151 E.06628
G1 X139.05 Y129.374 E.19809
G1 X139.05 Y126.626 E.09114
G1 X134.427 Y131.249 E.21687
G1 X135.63 Y133.63 E.08849
G1 X139.05 Y137.05 E.16042
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X130.293 Y135.969 E.05068
G1 X129.707 Y135.969 E.01947
G1 X128.626 Y137.05 E.05068
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X124.755 Y133.245 E.17848
G1 X124.755 Y134.873 E.05401
G1 X125.569 Y134.059 F30000
G1 F2925
G1 X125.569 Y132.431 E.05401
G1 X126.032 Y131.968 E.0217
G1 X126.292 Y131.968 E.00865
G1 X129.479 Y135.155 E.1495
G1 X130.521 Y135.155 E.03455
G1 X133.822 Y131.854 E.15486
G1 X126.377 Y124.377 E.35001
G1 X126.232 Y124.092 E.01061
G1 X129.154 Y121.17 E.13709
G1 X130.846 Y121.17 E.05612
G1 X134.033 Y124.357 E.1495
G1 X133.643 Y124.357 E.01292
G1 X134.949 Y123.051 E.06127
G1 X134.949 Y121.566 E.04926
G1 X134.848 Y121.464 E.00475
M73 P85 R3
G1 X134.683 Y120.763 F30000
G1 F2925
G1 X125.737 Y120.763 E.29677
G1 X125.314 Y121.161 E.01927
G2 X125.011 Y121.488 I.243 J.529 E.01517
G1 X125.017 Y122.607 E.03712
G1 X129.585 Y131.561 E.33343
G1 X125.821 Y131.561 E.12487
G2 X125.162 Y132.22 I4.121 J4.78 E.03092
G1 X125.162 Y134.904 E.08903
G1 X125.821 Y135.562 E.03089
G1 X134.513 Y135.562 E.28834
G1 X134.936 Y135.164 E.01927
G2 X135.238 Y134.837 I-.243 J-.529 E.01517
G1 X135.232 Y133.717 E.03716
G1 X130.651 Y124.764 E.3336
G1 X134.698 Y124.764 E.13425
G2 X135.356 Y124.105 I-4.121 J-4.78 E.03092
G1 X135.356 Y121.421 E.08903
G1 X134.739 Y120.78 E.02952
G1 X135.313 Y120.778 F30000
G1 F2925
G3 X135.763 Y121.34 I-.454 J.825 E.02454
G1 X135.763 Y122.237 E.02972
G1 X139.05 Y118.95 E.15416
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X131.374 Y118.95 E.16349
G1 X129.968 Y120.356 E.06593
G1 X130.032 Y120.356 E.0021
G1 X128.626 Y118.95 E.06593
G1 X123.698 Y118.95 E.16349
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X124.604 Y122.604 E.1714
G2 X124.633 Y122.749 I.317 J.013 E.00496
G1 X125.627 Y124.697 E.07255
G1 X120.95 Y129.374 E.21937
G1 X120.95 Y126.626 E.09114
G1 X125.555 Y131.231 E.216
G1 X125.74 Y131.154 E.00664
G1 X126.846 Y131.154 E.0367
G1 X128.219 Y129.781 E.06444
G1 X127.48 Y128.33 E.05401
G1 X129.565 Y130.626 F30000
G1 F2925
G1 X128.825 Y129.175 E.05401
G1 X131.223 Y126.777 E.11253
G1 X130.482 Y125.327 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X131.223 Y126.777 E-.61876
G1 X130.961 Y127.039 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 85/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L85
M991 S0 P84 ;notify layer change
G17
G3 Z17.2 I-.944 J.769 P1  F30000
G1 X139.398 Y137.398 Z17.2
G1 Z17
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2924
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2924
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.4 I1.081 J-.558 P1  F30000
G1 X132.57 Y127.621 Z17.4
G1 Z17
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2924
G1 X131.828 Y126.172 E.05401
G1 X132.829 Y125.171 E.04694
G1 X134.827 Y125.151 E.06628
G1 X139.05 Y129.374 E.19809
G1 X139.05 Y126.626 E.09114
G1 X134.427 Y131.249 E.21687
G1 X135.63 Y133.63 E.08849
G1 X139.05 Y137.05 E.16042
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X130.293 Y135.969 E.05068
G1 X129.707 Y135.969 E.01947
G1 X128.626 Y137.05 E.05068
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X124.755 Y133.245 E.17848
G1 X124.755 Y134.873 E.05401
G1 X125.569 Y134.059 F30000
G1 F2924
G1 X125.569 Y132.431 E.05401
G1 X126.032 Y131.968 E.0217
G1 X126.292 Y131.968 E.00865
G1 X129.479 Y135.155 E.1495
G1 X130.521 Y135.155 E.03455
G1 X133.822 Y131.854 E.15486
G1 X126.377 Y124.377 E.35001
G1 X126.232 Y124.092 E.01061
G1 X129.154 Y121.17 E.13709
G1 X130.846 Y121.17 E.05612
G1 X134.033 Y124.357 E.1495
G1 X133.643 Y124.357 E.01292
G1 X134.949 Y123.051 E.06127
G1 X134.949 Y121.566 E.04926
G1 X134.848 Y121.464 E.00475
G1 X134.683 Y120.763 F30000
G1 F2924
G1 X125.737 Y120.763 E.29677
G1 X125.314 Y121.161 E.01927
G2 X125.011 Y121.488 I.243 J.529 E.01517
G1 X125.017 Y122.607 E.03712
G1 X129.585 Y131.561 E.33343
M73 P85 R2
G1 X125.821 Y131.561 E.12487
G2 X125.162 Y132.22 I4.121 J4.78 E.03092
G1 X125.162 Y134.904 E.08903
G1 X125.821 Y135.562 E.03089
G1 X134.513 Y135.562 E.28834
G1 X134.936 Y135.164 E.01927
G2 X135.238 Y134.837 I-.243 J-.529 E.01517
G1 X135.232 Y133.717 E.03716
G1 X130.651 Y124.764 E.3336
G1 X134.698 Y124.764 E.13425
G2 X135.356 Y124.105 I-4.121 J-4.78 E.03092
G1 X135.356 Y121.421 E.08903
G1 X134.739 Y120.78 E.02952
G1 X135.313 Y120.778 F30000
G1 F2924
G3 X135.763 Y121.34 I-.454 J.825 E.02454
G1 X135.763 Y122.237 E.02972
G1 X139.05 Y118.95 E.15416
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X131.374 Y118.95 E.16349
G1 X129.968 Y120.356 E.06593
G1 X130.032 Y120.356 E.0021
G1 X128.626 Y118.95 E.06593
G1 X123.698 Y118.95 E.16349
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
M73 P86 R2
G1 X124.604 Y122.604 E.1714
G2 X124.633 Y122.749 I.317 J.013 E.00496
G1 X125.627 Y124.697 E.07255
G1 X120.95 Y129.374 E.21937
G1 X120.95 Y126.626 E.09114
G1 X125.555 Y131.231 E.216
G1 X125.74 Y131.154 E.00664
G1 X126.846 Y131.154 E.0367
G1 X128.219 Y129.781 E.06444
G1 X127.48 Y128.33 E.05401
G1 X129.565 Y130.626 F30000
G1 F2924
G1 X128.825 Y129.175 E.05401
G1 X131.223 Y126.777 E.11253
G1 X130.482 Y125.327 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X131.223 Y126.777 E-.61876
G1 X130.961 Y127.039 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 86/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L86
M991 S0 P85 ;notify layer change
G17
G3 Z17.4 I-.944 J.769 P1  F30000
G1 X139.398 Y137.398 Z17.4
G1 Z17.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2924
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2924
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.6 I1.081 J-.558 P1  F30000
G1 X132.57 Y127.621 Z17.6
G1 Z17.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2924
G1 X131.828 Y126.172 E.05401
G1 X132.829 Y125.171 E.04694
G1 X134.827 Y125.151 E.06628
G1 X139.05 Y129.374 E.19809
G1 X139.05 Y126.626 E.09114
G1 X134.427 Y131.249 E.21687
G1 X135.63 Y133.63 E.08849
G1 X139.05 Y137.05 E.16042
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X130.293 Y135.969 E.05068
G1 X129.707 Y135.969 E.01947
G1 X128.626 Y137.05 E.05068
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X124.755 Y133.245 E.17848
G1 X124.755 Y134.873 E.05401
G1 X125.569 Y134.059 F30000
G1 F2924
G1 X125.569 Y132.431 E.05401
G1 X126.032 Y131.968 E.0217
G1 X126.292 Y131.968 E.00865
G1 X129.479 Y135.155 E.1495
G1 X130.521 Y135.155 E.03455
G1 X133.822 Y131.854 E.15486
G1 X126.377 Y124.377 E.35001
G1 X126.232 Y124.092 E.01061
G1 X129.154 Y121.17 E.13709
G1 X130.846 Y121.17 E.05612
G1 X134.033 Y124.357 E.1495
G1 X133.643 Y124.357 E.01292
G1 X134.949 Y123.051 E.06127
G1 X134.949 Y121.566 E.04926
G1 X134.848 Y121.464 E.00475
G1 X134.683 Y120.763 F30000
G1 F2924
G1 X125.737 Y120.763 E.29677
G1 X125.314 Y121.161 E.01927
G2 X125.011 Y121.488 I.243 J.529 E.01517
G1 X125.017 Y122.607 E.03712
G1 X129.585 Y131.561 E.33343
G1 X125.821 Y131.561 E.12487
G2 X125.162 Y132.22 I4.121 J4.78 E.03092
G1 X125.162 Y134.904 E.08903
G1 X125.821 Y135.562 E.03089
G1 X134.513 Y135.562 E.28834
G1 X134.936 Y135.164 E.01927
G2 X135.238 Y134.837 I-.243 J-.529 E.01517
G1 X135.232 Y133.717 E.03716
G1 X130.651 Y124.764 E.3336
G1 X134.698 Y124.764 E.13425
G2 X135.356 Y124.105 I-4.121 J-4.78 E.03092
G1 X135.356 Y121.421 E.08903
G1 X134.739 Y120.78 E.02952
G1 X135.313 Y120.778 F30000
G1 F2924
G3 X135.763 Y121.34 I-.454 J.825 E.02454
G1 X135.763 Y122.237 E.02972
G1 X139.05 Y118.95 E.15416
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X131.374 Y118.95 E.16349
G1 X129.968 Y120.356 E.06593
G1 X130.032 Y120.356 E.0021
G1 X128.626 Y118.95 E.06593
G1 X123.698 Y118.95 E.16349
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X124.604 Y122.604 E.1714
G2 X124.633 Y122.749 I.317 J.013 E.00496
G1 X125.627 Y124.697 E.07255
G1 X120.95 Y129.374 E.21937
G1 X120.95 Y126.626 E.09114
G1 X125.555 Y131.231 E.216
G1 X125.74 Y131.154 E.00664
G1 X126.846 Y131.154 E.0367
G1 X128.219 Y129.781 E.06444
G1 X127.48 Y128.33 E.05401
G1 X129.565 Y130.626 F30000
G1 F2924
G1 X128.825 Y129.175 E.05401
G1 X131.223 Y126.777 E.11253
G1 X130.482 Y125.327 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X131.223 Y126.777 E-.61876
G1 X130.961 Y127.039 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 87/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L87
M991 S0 P86 ;notify layer change
G17
G3 Z17.6 I-.944 J.769 P1  F30000
G1 X139.398 Y137.398 Z17.6
G1 Z17.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2924
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2924
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.8 I1.081 J-.558 P1  F30000
G1 X132.57 Y127.621 Z17.8
G1 Z17.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2924
G1 X131.828 Y126.172 E.05401
G1 X132.829 Y125.171 E.04694
G1 X134.827 Y125.151 E.06628
G1 X139.05 Y129.374 E.19809
G1 X139.05 Y126.626 E.09114
G1 X134.427 Y131.249 E.21687
G1 X135.63 Y133.63 E.08849
G1 X139.05 Y137.05 E.16042
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X130.293 Y135.969 E.05068
G1 X129.707 Y135.969 E.01947
G1 X128.626 Y137.05 E.05068
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X124.755 Y133.245 E.17848
G1 X124.755 Y134.873 E.05401
G1 X125.569 Y134.059 F30000
G1 F2924
G1 X125.569 Y132.431 E.05401
G1 X126.032 Y131.968 E.0217
G1 X126.292 Y131.968 E.00865
G1 X129.479 Y135.155 E.1495
G1 X130.521 Y135.155 E.03455
G1 X133.822 Y131.854 E.15486
G1 X126.377 Y124.377 E.35001
G1 X126.232 Y124.092 E.01061
G1 X129.154 Y121.17 E.13709
G1 X130.846 Y121.17 E.05612
G1 X134.033 Y124.357 E.1495
G1 X133.643 Y124.357 E.01292
G1 X134.949 Y123.051 E.06127
G1 X134.949 Y121.566 E.04926
M73 P87 R2
G1 X134.848 Y121.464 E.00475
G1 X134.683 Y120.763 F30000
G1 F2924
G1 X125.737 Y120.763 E.29677
G1 X125.314 Y121.161 E.01927
G2 X125.011 Y121.488 I.243 J.529 E.01517
G1 X125.017 Y122.607 E.03712
G1 X129.585 Y131.561 E.33343
G1 X125.821 Y131.561 E.12487
G2 X125.162 Y132.22 I4.121 J4.78 E.03092
G1 X125.162 Y134.904 E.08903
G1 X125.821 Y135.562 E.03089
G1 X134.513 Y135.562 E.28834
G1 X134.936 Y135.164 E.01927
G2 X135.238 Y134.837 I-.243 J-.529 E.01517
G1 X135.232 Y133.717 E.03716
G1 X130.651 Y124.764 E.3336
G1 X134.698 Y124.764 E.13425
G2 X135.356 Y124.105 I-4.121 J-4.78 E.03092
G1 X135.356 Y121.421 E.08903
G1 X134.739 Y120.78 E.02952
G1 X135.313 Y120.778 F30000
G1 F2924
G3 X135.763 Y121.34 I-.454 J.825 E.02454
G1 X135.763 Y122.237 E.02972
G1 X139.05 Y118.95 E.15416
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X131.374 Y118.95 E.16349
G1 X129.968 Y120.356 E.06593
G1 X130.032 Y120.356 E.0021
G1 X128.626 Y118.95 E.06593
G1 X123.698 Y118.95 E.16349
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X124.604 Y122.604 E.1714
G2 X124.633 Y122.749 I.317 J.013 E.00496
G1 X125.627 Y124.697 E.07255
G1 X120.95 Y129.374 E.21937
G1 X120.95 Y126.626 E.09114
G1 X125.555 Y131.231 E.216
G1 X125.74 Y131.154 E.00664
G1 X126.846 Y131.154 E.0367
G1 X128.219 Y129.781 E.06444
G1 X127.48 Y128.33 E.05401
G1 X129.565 Y130.626 F30000
G1 F2924
G1 X128.825 Y129.175 E.05401
G1 X131.223 Y126.777 E.11253
G1 X130.482 Y125.327 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 17.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X131.223 Y126.777 E-.61876
G1 X130.961 Y127.039 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 88/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L88
M991 S0 P87 ;notify layer change
G17
G3 Z17.8 I-.944 J.769 P1  F30000
G1 X139.398 Y137.398 Z17.8
G1 Z17.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F6845
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6845
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18 I.742 J-.965 P1  F30000
G1 X134.94 Y135.544 Z18
G1 Z17.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F6845
G1 X134.877 Y135.58 E.00204
G1 X134.925 Y135.608 E.00155
G1 X134.326 Y135.743 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.400322
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X135.203 Y134.866 E.06365
G1 X135.217 Y134.833 E.00184
G1 X135.217 Y134.215 E.03166
G1 X133.891 Y135.541 E.09615
G1 X133.254 Y135.541 E.03266
G1 X135.164 Y133.631 E.13851
G1 X134.949 Y133.21 E.02427
G1 X132.618 Y135.541 E.16906
G1 X131.981 Y135.541 E.03266
G1 X134.733 Y132.788 E.19962
G1 X134.518 Y132.367 E.02427
G1 X131.344 Y135.541 E.23017
G1 X130.707 Y135.541 E.03266
G1 X134.302 Y131.946 E.26072
G1 X134.086 Y131.525 E.02427
G1 X130.07 Y135.541 E.29127
G1 X129.433 Y135.541 E.03266
G1 X133.871 Y131.103 E.32182
G1 X133.655 Y130.682 E.02427
G1 X128.796 Y135.541 E.35238
G1 X128.16 Y135.541 E.03266
G1 X133.44 Y130.261 E.38293
G1 X133.224 Y129.84 E.02427
G1 X127.523 Y135.541 E.41348
G1 X126.886 Y135.541 E.03266
G1 X133.008 Y129.418 E.44403
G1 X132.793 Y128.997 E.02427
G1 X126.249 Y135.541 E.47459
G1 X125.825 Y135.541 E.02176
G3 X125.709 Y135.444 I.058 J-.188 E.00794
G1 X132.577 Y128.576 E.49815
G1 X132.362 Y128.155 E.02427
G1 X129.388 Y131.128 E.21566
G1 X129.173 Y130.706 E.02428
G1 X132.146 Y127.733 E.21563
G1 X131.931 Y127.312 E.02427
G1 X128.958 Y130.285 E.2156
G1 X128.743 Y129.863 E.02428
G1 X131.715 Y126.891 E.21557
G1 X131.499 Y126.469 E.02427
G1 X128.528 Y129.441 E.21553
G1 X128.312 Y129.02 E.02428
G1 X131.284 Y126.048 E.2155
G1 X131.068 Y125.627 E.02427
G1 X128.097 Y128.598 E.21547
G1 X127.882 Y128.176 E.02428
G1 X131.003 Y125.055 E.22635
M106 S252.45
G1 X131.113 Y124.945 F30000
M106 S255
G1 F3000
G1 X134.994 Y121.065 E.28142
G1 X135.312 Y121.383 E.02309
G1 X131.953 Y124.742 E.24364
G1 X132.59 Y124.742 E.03266
G1 X135.335 Y121.997 E.19911
G1 X135.335 Y122.634 E.03266
G1 X133.226 Y124.742 E.15292
G1 X133.863 Y124.742 E.03266
G1 X135.335 Y123.271 E.10673
G1 X135.335 Y123.908 E.03266
G1 X134.298 Y124.945 E.07523
M106 S252.45
G1 X135.216 Y124.736 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
; LAYER_HEIGHT: 0.2
G1 F6845
G1 X135.286 Y124.666 E.00273
G1 X135.328 Y120.903 F30000
G1 F6845
G1 X135.258 Y120.834 E.00273
G1 X135.564 Y120.674 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6845
G1 X135.657 Y120.767 E.00437
G2 X135.764 Y121.34 I.754 J.157 E.01984
G1 X135.764 Y122.236 E.02972
G1 X139.05 Y118.95 E.15416
G1 X139.05 Y121.698 E.09114
G1 X136.302 Y118.95 E.12889
G1 X131.374 Y118.95 E.16349
G1 X129.968 Y120.356 E.06593
G1 X130.032 Y120.356 E.0021
G1 X128.626 Y118.95 E.06593
G1 X123.698 Y118.95 E.16349
G1 X120.95 Y121.698 E.12889
G1 X120.95 Y118.95 E.09114
G1 X124.604 Y122.604 E.1714
G2 X124.633 Y122.749 I.317 J.013 E.00496
G1 X125.627 Y124.697 E.07255
G1 X120.95 Y129.374 E.21937
G1 X120.95 Y126.626 E.09114
G1 X125.555 Y131.231 E.216
G1 X125.74 Y131.154 E.00664
G1 X126.846 Y131.154 E.0367
G1 X128.219 Y129.781 E.06444
G1 X127.48 Y128.33 E.05401
G1 X127.516 Y127.905 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.400322
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X134.637 Y120.784 E.51642
G1 X134 Y120.784 E.03266
M73 P88 R2
G1 X127.452 Y127.333 E.47492
G1 X127.237 Y126.911 E.02428
G1 X133.363 Y120.784 E.44433
G1 X132.727 Y120.784 E.03266
G1 X127.022 Y126.489 E.41375
G1 X126.807 Y126.068 E.02428
G1 X132.09 Y120.784 E.38316
G1 X131.453 Y120.784 E.03266
G1 X126.591 Y125.646 E.35258
G1 X126.376 Y125.224 E.02428
G1 X130.816 Y120.784 E.32199
G1 X130.179 Y120.784 E.03266
G1 X126.161 Y124.802 E.29141
G1 X125.946 Y124.381 E.02428
G1 X129.542 Y120.784 E.26082
G1 X128.905 Y120.784 E.03266
G1 X125.731 Y123.959 E.23024
G1 X125.516 Y123.537 E.02428
G1 X128.269 Y120.784 E.19965
G1 X127.632 Y120.784 E.03266
G1 X125.301 Y123.115 E.16907
G1 X125.085 Y122.694 E.02428
G1 X126.995 Y120.784 E.13848
G1 X126.358 Y120.784 E.03266
G1 X125.032 Y122.11 E.09614
G1 X125.032 Y121.493 E.03166
G1 X125.046 Y121.459 E.00185
G1 X125.924 Y120.582 E.06364
M106 S252.45
G1 X125.352 Y120.708 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
; LAYER_HEIGHT: 0.2
G1 F6845
G1 X125.288 Y120.745 E.00204
G1 X125.337 Y120.773 E.00155
G1 X124.719 Y121.913 F30000
G1 F6845
G1 X124.656 Y121.95 E.00204
G1 X124.704 Y121.978 E.00155
G1 X126.589 Y131.38 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.400322
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X125.183 Y132.785 E.10191
G1 X125.183 Y133.422 E.03266
G1 X127.023 Y131.583 E.13341
G1 X127.66 Y131.583 E.03266
G1 X125.183 Y134.059 E.1796
G1 X125.183 Y134.696 E.03266
G1 X128.297 Y131.583 E.22579
G1 X128.934 Y131.583 E.03266
G1 X125.247 Y135.269 E.26736
M106 S252.45
G1 X125.19 Y135.422 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
; LAYER_HEIGHT: 0.2
G1 F6845
G1 X125.26 Y135.492 E.00273
G1 X124.755 Y134.873 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6845
G1 X124.755 Y133.245 E.05401
G1 X120.95 Y137.05 E.17848
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X129.707 Y135.969 E.05068
G1 X130.293 Y135.969 E.01947
G1 X131.374 Y137.05 E.05068
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X135.63 Y133.63 E.16042
G1 X134.427 Y131.249 E.08849
G1 X139.05 Y126.626 E.21687
G1 X139.05 Y129.374 E.09114
G1 X134.827 Y125.151 E.19809
G1 X132.829 Y125.171 E.06628
G1 X131.828 Y126.172 E.04694
G1 X132.57 Y127.621 E.05401
G1 X135.573 Y134.335 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F6845
G1 X135.509 Y134.372 E.00204
G1 X135.557 Y134.4 E.00155
G1 X125.19 Y131.702 F30000
G1 F6845
G1 X125.26 Y131.632 E.00273
; CHANGE_LAYER
; Z_HEIGHT: 17.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X125.19 Y131.702 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 89/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L89
M991 S0 P88 ;notify layer change
G17
G3 Z18 I-.453 J1.13 P1  F30000
G1 X139.398 Y137.398 Z18
G1 Z17.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4639
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4639
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.2 I.773 J-.94 P1  F30000
G1 X131.783 Y132.796 Z18.2
G1 Z17.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.586306
G1 F4639
G2 X131.787 Y132.907 I-.03 J.057 E.0118
G1 X131.653 Y131.657 F30000
; LINE_WIDTH: 0.419999
G1 F4639
G1 X131.636 Y131.931 E.00843
G1 X131.355 Y132.618 E.02282
G1 X130.873 Y133.197 E.02315
G1 X130.679 Y133.315 E.00696
G1 X132.502 Y133.315 E.05601
G1 X131.681 Y131.71 E.05539
G1 X130.816 Y125.053 F30000
G1 F4639
G3 X130.984 Y124.779 I.185 J-.075 E.01149
G1 X134.685 Y124.779 E.11375
G1 X134.913 Y124.672 E.00772
G1 X135.19 Y124.672 E.00851
G1 X135.265 Y124.597 E.00326
G1 X135.293 Y124.222 E.01155
G1 X135.371 Y124.093 E.00466
G1 X135.371 Y121.434 E.0817
G1 X135.265 Y121.206 E.00772
G1 X135.265 Y120.929 E.00851
G1 X135.19 Y120.854 E.00326
G1 X134.815 Y120.827 E.01155
G1 X134.685 Y120.748 E.00466
G1 X125.749 Y120.748 E.27459
G1 X125.521 Y120.854 E.00772
G1 X125.389 Y120.854 E.00407
G2 X125.308 Y121.134 I.213 J.214 E.00936
G1 X124.996 Y121.485 E.01442
G1 X124.975 Y121.736 E.00773
G1 X124.812 Y121.891 E.00692
G1 X124.785 Y121.95 E.002
G1 X124.996 Y122.397 E.01519
G1 X125.011 Y122.627 E.00708
G1 X129.42 Y131.272 E.29819
G3 X129.253 Y131.546 I-.185 J.075 E.01149
G1 X125.833 Y131.546 E.10507
G1 X125.605 Y131.653 E.00772
G1 X125.329 Y131.653 E.00851
G1 X125.253 Y131.728 E.00326
G1 X125.226 Y132.103 E.01155
G1 X125.147 Y132.232 E.00466
G1 X125.147 Y134.891 E.0817
G1 X125.253 Y135.119 E.00772
G1 X125.253 Y135.396 E.00851
G1 X125.329 Y135.471 E.00326
G1 X125.704 Y135.498 E.01155
G1 X125.833 Y135.577 E.00466
G1 X134.501 Y135.577 E.26633
G1 X134.728 Y135.471 E.00772
G1 X134.861 Y135.471 E.00407
G2 X134.942 Y135.191 I-.213 J-.214 E.00936
G1 X135.253 Y134.84 E.01442
G1 X135.274 Y134.585 E.00785
G1 X135.437 Y134.43 E.00691
G1 X135.464 Y134.371 E.002
G1 X135.254 Y133.926 E.01514
G1 X135.239 Y133.697 E.00706
G1 X130.843 Y125.107 E.2965
G1 X130.48 Y125.224 F30000
G1 F4639
G3 X130.61 Y124.542 I.504 J-.257 E.02297
G1 X130.886 Y124.41 E.00939
G1 X130.984 Y124.402 E.00301
G1 X134.58 Y124.402 E.11049
G3 X134.891 Y124.299 I.32 J.444 E.01024
G2 X134.994 Y123.843 I-1.415 J-.56 E.01442
G1 X134.994 Y121.585 E.06936
G1 X134.891 Y121.228 E.01143
G2 X134.435 Y121.125 I-.56 J1.415 E.01442
G1 X125.855 Y121.125 E.26365
G1 X125.673 Y121.238 E.00657
G3 X125.373 Y121.65 I-1.833 J-1.017 E.01571
G1 X125.311 Y121.907 E.00812
G1 X125.227 Y121.987 E.00356
G1 X125.37 Y122.346 E.0119
G1 X125.382 Y122.525 E.00551
G1 X129.756 Y131.101 E.29581
G3 X129.626 Y131.782 I-.504 J.257 E.02295
G1 X129.35 Y131.915 E.00941
G1 X129.253 Y131.923 E.00301
G1 X125.939 Y131.923 E.10182
G3 X125.627 Y132.027 I-.32 J-.444 E.01024
G2 X125.524 Y132.482 I1.415 J.56 E.01442
G1 X125.524 Y134.785 E.07077
G3 X125.627 Y135.097 I-.445 J.32 E.01024
G2 X126.083 Y135.2 I.56 J-1.415 E.01442
G1 X134.395 Y135.2 E.25539
G1 X134.576 Y135.087 E.00657
G3 X134.876 Y134.711 I.992 J.483 E.0149
G1 X134.939 Y134.413 E.00935
G1 X135.022 Y134.335 E.00353
G1 X134.88 Y133.978 E.01183
G1 X134.868 Y133.799 E.0055
G1 X130.507 Y125.278 E.29412
G1 X130.144 Y125.396 F30000
G1 F4639
G1 X130.046 Y125.068 E.01052
G1 X130.067 Y124.746 E.0099
G3 X130.641 Y124.089 I.999 J.293 E.02764
G1 X130.984 Y124.025 E.01073
G1 X134.481 Y124.025 E.10745
G1 X134.576 Y123.983 E.00319
G1 X134.617 Y123.843 E.0045
G1 X134.617 Y121.639 E.06773
G1 X134.576 Y121.544 E.00319
G1 X134.435 Y121.502 E.0045
G1 X125.964 Y121.502 E.26031
G1 X125.727 Y121.859 E.01317
G1 X125.668 Y122.03 E.00555
G2 X125.819 Y122.551 I3.06 J-.6 E.01669
G1 X130.092 Y130.929 E.28899
G1 X130.19 Y131.258 E.01052
G1 X130.169 Y131.578 E.00987
G3 X129.596 Y132.236 I-.999 J-.293 E.02765
G1 X129.253 Y132.3 E.01075
G1 X126.038 Y132.3 E.09878
G1 X125.943 Y132.342 E.00319
G1 X125.901 Y132.482 E.0045
G1 X125.901 Y134.686 E.06773
G1 X125.943 Y134.782 E.00319
G1 X126.083 Y134.823 E.0045
G1 X134.286 Y134.823 E.25204
G1 X134.522 Y134.467 E.01313
G1 X134.581 Y134.292 E.00567
G2 X134.431 Y133.773 I-2.977 J.58 E.01663
G1 X130.171 Y125.449 E.28731
G1 X129.808 Y125.567 F30000
G1 F4639
G1 X129.671 Y125.108 E.01473
G1 X129.701 Y124.658 E.01386
G1 X129.853 Y124.287 E.01232
G1 X130.113 Y123.976 E.01245
G1 X130.503 Y123.738 E.01405
G1 X130.984 Y123.648 E.01502
G1 X134.24 Y123.648 E.10007
G1 X134.24 Y121.879 E.05434
G1 X126.157 Y121.879 E.24839
G1 X126.071 Y122.03 E.00534
G1 X126.154 Y122.38 E.01106
G1 X130.428 Y130.758 E.28899
G1 X130.565 Y131.218 E.01473
G1 X130.536 Y131.666 E.01382
G1 X130.384 Y132.036 E.01229
G1 X130.125 Y132.348 E.01247
G1 X129.734 Y132.587 E.01408
G1 X129.253 Y132.677 E.01505
G1 X126.278 Y132.677 E.09139
G1 X126.278 Y134.446 E.05435
G1 X134.093 Y134.446 E.24012
G1 X134.179 Y134.292 E.00541
G1 X134.095 Y133.945 E.01098
G1 X129.835 Y125.621 E.28733
G1 X129.472 Y125.739 F30000
G1 F4639
G1 X129.296 Y125.148 E.01893
G1 X129.334 Y124.569 E.01782
G1 X129.53 Y124.092 E.01584
G1 X129.864 Y123.693 E.016
G1 X130.366 Y123.387 E.01807
G3 X130.984 Y123.271 I.617 J1.581 E.01942
G1 X133.863 Y123.271 E.08848
G1 X133.863 Y122.256 E.03117
G1 X126.515 Y122.256 E.2258
G1 X130.764 Y130.587 E.28735
G3 X130.94 Y131.177 I-1.511 J.771 E.01905
G1 X130.902 Y131.754 E.01776
G1 X130.708 Y132.23 E.0158
G1 X130.374 Y132.631 E.01603
G1 X129.871 Y132.938 E.0181
G3 X129.253 Y133.055 I-.619 J-1.58 E.01946
G1 X126.655 Y133.055 E.07981
G1 X126.655 Y134.069 E.03117
G1 X133.735 Y134.069 E.21754
G1 X129.499 Y125.792 E.2857
G1 X128.854 Y126.057 F30000
; LINE_WIDTH: 0.395478
G1 F4639
G1 X131.084 Y130.424 E.14086
G3 X131.315 Y131.137 I-1.825 J.985 E.02167
G1 X131.269 Y131.842 E.0203
G1 X131.031 Y132.424 E.01805
G1 X130.623 Y132.914 E.01831
G1 X130.009 Y133.289 E.02068
G1 X129.607 Y133.38 E.01183
; LINE_WIDTH: 0.362765
G1 X129.253 Y133.402 E.00926
G1 X127.003 Y133.402 E.05863
G1 X127.003 Y133.721 E.00831
G1 X129.253 Y133.721 E.05863
; LINE_WIDTH: 0.361617
G1 X129.669 Y133.707 E.01081
; LINE_WIDTH: 0.406252
G1 X130.085 Y133.692 E.01233
G1 X133.119 Y133.692 E.08982
G1 X129.155 Y125.903 E.25874
G1 X128.921 Y125.188 E.02228
G1 X128.968 Y124.481 E.02099
G1 X129.207 Y123.898 E.01866
G1 X129.615 Y123.409 E.01885
G1 X130.229 Y123.036 E.02128
G1 X130.629 Y122.945 E.01214
; LINE_WIDTH: 0.362649
G1 X130.984 Y122.923 E.00926
G1 X133.515 Y122.923 E.06596
G1 X133.515 Y122.604 E.0083
G1 X130.984 Y122.604 E.06596
; LINE_WIDTH: 0.361614
G1 X130.568 Y122.619 E.01079
; LINE_WIDTH: 0.418317
G1 X130.153 Y122.633 E.01271
G1 X127.13 Y122.633 E.09247
G1 X128.498 Y125.314 E.09206
G1 X128.828 Y126.003 E.02337
G1 X128.584 Y124.653 F30000
; LINE_WIDTH: 0.419999
G1 F4639
G1 X128.601 Y124.392 E.00804
G1 X128.884 Y123.703 E.02288
G1 X129.366 Y123.126 E.02312
G1 X129.556 Y123.01 E.00683
G1 X127.746 Y123.01 E.05562
G1 X128.557 Y124.6 E.05483
G1 X128.526 Y123.409 F30000
; LINE_WIDTH: 0.580052
G1 F4639
G2 X128.529 Y123.519 I-.029 J.056 E.0115
G1 X127.48 Y128.33 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4639
G1 X128.219 Y129.781 E.05401
G1 X126.846 Y131.154 E.06444
G1 X125.74 Y131.154 E.0367
G1 X125.555 Y131.231 E.00664
G1 X120.95 Y126.626 E.216
G1 X120.95 Y129.374 E.09114
G1 X125.627 Y124.697 E.21937
G1 X124.633 Y122.749 E.07255
G3 X124.604 Y122.604 I.288 J-.133 E.00496
G1 X120.95 Y118.95 E.1714
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X128.626 Y118.95 E.16349
G1 X130.032 Y120.356 E.06593
G1 X129.968 Y120.356 E.0021
G1 X131.374 Y118.95 E.06593
G1 X136.302 Y118.95 E.16349
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X135.764 Y122.236 E.15416
G1 X135.764 Y121.34 E.02972
G3 X135.657 Y120.767 I.647 J-.417 E.01984
G1 X135.564 Y120.674 E.00437
G1 X132.57 Y127.621 F30000
G1 F4639
G1 X131.828 Y126.172 E.05401
G1 X132.829 Y125.171 E.04694
G1 X134.827 Y125.151 E.06628
G1 X139.05 Y129.374 E.19809
G1 X139.05 Y126.626 E.09114
G1 X134.427 Y131.249 E.21687
G1 X135.63 Y133.63 E.08849
G1 X139.05 Y137.05 E.16042
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X130.293 Y135.969 E.05068
G1 X129.707 Y135.969 E.01947
G1 X128.626 Y137.05 E.05068
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X124.755 Y133.245 E.17848
G1 X124.755 Y134.873 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X124.755 Y133.245 E-.61876
G1 X124.492 Y133.508 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 90/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L90
M991 S0 P89 ;notify layer change
G17
G3 Z18.2 I-.199 J1.201 P1  F30000
G1 X135.905 Y135.396 Z18.2
G1 Z18
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4946
G1 X125.328 Y135.396 E.35083
G1 X125.328 Y131.728 E.12168
G1 X129.857 Y131.728 E.15021
G1 X124.348 Y120.929 E.40212
M73 P89 R2
G1 X135.19 Y120.929 E.35964
G1 X135.19 Y124.597 E.12168
G1 X130.379 Y124.597 E.1596
G1 X135.877 Y135.342 E.40039
; WIPE_START
G1 F24000
G1 X133.877 Y135.353 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.4 I-.423 J1.141 P1  F30000
G1 X139.398 Y137.398 Z18.4
G1 Z18
G1 E.8 F1800
G1 F4946
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4946
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.4 I.961 J-.746 P1  F30000
G1 X134.908 Y134.024 Z18.4
G1 Z18
G1 E.8 F1800
M204 S2000
; FEATURE: Top surface
G1 F4946
G1 X133.758 Y135.174 E.04997
G1 X133.225 Y135.174
G1 X134.757 Y133.642 E.06657
G1 X134.577 Y133.289
G1 X132.692 Y135.174 E.08189
G1 X132.159 Y135.174
G1 X134.396 Y132.936 E.09722
G1 X134.215 Y132.583
G1 X131.625 Y135.174 E.11255
G1 X131.092 Y135.174
G1 X134.035 Y132.231 E.12788
G1 X133.854 Y131.878
G1 X130.559 Y135.174 E.14321
G1 X130.026 Y135.174
G1 X133.674 Y131.525 E.15854
G1 X133.493 Y131.172
G1 X129.492 Y135.174 E.17387
G1 X128.959 Y135.174
G1 X133.313 Y130.82 E.1892
G1 X133.132 Y130.467
G1 X128.426 Y135.174 E.20453
G1 X127.892 Y135.174
G1 X132.952 Y130.114 E.21985
G1 X132.771 Y129.761
G1 X127.359 Y135.174 E.23518
G1 X126.826 Y135.174
G1 X130.049 Y131.95 E.14007
G1 X129.516 Y131.95
G1 X126.293 Y135.174 E.14007
G1 X125.817 Y135.116
G1 X128.983 Y131.95 E.13758
G1 X128.45 Y131.95
G1 X125.551 Y134.849 E.12596
G1 X125.551 Y134.316
G1 X127.916 Y131.95 E.10279
G1 X127.383 Y131.95
G1 X125.551 Y133.782 E.07962
G1 X125.551 Y133.249
G1 X126.85 Y131.95 E.05644
G1 X126.316 Y131.95
G1 X125.551 Y132.716 E.03327
M204 S10000
G1 X130.162 Y131.837 F30000
M204 S2000
G1 F4946
G1 X132.591 Y129.409 E.10554
G1 X132.41 Y129.056
G1 X129.982 Y131.484 E.10552
G1 X129.802 Y131.131
G1 X132.23 Y128.703 E.1055
G1 X132.049 Y128.35
G1 X129.622 Y130.778 E.10549
G1 X129.442 Y130.425
G1 X131.869 Y127.998 E.10547
G1 X131.688 Y127.645
G1 X129.261 Y130.072 E.10545
G1 X129.081 Y129.718
G1 X131.508 Y127.292 E.10544
G1 X131.327 Y126.939
G1 X128.901 Y129.365 E.10542
G1 X128.721 Y129.012
G1 X131.147 Y126.587 E.1054
G1 X130.966 Y126.234
G1 X128.541 Y128.659 E.10539
G1 X128.361 Y128.306
G1 X130.786 Y125.881 E.10537
G1 X130.605 Y125.528
G1 X128.181 Y127.953 E.10535
G1 X128.001 Y127.6
G1 X130.425 Y125.176 E.10534
G1 X130.244 Y124.823
G1 X127.82 Y127.247 E.10532
G1 X127.64 Y126.893
G1 X130.064 Y124.47 E.10531
M204 S10000
G1 X133.891 Y124.375 F30000
M204 S2000
G1 F4946
G1 X134.968 Y123.299 E.04676
G1 X134.968 Y122.766
G1 X133.358 Y124.375 E.06993
G1 X132.825 Y124.375
G1 X134.968 Y122.232 E.09311
G1 X134.968 Y121.699
G1 X132.292 Y124.375 E.11628
G1 X131.758 Y124.375
G1 X134.813 Y121.32 E.13274
G1 X134.449 Y121.152
G1 X131.225 Y124.375 E.14007
G1 X130.692 Y124.375
G1 X133.915 Y121.152 E.14007
G1 X133.382 Y121.152
G1 X130.159 Y124.375 E.14007
M204 S10000
; WIPE_START
G1 F24000
G1 X131.573 Y122.961 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.4 I-.799 J-.918 P1  F30000
G1 X127.46 Y126.54 Z18.4
G1 Z18
G1 E.8 F1800
M204 S2000
G1 F4946
G1 X132.849 Y121.152 E.23416
G1 X132.315 Y121.152
G1 X127.28 Y126.187 E.21882
G1 X127.1 Y125.834
G1 X131.782 Y121.152 E.20347
G1 X131.249 Y121.152
G1 X126.92 Y125.481 E.18813
G1 X126.74 Y125.128
G1 X130.716 Y121.152 E.17278
G1 X130.182 Y121.152
G1 X126.559 Y124.775 E.15744
G1 X126.379 Y124.422
G1 X129.649 Y121.152 E.14209
G1 X129.116 Y121.152
G1 X126.199 Y124.068 E.12674
G1 X126.019 Y123.715
G1 X128.583 Y121.152 E.1114
G1 X128.049 Y121.152
G1 X125.839 Y123.362 E.09605
G1 X125.659 Y123.009
G1 X127.516 Y121.152 E.08071
G1 X126.983 Y121.152
G1 X125.479 Y122.656 E.06536
G1 X125.341 Y122.26
G1 X126.449 Y121.152 E.04817
M204 S10000
; WIPE_START
G1 F24000
G1 X125.341 Y122.26 E-.59567
G1 X125.479 Y122.656 E-.15921
G1 X125.488 Y122.646 E-.00513
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.4 I-.952 J.758 P1  F30000
G1 X134.927 Y134.502 Z18.4
G1 Z18
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.368901
G1 F4946
G1 X134.237 Y135.192 E.02594
G1 X134.986 Y123.803 F30000
; LINE_WIDTH: 0.405563
G1 F4946
G1 X134.396 Y124.394 E.02469
; WIPE_START
G1 F24000
G1 X134.986 Y123.803 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.4 I.346 J-1.167 P1  F30000
G1 X125.992 Y121.133 Z18.4
G1 Z18
G1 E.8 F1800
; LINE_WIDTH: 0.339511
G1 F4946
G1 X125.322 Y121.803 E.02289
G1 X125.967 Y131.931 F30000
; LINE_WIDTH: 0.186029
G1 F4946
G1 X125.532 Y132.367 E.00718
G1 X124.98 Y134.648 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4946
G1 X124.98 Y133.02 E.05401
G1 X120.95 Y137.05 E.18905
G1 X120.95 Y134.302 E.09114
G1 X123.698 Y137.05 E.12889
G1 X128.626 Y137.05 E.16349
G1 X129.932 Y135.744 E.06124
G1 X130.068 Y135.744 E.00452
G1 X131.374 Y137.05 E.06124
G1 X136.302 Y137.05 E.16349
G1 X139.05 Y134.302 E.12889
G1 X139.05 Y137.05 E.09114
G1 X135.143 Y133.143 E.18328
G1 X134.259 Y131.417 E.06432
G1 X139.05 Y126.626 E.22472
G1 X139.05 Y129.374 E.09114
G1 X134.622 Y124.946 E.20773
G1 X133.054 Y124.946 E.05199
G1 X131.661 Y126.339 E.06536
G1 X132.403 Y127.789 E.05401
; WIPE_START
G1 F24000
G1 X131.661 Y126.339 E-.61876
G1 X131.924 Y126.076 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.4 I-.534 J-1.094 P1  F30000
G1 X127.647 Y128.163 Z18.4
G1 Z18
G1 E.8 F1800
G1 F4946
G1 X128.387 Y129.613 E.05401
G1 X126.621 Y131.379 E.08287
G1 X125.703 Y131.379 E.03042
G1 X120.95 Y126.626 E.22298
G1 X120.95 Y129.374 E.09114
G1 X125.794 Y124.53 E.22723
G1 X125.028 Y123.028 E.05595
G1 X120.95 Y118.95 E.19127
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X128.626 Y118.95 E.16349
G1 X130.257 Y120.581 E.0765
G1 X129.743 Y120.581 E.01705
G1 X131.374 Y118.95 E.0765
G1 X136.302 Y118.95 E.16349
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X135.538 Y122.462 E.16473
G1 X135.538 Y120.833 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X135.538 Y122.462 E-.61876
G1 X135.801 Y122.199 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 91/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L91
M991 S0 P90 ;notify layer change
G17
G3 Z18.4 I-.861 J-.86 P1  F30000
G1 X125.804 Y132.203 Z18.4
G1 Z18.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3134
G1 X130.633 Y132.203 E.16019
G1 X125.72 Y122.572 E.35866
G1 X125.72 Y121.405 E.03871
G1 X134.714 Y121.405 E.29835
G1 X134.714 Y124.122 E.09012
G1 X129.601 Y124.122 E.16962
G1 X134.529 Y133.753 E.35888
G1 X134.529 Y134.92 E.03872
G1 X125.804 Y134.92 E.28943
G1 X125.804 Y132.263 E.08813
G1 X126.196 Y132.595 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3134
G1 X131.273 Y132.595 E.15601
M73 P90 R2
G1 X126.112 Y122.478 E.34901
G1 X126.112 Y121.797 E.02091
G1 X134.322 Y121.797 E.25227
G1 X134.322 Y123.73 E.05938
G1 X128.96 Y123.73 E.16477
G1 X134.137 Y133.847 E.34923
G1 X134.137 Y134.528 E.02092
G1 X126.196 Y134.528 E.24401
G1 X126.196 Y132.655 E.05754
M204 S10000
; WIPE_START
G1 F24000
G1 X128.196 Y132.632 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.6 I-.476 J1.12 P1  F30000
G1 X139.398 Y137.398 Z18.6
G1 Z18.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3134
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3134
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.6 I.786 J-.929 P1  F30000
G1 X129.481 Y130.71 Z18.6
G1 Z18.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3134
G1 X128.741 Y129.259 E.05401
G1 X126.145 Y131.855 E.12177
G1 X120.95 Y126.626 E.24449
G1 X120.95 Y129.374 E.09114
G1 X126.148 Y124.176 E.24382
G1 X120.95 Y118.95 E.24449
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X128.626 Y118.95 E.16349
G1 X130.733 Y121.057 E.09881
G1 X129.267 Y121.057 E.04861
G1 X131.374 Y118.95 E.09881
G1 X136.302 Y118.95 E.16349
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X135.063 Y122.937 E.18704
G1 X135.063 Y121.309 E.05401
; WIPE_START
G1 F24000
G1 X135.063 Y122.937 E-.61876
G1 X135.325 Y122.675 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.6 I-.578 J-1.071 P1  F30000
G1 X130.566 Y125.243 Z18.6
G1 Z18.2
G1 E.8 F1800
G1 F3134
G1 X131.308 Y126.692 E.05401
G1 X133.53 Y124.47 E.10426
G1 X134.146 Y124.47 E.02043
G1 X139.05 Y129.374 E.23004
G1 X139.05 Y126.626 E.09114
G1 X133.906 Y131.77 E.2413
G1 X134.048 Y132.048 E.01037
G1 X139.05 Y137.05 E.23462
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X129.593 Y135.268 E.08356
G1 X130.407 Y135.268 E.02703
G1 X128.626 Y137.05 E.08356
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X125.456 Y132.544 E.21136
G1 X125.456 Y134.172 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X125.456 Y132.544 E-.61876
G1 X125.193 Y132.807 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 92/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L92
M991 S0 P91 ;notify layer change
G17
M73 P90 R1
G3 Z18.6 I.855 J.866 P1  F30000
G1 X125.804 Y132.203 Z18.6
G1 Z18.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3124
G1 X130.633 Y132.203 E.16019
G1 X125.72 Y122.572 E.35866
G1 X125.72 Y121.405 E.03871
G1 X134.714 Y121.405 E.29835
G1 X134.714 Y124.122 E.09012
G1 X129.601 Y124.122 E.16962
G1 X134.529 Y133.753 E.35888
G1 X134.529 Y134.92 E.03872
G1 X125.804 Y134.92 E.28943
G1 X125.804 Y132.263 E.08813
G1 X126.196 Y132.595 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3124
G1 X131.273 Y132.595 E.15601
G1 X126.112 Y122.478 E.34901
G1 X126.112 Y121.797 E.02091
G1 X134.322 Y121.797 E.25227
G1 X134.322 Y123.73 E.05938
G1 X128.96 Y123.73 E.16477
G1 X134.137 Y133.847 E.34923
G1 X134.137 Y134.528 E.02092
G1 X126.196 Y134.528 E.24401
G1 X126.196 Y132.655 E.05754
M204 S10000
; WIPE_START
G1 F24000
G1 X128.196 Y132.632 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.8 I-.476 J1.12 P1  F30000
G1 X139.398 Y137.398 Z18.8
G1 Z18.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3124
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3124
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.8 I.786 J-.929 P1  F30000
G1 X129.481 Y130.71 Z18.8
G1 Z18.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3124
G1 X128.741 Y129.259 E.05401
G1 X126.145 Y131.855 E.12177
G1 X120.95 Y126.626 E.24449
G1 X120.95 Y129.374 E.09114
G1 X126.148 Y124.176 E.24382
G1 X120.95 Y118.95 E.24449
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X128.626 Y118.95 E.16349
G1 X130.733 Y121.057 E.09881
G1 X129.267 Y121.057 E.04861
G1 X131.374 Y118.95 E.09881
G1 X136.302 Y118.95 E.16349
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X135.063 Y122.937 E.18704
G1 X135.063 Y121.309 E.05401
; WIPE_START
G1 F24000
G1 X135.063 Y122.937 E-.61876
G1 X135.325 Y122.675 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.8 I-.578 J-1.071 P1  F30000
G1 X130.566 Y125.243 Z18.8
G1 Z18.4
G1 E.8 F1800
G1 F3124
G1 X131.308 Y126.692 E.05401
G1 X133.53 Y124.47 E.10426
G1 X134.146 Y124.47 E.02043
G1 X139.05 Y129.374 E.23004
G1 X139.05 Y126.626 E.09114
M73 P91 R1
G1 X133.906 Y131.77 E.2413
G1 X134.048 Y132.048 E.01037
G1 X139.05 Y137.05 E.23462
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X129.593 Y135.268 E.08356
G1 X130.407 Y135.268 E.02703
G1 X128.626 Y137.05 E.08356
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X125.456 Y132.544 E.21136
G1 X125.456 Y134.172 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X125.456 Y132.544 E-.61876
G1 X125.193 Y132.807 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 93/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L93
M991 S0 P92 ;notify layer change
G17
G3 Z18.8 I.855 J.866 P1  F30000
G1 X125.804 Y132.203 Z18.8
G1 Z18.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3124
G1 X130.633 Y132.203 E.16019
G1 X125.72 Y122.572 E.35866
G1 X125.72 Y121.405 E.03871
G1 X134.714 Y121.405 E.29835
G1 X134.714 Y124.122 E.09012
G1 X129.601 Y124.122 E.16962
G1 X134.529 Y133.753 E.35888
G1 X134.529 Y134.92 E.03872
G1 X125.804 Y134.92 E.28943
G1 X125.804 Y132.263 E.08813
G1 X126.196 Y132.595 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3124
G1 X131.273 Y132.595 E.15601
G1 X126.112 Y122.478 E.34901
G1 X126.112 Y121.797 E.02091
G1 X134.322 Y121.797 E.25227
G1 X134.322 Y123.73 E.05938
G1 X128.96 Y123.73 E.16477
G1 X134.137 Y133.847 E.34923
G1 X134.137 Y134.528 E.02092
G1 X126.196 Y134.528 E.24401
G1 X126.196 Y132.655 E.05754
M204 S10000
; WIPE_START
G1 F24000
G1 X128.196 Y132.632 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19 I-.476 J1.12 P1  F30000
G1 X139.398 Y137.398 Z19
G1 Z18.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3124
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3124
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19 I.786 J-.929 P1  F30000
G1 X129.481 Y130.71 Z19
G1 Z18.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3124
G1 X128.741 Y129.259 E.05401
G1 X126.145 Y131.855 E.12177
G1 X120.95 Y126.626 E.24449
G1 X120.95 Y129.374 E.09114
G1 X126.148 Y124.176 E.24382
G1 X120.95 Y118.95 E.24449
G1 X120.95 Y121.698 E.09114
G1 X123.698 Y118.95 E.12889
G1 X128.626 Y118.95 E.16349
G1 X130.733 Y121.057 E.09881
G1 X129.267 Y121.057 E.04861
G1 X131.374 Y118.95 E.09881
G1 X136.302 Y118.95 E.16349
G1 X139.05 Y121.698 E.12889
G1 X139.05 Y118.95 E.09114
G1 X135.063 Y122.937 E.18704
G1 X135.063 Y121.309 E.05401
; WIPE_START
G1 F24000
G1 X135.063 Y122.937 E-.61876
G1 X135.325 Y122.675 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19 I-.578 J-1.071 P1  F30000
G1 X130.566 Y125.243 Z19
G1 Z18.6
G1 E.8 F1800
G1 F3124
G1 X131.308 Y126.692 E.05401
G1 X133.53 Y124.47 E.10426
G1 X134.146 Y124.47 E.02043
G1 X139.05 Y129.374 E.23004
G1 X139.05 Y126.626 E.09114
G1 X133.906 Y131.77 E.2413
G1 X134.048 Y132.048 E.01037
G1 X139.05 Y137.05 E.23462
G1 X139.05 Y134.302 E.09114
G1 X136.302 Y137.05 E.12889
G1 X131.374 Y137.05 E.16349
G1 X129.593 Y135.268 E.08356
G1 X130.407 Y135.268 E.02703
G1 X128.626 Y137.05 E.08356
G1 X123.698 Y137.05 E.16349
G1 X120.95 Y134.302 E.12889
G1 X120.95 Y137.05 E.09114
G1 X125.456 Y132.544 E.21136
G1 X125.456 Y134.172 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 18.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X125.456 Y132.544 E-.61876
G1 X125.193 Y132.807 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 94/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L94
M991 S0 P93 ;notify layer change
G17
G3 Z19 I.855 J.866 P1  F30000
G1 X125.804 Y132.203 Z19
G1 Z18.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3887
G1 X130.633 Y132.203 E.16019
G1 X125.72 Y122.572 E.35866
G1 X125.72 Y121.405 E.03871
G1 X134.714 Y121.405 E.29835
M73 P92 R1
G1 X134.714 Y124.122 E.09012
G1 X129.601 Y124.122 E.16962
G1 X134.529 Y133.753 E.35888
G1 X134.529 Y134.92 E.03872
G1 X125.804 Y134.92 E.28943
G1 X125.804 Y132.263 E.08813
G1 X126.196 Y132.595 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3887
G1 X131.273 Y132.595 E.15601
G1 X126.112 Y122.478 E.34901
G1 X126.112 Y121.797 E.02091
G1 X134.322 Y121.797 E.25227
G1 X134.322 Y123.73 E.05938
G1 X128.96 Y123.73 E.16477
G1 X134.137 Y133.847 E.34923
G1 X134.137 Y134.528 E.02092
G1 X126.196 Y134.528 E.24401
G1 X126.196 Y132.655 E.05754
M204 S10000
; WIPE_START
G1 F24000
G1 X128.196 Y132.632 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.2 I-.476 J1.12 P1  F30000
G1 X139.398 Y137.398 Z19.2
G1 Z18.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3887
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3887
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.2 I.582 J1.069 P1  F30000
G1 X139.05 Y137.05 Z19.2
G1 Z18.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3887
G1 X134.878 Y137.05 E.13839
G1 X134.878 Y133.669 E.11215
G1 X130.17 Y124.47 E.34278
G1 X135.063 Y124.47 E.16229
G1 X135.063 Y121.057 E.11323
G1 X125.372 Y121.057 E.32146
G1 X125.372 Y122.656 E.05304
G1 X130.065 Y131.855 E.34258
G1 X125.456 Y131.855 E.15288
G1 X125.456 Y137.05 E.17231
G1 X120.95 Y137.05 E.14946
G1 X120.95 Y118.95 E.60039
G1 X139.05 Y118.95 E.60039
G1 X139.05 Y136.99 E.5984
G1 X138.643 Y133.081 F30000
G1 F3887
G1 X138.643 Y134.709 E.05401
G1 X136.709 Y136.643 E.09069
G1 X138.643 Y136.643 E.06413
G1 X134.985 Y132.985 E.17159
G1 X134.208 Y131.468 E.05654
G1 X138.643 Y127.033 E.20802
G1 X138.643 Y128.967 E.06413
G1 X134.553 Y124.877 E.19185
G1 X133.123 Y124.877 E.04744
G1 X131.61 Y126.39 E.07097
G1 X132.352 Y127.84 E.05401
; WIPE_START
G1 F24000
G1 X131.61 Y126.39 E-.61876
G1 X131.873 Y126.127 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.2 I-.522 J-1.099 P1  F30000
G1 X127.698 Y128.112 Z19.2
G1 Z18.8
G1 E.8 F1800
G1 F3887
G1 X128.438 Y129.562 E.05401
G1 X126.552 Y131.448 E.08848
G1 X125.772 Y131.448 E.02587
G1 X121.357 Y127.033 E.2071
G1 X121.357 Y128.967 E.06413
G1 X125.845 Y124.479 E.21052
G1 X125.185 Y123.185 E.0482
G1 X121.357 Y119.357 E.17955
G1 X123.291 Y119.357 E.06413
G1 X121.357 Y121.291 E.09069
G1 X121.357 Y122.919 E.05401
G1 X127.405 Y119.357 F30000
G1 F3887
G1 X129.033 Y119.357 E.05401
G1 X130.326 Y120.65 E.06062
G1 X129.674 Y120.65 E.0216
G1 X130.967 Y119.357 E.06062
G1 X136.709 Y119.357 E.1905
G1 X138.643 Y121.291 E.09069
G1 X138.643 Y119.357 E.06413
G1 X135.47 Y122.53 E.14885
G1 X135.47 Y120.902 E.05401
; WIPE_START
G1 F24000
G1 X135.47 Y122.53 E-.61876
G1 X135.732 Y122.268 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.2 I-1.197 J-.221 P1  F30000
G1 X133.002 Y137.05 Z19.2
G1 Z18.8
G1 E.8 F1800
G1 F3887
G1 X131.374 Y137.05 E.05401
G1 X129.592 Y135.268 E.08356
G1 X130.408 Y135.268 E.02704
G1 X128.626 Y137.05 E.08356
G1 X126.998 Y137.05 E.05401
G1 X124.919 Y136.643 F30000
G1 F3887
G1 X123.291 Y136.643 E.05401
G1 X121.357 Y134.709 E.09069
G1 X121.357 Y136.643 E.06413
G1 X125.049 Y132.951 E.17317
G1 X125.049 Y134.58 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 19
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X125.049 Y132.951 E-.61876
G1 X124.786 Y133.214 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 95/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L95
M991 S0 P94 ;notify layer change
G17
G3 Z19.2 I.857 J.864 P1  F30000
G1 X125.804 Y132.203 Z19.2
G1 Z19
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3887
G1 X130.633 Y132.203 E.16019
G1 X125.72 Y122.572 E.35866
G1 X125.72 Y121.405 E.03871
G1 X134.714 Y121.405 E.29835
G1 X134.714 Y124.122 E.09012
G1 X129.601 Y124.122 E.16962
G1 X134.529 Y133.753 E.35888
G1 X134.529 Y134.92 E.03872
G1 X125.804 Y134.92 E.28943
G1 X125.804 Y132.263 E.08813
G1 X126.196 Y132.595 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3887
G1 X131.273 Y132.595 E.15601
G1 X126.112 Y122.478 E.34901
G1 X126.112 Y121.797 E.02091
G1 X134.322 Y121.797 E.25227
G1 X134.322 Y123.73 E.05938
G1 X128.96 Y123.73 E.16477
G1 X134.137 Y133.847 E.34923
G1 X134.137 Y134.528 E.02092
G1 X126.196 Y134.528 E.24401
G1 X126.196 Y132.655 E.05754
M204 S10000
; WIPE_START
G1 F24000
G1 X128.196 Y132.632 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.4 I-.476 J1.12 P1  F30000
G1 X139.398 Y137.398 Z19.4
G1 Z19
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3887
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3887
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.4 I.582 J1.069 P1  F30000
G1 X139.05 Y137.05 Z19.4
G1 Z19
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3887
G1 X134.878 Y137.05 E.13839
G1 X134.878 Y133.669 E.11215
G1 X130.17 Y124.47 E.34278
G1 X135.063 Y124.47 E.16229
G1 X135.063 Y121.057 E.11323
G1 X125.372 Y121.057 E.32146
G1 X125.372 Y122.656 E.05304
G1 X130.065 Y131.855 E.34258
G1 X125.456 Y131.855 E.15288
G1 X125.456 Y137.05 E.17231
G1 X120.95 Y137.05 E.14946
G1 X120.95 Y118.95 E.60039
G1 X139.05 Y118.95 E.60039
M73 P93 R1
G1 X139.05 Y136.99 E.5984
G1 X138.643 Y133.081 F30000
G1 F3887
G1 X138.643 Y134.709 E.05401
G1 X136.709 Y136.643 E.09069
G1 X138.643 Y136.643 E.06413
G1 X134.985 Y132.985 E.17159
G1 X134.208 Y131.468 E.05654
G1 X138.643 Y127.033 E.20802
G1 X138.643 Y128.967 E.06413
G1 X134.553 Y124.877 E.19185
G1 X133.123 Y124.877 E.04744
G1 X131.61 Y126.39 E.07097
G1 X132.352 Y127.84 E.05401
; WIPE_START
G1 F24000
G1 X131.61 Y126.39 E-.61876
G1 X131.873 Y126.127 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.4 I-.522 J-1.099 P1  F30000
G1 X127.698 Y128.112 Z19.4
G1 Z19
G1 E.8 F1800
G1 F3887
G1 X128.438 Y129.562 E.05401
G1 X126.552 Y131.448 E.08848
G1 X125.772 Y131.448 E.02587
G1 X121.357 Y127.033 E.2071
G1 X121.357 Y128.967 E.06413
G1 X125.845 Y124.479 E.21052
G1 X125.185 Y123.185 E.0482
G1 X121.357 Y119.357 E.17955
G1 X123.291 Y119.357 E.06413
G1 X121.357 Y121.291 E.09069
G1 X121.357 Y122.919 E.05401
G1 X127.405 Y119.357 F30000
G1 F3887
G1 X129.033 Y119.357 E.05401
G1 X130.326 Y120.65 E.06062
G1 X129.674 Y120.65 E.0216
G1 X130.967 Y119.357 E.06062
G1 X136.709 Y119.357 E.1905
G1 X138.643 Y121.291 E.09069
G1 X138.643 Y119.357 E.06413
G1 X135.47 Y122.53 E.14885
G1 X135.47 Y120.902 E.05401
; WIPE_START
G1 F24000
G1 X135.47 Y122.53 E-.61876
G1 X135.732 Y122.268 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.4 I-1.197 J-.221 P1  F30000
G1 X133.002 Y137.05 Z19.4
G1 Z19
G1 E.8 F1800
G1 F3887
G1 X131.374 Y137.05 E.05401
G1 X129.592 Y135.268 E.08356
G1 X130.408 Y135.268 E.02704
G1 X128.626 Y137.05 E.08356
G1 X126.998 Y137.05 E.05401
G1 X124.919 Y136.643 F30000
G1 F3887
G1 X123.291 Y136.643 E.05401
G1 X121.357 Y134.709 E.09069
G1 X121.357 Y136.643 E.06413
G1 X125.049 Y132.951 E.17317
G1 X125.049 Y134.58 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 19.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X125.049 Y132.951 E-.61876
G1 X124.786 Y133.214 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 96/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L96
M991 S0 P95 ;notify layer change
G17
G3 Z19.4 I.857 J.864 P1  F30000
G1 X125.804 Y132.203 Z19.4
G1 Z19.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3887
G1 X130.633 Y132.203 E.16019
G1 X125.72 Y122.572 E.35866
G1 X125.72 Y121.405 E.03871
G1 X134.714 Y121.405 E.29835
G1 X134.714 Y124.122 E.09012
G1 X129.601 Y124.122 E.16962
G1 X134.529 Y133.753 E.35888
G1 X134.529 Y134.92 E.03872
G1 X125.804 Y134.92 E.28943
G1 X125.804 Y132.263 E.08813
G1 X126.196 Y132.595 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3887
G1 X131.273 Y132.595 E.15601
G1 X126.112 Y122.478 E.34901
G1 X126.112 Y121.797 E.02091
G1 X134.322 Y121.797 E.25227
G1 X134.322 Y123.73 E.05938
G1 X128.96 Y123.73 E.16477
G1 X134.137 Y133.847 E.34923
G1 X134.137 Y134.528 E.02092
G1 X126.196 Y134.528 E.24401
G1 X126.196 Y132.655 E.05754
M204 S10000
; WIPE_START
G1 F24000
G1 X128.196 Y132.632 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.6 I-.476 J1.12 P1  F30000
G1 X139.398 Y137.398 Z19.6
G1 Z19.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3887
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3887
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.6 I.582 J1.069 P1  F30000
G1 X139.05 Y137.05 Z19.6
G1 Z19.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3887
G1 X134.878 Y137.05 E.13839
G1 X134.878 Y133.669 E.11215
G1 X130.17 Y124.47 E.34278
G1 X135.063 Y124.47 E.16229
G1 X135.063 Y121.057 E.11323
G1 X125.372 Y121.057 E.32146
G1 X125.372 Y122.656 E.05304
G1 X130.065 Y131.855 E.34258
G1 X125.456 Y131.855 E.15288
G1 X125.456 Y137.05 E.17231
G1 X120.95 Y137.05 E.14946
G1 X120.95 Y118.95 E.60039
G1 X139.05 Y118.95 E.60039
G1 X139.05 Y136.99 E.5984
G1 X138.643 Y133.081 F30000
G1 F3887
G1 X138.643 Y134.709 E.05401
G1 X136.709 Y136.643 E.09069
G1 X138.643 Y136.643 E.06413
G1 X134.985 Y132.985 E.17159
G1 X134.208 Y131.468 E.05654
G1 X138.643 Y127.033 E.20802
G1 X138.643 Y128.967 E.06413
G1 X134.553 Y124.877 E.19185
G1 X133.123 Y124.877 E.04744
G1 X131.61 Y126.39 E.07097
G1 X132.352 Y127.84 E.05401
; WIPE_START
G1 F24000
G1 X131.61 Y126.39 E-.61876
G1 X131.873 Y126.127 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.6 I-.522 J-1.099 P1  F30000
G1 X127.698 Y128.112 Z19.6
G1 Z19.2
G1 E.8 F1800
G1 F3887
G1 X128.438 Y129.562 E.05401
G1 X126.552 Y131.448 E.08848
G1 X125.772 Y131.448 E.02587
G1 X121.357 Y127.033 E.2071
G1 X121.357 Y128.967 E.06413
G1 X125.845 Y124.479 E.21052
G1 X125.185 Y123.185 E.0482
M73 P94 R1
G1 X121.357 Y119.357 E.17955
G1 X123.291 Y119.357 E.06413
G1 X121.357 Y121.291 E.09069
G1 X121.357 Y122.919 E.05401
G1 X127.405 Y119.357 F30000
G1 F3887
G1 X129.033 Y119.357 E.05401
G1 X130.326 Y120.65 E.06062
G1 X129.674 Y120.65 E.0216
G1 X130.967 Y119.357 E.06062
G1 X136.709 Y119.357 E.1905
G1 X138.643 Y121.291 E.09069
G1 X138.643 Y119.357 E.06413
G1 X135.47 Y122.53 E.14885
G1 X135.47 Y120.902 E.05401
; WIPE_START
G1 F24000
G1 X135.47 Y122.53 E-.61876
G1 X135.732 Y122.268 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.6 I-1.197 J-.221 P1  F30000
G1 X133.002 Y137.05 Z19.6
G1 Z19.2
G1 E.8 F1800
G1 F3887
G1 X131.374 Y137.05 E.05401
G1 X129.592 Y135.268 E.08356
G1 X130.408 Y135.268 E.02704
G1 X128.626 Y137.05 E.08356
G1 X126.998 Y137.05 E.05401
G1 X124.919 Y136.643 F30000
G1 F3887
G1 X123.291 Y136.643 E.05401
G1 X121.357 Y134.709 E.09069
G1 X121.357 Y136.643 E.06413
G1 X125.049 Y132.951 E.17317
G1 X125.049 Y134.58 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 19.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X125.049 Y132.951 E-.61876
G1 X124.786 Y133.214 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 97/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L97
M991 S0 P96 ;notify layer change
G17
G3 Z19.6 I.857 J.864 P1  F30000
G1 X125.804 Y132.203 Z19.6
G1 Z19.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3887
G1 X130.633 Y132.203 E.16019
G1 X125.72 Y122.572 E.35866
G1 X125.72 Y121.405 E.03871
G1 X134.714 Y121.405 E.29835
G1 X134.714 Y124.122 E.09012
G1 X129.601 Y124.122 E.16962
G1 X134.529 Y133.753 E.35888
G1 X134.529 Y134.92 E.03872
G1 X125.804 Y134.92 E.28943
G1 X125.804 Y132.263 E.08813
G1 X126.196 Y132.595 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3887
G1 X131.273 Y132.595 E.15601
G1 X126.112 Y122.478 E.34901
G1 X126.112 Y121.797 E.02091
G1 X134.322 Y121.797 E.25227
G1 X134.322 Y123.73 E.05938
G1 X128.96 Y123.73 E.16477
G1 X134.137 Y133.847 E.34923
G1 X134.137 Y134.528 E.02092
G1 X126.196 Y134.528 E.24401
G1 X126.196 Y132.655 E.05754
M204 S10000
; WIPE_START
G1 F24000
G1 X128.196 Y132.632 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.8 I-.476 J1.12 P1  F30000
G1 X139.398 Y137.398 Z19.8
G1 Z19.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3887
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3887
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.8 I.582 J1.069 P1  F30000
G1 X139.05 Y137.05 Z19.8
G1 Z19.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3887
G1 X134.878 Y137.05 E.13839
G1 X134.878 Y133.669 E.11215
G1 X130.17 Y124.47 E.34278
G1 X135.063 Y124.47 E.16229
G1 X135.063 Y121.057 E.11323
G1 X125.372 Y121.057 E.32146
G1 X125.372 Y122.656 E.05304
G1 X130.065 Y131.855 E.34258
G1 X125.456 Y131.855 E.15288
G1 X125.456 Y137.05 E.17231
G1 X120.95 Y137.05 E.14946
G1 X120.95 Y118.95 E.60039
G1 X139.05 Y118.95 E.60039
G1 X139.05 Y136.99 E.5984
G1 X138.643 Y133.081 F30000
G1 F3887
G1 X138.643 Y134.709 E.05401
G1 X136.709 Y136.643 E.09069
G1 X138.643 Y136.643 E.06413
G1 X134.985 Y132.985 E.17159
G1 X134.208 Y131.468 E.05654
G1 X138.643 Y127.033 E.20802
G1 X138.643 Y128.967 E.06413
G1 X134.553 Y124.877 E.19185
G1 X133.123 Y124.877 E.04744
G1 X131.61 Y126.39 E.07097
G1 X132.352 Y127.84 E.05401
; WIPE_START
G1 F24000
G1 X131.61 Y126.39 E-.61876
G1 X131.873 Y126.127 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.8 I-.522 J-1.099 P1  F30000
G1 X127.698 Y128.112 Z19.8
G1 Z19.4
G1 E.8 F1800
G1 F3887
G1 X128.438 Y129.562 E.05401
G1 X126.552 Y131.448 E.08848
G1 X125.772 Y131.448 E.02587
G1 X121.357 Y127.033 E.2071
G1 X121.357 Y128.967 E.06413
G1 X125.845 Y124.479 E.21052
G1 X125.185 Y123.185 E.0482
G1 X121.357 Y119.357 E.17955
G1 X123.291 Y119.357 E.06413
G1 X121.357 Y121.291 E.09069
G1 X121.357 Y122.919 E.05401
G1 X127.405 Y119.357 F30000
G1 F3887
G1 X129.033 Y119.357 E.05401
G1 X130.326 Y120.65 E.06062
G1 X129.674 Y120.65 E.0216
G1 X130.967 Y119.357 E.06062
G1 X136.709 Y119.357 E.1905
G1 X138.643 Y121.291 E.09069
G1 X138.643 Y119.357 E.06413
G1 X135.47 Y122.53 E.14885
G1 X135.47 Y120.902 E.05401
; WIPE_START
G1 F24000
G1 X135.47 Y122.53 E-.61876
G1 X135.732 Y122.268 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.8 I-1.197 J-.221 P1  F30000
G1 X133.002 Y137.05 Z19.8
G1 Z19.4
G1 E.8 F1800
G1 F3887
G1 X131.374 Y137.05 E.05401
G1 X129.592 Y135.268 E.08356
G1 X130.408 Y135.268 E.02704
G1 X128.626 Y137.05 E.08356
G1 X126.998 Y137.05 E.05401
G1 X124.919 Y136.643 F30000
G1 F3887
G1 X123.291 Y136.643 E.05401
G1 X121.357 Y134.709 E.09069
G1 X121.357 Y136.643 E.06413
G1 X125.049 Y132.951 E.17317
G1 X125.049 Y134.58 E.05401
M106 S244.8
; CHANGE_LAYER
; Z_HEIGHT: 19.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X125.049 Y132.951 E-.61876
G1 X124.786 Y133.214 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 98/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L98
M991 S0 P97 ;notify layer change
G17
G3 Z19.8 I.857 J.864 P1  F30000
G1 X125.804 Y132.203 Z19.8
G1 Z19.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F15476.087
G1 X130.633 Y132.203 E.16019
G1 X125.72 Y122.572 E.35866
G1 X125.72 Y121.405 E.03871
G1 X134.714 Y121.405 E.29835
G1 X134.714 Y124.122 E.09012
M73 P95 R1
G1 X129.601 Y124.122 E.16962
G1 X134.529 Y133.753 E.35888
G1 X134.529 Y134.92 E.03872
G1 X125.804 Y134.92 E.28943
G1 X125.804 Y132.263 E.08813
G1 X126.196 Y132.595 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X131.273 Y132.595 E.15601
G1 X126.112 Y122.478 E.34901
G1 X126.112 Y121.797 E.02091
G1 X134.322 Y121.797 E.25227
G1 X134.322 Y123.73 E.05938
G1 X128.96 Y123.73 E.16477
G1 X134.137 Y133.847 E.34923
G1 X134.137 Y134.528 E.02092
G1 X126.196 Y134.528 E.24401
G1 X126.196 Y132.655 E.05754
M204 S10000
; WIPE_START
G1 F24000
G1 X128.196 Y132.632 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20 I-.476 J1.12 P1  F30000
G1 X139.398 Y137.398 Z20
G1 Z19.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
G1 X139.027 Y137.231 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.401375
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X139.027 Y118.972 E.94129
G1 X138.576 Y118.972 E.02327
G1 X138.576 Y137.028 E.93085
G1 X138.125 Y137.028 E.02327
G1 X138.125 Y118.972 E.93085
G1 X137.673 Y118.972 E.02327
G1 X137.673 Y137.028 E.93085
G1 X137.222 Y137.028 E.02327
G1 X137.222 Y118.972 E.93085
G1 X136.771 Y118.972 E.02327
G1 X136.771 Y137.028 E.93085
G1 X136.319 Y137.028 E.02327
G1 X136.319 Y118.972 E.93085
G1 X135.868 Y118.972 E.02327
G1 X135.868 Y137.028 E.93085
G1 X135.416 Y137.028 E.02327
G1 X135.416 Y118.972 E.93085
G1 X134.965 Y118.972 E.02327
G1 X134.965 Y137.028 E.93085
G1 X134.899 Y137.028 E.0034
G1 X134.899 Y133.664 E.17345
G1 X134.514 Y132.911 E.04361
G1 X134.514 Y124.491 E.43403
G1 X134.062 Y124.491 E.02327
G1 X134.062 Y132.029 E.38856
G1 X133.611 Y131.147 E.05108
G1 X133.611 Y124.491 E.34308
G1 X133.16 Y124.491 E.02327
G1 X133.16 Y130.264 E.29761
G1 X132.708 Y129.382 E.05108
G1 X132.708 Y124.491 E.25214
G1 X132.257 Y124.491 E.02327
G1 X132.257 Y128.5 E.20667
G1 X131.805 Y127.618 E.05108
G1 X131.805 Y124.491 E.1612
G1 X131.354 Y124.491 E.02327
G1 X131.354 Y126.736 E.11573
G1 X130.903 Y125.854 E.05108
G1 X130.903 Y124.491 E.07026
G1 X130.451 Y124.491 E.02327
G1 X130.451 Y125.417 E.0477
M106 S244.8
; WIPE_START
G1 F24000
G1 X130.451 Y124.491 E-.35161
G1 X130.903 Y124.491 E-.17152
G1 X130.903 Y125.115 E-.23687
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20 I.891 J.829 P1  F30000
G1 X134.514 Y121.238 Z20
G1 Z19.6
G1 E.8 F1800
M106 S255
M73 P95 R0
G1 F3000
G1 X134.514 Y118.972 E.11682
G1 X134.062 Y118.972 E.02327
G1 X134.062 Y121.035 E.10638
G1 X133.611 Y121.035 E.02327
G1 X133.611 Y118.972 E.10638
G1 X133.16 Y118.972 E.02327
G1 X133.16 Y121.035 E.10638
G1 X132.708 Y121.035 E.02327
G1 X132.708 Y118.972 E.10638
G1 X132.257 Y118.972 E.02327
G1 X132.257 Y121.035 E.10638
G1 X131.805 Y121.035 E.02327
G1 X131.805 Y118.972 E.10638
G1 X131.354 Y118.972 E.02327
G1 X131.354 Y121.035 E.10638
G1 X130.903 Y121.035 E.02327
G1 X130.903 Y118.972 E.10638
G1 X130.451 Y118.972 E.02327
G1 X130.451 Y121.035 E.10638
G1 X130 Y121.035 E.02327
G1 X130 Y118.972 E.10638
G1 X129.549 Y118.972 E.02327
G1 X129.549 Y121.035 E.10638
G1 X129.097 Y121.035 E.02327
G1 X129.097 Y118.972 E.10638
G1 X128.646 Y118.972 E.02327
G1 X128.646 Y121.035 E.10638
G1 X128.194 Y121.035 E.02327
G1 X128.194 Y118.972 E.10638
G1 X127.743 Y118.972 E.02327
G1 X127.743 Y121.035 E.10638
G1 X127.292 Y121.035 E.02327
G1 X127.292 Y118.972 E.10638
G1 X126.84 Y118.972 E.02327
G1 X126.84 Y121.035 E.10638
G1 X126.389 Y121.035 E.02327
G1 X126.389 Y118.972 E.10638
G1 X125.938 Y118.972 E.02327
G1 X125.938 Y121.238 E.11682
M106 S244.8
G1 X120.972 Y118.769 F30000
M106 S255
G1 F3000
G1 X120.972 Y137.028 E.94129
G1 X121.424 Y137.028 E.02327
G1 X121.424 Y118.972 E.93085
G1 X121.875 Y118.972 E.02327
G1 X121.875 Y137.028 E.93085
G1 X122.327 Y137.028 E.02327
G1 X122.327 Y118.972 E.93085
G1 X122.778 Y118.972 E.02327
G1 X122.778 Y137.028 E.93085
G1 X123.229 Y137.028 E.02327
G1 X123.229 Y118.972 E.93085
G1 X123.681 Y118.972 E.02327
G1 X123.681 Y137.028 E.93085
G1 X124.132 Y137.028 E.02327
G1 X124.132 Y118.972 E.93085
G1 X124.583 Y118.972 E.02327
G1 X124.583 Y137.028 E.93085
G1 X125.035 Y137.028 E.02327
G1 X125.035 Y118.972 E.93085
G1 X125.486 Y118.972 E.02327
G1 X125.486 Y131.834 E.66306
G1 X125.938 Y131.834 E.02327
G1 X125.938 Y123.812 E.41354
G1 X126.389 Y124.697 E.05121
G1 X126.389 Y131.834 E.36793
G1 X126.84 Y131.834 E.02327
G1 X126.84 Y125.582 E.32231
G1 X127.292 Y126.466 E.05121
G1 X127.292 Y131.834 E.2767
G1 X127.743 Y131.834 E.02327
G1 X127.743 Y127.351 E.23108
G1 X128.194 Y128.236 E.05121
G1 X128.194 Y131.834 E.18547
G1 X128.646 Y131.834 E.02327
G1 X128.646 Y129.121 E.13985
G1 X129.097 Y130.006 E.05121
G1 X129.097 Y131.834 E.09423
G1 X129.549 Y131.834 E.02327
G1 X129.549 Y130.891 E.04862
G1 X130 Y131.775 E.05121
G1 X130 Y132.036 E.01344
M106 S244.8
; WIPE_START
G1 F24000
G1 X130 Y131.775 E-.09909
G1 X129.549 Y130.891 E-.37746
G1 X129.549 Y131.637 E-.28345
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20 I-1.029 J-.649 P1  F30000
G1 X126.695 Y136.159 Z20
G1 Z19.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.605248
; LAYER_HEIGHT: 0.2
G1 F11203.426
G1 X133.579 Y136.159 E.31545
G1 X133.639 Y135.689 F30000
; LINE_WIDTH: 0.419999
G1 F15000
G1 X126.225 Y135.689 E.2278
G1 X126.225 Y136.629 E.02887
G1 X134.109 Y136.629 E.24224
G1 X134.109 Y135.689 E.02887
G1 X133.699 Y135.689 E.01259
G1 X133.639 Y135.312 F30000
G1 F15000
G1 X125.848 Y135.312 E.23939
G1 X125.848 Y137.006 E.05204
G1 X134.486 Y137.006 E.26541
G1 X134.486 Y135.312 E.05204
M73 P96 R0
G1 X133.699 Y135.312 E.02418
M106 S252.45
; CHANGE_LAYER
; Z_HEIGHT: 19.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F24000
G1 X134.486 Y135.312 E-.29898
G1 X134.486 Y136.525 E-.46102
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 99/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L99
M991 S0 P98 ;notify layer change
G17
G3 Z20 I.542 J-1.089 P1  F30000
G1 X125.804 Y132.203 Z20
G1 Z19.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7482
G1 X130.633 Y132.203 E.16019
G1 X125.72 Y122.572 E.35866
G1 X125.72 Y121.405 E.03871
G1 X134.714 Y121.405 E.29835
G1 X134.714 Y124.122 E.09012
G1 X129.601 Y124.122 E.16962
G1 X134.529 Y133.753 E.35888
G1 X134.529 Y134.92 E.03872
G1 X125.804 Y134.92 E.28943
G1 X125.804 Y132.263 E.08813
G1 X126.196 Y132.595 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7482
G1 X131.273 Y132.595 E.15601
G1 X126.112 Y122.478 E.34901
G1 X126.112 Y121.797 E.02091
G1 X134.322 Y121.797 E.25227
G1 X134.322 Y123.73 E.05938
G1 X128.96 Y123.73 E.16477
G1 X134.137 Y133.847 E.34923
G1 X134.137 Y134.528 E.02092
G1 X126.196 Y134.528 E.24401
G1 X126.196 Y132.655 E.05754
M204 S10000
; WIPE_START
G1 F24000
G1 X128.196 Y132.632 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.2 I-.476 J1.12 P1  F30000
G1 X139.398 Y137.398 Z20.2
G1 Z19.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7482
G1 X120.602 Y137.398 E.62349
G1 X120.602 Y118.602 E.62349
G1 X139.398 Y118.602 E.62349
G1 X139.398 Y137.338 E.6215
G1 X139.79 Y137.79 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7482
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
; WIPE_START
G1 F24000
G1 X137.79 Y137.736 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.2 I.059 J-1.216 P1  F30000
G1 X127.433 Y137.234 Z20.2
G1 Z19.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.422224
G1 F7482
G1 X120.935 Y130.737 E.28403
G1 X120.935 Y131.273 E.01658
G1 X126.727 Y137.065 E.25316
G1 X126.191 Y137.065 E.01658
G1 X120.935 Y131.809 E.22971
G1 X120.935 Y132.346 E.01658
G1 X125.654 Y137.065 E.20627
G1 X125.118 Y137.065 E.01658
G1 X120.935 Y132.882 E.18282
G1 X120.935 Y133.419 E.01658
G1 X124.581 Y137.065 E.15937
G1 X124.045 Y137.065 E.01658
G1 X120.935 Y133.955 E.13592
G1 X120.935 Y134.491 E.01658
G1 X123.509 Y137.065 E.11248
G1 X122.972 Y137.065 E.01658
G1 X120.935 Y135.028 E.08903
G1 X120.935 Y135.564 E.01658
G1 X122.436 Y137.065 E.06558
G1 X121.899 Y137.065 E.01658
G1 X120.935 Y136.101 E.04213
G1 X120.935 Y136.637 E.01658
G1 X121.533 Y137.234 E.0261
; WIPE_START
G1 F24000
G1 X120.935 Y136.637 E-.32093
G1 X120.935 Y136.101 E-.20384
G1 X121.373 Y136.538 E-.23523
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.2 I1.044 J.626 P1  F30000
G1 X132.03 Y118.766 Z20.2
G1 Z19.8
G1 E.8 F1800
G1 F7482
G1 X134.336 Y121.072 E.1008
G1 X133.8 Y121.072 E.01658
G1 X131.664 Y118.935 E.09338
G1 X131.127 Y118.935 E.01658
G1 X133.264 Y121.072 E.09338
G1 X132.727 Y121.072 E.01658
G1 X130.591 Y118.935 E.09338
G1 X130.054 Y118.935 E.01658
G1 X132.191 Y121.072 E.09338
G1 X131.654 Y121.072 E.01658
G1 X129.518 Y118.935 E.09338
G1 X128.982 Y118.935 E.01658
G1 X131.118 Y121.072 E.09338
G1 X130.581 Y121.072 E.01658
G1 X128.445 Y118.935 E.09338
G1 X127.909 Y118.935 E.01658
G1 X130.045 Y121.072 E.09338
G1 X129.509 Y121.072 E.01658
G1 X127.372 Y118.935 E.09338
G1 X126.836 Y118.935 E.01658
G1 X128.972 Y121.072 E.09338
G1 X128.436 Y121.072 E.01658
G1 X126.299 Y118.935 E.09338
G1 X125.763 Y118.935 E.01658
G1 X127.899 Y121.072 E.09338
G1 X127.363 Y121.072 E.01658
G1 X125.227 Y118.935 E.09338
G1 X124.69 Y118.935 E.01658
G1 X126.827 Y121.072 E.09338
G1 X126.29 Y121.072 E.01658
G1 X124.154 Y118.935 E.09338
G1 X123.617 Y118.935 E.01658
G1 X125.754 Y121.072 E.09338
G1 X125.387 Y121.072 E.01134
G1 X125.387 Y121.241 E.00524
G1 X123.081 Y118.935 E.10079
G1 X122.545 Y118.935 E.01658
G1 X125.387 Y121.778 E.12424
G1 X125.387 Y122.314 E.01658
G1 X122.008 Y118.935 E.14769
G1 X121.472 Y118.935 E.01658
G1 X125.594 Y123.057 E.18017
G1 X126.152 Y124.152 E.03799
G1 X120.935 Y118.935 E.22803
G1 X120.935 Y119.472 E.01658
G1 X126.711 Y125.247 E.25245
G1 X127.269 Y126.342 E.03799
G1 X120.935 Y120.008 E.27686
G1 X120.935 Y120.545 E.01658
G1 X127.828 Y127.437 E.30128
G1 X128.386 Y128.532 E.03799
G1 X120.935 Y121.081 E.3257
G1 X120.935 Y121.617 E.01658
G1 X128.945 Y129.627 E.35011
G1 X129.504 Y130.722 E.03799
G1 X120.935 Y122.154 E.37453
G1 X120.935 Y122.69 E.01658
G1 X130.062 Y131.817 E.39894
G1 X130.089 Y131.87 E.00184
G1 X129.579 Y131.87 E.01578
G1 X120.935 Y123.227 E.37781
G1 X120.935 Y123.763 E.01658
G1 X129.042 Y131.87 E.35437
G1 X128.506 Y131.87 E.01658
G1 X120.935 Y124.3 E.33092
G1 X120.935 Y124.836 E.01658
G1 X127.97 Y131.87 E.30747
G1 X127.433 Y131.87 E.01658
G1 X120.935 Y125.372 E.28402
G1 X120.935 Y125.909 E.01658
G1 X126.897 Y131.87 E.26058
G1 X126.36 Y131.87 E.01658
G1 X120.935 Y126.445 E.23713
G1 X120.935 Y126.982 E.01658
G1 X125.824 Y131.87 E.21368
G1 X125.471 Y131.87 E.01091
G1 X125.471 Y132.054 E.00567
G1 X120.935 Y127.518 E.19825
G1 X120.935 Y128.054 E.01658
G1 X125.471 Y132.59 E.19825
G1 X125.471 Y133.126 E.01658
G1 X120.935 Y128.591 E.19825
G1 X120.935 Y129.127 E.01658
G1 X125.471 Y133.663 E.19825
G1 X125.471 Y134.199 E.01658
G1 X120.935 Y129.664 E.19825
G1 X120.935 Y130.2 E.01658
G1 X125.471 Y134.736 E.19825
G1 X125.471 Y135.253 E.016
G1 X125.989 Y135.253 E.016
G1 X127.8 Y137.065 E.07917
G1 X128.336 Y137.065 E.01658
G1 X126.525 Y135.253 E.07917
G1 X127.061 Y135.253 E.01658
G1 X128.873 Y137.065 E.07917
G1 X129.409 Y137.065 E.01658
G1 X127.598 Y135.253 E.07917
G1 X128.134 Y135.253 E.01658
G1 X129.946 Y137.065 E.07917
G1 X130.482 Y137.065 E.01658
G1 X128.671 Y135.253 E.07917
G1 X129.207 Y135.253 E.01658
G1 X131.018 Y137.065 E.07917
G1 X131.555 Y137.065 E.01658
G1 X129.744 Y135.253 E.07917
G1 X130.28 Y135.253 E.01658
G1 X132.091 Y137.065 E.07917
G1 X132.628 Y137.065 E.01658
G1 X130.816 Y135.253 E.07917
G1 X131.353 Y135.253 E.01658
G1 X133.164 Y137.065 E.07917
G1 X133.7 Y137.065 E.01658
G1 X131.889 Y135.253 E.07917
G1 X132.426 Y135.253 E.01658
G1 X134.237 Y137.065 E.07917
G1 X134.773 Y137.065 E.01658
G1 X132.962 Y135.253 E.07917
G1 X133.498 Y135.253 E.01658
G1 X135.31 Y137.065 E.07917
G1 X135.846 Y137.065 E.01658
G1 X134.035 Y135.253 E.07917
G1 X134.571 Y135.253 E.01658
G1 X136.383 Y137.065 E.07917
G1 X136.919 Y137.065 E.01658
G1 X134.863 Y135.008 E.08988
G1 X134.863 Y134.472 E.01658
G1 X137.455 Y137.065 E.11333
G1 X137.992 Y137.065 E.01658
G1 X134.863 Y133.936 E.13678
G1 X134.863 Y133.673 E.00813
G1 X134.576 Y133.113 E.01944
G1 X138.528 Y137.065 E.17275
G1 X139.065 Y137.065 E.01658
G1 X134.014 Y132.014 E.22077
G1 X133.452 Y130.915 E.03815
G1 X139.065 Y136.528 E.24535
G1 X139.065 Y135.992 E.01658
G1 X132.889 Y129.817 E.26992
G1 X132.327 Y128.718 E.03815
G1 X139.065 Y135.455 E.2945
G1 X139.065 Y134.919 E.01658
G1 X131.765 Y127.619 E.31907
G1 X131.203 Y126.521 E.03815
G1 X139.065 Y134.383 E.34365
G1 X139.065 Y133.846 E.01658
G1 X130.641 Y125.422 E.36822
G1 X130.146 Y124.455 E.03358
G1 X130.21 Y124.455 E.00198
G1 X139.065 Y133.31 E.38705
G1 X139.065 Y132.773 E.01658
G1 X130.746 Y124.455 E.3636
G1 X131.283 Y124.455 E.01658
G1 X139.065 Y132.237 E.34016
G1 X139.065 Y131.701 E.01658
G1 X131.819 Y124.455 E.31671
G1 X132.356 Y124.455 E.01658
G1 X139.065 Y131.164 E.29326
G1 X139.065 Y130.628 E.01658
G1 X132.892 Y124.455 E.26982
G1 X133.428 Y124.455 E.01658
G1 X139.065 Y130.091 E.24637
G1 X139.065 Y129.555 E.01658
G1 X133.965 Y124.455 E.22292
G1 X134.501 Y124.455 E.01658
G1 X139.065 Y129.018 E.19947
G1 X139.065 Y128.482 E.01658
G1 X135.038 Y124.455 E.17603
G1 X135.048 Y123.929 E.01628
G1 X139.065 Y127.946 E.17559
G1 X139.065 Y127.409 E.01658
G1 X135.048 Y123.392 E.17559
G1 X135.048 Y122.856 E.01658
G1 X139.065 Y126.873 E.17559
G1 X139.065 Y126.336 E.01658
G1 X135.048 Y122.319 E.17559
G1 X135.048 Y121.783 E.01658
G1 X139.065 Y125.8 E.17559
G1 X139.065 Y125.264 E.01658
G1 X132.736 Y118.935 E.27661
G1 X133.273 Y118.935 E.01658
G1 X139.065 Y124.727 E.25317
G1 X139.065 Y124.191 E.01658
G1 X133.809 Y118.935 E.22972
G1 X134.346 Y118.935 E.01658
G1 X139.065 Y123.654 E.20627
G1 X139.065 Y123.118 E.01658
G1 X134.882 Y118.935 E.18282
G1 X135.419 Y118.935 E.01658
G1 X139.065 Y122.581 E.15938
G1 X139.065 Y122.045 E.01658
G1 X135.955 Y118.935 E.13593
G1 X136.491 Y118.935 E.01658
G1 X139.065 Y121.509 E.11248
G1 X139.065 Y120.972 E.01658
G1 X137.028 Y118.935 E.08903
G1 X137.564 Y118.935 E.01658
G1 X139.065 Y120.436 E.06559
G1 X139.065 Y119.899 E.01658
G1 X138.101 Y118.935 E.04214
G1 X138.637 Y118.935 E.01658
G1 X139.234 Y119.533 E.02611
; CHANGE_LAYER
; Z_HEIGHT: 20
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F24000
G1 X138.637 Y118.935 E-.32099
G1 X138.101 Y118.935 E-.20384
G1 X138.538 Y119.373 E-.23517
; WIPE_END
M73 P97 R0
G1 E-.04 F1800
; layer num/total_layer_count: 100/100
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L100
M991 S0 P99 ;notify layer change
G17
G3 Z20.2 I-.89 J-.83 P1  F30000
G1 X126.196 Y132.595 Z20.2
G1 Z20
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8614
G1 X131.273 Y132.595 E.15601
G1 X126.112 Y122.478 E.34901
G1 X126.112 Y121.797 E.02091
G1 X134.322 Y121.797 E.25227
G1 X134.322 Y123.73 E.05938
G1 X128.96 Y123.73 E.16477
G1 X134.137 Y133.847 E.34923
G1 X134.137 Y134.528 E.02092
G1 X126.196 Y134.528 E.24401
G1 X126.196 Y132.655 E.05754
M204 S10000
; WIPE_START
G1 F24000
G1 X128.196 Y132.632 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.4 I-.495 J1.112 P1  F30000
G1 X139.79 Y137.79 Z20.4
G1 Z20
G1 E.8 F1800
M204 S5000
G1 F8614
G1 X120.21 Y137.79 E.60164
G1 X120.21 Y118.21 E.60164
G1 X139.79 Y118.21 E.60164
G1 X139.79 Y137.73 E.5998
M204 S10000
G1 X139.583 Y136.815 F30000
M204 S2000
; FEATURE: Top surface
G1 F8614
G1 X138.815 Y137.583 E.03335
G1 X138.282 Y137.583
G1 X139.583 Y136.282 E.05652
G1 X139.583 Y135.749
G1 X137.749 Y137.583 E.0797
G1 X137.215 Y137.583
G1 X139.583 Y135.215 E.10287
G1 X139.583 Y134.682
G1 X136.682 Y137.583 E.12604
G1 X136.149 Y137.583
G1 X139.583 Y134.149 E.14922
G1 X139.583 Y133.616
G1 X135.616 Y137.583 E.17239
G1 X135.082 Y137.583
G1 X139.583 Y133.082 E.19556
G1 X139.583 Y132.549
G1 X134.549 Y137.583 E.21874
G1 X134.016 Y137.583
G1 X139.583 Y132.016 E.24191
G1 X139.583 Y131.482
G1 X133.482 Y137.583 E.26508
G1 X132.949 Y137.583
G1 X139.583 Y130.949 E.28825
G1 X139.583 Y130.416
G1 X132.416 Y137.583 E.31143
G1 X131.883 Y137.583
G1 X139.583 Y129.883 E.3346
G1 X139.583 Y129.349
G1 X134.345 Y134.587 E.22761
G1 X134.345 Y134.054
G1 X139.583 Y128.816 E.22761
G1 X139.583 Y128.283
G1 X134.251 Y133.614 E.23168
G1 X134.071 Y133.262
G1 X139.583 Y127.75 E.23953
G1 X139.583 Y127.216
G1 X133.89 Y132.909 E.24737
G1 X133.71 Y132.556
G1 X139.583 Y126.683 E.25521
G1 X139.583 Y126.15
G1 X133.529 Y132.203 E.26306
G1 X133.348 Y131.851
G1 X139.583 Y125.616 E.2709
G1 X139.583 Y125.083
G1 X133.168 Y131.498 E.27875
G1 X132.987 Y131.145
G1 X139.583 Y124.55 E.28659
G1 X139.583 Y124.017
G1 X132.807 Y130.792 E.29444
G1 X132.626 Y130.44
G1 X139.583 Y123.483 E.30228
G1 X139.583 Y122.95
G1 X132.446 Y130.087 E.31013
G1 X132.265 Y129.734
G1 X139.583 Y122.417 E.31797
G1 X139.583 Y121.884
G1 X132.085 Y129.381 E.32581
G1 X131.904 Y129.029
G1 X139.583 Y121.35 E.33366
G1 X139.583 Y120.817
G1 X131.724 Y128.676 E.3415
G1 X131.543 Y128.323
G1 X139.583 Y120.284 E.34935
G1 X139.583 Y119.75
G1 X131.363 Y127.97 E.35719
G1 X131.182 Y127.618
G1 X139.583 Y119.217 E.36504
G1 X139.583 Y118.684
G1 X134.53 Y123.737 E.21958
G1 X134.53 Y123.204
G1 X139.316 Y118.417 E.20799
G1 X138.783 Y118.417
G1 X134.53 Y122.67 E.18482
G1 X134.53 Y122.137
G1 X138.249 Y118.417 E.16164
G1 X137.716 Y118.417
G1 X134.53 Y121.604 E.13847
G1 X134.011 Y121.59
G1 X137.183 Y118.417 E.13785
G1 X136.65 Y118.417
G1 X133.477 Y121.59 E.13785
G1 X132.944 Y121.59
G1 X136.116 Y118.417 E.13785
G1 X135.583 Y118.417
G1 X132.411 Y121.59 E.13785
G1 X131.877 Y121.59
G1 X135.05 Y118.417 E.13785
G1 X134.516 Y118.417
G1 X131.344 Y121.59 E.13785
G1 X130.811 Y121.59
G1 X133.983 Y118.417 E.13785
G1 X133.45 Y118.417
G1 X130.278 Y121.59 E.13785
G1 X129.744 Y121.59
G1 X132.917 Y118.417 E.13785
G1 X132.383 Y118.417
G1 X129.211 Y121.59 E.13785
G1 X128.678 Y121.59
G1 X131.85 Y118.417 E.13785
G1 X131.317 Y118.417
G1 X128.145 Y121.59 E.13785
G1 X127.611 Y121.59
G1 X130.784 Y118.417 E.13785
G1 X130.25 Y118.417
G1 X127.078 Y121.59 E.13785
G1 X126.545 Y121.59
G1 X129.717 Y118.417 E.13785
G1 X129.184 Y118.417
G1 X126.011 Y121.59 E.13785
M204 S10000
; WIPE_START
G1 F24000
G1 X127.426 Y120.175 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.4 I-1.087 J.548 P1  F30000
G1 X131.002 Y127.265 Z20.4
G1 Z20
G1 E.8 F1800
M204 S2000
G1 F8614
G1 X134.329 Y123.937 E.14461
G1 X133.796 Y123.937
G1 X130.821 Y126.912 E.12928
G1 X130.641 Y126.559
G1 X133.263 Y123.937 E.11395
G1 X132.73 Y123.937
G1 X130.46 Y126.207 E.09862
G1 X130.28 Y125.854
G1 X132.196 Y123.937 E.08329
G1 X131.663 Y123.937
G1 X130.099 Y125.501 E.06796
G1 X129.919 Y125.148
G1 X131.13 Y123.937 E.05263
G1 X130.597 Y123.937
G1 X129.738 Y124.796 E.03731
G1 X129.558 Y124.443
G1 X130.063 Y123.937 E.02198
M204 S10000
; WIPE_START
G1 F24000
G1 X129.558 Y124.443 E-.27178
G1 X129.738 Y124.796 E-.15058
G1 X130.366 Y124.167 E-.33764
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.4 I-1.216 J.048 P1  F30000
G1 X130.668 Y131.865 Z20.4
G1 Z20
G1 E.8 F1800
M204 S2000
G1 F8614
G1 X130.145 Y132.388 E.02274
G1 X129.611 Y132.388
G1 X130.488 Y131.512 E.03809
G1 X130.308 Y131.159
G1 X129.078 Y132.388 E.05343
G1 X128.545 Y132.388
G1 X130.128 Y130.805 E.06878
G1 X129.947 Y130.452
G1 X128.012 Y132.388 E.08412
G1 X127.478 Y132.388
G1 X129.767 Y130.099 E.09947
G1 X129.587 Y129.746
G1 X126.945 Y132.388 E.11481
G1 X126.412 Y132.388
G1 X129.407 Y129.393 E.13016
M204 S10000
; WIPE_START
G1 F24000
G1 X127.993 Y130.807 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.4 I-.651 J1.028 P1  F30000
G1 X134.196 Y134.736 Z20.4
G1 Z20
G1 E.8 F1800
M204 S2000
G1 F8614
G1 X131.349 Y137.583 E.12372
G1 X130.816 Y137.583
G1 X133.663 Y134.736 E.12372
G1 X133.13 Y134.736
G1 X130.283 Y137.583 E.12372
G1 X129.75 Y137.583
G1 X132.597 Y134.736 E.12372
G1 X132.063 Y134.736
G1 X129.216 Y137.583 E.12372
G1 X128.683 Y137.583
G1 X131.53 Y134.736 E.12372
G1 X130.997 Y134.736
G1 X128.15 Y137.583 E.12372
G1 X127.616 Y137.583
G1 X130.464 Y134.736 E.12372
G1 X129.93 Y134.736
G1 X127.083 Y137.583 E.12372
G1 X126.55 Y137.583
G1 X129.397 Y134.736 E.12372
G1 X128.864 Y134.736
G1 X126.017 Y137.583 E.12372
G1 X125.483 Y137.583
G1 X128.33 Y134.736 E.12372
G1 X127.797 Y134.736
G1 X124.95 Y137.583 E.12372
G1 X124.417 Y137.583
G1 X127.264 Y134.736 E.12372
G1 X126.731 Y134.736
G1 X123.884 Y137.583 E.12372
G1 X123.35 Y137.583
G1 X126.197 Y134.736 E.12372
G1 X125.989 Y134.411
G1 X122.817 Y137.583 E.13783
G1 X122.284 Y137.583
G1 X125.989 Y133.878 E.161
G1 X125.989 Y133.344
G1 X121.75 Y137.583 E.18418
G1 X121.217 Y137.583
G1 X125.989 Y132.811 E.20735
M204 S10000
; WIPE_START
G1 F24000
G1 X124.575 Y134.225 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.4 I.906 J.813 P1  F30000
G1 X129.227 Y129.04 Z20.4
G1 Z20
G1 E.8 F1800
M204 S2000
G1 F8614
M73 P98 R0
G1 X120.684 Y137.583 E.37123
G1 X120.417 Y137.316
G1 X129.047 Y128.687 E.37498
G1 X128.867 Y128.333
G1 X120.417 Y136.783 E.36716
G1 X120.417 Y136.249
G1 X128.686 Y127.98 E.35933
G1 X128.506 Y127.627
G1 X120.417 Y135.716 E.3515
G1 X120.417 Y135.183
G1 X128.326 Y127.274 E.34367
G1 X128.146 Y126.921
G1 X120.417 Y134.65 E.33584
G1 X120.417 Y134.116
G1 X127.966 Y126.568 E.32802
G1 X127.786 Y126.215
G1 X120.417 Y133.583 E.32019
G1 X120.417 Y133.05
G1 X127.606 Y125.862 E.31236
G1 X127.425 Y125.508
G1 X120.417 Y132.516 E.30453
G1 X120.417 Y131.983
G1 X127.245 Y125.155 E.2967
G1 X127.065 Y124.802
G1 X120.417 Y131.45 E.28888
G1 X120.417 Y130.917
G1 X126.885 Y124.449 E.28105
G1 X126.705 Y124.096
G1 X120.417 Y130.383 E.27322
G1 X120.417 Y129.85
G1 X126.525 Y123.743 E.26539
G1 X126.345 Y123.39
G1 X120.417 Y129.317 E.25756
G1 X120.417 Y128.784
G1 X126.164 Y123.037 E.24974
G1 X125.984 Y122.683
G1 X120.417 Y128.25 E.24191
G1 X120.417 Y127.717
G1 X125.905 Y122.23 E.23845
G1 X125.905 Y121.696
G1 X120.417 Y127.184 E.23845
G1 X120.417 Y126.65
G1 X128.651 Y118.417 E.35777
G1 X128.117 Y118.417
G1 X120.417 Y126.117 E.3346
G1 X120.417 Y125.584
G1 X127.584 Y118.417 E.31142
G1 X127.051 Y118.417
G1 X120.417 Y125.051 E.28825
G1 X120.417 Y124.517
G1 X126.517 Y118.417 E.26508
G1 X125.984 Y118.417
G1 X120.417 Y123.984 E.2419
G1 X120.417 Y123.451
G1 X125.451 Y118.417 E.21873
G1 X124.918 Y118.417
G1 X120.417 Y122.918 E.19556
G1 X120.417 Y122.384
G1 X124.384 Y118.417 E.17238
G1 X123.851 Y118.417
G1 X120.417 Y121.851 E.14921
G1 X120.417 Y121.318
G1 X123.318 Y118.417 E.12604
G1 X122.785 Y118.417
G1 X120.417 Y120.785 E.10286
G1 X120.417 Y120.251
G1 X122.251 Y118.417 E.07969
G1 X121.718 Y118.417
G1 X120.417 Y119.718 E.05652
G1 X120.417 Y119.185
G1 X121.185 Y118.417 E.03334
M204 S10000
; WIPE_START
G1 F24000
G1 X120.417 Y119.185 E-.41236
G1 X120.417 Y119.718 E-.20264
G1 X120.687 Y119.448 E-.145
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.4 I-.194 J1.201 P1  F30000
G1 X134.627 Y121.701 Z20.4
G1 Z20
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.109425
G1 F8614
G1 X134.541 Y121.817 E.00078
G1 X134.511 Y121.796 E.0002
; WIPE_START
G1 F24000
G1 X134.541 Y121.817 E-.15336
G1 X134.627 Y121.701 E-.60664
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.4 I-1.217 J.003 P1  F30000
G1 X134.632 Y123.84 Z20.4
G1 Z20
G1 E.8 F1800
; LINE_WIDTH: 0.12927
G1 F8614
G1 X134.432 Y124.04 E.00199
; WIPE_START
G1 F24000
G1 X134.632 Y123.84 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.4 I-1.216 J-.034 P1  F30000
G1 X134.33 Y134.573 Z20.4
G1 Z20
G1 E.8 F1800
; LINE_WIDTH: 0.167753
G1 F8614
G1 X134.389 Y134.721 E.00162
G1 X134.33 Y134.78 E.00085
G1 X134.182 Y134.721 E.00162
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F24000
G1 X134.33 Y134.78 E-.301
G1 X134.389 Y134.721 E-.15816
G1 X134.33 Y134.573 E-.30084
; WIPE_END
G1 E-.04 F1800
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; filament end gcode 
M106 P3 S0
;===== date: 20230118 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z20.5 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos 
G1 Y265 F3000
M991 S0 P-1 ;end smooth timelapse at safe pos
M400 S2 ;wait for last picture to be taken

G1 X65 Y245 F12000
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z120 F600
    G1 Z118

M400 P100
M17 R ; restore z current

G90
G1 X128 Y250 F3600

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power

M73 P100 R0
; EXECUTABLE_BLOCK_END

