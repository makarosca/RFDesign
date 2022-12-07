# Scaffold Generation

#!/bin/bash
mkdir /output

# Run hallucination
python3 RFDesign/hallucination/hallucinate.py $@ --out /output/design

# Run rosetta relaxation
RFDesign/scripts/trfold_relax.sh /output/

# Run AF2 metrics
python3 RFDesign/scripts/af2_metrics.py /output/trf_relax

# Run PyRosetta metrics
python3 RFDesign/scripts/pyrosetta_metrics.py /output/trf_relax

# Compile metrics
python3 RFDesign/scripts/compile_metrics.py /output/trf_relax