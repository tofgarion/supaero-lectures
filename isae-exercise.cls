%% ISAE document class for exercises
%% C. Garion, 2012
%%
%% Mostly taken from article.cls and "Rolling your own Document Class:
%% Using LaTeX to keep away from the Dark Side" by Peter Flynn
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{isae-exercise}[2012/08/29 v0.1 
               LaTeX document class for ISAE exercises]


% defs for babel language etc.
\def\@language{english}
\def\@requirefrench{}
\DeclareOption{fr}{\def\@language{french}\def\@requirefrench{true}}
\DeclareOption{en}{\def\@language{english}}
\DeclareOption{fr-en}{\def\@language{english,french}\def\@requirefrench{true}}
\DeclareOption{en-fr}{\def\@language{french,english}}
\def\@requirebiblatex{}
\DeclareOption{biblatex}{\def\@requirebiblatex{true}}

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
\PassOptionsToClass{a4paper}{exam}
\DeclareOption*{\InputIfFileExists{\CurrentOption.sup}{}{%
    \PassOptionsToClass{\CurrentOption}{exam}}}
\ProcessOptions \relax
\RequirePackage{atbegshi}
\RequirePackage{fancyhdr}
\LoadClass{exam}

% etex for more dimens
\RequirePackage{etex}

% page layout for pages other than first one, see header and footer
% conf. below
\RequirePackage[hscale=0.85, vscale=0.90, top=40pt, includeheadfoot]{geometry}

% fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}

% babel for languages. Uses translator package for theorem etc. names.
\RequirePackage[\@language]{babel}
\RequirePackage{translator}
\ifx\@requirefrench\@empty
  \relax
\else
  \uselanguage{French}
  \languagepath{French}
  \deftranslation[to=French]{Audience}{Public}
  \RequirePackage{ae,aecompl,aeguill}
\fi

% microtype for spacing
\RequirePackage[babel=true,kerning=true]{microtype}
\SetExtraKerning%
    [ name = ttkerning,%
      context  = french]%
    { encoding = {T1}, family={ul9,fvm,tt*} }%
    { }%

% multirow for header
\RequirePackage{multirow}

% hyperref package for links
\RequirePackage[pdfversion=1.7, pdftex, colorlinks, urlcolor=blue, pdfstartview=FitH, pdfhighlight={/N}]{hyperref}

% bibliography with biblatex
\ifx\@requirebiblatex\@empty
  \relax
\else
\RequirePackage[babel]{csquotes}
\RequirePackage[
  style=numeric%
  ]{biblatex}
\fi

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
    \large \translate{Author}  & \large : \@author & \\
    \large \translate{Audience} & \large : \public@internal & \\
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
\RequirePackage[cm]{sfmath}

% no indentation
\setlength{\parindent}{0in}

% no date by default
\date{}
