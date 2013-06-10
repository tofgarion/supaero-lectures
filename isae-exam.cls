%% ISAE/SUPAERO document class for exams
%% C. Garion, 2012
%%
%% Mostly taken from article.cls and "Rolling your own Document Class:
%% Using LaTeX to keep away from the Dark Side" by Peter Flynn
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{supaero-exam}[2012/01/30 v0.1 
               LaTeX document class for SUPAERO exams]

% defs for babel language etc.
\def\@language{english}
\def\@requirefrench{}
\DeclareOption{fr}{\def\@language{french}\def\@requirefrench{true}}
\DeclareOption{en}{\def\@language{english}}
\DeclareOption{fr-en}{\def\@language{english,french}\def\@requirefrench{true}}
\DeclareOption{en-fr}{\def\@language{french,english}}
\def\@requirebiblatex{}
\DeclareOption{biblatex}{\def\@requirebiblatex{true}}
\def\@ensica{}
\DeclareOption{ensica}{\def\@ensica{true}}
\def\@supaero{}
\DeclareOption{supaero}{\def\@supaero{true}}
\def\@name{}
\DeclareOption{name}{\def\@name{true}}
\def\@gradetable{}
\DeclareOption{gradetable}{\def\@gradetable{true}}


\newif\ifmarksdetail
\marksdetailfalse
\DeclareOption{marksdetail}{\marksdetailtrue}

\newif\ifmarkssum
\markssumfalse
\DeclareOption{markssum}{\markssumtrue}

