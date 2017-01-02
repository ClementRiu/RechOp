\ProvidesClass{rapport}
\LoadClassWithOptions{article}


\usepackage[utf8]{inputenc}					% gestion des accents (source)
\usepackage[T1]{fontenc}					% gestion des accents (PDF)
\usepackage[frenchb]{babel}				    % gestion du français
\usepackage{stmaryrd}						% symboles supplémentaires
\usepackage{csquotes}
\usepackage[colorlinks=true,pdfmenubar=false,pdfpagemode=UseNone,urlcolor=black,linkcolor=black,citecolor=black,filecolor=black,pdfstartview=FitH]{hyperref}

\usepackage{textcomp}						% caractères additionnels
\usepackage{mathtools,amssymb,amsthm}		% packages de l'AMS + mathtools
\usepackage{siunitx}
\usepackage{stmaryrd}
\usepackage{bm}

\usepackage{geometry}						% gestion des marges
\geometry{top=3cm, bottom=3cm, left=2.5cm, right=2.5cm}

\usepackage{graphicx}						% gestion des images
\usepackage{xcolor}							% gestion des couleurs
\usepackage{array}							% gestion améliorée des tableaux
\usepackage{multirow}						% gestion améliorée des colonnes

\usepackage[framemethod=tikz]{mdframed}		% mise en page
\usepackage{calc}							% syntaxe naturelle pour les calculs
\usepackage[pagestyles]{titlesec}			% pour les sections
\usepackage{titletoc}						% pour la table des matières
\usepackage{fancyhdr}						% pour les en-têtes
\usepackage{wrapfig}
\usepackage{listings}
\usepackage{enumitem}
\setlist[itemize]{label=$\bullet$}
\usepackage{smartdiagram}


\edef\restoreparindent{\parindent=\the\parindent\relax}
\usepackage{parskip}
\restoreparindent

% tracer des courbes
\usepackage{tikz, pgf}
\usepackage{tikz-3dplot}
\usepackage{tkz-euclide}
\usepackage{pgfplots}
\usepackage{pgfplotstable}
\pgfplotsset{compat=1.8}
\pgfplotsset{every axis legend/.append style={
	at = {(0.5,1.03)},
    anchor = south}
}
\newlength\figureheight
\newlength\figurewidth
\setlength\figureheight{8cm}
\setlength\figurewidth{13cm}

\newpagestyle{main}{
  \sethead{}
    {\sectiontitle}
    {}
	\setfoot{}
		{\thepage}
		{}
}

\pagestyle{main}

\author{Clément \textsc{Riu} et Anne \textsc{Spitz}}

% newcommand
\renewcommand{\P}{\mathbf{P}}
\newcommand{\E}{\mathbf{E}}
\newcommand{\N}{\mathbf{N}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\C}{\mathbf{C}}
\newcommand{\Z}{\mathbf{Z}}

% environments
\theoremstyle{plain}
\newtheorem{question}{Question}

\theoremstyle{definition}
\newtheorem{exo}{Exercice}


\definecolor{mygreen}{rgb}{0,0.6,0}
\definecolor{mygray}{rgb}{0.96,0.96,0.96}
\definecolor{mymauve}{rgb}{0.58,0,0.82}
\definecolor{myorange}{HTML}{8B5300}
\definecolor{mymagenta}{HTML}{BC5A65}
\definecolor{myazur}{HTML}{317ECC}
\definecolor{mylightdark}{HTML}{4E4E4E}

\lstset{
  backgroundcolor=\color{mygray},
  language=Python,
  basicstyle=\footnotesize\ttfamily\color{mylightdark},        % size of fonts used for the code
  xleftmargin=0.25in,
  xrightmargin=0.25in,
  breaklines=true,                 % automatic line breaking only at whitespace
  captionpos=b,                    % sets the caption-position to bottom
  keywordstyle=\color{mymagenta},       % keyword style
  commentstyle=\color{mygreen},    % comment style
  escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
  stringstyle=\color{myazur},     % string literal style
}
