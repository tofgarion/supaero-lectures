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

% \newif\ifmarkingscheme
% \markingschemefalse
% \DeclareOption{markingscheme}{\markingschemetrue}
% \DeclareOption{nomarkingscheme}{\markingschemefalse}

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


% default font
\renewcommand\familydefault{cmss}
\RequirePackage[cm]{sfmath}

% no indentation
\setlength{\parindent}{0in}
