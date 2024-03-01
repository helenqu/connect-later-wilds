#!/bin/bash

SEED=$1
LP_LR=$2
FT_LR=$3
TRANSFORM_P=$4
AUG_STRENGTH=$5
PRETRAIN_PATH=$6

# load the environment
source env_setup.sh

DATA_DIR=$7
LOGDIR=$8

mkdir -p $LOGDIR

# LP
python examples/run_expt.py --root_dir ${DATA_DIR} \
    --lr ${LP_LR} \
    --n_epochs 10 \
    --weight_decay 0.01 \
    --transform_p ${TRANSFORM_P} \
    --train_additional_transforms camelyon_color \
    --transform_kwargs sigma=${AUG_STRENGTH} \
    --algorithm ERM \
    --dataset camelyon17 \
    --download \
    --pretrained_model_path ${PRETRAIN_PATH} \
    --seed ${SEED} \
    --log_dir ${LOGDIR}/LP_camelyon_pretrain_aug_${SEED}_lplr${LP_LR}_ftlr${FT_LR}_p${TRANSFORM_P}_augstrength${AUG_STRENGTH} \
    --progress_bar True \
    --erm_freeze_featurizer

# FT
python examples/run_expt.py --root_dir ${DATA_DIR} \
    --lr ${FT_LR} \
    --weight_decay 0.01 \
    --transform_p ${TRANSFORM_P} \
    --train_additional_transforms camelyon_color \
    --transform_kwargs sigma=${AUG_STRENGTH} \
    --algorithm ERM \
    --dataset camelyon17 \
    --download \
    --pretrained_model_path ${LOGDIR}/LP_camelyon_pretrain_aug_${SEED}_lplr${LP_LR}_ftlr${FT_LR}_p${TRANSFORM_P}_augstrength${AUG_STRENGTH}/camelyon17_seed:${SEED}_epoch:best_model.pth \
    --seed ${SEED} \
    --log_dir ${LOGDIR}/FT_camelyon_pretrain_aug_LPFT_${SEED}_lplr${LP_LR}_ftlr${FT_LR}_p${TRANSFORM_P}_augstrength${AUG_STRENGTH} \
    --progress_bar True \
