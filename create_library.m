%% Create Tex File
clc;
close all;
clearvars;

fid     = fopen('PianoLibrary.tex','w');

%% Add generic structure
fprintf(fid, ['\\documentclass{article}' '\n']);
fprintf(fid, ['\\usepackage[utf8]{inputenc}' '\n']);
fprintf(fid, ['\\usepackage{pdfpages}' '\n']);
fprintf(fid, ['\\usepackage{hyperref}' '\n']);
fprintf(fid, ['\\title{Compilation of Piano Music}' '\n']);
fprintf(fid, ['\\author{Andrew Fisher}' '\n']);
fprintf(fid, ['\\begin{document}' '\n']);
fprintf(fid, ['\\maketitle' '\n']);
fprintf(fid, ['\\tableofcontents' '\n']);
fprintf(fid, ['\\clearpage' '\n']);

%% Loop over pdf files
% Read in pdf songfile names
songnames   = dir('PianoPDFs\*.pdf*');
for j=1:length(songnames)
    songtitle   = erase(songnames(j).name,'.pdf');
    fprintf(fid, ['\\phantomsection' '\n']);
    fprintf(fid, ['\\addcontentsline{toc}{section}{' songtitle '}' '\n']);
    fprintf(fid, ['\\includepdf[pages=-]{"PianoPDFs/' songtitle '"}' '\n']);
end

fprintf(fid, ['\\end{document}' '\n']);


%% Compile tex file into PDF music library
system('pdflatex -quiet PianoLibrary.tex');
fprintf('Compiled once\n');
system('pdflatex -quiet PianoLibrary.tex'); %compiling twice to ensure TOC exists
fprintf('Compiled twice\n');
fclose('all');

%% Send PDF to Test Email
send_email('Piano PDF','A searchable compilation of all piano pdfs','PianoLibrary.pdf')