% Compute the Cosine distance between every pair of tf-idf in each document
% MarkingId 3084
all_file_name_list={'RedRidingHood.txt','PrincessPea.txt','Cinderella.txt','CAFA1.txt','CAFA2.txt','CAFA3.txt'};
all_files_content={};
file_data_= zeros(1,10);
each_file_name={'red','prince','cind','caf1','caf2','caf3'};
%Read file content
for each_file=1:length(all_file_name_list)
    opened_file = fopen(char(all_file_name_list(each_file)), 'rt');
    file_data= fgetl(opened_file);
    file_data(file_data== ':')=[];
    file_data(file_data=='-')=[];
    fclose(opened_file);
    lowered_data= lower(regexpi(file_data,' ','split'));
    all_files_content=[all_files_content,lowered_data];
    seperate_contents.(each_file_name{each_file})=lowered_data;
end
%Identify unique and sort it 
list_of_all_words=struct();
all_files_content= sort(all_files_content);
all_files_content(1:6)=[];
sorted_uniq_vect= sort(unique(all_files_content));
uniq_vect= strtrim(sorted_uniq_vect);
for i=1:length(uniq_vect)
    is_char=str2double(uniq_vect(i));
    if isnan(is_char)
        list_of_all_words.(char(uniq_vect(i)))=0;
    end
end

% Count words in struct and increment as it appears
incre=1;
seperate_counter_of_words=struct();
for each=each_file_name
    each_sperate_content=seperate_contents.(each{1});
    seperate_counter_of_words.(each_file_name{incre})=list_of_all_words;
    for i=1:length(each_sperate_content)
        if isfield(list_of_all_words,each_sperate_content(i)) == 1
            seperate_counter_of_words.(each_file_name{incre}).(char(each_sperate_content(i)))=seperate_counter_of_words.(each_file_name{incre}).(char(each_sperate_content(i)))+1;   
        end
    end
    incre=incre+1;  
end

% transform the data to double
count=1;
for docs=each_file_name
    words=fieldnames(seperate_counter_of_words.(each_file_name{count}));
    content_count=[];
    for i =1:length(words)
        w=char(words(i));
        seperate_content_file=seperate_counter_of_words.(each_file_name{count});
        content_count=[content_count,seperate_content_file.(w)];
    end
    all_double.(each_file_name{count})=content_count';
    count=count+1;
end
% Compute the term and id frequency
concat_matrix=[all_double.red,all_double.prince,all_double.cind,all_double.caf1,all_double.caf2,all_double.caf3];
term_freq= compute_ttf(concat_matrix);
inv_freq = compute_idff(concat_matrix);
term_and_id_freq= term_freq.*inv_freq ;

distance_betwen= [term_and_id_freq(:,1)';term_and_id_freq(:,2)';term_and_id_freq(:,3)';term_and_id_freq(:,4)';term_and_id_freq(:,5)';term_and_id_freq(:,6)'];
DPDIST=pdist2(distance_betwen,distance_betwen,'cosine');
clims = [0 1];
imagesc(DPDIST,clims)
title('Cosine Distance')
set(gca, 'xticklabel', {'RRH','PPea','Cinde', 'CAFA1', 'CAFA2', 'CAFA3'});
set(gca, 'yticklabel', {'RRH','PPea','Cinde', 'CAFA1', 'CAFA2', 'CAFA3'});
colormap(gray) 
colorbar