function [ rmmd_chapter,idx ] = recommendation_correct( data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
score1=data;
[stu_num,course_num]=size(score1);
[stu_rnd,course_rnd]=find(score1==-1);
num_srnd=length(stu_rnd);
% num_crnd=length(stu_rnd);
alpha=mean(score1,2);%求出每个学生的平均成绩
pd_score=zeros(stu_num,course_num);
rmmd_chapter=zeros(stu_num,course_num);
neighb_num=16;

score_orig=score1;
score1(:,course_rnd)=[];

D1 = 1-pdist(score1,'cosine');
z1=squareform(D1);

v1=z1(:,stu_rnd);
[b1,j1]=sort(v1,'descend');
idx=j1(1:neighb_num,:);% the neighbours index
sim_vec=b1(1:neighb_num,:); %similarity of neighbours in descend order


for i=1:num_srnd
    neighbour_score=score_orig(idx(:,i),course_rnd(i));
    pd_score(stu_rnd(i),course_rnd(i))=(sim_vec(:,i)'*neighbour_score)/sum(sim_vec(:,i));
    if pd_score(stu_rnd(i),course_rnd(i))>=alpha(i)
        rmmd_chapter(idx(:,i),course_rnd(i))=1;
    end
end

end