%% ISAE/SUPAERO document class for exams
%% C. Garion, 2012
%%
%% Mostly taken from article.cls and "Rolling your own Document Class:
%% Using LaTeX to keep away from the Dark Side" by Peter Flynn
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{supaero-exam}[2012/01/30 v0.1 
               LaTeX document class for SUPAERO exams]

% This class extends the article class
% Read all the documentclass options; pass them to article,
% unless the file "<currentoption>.sup" exists, then it is loaded
\DeclareOption*{\InputIfFileExists{\CurrentOption.sup}{}{%
    \PassOptionsToClass{\CurrentOption}{exam}}}
\ExecuteOptions{a4paper,11pt}
\ProcessOptions \relax
\RequirePackage{atbegshi}
\LoadClass{exam}

\newenvironment{nonsolution}%[1][0pt]%
  {%
    \ifprintanswers
      \setbox\z@\vbox\bgroup
    \else
      \begingroup
    \fi
  }{%
    \ifprintanswers
      \egroup
    \else
      \endgroup
    \fi
  }%

% default font
\renewcommand\familydefault{cmss}

% no indentation
\setlength{\parindent}{0in}
