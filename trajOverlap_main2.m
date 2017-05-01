function [c_ij] = trajOverlap_main2(frame1,frame2,traj1,traj2)
%%% feature 2 -> time difference
time_diff = frame2-frame1; 
k = 4;

if(time_diff > k)
    c_ij = 10;
else
    iou = zeros(1,time_diff);
%     weights = [0,0,0,0,0,0.5, 0.5, 0.5, 0.5, 0.5];  %% weights
%     hist = zeros(1,10);  %% 10 bin histogram

    %%% feature 1 -> IoU
    for i = 1:time_diff
        bbox1 = traj1(i,:);
        bbox2 = traj2(time_diff-i+1,:);
        iou(i) = bboxOverlap(bbox1,bbox2);  %%find IoU between detections
    end
    avg = -sum(iou(:))/time_diff;
    a_ij = 1/(1+exp(avg));  %% sigmoid funct 
    c_ij = -log(a_ij);
end
end