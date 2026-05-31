:
/* appearance */
static unsigned int borderpx        = 1;        /* border pixel of windows */
static unsigned int snap            = 32;       /* snap pixel */
static const unsigned int gappih    = 20;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 20;       /* vert inner gap between windows */
static const unsigned int gappoh    = 20;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 30;       /* vert outer gap between windows and screen edge */
static       int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static int showbar                  = 1;        /* 0 means no bar */
static const int showtitle          = 1;        /* 0 means no title */
static const int showtags           = 1;        /* 0 means no tags */
static const int showlayout         = 1;        /* 0 means no layout indicator */
static const int showstatus         = 1;        /* 0 means no status bar */
static const int showfloating       = 0;        /* 0 means no floating indicator */
static int topbar                   = 1;        /* 0 means bottom bar */

static char dmenufont[]             = "monospace:size=10";

static const char *fonts[] = {	"monospace:size=12"	,	"Hack Nerd Font Mono:size=15"	};



/* default colors used if xrdb is not loaded */
static char normbgcolor[]           = "#2e3440";
static char normbordercolor[]       = "#4c566a";
static char normfgcolor[]           = "#d8dee9";
static char selfgcolor[]            = "#eceff4";
static char selbordercolor[]        = "#a3be8c";
static char selbgcolor[]            = "#b48ead";

static char *colors[][3] = {
       /*               fg           bg           border   */
		[SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
		[SchemeSel]  = { selbgcolor,  selfgcolor,  selbordercolor  },
		/* for bar --> {text, background, null} */
		[SchemeStatus]  = { normfgcolor, normbgcolor,  normbgcolor  }, /* status R */
		[SchemeTagsSel]  = { normfgcolor, normbgcolor,  normbgcolor  }, /* tag L selected */
		[SchemeTagsNorm]  = { selbordercolor, normbgcolor,  normbgcolor  }, /* tag L unselected */
		[SchemeInfoSel]  = { normfgcolor, normbgcolor,  normbgcolor  }, /* info M selected */
		[SchemeInfoNorm]  = { normfgcolor, normbgcolor,  normbgcolor  }, /* info M unselected */
};



/*slock*/

static const char *user  = "nobody";
static const char *group = "nobody";

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
// static const char *tags[] = { "󰎤", "󰎧", "󰎪", "󰎭", "󰎱", "󰎳", "󰎶", "󰎹", "󰎼" };


static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	{ "St",      NULL,     NULL,           0,         0,          1,           0,        -1 },
	{ "fzfmenu", NULL,     "fzf", 	0,         1,          1,           1,        -1 }, /* xev */
	{ NULL,      NULL,     "Event Tester", 0,         0,          0,           1,        -1 }, /* xev */
	{ "wallmenu", NULL, 	NULL, 			0, 		1, 			1, 				0, 		-1 },

};

#include "vanitygaps.c"


/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 0; /* 1 will force focus on the fullscreen window */


static const Layout layouts[] = { /* alt glyphs: 󱡗 󱏋 */
	/* symbol     arrange function */
	{ "󰓒",      tile },    /* first entry is default */
	{ "󰇥",      NULL },    /* no layout function means floating behavior */
	{ "",      monocle },
	{ "󰫣",      spiral },
	{ "󰫥",      dwindle },
};


