source env_setup.sh

LOGDIR=$1

mkdir -p $LOGDIR
LP_LR=0.006222466404167087
FT_LR=0.003324366874654924
TRANSFORM_P=0.8260829829811762
AUG_STRENGTH=0.0995477425665205

for SEED in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15;
do
    PRETRAIN_PATH=pretrained_camelyon.pth
    sbatch ${cluster_info} -N 1 -c 32 --gpus=1 -t 12:00:00 --output=${LOGDIR}/seed_${SEED}.out run_camelyon.sh ${SEED} ${LP_LR} ${FT_LR} ${TRANSFORM_P} ${AUG_STRENGTH} ${PRETRAIN_PATH}
done
