\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gamifiedcv}[2024/12/31 v3.4.3 Gamified Digital Marketing CV with ATS Support]

% Base class
\LoadClass{extarticle}

% Required packages
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[french]{babel}
\RequirePackage{lmodern}
\RequirePackage{microtype}
\RequirePackage{etoolbox}
\RequirePackage{xcolor}
\RequirePackage{xparse}
\RequirePackage[margin=2cm,noheadfoot]{geometry}
\RequirePackage[fixed]{fontawesome5}
\RequirePackage{tikz}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{graphicx}
\RequirePackage[scaled=0.9]{helvet}
\RequirePackage{paracol}
\RequirePackage{letltxmacro}
\RequirePackage{accsupp}
\RequirePackage[many]{tcolorbox}

% TikZ libraries
\usetikzlibrary{shapes.misc}
\usetikzlibrary{positioning}
\usetikzlibrary{backgrounds}
\usetikzlibrary{shadows}
\usetikzlibrary{arrows.meta}
\usetikzlibrary{calc}
\usetikzlibrary{shapes.geometric}

% Dimension Management System
% Default values - all can be customized
\newlength{\cvphotowidth}
\newlength{\cvphotosep}
\newlength{\cvskillbarwidth}
\newlength{\cvheaderheight}
\newlength{\cvsectionvspace}
\newlength{\cvitemvspace}
\newlength{\cvcolumnsep}
\newlength{\cvboxpadding}
\newlength{\cviconsize}
\newlength{\cvborderwidth}

% Initialize with default values
\setlength{\cvphotowidth}{3.5cm}
\setlength{\cvphotosep}{2em}
\setlength{\cvskillbarwidth}{4cm}
\setlength{\cvheaderheight}{4cm}
\setlength{\cvsectionvspace}{1em}
\setlength{\cvitemvspace}{0.5em}
\setlength{\cvcolumnsep}{2em}
\setlength{\cvboxpadding}{0.5em}
\setlength{\cviconsize}{1em}
\setlength{\cvborderwidth}{0.4pt}

