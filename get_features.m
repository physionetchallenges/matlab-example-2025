function features=get_features(file,header)

signals=read_challenge_signals(file,header);

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

function signals=scale_signals(signals,header)

header=strsplit(header,'\n');

for j=1:size(signals,2)

    header_tmp=header{1+j};
    header_tmp=strsplit(header_tmp,' ');
    header_tmp=header_tmp{contains(header_tmp,'/mV')};

    baseline=extractBetween(header_tmp,'(',')');
    baseline=str2num(baseline{1});

    gain=extractBefore(header_tmp,'(');
    gain=str2num(gain);

    signals(:,j)=(signals(:,j)-baseline)/gain;


end