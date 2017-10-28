desdir=renet_noresize
log=train.log

python plot_training_log.py.example 0 $desdir/test_iter_accu.png $desdir/$log
python plot_training_log.py.example 2 $desdir/test_iter_loss.png $desdir/$log
python plot_training_log.py.example 4 $desdir/train_iter_lr.png $desdir/$log
python plot_training_log.py.example 6 $desdir/train_iter_loss.png $desdir/$log

