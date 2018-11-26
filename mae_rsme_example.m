score1=score01;
[stu_num,course_num]=size(score1); 
num_srnd=round(stu_num/4);
num_crnd=round(course_num/4);
neighb_num=5;

for test=1:10
    score1=score01;
    perm1=randperm(stu_num);
    perm2=randperm(course_num);

    stu_rnd=perm1(1:num_srnd);% 
    course_rnd=perm2(1:num_crnd);% randomly choose as aim group 
    real_score=score1(stu_rnd,course_rnd);
    score_ex=score1;
    score1(:,course_rnd)=[];

    D1 = 1-pdist(score1,'cosine');
    z1=squareform(D1);
    D2 = 1-pdist(score1,'jaccard');
    z2=squareform(D2);
    D3 = 1-pdist(score1,'spearman');
    z3=squareform(D3);
    
    v1=z1(:,stu_rnd);
    [b1,j1]=sort(v1,'descend');
    idx1=j1(1:neighb_num,:);% the neighbours index
    sim_vec1=b1(1:neighb_num,:); %similarity of neighbours in descend order

    v2=z2(:,stu_rnd);
    [b2,j2]=sort(v2,'descend');
    idx2=j2(1:neighb_num,:);% the neighbours index
    sim_vec2=b2(1:neighb_num,:); %similarity of neighbours in descend order
    
    v3=z3(:,stu_rnd);
    [b3,j3]=sort(v3,'descend');
    idx3=j3(1:neighb_num,:);% the neighbours index
    sim_vec3=b3(1:neighb_num,:); %similarity of neighbours in descend order
    for i=1:num_srnd
        for j=1:num_crnd
            neighbour_score1=score_ex(idx1(:,i),course_rnd(j));
            pd_score1(i,j)=(sim_vec1(:,i)'*neighbour_score1)/sum(sim_vec1(:,i));     
            neighbour_score2=score_ex(idx2(:,i),course_rnd(j));
            pd_score2(i,j)=(sim_vec2(:,i)'*neighbour_score2)/sum(sim_vec2(:,i));  
            neighbour_score3=score_ex(idx3(:,i),course_rnd(j));
            pd_score3(i,j)=(sim_vec3(:,i)'*neighbour_score3)/sum(sim_vec3(:,i));  
        end
    end

    mae1(test)=mean(sum(abs(pd_score1-real_score),2)/course_num);
    rmse1(test)=mean(sqrt(sum((pd_score1-real_score).^2,2))/course_num);
    mae2(test)=mean(sum(abs(pd_score2-real_score),2)/course_num);
    rmse2(test)=mean(sqrt(sum((pd_score2-real_score).^2,2))/course_num);
    mae3(test)=mean(sum(abs(pd_score3-real_score),2)/course_num);
    rmse3(test)=mean(sqrt(sum((pd_score3-real_score).^2,2))/course_num);
end


% [pd_score1,real_score1,mae1,~]=compute_sim(score,score_ex1,stu_rnd,course_rnd,neighb_num,course_num,'cosine');