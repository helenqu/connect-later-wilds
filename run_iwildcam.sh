#!/bin/bash

SEED=$1
LP_LR=$2
FT_LR=$3
TRANSFORM_P=$4

# load the environment
source env_setup.sh

DATA_DIR=$5
LOGDIR=$6

mkdir -p $LOGDIR

SUFFIX=${7:-""}
PRETRAIN_PATH=${8:-swav_800ep_pretrain.pth.tar}

python examples/run_expt.py --root_dir ${DATA_DIR} --lr ${LP_LR} --n_epochs 10 --weight_decay 0 --transform_p ${TRANSFORM_P} --train_additional_transforms copypaste_same_y --algorithm ERM --dataset iwildcam --download --pretrained_model_path ${PRETRAIN_PATH} --seed ${SEED} --log_dir ${LOGDIR}/LP_iwildcam_pretrain${SUFFIX}_aug_${SEED}_lplr${LP_LR}_ftlr${FT_LR}_p${TRANSFORM_P} --erm_freeze_featurizer

# load the LP model and train again
python examples/run_expt.py --root_dir ${DATA_DIR} --lr ${FT_LR} --weight_decay 0 --transform_p ${TRANSFORM_P} --train_additional_transforms copypaste_same_y --algorithm ERM --dataset iwildcam --download --pretrained_model_path ${LOGDIR}/LP_iwildcam_pretrain${SUFFIX}_aug_${SEED}_lplr${LP_LR}_ftlr${FT_LR}_p${TRANSFORM_P}/iwildcam_seed:${SEED}_epoch:best_model.pth --seed ${SEED} --log_dir ${LOGDIR}/FT_iwildcam_pretrain${SUFFIX}_aug_${SEED}_lplr${LP_LR}_ftlr${FT_LR}_p${TRANSFORM_P}
