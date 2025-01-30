% !TeX encoding = UTF-8
\ProvidesClass{mni-thm-exam}

\newcommand{\examLanguage}{german} % Default to English
\DeclareOption{german}{\renewcommand{\examLanguage}{german}}
\DeclareOption{english}{\renewcommand{\examLanguage}{english}}
\ProcessOptions\relax

\LoadClass[12pt,oneside,a4paper]{scrartcl}

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}

\RequirePackage{xparse}
\RequirePackage{totcount}
\RequirePackage[ngerman]{babel}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{lmodern}
\RequirePackage{fancyhdr}
\RequirePackage{xifthen}

\RequirePackage{color}
\RequirePackage[dvipsnames, svgnames]{xcolor}
\RequirePackage{framed}
\RequirePackage{lastpage} 
\RequirePackage{url}
\RequirePackage[ddmmyyyy]{datetime}
\renewcommand{\dateseparator}{.}
\RequirePackage{fontawesome}
\RequirePackage{forloop}

\RequirePackage{pgffor}
\def\Step{0.5cm}
\def\MyDot{\scalebox{1}{\color{lightgray}.}}
\def\Dotbox{\hbox to \Step{\smash{\MyDot}\hfil}}
\def\DotPattern{%
	\hbox to \hsize{\leaders\Dotbox\hfill}\kern-.4mm
	
	\vbox to \Step{\offinterlineskip\leaders\hbox to \paperwidth{\leaders\Dotbox\hfill}\vfill}
	
	\nointerlineskip\hbox to \hsize{\leaders\Dotbox\hfill}%
}
\newcounter{loopCounter}
\newcommand{\writingSpace}[1]{%
\forloop{loopCounter}{0}{\value{loopCounter}<#1}{\DotPattern}
\setcounter{loopCounter}{0}
}
\RequirePackage{listings}

% Kopf- und Fußzeile
\pagestyle{fancy}
\fancyhf{}

\fancyhead[L]{\@subject  \setlength{\headsep}{6cm}}
\fancyfoot[R]{\thepage{} / \pageref{LastPage}}

% Sep line top and bottom
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0.5pt}

