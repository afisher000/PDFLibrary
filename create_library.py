# -*- coding: utf-8 -*-
"""
Created on Fri Jun 24 17:39:30 2022

@author: afish
"""
import os
import subprocess
folder = 'PianoPDFs'

# Create TEX document
with open('library.tex','w') as f:
    preamble = ['\\documentclass{article}',
                '\\usepackage[utf8]{inputenc}',
                '\\usepackage{pdfpages}',
                '\\usepackage{hyperref}',
                '\\title{PDF Library}',
                '\\author{Andrew Fisher}',
                '\\begin{document}',
                '\\maketitle',
                '\\tableofcontents',
                '\\clearpage','']
    f.write('\n'.join(preamble))
    
    for file in os.listdir(folder):
        if file.endswith('.pdf'):
            table_element = ['\\phantomsection',
                             '\\addcontentsline{toc}{section}{%s}'%file,
                             '\\includepdf[pages=-]{"%s/%s"}'%(folder,file),'']
            f.write('\n'.join(table_element))
    
    f.write('\\end{document}\n')
print('Created library.tex')

# Compile TEX document
cmd = subprocess.run('pdflatex -quiet library.tex'.split(' '), stderr=subprocess.PIPE, encoding='UTF=8')
cmd = subprocess.run('pdflatex -quiet library.tex'.split(' '), stderr=subprocess.PIPE, encoding='UTF=8')

# Remove extra files
extensions = ['aux','log','out','tex','toc']
for extension in extensions:
    os.remove('library.'+extension)


