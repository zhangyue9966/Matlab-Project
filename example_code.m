[stu_num,course_num]=size(example1); 
num_srnd=round(stu_num/3);
num_crnd=round(course_num/3);
neighb_num=3;
perm1=randperm(stu_num);
perm2=randperm(course_num);

stu_rnd=perm1(1:num_srnd);% 
course_rnd=perm2(1:num_crnd);% randomly choose as aim group 
score_ex1=example1;
score_ex1(:,course_rnd)=[];


D1 = 1-pdist(example1,'cosine');
z1=squareform(D1);
D2 = 1-pdist(example1,'jaccard');
z2=squareform(D2);
D3 = 1-pdist(example1,'spearman');
z3=squareform(D3);
% v1=z1(:,stu_rnd);
% [b1,j1]=sort(v1,'descend');
% idx1=j1(1:neighb_num);
% 
% sim_vec=b1(1:neighb_num);
% % rv_mean=mean(score_ex(idx1,:));
% rvj=score(idx1,course_rnd);
% pd_score=(sim_vec*rvj)/sum(sim_vec);
% real_score=score(stu_rnd,course_rnd);
% 
% mae=abs(pd_score-real_score)/course_num;
% rmse=sqrt(sum((pd_score-real_score).^2)/course_num);
% 
% [pd_score1,real_score1,mae1,~]=compute_sim(score,score_ex1,stu_rnd,course_rnd,neighb_num,course_num,'cosine');