%
% Copyright (c) 2017  Zubax Robotics OU  <info@zubax.com>
%
% Distributed under GPL v3.
%
% Author: Pavel Kirienko <pavel.kirienko@zubax.com>
%
% READ THIS FIRST:
%   In order for this package to work, its local directory must be included into the graphics
%   path list as follows:
%
%       \graphicspath{{document_templates/documentation_template_latex/}}
%
%   Notice the slash at the end, it is required.
%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{zubaxdoc}[2017/05/06 Zubax Documentation document class]

\LoadClass[a4paper,onecolumn,openany]{book}

\author{Zubax Robotics O\"U}

\RequirePackage{lipsum}              % Lorem ipsum text generation, useful for testing.
\RequirePackage[pagestyles]{titlesec}
\RequirePackage{titletoc}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{multicol}
\RequirePackage{etoolbox}
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{titling}
\RequirePackage[yyyymmdd]{datetime}
\RequirePackage{lastpage}

%
% Minor definitions.
%
\definecolor{colorhyperlink}{RGB}{100,0,0}
\definecolor{colorzubaxred}{RGB}{224,0,0}    % Zubax red logo color

\renewcommand{\dateseparator}{.}

\newcommand\ZubaxCopyright{\copyright{} \the\year{} \href{http://zubax.com}{\@author}}

%
% Font specification.
%
\RequirePackage[sfdefault]{roboto}   % Option 'sfdefault' only if the base font of the document is to be sans serif
\RequirePackage[T1]{fontenc}

%
% Page layout (tricky).
%
\raggedbottom
\RequirePackage[a4paper]{geometry}
\special{papersize=210mm,297mm}  % https://en.wikibooks.org/wiki/LaTeX/Page_Layout
\setlength\columnsep{6mm}        % Multi-column envoronments only
\setlength\headheight{17mm}
\setlength{\parskip}{0.5em}
\renewcommand{\baselinestretch}{1.2}
\leftskip=17mm
\headsep=8mm
\footskip=12mm
\setlist[description]{leftmargin=\leftskip,labelindent=\dimexpr\leftskip+\parindent\relax}
\setlist[enumerate]{leftmargin=\leftskip,itemindent=3em}
\setlist[itemize]{leftmargin=\leftskip,itemindent=3em}
\geometry{margin=20mm,top=24mm,bottom=24mm}

%
% Section formatting
%
\setcounter{secnumdepth}{3}      % Increase this to add deeper structures

\titleformat{\part}[display]{}{\centering\Large Part \thepart}{1em}{
	\centering\huge\bfseries
	}

\titleformat{\chapter}{\huge\bfseries}{}{1em}{\makebox[17mm][l]{\thechapter}\hangindent=17mm}
\titleformat{\section}{\Large\bfseries}{}{1em}{\makebox[17mm][l]{\thesection}\hangindent=17mm}
\titleformat{\subsection}{\bfseries}{}{1em}{\makebox[17mm][l]{\thesubsection}\hangindent=17mm}
\titleformat{\subsubsection}{\itshape}{\thesubsubsection}{1em}{%
	\makebox[17mm][l]{\thesubsubsection}\hangindent=17mm
	}

% Starred sections
\titleformat{name=\chapter,numberless}{\huge\bfseries}{}{1em}{}
\titleformat{name=\section,numberless}{\Large\bfseries}{}{1em}{}

% {left}{before}{after}[right]
\titlespacing{\chapter}{0em}{0em}{1em}
\titlespacing{\section}{0em}{.5em}{0em}
\titlespacing{\subsection}{0em}{.5em}{0em}
\titlespacing{\subsubsection}{0em}{0em}{0em}

%
% Hyperlinks.
% TODO: Abort rendering if title or author are empty!
%
\hypersetup{
    pdftitle={\@title{} -- \@author},
    pdfauthor={\@author},
    colorlinks,
    citecolor=colorhyperlink,
    filecolor=colorhyperlink,
    linkcolor=colorhyperlink,
    urlcolor=colorhyperlink
}

% We don't need to clear double page, ever. Shall the need arise, we'll have to implement a cleaner fix.
\renewcommand{\cleardoublepage}{\clearpage}

%
% Table of contents.
% Note that the title margins are defined in absolute units because we're using different font sizes.
%
\renewcommand{\contentsname}{Table of contents}
\renewcommand{\listfigurename}{List of figures}
\renewcommand{\listtablename}{List of tables}
\setcounter{tocdepth}{2}
\titlecontents{part}[0em]{\centering\bfseries}{}{}{}
\dottedcontents{chapter}[10mm]{\bfseries}{10mm}{1pc}
\dottedcontents{section}[20mm]{}{10mm}{1pc}
\dottedcontents{subsection}[30mm]{\small}{10mm}{1pc}

\dottedcontents{table}[2em]{}{2em}{1pc}
\dottedcontents{figure}[2em]{}{2em}{1pc}

% Custom styling of TOC, LOF, LOT.
\renewcommand\tableofcontents{%
    \thispagestyle{plain}
    \section*{\contentsname}%
    \@starttoc{toc}%
    }
\renewcommand\listoffigures{%
    \thispagestyle{plain}
    \section*{\listfigurename}%
    \@starttoc{lof}%
    }
\renewcommand\listoftables{%
    \thispagestyle{plain}
    \section*{\listtablename}%
    \@starttoc{lot}%
    }

% Make links black in the TOC, LOF, LOT.
\preto\tableofcontents{\hypersetup{linkcolor=black}}
\appto\tableofcontents{\hypersetup{linkcolor=colorhyperlink}}

\preto\listoffigures{\hypersetup{linkcolor=black}}
\appto\listoffigures{\hypersetup{linkcolor=colorhyperlink}}

\preto\listoftables{\hypersetup{linkcolor=black}}
\appto\listoftables{\hypersetup{linkcolor=colorhyperlink}}

%
% Page styling.
%
\newcommand\ChapterTitleWithNumber{%
    \ifthenelse{\equal{\thechapter}{0}}%
    {}%
    {\thechapter.\ }%
    \ifdefempty{\chaptertitle}%
    {\sectiontitle}%
    {\chaptertitle}%
    }

\newcommand\PageNumberWithTotal{\thepage\if@mainmatter/\pageref*{LastPage}\fi}

\newcommand\ZubaxLogoBlack[1][15mm]{\includegraphics[width=#1]{zubax_logo_black}}
\newcommand\ZubaxLogo[1][15mm]{\includegraphics[width=#1]{zubax_logo}}

\newcommand\VerboseLinkToSupportForum{Support \& feedback: \href{https://productforums.zubax.com}{productforums.zubax.com}}

\newcommand\TitleWithDateBefore{\begin{footnotesize}\today\quad\end{footnotesize}{\@title}}
\newcommand\TitleWithDateAfter{{\@title}\begin{footnotesize}\quad\today\end{footnotesize}}

\renewpagestyle{plain}{
	\sethead%
	    [\TitleWithDateAfter][][\ZubaxLogoBlack]     % even
	    {\ZubaxLogoBlack}{}{\TitleWithDateBefore}    % odd

	\setfoot%
	    [\PageNumberWithTotal][\small\VerboseLinkToSupportForum][\small\ZubaxCopyright]
	    {\small\ZubaxCopyright}{\small\VerboseLinkToSupportForum}{\PageNumberWithTotal}

	\headrule
	\footrule
    }
\newpagestyle{main}{
	\sethead%
	    [\TitleWithDateAfter][][\ZubaxLogoBlack]     % even
	    {\ZubaxLogoBlack}{}{\TitleWithDateBefore}    % odd

	\setfoot%
	    [\PageNumberWithTotal][][\small\ChapterTitleWithNumber]
	    {\small\ChapterTitleWithNumber}{}{\PageNumberWithTotal}

	\headrule
	\footrule
    }
\newpagestyle{titlepage}{
	\setfoot{\ZubaxCopyright}{}{\VerboseLinkToSupportForum}
	\footrule
    }

% Use the same style on pages that open new chapters.
\patchcmd{\chapter}{plain}{main}{}{}

% The document will switch to the proper page style automatically.
\preto\frontmatter{\onecolumn\pagestyle{plain}}
\preto\mainmatter{\onecolumn\pagestyle{main}}
\preto\backmatter{\onecolumn\pagestyle{plain}}

%
% Title page environment.
% Use "\BeginRightColumn" to switch to the right column.
%
\newcommand{\BeginRightColumn}{\vfill\eject}

\newcommand{\RenderTitlePageHeader}{%
    \renewcommand{\baselinestretch}{1}
    \begin{minipage}[b]{0.65\textwidth}
        \begin{flushleft}
        \begin{Huge}
            \@title\par
        \end{Huge}
        \end{flushleft}\vspace{7mm}
        Revision \today
    \end{minipage}%
    \hfill%
    \begin{minipage}[b]{0.3\textwidth}
        \begin{flushright}
        \begin{small}
            \ZubaxLogo[40mm]\\\vspace{3mm}
            \textbf{\@author}\\
            Narva mnt. 5, Tallinn 10117, Estonia\\
            \href{mailto:info@zubax.com}{info@zubax.com}\\
            Q\&{}A: \href{https://productforums.zubax.com}{productforums.zubax.com}
        \end{small}
        \end{flushright}
    \end{minipage}
    % Without \hfill here, TeX complains that hbox is underfull,
    % despite the fact that the rule spans for \textwidth here. I have no idea why.
    \rule{\textwidth}{.4pt}\hfill\vspace{3mm}
    }

\renewenvironment{titlepage}{%
    \leftskip=0mm\parindent=0mm
    \pagestyle{titlepage}\thispagestyle{titlepage}
    \twocolumn[%
        \begin{@twocolumnfalse}
            \RenderTitlePageHeader
        \end{@twocolumnfalse}
        ]
    }{%
    \onecolumn
    \clearpage
    }

\endinput
