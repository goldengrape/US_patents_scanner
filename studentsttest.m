%students t test
mdata=xlsread('patentdata.xls');
dotrans=find(mdata(:,11)>=2);
notrans=find(mdata(:,11)<1);
dotrans_page=mdata(dotrans,2);
notrans_page=mdata(notrans,2);
[h_page,p_page]=ttest2(log(dotrans_page),log(notrans_page))