%assignment
clear all
mdata=xlsread('merge_data.xls');
url_part='http://patft.uspto.gov/netacgi/nph-Parser?Sect2=PTO1&Sect2=HITOFF&p=1&u=/netahtml/PTO/search-bool.html&r=1&f=G&l=50&d=PALL&RefSrch=yes&Query=PN/';
url=strcat(url_part,num2str(mdata(:,1)));
amount_claim=-ones(length(mdata),1);
for i=1:500
    i
     txts=urlread(url(i,:));
     idx_start=strfind(txts,'Claims</B></I></CENTER>');
     idx_end=strfind(txts,'Description</B></I></CENTER>');
     claims=txts(idx_start:idx_end);
     a=regexp(claims,'<BR><BR>[0-9].');
     amount_claim(i)=length(a);
end
xlswrite('amout_claim_01.xls',amount_claim)