% Responsive scaling system
\newcommand{\setcvscale}[1]{%
  \setlength{\cvphotowidth}{#1\cvphotowidth}%
  \setlength{\cvphotosep}{#1\cvphotosep}%
  \setlength{\cvskillbarwidth}{#1\cvskillbarwidth}%
  \setlength{\cvheaderheight}{#1\cvheaderheight}%
  \setlength{\cvsectionvspace}{#1\cvsectionvspace}%
  \setlength{\cvitemvspace}{#1\cvitemvspace}%
  \setlength{\cvcolumnsep}{#1\cvcolumnsep}%
  \setlength{\cvboxpadding}{#1\cvboxpadding}%
  \setlength{\cviconsize}{#1\cviconsize}%
  \setlength{\cvborderwidth}{#1\cvborderwidth}%
}

% Customization commands
\newcommand{\setcvdimension}[2]{%
  \expandafter\ifx\csname cv#1\endcsname\relax
    \PackageError{gamifiedcv}{Unknown dimension: #1}{Available dimensions are: photowidth, photosep, skillbarwidth, etc.}%
  \else
    \expandafter\setlength\csname cv#1\endcsname{#2}%
  \fi
}

% Dynamic relative dimensions
\newcommand{\getcvrelativewidth}[1]{%
  \dimexpr\linewidth*#1/100\relax
}

% Options
\newif\if@normalphoto
\newif\if@raggedtwoe
\newif\if@withhyper
\newif\if@darkmode
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption{ragged2e}{\@raggedtwoetrue}
\DeclareOption{withhyper}{\@withhypertrue}
\DeclareOption{darkmode}{\@darkmodetrue}
% Class options for predefined scales
\DeclareOption{compact}{\setcvscale{0.8}}
\DeclareOption{wide}{\setcvscale{1.2}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

% Color schemes
\if@darkmode
    % Updated Dark Mode Colors with better contrast
    \definecolor{cvBackground}{HTML}{0A0F1B}     % Deep dark blue-black
    \definecolor{cvPrimaryLight}{HTML}{1A1F35}   % Dark navy
    \definecolor{cvPrimary}{HTML}{3B82F6}        % Strong blue (adjusted)
    \definecolor{cvPrimaryDark}{HTML}{2563EB}    % Darker blue for better contrast
    \definecolor{cvText}{HTML}{F8FAFC}           % Bright white
    \definecolor{cvTextLight}{HTML}{E2E8F0}      % Very light gray
    \definecolor{cvAccent}{HTML}{3B82F6}         % Strong blue (adjusted)
    \definecolor{cvBorder}{HTML}{1A1F35}         % Dark navy
    
    % Updated Gamification Colors for dark mode
    \definecolor{achievementGold}{HTML}{F59E0B}  % Bright orange-gold
    \definecolor{questPurple}{HTML}{8B5CF6}      % Bright purple
    \definecolor{skillGreen}{HTML}{10B981}       % Bright green
    \definecolor{expBlue}{HTML}{3B82F6}          % Strong blue
    
    \pagecolor{cvBackground}
    \color{cvText}
\else
    % Light Mode Colors
    \definecolor{cvBackground}{HTML}{FFFFFF}      % White
    \definecolor{cvPrimaryLight}{HTML}{EFF6FF}    % Very light blue
    \definecolor{cvPrimary}{HTML}{2563EB}        % Blue
    \definecolor{cvPrimaryDark}{HTML}{1D4ED8}    % Dark blue
    \definecolor{cvText}{HTML}{1E293B}           % Dark slate
    \definecolor{cvTextLight}{HTML}{64748B}      % Slate
    \definecolor{cvAccent}{HTML}{3B82F6}         % Blue
    \definecolor{cvBorder}{HTML}{E2E8F0}         % Light gray
    
    % Gamification Colors
    \definecolor{achievementGold}{HTML}{D97706}  % Gold
    \definecolor{questPurple}{HTML}{7C3AED}      % Purple
    \definecolor{skillGreen}{HTML}{059669}       % Green
    \definecolor{expBlue}{HTML}{2563EB}          % Blue
\fi

% Now the global tcolorbox styles
\tcbset{
    enhanced,
    boxrule=\cvborderwidth,
    arc=2mm,
    top=\cvboxpadding,
    bottom=\cvboxpadding,
    left=\cvboxpadding,
    right=\cvboxpadding,
    coltext=cvText,
    colback=cvPrimaryLight,
    fonttitle=\bfseries,
    toptitle=\cvboxpadding,
    bottomtitle=\cvboxpadding,
    shadow={0pt}{0pt}{0mm}{black!00},
    fontupper=\color{cvText},
    fontlower=\color{cvText}
}

% Define achievement types
\newcommand{\achtech}{\faLaptopCode}
\newcommand{\achsoft}{\faUsers}
\newcommand{\achproj}{\faProjectDiagram}
\newcommand{\achcert}{\faCertificate}

% Experience points visualization with milestone
\NewDocumentCommand{\xpbar}{mm}{%
  \noindent
  \begin{tcolorbox}[
    colback=cvPrimaryLight,
    colframe=expBlue,
    boxrule=\cvborderwidth,
    arc=1mm
  ]
  \begin{tikzpicture}
    \fill[cvPrimaryLight] (0,0) rectangle (\linewidth-4mm,0.4);
    \fill[expBlue] (0,0) rectangle ({(#1/100)*(\linewidth-4mm)},0.4);

    \node[anchor=center] at (0.5*\linewidth-2mm,0.2) {%
      \color{cvText}\small Level~#2~-~#1\%~to~Next~Level
    };
  \end{tikzpicture}
  \end{tcolorbox}
}
% Achievement badge
\NewDocumentCommand{\achievementbadge}{mmm}{%
  \par\noindent
  \begin{tcolorbox}[
    colback=cvPrimaryLight,
    colframe=achievementGold,
    boxrule=\cvborderwidth,
    arc=2mm
  ]
  \raggedright\textbf{#2}\ {#1}\hfill{\color{achievementGold}#3}
  \end{tcolorbox}
}

% Enhanced skill tree node with ATS support
\newcounter{skillcount}
\NewDocumentCommand{\skilltreenode}{mmm}{%
  \stepcounter{skillcount}%
  \par\noindent
  \begin{tcolorbox}[
    colback=cvPrimaryLight,
    colframe=skillGreen,
    boxrule=\cvborderwidth,
    arc=2mm,
    title={\BeginAccSupp{method=escape,ActualText={Skill: #1, Level #2: #3}}%
           \raggedright\textbf{#1}\EndAccSupp{}},
    lowerbox=visible,
    bicolor,
    colbacklower=white,
    fontlower=\color{cvText}
  ]
  \tikz[overlay,remember picture]\node[inner sep=0pt](skill-\number\value{skillcount}){};%
  \raggedright\small Level #2: #3
  \end{tcolorbox}
}

% Connect skills in skill tree
\newcommand{\connectskills}[2]{%
  \begin{tikzpicture}[overlay,remember picture]
    \path (skill-\number\value{skillcount}) -- ++(0,-1);
  \end{tikzpicture}%
}

% Marketing stats display
\NewDocumentCommand{\marketingstats}{mmmmmmmm}{%
  \noindent
  \begin{tcolorbox}[
    colback=cvPrimaryLight,
    colframe=cvPrimary,
    boxrule=\cvborderwidth,
    arc=2mm,
    width=\linewidth
  ]
  \begin{minipage}[t]{0.48\linewidth}
    \raggedright
    \powerstat{{\color{cvText}Campaign Power}}{#1}{#2}\par
    \powerstat{{\color{cvText}Audience Reach}}{#3}{#4}
  \end{minipage}\hfill
  \begin{minipage}[t]{0.48\linewidth}
    \raggedright
    \powerstat{{\color{cvText}ROI Boost}}{#5}{#6}\par
    \powerstat{{\color{cvText}Brand Impact}}{#7}{#8}
  \end{minipage}
  \end{tcolorbox}
}

% Marketing power stats
\newcommand{\powerstat}[3]{%
    \begin{tcolorbox}[
        colback=cvPrimaryLight,
        colframe=cvPrimary,
        boxrule=\cvborderwidth,
        arc=1mm
    ]
    {\color{cvText}\textbf{#1}}
    \hfill
    {\color{cvPrimary}\textbf{#2}}
    \tcblower
    {\small\color{cvText}#3}
    \end{tcolorbox}
    \vspace{\cvitemvspace}
}

% Enhanced job entry with ATS support
\define@key{jobentry}{company}{\def\jobentry@company{#1}}
\define@key{jobentry}{startdate}{\def\jobentry@startdate{#1}}
\define@key{jobentry}{enddate}{\def\jobentry@enddate{#1}}
\define@key{jobentry}{location}{\def\jobentry@location{#1}}
\define@key{jobentry}{department}{\def\jobentry@department{#1}}
\define@key{jobentry}{remote}[true]{\def\jobentry@remote{#1}}

% Enhanced job entry with comprehensive ATS support
% Enhanced job entry with better ATS while maintaining original style
\newcommand{\jobentry}[2][]{%
  \begingroup
  \setkeys{jobentry}{#1}%
  % Comprehensive ATS block with original styling
  \begin{tcolorbox}[
    colback=cvPrimaryLight,
    colframe=cvPrimary,
    boxrule=\cvborderwidth,
    arc=2mm
  ]
  \BeginAccSupp{method=escape,ActualText={%
    Position: #2%
    \ifx\jobentry@company\undefined\else
      \MessageBreak Company: \jobentry@company%
    \fi
    \ifx\jobentry@startdate\undefined\else
      \MessageBreak Employment Period: \jobentry@startdate%
      \ifx\jobentry@enddate\undefined\else
        \ - \jobentry@enddate%
      \fi
    \fi
    \ifx\jobentry@location\undefined\else
      \MessageBreak Location: \jobentry@location%
    \fi
    \ifx\jobentry@department\undefined\else
      \MessageBreak Department: \jobentry@department%
    \fi
    \ifx\jobentry@remote\undefined\else
      \MessageBreak Remote Work: Yes%
    \fi
  }}%
  \normalsize\bfseries#2%
  \par\vspace{\cvitemvspace}%
  \ifx\jobentry@company\undefined\else
    {\small\color{cvText}\jobentry@company}\par
  \fi
  \ifx\jobentry@startdate\undefined\else
    {\small\color{cvText}\faCalendar*\ \jobentry@startdate%
    \ifx\jobentry@enddate\undefined\else\ -- \jobentry@enddate\fi}\par
  \fi
  \ifx\jobentry@location\undefined\else
    {\small\color{cvText}\faMapMarker*\ \jobentry@location}\par
  \fi
  \ifx\jobentry@department\undefined\else
    {\small\color{cvText}\faBriefcase\ \jobentry@department}\par
  \fi
  \ifx\jobentry@remote\undefined\else
    {\small\color{cvText}\faLaptop\ Remote Work}\par
  \fi
  \EndAccSupp{}
  \end{tcolorbox}
  \vspace{\cvitemvspace}%
  \endgroup
}

% Original statbar definition
\newcommand{\statbar}[2]{%
  \par\noindent
  \BeginAccSupp{method=escape,ActualText={#1: #2 percent}}%
  {\mdseries\color{cvText}#1}\par
  \vspace{\cvitemvspace}%
  \noindent%
  \begin{tikzpicture}
    \fill[cvPrimaryLight] (0,0) rectangle (\cvskillbarwidth,0.25);
    \fill[cvPrimary] (0,0) rectangle ({min(\cvskillbarwidth,(\cvskillbarwidth)*#2/100)},0.25);
    \node[anchor=west,font=\small,inner sep=\cvboxpadding] 
         at (\cvskillbarwidth,0.125) {%
      \color{cvText}\ifnum#2>100 100\else#2\fi\%};
  \end{tikzpicture}\EndAccSupp{}\par
  \vspace{\cvitemvspace}%
}

% Updated statbar to use flexible dimensions (Redefinition)
\renewcommand{\statbar}[2]{%
  \par\noindent
  \BeginAccSupp{method=escape,ActualText={#1: #2 percent}}%
  {\mdseries\color{cvText}#1}\par
  \vspace{\cvitemvspace}%
  \noindent%
  \begin{tikzpicture}
    \fill[cvPrimaryLight] (0,0) rectangle (\cvskillbarwidth,0.25);
    \fill[cvPrimary] (0,0) rectangle ({min(\cvskillbarwidth,(\cvskillbarwidth)*#2/100)},0.25);
    \node[anchor=west,font=\small,inner sep=\cvboxpadding] 
         at (\cvskillbarwidth,0.125) {%
      \color{cvText}\ifnum#2>100 100\else#2\fi\%};
  \end{tikzpicture}\EndAccSupp{}\par
  \vspace{\cvitemvspace}%
}

% Original skilldots definition
% Simplify the skill dots design by removing just the enhanced styling
\newcommand{\skilldots}[3][]{%
    \par\noindent%
    \begin{tcolorbox}[
        colback=cvPrimaryLight,
        colframe=cvPrimary,
        boxrule=\cvborderwidth,
        arc=2pt,
        top=\cvboxpadding,
        bottom=\cvboxpadding,
        left=\cvboxpadding,
        right=\cvboxpadding
    ]
    \BeginAccSupp{method=escape,ActualText={Skill: #2, Proficiency Level: #3 out of 5}}%
    \mdseries\color{cvText}#2%
    \hfill%
    \begin{tikzpicture}[baseline]
        \foreach \i in {1,...,5} {%
            \ifnum\i>#3
                \node[circle, fill=cvPrimaryLight, draw=cvPrimary, 
                      minimum size=\cviconsize] at (\i*1.2\cviconsize-\cviconsize, 0) {};
            \else
                % Simplified filled dot
                \node[circle, fill=cvPrimary, draw=cvPrimary, 
                      minimum size=\cviconsize] at (\i*1.2\cviconsize-\cviconsize, 0) {};
            \fi
        }
    \end{tikzpicture}
    \ifx\relax#1\relax\else{\small\color{cvTextLight}\ (#1)}\fi
    \EndAccSupp{}
    \end{tcolorbox}
    \vspace{\cvitemvspace}%
}
% Updated skill dots with flexible spacing (Redefinition)
\renewcommand{\skilldots}[3][]{%
    \par\noindent%
    \begin{tcolorbox}[
        colback=cvPrimaryLight,
        colframe=cvPrimary,
        boxrule=\cvborderwidth,
        arc=2pt,
        top=\cvboxpadding,
        bottom=\cvboxpadding,
        left=\cvboxpadding,
        right=\cvboxpadding
    ]
    \BeginAccSupp{method=escape,ActualText={Skill: #2, Proficiency Level: #3 out of 5}}%
    \mdseries\color{cvText}#2%
    \hfill%
    \begin{tikzpicture}[baseline]
        \foreach \i in {1,...,5} {%
            \ifnum\i>#3
                \node[circle, fill=cvPrimaryLight, draw=cvPrimary, 
                      minimum size=\cviconsize] at (\i*1.2\cviconsize-\cviconsize, 0) {};
            \else
                \node[circle, fill=cvPrimary, draw=cvPrimary, 
                      minimum size=\cviconsize] at (\i*1.2\cviconsize-\cviconsize, 0) {};
            \fi
        }
    \end{tikzpicture}
    \ifx\relax#1\relax\else{\small\color{cvTextLight}\ (#1)}\fi
    \EndAccSupp{}
    \end{tcolorbox}
    \vspace{\cvitemvspace}%
}

% Original @makeaphoto definition
\newcommand{\@makeaphoto}[2]{%
  \begin{minipage}{#1}%
    \if@normalphoto
      \includegraphics[width=\cvphotowidth,keepaspectratio]{#2}%
    \else
      \begin{tikzpicture}
        \path [use as bounding box] (0,0) circle[radius=0.5\cvphotowidth];
        \clip (0,0) circle[radius=0.5\cvphotowidth];
        \node[anchor=center] at (0,0) {%
          \includegraphics[width=1.42857142857\cvphotowidth,
                          height=1.42857142857\cvphotowidth,
                          keepaspectratio]{#2}};
        \draw[cvPrimary, line width=\cvborderwidth] 
             (0,0) circle[radius=0.5\cvphotowidth];
      \end{tikzpicture}%
    \fi%
  \end{minipage}%
}

% Updated photo handling with flexible dimensions (Redefinition)
\renewcommand{\@makeaphoto}[2]{%
  \begin{minipage}{#1}%
    \if@normalphoto
      \includegraphics[width=\cvphotowidth,keepaspectratio]{#2}%
    \else
      \begin{tikzpicture}
        \path [use as bounding box] (0,0) circle[radius=0.5\cvphotowidth];
        \clip (0,0) circle[radius=0.5\cvphotowidth];
        \node[anchor=center] at (0,0) {%
          \includegraphics[width=1.42857142857\cvphotowidth,
                          height=1.42857142857\cvphotowidth,
                          keepaspectratio]{#2}};
        \draw[cvPrimary, line width=\cvborderwidth] 
             (0,0) circle[radius=0.5\cvphotowidth];
      \end{tikzpicture}%
    \fi%
  \end{minipage}%
}

% Enhanced section titles with ATS support
\newcommand{\sectiontitle}[2]{%
  \vspace{\cvsectionvspace}%
  \begin{tcolorbox}[
    empty,
    boxrule=0pt,
    left=0pt,
    right=0pt,
    top=0pt,
    bottom=0pt
  ]
  \BeginAccSupp{method=escape,ActualText={Section Header: #2}}%
  \noindent
  {\normalfont%
    % Icon with its own text alternative
    \BeginAccSupp{method=escape,ActualText={Section icon}}%
    {\color{cvAccent}\small\faIcon{#1}}%
    \EndAccSupp{}%
    \hspace{\cvboxpadding}%
    % Section title
    {\color{cvPrimaryDark}\large\bfseries#2}%
  }%
  \EndAccSupp{}
  \end{tcolorbox}%
  % Underline with proper spacing
  \noindent\textcolor{cvBorder}{\rule{\linewidth}{\cvborderwidth}}\par
  \vspace{\cvitemvspace}%
}

% Description list
\newenvironment{jobdescription}{%
  \begin{itemize}[
    leftmargin=1.2em,
    rightmargin=0pt,
    itemsep=\cvitemvspace,
    parsep=0pt,
    topsep=\cvitemvspace,
    partopsep=0pt,
    label={\color{cvPrimary}$\bullet$}
  ]
}{%
  \end{itemize}%
  \vspace{\cvitemvspace}%
}

% Personal information commands
\def\cvname{}
\def\cvjobtitle{}
\def\cvlevel{}
\def\cvalignment{}
\def\cvtagline{}
\def\cvemail{}
\def\cvphone{}
\def\cvgithub{}
\def\cvlinkedin{}
\def\cvlocation{}
\def\cvphoto{profile-placeholder.png}

\newcommand{\name}[1]{\def\cvname{#1}}
\newcommand{\jobtitle}[1]{\def\cvjobtitle{#1}}
\newcommand{\level}[1]{\def\cvlevel{#1}}
\newcommand{\alignment}[1]{\def\cvalignment{#1}}
\newcommand{\tagline}[1]{\def\cvtagline{#1}}

% Contact information with accessibility
\newcommand{\email}[1]{%
    \def\cvemail{%
        \BeginAccSupp{method=escape,ActualText={Email: #1}}%
        {\normalfont\BeginAccSupp{method=escape,ActualText={Email icon}}\faEnvelope\EndAccSupp{}}%
        \hspace{\cvboxpadding}\href{mailto:#1}{\texttt{#1}}%
        \EndAccSupp{}%
    }%
}

\newcommand{\phone}[1]{%
    \def\cvphone{%
        \BeginAccSupp{method=escape,ActualText={Phone: #1}}%
        {\normalfont\BeginAccSupp{method=escape,ActualText={Phone icon}}\faPhone\EndAccSupp{}}%
        \hspace{\cvboxpadding}\texttt{#1}%
        \EndAccSupp{}%
    }%
}

\newcommand{\github}[1]{%
    \def\cvgithub{%
        \BeginAccSupp{method=escape,ActualText={GitHub profile: #1}}%
        {\normalfont\BeginAccSupp{method=escape,ActualText={GitHub icon}}\faGithub\EndAccSupp{}}%
        \hspace{\cvboxpadding}\href{https://github.com/#1}{\texttt{#1}}%
        \EndAccSupp{}%
    }%
}

\newcommand{\linkedin}[1]{%
    \def\cvlinkedin{%
        \BeginAccSupp{method=escape,ActualText={LinkedIn profile: #1}}%
        {\normalfont\BeginAccSupp{method=escape,ActualText={LinkedIn icon}}\faLinkedin\EndAccSupp{}}%
        \hspace{\cvboxpadding}\href{https://linkedin.com/in/#1}{\texttt{#1}}%
        \EndAccSupp{}%
    }%
}

\newcommand{\location}[1]{%
    \def\cvlocation{%
        \BeginAccSupp{method=escape,ActualText={Location: #1}}%
        \faMapMarker*\ #1%
        \EndAccSupp{}%
    }%
}

% Error handling for required fields
\newcommand{\@checkrequired}[2]{%
  \ifcsname cv#1\endcsname
    \ifx\@empty\csname cv#1\endcsname
      \PackageError{gamifiedcv}{%
        Field `\@backslashchar #1` is empty%
      }{%
        Please provide a value for #2 using `\@backslashchar #1{...}`%
      }%
    \fi
  \else
    \PackageError{gamifiedcv}{%
      Field `\@backslashchar #1` is required but not defined%
    }{%
      Please define #2 using `\@backslashchar #1{...}`%
    }%
  \fi
}

% Photo handling with validation
\newcommand{\photo}[2][3.5cm]{%
  \IfFileExists{#2}{%
    \def\cvphoto{#2}%
  }{%
    \PackageWarning{gamifiedcv}{Photo file `#2` not found, using placeholder}%
    \def\cvphoto{profile-placeholder.png}%
  }%
  \setcvdimension{photowidth}{#1}
}

% Original makeheader definition
\newcommand{\makeheader}{%
  \begingroup
  \@checkrequired{name}{your name}
  \@checkrequired{jobtitle}{your job title}
  \begin{minipage}[t]{\dimexpr\linewidth-\cvphotowidth-\cvphotosep\relax}
    \raggedright
    \vspace{-2\baselineskip}
    {\fontsize{24}{29}\selectfont\color{cvText}\cvname}\par
    \vspace{\cvitemvspace}
    {\color{cvAccent}\large\cvjobtitle}\par
    \vspace{\cvitemvspace}
    {\small\color{cvTextLight}%
      \ifx\cvemail\empty\else\cvemail\hspace{\cvphotosep}\fi
      \ifx\cvphone\empty\else\cvphone\hspace{\cvphotosep}\fi
      \ifx\cvlocation\empty\else\cvlocation\hspace{\cvphotosep}\fi
      \ifx\cvgithub\empty\else\cvgithub\hspace{\cvphotosep}\fi
      \ifx\cvlinkedin\empty\else\cvlinkedin\fi
    }\par
    \vspace{\cvitemvspace}%
    {\small\color{cvTextLight}%
      \ifx\cvlevel\empty\else\cvlevel\ $\cdot$\ \fi
      \ifx\cvalignment\empty\else\textit{\cvalignment}\ $\cdot$\ \fi
      \ifx\cvtagline\empty\else\textit{\cvtagline}\fi
    }
  \end{minipage}\hfill%
  \@makeaphoto{\cvphotowidth}{\cvphoto}%
  \par\vspace{\cvitemvspace}
  \noindent\rule{\linewidth}{\cvborderwidth}\par
  \vspace{\cvitemvspace}
  \endgroup
}

% Updated header with flexible dimensions (Redefinition)
\renewcommand{\makeheader}{%
  \begingroup
  \@checkrequired{name}{your name}
  \@checkrequired{jobtitle}{your job title}
  \begin{minipage}[t]{\dimexpr\linewidth-\cvphotowidth-\cvphotosep\relax}
    \raggedright
    \vspace{-2\baselineskip}
    {\fontsize{24}{29}\selectfont\color{cvText}\cvname}\par
    \vspace{\cvitemvspace}
    {\color{cvAccent}\large\cvjobtitle}\par
    \vspace{\cvitemvspace}
    {\small\color{cvTextLight}%
      \ifx\cvemail\empty\else\cvemail\hspace{\cvphotosep}\fi
      \ifx\cvphone\empty\else\cvphone\hspace{\cvphotosep}\fi
      \ifx\cvlocation\empty\else\cvlocation\hspace{\cvphotosep}\fi
      \ifx\cvgithub\empty\else\cvgithub\hspace{\cvphotosep}\fi
      \ifx\cvlinkedin\empty\else\cvlinkedin\fi
    }\par
    \vspace{\cvitemvspace}%
    {\small\color{cvTextLight}%
      \ifx\cvlevel\empty\else\cvlevel\ $\cdot$\ \fi
      \ifx\cvalignment\empty\else\textit{\cvalignment}\ $\cdot$\ \fi
      \ifx\cvtagline\empty\else\textit{\cvtagline}\fi
    }
  \end{minipage}\hfill%
  \@makeaphoto{\cvphotowidth}{\cvphoto}%
  \par\vspace{\cvitemvspace}
  \noindent\rule{\linewidth}{\cvborderwidth}\par
  \vspace{\cvitemvspace}
  \endgroup
}

% Hyperref setup
\if@withhyper
    \RequirePackage[
        colorlinks=true,
        linkcolor=cvAccent,
        filecolor=cvAccent,
        urlcolor=cvAccent,
        pdftitle={Curriculum Vitae},
        pdftoolbar=true,
        pdfmenubar=true,
        pdfstartview=FitH,
        bookmarksopen=true,
        bookmarksnumbered=true,
        pdfpagemode=UseOutlines,
        unicode
    ]{hyperref}
\fi

% New ATS keywords command
\newcommand{\atskeywords}[1]{%
  \BeginAccSupp{method=escape,ActualText={Keywords: #1}}%
  \phantom{#1}%
  \EndAccSupp{}%
}

% PDF metadata
\AtBeginDocument{%
  \hypersetup{
    pdfauthor={\cvname},
    pdftitle={Curriculum Vitae - \cvname},
    pdfsubject={Curriculum Vitae},
    pdfcreator={LaTeX with gamifiedcv class}
  }%
  % Check required fields
  \@checkrequired{name}{your name}
}

% Page style
\pagestyle{empty}

% Premium version link
\AtEndDocument{%
  \vspace{2em}%
  \begin{center}
    \begin{tcolorbox}[
      colback=cvPrimaryLight,
      colframe=achievementGold,
      boxrule=\cvborderwidth,
      arc=2mm,
      width=0.8\linewidth
    ]
    {\color{cvText}Want more features? Check out the}
    \href{https://www.etsy.com/listing/1858429103/professional-gamified-latex-resume}{Premium Version}
    {\color{cvText}with multiple themes, enhanced gamification, and advanced features!}
    \end{tcolorbox}
  \end{center}
}

\endinput