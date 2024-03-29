%%%%%%%%%%%%%%%%%
% This is altacv.cls (v1.1.5, 1 December 2018) written by
% LianTze Lim (liantze@gmail.com).
%
% Modified by Omar Einea
%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%%
%%
% Contributions:
% - https://github.com/akreuzer Added ragged2e option (5 Nov 2018)
% - https://github.com/stefanogermano Fixed bad boxes and undefined font shape (July 2018)
% - https://github.com/foohyfooh Fixed blank spaces in \cvevent and bad link in README.md (June 2018)
%
%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\@ifl@t@r\fmtversion{2018/04/01}{\UseRawInputEncoding}{}
\ProvidesClass{altacv}[2018/12/01 AltaCV v1.1.5, yet another alternative class for a résumé/curriculum vitae.]

\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\newif\if@raggedtwoe
\DeclareOption{ragged2e}{\@raggedtwoetrue}
\ProcessOptions\relax

\LoadClass{extarticle}

\RequirePackage[margin=2cm]{geometry}
\RequirePackage{lib/fontawesome5}
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{scrlfile}

\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\if@raggedtwoe
  \RequirePackage[newcommands]{ragged2e}
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{heading}{black}
\colorlet{emphasis}{black}
\colorlet{body}{black!80!white}
\newcommand{\itemmarker}{{\small\textbullet}}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vskip0.25\baselineskip}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{.99\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-.97\marginparwidth-\marginparsep\relax}
}{\end{adjustwidth}}

\newcommand{\printinfo}[2]{\mbox{\textcolor{accent}{\normalfont\parbox[t]{1em}{\centering #1}}\hspace{.5em}#2}}

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}
\newcommand{\email}[1]{\printinfo{\fa{envelope}}{#1}}
\newcommand{\mailaddress}[1]{\printinfo{\fa{mail-bulk}}{#1}}
\newcommand{\phone}[1]{\printinfo{\fa{phone}}{#1}}
\newcommand{\homepage}[1]{\printinfo{\fa{link}}{#1}}
\newcommand{\linkedin}[1]{\printinfo{\fa{linkedin}}{#1}}
\newcommand{\github}[1]{\printinfo{\fa{github}}{#1}}
\newcommand{\location}[1]{\printinfo{\fa{map-marker-alt}}{#1}}

\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}

\newcommand{\makecvheader}{%
  \begingroup
    \ifdef{\@photodiameter}{\begin{minipage}{\dimexpr\linewidth-\@photodiameter}}{}%
    \raggedright\color{emphasis}%
    {\Huge\bfseries\MakeUppercase{\@name}\par}
    \medskip
    {\large\bfseries\color{accent}\@tagline\par}
    \medskip
    {\footnotesize\bfseries\@personalinfo\par}
    \ifdef{\@photodiameter}{%
    \end{minipage}\hfill%
    \begin{minipage}{\@photodiameter}
    \if@normalphoto
      \includegraphics[width=\linewidth]{\@photo}
    \else
      \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\linewidth];
    \fi%
    \end{minipage}\par}{}%
  \endgroup\smallskip
}

\renewenvironment{quote}{\color{accent}\itshape\large}{\par}

\newcommand{\cvsection}[2][]{%
  \bigskip%
  \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright #1}}%
  {\color{heading}\LARGE\bfseries\MakeUppercase{#2}}\\[-1ex]%
  {\color{heading}\rule{.97\linewidth}{2pt}\par}\medskip
}

\newcommand{\cvtitle}[1]{%
  {\color{emphasis}\bfseries{#1}}
  \medskip
}

\newcommand{\cvdated}[3]{%
  {\large\color{emphasis}#1\par}
  \smallskip\normalsize
  \ifstrequal{#2}{}{}{\textbf{\color{accent}#2}\par}
  \ifstrequal{#3}{}{}{{\smallskip\small\makebox[.5\linewidth][l]{\hspace{-.2em}\fa{calendar-alt}\hspace{.5em}#3}}}\par
  \medskip\normalsize
}

\newcommand{\cvevent}[4]{%
  {\large\makebox[.62\linewidth][l]{\color{emphasis}#1}}
  \ifstrequal{#3}{}{}{\small{\color{accent}\fa{calendar-alt}}\hspace{.5em}#3}%
  \par\smallskip\normalsize
  \ifstrequal{#2}{}{}{\textbf{\makebox[.62\linewidth][l]{\color{accent}#2}}}
  \ifstrequal{#4}{}{}{\small\hspace{.08em}{\color{accent}\fa{map-marker-alt}}\hspace{.53em}#4}\par
  \medskip\normalsize
}

\newcommand{\cvachievement}[3]{%
  \smallskip
  \begin{tabularx}{\linewidth}{@{}p{2em} @{\hspace{0em}} >{\raggedright\arraybackslash}X@{}}
  \multirow{2}{*}{\hspace{-.3em}\Large\color{accent}#1} & \bfseries\textcolor{emphasis}{#2}\\ & #3
  \end{tabularx}%
  \medskip
}

\newcommand{\cvskill}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=.95ex,inner ysep=.7ex,text height=1.5ex,text depth=.25ex]{#1};
}
\newcommand{\cvtool}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!30,opacity=0.9,rounded corners,inner xsep=.8ex,inner ysep=.7ex,text height=1.2ex,text depth=.15ex]{\small#1};
}

\newenvironment{cvcolumn}[1]{\begin{minipage}[t]{#1}\raggedright}{\end{minipage}}

\newcommand{\addnextpagesidebar}[2][]{\afterpage{\addsidebar[#1]{#2}}}

\AtBeginDocument{%
  \pagestyle{empty}
  \color{body}
  \raggedright
}
