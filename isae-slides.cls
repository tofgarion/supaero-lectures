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
\RequirePackage{atbegshi}
\LoadClass{beamer}

% etex for more dimens
\RequirePackage{etex}

% babel for languages. Beamer uses translator package for theorem
% etc. names.
\RequirePackage[\@language]{babel}
\ifx\@requirefrench\@empty
  \relax
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
    { encoding = {OT1,T1}, family={ul9,fvm,tt*} }%
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

% misc. commands and def
\newcommand{\s}{\onslide<+->}
\newcommand{\p}{\pause}
\newcommand{\vs}{\vspace{0.25cm}}