\def\module@internal{INXXX}
\newcommand{\module}[1]{\def\module@internal{#1}}

\def\modulename@internal{Blabla}
\newcommand{\modulename}[1]{\def\modulename@internal{#1}}

\def\uf@internal{UF Informatique}
\newcommand{\uf}[1]{\def\uf@internal{#1}}

\def\conditions@internal{}
\newcommand{\conditions}[1]{\def\conditions@internal{#1}}

% This class extends the exam class
% Read all the documentclass options; pass them to article,
% unless the file "<currentoption>.sup" exists, then it is loaded
\PassOptionsToClass{a4paper}{exam}
\DeclareOption*{\InputIfFileExists{\CurrentOption.sup}{}{%
    \PassOptionsToClass{\CurrentOption}{exam}}}
\ProcessOptions \relax
\RequirePackage{atbegshi}
\LoadClass{exam}

% etex for more dimens
\RequirePackage{etex}

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
    { encoding = {OT1,T1}, 
      family = {ul9, tt*} }%
    { }%
\SetExtraKerning%
    [ name = uml,%
      context  = uml]%
    { encoding = {OT1,T1} }%
    { }%

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

% marks detail
\RequirePackage{environ}
\RequirePackage{colortbl}
\RequirePackage{xcolor}
\RequirePackage{numprint}
\RequirePackage{lstdoc}
\RequirePackage{booktabs}

\nprounddigits{3}
\colorlet{isae@bgtab}{gray!20}

\newcounter{ms}

\gdef\markssum\@empty
\gdef\mymarkssum{}

\def\addtolist#1#2{%
  \lst@lAddTo#1{#2}
}

\def\DM#1|#2;{%
  %\addtocounter{ms}{1}
  question: \thequestion\\
  \addtolist{\markssum}{\thequestion,}%
  %\xdef{\mymarkssum}{\mymarkssum bla}%
  \markssum{}
  %\mymarkssum{}\\
  \expandafter\gdef\csname\thequestion-\thepartno\endcsname{\thequestion-\thepartno-\value{ms}&#1&#2\cr\relax}
  \lst@BubbleSort{\markssum}
}

% \newsavebox{\tempbox}
% \savebox{\tempbox}{
% \centering
% \begin{tabular}{llll}
%   \toprule[1pt]
%   Number & bla & bli\\
%   \midrule
%   \@for\i:=\markssum \do{\csname\i\endcsname}
%   \vspace{-14pt}\\\bottomrule
% \end{tabular}
% }

\newcommand\initmarkssum[1][0]{%
  \expandafter\xdef\markssum{\markssum \cellcolor{isae@bgtab}\thequestion & & #1 \cr\relax}
}

\RequirePackage{datatool}
\DTLnewdb{marksum}

\newenvironment{marksum}{%
  \setcounter{ms}{0}
  \DTLnewrow{marksum}
  \expandafter\def\expandafter\sortitemaux\expandafter{\thequestion-\thepartno}
  \sortitemaux{}
  \DTLnewdbentry{marksum}{sortitem}{\thequestion-\thepartno}
  \DTLnewdbentry{marksum}{qnumber}{\thequestion-\thepartno}
  \DTLnewdbentry{marksum}{comment}{blabla pour question \thequestion}
  \DTLnewdbentry{marksum}{mark}{1}
}{%
}%

\newcommand\printmarksum{%
  \DTLsort{sortitem}{marksum}%
  \begin{tabular}{l l l l}
  \DTLforeach*{marksum}{\thesortitem=sortitem,\theqnumber=qnumber,\thecomment=comment,\themark=mark}{%
    \thesortitem & \theqnumber & \thecomment & \themark\\
  }%
  \end{tabular}
}%

% \RequirePackage{letltxmacro}

% \let\oldQuestion\question
% \renewcommand{\question}{coucou \oldQuestion}

% \NewEnviron{marksdetail}{%
%   \ifmarksdetail
%     \vspace{1em}

%     {\bf \translate{Grade details}:}

%     \vspace{0.5em}

%     \begin{tabular}[h]{>{\bfseries } l | l n{4}{3}}
%       \BODY
%     \end{tabular}

%     \vspace{0.5em}

%   \else
%     \relax
%   \fi
% }


\newcommand{\rowemph}{\expandafter\rowcolor{gray!30}}
\newcommand{\malus}{\expandafter\cellcolor{red!30}}
\newcommand{\bonus}{\expandafter\cellcolor{green!30}}

% logo
\def\logo{logo_isae_compact_color_72.png}

\ifx\@ensica\@empty
  \relax
\else
  \def\logo{logo_ensica_compact_color_72.png}
\fi

\ifx\@supaero\@empty
  \relax
\else
  \def\logo{logo_supaero_compact_color_72.png}
\fi

% title with shorttitle
\renewcommand\title{\@dblarg\mytitlecmd}
\long\def\mytitlecmd[#1]#2{%
  \def\mytitle{#2}%
  \def\shorttitle{#1}%
}

% headers and titlepage
\RequirePackage{graphicx}

\deftranslation[to=French]{Name}{Nom}
\deftranslation[to=French]{First name}{Pr\'enom}
\deftranslation[to=French]{Group}{Groupe}
\deftranslation[to=French]{Comments}{Commentaires \'eventuels}
\deftranslation[to=French]{Grade details}{Notation d\'etaill\'ee}

\header{\module@internal}{\shorttitle}{\@date}
\headrule
\footer{}{}{\thepage/\numpages}
\footrule
\coverheader{\includegraphics[width=0.15\textwidth]{\logo}}{}{\Large
  \uf@internal{}}
\renewcommand{\questionlabel}{\bfseries \thequestion.}

\pagestyle{headandfoot}


\newcommand\basiccoverpage{
  \null
  \vskip 30pt

  \begin{center}%
    {\huge \bfseries \module@internal: \modulename@internal \par}%
  \end{center}

  \begin{center}%
    {\huge \mytitle \par}%
  \end{center}

  \vskip 40pt

  \ifx\conditions@internal\empty
    \relax
  \else
    \noindent\rule{\linewidth}{2pt}

    {\large \conditions@internal}

    \noindent\rule{\linewidth}{2pt}
  \fi


  \vskip 10pt

  \if\@name\empty
    \relax
  \else
  {\huge
  \makebox[\textwidth]{\translate{Name}:\enspace\hrulefill}

  \vspace{5pt}

  \makebox[\textwidth]{\translate{First name}:\enspace\hrulefill}

  \vspace{11pt}

  \makebox[\textwidth]{\translate{Group}:\enspace\hrulefill}
  }

  \vskip 10pt
  \fi

  \if\@gradetable\empty
    \relax
  \else
  ~
  \begin{minipage}[t]{0.32\linewidth}
    \hspace{0cm}

    \gradetable
  \end{minipage}
  \begin{minipage}[t]{0.68\linewidth}
    \vskip 5pt
    \Large \bfseries \translate{Comments}:
  \end{minipage}
  \fi
}

% environment and commands

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

% remaining space in current page
\newcommand\measurepage[1]{\dimexpr\pagegoal-\pagetotal+#1\textheight\relax}

% checkboxes
\RequirePackage{amssymb}
\checkboxchar{$\Box$}

% default font
\renewcommand\familydefault{cmss}
\RequirePackage[cm]{sfmath}

% no indentation
\setlength{\parindent}{0in}
