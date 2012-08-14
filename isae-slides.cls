%% ISAE document class for slides
%% C. Garion, 2012
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{isae-slides}[2012/08/14 v0.1 
               LaTeX document class for ISAE slides]

% defs for babel language. Default is english
\def\@language{english}
\def\@requirefrench{}
\DeclareOption{fr}{\def\@language{french}\def\@requirefrench{true}}
\DeclareOption{en}{\def\@language{english}}
\DeclareOption{fr-en}{\def\@language{english,french}\def\@requirefrench{true}}
\DeclareOption{en-fr}{\def\@language{french,english}}

% This class extends the beamer class
% Read all the documentclass options; pass them to beamer,
% unless the file "<currentoption>.sup" exists, then it is loaded
\PassOptionsToClass{a4paper}{beamer}
\DeclareOption*{\InputIfFileExists{\CurrentOption.sup}{}{%
    \PassOptionsToClass{\CurrentOption}{beamer}}}
\def\@requirebiblatex{}
\DeclareOption{biblatex}{% use biblatex
  \def\@requirebiblatex{true}%
}%
\ProcessOptions \relax
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
\uselanguage{French}
\languagepath{French}
\fi

% microtype for spacing
\RequirePackage[babel=true,kerning=true]{microtype}

% hyperref package for links
\RequirePackage{hyperref}

% bibliography with biblatex
\ifx\@requirebiblatex\@empty
  \relax
\else
\RequirePackage[babel]{csquotes}
\RequirePackage[
  style=beamer%
  ]{biblatex}
\defbibheading{inline-bibliography}{}
\newcommand{\printbibliographyinline}{%
  \printbibliography[segment=\therefsegment,heading=inline-bibliography]%
  \newrefsegment%
}
\newcommand{\biblioinline}[1]{
  \nocite{#1}
  \begin{center}
    \usebeamercolor{block body}
    \begin{tikzpicture}
      \draw node[draw=fg!20!bg, fill=bg, rounded corners=2pt] {\parbox{0.95\textwidth}{\vskip-0.1cm\printbibliographyinline\vskip0.1cm}};
    \end{tikzpicture}
    \twopton{}
\end{center}
}
\newcommand{\biblio}{
  \begin{center}
    \usebeamercolor{block body}
    \begin{tikzpicture}
      \draw node[draw=fg!20!bg, fill=bg, rounded corners=2pt] {\parbox{0.95\textwidth}{\vskip-0.1cm\printbibliography\vskip0.1cm}};
    \end{tikzpicture}
    \twopton{}
\end{center}
}
\fi

% select theme for beamer
\usetheme{isae}