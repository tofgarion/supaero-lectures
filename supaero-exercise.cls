%% ISAE/SUPAERO document class for exercises
%% C. Garion, 2011
%%
%% Mostly taken from article.cls and "Rolling your own Document Class:
%% Using LaTeX to keep away from the Dark Side" by Peter Flynn
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{supaero-exercise}[2011/05/22 v0.1 
               LaTeX document class for SUPAERO exercises]


\def\GITAbrHash{}
\def\GITAuthorDate{}
\def\GITAuthorName{}

\def\module@internal{INXXX}
\newcommand{\module}[1]{\def\module@internal{#1}}

\def\public@internal{INXXX}
\newcommand{\public}[1]{\def\public@internal{#1}}

\global\let\@abstract\@empty
\newcommand{\setabstract}[1]{\def\@abstract{#1}}
\newcommand{\show@abstract}{\@abstract}

% This class extends the article class
% Read all the documentclass options; pass them to article,
% unless the file "<currentoption>.sup" exists, then it is loaded
\PassOptionsToClass{a4paper}{article}
\DeclareOption*{\InputIfFileExists{\CurrentOption.sup}{}{%
    \PassOptionsToClass{\CurrentOption}{exam}}}
\ProcessOptions \relax
\RequirePackage{atbegshi}
\RequirePackage{fancyhdr}
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

% page layout for pages other than first one, see header and footer
% conf. below
\RequirePackage[hscale=0.85, vscale=0.90, top=40pt, includeheadfoot]{geometry}

% babel for languages
\RequirePackage{babel}

% microtype for spacing
\RequirePackage[babel=true,kerning=true]{microtype}

% multirow for header
\RequirePackage{multirow}

% graphics
\RequirePackage[pdftex]{graphicx}

% title with shorttitle
\renewcommand\title{\@dblarg\mytitlecmd}
\long\def\mytitlecmd[#1]#2{%
  \def\mytitle{#2}%
  \def\shorttitle{#1}%
}

% header and footer
\RequirePackage{lastpage}

% textpos
\RequirePackage[absolute]{textpos}
\setlength{\TPHorizModule}{0.3\textwidth}
\setlength{\TPVertModule}{\TPHorizModule}
\textblockorigin{2em}{3em}

\firstpageheader{}{%
  \ifprintanswers
  \begin{textblock}{1}(1,0)
    \tikz \node[rounded corners, draw=red!80, ultra thick, rotate=30]% 
    {\Huge\bf \textcolor{red}{\texttt{Solution}}};
  \end{textblock}
  \fi
  \noindent\begin{tabular}[t]{| l l | c |}
    \hline
    & & \\[-1.5ex]
    \multicolumn{2}{| p{0.75\textwidth}|}{\huge \bf \module@internal
      : \mytitle} &
    \multirow{5}{*}{\includegraphics[width=0.2\textwidth]{VL_SUPAERO_72_cmjn.png}}\\[5pt]
    \large  & & \\
    \cline{1-2}
    & & \\[-1.5ex]
    \large Auteur  & \large : \@author & \\
    \large Public & \large : \public@internal & \\
    \large Date & \large : \@date & \\
    \hline
  \end{tabular}    
}{}%

\firstpagefooter{%
  \tt Revision~\GITAbrHash, \GITAuthorDate, \GITAuthorName.}%
  {}%
  {\thepage/\pageref{LastPage}}%

\runningheader{\module@internal}{\shorttitle \ifprintanswers { }- solution\fi}{\public@internal}%
\runningfooter{}{}{\thepage/\pageref{LastPage}}

\runningheadrule{}
\footrule{}

\extraheadheight[70pt]{0pt}

\pagestyle{headandfoot}

% default font
\renewcommand\familydefault{cmss}

% no indentation
\setlength{\parindent}{0in}

% no date by default
\date{}