/* key definitions */
#define MODKEY Mod4Mask // windows key
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
	{ MOD, XK_j,     ACTION##stack, {.i = INC(+1) } }, \
	{ MOD, XK_k,     ACTION##stack, {.i = INC(-1) } }, \
	/*{ MOD, XK_grave, ACTION##stack, {.i = PREVSEL } }, \
	{ MOD, XK_q,     ACTION##stack, {.i = 0 } }, \
	{ MOD, XK_a,     ACTION##stack, {.i = 1 } }, \
	{ MOD, XK_z,     ACTION##stack, {.i = 2 } }, \
	{ MOD, XK_x,     ACTION##stack, {.i = -1 } }, */

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* helper for launching gtk application */
#define GTKCMD(cmd) { .v = (const char*[]){ "/usr/bin/gtk-launch", cmd, NULL } }

#define STATUSBAR "dwmblocks"
#define BROWSER "qutebrowser"

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */

static const char *dmenucmd[] = {
    "dmenu_run",
    "-m", dmenumon,
    "-fn", dmenufont,
    "-nb", "#0e0e0d",   /* wal background */
    "-nf", "#c7c7c4",   /* wal foreground */
    "-sb", "#926130",   /* ORANGE selection */
    "-sf", "#0e0e0d",
    NULL
};

static const char *screenshotcmd[] = { "sh", "-c", "screenshot", NULL };
static const char *termcmd[]  = { "st", NULL };

static const char *ledcmd[]        = { "sh", "-c", "led", NULL };
static const char *mutecmd[]       = { "sh", "-c", "amixer set Master toggle", NULL };
static const char *volupcmd[]      = { "sh", "-c", "amixer set Master 5%+", NULL };
static const char *voldowncmd[]    = { "sh", "-c", "amixer set Master 5%-", NULL };
static const char *brupcmd[]       = { "sh", "-c", "brightnessctl set +10%", NULL };
static const char *brdowncmd[]     = { "sh", "-c", "brightnessctl set 10%-", NULL };


static const Arg tagexec[] = { /* spawn application when tag is middle-clicked */
	{ .v = termcmd }, /* 1 */
	{ .v = termcmd }, /* 2 */
	{ .v = termcmd }, /* 3 */
	{ .v = termcmd }, /* 4 */
	{ .v = termcmd }, /* 5 */
	{ .v = termcmd }, /* 6 */
	{ .v = termcmd }, /* 7 */
	{ .v = termcmd }, /* 8 */
	{ .v = termcmd }, /* 9 */
    /* GTKCMD("gtkapplication") */
};

static const Key keys[] = {
    /* Core controls */
    { MODKEY,                       XK_p,          spawn,          {.v = dmenucmd } },
    { MODKEY,                       XK_Return,     spawn,          {.v = termcmd } },
    { MODKEY,                       XK_q,          killclient,     {0} },
    { MODKEY|ShiftMask,             XK_BackSpace,  quit,           {0} },
    { MODKEY|ControlMask,           XK_backslash,  xrdb,           {.v = NULL } },
    STACKKEYS(MODKEY,                              focus)

    /* Bar toggles */
    { MODKEY|ControlMask,           XK_t,          togglebartitle, {0} },
    { MODKEY|ControlMask,           XK_s,          togglebarstatus,{0} },
    { MODKEY|ControlMask,           XK_r,          togglebarlt,    {0} },
    { MODKEY|ControlMask,           XK_f,          togglebarfloat, {0} },

    /* Tag keys */
    TAGKEYS(                        XK_1,                          0)
    TAGKEYS(                        XK_2,                          1)
    TAGKEYS(                        XK_3,                          2)
    TAGKEYS(                        XK_4,                          3)
    TAGKEYS(                        XK_5,                          4)
    TAGKEYS(                        XK_6,                          5)
    TAGKEYS(                        XK_7,                          6)
    TAGKEYS(                        XK_8,                          7)
    TAGKEYS(                        XK_9,                          8)

    /* Apps */
    { MODKEY,                       XK_e,          spawn,          SHCMD("dolphin") },
    { MODKEY,                       XK_o,          spawn,          SHCMD("obsidian") },
    { MODKEY|ShiftMask,             XK_c,          spawn,          SHCMD("code") },

    /* Screenshot & LED */
    { MODKEY|ShiftMask,             XK_s,          spawn,          {.v = screenshotcmd } },
	{ MODKEY, 						XK_l, 			spawn, 			SHCMD("xset led 3") },

    /* Volume */
    { MODKEY,                       XK_F1,         spawn,          {.v = mutecmd } },
    { MODKEY,                       XK_F2,         spawn,          {.v = volupcmd } },
    { MODKEY,                       XK_F3,         spawn,          {.v = voldowncmd } },

    /* Brightness */
    { MODKEY,                       XK_F11,        spawn,          {.v = brupcmd } },
    { MODKEY,                       XK_F12,        spawn,          {.v = brdowncmd } },
		
	/* Screen Lock */
    { MODKEY,                       XK_m,          spawn,          SHCMD("slock") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask           button          function        argument */
#ifndef __OpenBSD__
	{ ClkWinTitle,          0,			Button2,	zoom,           {0} },
	{ ClkStatusText,        0,			Button1,	sigstatusbar,   {.i = 1} },
	{ ClkStatusText,        0,			Button2,	sigstatusbar,   {.i = 2} },
	{ ClkStatusText,        0,			Button3,	sigstatusbar,   {.i = 3} },
	{ ClkStatusText,        0,			Button4,	sigstatusbar,   {.i = 4} },
	{ ClkStatusText,        0,			Button5,	sigstatusbar,   {.i = 5} },
	{ ClkStatusText,		ShiftMask,	Button1,	sigstatusbar,	{.i = 6} },
#endif

	{ ClkStatusText,        ShiftMask,	Button3,	spawn,          SHCMD("st -e nvim ~/.local/src/dwmblocks/blocks.h") },
	{ ClkClientWin,			MODKEY,		Button1,	movemouse,      {0} }, /* left click */
	{ ClkClientWin,			MODKEY,		Button2,	defaultgaps,    {0} }, /* middle click */
	{ ClkClientWin,			MODKEY,		Button3,	resizemouse,    {0} }, /* right click */
	{ ClkClientWin,			MODKEY,		Button4,	incrgaps,       {.i = +1} }, /* scroll up */
	{ ClkClientWin,			MODKEY,		Button5,	incrgaps,       {.i = -1} }, /* scroll down */
	{ ClkTagBar,			0,			Button1,	view,           {0} },
	{ ClkTagBar,			0,			Button3,	toggleview,     {0} },
	{ ClkTagBar,			MODKEY,		Button1,	tag,            {0} },
	{ ClkTagBar,			MODKEY,		Button3,	toggletag,      {0} },
	{ ClkRootWin,			0,			Button2,	togglebar,      {0} }, /* hide bar */
};
