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

\newif\ifmarks
\marksfalse
\DeclareOption{marks}{\markstrue}
\DeclareOption{nomarks}{\marksfalse}

\def\module@internal{INXXX}
\newcommand{\module}[1]{\def\module@internal{#1}}

\def\modulename@internal{Blabla}
\newcommand{\modulename}[1]{\def\module@internal{#1}}

\def\uf@internal{UF Informatique}
\newcommand{\uf}[1]{\def\uf@internal{#1}}

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

% \newcommand\MarkingSchemeEmphasis[1]{%
%   \def\MarkingScheme@Emphasis{#1}%
% }
% \MarkingSchemeEmphasis{}

% \newenvironment{markingscheme}
%   {%
%     \ifmarkingscheme
%       \begingroup
%       \MarkingScheme@Emphasis
%     \else
%       \setbox\z@\vbox\bgroup
%     \fi
%   }{%
%     \ifmarkingscheme
%       \endgroup
%     \else
%       \egroup
%     \fi
%   }%

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

  \noindent\rule{\linewidth}{2pt}

  {\large

    Cette première partie de l'examen est composée de \numquestions{}
    exercices indépendants. Le barême indiqué pour chaque exercice
    l'est à titre indicatif et peut être modifié.

    Les seuls documents autorisés pour cet examen sont:
    
    \begin{itemize}
    \item les notes distribuées en cours (avec vos notes manuscrites)
    \item les cartes de référence distribuées en cours
    \end{itemize}
    
    Les annales des examens des années précédentes sont interdites. Les
    téléphones portables doivent être éteints et rangés. L'utilisation
    d'un ordinateur durant l'examen est interdite.
    
    Vous avez normalement la place de répondre sur ce document. Si vous
    devez utiliser une copie libre, n'oubliez pas d'y indiquer vos noms,
    prénoms et groupe de PC, ainsi que le numéro précis de la question à
    laquelle vous répondez.
  }

  \noindent\rule{\linewidth}{2pt}

  \vskip 10pt
  
  {\huge
  \makebox[\textwidth]{Nom:\enspace\hrulefill}

  \vspace{5pt}

  \makebox[\textwidth]{Prénom:\enspace\hrulefill}

  \vspace{11pt}

  \makebox[\textwidth]{Groupe:\enspace\hrulefill}
  }

  \vskip 10pt

  ~
  \begin{minipage}[t]{0.32\linewidth}
    \hspace{0cm}

    \gradetable
  \end{minipage}
  \begin{minipage}[t]{0.68\linewidth}
    \vskip 5pt
    \Large \bfseries Commentaires éventuels:
  \end{minipage}
}

% default font
\renewcommand\familydefault{cmss}
\RequirePackage[cm]{sfmath}

% no indentation
\setlength{\parindent}{0in}
