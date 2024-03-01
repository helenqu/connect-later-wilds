source env_setup.sh

LOGDIR=$1

mkdir -p $LOGDIR
LP_LR=0.0018804142350329204
FT_LR=0.0002504172429234668
TRANSFORM_P=0.5473471004493135

for SEED in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15;
do
    sbatch ${cluster_info} -N 1 -c 32 --gpus=1 -t 12:00:00 --output=${LOGDIR}/seed_${SEED}.out run_iwildcam.sh ${SEED} ${LP_LR} ${FT_LR} ${TRANSFORM_P}
    echo "run_exp.sh ${SEED} ${LP_LR} ${FT_LR} ${TRANSFORM_P}"
done
