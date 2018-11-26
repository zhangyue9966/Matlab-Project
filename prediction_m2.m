score1=course1481transed;
[stu_num,course_num]=size(score1); 
num_srnd=round(stu_num/4);
num_crnd=round(course_num/4);
neighb_num=16;
count=1;

score1=score01;
perm1=randperm(stu_num);
perm2=randperm(course_num);

stu_rnd=perm1(1:num_srnd);%
course_rnd=perm2(1:num_crnd);% randomly choose as aim group

score_ex=score1;
score1(:,course_rnd)=[];

D1 = 1-pdist(score1,'cosine');
z1=squareform(D1);

v1=z1(:,stu_rnd);
[b1,j1]=sort(v1,'descend');
idx1=j1(1:neighb_num,:);% the neighbours index
sim_vec1=b1(1:neighb_num,:); %similarity of neighbours in descend order

for i=1:stu_num
    for j=1:course_num
        neighbour_score1=score_ex(idx1(:,i),course_rnd(j));
        pd_score1(i,j)=(sim_vec1(:,i)'*neighbour_score1)/sum(sim_vec1(:,i));
    end
end

mae1(count)=mean(sum(abs(pd_score1-real_score),2)/course_num);
rmse1(count)=mean(sqrt(sum((pd_score1-real_score).^2,2))/course_num);
count=count+1;

