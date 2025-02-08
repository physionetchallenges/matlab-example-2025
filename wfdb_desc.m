function sigInfo = wfdb_desc(headname)

sigInfo = struct;

fid = fopen([headname '.hea']);
str = fgets(fid);
cc = textscan(str,'%s');
cc = cc{1};

var_name = {'RecordName','channels','SamplingFrequency','LengthSamples','time', 'date'};
var_type = {'s','d','d','d','s','s'};
n=0;
for i=1:length(cc)
    if i<=length(var_name)
        com = sprintf('%s = "%s";', var_name{i}, cc{i});
        eval(com);
        n=n+1;
    end
end

item_name = {'File','Format','Gains','AdcResolution','AdcZero','InitialValue','CheckSum','BlockSize','Description'};
item_type = {'s','s','s','d','d','d','d','d','s'};
n_files=0;
n_item=0;
str = fgets(fid);
while ischar(str) & ~startsWith(str, '#') 

    cc2 = textscan(str,'%s');
    cc2 = cc2{1};
    n_files=n_files+1;
    for i=1:n
        com = sprintf('sigInfo(%d).%s = "%s";',n_files, var_name{i}, cc{i});
        eval(com);
        if var_type{i} == 'd'
            com = sprintf(['sigInfo(%d).%s = str2num(sigInfo(%d).%s);'],n_files,var_name{i},n_files,var_name{i});
            eval(com);
        end
    end
    if n>=6
        sigInfo(n_files).StartTime=strjoin(['[', sigInfo(n_files).time, ' ', sigInfo(n_files).date, ']']);
    else
        sigInfo(n_files).StartTime="";
    end
    for i=1:length(cc2)
        if i<=length(item_name)
            com = sprintf(['sigInfo(%d).%s = "%s";'],n_files,item_name{i},cc2{i});
            eval(com);
            if item_type{i} == 'd'
                com = sprintf(['sigInfo(%d).%s = str2num(sigInfo(%d).%s);'],n_files,item_name{i},n_files,item_name{i});
                eval(com);
            end
            n_item = n_item + 1;
        end
    end
        
    numStr = regexp(sigInfo(n_files).Gains, '[+-]?\d+(\.\d+)?', 'match');

    sigInfo(n_files).Gain=str2num(numStr{1});
    sigInfo(n_files).Baseline=str2num(numStr{2});

    k=strfind(sigInfo(n_files).Gains, '/');
    sigInfo(n_files).Units=sigInfo(n_files).Gains{1}(k+1:end);

    str = fgets(fid);
end
fclose(fid);
end
