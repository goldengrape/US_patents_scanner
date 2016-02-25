a01=xlsread('amout_claim_01.xls');
a02=xlsread('amout_claim_02.xls');
a03=xlsread('amout_claim_03.xls');
a04=xlsread('amout_claim_04.xls');
a05=xlsread('amout_claim_05.xls');
a06=xlsread('amout_claim_06.xls');
a07=xlsread('amout_claim_07.xls');
a08=xlsread('amout_claim_08.xls');
a09=xlsread('amout_claim_09.xls');
a10=xlsread('amout_claim_10.xls');
a11=xlsread('amout_claim_11.xls');
a12=xlsread('amout_claim_12.xls');

claim=a01.*(a01>-1)+a02.*(a02>-1)+a03.*(a03>-1)+a04.*(a04>-1)+a05.*(a05>-1)+a06.*(a06>-1)+a07.*(a07>-1)+a08.*(a08>-1)+a09.*(a09>-1)+a10.*(a10>-1)+a11.*(a11>-1)+a12.*(a12>-1);