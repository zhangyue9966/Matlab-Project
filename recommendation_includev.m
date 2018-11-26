function [ rmmd_chapter,idx1,idx2,pd_score,pd_score_persecond] = recommendation_includev (s,v)
%Summary of this function goes here
%s-score matrix v-velocity matrix
score1=s;
score2=v;
[stu_num,course_num]=size(score1);
[stu_rnd,course_rnd]=find(score1==-1);
num_srnd=length(stu_rnd);
% num_crnd=length(stu_rnd);
alpha1=mean(score1,2);%求出每个学生的平均成绩
alpha2=0.6;
pd_score=zeros(stu_num,course_num);
pd_score_persecond=zeros(stu_num,course_num);
rmmd_chapter=zeros(stu_num,course_num);
neighb_num=16;

score_orig=score1;
score1(:,course_rnd)=[];
score2_orig=score2;
score2(:,course_rnd)=[];

D1 = 1-pdist(score1,'cosine');
z1=squareform(D1);
v1=z1(:,stu_rnd);
[b1,j1]=sort(v1,'descend');
idx1=j1(1:neighb_num,:);% the neighbours index
sim_vec1=b1(1:neighb_num,:); %similarity of neighbours in descend order

D2 = 1-pdist(score2,'cosine');
z2=squareform(D2);
v2=z2(:,stu_rnd);
[b2,j2]=sort(v2,'descend');
idx2=j2(1:neighb_num,:);% the neighbours index
sim_vec2=b2(1:neighb_num,:); %similarity of neighbours in descend order

for i=1:num_srnd
    neighbour_score1=score_orig(idx1(:,i),course_rnd(i));
    neighbour_score2=score2_orig(idx2(:,i),course_rnd(i));
    pd_score(stu_rnd(i),course_rnd(i))=(sim_vec1(:,i)'*neighbour_score1)/sum(sim_vec1(:,i));
    pd_score_persecond(stu_rnd(i),course_rnd(i))=(sim_vec2(:,i)'*neighbour_score2)/sum(sim_vec2(:,i));
    if pd_score(stu_rnd(i),course_rnd(i))<=alpha1(i)
        if  pd_score_persecond(stu_rnd(i),course_rnd(i))<alpha2
            rmmd_chapter(stu_rnd(i),course_rnd(i))=1;
        end        
    end
end

end