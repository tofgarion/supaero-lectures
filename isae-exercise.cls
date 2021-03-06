%% ISAE document class for exercises
%% C. Garion, 2012-2016
%%
%% Mostly taken from article.cls and "Rolling your own Document Class:
%% Using LaTeX to keep away from the Dark Side" by Peter Flynn
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{isae-exercise}[2016/11/17 v0.2
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
\def\@requirecc{}
\DeclareOption{cc}{\def\@requirecc{true}}
\def\@requireadvanced{}
\DeclareOption{advanced}{\def\@requireadvanced{true}}

\def\GITAbrHash{}
\def\GITAuthorDate{}
\def\GITAuthorName{}

\def\module@internal{INXXX}
\newcommand{\module}[1]{\def\module@internal{#1}}
\newcommand{\showmodule}{\module@internal}

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
\RequirePackage[hyperref,x11names]{xcolor}
\RequirePackage{atbegshi}
\RequirePackage{fancyhdr}
\LoadClass{exam}

% for luatex
\RequirePackage{ifluatex}

% etex for more dimens
\RequirePackage{etex}

% page layout for pages other than first one, see header and footer
% conf. below
\RequirePackage[hscale=0.85, vscale=0.90, top=40pt, includeheadfoot]{geometry}

% fonts
\ifluatex
\RequirePackage{fontspec}
\setmainfont{texgyrepagella}
\setsansfont{lmsans10-regular}[Scale=MatchLowercase]
\setmonofont{Fira Mono}[Scale=0.9]
\RequirePackage{mathtools,amssymb}
\RequirePackage{unicode-math}
\setmathfont{Latin Modern Math}
\else
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\fi

% babel for languages. Uses translator package for theorem etc. names.
\RequirePackage[\@language]{babel}
\RequirePackage{translator}
\ifx\@requirefrench\@empty
  \relax
\else
  \uselanguage{French}
  \languagepath{French}
  \deftranslation[to=French]{Audience}{Public}
  \ifluatex
  \relax
  \else
  \RequirePackage{ae,aecompl,aeguill}
  \fi
  \frenchbsetup{ItemLabels=\textendash}
\fi

% microtype for spacing
\ifluatex
\relax
\else
\RequirePackage[babel=true,kerning=true]{microtype}
\SetExtraKerning%
    [ name = ttkerning,%
      context  = french]%
    { encoding = {OT1,T1},
      family = {ul9, tt*} }%
    { }%
\SetExtraKerning%
    [ name = uml,%
      context  = uml]%
    { encoding = {OT1,T1} }%
    { }%
\fi

% multirow for header
\RequirePackage{multirow}

% hyperref package for links
\RequirePackage[pdfversion=1.7, colorlinks, urlcolor=SteelBlue4, citecolor=Firebrick4, linkcolor=Firebrick4, pdfstartview=FitH, pdfhighlight={/N}]{hyperref}

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
\ifluatex
\RequirePackage{graphicx}
\else
\RequirePackage[pdftex]{graphicx}
\fi

% CC license
\ifx\@requirecc\@empty
  \relax
\else
\RequirePackage{tikz}

\let\Oldenddoc\enddocument%
\def\enddocument{%
  \selectlanguage{english}

  \section*{License CC BY-NC-SA 3.0}
  \label{sec:license}
  \begin{minipage}{0.2\textwidth}
    \begin{tikzpicture}
      \node[rounded corners, draw=black, fill=black!20]
      {\includegraphics[width=0.1\textwidth]{cc.png}\quad
        \includegraphics[width=0.1\textwidth]{by.png}\quad
        \includegraphics[width=0.1\textwidth]{nc.png}\quad
        \includegraphics[width=0.1\textwidth]{sa.png}
      };
    \end{tikzpicture}
  \end{minipage}
  \begin{minipage}{0.7\textwidth}
    This work is licensed under the Creative Commons
    Attribution-NonCommercial-ShareAlike 3.0 Unported license (CC
    BY-NC-SA 3.0)
  \end{minipage}

  \vspace{1em}

  You are free to Share (copy, distribute and transmite) and to
  Remix (adapt) this work under the following conditions:

  \vspace{1em}

  \begin{tabular}[h]{c p{0.8\textwidth}}
    \multirow{2}{0.04\textwidth}{\includegraphics[width=0.04\textwidth]{by.png}} &
    \textbf{Attribution} -- You must attribute the work in the
    manner specified by the author or licensor (but not in any way
    that suggests that they endorse you or your use of the work).\\ \\[-1em]
    \multirow{2}{0.04\textwidth}{\includegraphics[width=0.04\textwidth]{nc.png}} &
    \textbf{Noncommercial} -- You may not use this work for
    commercial purposes. \\ \\
    \multirow{2}{0.04\textwidth}{\includegraphics[width=0.04\textwidth]{sa.png}} &
    \textbf{Share Alike} -- If you alter, transform, or build upon
    this work, you may distribute the resulting work only under the
    same or similar license to this one. \\ \\
  \end{tabular}

  See \url{http://creativecommons.org/licenses/by-nc-sa/3.0/} for more
  details.
  \Oldenddoc
}%
\newsavebox{\ccbox}%
\savebox{\ccbox}{
  \begin{tikzpicture}[baseline={([yshift={-4\ht\strutbox}]current bounding box.north)}]
    \node[rounded corners, draw=black, fill=black!20]
    {\includegraphics[width=0.1\textwidth]{cc.png}\quad
      \includegraphics[width=0.1\textwidth]{by.png}\quad
      \includegraphics[width=0.1\textwidth]{nc.png}\quad
      \includegraphics[width=0.1\textwidth]{sa.png}
    };
  \end{tikzpicture}
}
\fi

% title with shorttitle
\renewcommand\title{\@dblarg\mytitlecmd}
\long\def\mytitlecmd[#1]#2{%
  \def\mytitle{#2}%
  \def\shorttitle{#1}%
}

% header and footer
%\RequirePackage{lastpage}
\RequirePackage[pagecontinue=true,alphMult=ab,AlphMulti=AB,fnsymbolmult=true,romanMult=true,RomanMulti=true]{pageslts}
\AtBeginDocument{\pagenumbering{arabic}}

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
  \else
    \ifx\@requireadvanced\@empty%
    \relax%
    \else%
    \begin{textblock}{1}(1,0)%
      \tikz \node[rounded corners, draw=red!80, ultra thick, rotate=30]%
      {\Huge\bf \textcolor{red}{\texttt{Advanced}}};%
    \end{textblock}%
    \fi%
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

\ifx\@requirecc\@empty
\firstpagefooter{%
  \tt Revision~\GITAbrHash, \GITAuthorDate, \GITAuthorName.}%
  {}%
  {\thepage/\pageref{LastPage}}%
\else
\firstpagefooter{%
  \resizebox{0.1\linewidth}{!}{\usebox{\ccbox}}
  }%
  {\tt Revision~\GITAbrHash, \GITAuthorDate, \GITAuthorName.}%
  {\thepage/\pageref{LastPage}}%
\fi

\runningheader{\module@internal}{\shorttitle \ifprintanswers { }- solution\fi}{\public@internal}%
\runningfooter{\ifx\@requirecc\@empty\else\resizebox{0.1\linewidth}{!}{\usebox{\ccbox}}\fi}{}{\thepage/\pageref{LastPage}}

\runningheadrule{}
\footrule{}

\extraheadheight[70pt]{0pt}

\pagestyle{headandfoot}

% default font
\ifluatex
\relax
\else
\renewcommand\familydefault{cmss}
\RequirePackage[cm]{sfmath}
\fi

% % redefine emph
% \makeatletter
% \DeclareRobustCommand{\em}{%
%   \@nomath\em \if b\expandafter\@car\f@series\@nil
%   \normalfont \else \bfseries \fi}
% \makeatother

% no indentation
\setlength{\parindent}{0in}

% no date by default
\date{}
