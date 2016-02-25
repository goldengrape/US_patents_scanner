%assignment
clear all
mdata=xlsread('merge_data.xlsx');
url_part='http://assignments.uspto.gov/assignments/q?db=pat&pat=';
url=strcat(url_part,num2str(mdata(:,1)));
for i=5501:length(url)
    i
    txts=urlread(url(i,:));
    idx_start=strfind(txts,'Total Assignments:');
    if isempty(idx_start)
        assign(i)=0;
        continue
    end
    idx_end=idx_start+50;
    content=txts(idx_start:idx_end);
    idx_end=strfind(content,'</div>');
    assign(i)=str2num(content(25:idx_end-1));
end
xlswrite('assignment_12.xls',assign);
        