% Parameters
\def\@examiner{No docent set}
\newcommand{\examiner}[1]{
  \def\@examiner{#1}
}

\def\@coExaminer{No docent set}
\newcommand{\coExaminer}[1]{
  \def\@coExaminer{#1}
}

\def\@semester{No cohort set}
\newcommand{\semester}[1]{
  \def\@semester{#1}
}

\def\@degreeProgram{}
\newcommand{\degreeProgram}[1]{
  \def\@degreeProgram{#1}
}

\def\@logo{}
\newcommand{\logo}[2][height=44bp]{
  \def\@logo{\includegraphics[#1]{#2}}
}

\def\@notice{}
\newcommand{\notice}[1]{
  \def\@notice{#1}
}


% Set geometry of pages
\RequirePackage[left=2.5cm,right=2.5cm,top=2cm,bottom=3cm,includeheadfoot]{geometry}
\geometry{headheight=72pt, headsep=1cm}

\RequirePackage{array}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}

% Title page
\newcommand{\TitlePage}{%
\begin{titlepage}
	\centering
	\@logo
	\vfill
	{\large \@title} \\
	\vspace{1cm}
	{\Large \@subject}
	\vfill
	\@date
	\vfill
	
	\@notice
	
	\vfill
	
	\begin{table}[h]
		\centering
		\begin{tabular}{|r|p{8cm}|p{1cm}}
			\cline{1-2}
			\ifthenelse{\equal{\examLanguage}{german}}{Name}{Last name}
			& & $\leftarrow$ \faPencil\\
			\cline{1-2}
			\ifthenelse{\equal{\examLanguage}{german}}{Vorname}{First name}
			& & $\leftarrow$ \faPencil\\
			\cline{1-2}
			\ifthenelse{\equal{\examLanguage}{german}}{Mat.Nr.}{Mat.Nr.}
			& & $\leftarrow$ \faPencil\\
			\cline{1-2}
			\ifthenelse{\equal{\examLanguage}{german}}{Studiengang}{Degree program} 
			& \@degreeProgram &
			\ifx\@degreeProgram\@empty
        		$\leftarrow$ \faPencil
    		\else
    		\fi
			\\
			\cline{1-2}
			\ifthenelse{\equal{\examLanguage}{german}}{Prüfer}{Examiner} 
			& \@examiner \\
			\cline{1-2}
			\ifthenelse{\equal{\examLanguage}{german}}{Zweitprüfer}{Co-examiner} 
			& \@coExaminer \\
			\cline{1-2}
			\ifthenelse{\equal{\examLanguage}{german}}{Semester}{Semester} 
			& \@semester\\
			\cline{1-2}
		\end{tabular}
	\end{table}
	
	\vspace*{\fill}
	
	\ifthenelse{\equal{\examLanguage}{german}}{Vom Prüfer auszufüllen.}{To be completed by the examiner.} 
	
	\newcounter{x}
	\begin{table}[h]
		\centering
		\begin{tabular}{|c||*{\totvalue{topicNr}}{C{0.7cm}|}|c|}
			\hline
			\ifthenelse{\equal{\examLanguage}{german}}{Thematik}{Topic} & 
			\forloop
				{x}
				{1}
				{\value{x} < \numexpr\totvalue{topicNr}+1}
				{\arabic{x} &} 
			$\sum$\\
			\hline
			\hline
			\ifthenelse{\equal{\examLanguage}{german}}{Punkte Gesamt}{Total points} &
			\forloop
				{x}
				{1}
				{\value{x} < \numexpr\totvalue{topicNr}+1}
				{\total{totalPoints\arabic{x}} &} 
			\total{totalPoints} \\
			\hline
			\ifthenelse{\equal{\examLanguage}{german}}{Punkte Erreicht}{Points achieved} & 
			\forloop
				{x}
				{1}
				{\value{x} < \numexpr\totvalue{topicNr}+1}
				{&} 
			\\
			\hline
		\end{tabular}
	\end{table}
	
	\vfill
\end{titlepage}
\newpage
}

% Schusterjungen und Hurenkinder vermeiden
\clubpenalty = 10000
\widowpenalty = 10000
\displaywidowpenalty = 10000

% task definition
\newcounter{topicNr}
\newcounter{taskNr}
\newcounter{subTaskNr}

\setcounter{topicNr}{0}
\setcounter{taskNr}{1}
\setcounter{subTaskNr}{1}

\regtotcounter{topicNr}

\newcounter{totalPoints}
\setcounter{totalPoints}{0}
\regtotcounter{totalPoints}

%setup some counters since loops do not work
\newtotcounter{totalPoints1}
\newtotcounter{totalPoints2}
\newtotcounter{totalPoints3}
\newtotcounter{totalPoints4}
\newtotcounter{totalPoints5}
\newtotcounter{totalPoints6}
\newtotcounter{totalPoints7}
\newtotcounter{totalPoints8}
\newtotcounter{totalPoints9}
\newtotcounter{totalPoints10}
\newtotcounter{totalPoints11}
\newtotcounter{totalPoints12}
\newtotcounter{totalPoints13}
\newtotcounter{totalPoints14}
\newtotcounter{totalPoints15}
\newtotcounter{totalPoints16}
\newtotcounter{totalPoints17}

\newcommand{\topic}[1]{%
	\stepcounter{topicNr}
	\section*{\arabic{topicNr} #1}
	\label{a\arabic{topicNr}}
	\setcounter{taskNr}{0}
	\setcounter{subTaskNr}{0}
}

\NewDocumentCommand{\task}{O{0} O{0} m}{%
    \noindent%
	\paragraph*{\arabic{topicNr}.\arabic{taskNr}\marginpar{\setlength{\fboxrule}{0pt}\fbox{\textbf{#2P}}}}
	\stepcounter{taskNr}
	\setcounter{subTaskNr}{0}
	{#3}
	\ifthenelse{\equal{#1}{0}}{}{\\ \writingSpace{#1}}
	\addtocounter{totalPoints\arabic{topicNr}}{#2}
	\addtocounter{totalPoints}{#2}
}

\newcommand{\subtask}[2][0]{%
	\subparagraph*{\alph{subTaskNr})}
	\stepcounter{subTaskNr}
	{#2} 
	\ifthenelse{\equal{#1}{0}}{}{\\ \writingSpace{#1}}
}


\RequirePackage{listings}
\makeatletter
\newcommand\BeraMonottfamily{%
  \def\fvm@Scale{0.85}% scales the font down
  \fontfamily{fvm}\selectfont% selects the Bera Mono font
}
\makeatother

\lstset{
    basicstyle=\ttfamily\footnotesize, % Font style
    keywordstyle=\color{blue}\bfseries, % Keywords (e.g., public, static, class)
    keywordstyle=[2]\color{cyan},      % Functions (e.g., main, print)
    keywordstyle=[3]\color{teal},      % Special words (like "this", "super")
    keywordstyle=[4]\color{violet},    % Primitive types (int, boolean, etc.)
    commentstyle=\color{gray},
    stringstyle=\color{ForestGreen},
    identifierstyle=\color{black},
    backgroundcolor=\color{white},
    frame=single,
    numbers=left,
    numberstyle=\tiny\color{gray},
    stepnumber=1,
    breaklines=true,
    tabsize=4,
    showstringspaces=false,
}

\lstdefinelanguage{JS}{
    keywords={break, case, catch, continue, debugger, default, delete, do, else, finally, for, function, if, in, instanceof, new, return, switch, throw, try, typeof, var, void, while, with, let, const, class, extends, super, export, import, yield, async, await, static, readonly, public, private, protected, abstract, implements, interface, enum, namespace, declare, module, as, from, of},
    morekeywords=[2]{true,false,null,undefined,NaN,Infinity,this},
    morekeywords=[3]{console,window,document,global,require,module,exports,setTimeout,setInterval,clearTimeout,clearInterval,Promise,Object,Array,Map,Set,Date,RegExp,Error,JSON,Math,Symbol},
    morekeywords=[4]{string,number,boolean,any,unknown,void,never,object,readonly,instanceof},
    sensitive=true,
    comment=[l]{//},                    % Single-line comments
    morecomment=[s]{/*}{*/},            % Multi-line comments
    morestring=[b]',                    % Strings in single quotes
    morestring=[b]",                    % Strings in double quotes
    morestring=[b]`                     % Template literals
}

\lstdefinelanguage{TS}{
    keywords={break, case, catch, continue, debugger, default, delete, do, else, finally, for, function, if, in, instanceof, new, return, switch, throw, try, typeof, var, void, while, with, let, const, class, extends, super, export, import, yield, async, await, static, readonly, public, private, protected, abstract, implements, interface, enum, namespace, declare, module, as, from, of, type},
    morekeywords=[2]{true,false,null,undefined,NaN,Infinity,this},
    morekeywords=[3]{console,window,document,global,require,module,exports,setTimeout,setInterval,clearTimeout,clearInterval,Promise,Object,Array,Map,Set,Date,RegExp,Error,JSON,Math,Symbol},
    morekeywords=[4]{string,number,boolean,any,unknown,void,never,object,readonly,instanceof},
    morekeywords=[5]{keyof, infer, extends, constructor, async, await},
    sensitive=true,
    comment=[l]{//},                    % Single-line comments
    morecomment=[s]{/*}{*/},            % Multi-line comments
    morestring=[b]',                    % Strings in single quotes
    morestring=[b]",                    % Strings in double quotes
    morestring=[b]`                     % Template literals
}

\lstdefinelanguage{HTML}{
    sensitive=true,
    morekeywords={html, head, title, meta, link, style, script, body, div, span, p, h1, h2, h3, h4, h5, h6, a, img, ul, ol, li, table, tr, td, th, thead, tbody, tfoot, form, input, button, label, select, option, textarea, nav, section, article, aside, footer, header, main, figure, figcaption, video, audio, source, canvas, iframe, svg, path, g, circle, rect, animate, use},
    morekeywords=[2]{class, id, href, src, alt, style, rel, type, name, content, charset, http-equiv, action, method, value, placeholder, required, disabled, readonly, checked, multiple, target, download, autoplay, controls, loop, muted, width, height, defer, async, crossorigin},
    comment=[s]{<!--}{-->},            % HTML comments
    morestring=[b]",                    % Strings in attributes
    morestring=[b]',
}

\lstdefinelanguage{CSS}{
    sensitive=true,
    morekeywords={color, background, border, margin, padding, font, font-size, font-weight, text-align, text-decoration, line-height, width, height, display, position, top, bottom, left, right, flex, grid, align-items, justify-content, opacity, visibility, overflow, box-shadow, transform, transition, animation, content, cursor, z-index, clip-path},
    morekeywords=[2]{px, em, rem, vh, vw, \%, deg, s, ms, auto, none, block, inline, flex, grid, relative, absolute, fixed, sticky, static},
    morekeywords=[3]{important, inherit, initial, unset},
    comment=[s]{/*}{*/},                % CSS comments
    morestring=[b]",                     % Strings in properties
    morestring=[b]'                      % Strings in properties
}
