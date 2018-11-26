dataset1=table2array(course1481scoreesecondS1);
[row,col]=size(dataset1);
stu_num=length(unique(dataset1(:,1)));
course_num=length(unique(dataset1(:,2)));
result=-1.*ones(stu_num,course_num);
for i=1:row
    stu_id=dataset1(i,1);
    course_id=dataset1(i,2);
    score=dataset1(i,3);
    result(stu_id,course_id)=score;    

end

% mean_score=mean(result_re');
% for i=1:stu_num
%     for j=1:course_num
%         if result_re(i,j)>=mean_score(i)
%             correct(i,j)=j;
%         else
%             result_re(i,j)=0;
%         end
%     end
% end