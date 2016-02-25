clear all;
max=8341762;
min=4366579;
d=max-min;
max=floor(min+0.8*d);
min=floor(min+0.6*d);
num=500;
patentID=-ones(num,1);
page_num=-ones(num,4);
claims_number=-ones(num,1);
ref_number=-ones(num,1);
filed_date=-ones(num,1);
appl_date=-ones(num,1);
length_Description=-ones(num,1);

patentID=floor(rand(num,1,'double')*(max-min))+min;
%patentID=min+1
%patentID=5652351
%patentID=5890258
url_p1='http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO1&Sect2=HITOFF&d=PALL&p=1&u=%2Fnetahtml%2FPTO%2Fsrchnum.htm&r=1&f=G&l=50&s1=';
url_p2='.PN.&OS=PN/';
url_p3='&RS=PN/';
url_img_p1='http://patimg1.uspto.gov/.piw?Docid=';
url_img_p2='&SectionNum=';
url_img_p3='&IDKey=&HomeUrl=http://pimg-piw.uspto.gov/';

for i=1:num
    i
    patentIDurl=num2str(patentID(i));
    turl=[url_p1,patentIDurl,url_p2,patentIDurl,url_p3,patentIDurl];
    txturl=turl;
  
    
    %% read page numbers
    % page_num(i,1)=total page number
    % page_num(i,2)=Drawings start page number
    % page_num(i,3)=Specifications start page number
    % page_num(i,4)=Claims start page number
    for section=2:4
        imgurl=[url_img_p1,patentIDurl,url_img_p2,num2str(section),url_img_p3];
        imgs=urlread(imgurl);
        
        idx_start=strfind(imgs,'Section:');
                if isempty(idx_start);continue;end
        
        %find page_num
        idx_end=strfind(imgs,'pages</b></font>');
                if isempty(idx_end);continue;end
        content=imgs(idx_start:idx_end-1);
        idx_start=strfind(content,'<b>')+3;
        idx_end=strfind(content,'of')-1;
                if isempty(idx_end);continue;end
        page_num(i,section)=str2num(content(idx_start:idx_end));
        
    end
        if isempty(idx_start);continue;end
    page_num(i,1)=str2num(content(idx_end+3:length(content)));
    
    %% read dates
    % filed_date
    % appl_date
    txts=urlread(txturl);
    idx_start=strfind(txts,'WIDTH="10%">Filed:');
            if isempty(idx_start);continue;end
    idx_end=idx_start+110;
            if isempty(idx_end);continue;end
    content=txts(idx_start:idx_end);
    idx_start=strfind(content,'<B>');
            if isempty(idx_start);continue;end
    idx_end=strfind(content,'</B>');
            if isempty(idx_end);continue;end
    filed_date(i)=datenum(content(idx_start+3:idx_end-1));
    
    HR_idx=strfind(txts,'<HR>');
    content=txts(HR_idx(1):HR_idx(2));
    temp_idx=strfind(content,'<TD ALIGN="RIGHT" WIDTH="50%">');
    idx_start=temp_idx(2);
    idx_end=idx_start+70;
    content=content(idx_start:idx_end);
    idx_end=strfind(content,'</B>');
    content=content(36:idx_end-2);
    appl_date(i)=datenum(content);
    
    %% read claims number
    %claims_number(i)
    idx_start=strfind(txts,'<CENTER><B><I>Claims</B></I></CENTER>');
    idx_end=strfind(txts,'Description</B></I></CENTER>');
    claimstxt=txts(idx_start:idx_end);
    idx_brbr=strfind(claimstxt,'<BR><BR>');
    claims_number(i)=length(idx_brbr)-1;
    
    %% read ref-BY number
    %ref_number
    refurl=['http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=%2Fnetahtml%2Fsearch-adv.htm&r=0&f=S&l=50&d=PALL&Query=ref/',patentIDurl];
    reftxts=urlread(refurl);
    idx_start=strfind(reftxts,'Results of Search in US Patent Collection db for:');
    if isempty(idx_start)
        r_number=1;
        %hit one paper
    else
        idx_end=idx_start+150;
        content=reftxts(idx_start:idx_end);
        idx_start=strfind(content,'</B>: ');
        idx_end=strfind(content,'patents.');
        r_number=str2num(content(idx_start+5:idx_end-1));
    end
    ref_number(i)=r_number;
    
    %% read Description
    idx_start=strfind(txts,'Description</B>');
    idx_end=strfind(txts,'* * * * *');
    Descriptiontxt=txts(idx_start:idx_end);
    Descriptiontxt=strrep(Descriptiontxt,'<BR>','');
    Descriptiontxt=strrep(Descriptiontxt,'<B>','');
    length_Description(i)=length(Descriptiontxt);
end


data(:,1)=patentID;
data(:,2)=page_num(:,1);
data(:,3)=page_num(:,2);
data(:,4)=page_num(:,3);
data(:,5)=page_num(:,4);
data(:,6)=claims_number;
data(:,7)=ref_number;
data(:,8)=length_Description;
data(:,9)=filed_date;
data(:,10)=appl_date;
xlswrite('patentdata1983to2013_4_5.xls',data);
