#!/bin/bash

RFDesign/biolib_run.sh --2chain --pdb=RFDesign/tutorials/halluc_SH3_binder/input/SH3_2w0z.pdb --mask '47-47,B7-14,23-23' --use_template 'B7-14' --spike_fas RFDesign/tutorials/halluc_SH3_binder/output/hits_sh3_r1/sh3_r1_66.fas --spike 0.999 --force_aa 'B7-14' --exclude_aa C --receptor RFDesign/tutorials/halluc_SH3_binder/input/SH3_2w0z_rec.pdb --rec_placement second --w_surfnp 1 --steps=m10 --num=1 --w_rog=1 --rog_thresh=16 --save_pdb=True --track_step=1 --cautious=True
