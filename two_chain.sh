#!/bin/bash
export PATH=/root/silent_tools:$PATH
/root/miniconda3/envs/rfdesign-cuda/bin/python3 RFDesign/scripts/split_folder.py /output/trf_relax/
for i in /output/trf_relax/*/
do
 cd $i
 silentfrompdbs *pdb > in.silent
 /root/miniconda3/envs/rfdesign-cuda/bin/python3 /root/RFDesign/scripts/af2_interface_metrics.py -silent in.silent
done

for i in /output/trf_relax/*/; 
do
  mkdir $i/relax; 
  cd $i/relax
  ln -s ../out.silent in.silent
  /root/rosetta_scripts.static.linuxgccrelease -beta_nov16 -in:file:silent_struct_type binary -in:file:silent in.silent -out:file:silent_struct_type binary -out:file:silent out.silent -mute protocols.rosetta_scripts.ParsedProtocol.REPORT -multithreading:total_threads 1 -parser:protocol /root/RFDesign/scripts/minterface.xml
  silentextract out.silent
  /root/miniconda3/envs/rfdesign-cuda/bin/python3 /root/RFDesign/scripts/get_interface_metrics.py .
 done

for i in /output/trf_relax/*/; 
do 
  cd /output/trf_relax/
  echo Getting binder RMSD for batch $i
  /root/miniconda3/envs/rfdesign-cuda/bin/python3 /root/RFDesign/scripts/get_binder_rmsd.py $i
done