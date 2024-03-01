import pandas as pd
import argparse
import numpy as np
from pathlib import Path


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("exp_dir_prefix", help="Prefix of the experiment directory")
    args = parser.parse_args()


    seed = 0
    parent_dir = Path(args.exp_dir_prefix).parent
    prefix = Path(args.exp_dir_prefix).name

    best_exp_dir = None
    best_ood_f1 = 0
    for exp_dir in parent_dir.glob(f"{prefix}*"):
        try:
            ood_val_df = pd.read_csv(exp_dir / "val_eval.csv")
            ood_f1 = ood_val_df["acc_avg"].max()
            if best_exp_dir is None or ood_f1 > best_ood_f1:
                best_exp_dir = exp_dir
                best_ood_f1 = ood_f1
                print(f"New best exp dir: {best_exp_dir}, acc_avg-macro_all: {best_ood_f1}")
        except:
            print(f"Error in {exp_dir}")


    print("Best exp dir: ", best_exp_dir)
    print("Best acc_avg: ", best_ood_f1)
