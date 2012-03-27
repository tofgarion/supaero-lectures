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

\def\titlesol@internal{solution}
\newcommand{\titlesol}[1]{\def\titlesol@internal{#1}}

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
\LoadClass{exam}

% page layout
\RequirePackage[hscale=0.85, vscale=0.93,
                top=40pt, headheight=70pt, includeheadfoot]{geometry}

% babel for languages
\RequirePackage{babel}

% microtype for spacing
\RequirePackage[babel=true,kerning=true]{microtype}

% multirow for header
\RequirePackage{multirow}

% graphics
\RequirePackage[pdftex]{graphicx}

% header and footer
\RequirePackage{lastpage}
\firstpageheader{}{%
    \noindent\begin{tabular}[h]{| l l | c |}
      \hline
       & & \\[-1.5ex]
      \multicolumn{2}{| p{0.75\textwidth}|}{\huge \bf \module@internal
        : \@title} &
        \multirow{5}{*}{\includegraphics[width=0.2\textwidth]{VL_SUPAERO_72_cmjn.png}}\\[5pt]
      \large  & & \\
      \cline{1-2}
       & & \\[-1.5ex]
      \large Auteur  & \large : \@author & \\
      \large Public & \large : \public@internal & \\
      \large Date & \large : \@date & \\
      \hline
    \end{tabular}    
}{}
\runningheader{\module@internal}{\@title}{\public@internal}
\runningheadrule

\firstpagefooter{{\tt Revision~\GITAbrHash, \GITAuthorDate,
    \GITAuthorName.}}{}{\thepage/\pageref{LastPage}}
\runningfooter{}{}{\thepage/\pageref{LastPage}}

% \fancypagestyle{mypage}{%
%   \fancyhf{}
%   \lhead{}
%   \chead{
%     \noindent\begin{tabular}[h]{| l l | c |}
%       \hline
%        & & \\[-1.5ex]
%       \multicolumn{2}{| p{0.75\textwidth}|}{\huge \bf \module@internal
%         : \noncorrige{\@title} \corrige{\titlesol@internal}} &
%         \multirow{5}{*}{\includegraphics[width=0.2\textwidth]{VL_SUPAERO_72_cmjn.png}}\\[5pt]
%       \large  & & \\
%       \cline{1-2}
%        & & \\[-1.5ex]
%       \large Auteur  & \large : \@author & \\
%       \large Public & \large : \public@internal & \\
%       \large Date & \large : \@date & \\
%       \hline
%     \end{tabular}    
%   }
%   \rhead{}

%   \lfoot{{\tt Revision~\GITAbrHash, \GITAuthorDate, \GITAuthorName.}}
%   \rfoot{\thepage/\pageref{LastPage}}
%   \renewcommand{\headrulewidth}{0pt}
%   \renewcommand{\footrulewidth}{0.4pt}
% }

% \pagestyle{headandfoot}

% default font
\renewcommand\familydefault{cmss}

% no indentation
\setlength{\parindent}{0in}
