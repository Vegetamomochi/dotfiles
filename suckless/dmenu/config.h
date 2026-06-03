/* See LICENSE file for copyright and license details. */
static int topbar = 1;
static int centered = 1;
static int min_width = 500;
static const float menu_height_ratio = 4.0f;
static char *fonts[] = {
        "monospace:size=11", "Hack Nerd Font Mono:size=19"
};
static const char *prompt = NULL;
static unsigned int lines = 0;
static const char worddelimiters[] = " ";

/* ===== PYWAL COLORS ===== */
#include <X11/Xresource.h>
static char *colors[SchemeLast][2] = {
        [SchemeNorm] = { "#bbbbbb", "#222222" },
        [SchemeSel]  = { "#eeeeee", "#005577" },
        [SchemeOut]  = { "#000000", "#00ffff" },
};
