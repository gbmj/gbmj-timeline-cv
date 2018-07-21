%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gbmj's timeline cv –- a graphical life-story resume
% LaTeX Template – class file
% Compile with XeLaTeX or LuaTeX
% Version 1.0 (30/7/2018)
% Shared under GPLv3
%
% AUTHOR
% ======
% Grayson Morris (http://www.graysonbraymorris.com)
% https://github.com/gbmj/gbmj-timeline-cv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ProvidesClass{gbmj-timeline-cv}[2018/07/30 graphical timeline resume class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption*{% this lets you use options like a4paper, letterpaper, etc that are defined by the article class
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Global package imports
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage[hidelinks]{hyperref}    % to get rid of the awful blue boxes around links
\usepackage{ulem}                   % for dotted underlines
\usepackage{lastpage}               % for the "of y" in "page x of y"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% General formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{empty} % empty the header and footer; we'll put the info in a tcolorbox instead

\newcommand{\sbvsep}[1]{\vspace{#1}\\} % space to separate sections in sideboxes
\newcommand{\sbhsep}[1]{\hspace{#1}}    % horizontal space (not currently used)
\newcommand{\duhref}[2]{\href{#1}{\dotuline{#2}} } % make links show as dotted underlines

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define document colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage[]{xcolor}    % try the luatex option if you're compiling with LuaLaTeX and have color problems
% Manual:   http://mirror.koddos.net/CTAN/macros/latex/contrib/xcolor/xcolor.pdf
%%%%%%
\definecolor{accent}{HTML}{1D824C} 
\definecolor{primary}{HTML}{000000} 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set document fonts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{fontspec}    % to use openfont fonts            
% Manual:   http://tug.ctan.org/tex-archive/macros/latex/contrib/fontspec/fontspec.pdf
%%%%%%
\defaultfontfeatures{Ligatures=TeX} % for the usual TeX shortcuts (`` left quote, --- m-dash, etc)

%%%%%% set the default font to fall back on when no other has been specified. We'll use this font for the objective, personal, and story boxes.
\setmainfont[Color=primary, Path = fonts/lato/,
    BoldFont=Lato-Bol,
    ItalicFont=Lato-LigIta,
    BoldItalicFont=Lato-BolIta]{Lato-Lig}

%%%%%% the template uses one accent color (which you can change above), five font sizes, and four font weights to provide textual variety and emphasis.
\newcommand{\fonttn}{\fontsize{8pt}{10pt}} % built-in command: footnotesize
\newcommand{\fontsm}{\fontsize{9pt}{11pt}} % built-in command: small
\newcommand{\fontmd}{\fontsize{10pt}{12pt}} % built-in command: normalsize
\newcommand{\fontlg}{\fontsize{11pt}{11pt}}
\newcommand{\fontgi}{\fontsize{14pt}{14pt}} % not quite the "Large" built-in command

\newcommand{\thinf}{\fontspec[Path = fonts/raleway/, ItalicFont=Raleway-ThinItalic]{Raleway-Thin}} % only used for first-page header
\newcommand{\lightf}{\fontspec[Path = fonts/raleway/, ItalicFont=Raleway-LightItalic]{Raleway-Light}}
\newcommand{\mediumf}{\fontspec[Path = fonts/raleway/, ItalicFont=Raleway-Italic]{Raleway-Regular}}
\newcommand{\heavyf}{\fontspec[Path = fonts/raleway/, ItalicFont=Raleway-MediumItalic]{Raleway-Medium}}


%%% Keywords: regular shape, heavier weight, regular color (inherits size)
\newcommand{\cvkeyword}[1]{{\mediumf \selectfont \textcolor{primary}{#1} }}

%%% Highlights: small caps, heaviest weight, accent color (inherits size)
\newcommand{\cvhilite}[1]{{\heavyf \scshape \selectfont \textcolor{accent}{#1} }}

%%% Categories: small caps, heaviest weight, regular color (inherits size)
\newcommand{\cvcategory}[1]{{\heavyf \scshape \selectfont \textcolor{primary}{#1} }}

%%% Category answers: regular shape, regular weight, regular color 
% this one's a little hacky. I found that the "answers" to the right of a category look better in a lighter font, but one size smaller.
\newcommand{\cvanswer}[1]{{\lightf \fontsm \selectfont \textcolor{primary}{#1} }}

%%%%%% Posterbox default fonts
%%% these don't need \selectfont or an argument; the posterbox command handles that
%%% default box: small caps, heavier weight, largest size, regular color
\newcommand{\defboxtitlefont}{\color{primary} \mediumf \fontgi \scshape}

%%% sidebox label: regular shape, heaviest weight, medium size, regular color
\newcommand{\sbtimespanfont}{\color{primary} \heavyf \fontmd}


%%%%%% Sidebox fields
% in general, each of the dashed-outline sideboxes will have a title, subtitle, and description. (You may add other things below those, like a list of patents or relevant keywords)
%%% Title (degree, job, etc): small caps, heaviest weight, larger size, regular color, line break
\newcommand{\sbtitle}[1]{{\heavyf \fontlg \scshape \selectfont \textcolor{primary}{#1 \\} }}

%%% Subtitle (school, company, etc): regular shape, medium weight, medium size, regular color, line break, extra vspace
\newcommand{\sbsubtitle}[1]{{\mediumf \fontmd \selectfont \textcolor{primary}{#1 \\}{\vspace{1mm}} }}

%%% Description: regular shape, lightest weight, smallest size, regular color
% no line break, or compiler will complain when it's the last field in a posterbox. Use \sbvsep to add vspace if needed
\newcommand{\sbdescrip}[1]{\lightf \fonttn \selectfont \textcolor{primary}{#1}}


%%%%%% Paper/patent listings
%%% Highlight your name amid all the authors: heavier weight, accent color
\newcommand{\gauthor}[1]{{\mediumf \selectfont \textcolor{accent}{#1}}}

%%% Link paper / patent title to an online source; heavier font weight than author list & dotted underline
% Use: \ptitle{<url>}{<link text>}
\newcommand{\ptitle}[2]{
{\mediumf \selectfont \duhref{#1}{#2} }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define headerboxes, infoboxes, and storyboxes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage[poster]{tcolorbox}
% Manuals:  https://mirror.hmc.edu/ctan/macros/latex/contrib/tcolorbox/tcolorbox.pdf
%           http://mirror.hmc.edu/ctan/macros/latex/contrib/tcolorbox/tcolorbox-tutorial-poster.pdf
\usepackage{tikz}
\usetikzlibrary{shapes,decorations.shapes}  % for the chevrons in the futurebox
% Manual:   http://mirror.koddos.net/CTAN/graphics/pgf/base/doc/pgfmanual.pdf
%%%%%%%%%%%%%%%%%%%%%%%%
% Headerbox (posterbox with no frame, no title)
% specify standard posterbox arguments (name, column, row, etc) in argument #1
% arguments #2-#6 can be anything you like, but #5 will be wrapped in a mailto: command so it's kind of handy if it's an actual email address :)
% 
%%%%%%%%%%%%%%%%%%%%%%%%
% Page 1 use:
% \headerbox{<usual posterbox name and location options}{<first name>}{<last name>}{<street address> | <city, zip, etc>}{<email address>}{<phone number>}
% Page 2+ use:
% \headerbox{<usual posterbox name and location options}{<first name>}{<last name>}{}{}{}
\newcommand{\headerbox}[6]{
    \posterbox[
        halign=center,  % center box text horizontally
        valign=center,  % center box text vertically
        blanker         % less padding
        ]
        % the unique identifier and positioning params for the posterbox:
        {#1}
        % the posterbox content:
        {
        \ifnum\value{page}=1 
            % print first page header
	        {\thinf\fontsize{40pt}{60pt}\selectfont #2         % your first name (lighter text)     
        	\lightf\fontsize{40pt}{60pt}\selectfont #3         % your last name (heavier text)
            \\[3mm]
            \mediumf\fontsize{11pt}{14pt}\selectfont #4         % your address
            \\
            \duhref{mailto:#5}{#5} |  #6}                       % your email & phone
        \else
            % print subsequent page header ( your name and the page number)
            {\heavyf\fonttn\selectfont \textcolor{accent}{\scshape{#2 #3}}
            \lightf\selectfont | curriculum vitae | page \thepage \hspace{1pt} of \pageref{LastPage}}
        \fi 
        \\
        \rule{\paperwidth}{0.4pt}
        \\
    } % end of posterbox content
} % end of newcommand

%%%%%%%%%%%%%%%%%%%%%%%%
% Photobox (posterbox with no frame, no title, no text)
% specify standard posterbox arguments (name, column, row, etc) in #1
% specify your image file (including path, if not in same directory) in #2
%%%%%%%%%%%%%%%%%%%%%%%%
% Use:
% \photobox{<usual posterbox name and location options>}{<path/imgname>}
\newcommand{\photobox}[2]{
    \posterbox[boxrule=0pt, interior style={fill overzoom image=#2}]{#1}{}
    }

%%%%%%%%%%%%%%%%%%%%%%%%
% Tightbox (posterbox with no frame, less padding)
% specify standard posterbox arguments (name, column, row, etc) in #1
% specify the title text for the box in #2
%%%%%%%%%%%%%%%%%%%%%%%%
% Use:
% \tightbox{<usual posterbox name and location options>}{<title>}
\newcommand{\tightbox}[2]{
    \posterbox[title=#2, blanker]{#1}
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sidebox formatting (posterbox with chrono-dot, dashed outline, and inset title)
% #1 standard posterbox arguments (name, column, row, etc)
% #2 inset title (year, timespan, word, whatever) – leave empty to suppress graphics
% #3 chrono-dot position, including units (eg, 2cm) – leave empty to suppress graphics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use:
% \sideboxright{<usual posterbox name and location options>}{<title>}{<dot's vertical shift relative to top left corner>}{<your content>}
\newcommand{\sideboxright}[3]{
    \posterbox[
        halign=flush left, % text will be ragged right instead of indented and justified
        % the dashed box frame:
        enhanced,arc=3mm,borderline={1pt}{-2mm}{accent,dashed}, % the -2mm moves the borderline outside the box
        % the inset timespan/year title:
        fonttitle=\sbtimespanfont, attach boxed title to top center={yshift=-1mm}, boxed title style={colback=white}, title=#2,
        % draw the chrono-dot:
        overlay={\foreach \y in {#3} { 
            \begin{scope}[shift={([xshift=-2mm, yshift=-\y]frame.north west)}]
            \path[draw=accent!50!black,fill=accent!80] (0,0) arc (90:270:5mm);
            \end{scope}
            }
        }
        ]
        % the unique identifier and positioning params for the posterbox:
        {#1}
}

% \sideboxleft{<usual posterbox name and location options>}{<title>}{<dot's vertical shift relative to top right corner>}{<your content>}
\newcommand{\sideboxleft}[3]{
    \posterbox[
        halign=flush left, % text will be ragged right instead of indented and justified
        % the dashed box frame:
        enhanced,arc=3mm,borderline={1pt}{-2mm}{accent,dashed},
        % the inset timespan/year title:
        fonttitle=\sbtimespanfont, attach boxed title to top center={yshift=-1mm}, boxed title style={colback=white}, title=#2,
        % draw the chrono-dot:
        overlay={\foreach \y in {#3} {
            \begin{scope}[shift={([xshift=2mm, yshift=-\y]frame.north east)}]
            \path[draw=accent!50!black,fill=accent!80] (0,0) arc (270:450:5mm);
            \end{scope}
            }
        }
        ]
        % the unique identifier and positioning params for the posterbox:
        {#1}
}

% \sideboxbottom{<usual posterbox name and location options>}{<title>}{<dot's horizontal shift relative to top left corner>}{<your content>}
\newcommand{\sideboxbottom}[3]{
    \posterbox[
        halign=flush left, % text will be ragged right instead of indented and justified
        % the dashed box frame:
        enhanced,arc=3mm,borderline={1pt}{-2mm}{accent,dashed},
        % the inset timespan/year title:
        fonttitle=\sbtimespanfont, attach boxed title to top center={yshift=-1mm}, boxed title style={colback=white}, title=#2,
        % draw the chrono-dot:
        overlay={\foreach \x in {#3} {
            \begin{scope}[shift={([xshift=\x, yshift=2mm]frame.north west)}]
            \path[draw=accent!50!black,fill=accent!80] (0,0) arc (0:180:10mm);
            \end{scope}
            }
        }
        ]
        % the unique identifier and positioning params for the posterbox:
        {#1}
}









