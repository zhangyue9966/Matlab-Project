function [z1,z2,z3] = mae_calculator(score)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[stu_num,course_num]=size(score); 
num_srnd=round(stu_num/4);
num_crnd=round(course_num/4);

perm1=randperm(stu_num);
perm2=randperm(course_num);

stu_rnd=perm1(1:num_srnd);% 
course_rnd=perm2(1:num_crnd);% randomly choose as aim group 
score_ex=score;
score_ex(:,course_rnd)=[];

i=1;
for neighb_num=2:20 %normal dataset
    [pd_score1,real_score1,mae1,~]=compute_sim(score,score_ex,stu_rnd,course_rnd,neighb_num,course_num,'cosine');
    z1(i,:)=mae1;
    zz1(i)=rmse1;
    [pd_score2,real_score2,mae2,~]=compute_sim(score,score_ex,stu_rnd,course_rnd,neighb_num,course_num,'jaccard');
    z2(i,:)=mae2;
    zz2(i)=rmse2;
    [pd_score3,real_score3,mae3,~]=compute_sim(score,score_ex,stu_rnd,course_rnd,neighb_num,course_num,'spearman');
    z3(i,:)=mae3;
    zz3(i)=rmse3;
    i=i+1;
end
end

