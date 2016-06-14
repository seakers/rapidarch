function score = analyze_student_seq(str,params)
% score = analyze_student_seq(str,params)
% Example of usage:
% params.CONNECTIVITIES = zeros(9,9);% instead of zeros this
% You can do this by typing load inclass4_matrix.mat
% str = {'PA' 'OR' 'CO' 'AD' 'AV' 'PO' 'ST' 'PR' 'TH'} % this your sequence
% score = analyze_student_seq(str,params)
% Daniel Selva <ds925@cornell.edu>
%
    seq = str2seq(str,params);
    score = fitness_function_dsmseq2(seq,params);
    fprintf('score = %d\n',score);
    graph_matrix2(reorder_dsm(params.CONNECTIVITIES,seq),'','','Student DSM', params.LABELS(seq), params.LABELS(seq), 0);
end