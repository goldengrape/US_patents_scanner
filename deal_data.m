%data 
clear all
mdata=xlsread('patentdata.xls');
ydata=xlsread('buzhidao.xlsx');
amount=ydata(2:31,2)-ydata(1:30,2);
log_amount=log(amount);

for year=1983:2012
    i=year-1982;
    lower=ydata(year-1982,2);
    upper=ydata(year-1981,2);
    id_lower=mdata(:,1)>lower;
    id_upper=mdata(:,1)<=upper;
    id=id_lower.*id_upper;
    data=mdata(find(id>=1),:);
    addyear(find(id>=1))=year;
    page=data(:,2);
    page_sec1=data(:,3)-1;
    page_sec2=data(:,4)-data(:,3);
    page_sec3=data(:,5)-data(:,4);
    page_sec4=data(:,2)-data(:,5);
    claim=data(:,6);
    reference=data(:,7);
    days=abs(data(:,10)-data(:,9));
    assignment=data(:,11);
    
    
    
    log_page=log(data(:,2));
    
    log_page_mean(i)=mean(log_page);
    log_page_std(i)=std(log_page);
    
    log_page_sec1_mean(i)=mean(log(page_sec1));
    log_page_sec2_mean(i)=mean(log(page_sec2));
    log_page_sec3_mean(i)=mean(log(page_sec3));
    log_page_sec4_mean(i)=mean(log(page_sec4));
    
    log_page_sec1_std(i)=std(log(page_sec1));
    log_page_sec2_std(i)=std(log(page_sec1));
    log_page_sec3_std(i)=std(log(page_sec1));
    log_page_sec4_std(i)=std(log(page_sec1));
    
    log_claim_mean(i)=mean(log(claim));
    log_claim_std(i)=std(log(claim));
    
    ref_mean(i)=mean(reference);

    log_days=log(days);
    log_days_mean(i)=mean(log_days);
    log_days_std(i)=std(log_days);
     
    assign_mean(i)=mean(assignment);
    amount_assign_persent(i)=sum(assignment>=2)/length(assignment);
end
%year
writedata(:,1)=1983:2012;
%amount of patents
writedata(:,2)=log_amount;

%log_page
writedata(:,3)=log_page_mean;
writedata(:,4)=log_page_std;

%log_claim
writedata(:,5)=log_claim_mean;
writedata(:,6)=log_claim_std;

%ref
writedata(:,7)=ref_mean;

%log_days
writedata(:,8)=log_days_mean;
writedata(:,9)=log_days_std;

%amount_assign_persent
writedata(:,10)=amount_assign_persent;

xlswrite('yearbook.xls',writedata);

