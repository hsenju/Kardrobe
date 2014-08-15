#!/bin/sh
GETAROOT=/data/lib/geta
HANDLE=clothes
ITB=/home/ec2-user/clothes/ralphoutfile.txt

/data/lib/geta/wbin/stp -b $GETAROOT $HANDLE title,price,link,imglink < $ITB

HANDLE2=woman
ITB2=/home/ec2-user/clothes/ralphoutfilew.txt

/data/lib/geta/wbin/stp -b $GETAROOT $HANDLE2 title,price,link,imglink < $ITB2

HANDLE=lacoste
ITB=/home/ec2-user/clothes/outfiledefault2.txt

/data/lib/geta/wbin/stp -b $GETAROOT $HANDLE title,price,link,imglink,brand,@fss < $ITB

HANDLE=woman2
ITB=/home/ec2-user/clothes/outfiledefaultwoman.txt

/data/lib/geta/wbin/stp -b $GETAROOT $HANDLE title,price,link,imglink,brand,@fss < $ITB