import os,sys,glob,shutil
import numpy as np
import pandas as pd

def split_folder(folder, batch_size, trb_dir=None, start_batch=0, ndigits=None):
    '''Splits files in a folder into subdirectories with <batch_size> files each.'''

    N = batch_size
    i = 0
    b = start_batch
    if trb_dir is None:
        trb_dir = folder+'/../'
        
    filenames = sorted(glob.glob(folder+'*pdb'))
    print(folder)
    print(len(filenames))
    if ndigits is None:
        ndigits = int(np.ceil(np.log10(len(filenames)/N)))

    for fn in filenames:
        subfolder = f'{b:0{ndigits}}/'
        os.makedirs(folder+'/'+subfolder, exist_ok=True)
        shutil.move(fn, folder+'/'+subfolder+os.path.basename(fn))
        trbfn = os.path.basename(fn).replace('.pdb','.trb')
        if os.path.islink(folder+'/'+trbfn):
            os.symlink(trb_dir+'/'+trbfn, folder+'/'+subfolder+trbfn)
            os.remove(folder+'/'+trbfn)

        i += 1
        if i>=N:
            b += 1
            i = 0




split_folder(folder=sys.argv[1], batch_size=5)