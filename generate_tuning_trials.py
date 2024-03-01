import numpy as np
np.random.seed(111)

lp_lrs = []
ft_lrs = []
transform_ps = []
# augmentations
for i in range(10):
    lp_lr_exponent = np.random.uniform(-3, -2)
    ft_lr_exponent = np.random.uniform(-5, -2)
    transform_p = np.random.uniform(0.5, 0.9)

    lp_lr = 10 ** lp_lr_exponent
    ft_lr = 10 ** ft_lr_exponent

    lp_lrs.append(lp_lr)
    ft_lrs.append(ft_lr)
    transform_ps.append(transform_p)

print("With augmentations")
print("lp_lrs", ' '.join([str(lp_lr) for lp_lr in lp_lrs]))
print("ft_lrs", ' '.join([str(ft_lr) for ft_lr in ft_lrs]))
print("transform_ps", ' '.join([str(transform_p) for transform_p in transform_ps]))


lp_lrs = []
ft_lrs = []
# no augmentations
for i in range(10):
    lp_lr_exponent = np.random.uniform(-3, -2)
    ft_lr_exponent = np.random.uniform(-5, -2)
    lp_lr = 10 ** lp_lr_exponent
    ft_lr = 10 ** ft_lr_exponent

    lp_lrs.append(lp_lr)
    ft_lrs.append(ft_lr)

print("Without augmentations")
print("lp_lrs", ' '.join([str(lp_lr) for lp_lr in lp_lrs]))
