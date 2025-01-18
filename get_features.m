function features=get_features(file,header)

signals=rdsamp(file(1:end-4));

features(1)=nanmean(signals(:,2));
features(2)=nanstd(signals(:,2));
features(3)=get_age(header);
features(4)=get_sex(header);

function age=get_age(header)

header=strsplit(header,'\n');
age_tmp=header(startsWith(header,'# Age:'));
age_tmp=strsplit(age_tmp{1},':');
age=str2double(age_tmp{2});

function sex=get_sex(header)

header=strsplit(header,'\n');
sex_tmp=header(startsWith(header,'# Sex:'));
sex_tmp=strsplit(sex_tmp{1},':');
if startsWith(sex_tmp{2},'Fem')
    sex=0;
elseif startsWith(sex_tmp{2},'Mal')
    sex=1;
else
    sex=2;
end