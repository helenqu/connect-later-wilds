import pandas as pd
import argparse
import numpy as np
from pathlib import Path


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--exp_dir_prefix", help="Prefix of the experiment directory")
    parser.add_argument("--colname", help="Prefix of the experiment directory")
    parser.add_argument("--tuning_dir", help="Prefix of the experiment directory")
    # parser.add_argument("seeds", help="comma separated list of seeds")
    # parser.add_argument("exp_dir_suffix", help="Suffix of the experiment directory")
    args = parser.parse_args()
    exp_dir_prefix = Path(args.exp_dir_prefix)

    ood_test = []
    id_test = []
    best_epochs = []
    exp_dirs = list(Path(exp_dir_prefix.parent).glob(f"{exp_dir_prefix.name}*"))
    if args.tuning_dir:
        exp_dirs.append(Path(args.tuning_dir)) # tuning run counts as a seed
    for exp_dir in exp_dirs:
        print(f"reading {exp_dir}")
    # for seed in args.seeds.split(","):
    #     exp_dir = [d for d in Path('/pscratch/sd/h/helenqu/camelyon_seed_logs').glob(f"{args.exp_dir_prefix}_{seed}_{args.exp_dir_suffix}") if d.is_dir()][0]

        ood_val_df = pd.read_csv(str(exp_dir / "val_eval.csv"))
        # choose from last 5 epochs
        # ood_val_df.iloc[:-5] = 0
        best_epoch = ood_val_df[args.colname].idxmax()

        ood_test_df = pd.read_csv(str(exp_dir / "test_eval.csv"))
        id_test_df = pd.read_csv(str(exp_dir / "id_val_eval.csv")) # camelyon doesnt seem to have an ID test split

        ood_test.append(ood_test_df[args.colname].iloc[best_epoch])
        id_test.append(id_test_df[args.colname].iloc[best_epoch])
        best_epochs.append(best_epoch)

    # average over seeds
    print(f"Experiment: {args.exp_dir_prefix}")
    print(f"Avg OOD test: {sum(ood_test)/len(ood_test)}", "Std OOD test:", np.std(ood_test))
    print(f"Avg ID test: {sum(id_test)/len(id_test)}", "Std ID test:", np.std(id_test))
    print(f"Avg Best epoch: {sum(best_epochs)/len(best_epochs)}", "Std Best epoch:", np.std(best_epochs))

    print("All results:")
    print("OOD test:", ood_test)
    print("ID test:", id_test)
    print("Best epoch:", best_epochs)
