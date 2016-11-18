%% ISAE document class for refcards
%% C. Garion, 2012
%%
%% Mostly taken from article.cls and "Rolling your own Document Class:
%% Using LaTeX to keep away from the Dark Side" by Peter Flynn
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{isae-refcard}[2012/09/20 v0.1
               LaTeX document class for ISAE refcards]


% defs for babel language etc.
\def\@language{english}
\def\@requirefrench{}
\DeclareOption{fr}{\def\@language{french}\def\@requirefrench{true}}
\DeclareOption{en}{\def\@language{english}}
\DeclareOption{fr-en}{\def\@language{english,french}\def\@requirefrench{true}}
\DeclareOption{en-fr}{\def\@language{french,english}}
\def\@requirebiblatex{}
\DeclareOption{biblatex}{\def\@requirebiblatex{true}}
\DeclareOption{cc}{\def\@requirecc{true}}

\def\GITAbrHash{}
\def\GITAuthorDate{}
\def\GITAuthorName{}

\def\module@internal{INXXX}
\newcommand{\module}[1]{\def\module@internal{#1}}

% This class extends the article class
% Read all the documentclass options; pass them to article,
% unless the file "<currentoption>.sup" exists, then it is loaded
\PassOptionsToClass{a4paper}{article}
\DeclareOption*{\InputIfFileExists{\CurrentOption.sup}{}{%
    \PassOptionsToClass{\CurrentOption}{article}}}
\ProcessOptions \relax
\RequirePackage[hyperref,x11names]{xcolor}
\RequirePackage{atbegshi}
\LoadClass{article}

% for luatex
\RequirePackage{ifluatex}

% etex for more dimens
\RequirePackage{etex}

% page layout for pages other than first one, see header and footer
% conf. below
\RequirePackage[hscale=0.9, vscale=0.8, foot=4em]{geometry}

% fonts
\ifluatex
\RequirePackage{fontspec}
\setmainfont{texgyrepagella}
\setsansfont{lmsans10-regular}[Scale=MatchLowercase]
\setmonofont{Inconsolatazi4}[Scale=0.85]
\RequirePackage{mathtools,amssymb}
\RequirePackage{unicode-math}
\setmathfont{Latin Modern Math}
\else
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\fi

% babel for languages. Beamer uses translator package for theorem
% etc. names.
\RequirePackage[\@language]{babel}
\ifx\@requirefrench\@empty
  \relax
\else
  \RequirePackage{ae,aecompl,aeguill}
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
\RequirePackage{graphicx}

% title with shorttitle
\renewcommand\title{\@dblarg\mytitlecmd}
\long\def\mytitlecmd[#1]#2{%
  \def\mytitle{#2}%
  \def\shorttitle{#1}%
}

% headers and footers
\ifx\@requirecc\@empty
  \relax
\else
\RequirePackage{tikz}
\fi

\RequirePackage{fancyhdr}
\fancypagestyle{headandfoot}{
  \lhead{}
  \chead{}
  \rhead{}
  \lfoot{\Large \mytitle{} -- \@author}
  \cfoot{\ifx\@requirecc\@empty\relax\else\Large \module@internal\fi%
  }
  \rfoot{\ifx\@requirecc\Large \module@internal\else%
    \begin{tikzpicture}%
      \node[rounded corners, draw=black, fill=black!20]%
      {\includegraphics[width=0.015\textwidth]{cc.png}\quad%
        \includegraphics[width=0.015\textwidth]{by.png}\quad%
        \includegraphics[width=0.015\textwidth]{nc.png}\quad%
        \includegraphics[width=0.015\textwidth]{sa.png}%
      };%
    \end{tikzpicture}%
    \fi%
  }
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0.4pt}
}

\pagestyle{headandfoot}

% default font
\ifluatex
\relax
\else
\renewcommand\familydefault{cmss}
\RequirePackage[cm]{sfmath}
\fi

% no indentation
\setlength{\parindent}{0in}

% no date by default
\date{}
