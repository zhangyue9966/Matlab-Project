score1=score01;
[stu_num,course_num]=size(score1);
stu_rnd=round(rand(1)*stu_num);
course_rnd=round(rand(1)*course_num);% randomly choose as aim group 
real_score=score(stu_rnd,course_rnd);
pd_score1=zeros(stu_num,course_num);
score_orig=score1;
score1(:,course_rnd)=[];

count=1;
for neighb_num=2:20  
    D1 = 1-pdist(score1,'cosine');
    z1=squareform(D1);
    v1=z1(:,stu_rnd);
    [b1,j1]=sort(v1,'descend');
    idx=j1(1:neighb_num);% the neighbours index
    sim_vec=b1(1:neighb_num); %similarity of neighbours in descend order
    
    neighbour_score=score_orig(idx,course_rnd);
    pd_score1=(sim_vec'*neighbour_score)/sum(sim_vec);    
    mae1(count)=abs(pd_score1-real_score);
    rmse1(count)=sqrt(sum((pd_score1-real_score).^2));
    count=count+1;
end

plot(2:20,mae1,'r-*');
% hold on
% plot(2:20,,'m-*');
% hold on 
% plot(2:20,mae3,'g-*');
% legend('cosine','jaccard','spearman')

