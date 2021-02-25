set overlay_name "pystrath_rfsoc"
set design_name "block_design"

# Open project
open_project ./${overlay_name}/${overlay_name}.xpr

# Make block design
source ./${design_name}.tcl
