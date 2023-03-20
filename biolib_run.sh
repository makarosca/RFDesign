# Scaffold Generation
two_chain=""
echo $1
if [ $1 == "--2chain" ] 
then 
  echo "Running 2chain optimization scoring mode..."
  two_chain="true"
  shift
fi

#!/bin/bash
mkdir /output

# Run hallucination
/root/miniconda3/envs/rfdesign-cuda/bin/python RFDesign/hallucination/hallucinate.py $@ --out /output/design

# Run rosetta relaxation
RFDesign/scripts/trfold_relax.sh /output/

# Run two chain and exit if specefied
if [[ -n $two_chain ]]
then 
  ./two_chain.sh
  exit
fi

# Run AF2 metrics
/root/miniconda3/envs/rfdesign-cuda/bin/python RFDesign/scripts/af2_metrics.py /output/trf_relax

# Run PyRosetta metrics
/root/miniconda3/envs/rfdesign-cuda/bin/python RFDesign/scripts/pyrosetta_metrics.py /output/trf_relax

# Compile metrics
/root/miniconda3/envs/rfdesign-cuda/bin/python RFDesign/scripts/compile_metrics.py /output/trf_relax