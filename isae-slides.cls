%% ISAE document class for slides
%% C. Garion, 2012
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{isae-slides}[2012/08/14 v0.1 
               LaTeX document class for ISAE slides]

% defs for babel language etc.
\def\@language{english}
\def\@requirefrench{}
\DeclareOption{fr}{\def\@language{french}\def\@requirefrench{true}}
\DeclareOption{en}{\def\@language{english}}
\DeclareOption{fr-en}{\def\@language{english,french}\def\@requirefrench{true}}
\DeclareOption{en-fr}{\def\@language{french,english}}
\def\@noteshandout{}
\DeclareOption{notes}{\def\@noteshandout{true}}
\def\@requirebiblatex{}
\DeclareOption{biblatex}{\def\@requirebiblatex{true}}
\def\@outline{}
\DeclareOption{outline}{\def\@outline{true}}
\def\myoutline{Outline }
\def\mypartname{of part}

% This class extends the beamer class
% Read all the documentclass options; pass them to beamer,
% unless the file "<currentoption>.sup" exists, then it is loaded
\PassOptionsToClass{a4paper}{beamer}
\DeclareOption*{\InputIfFileExists{\CurrentOption.sup}{}{%
    \PassOptionsToClass{\CurrentOption}{beamer}}}
\ProcessOptions \relax
\ifx\@noteshandout\@empty
  \relax
\else
  \PassOptionsToClass{handout}{beamer}
\fi
% bug with beamer and tikz
\RequirePackage{atbegshi}
\LoadClass{beamer}

% etex for more dimens
\RequirePackage{etex}

% fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}

% babel for languages. Beamer uses translator package for theorem
% etc. names.
\RequirePackage[\@language]{babel}
\ifx\@requirefrench\@empty
  \RequirePackage{xspace}
\else
  \RequirePackage{ae,aecompl,aeguill}
  \uselanguage{French}
  \languagepath{French}
  \def\myoutline{Plan }
  \def\mypartname{de la partie}
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
\RequirePackage{hyperref}

% bibliography with biblatex
\ifx\@requirebiblatex\@empty
  \relax
\else
\RequirePackage[babel]{csquotes}
\RequirePackage[
  style=isae%
  ]{biblatex}
\defbibheading{inline-bibliography}{}
\newcommand{\printbibliographyinline}{%
  \printbibliography[segment=\therefsegment,heading=inline-bibliography]%
  \newrefsegment%
}
\newcommand{\biblioinline}[1]{
  \nocite{#1}
  \begin{block}{}
    \parbox{\textwidth}{\printbibliographyinline}
  \end{block}
}
\newcommand{\biblio}{
  \begin{block}{}
    \parbox{\textwidth}{\printbibliography}
  \end{block}
}
\fi

% outline 
\ifx\@outline\@empty
  \relax
\else
\AtBeginPart%
{%
  \begin{frame}
    \frametitle{\myoutline \mypartname ~ \insertpartnumber ~- \insertshortpart}
    \addtocontents{toc}{\protect\beamer@partintoc{\the\c@part}{\beamer@partname}{\the\c@page}}%

    \partpage

    \tableofcontents[subsectionstyle=hide]
  \end{frame}
}
% onlyparts command for tableofcontents. Thanks Ulrich Schwarz et
% al. at http://tex.stackexchange.com/questions/5285/tableofcontents-from-part-commands-in-beamer
\providecommand\beamer@partintoc[3]{%
  \ifnum\c@tocdepth=-1\relax
    % requesting onlyparts.
    \usebeamerfont{section in toc}
    #1 - #2
    \par
  \fi
}
\define@key{beamertoc}{onlyparts}[]{%
  \c@tocdepth=-1\relax
}
\AtBeginSection[]
{
  \begin{frame}
    \frametitle{\myoutline\ifx\beamer@partname\undefined\relax\else \mypartname ~ \insertpartnumber ~- \insertshortpart\fi}

    \tableofcontents[sectionstyle=show/shaded, subsectionstyle=show/show/hide]
  \end{frame}
}
\AtBeginSubsection[]
{
  \begin{frame}
    \frametitle{\myoutline\ifx\beamer@partname\undefined\relax\else \mypartname ~ \insertpartnumber ~- \insertshortpart\fi}

    \tableofcontents[sectionstyle=show/shaded, subsectionstyle=show/shaded/hide]
  \end{frame}
}
\fi

% for handouts, 2x2 disposition
\ifx\@noteshandout\@empty
  \mode<handout>{
    \RequirePackage{pgfpages}
    \pgfpagesuselayout{4 on 1}[a4paper, border shrink=2.5mm, landscape]
  }
\else
  \mode<handout>{
    \RequirePackage{handoutWithNotes}
    \pgfpagesuselayout{2 on 1 with notes landscape}[a4paper, border shrink=5mm]
  }
\fi

% select theme for beamer
\usetheme{isae}

% for beamer overlays with TikZ nodes
\tikzset{onslide/.code args={<#1>#2}{%
  \only<#1>{\pgfkeysalso{#2}} 
}}

% command for CC license
\RequirePackage{multirow}

\newcommand{\cclicense}{
  \begin{frame}[t]
    \frametitle{License CC BY-NC-SA 3.0}

    {\small

    \begin{columns}[T]
      \begin{column}{0.3\textwidth}
        \begin{tikzpicture}
          \node[rounded corners, draw=black, fill=black!20] 
               {\includegraphics[width=0.2\textwidth]{cc.png}\quad 
                \includegraphics[width=0.2\textwidth]{by.png}\quad
                \includegraphics[width=0.2\textwidth]{nc.png}\quad
                \includegraphics[width=0.2\textwidth]{sa.png}
               };
        \end{tikzpicture}
      \end{column}
      \begin{column}{0.6\textwidth}
        This work is licensed under the Creative Commons
        Attribution-NonCommercial-ShareAlike 3.0 Unported license (CC
        BY-NC-SA 3.0)
      \end{column}
    \end{columns}

    \vfill

    You are free to Share (copy, distribute and transmite) and to
    Remix (adapt) this work under the following conditions:

    \vspace{1em}

    \begin{tabular}[h]{c p{0.8\textwidth}}
      \multirow{2}{0.075\textwidth}{\includegraphics[width=0.075\textwidth]{by.png}} &
      \textbf{Attribution} -- You must attribute the work in the
      manner specified by the author or licensor (but not in any way
      that suggests that they endorse you or your use of the work).\\ \\[-1em]
      \multirow{2}{0.075\textwidth}{\includegraphics[width=0.075\textwidth]{nc.png}} &
      \textbf{Noncommercial} -- You may not use this work for
      commercial purposes. \\ \\
      \multirow{2}{0.075\textwidth}{\includegraphics[width=0.075\textwidth]{sa.png}} &
      \textbf{Share Alike} -- If you alter, transform, or build upon
      this work, you may distribute the resulting work only under the
      same or similar license to this one. \\ \\
    \end{tabular}

    See \url{http://creativecommons.org/licenses/by-nc-sa/3.0/}.
    }
  \end{frame}
}

% misc. commands and def
\newcommand{\s}{\onslide<+->}
\newcommand{\p}{\pause}
\newcommand{\vs}{\vspace{0.25cm}}
\newcommand{\dvs}{\vspace{0.5cm}}

\RequirePackage{pifont}
\newcommand{\frametitleexercise}[1]{%
  \frametitle{\hbox{\rlap{\parbox{\textwidth}{\raggedright #1}} ~
      \rlap{\parbox{0.9\paperwidth}{\raggedleft \ding{46}}}}}
}
