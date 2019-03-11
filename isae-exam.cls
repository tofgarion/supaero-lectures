%% ISAE/SUPAERO document class for exams
%% C. Garion, 2012, 2013, 2014
%%
%% Mostly taken from article.cls and "Rolling your own Document Class:
%% Using LaTeX to keep away from the Dark Side" by Peter Flynn
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{isae-exam}[2014/01/07 v0.3
               LaTeX document class for ISAE exams]

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
\def\@requirecc{}
\DeclareOption{cc}{\def\@requirecc{true}}
\def\@machinename{}
\DeclareOption{machinename}{\def\@machinename{true}}

\newif\ifmarksdetail
\marksdetailfalse
\DeclareOption{marksdetail}{\marksdetailtrue}

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

% for luatex
\RequirePackage{ifluatex}

% etex for more dimens
\RequirePackage{etex}

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

% marks detail
\RequirePackage{environ}
\RequirePackage{colortbl}
\RequirePackage[hyperref,x11names]{xcolor}
\RequirePackage{numprint}
\RequirePackage{booktabs}

\nprounddigits{3}
\colorlet{isae@bgtab}{gray!20}

\NewEnviron{marksdetail}{%
  \ifmarksdetail
    \section*{\translate{Grade details}}

    \BODY
  \else
    \relax
  \fi
}

\NewEnviron{markstab}{%
  \vspace{0.5em}

  \begin{tabular}[h]{>{\bfseries } l | l r}
    \BODY
  \end{tabular}

  \vspace{0.5em}
}

\newcommand{\rowemph}{\expandafter\rowcolor{gray!30}}
\newcommand{\malus}{\expandafter\rowcolor{red!30}}
\newcommand{\bonus}{\expandafter\rowcolor{green!30}}

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

% CC license
\ifx\@requirecc\@empty
  \relax
\else
\RequirePackage{tikz}
\RequirePackage{multirow}

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

% headers and titlepage
\RequirePackage[absolute]{textpos}
\setlength{\TPHorizModule}{0.5\textwidth}
\setlength{\TPVertModule}{0.1\textheight}
\textblockorigin{2em}{3em}

\deftranslation[to=French]{Name}{Nom}
\deftranslation[to=French]{First name}{Pr\'enom}
\deftranslation[to=French]{Group}{Groupe}
\deftranslation[to=French]{Comments}{Commentaires \'eventuels}
\deftranslation[to=French]{Grade details}{Notation d\'etaill\'ee}
\deftranslation[to=French]{Machine}{Machine}

\header{\module@internal}{\shorttitle, question \thequestion\ifprintanswers { }- solution\fi}{\@date}
\headrule
\footer{\ifx\@requirecc\@empty\else\resizebox{0.1\linewidth}{!}{\usebox{\ccbox}}\fi}{}{\thepage/\numpages}
\footrule{}

\coverheader{\includegraphics[width=0.15\textwidth]{\logo}}{}{\Large
  \uf@internal{}}
\renewcommand{\questionlabel}{\bfseries \thequestion.}

\pagestyle{headandfoot}

\newcommand\basiccoverpage{
\begin{coverpages}
  \null
  \vskip 30pt

  \ifprintanswers
  \begin{textblock}{1}(1,1)
    \tikz \node[rounded corners, draw=red!80, ultra thick, rotate=30]%
    {\Huge\bf \textcolor{red}{\texttt{Solution}}};
  \end{textblock}
  \fi

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

  \if\@machinename\empty
    \relax
  \else
  {\vspace{11pt}

    \makebox[\textwidth]{\translate{Machine}:\enspace\hrulefill}
  }
  \fi
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
\end{coverpages}
}

% environments and commands
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

% maths
\RequirePackage{mathtools}

% default font
\ifluatex
\relax
\else
\renewcommand\familydefault{cmss}
\RequirePackage[cm]{sfmath}
\fi

% no indentation
\setlength{\parindent}{0in}
